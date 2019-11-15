From: zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/6]  drm/radeon: remove some set but not used variables
Date: Fri, 15 Nov 2019 20:12:54 +0800
Message-ID: <1573819980-54523-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org

emhlbmdiaW4gKDYpOgogIGRybS9yYWRlb246IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlh
YmxlICdzaXplJywncmVsb2NzX2NodW5rJwogIGRybS9yYWRlb246IHJlbW92ZSBzZXQgYnV0IG5v
dCB1c2VkIHZhcmlhYmxlICdiYWNrYmlhc19yZXNwb25zZV90aW1lJwogIGRybS9yYWRlb246IHJl
bW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdkaWdfY29ubmVjdG9yJwogIGRybS9yYWRl
b246IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdyYWRlb25fY29ubmVjdG9yJwog
IGRybS9yYWRlb246IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdibG9ja3MnCiAg
ZHJtL3JhZGVvbjogcmVtb3ZlIHNldCBidXQgbm90IHVzZWQgdmFyaWFibGUgJ3R2X3BsbF9jbnRs
MScKCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2F0b21iaW9zX2RwLmMgICAgICB8IDMgLS0tCiBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfY3MuYyAgICAgICAgICB8IDggKystLS0tLS0KIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NvbWJpb3MuYyAgIHwgMyArLS0KIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYyAgIHwgMiAtLQogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fbGVnYWN5X3R2LmMgfCA4ICstLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3NpX2RwbS5jICAgICAgICAgICB8IDMgKy0tCiA2IGZpbGVzIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCgotLQoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
