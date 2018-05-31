From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/display: enable CONFIG_DRM_AMD_DC_DCN1_0
 by default
Date: Thu, 31 May 2018 14:01:12 -0400
Message-ID: <fdb64c3d-942f-259a-e207-c9b71a281589@amd.com>
References: <20180531143320.32061-1-alexander.deucher@amd.com>
 <20180531143320.32061-2-alexander.deucher@amd.com>
 <f4065108-0096-331e-d75d-88145f54a62e@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f4065108-0096-331e-d75d-88145f54a62e-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNS0zMSAxMjowOCBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
NS0zMSAwNDozMyBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBJdCdzIHJlcXVpcmVkIGZvciBk
aXNwbGF5cyBvbiBSYXZlbi4gIFRoZSBEQ04gYmFuZHdpZHRoIGNhbGNzIHVzZQo+PiBmbG9hdGlu
ZyBwb2ludCwgYnV0IERDTiBpcyBBUFUgb25seSBhbmQgaXQgYWxyZWFkeSBkZXBlbmRzIG9uCj4+
IFg4Ni4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9LY29uZmln
IHwgMSArCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9LY29uZmlnIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L0tjb25maWcKPj4gaW5kZXggOWQ1Njg4OTI3OWIzLi40YzM1NjI1ZWIyYzcg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9LY29uZmlnCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9LY29uZmlnCj4+IEBAIC0xMiw2ICsxMiw3
IEBAIGNvbmZpZyBEUk1fQU1EX0RDCj4+ICBjb25maWcgRFJNX0FNRF9EQ19EQ04xXzAKPj4gIAli
b29sICJEQ04gMS4wIFJhdmVuIGZhbWlseSIKPj4gIAlkZXBlbmRzIG9uIERSTV9BTURfREMgJiYg
WDg2Cj4+ICsJZGVmYXVsdCB5Cj4+ICAJaGVscAo+PiAgCSAgQ2hvb3NlIHRoaXMgb3B0aW9uIGlm
IHlvdSB3YW50IHRvIGhhdmUKPj4gIAkgIFJWIGZhbWlseSBmb3IgZGlzcGxheSBlbmdpbmUKPj4K
PiAKPiBDYW4gQ09ORklHX0RSTV9BTURfRENfRENOMV8wIGp1c3QgYmUgcmVwbGFjZWQgYnkgKHNv
bWV0aGluZyBsaWtlKQo+IENPTkZJR19YODYgYWx0b2dldGhlcj8KPiAKPiAKCgpHb29kIGlkZWEu
CgpXaWxsIGhhdmUgdG8gY2hlY2sgd2l0aCBzb21lIG9mIHRoZSBEQyBndXlzIGJ1dCBpdCBzZWVt
cyBsaWtlIGEgYmV0dGVyIG9wdGlvbiB0aGFuIHRoZSBEQ04xIG9uZS4KCkhhcnJ5Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
