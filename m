From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: cleanup unused iterator members for sdma
 v3
Date: Mon, 14 Nov 2016 13:56:59 +0100
Message-ID: <198f9eb8-e32c-a52e-e351-131f6f5807bf@amd.com>
References: <1479127619-23643-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479127619-23643-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex
 Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMTQuMTEuMjAxNiB1bSAxMzo0NiBzY2hyaWViIEh1YW5nIFJ1aToKPiBTaWduZWQtb2ZmLWJ5
OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIGJvdGguCgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92M18wLmMgfCAyICstCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YzXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjNfMC5jCj4gaW5kZXggYzU3MTlhMS4uMzczYWU3MCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YzXzAuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjNfMC5jCj4gQEAgLTk4Nyw3ICs5ODcsNyBAQCBzdGF0
aWMgdm9pZCBzZG1hX3YzXzBfdm1fd3JpdGVfcHRlKHN0cnVjdCBhbWRncHVfaWIgKmliLCB1aW50
NjRfdCBwZSwKPiAgIAlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSBsb3dlcl8zMl9iaXRzKHBl
KTsKPiAgIAlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSB1cHBlcl8zMl9iaXRzKHBlKTsKPiAg
IAlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSBuZHc7Cj4gLQlmb3IgKDsgbmR3ID4gMDsgbmR3
IC09IDIsIC0tY291bnQsIHBlICs9IDgpIHsKPiArCWZvciAoOyBuZHcgPiAwOyBuZHcgLT0gMikg
ewo+ICAgCQlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSBsb3dlcl8zMl9iaXRzKHZhbHVlKTsK
PiAgIAkJaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gdXBwZXJfMzJfYml0cyh2YWx1ZSk7Cj4g
ICAJCXZhbHVlICs9IGluY3I7CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
