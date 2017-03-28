From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 13/15] drm/amdgpu: adapt vm size for multi vmpt
Date: Tue, 28 Mar 2017 11:19:50 +0800
Message-ID: <58D9D656.7090107@amd.com>
References: <1490594005-14553-1-git-send-email-David1.Zhou@amd.com>
 <1490594005-14553-14-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490594005-14553-14-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org

T24gMDMvMjcvMjAxNyAwMTo1MyBQTSwgQ2h1bm1pbmcgWmhvdSB3cm90ZToKPiBDaGFuZ2UtSWQ6
IEkxN2I0MGFlYzY4NDA0ZTQ2OTYxYTlmZGEyMmRmYWRkMWFlOWQ2ZjJjCj4gU2lnbmVkLW9mZi1i
eTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgfCA2ICsrKysrKwo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5j
Cj4gaW5kZXggNjYyNWEyZi4uNjEzYzhmNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3Y5XzAuYwo+IEBAIC01MDgsNiArNTA4LDEyIEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfdm1f
aW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAkgKiBhbWRrZmQgd2lsbCB1c2Ug
Vk1JRHMgOC0xNQo+ICAgCSAqLwo+ICAgCWFkZXYtPnZtX21hbmFnZXIubnVtX2lkcyA9IEFNREdQ
VV9OVU1fT0ZfVk1JRFM7Cj4gKwkvKiBCZWNhdXNlIG9mIGZvdXIgbGV2ZWwgVk1QVHMsIHZtIHNp
emUgYXQgbGVhc3QgaXMgMjU2R0IuCj4gKwkyNTZUQiBpcyBPSyBhcyB3ZWxsICovCgpJZiBlYWNo
IFBUIHNpemUgaXMgOSwgYW5kIGNvbnRhaW5zIDMgbGV2ZWxzIFBUICsgMSBQRC4KOSAqIDMgKyAx
MihwYWdlIHNpemUpICsgMShhdCBsZWFzdCAxIGJpdCBmb3IgUEQpID0gNDAgYml0cyBoZXJlLgoK
VGhlbiBpdCBsb29rcyAxVCBpcyBtaW5pbXVtIHNpemUuClBsZWFzZSBjb25maXJtIGl0LgoKSmVy
cnkuCgo+ICsJaWYgKGFtZGdwdV92bV9zaXplIDwgMjU2KSB7Cj4gKwkJRFJNX1dBUk4oInZtIHNp
emUgYXQgbGVhc3QgaXMgMjU2R0IhXG4iKTsKPiArCQlhbWRncHVfdm1fc2l6ZSA9IDI1NjsKPiAr
CX0KPiAgIAlhZGV2LT52bV9tYW5hZ2VyLm51bV9sZXZlbCA9IDE7Cj4gICAJYW1kZ3B1X3ZtX21h
bmFnZXJfaW5pdChhZGV2KTsKPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
