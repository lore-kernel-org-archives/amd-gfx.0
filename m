From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH libdrm v2] amdgpu: add REPLACE and CLEAR checking for VA
 op (v2)
Date: Wed, 22 Mar 2017 10:34:56 +0100
Message-ID: <f90ecac5-884f-8db0-7321-94db910e3c51@vodafone.de>
References: <1490152440-3721-1-git-send-email-Jerry.Zhang@amd.com>
 <6e194b66-d14d-5b43-cd7b-2e5534738c16@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6e194b66-d14d-5b43-cd7b-2e5534738c16-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, nicolai.haehnle-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjIuMDMuMjAxNyB1bSAwNzozMSBzY2hyaWViIE5pY29sYWkgSMOkaG5sZToKPiBPbiAyMi4w
My4yMDE3IDA0OjE0LCBKdW53ZWkgWmhhbmcgd3JvdGU6Cj4+IHYyOiBmaXggaW5kZW50Cj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KPgo+IFJl
dmlld2VkLWJ5OiBOaWNvbGFpIEjDpGhubGUgPG5pY29sYWkuaGFlaG5sZUBhbWQuY29tPgoKUmV2
aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4K
Pgo+PiAtLS0KPj4gIGFtZGdwdS9hbWRncHVfYm8uYyB8IDQgKysrLQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYW1k
Z3B1L2FtZGdwdV9iby5jIGIvYW1kZ3B1L2FtZGdwdV9iby5jCj4+IGluZGV4IDcxY2Q2NjYuLjg1
MGZlOGMgMTAwNjQ0Cj4+IC0tLSBhL2FtZGdwdS9hbWRncHVfYm8uYwo+PiArKysgYi9hbWRncHUv
YW1kZ3B1X2JvLmMKPj4gQEAgLTk1Miw3ICs5NTIsOSBAQCBpbnQgYW1kZ3B1X2JvX3ZhX29wX3Jh
dyhhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYsCj4+ICAgICAgc3RydWN0IGRybV9hbWRncHVfZ2Vt
X3ZhIHZhOwo+PiAgICAgIGludCByOwo+Pgo+PiAtICAgIGlmIChvcHMgIT0gQU1ER1BVX1ZBX09Q
X01BUCAmJiBvcHMgIT0gQU1ER1BVX1ZBX09QX1VOTUFQKQo+PiArICAgIGlmIChvcHMgIT0gQU1E
R1BVX1ZBX09QX01BUCAmJiBvcHMgIT0gQU1ER1BVX1ZBX09QX1VOTUFQICYmCj4+ICsgICAgICAg
IG9wcyAhPSBBTURHUFVfVkFfT1BfUkVQTEFDRSAmJiBvcHMgIT0gQU1ER1BVX1ZBX09QX0NMRUFS
KQo+PiArCj4+ICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pgo+PiAgICAgIG1lbXNldCgmdmEs
IDAsIHNpemVvZih2YSkpOwo+Pgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
