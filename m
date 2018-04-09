From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Don't spam debug messages
Date: Mon, 9 Apr 2018 14:13:28 -0400
Message-ID: <e1e095dc-f1e2-7624-aafe-786c953d57fe@amd.com>
References: <20180409180615.15900-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org, sunpeng.li-5C7GfCeVMHo@public.gmane.org

VGVzdGVkLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+CgoKV29ya3MgZm9y
IG1lIQoKVGhhbmtzLApUb20KCk9uIDA0LzA5LzIwMTggMDI6MDYgUE0sIEhhcnJ5IFdlbnRsYW5k
IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBh
bWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvbG9n
Z2VyX3R5cGVzLmggfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2luY2x1ZGUvbG9nZ2VyX3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5j
bHVkZS9sb2dnZXJfdHlwZXMuaAo+IGluZGV4IDRmMzMyZTgwY2VjYy4uYjYwOGEwODMwODAxIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2xvZ2dlcl90
eXBlcy5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvbG9nZ2Vy
X3R5cGVzLmgKPiBAQCAtMzIsNyArMzIsNyBAQAo+ICAgCj4gICAjZGVmaW5lIERDX0xPR19FUlJP
UiguLi4pIERSTV9FUlJPUihfX1ZBX0FSR1NfXykKPiAgICNkZWZpbmUgRENfTE9HX1dBUk5JTkco
Li4uKSBEUk1fV0FSTihfX1ZBX0FSR1NfXykKPiAtI2RlZmluZSBEQ19MT0dfREVCVUcoLi4uKSBE
Uk1fSU5GTyhfX1ZBX0FSR1NfXykKPiArI2RlZmluZSBEQ19MT0dfREVCVUcoLi4uKSBEUk1fREVC
VUdfS01TKF9fVkFfQVJHU19fKQo+ICAgI2RlZmluZSBEQ19MT0dfREMoLi4uKSBEUk1fREVCVUdf
S01TKF9fVkFfQVJHU19fKQo+ICAgI2RlZmluZSBEQ19MT0dfRFROKC4uLikgRFJNX0RFQlVHX0tN
UyhfX1ZBX0FSR1NfXykKPiAgICNkZWZpbmUgRENfTE9HX1NVUkZBQ0UoLi4uKSBwcl9kZWJ1Zygi
W1NVUkZBQ0VdOiJfX1ZBX0FSR1NfXykKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
