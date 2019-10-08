From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Enable gfx cache probing on HDP write for
 arcturus
Date: Tue, 8 Oct 2019 10:00:02 +0200
Message-ID: <380de858-270b-84b2-df1c-4f24d59f6fb3@gmail.com>
References: <1570480448-29861-1-git-send-email-Oak.Zeng@amd.com>
 <1570480448-29861-2-git-send-email-Oak.Zeng@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1570480448-29861-2-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

QW0gMDcuMTAuMTkgdW0gMjI6MzQgc2NocmllYiBaZW5nLCBPYWs6Cj4gVGhpcyBhbGxvd3MgZ2Z4
IGNhY2hlIHRvIGJlIHByb2JlZCBhbmQgaW52YWxpZGF0ZWQgKGZvciBub25lLWRpcnR5IGNhY2hl
IGxpbmVzKQo+IG9uIGEgSERQIHdyaXRlIChmcm9tIGVpdGhlciBhbm90aGVyIEdQVSBvciBDUFUp
LiBUaGlzIHNob3VsZCB3b3JrIG9ubHkgZm9yIHRoZQo+IG1lbW9yeSBtYXBwZWQgYXMgUlcgbWVt
b3J5IHR5cGUgbmV3bHkgYWRkZWQgZm9yIGFyY3R1cnVzLCB0byBhY2hpZXZlIHNvbWUgY2FjaGUK
PiBjb2hlcmVuY2UgYi90IG11bHRpcGxlIG1lbW9yeSBjbGllbnRzLgo+Cj4gQ2hhbmdlLUlkOiBJ
NWM5YTZhMjVkODhjZDc1YzcxYzg4ODIyMTIzZTBkNGMwNjdhYTNmOAo+IFNpZ25lZC1vZmYtYnk6
IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jIHwgMyArKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IGluZGV4IGM3ZTA3
ZjEuLjZlNDVlYmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBA
QCAtMTE5Miw2ICsxMTkyLDkgQEAgc3RhdGljIGludCBnbWNfdjlfMF9od19pbml0KHZvaWQgKmhh
bmRsZSkKPiAgIAkJLyogVE9ETyBmb3IgcmVub2lyICovCj4gICAJCW1taHViX3YxXzBfdXBkYXRl
X3Bvd2VyX2dhdGluZyhhZGV2LCB0cnVlKTsKPiAgIAkJYnJlYWs7Cj4gKwljYXNlIENISVBfQVJD
VFVSVVM6Cj4gKwkJV1JFRzMyX0ZJRUxEMTUoSERQLCAwLCBIRFBfTU1IVUJfQ05UTCwgSERQX01N
SFVCX0dDQywgMSk7Cj4gKwkJYnJlYWs7Cj4gICAJZGVmYXVsdDoKPiAgIAkJYnJlYWs7Cj4gICAJ
fQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
