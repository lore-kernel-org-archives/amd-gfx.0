From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm v2] amdgpu: add REPLACE and CLEAR checking for VA
 op (v2)
Date: Wed, 22 Mar 2017 07:31:01 +0100
Message-ID: <6e194b66-d14d-5b43-cd7b-2e5534738c16@gmail.com>
References: <1490152440-3721-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490152440-3721-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, nicolai.haehnle-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjIuMDMuMjAxNyAwNDoxNCwgSnVud2VpIFpoYW5nIHdyb3RlOgo+IHYyOiBmaXggaW5kZW50
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+CgpS
ZXZpZXdlZC1ieTogTmljb2xhaSBIw6RobmxlIDxuaWNvbGFpLmhhZWhubGVAYW1kLmNvbT4KCgo+
IC0tLQo+ICBhbWRncHUvYW1kZ3B1X2JvLmMgfCA0ICsrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRn
cHVfYm8uYyBiL2FtZGdwdS9hbWRncHVfYm8uYwo+IGluZGV4IDcxY2Q2NjYuLjg1MGZlOGMgMTAw
NjQ0Cj4gLS0tIGEvYW1kZ3B1L2FtZGdwdV9iby5jCj4gKysrIGIvYW1kZ3B1L2FtZGdwdV9iby5j
Cj4gQEAgLTk1Miw3ICs5NTIsOSBAQCBpbnQgYW1kZ3B1X2JvX3ZhX29wX3JhdyhhbWRncHVfZGV2
aWNlX2hhbmRsZSBkZXYsCj4gIAlzdHJ1Y3QgZHJtX2FtZGdwdV9nZW1fdmEgdmE7Cj4gIAlpbnQg
cjsKPgo+IC0JaWYgKG9wcyAhPSBBTURHUFVfVkFfT1BfTUFQICYmIG9wcyAhPSBBTURHUFVfVkFf
T1BfVU5NQVApCj4gKwlpZiAob3BzICE9IEFNREdQVV9WQV9PUF9NQVAgJiYgb3BzICE9IEFNREdQ
VV9WQV9PUF9VTk1BUCAmJgo+ICsJICAgIG9wcyAhPSBBTURHUFVfVkFfT1BfUkVQTEFDRSAmJiBv
cHMgIT0gQU1ER1BVX1ZBX09QX0NMRUFSKQo+ICsKPiAgCQlyZXR1cm4gLUVJTlZBTDsKPgo+ICAJ
bWVtc2V0KCZ2YSwgMCwgc2l6ZW9mKHZhKSk7Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
