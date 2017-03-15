From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/radeon/si: add dpm quirk for Oland
Date: Wed, 15 Mar 2017 14:05:03 +0100
Message-ID: <452116bd-162d-76f6-31b8-dd3c2284c1f9@vodafone.de>
References: <1489582890-17915-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489582890-17915-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMTUuMDMuMjAxNyB1bSAxNDowMSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBPTEFORCAweDEw
MDI6MHg2NjA0IDB4MTAyODoweDA2NkYgMHgwMCBzZWVtcyB0byBoYXZlIHByb2JsZW1zCj4gd2l0
aCBoaWdoZXIgc2Nsa3MuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKCkFja2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciBib3RoIHBh
dGNoZXMuCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyB8IDYgKysr
KysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
c2lfZHBtLmMKPiBpbmRleCBkMTJiODk3Li43MmUxNTg4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vc2lfZHBtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Np
X2RwbS5jCj4gQEAgLTI5ODQsNiArMjk4NCwxMiBAQCBzdGF0aWMgdm9pZCBzaV9hcHBseV9zdGF0
ZV9hZGp1c3RfcnVsZXMoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCj4gICAJCSAgICAocmRl
di0+cGRldi0+ZGV2aWNlID09IDB4NjY2NykpIHsKPiAgIAkJCW1heF9zY2xrID0gNzUwMDA7Cj4g
ICAJCX0KPiArCX0gZWxzZSBpZiAocmRldi0+ZmFtaWx5ID09IENISVBfT0xBTkQpIHsKPiArCQlp
ZiAoKHJkZXYtPnBkZXYtPmRldmljZSA9PSAweDY2MDQpICYmCj4gKwkJICAgIChyZGV2LT5wZGV2
LT5zdWJzeXN0ZW1fdmVuZG9yID09IDB4MTAyOCkgJiYKPiArCQkgICAgKHJkZXYtPnBkZXYtPnN1
YnN5c3RlbV9kZXZpY2UgPT0gMHgwNjZGKSkgewo+ICsJCQltYXhfc2NsayA9IDc1MDAwOwo+ICsJ
CX0KPiAgIAl9Cj4gICAKPiAgIAlpZiAocnBzLT52Y2VfYWN0aXZlKSB7CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
