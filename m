From: Luben Tuikov <luben.tuikov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: enable TMZ bit in FRAME_CONTROL for gfx10
Date: Tue, 19 Nov 2019 18:51:42 -0500
Message-ID: <de8125e7-a483-4701-7d29-2ba33ca3e21d@amd.com>
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
 <1574054316-2802-5-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574054316-2802-5-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Ray.Huang-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

T24gMjAxOS0xMS0xOCAxMjoxOCBhLm0uLCBBYXJvbiBMaXUgd3JvdGU6Cj4gVGhpcyBwYXRjaCBl
bmFibGVzIFRNWiBiaXQgaW4gRlJBTUVfQ09OVFJPTCBmb3IgZ2Z4MTAuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jCj4gaW5kZXggZDZlMTFlZS4uOGRjZTA2NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gQEAgLTQ1ODgsNyArNDU4OCw3IEBAIHN0YXRpYyB2b2lk
IGdmeF92MTBfMF9yaW5nX2VtaXRfY250eGNudGwoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+
ICAJCWdmeF92MTBfMF9yaW5nX2VtaXRfY2VfbWV0YShyaW5nLAo+ICAJCQkJICAgIGZsYWdzICYg
QU1ER1BVX0lCX1BSRUVNUFRFRCA/IHRydWUgOiBmYWxzZSk7Cj4gIAo+IC0JZ2Z4X3YxMF8wX3Jp
bmdfZW1pdF90bXoocmluZywgdHJ1ZSwgZmFsc2UpOwo+ICsJZ2Z4X3YxMF8wX3JpbmdfZW1pdF90
bXoocmluZywgdHJ1ZSwgdHJ1c3RlZCk7Cj4gIAoKRG8geW91IG1lYW4gaGVyZSAidHJ1ZSIgKHRo
ZSBvcHBvc2l0ZSBvZiAiZmFsc2UiKSBhcyBvcHBvc2VkIHRvICJ0cnVzdGVkIj8KClJlZ2FyZHMs
Ckx1YmVuCgo+ICAJZHcyIHw9IDB4ODAwMDAwMDA7IC8qIHNldCBsb2FkX2VuYWJsZSBvdGhlcndp
c2UgdGhpcyBwYWNrYWdlIGlzIGp1c3QgTk9QcyAqLwo+ICAJaWYgKGZsYWdzICYgQU1ER1BVX0hB
VkVfQ1RYX1NXSVRDSCkgewo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
