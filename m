From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove duplicated codes
Date: Wed, 27 Jun 2018 14:37:25 +0800
Message-ID: <5B3330A5.9090905@amd.com>
References: <1530079813-4012-1-git-send-email-Flora.Cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1530079813-4012-1-git-send-email-Flora.Cui-5C7GfCeVMHo@public.gmane.org>
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
To: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMjcvMjAxOCAwMjoxMCBQTSwgRmxvcmEgQ3VpIHdyb3RlOgo+IENoYW5nZS1JZDogSWMw
ZGJkNjkzYmFjMDkzZTU0ZWI5NWI1ZTU0N2M4OWI2NGE1NzQzYjgKPiBTaWduZWQtb2ZmLWJ5OiBG
bG9yYSBDdWkgPEZsb3JhLkN1aUBhbWQuY29tPgoKR29vZCBjYXRjaC4KUmV2aWV3ZWQtYnk6IEp1
bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMgfCA1IC0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwg
NSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWRzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMK
PiBpbmRleCBhMWM3OGY5Li4zYTA3MmE3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9pZHMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9pZHMuYwo+IEBAIC01NzgsMTEgKzU3OCw2IEBAIHZvaWQgYW1kZ3B1X3ZtaWRfbWdy
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCQlsaXN0X2FkZF90YWlsKCZp
ZF9tZ3ItPmlkc1tqXS5saXN0LCAmaWRfbWdyLT5pZHNfbHJ1KTsKPiAgIAkJfQo+ICAgCX0KPiAt
Cj4gLQlhZGV2LT52bV9tYW5hZ2VyLmZlbmNlX2NvbnRleHQgPQo+IC0JCWRtYV9mZW5jZV9jb250
ZXh0X2FsbG9jKEFNREdQVV9NQVhfUklOR1MpOwo+IC0JZm9yIChpID0gMDsgaSA8IEFNREdQVV9N
QVhfUklOR1M7ICsraSkKPiAtCQlhZGV2LT52bV9tYW5hZ2VyLnNlcW5vW2ldID0gMDsKPiAgIH0K
Pgo+ICAgLyoqCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
