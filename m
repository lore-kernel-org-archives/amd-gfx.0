From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix null pointer for bo unmap trace function
Date: Fri, 11 May 2018 14:17:37 +0200
Message-ID: <0cf7ad87-df3b-cccf-9638-756ff263983a@gmail.com>
References: <1526031003-11476-1-git-send-email-Jerry.Zhang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1526031003-11476-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org

QW0gMTEuMDUuMjAxOCB1bSAxMTozMCBzY2hyaWViIEp1bndlaSBaaGFuZzoKPiBTaWduZWQtb2Zm
LWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIHwgMiArLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+IGluZGV4IDUzMjI2M2EuLmU5NmUyNmQgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+IEBAIC0yNzUsNyAr
Mjc1LDcgQEAKPiAgIAkJCSAgICAgKSwKPiAgIAo+ICAgCSAgICBUUF9mYXN0X2Fzc2lnbigKPiAt
CQkJICAgX19lbnRyeS0+Ym8gPSBib192YS0+YmFzZS5ibzsKPiArCQkJICAgX19lbnRyeS0+Ym8g
PSBib192YSA/IGJvX3ZhLT5iYXNlLmJvIDogTlVMTDsKPiAgIAkJCSAgIF9fZW50cnktPnN0YXJ0
ID0gbWFwcGluZy0+c3RhcnQ7Cj4gICAJCQkgICBfX2VudHJ5LT5sYXN0ID0gbWFwcGluZy0+bGFz
dDsKPiAgIAkJCSAgIF9fZW50cnktPm9mZnNldCA9IG1hcHBpbmctPm9mZnNldDsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
