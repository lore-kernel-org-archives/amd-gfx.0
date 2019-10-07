From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] drm/amd/display: some fixes for gcc warning
Date: Mon, 7 Oct 2019 12:20:12 -0400
Message-ID: <CADnq5_O8NEnbsWdCzuYvdyT42H1y-px4Jc+t=pDcrUY1s4Y61w@mail.gmail.com>
References: <1570243476-44419-1-git-send-email-zhengbin13@huawei.com>
 <85a8ffa0-6458-32fc-41b0-6e14dcdb61d8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <85a8ffa0-6458-32fc-41b0-6e14dcdb61d8-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Li,
 Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgT2N0IDcsIDIwMTkgYXQgMTA6MTkgQU0g
SGFycnkgV2VudGxhbmQgPGh3ZW50bGFuQGFtZC5jb20+IHdyb3RlOgo+Cj4gU2VyaWVzIGlzCj4g
UmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+Cj4g
SGFycnkKPgo+IE9uIDIwMTktMTAtMDQgMTA6NDQgcC5tLiwgemhlbmdiaW4gd3JvdGU6Cj4gPiB6
aGVuZ2JpbiAoNSk6Cj4gPiAgIGRybS9hbWQvZGlzcGxheTogTWFrZSBmdW5jdGlvbiB3YWl0X2Zv
cl9hbHRfbW9kZSBzdGF0aWMKPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBSZW1vdmUgc2V0IGJ1dCBu
b3QgdXNlZCB2YXJpYWJsZSAnc291cmNlX2JwcCcKPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBSZW1v
dmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZXMKPiA+ICAgICAnaF9yYXRpb19jaHJvbWEnLCd2
X3JhdGlvX2Nocm9tYScKPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBSZW1vdmUgc2V0IGJ1dCBub3Qg
dXNlZCB2YXJpYWJsZSAncGl4ZWxfd2lkdGgnCj4gPiAgIGRybS9hbWQvZGlzcGxheTogUmVtb3Zl
IHNldCBidXQgbm90IHVzZWQgdmFyaWFibGVzICdwcF9zbXUnLCdvbGRfcGlwZScKPiA+Cj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jICAgICAgICAgICAg
ICAgfCAgMiArLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNl
MTEwX2h3X3NlcXVlbmNlci5jIHwgMTIgLS0tLS0tLS0tLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2RwcC5jICAgICAgICAgICAgfCAgNyAtLS0tLS0t
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2R3Yl9zY2wu
YyAgICAgICAgfCAgNCAtLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rz
Yy9yY19jYWxjLmMgICAgICAgICAgICAgICAgfCAgMyAtLS0KPiA+ICA1IGZpbGVzIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyNyBkZWxldGlvbnMoLSkKPiA+Cj4gPiAtLQo+ID4gMi43LjQKPiA+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
