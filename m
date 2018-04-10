From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Don't spam debug messages
Date: Tue, 10 Apr 2018 16:44:55 -0400
Message-ID: <25fa8982-9c92-b23e-d3ab-b86d463c0cd1@amd.com>
References: <20180409180615.15900-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180409180615.15900-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, tstdenis-5C7GfCeVMHo@public.gmane.org, Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org, sunpeng.li-5C7GfCeVMHo@public.gmane.org

UGluZwoKT24gMjAxOC0wNC0wOSAwMjowNiBQTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gU2ln
bmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2xvZ2dlcl90eXBlcy5oIHwg
MiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvbG9nZ2Vy
X3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9sb2dnZXJfdHlw
ZXMuaAo+IGluZGV4IDRmMzMyZTgwY2VjYy4uYjYwOGEwODMwODAxIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2xvZ2dlcl90eXBlcy5oCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvbG9nZ2VyX3R5cGVzLmgKPiBAQCAt
MzIsNyArMzIsNyBAQAo+ICAKPiAgI2RlZmluZSBEQ19MT0dfRVJST1IoLi4uKSBEUk1fRVJST1Io
X19WQV9BUkdTX18pCj4gICNkZWZpbmUgRENfTE9HX1dBUk5JTkcoLi4uKSBEUk1fV0FSTihfX1ZB
X0FSR1NfXykKPiAtI2RlZmluZSBEQ19MT0dfREVCVUcoLi4uKSBEUk1fSU5GTyhfX1ZBX0FSR1Nf
XykKPiArI2RlZmluZSBEQ19MT0dfREVCVUcoLi4uKSBEUk1fREVCVUdfS01TKF9fVkFfQVJHU19f
KQo+ICAjZGVmaW5lIERDX0xPR19EQyguLi4pIERSTV9ERUJVR19LTVMoX19WQV9BUkdTX18pCj4g
ICNkZWZpbmUgRENfTE9HX0RUTiguLi4pIERSTV9ERUJVR19LTVMoX19WQV9BUkdTX18pCj4gICNk
ZWZpbmUgRENfTE9HX1NVUkZBQ0UoLi4uKSBwcl9kZWJ1ZygiW1NVUkZBQ0VdOiJfX1ZBX0FSR1Nf
XykKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
