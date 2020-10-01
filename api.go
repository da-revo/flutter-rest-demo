package main

import (
	"fmt"
	"net/http"
	"path"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
)

func main() {

	router := PrimaryRouter()

	http.ListenAndServe(":3000", router)
}

// PrimaryRouter is used to set the API routes
func PrimaryRouter() *chi.Mux {

	router := chi.NewRouter()

	router.Use(
		middleware.RedirectSlashes,
		middleware.RealIP,
		middleware.RequestID,
		middleware.Logger,
		middleware.Recoverer,
	)

	router.Get("/", Index)

	router.Get("/all", AllNews)

	router.Get("/item/{id:[0-9]*}", NewsItem)

	return router
}

// Index displays welcome
func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "you have reached the FAKE NEWS server !\n")
}

// AllNews displays brief info of all news
func AllNews(w http.ResponseWriter, r *http.Request) {
	fp := path.Join("json4u", "all.json")
	w.Header().Set("Cache-Control", "no-cache")
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	http.ServeFile(w, r, fp)
}

// NewsItem displays brief info of all news
func NewsItem(w http.ResponseWriter, r *http.Request) {
	itemID := chi.URLParam(r, "id")

	fp := path.Join("json4u", itemID+".json")
	w.Header().Set("Cache-Control", "no-cache")
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	http.ServeFile(w, r, fp)
}
