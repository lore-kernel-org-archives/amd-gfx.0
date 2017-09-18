From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/18] drm/amdgpu:no kiq in IH
Date: Mon, 18 Sep 2017 11:05:14 +0200
Message-ID: <6402fd20-588e-8396-3500-15792881f7ee@gmail.com>
References: <1505715122-23904-1-git-send-email-Monk.Liu@amd.com>
 <1505715122-23904-3-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505715122-23904-3-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTguMDkuMjAxNyB1bSAwODoxMSBzY2hyaWViIE1vbmsgTGl1Ogo+IENoYW5nZS1JZDogSTRk
ZWI2NTY3NWQyNTMxMjM2YjJmNGUyYmM2ZjAxNWM2NTc1NDY0NjQKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmVnYTEwX2loLmMgfCA0ICsrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdh
MTBfaWguYwo+IGluZGV4IDY3NjEwZjcuLmMyOTFlMzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92ZWdhMTBfaWguYwo+IEBAIC0yMTksOSArMjE5LDkgQEAgc3RhdGljIHUzMiB2ZWdh
MTBfaWhfZ2V0X3dwdHIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCQl3cHRyLCBh
ZGV2LT5pcnEuaWgucnB0ciwgdG1wKTsKPiAgIAkJYWRldi0+aXJxLmloLnJwdHIgPSB0bXA7Cj4g
ICAKPiAtCQl0bXAgPSBSUkVHMzIoU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1tSUhfUkJf
Q05UTCkpOwo+ICsJCXRtcCA9IFJSRUczMl9OT19LSVEoU09DMTVfUkVHX09GRlNFVChPU1NTWVMs
IDAsIG1tSUhfUkJfQ05UTCkpOwo+ICAgCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhfUkJf
Q05UTCwgV1BUUl9PVkVSRkxPV19DTEVBUiwgMSk7Cj4gLQkJV1JFRzMyKFNPQzE1X1JFR19PRkZT
RVQoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVEwpLCB0bXApOwo+ICsJCVdSRUczMl9OT19LSVEoU09D
MTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTCksIHRtcCk7Cj4gICAJfQo+ICAg
CXJldHVybiAod3B0ciAmIGFkZXYtPmlycS5paC5wdHJfbWFzayk7Cj4gICB9CgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
