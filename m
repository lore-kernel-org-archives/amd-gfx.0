From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: fix a signedness bugs
Date: Tue, 16 May 2017 17:42:54 +0300
Message-ID: <20170516144253.vvu3i6mbx3rv5uki@mwanda>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, Ken Wang <Qingqing.wang-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

U21hdGNoIGNvbXBsYWlucyBhYm91dCBhIHNpZ25lZG5lc3MgYnVnIGhlcmU6CgoJdmVnYTEwX2h3
bWdyLmM6NDIwMiB2ZWdhMTBfZm9yY2VfY2xvY2tfbGV2ZWwoKQoJd2FybjogYWx3YXlzIHRydWUg
Y29uZGl0aW9uICcoaSA+PSAwKSA9PiAoMC11MzJtYXggPj0gMCknCgpGaXhlczogN2I1MmRiMzlh
NGMyICgiZHJtL2FtZC9wb3dlcnBsYXk6IGZpeCBidWcgc2Nsay9tY2xrIGxldmVsIGNhbid0IGJl
IHNldCBvbiB2ZWdhMTAuIikKU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBvcmFjbGUuY29tPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aHdtZ3IvdmVnYTEwX2h3bWdyLmMKaW5kZXggYWQzMGY1ZDNhMTBkLi4yNjE0YWYyZjU1M2YgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21n
ci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21n
ci5jCkBAIC00MTg2LDcgKzQxODYsNyBAQCBzdGF0aWMgaW50IHZlZ2ExMF9mb3JjZV9jbG9ja19s
ZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCQllbnVtIHBwX2Nsb2NrX3R5cGUgdHlwZSwg
dWludDMyX3QgbWFzaykKIHsKIAlzdHJ1Y3QgdmVnYTEwX2h3bWdyICpkYXRhID0gKHN0cnVjdCB2
ZWdhMTBfaHdtZ3IgKikoaHdtZ3ItPmJhY2tlbmQpOwotCXVpbnQzMl90IGk7CisJaW50IGk7CiAK
IAlpZiAoaHdtZ3ItPmRwbV9sZXZlbCAhPSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9NQU5VQUwpCiAJ
CXJldHVybiAtRUlOVkFMOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
