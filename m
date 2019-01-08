From: Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: Fix suspend/resume issues with MST
Date: Tue, 08 Jan 2019 16:20:33 -0500
Message-ID: <2188308963eac8fdfe7c3c8015d267e4752cfe50.camel@redhat.com>
References: <20190108211133.32564-1-lyude@redhat.com>
 <CADnq5_N=wu0C+ZknUqXhodOye3i-ySGVVn9Mrb4_6W1jRPp_EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_N=wu0C+ZknUqXhodOye3i-ySGVVn9Mrb4_6W1jRPp_EA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mikita Lipski <mikita.lipski@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, David Francis <david.francis@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Shirish S <shirish.s@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Leo Li <sunpeng.li@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, Tony Cheng <tony.cheng@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Anthony Koo <anthony.koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCAyMDE5LTAxLTA4IGF0IDE2OjE3IC0wNTAwLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4g
T24gVHVlLCBKYW4gOCwgMjAxOSBhdCA0OjExIFBNIEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gRml4IHRoZSBzdXNwZW5kL2lzc3VlcyB0aGF0IEplcnJ5IFp1byBmb3Vu
ZCBpbiBhbWRncHUsIGFuZCBhZGQgc29tZQo+ID4gY29tcGlsZXIgd2FybmluZ3MgZm9yIGRyaXZl
cnMgaWdub3JpbmcgdGhlIHJldHVybiBjb2RlIG9mCj4gPiBkcm1fZHBfbXN0X3RvcG9sb2d5X21n
cl9yZXN1bWUoKSB0byBoZWxwIGVuc3VyZSB3ZSBkb24ndCBuZWVkIHRvIGZpeAo+ID4gdGhpcyBh
Z2FpbiBpbiB0aGUgZnV0dXJlIGZvciBzb21lb25lIGVsc2UncyBkcml2ZXIuCj4gPiAKPiA+IENj
OiBKZXJyeSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPgo+ID4gCj4gPiBMeXVkZSBQYXVsICgzKToK
PiA+ICAgZHJtL2FtZGdwdTogRG9uJ3QgaWdub3JlIHJjIGZyb20gZHJtX2RwX21zdF90b3BvbG9n
eV9tZ3JfcmVzdW1lKCkKPiA+ICAgZHJtL2FtZGdwdTogRG9uJ3QgZmFpbCByZXN1bWUgcHJvY2Vz
cyBpZiByZXN1bWluZyBhdG9taWMgc3RhdGUgZmFpbHMKPiA+ICAgZHJtL2RwX21zdDogQWRkIF9f
bXVzdF9jaGVjayB0byBkcm1fZHBfbXN0X3RvcG9sb2d5X21ncl9yZXN1bWUoKQo+IAo+IEkgY2Fu
IHRha2UgdGhlc2UgdGhyb3VnaCB0aGUgYW1kZ3B1IHRyZWUgb3IgeW91IGNhbiBjb21taXQgdGhl
bSB0bwo+IGRybS1taXNjIChhc3N1bWluZyB5b3UgaGF2ZSBjb21taXQgcmlnaHRzKS4gIEVpdGhl
ciB3YXkgd29ya3MgZm9yIG1lLgpJIGRvbid0IG1pbmQganVzdCBwdXNoaW5nIHRoZXNlIHRvIGRy
bS1taXNjIHNpbmNlIHlvdSBzZWVtIE9LIHdpdGggaXQuIFRoYW5rcyEKPiAKPiBUaGFua3MsCj4g
Cj4gQWxleAo+IAo+ID4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyB8IDM3ICsrKysrKysrKysrKystLS0tLS0KPiA+ICBpbmNsdWRlL2RybS9kcm1fZHBfbXN0
X2hlbHBlci5oICAgICAgICAgICAgICAgfCAgMyArLQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjcg
aW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4gPiAKPiA+IC0tCj4gPiAyLjIwLjEKPiA+
IAo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
ID4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Ci0tIApDaGVlcnMsCglMeXVkZSBQYXVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
