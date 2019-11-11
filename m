From: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
Subject: [PATCH] drm/amd/display: Fix unsigned variable compared to less than
 zero
Date: Mon, 11 Nov 2019 11:25:43 -0600
Message-ID: <20191111172543.GA31748@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>, Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Q3VycmVubHksIHRoZSBlcnJvciBjaGVjayBiZWxvdyBvbiB2YXJpYWJsZSAqdmNwaV9zbG90cyog
aXMgYWx3YXlzCmZhbHNlIGJlY2F1c2UgaXQgaXMgYSB1aW50NjRfdCB0eXBlIHZhcmlhYmxlLCBo
ZW5jZSwgdGhlIHZhbHVlcwp0aGlzIHZhcmlhYmxlIGNhbiBob2xkIGFyZSBuZXZlciBsZXNzIHRo
YW4gemVybzoKCmRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmM6CjQ4NzAgICAgICAgICBpZiAoZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ZS0+dmNwaV9zbG90cyA8
IDApIHsKNDg3MSAgICAgICAgICAgICAgICAgRFJNX0RFQlVHX0FUT01JQygiZmFpbGVkIGZpbmRp
bmcgdmNwaSBzbG90czogJWRcbiIsIChpbnQpZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ICAgICBlLT52
Y3BpX3Nsb3RzKTsKNDg3MiAgICAgICAgICAgICAgICAgcmV0dXJuIGRtX25ld19jb25uZWN0b3Jf
c3RhdGUtPnZjcGlfc2xvdHM7CjQ4NzMgICAgICAgICB9CgpGaXggdGhpcyBieSBtYWtpbmcgKnZj
cGlfc2xvdHMqIG9mIGludCB0eXBlLgoKQWRkcmVzc2VzLUNvdmVyaXR5OiAxNDg3ODM4ICgiVW5z
aWduZWQgY29tcGFyZWQgYWdhaW5zdCAwIikKRml4ZXM6IGI0YzU3OGYwODM3OCAoImRybS9hbWQv
ZGlzcGxheTogQWRkIE1TVCBhdG9taWMgcm91dGluZXMiKQpTaWduZWQtb2ZmLWJ5OiBHdXN0YXZv
IEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmggfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaAppbmRleCA2ZGIwN2U5ZTMzYWIuLmE4
ZmM5MGE5MjdkNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5oCkBAIC00MDMsNyArNDAzLDcgQEAgc3RydWN0IGRtX2Nvbm5lY3Rvcl9z
dGF0ZSB7CiAJYm9vbCB1bmRlcnNjYW5fZW5hYmxlOwogCWJvb2wgZnJlZXN5bmNfY2FwYWJsZTsK
IAl1aW50OF90IGFibV9sZXZlbDsKLQl1aW50NjRfdCB2Y3BpX3Nsb3RzOworCWludCB2Y3BpX3Ns
b3RzOwogCXVpbnQ2NF90IHBibjsKIH07CiAKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
