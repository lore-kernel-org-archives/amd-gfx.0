From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu: add AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
 flag v3
Date: Tue, 11 Oct 2016 11:35:55 +0200
Message-ID: <0e4a6c46-5294-091e-ae16-a21db93b1638@amd.com>
References: <1474969797-1882-1-git-send-email-deathsimple@vodafone.de>
 <1474969797-1882-2-git-send-email-deathsimple@vodafone.de>
 <627af621-8fb2-ba41-c87e-96bb12e594d8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <627af621-8fb2-ba41-c87e-96bb12e594d8-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDcuMTAuMjAxNiB1bSAyMzoxOSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IE9uIDE2LTA5
LTI3IDA1OjQ5IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3MuYwo+PiBAQCAtMTE5NSw2ICsxMTk1LDE1IEBAIGludCBhbWRncHVf
Y3Nfc3lzdm1fYWNjZXNzX3JlcXVpcmVkKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwYXJzZXIp
Cj4+ICAgCQlyID0gYW1kZ3B1X3R0bV9iaW5kKCZiby0+dGJvLCAmYm8tPnRiby5tZW0pOwo+PiAg
IAkJaWYgKHVubGlrZWx5KHIpKQo+PiAgIAkJCXJldHVybiByOwo+PiArCj4+ICsJCWlmIChiby0+
ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMpCj4+ICsJCQljb250aW51
ZTsKPiBTaG91bGQgeW91IGFsc28gY29udGludWUgaWYgdGhlIEJPIGlzIG5vdCBWUkFNPwoKTm8s
IHRoZSBwbGFjZW1lbnQgb2YgdGhlIEJPIGF0IHRoaXMgcG9pbnQgaXNuJ3QgZmluYWwuIEZvciBv
bGRlciBVVkQgCmJsb2NrcyB0aGlzIGNhbiBzdGlsbCBiZSBzaHVmZmxlZCBhcm91bmQgdG8gZnVs
ZmlsbCB0aGUgcGxhY2VtZW50IApyZXN0cmljdGlvbnMuCgpTbyB0aGUgQk8gY291bGQgc3RpbGwg
bW92ZSBpbnRvIFZSQU0gZXZlbiBhZnRlciB0aGlzLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+
IFJlZ2FyZHMsCj4gICAgRmVsaXgKPgo+PiArCj4+ICsJCWJvLT5mbGFncyB8PSBBTURHUFVfR0VN
X0NSRUFURV9WUkFNX0NPTlRJR1VPVVM7Cj4+ICsJCWFtZGdwdV90dG1fcGxhY2VtZW50X2Zyb21f
ZG9tYWluKGJvLCBiby0+YWxsb3dlZF9kb21haW5zKTsKPj4gKwkJciA9IHR0bV9ib192YWxpZGF0
ZSgmYm8tPnRibywgJmJvLT5wbGFjZW1lbnQsIGZhbHNlLCBmYWxzZSk7Cj4+ICsJCWlmICh1bmxp
a2VseShyKSkKPj4gKwkJCXJldHVybiByOwo+PiAgIAl9Cj4+ICAgCj4+ICAgCXJldHVybiAwOwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
