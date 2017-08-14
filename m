From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/ttm:fix missing inc bo_count
Date: Mon, 14 Aug 2017 10:07:13 +0200
Message-ID: <0a0407c7-6e8e-cd00-d01f-36fc9d5e4c87@vodafone.de>
References: <1502682217-8920-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1502682217-8920-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTQuMDguMjAxNyB1bSAwNTo0MyBzY2hyaWViIE1vbmsgTGl1Ogo+IEZyb206IE1vbmsgTGl1
IDxtb25rLmxpdUBhbWQuY29tPgo+Cj4gQ2hhbmdlLUlkOiBJMzJlZDkyOGU1OWRiNTQ3OGU0Mjkx
ODlhYzhiMDEwZTMzNmU0NWE5NAo+IFNpZ25lLW9mZi1ieTogSmFjayBYaWFvIDxqYWNrLnhpYW9A
YW1kLmNvbT4KCk5pY2UgY2F0Y2gsIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpQbGVhc2UgcGluZyBtZSBpZiB0aG9zZSBU
VE0gcGF0Y2hlcyBuZWVkIGEgd2hpdGVsaXN0aW5nIGluIG91ciBpbnRlcm5hbCAKZ2l0IHNlcnZl
ci4KCkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGls
LmMgfCAxICsKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYyBiL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvX3V0aWwuYwo+IGluZGV4IGQwNDU5YjMuLmM5MzRhZDUgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fYm9fdXRpbC5jCj4gQEAgLTQ2OSw2ICs0NjksNyBAQCBzdGF0aWMgaW50IHR0bV9i
dWZmZXJfb2JqZWN0X3RyYW5zZmVyKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCj4gICAJ
ICogVE9ETzogRXhwbGljaXQgbWVtYmVyIGNvcHkgd291bGQgcHJvYmFibHkgYmUgYmV0dGVyIGhl
cmUuCj4gICAJICovCj4gICAKPiArCWF0b21pY19pbmMoJmJvLT5nbG9iLT5ib19jb3VudCk7Cj4g
ICAJSU5JVF9MSVNUX0hFQUQoJmZiby0+ZGRlc3Ryb3kpOwo+ICAgCUlOSVRfTElTVF9IRUFEKCZm
Ym8tPmxydSk7Cj4gICAJSU5JVF9MSVNUX0hFQUQoJmZiby0+c3dhcCk7CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
