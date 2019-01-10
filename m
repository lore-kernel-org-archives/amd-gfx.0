From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH v5 04/20] drm/dp_mst: Fix some formatting in
 drm_dp_mst_deallocate_vcpi()
Date: Thu, 10 Jan 2019 10:16:52 +0100
Message-ID: <20190110091652.GE21184@phenom.ffwll.local>
References: <20190109003516.14752-1-lyude@redhat.com>
 <20190109003516.14752-5-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190109003516.14752-5-lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jerry Zuo <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, David Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Juston Li <juston.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

T24gVHVlLCBKYW4gMDgsIDIwMTkgYXQgMDc6MzU6MDFQTSAtMDUwMCwgTHl1ZGUgUGF1bCB3cm90
ZToKPiBTcGxpdCBzb21lIHN0dWZmIGFjcm9zcyBtdWx0aXBsZSBsaW5lcwo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEhhcnJ5
IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgo+
IENjOiBKZXJyeSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPgo+IENjOiBKdXN0b24gTGkgPGp1c3Rv
bi5saUBpbnRlbC5jb20+CgpPbiBwYXRjaGVzIDEtNDogUmV2aWV3ZWQtYnk6IERhbmllbCBWZXR0
ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9kcm1f
ZHBfbXN0X3RvcG9sb2d5LmMgfCAzICsrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1f
ZHBfbXN0X3RvcG9sb2d5LmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5j
Cj4gaW5kZXggYTYzYTRkMzI5NjJhLi43NWNjYTZhODQzZmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9k
cm1fZHBfbXN0X3RvcG9sb2d5LmMKPiBAQCAtMjc5MCw3ICsyNzkwLDggQEAgRVhQT1JUX1NZTUJP
TChkcm1fZHBfbXN0X3Jlc2V0X3ZjcGlfc2xvdHMpOwo+ICAgKiBAbWdyOiBtYW5hZ2VyIGZvciB0
aGlzIHBvcnQKPiAgICogQHBvcnQ6IHVudmVyaWZpZWQgcG9ydCB0byBkZWFsbG9jYXRlIHZjcGkg
Zm9yCj4gICAqLwo+IC12b2lkIGRybV9kcF9tc3RfZGVhbGxvY2F0ZV92Y3BpKHN0cnVjdCBkcm1f
ZHBfbXN0X3RvcG9sb2d5X21nciAqbWdyLCBzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpwb3J0KQo+
ICt2b2lkIGRybV9kcF9tc3RfZGVhbGxvY2F0ZV92Y3BpKHN0cnVjdCBkcm1fZHBfbXN0X3RvcG9s
b2d5X21nciAqbWdyLAo+ICsJCQkJc3RydWN0IGRybV9kcF9tc3RfcG9ydCAqcG9ydCkKPiAgewo+
ICAJcG9ydCA9IGRybV9kcF9nZXRfdmFsaWRhdGVkX3BvcnRfcmVmKG1nciwgcG9ydCk7Cj4gIAlp
ZiAoIXBvcnQpCj4gLS0gCj4gMi4yMC4xCj4gCgotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBF
bmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
