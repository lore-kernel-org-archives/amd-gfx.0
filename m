From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove redundant memset
Date: Thu, 30 Aug 2018 09:39:46 +0800
Message-ID: <5B874AE2.4080302@amd.com>
References: <1535555864-2521-1-git-send-email-Philip.Yang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1535555864-2521-1-git-send-email-Philip.Yang-5C7GfCeVMHo@public.gmane.org>
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
To: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDgvMjkvMjAxOCAxMToxNyBQTSwgUGhpbGlwIFlhbmcgd3JvdGU6Cj4ga3ZtYWxsb2NfYXJy
YXkgdXNlcyBfX0dGUF9aRVJPIGZsYWcgZW5zdXJlcyB0aGF0IHRoZSByZXR1cm5lZCBhZGRyZXNz
Cj4gaXMgemVyb2VkIGFscmVhZHksIG1lbXNldCBpdCB0byB6ZXJvIGFnYWluIGFmdGVyd2FyZHMg
aXMgdW5uZWNlc3NhcnksCj4gYW5kIGluIHRoaXMgY2FzZSBidWdneSBiZWNhdXNlIHdlIG9ubHkg
Y2xlYXIgdGhlIGZpcnN0IGVudHJ5Lgo+Cj4gQ2hhbmdlLUlkOiBJZjk0YTU5ZDNjYmYyNjkwZGQy
YTFlMmFkZDcxYmMzOTNkZjZhOTY4Ngo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGls
aXAuWWFuZ0BhbWQuY29tPgoKR29vZCBjYXRjaC4KClJldmlld2VkLWJ5OiBKdW53ZWkgWmhhbmcg
PEplcnJ5LlpoYW5nQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgfCAxIC0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IDE1M2M5YmUuLjMz
ZDljZTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC01
NDAsNyArNTQwLDYgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfbGV2ZWxzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQkJCQkJICAgR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8p
Owo+ICAgCQlpZiAoIXBhcmVudC0+ZW50cmllcykKPiAgIAkJCXJldHVybiAtRU5PTUVNOwo+IC0J
CW1lbXNldChwYXJlbnQtPmVudHJpZXMsIDAgLCBzaXplb2Yoc3RydWN0IGFtZGdwdV92bV9wdCkp
Owo+ICAgCX0KPgo+ICAgCWZyb20gPSBzYWRkciA+PiBzaGlmdDsKPgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
