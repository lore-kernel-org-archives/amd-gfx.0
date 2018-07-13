From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Make sure IB tests flushed after IP resume
Date: Fri, 13 Jul 2018 18:21:15 +0200
Message-ID: <e37764da-6e0d-365a-1377-6877c0501d6e@gmail.com>
References: <20180713154118.5527-1-leo.liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180713154118.5527-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
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
To: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTMuMDcuMjAxOCB1bSAxNzo0MSBzY2hyaWViIExlbyBMaXU6Cj4gRml4ZXM6IDJjNzczZGUy
IChkcm0vYW1kZ3B1OiBkZWZlciB0ZXN0IElCcyBvbiB0aGUgcmluZ3MgYXQgYm9vdCAoVjMpKQo+
Cj4gU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIG5vdywgYnV0
IHdlIAptaWdodCB3YW50IHRvIG1vdmUgdGhhdCBldmVuIGZ1cnRoZXIgZG93bi4KCkNocmlzdGlh
bi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
fCAzICsrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4IGFlYjFiMjc5YTRjYy4u
YWUyNzc2NDI4YWRkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwo+IEBAIC0yNzcxLDYgKzI3NzEsOSBAQCBpbnQgYW1kZ3B1X2RldmljZV9yZXN1bWUo
c3RydWN0IGRybV9kZXZpY2UgKmRldiwgYm9vbCByZXN1bWUsIGJvb2wgZmJjb24pCj4gICAJaWYg
KHIpCj4gICAJCXJldHVybiByOwo+ICAgCj4gKwkvKiBNYWtlIHN1cmUgSUIgdGVzdHMgZmx1c2hl
ZCAqLwo+ICsJZmx1c2hfZGVsYXllZF93b3JrKCZhZGV2LT5sYXRlX2luaXRfd29yayk7Cj4gKwo+
ICAgCS8qIGJsYXQgdGhlIG1vZGUgYmFjayBpbiAqLwo+ICAgCWlmIChmYmNvbikgewo+ICAgCQlp
ZiAoIWFtZGdwdV9kZXZpY2VfaGFzX2RjX3N1cHBvcnQoYWRldikpIHsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
