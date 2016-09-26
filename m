From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: implement raster configuration
Date: Mon, 26 Sep 2016 22:38:59 +0200
Message-ID: <CAAxE2A7nSCd-_ViLiJ5RZfTC54DNoYCKL2Ny=WgLSDVCEcdVOQ@mail.gmail.com>
References: <1474166210-21736-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474166210-21736-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

VGhlIHNlcmllcyBpcyBtaXNzaW5nIGEgRFJNIHZlcnNpb24gYnVtcCwgc28gTWVzYSBjYW4ndCBy
ZWFsbHkgdXNlIGl0CmV2ZW4gaWYgaXQgd2FudGVkLgoKTWFyZWsKCk9uIFN1biwgU2VwIDE4LCAy
MDE2IGF0IDQ6MzYgQU0sIEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+IHdyb3RlOgo+IEhp
IGFsbCwKPgo+IFRoaXMgcGF0Y2ggc2V0IGlzIHRvIGludHJvZHVjZSB0aGUgcmFzdGVyIGNvbmZp
Z3VyYXRpb24gZm9yIGFsbCBnZngKPiBnZW5lcmF0aW9ucy4KPgo+IFRoYW5rcywKPiBSdWkKPgo+
IEh1YW5nIFJ1aSAoMyk6Cj4gICBkcm0vYW1kZ3B1OiBpbXBsZW1lbnQgcmFzdGVyIGNvbmZpZ3Vy
YXRpb24gZm9yIGdmeCB2Ngo+ICAgZHJtL2FtZGdwdTogaW1wbGVtZW50IHJhc3RlciBjb25maWd1
cmF0aW9uIGZvciBnZnggdjcKPiAgIGRybS9hbWRncHU6IGltcGxlbWVudCByYXN0ZXIgY29uZmln
dXJhdGlvbiBmb3IgZ2Z4IHY4Cj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrZC5o
ICAgICAgICAgICAgIHwgIDM2ICsrKysrKwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjZfMC5jICAgICAgICAgfCAxMzMgKysrKysrKysrKysrKysrKysrKy0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYyAgICAgICAgIHwgMTYwICsrKysrKysrKysrKysr
KysrKysrKysrLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jICAgICAg
ICAgfCAxNjggKysrKysrKysrKysrKysrKysrKysrKysrKy0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmlkLmggICAgICAgICAgICAgIHwgIDM3ICsrKysrKwo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvc2kvc2lkLmggfCAgMzUgKysrKysrCj4gIDYgZmlsZXMg
Y2hhbmdlZCwgNTY2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiAtLQo+IDIuNy40
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFt
ZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
