From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: disable page queue support for Vega20
Date: Thu, 22 Nov 2018 10:14:31 +0100
Message-ID: <0100f424-8736-3c6d-a1c5-e66618a068ef@gmail.com>
References: <20181121064030.14792-1-evan.quan@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181121064030.14792-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjEuMTEuMTggdW0gMDc6NDAgc2NocmllYiBFdmFuIFF1YW46Cj4gS2VlcCBpdCBkaXNhYmxl
ZCB1bnRpbCB3ZSBjb25maXJtIGl0J3MgcmVhZHkuCj4KPiBDaGFuZ2UtSWQ6IEkyZGM0YzBmMTE1
NmRkODJmNzA0NjY3MmZlZDZkMjJiOWQxOGMyMDEwCj4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFu
IDxldmFuLnF1YW5AYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjRfMC5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zZG1hX3Y0XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCj4g
aW5kZXggMGEzYjY4ZGQ0OWEwLi5lNmNiMmMzOTk5NTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3Y0XzAuYwo+IEBAIC0xNDU3LDcgKzE0NTcsOCBAQCBzdGF0aWMgYm9vbCBz
ZG1hX3Y0XzBfZndfc3VwcG9ydF9wYWdpbmdfcXVldWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCj4gICAJY2FzZSBDSElQX1ZFR0ExMjoKPiAgIAkJcmV0dXJuIGZ3X3ZlcnNpb24gPj0gMzE7
Cj4gICAJY2FzZSBDSElQX1ZFR0EyMDoKPiAtCQlyZXR1cm4gZndfdmVyc2lvbiA+PSAxMTU7Cj4g
KwkJLy9yZXR1cm4gZndfdmVyc2lvbiA+PSAxMTU7Cj4gKwkJcmV0dXJuIGZhbHNlOwoKUGxlYXNl
IGRvbid0IHVzZSAiLy8iIGluIGtlcm5lbCBjb2RlIHRvIGNvbW1lbnQgdGhpbmdzIG91dC4KCkNo
cmlzdGlhbi4KCj4gICAJZGVmYXVsdDoKPiAgIAkJcmV0dXJuIGZhbHNlOwo+ICAgCX0KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
