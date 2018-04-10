From: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Don't spam debug messages
Date: Tue, 10 Apr 2018 16:47:06 -0400
Message-ID: <cb635c75-1324-259a-b369-90a6490f95db@amd.com>
References: <20180409180615.15900-1-harry.wentland@amd.com>
 <25fa8982-9c92-b23e-d3ab-b86d463c0cd1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <25fa8982-9c92-b23e-d3ab-b86d463c0cd1-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, tstdenis-5C7GfCeVMHo@public.gmane.org, Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org

CgpPbiAyMDE4LTA0LTEwIDA0OjQ0IFBNLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPiBQaW5nCj4g
Cj4gT24gMjAxOC0wNC0wOSAwMjowNiBQTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4+IFNpZ25l
ZC1vZmYtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgoKUmV2aWV3
ZWQtYnk6IExlbyAoU3VucGVuZykgTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KCj4+IC0tLQo+PiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2xvZ2dlcl90eXBlcy5oIHwgMiAr
LQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvbG9nZ2Vy
X3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9sb2dnZXJfdHlw
ZXMuaAo+PiBpbmRleCA0ZjMzMmU4MGNlY2MuLmI2MDhhMDgzMDgwMSAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvbG9nZ2VyX3R5cGVzLmgKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvbG9nZ2VyX3R5cGVzLmgKPj4g
QEAgLTMyLDcgKzMyLDcgQEAKPj4gICAKPj4gICAjZGVmaW5lIERDX0xPR19FUlJPUiguLi4pIERS
TV9FUlJPUihfX1ZBX0FSR1NfXykKPj4gICAjZGVmaW5lIERDX0xPR19XQVJOSU5HKC4uLikgRFJN
X1dBUk4oX19WQV9BUkdTX18pCj4+IC0jZGVmaW5lIERDX0xPR19ERUJVRyguLi4pIERSTV9JTkZP
KF9fVkFfQVJHU19fKQo+PiArI2RlZmluZSBEQ19MT0dfREVCVUcoLi4uKSBEUk1fREVCVUdfS01T
KF9fVkFfQVJHU19fKQo+PiAgICNkZWZpbmUgRENfTE9HX0RDKC4uLikgRFJNX0RFQlVHX0tNUyhf
X1ZBX0FSR1NfXykKPj4gICAjZGVmaW5lIERDX0xPR19EVE4oLi4uKSBEUk1fREVCVUdfS01TKF9f
VkFfQVJHU19fKQo+PiAgICNkZWZpbmUgRENfTE9HX1NVUkZBQ0UoLi4uKSBwcl9kZWJ1ZygiW1NV
UkZBQ0VdOiJfX1ZBX0FSR1NfXykKPj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
