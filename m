From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Enable ip block bit mask print out info by
 default
Date: Fri, 2 Feb 2018 08:47:04 +0100
Message-ID: <50ae834e-a6c3-83b3-1a93-144f9fac1d64@gmail.com>
References: <1517521793-5959-1-git-send-email-Shaoyun.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1517521793-5959-1-git-send-email-Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDEuMDIuMjAxOCB1bSAyMjo0OSBzY2hyaWViIFNoYW95dW4gTGl1Ogo+IENoYW5nZS1JZDog
STlmNzk0YjlhNGNiYjNjYzkyOWRkYzFlNGY0M2Q5NTA5Y2U4NmQ2MzgKPiBTaWduZWQtb2ZmLWJ5
OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gaW5kZXggMGYwYjNlYS4uNGIxYzM3YSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMTA2MSw3
ICsxMDYxLDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRkKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCWlmICghaXBfYmxvY2tfdmVyc2lvbikKPiAgIAkJcmV0dXJuIC1F
SU5WQUw7Cj4gICAKPiAtCURSTV9ERUJVRygiYWRkIGlwIGJsb2NrIG51bWJlciAlZCA8JXM+XG4i
LCBhZGV2LT5udW1faXBfYmxvY2tzLAo+ICsJRFJNX0lORk8oImFkZCBpcCBibG9jayBudW1iZXIg
JWQgPCVzPlxuIiwgYWRldi0+bnVtX2lwX2Jsb2NrcywKPiAgIAkJICBpcF9ibG9ja192ZXJzaW9u
LT5mdW5jcy0+bmFtZSk7Cj4gICAKPiAgIAlhZGV2LT5pcF9ibG9ja3NbYWRldi0+bnVtX2lwX2Js
b2NrcysrXS52ZXJzaW9uID0gaXBfYmxvY2tfdmVyc2lvbjsKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
