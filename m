From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/10] drm/nouveau: Use connector kdev as aux device parent
Date: Thu, 4 Jul 2019 15:05:13 -0400
Message-ID: <20190704190519.29525-5-sunpeng.li@amd.com>
References: <20190704190519.29525-1-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190704190519.29525-1-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org

RnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpTZXQgdGhlIGNvbm5lY3RvcidzIGtl
cm5lbCBkZXZpY2UgYXMgdGhlIHBhcmVudCBmb3IgdGhlIGF1eCBrZXJuZWwKZGV2aWNlLiBUaGlz
IGFsbG93cyB1ZGV2IHJ1bGVzIHRvIGFjY2VzcyBjb25uZWN0b3IgYXR0cmlidXRlcyB3aGVuCmNy
ZWF0aW5nIHN5bWxpbmtzIHRvIGF1eCBkZXZpY2VzLgoKQ2M6IEJlbiBTa2VnZ3MgPGJza2VnZ3NA
cmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9jb25uZWN0b3IuYyB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfY29ubmVjdG9yLmMgYi9kcml2ZXJzL2dw
dS9kcm0vbm91dmVhdS9ub3V2ZWF1X2Nvbm5lY3Rvci5jCmluZGV4IDQxMTZlZTYyYWRhZi4uZTMy
ZGVmMDllZjg5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2Nv
bm5lY3Rvci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfY29ubmVjdG9y
LmMKQEAgLTEzNDYsNyArMTM0Niw3IEBAIG5vdXZlYXVfY29ubmVjdG9yX2NyZWF0ZShzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2LAogCQlicmVhazsKIAljYXNlIERSTV9NT0RFX0NPTk5FQ1RPUl9EaXNw
bGF5UG9ydDoKIAljYXNlIERSTV9NT0RFX0NPTk5FQ1RPUl9lRFA6Ci0JCW52X2Nvbm5lY3Rvci0+
YXV4LmRldiA9IGRldi0+ZGV2OworCQludl9jb25uZWN0b3ItPmF1eC5kZXYgPSBjb25uZWN0b3It
PmtkZXY7CiAJCW52X2Nvbm5lY3Rvci0+YXV4LnRyYW5zZmVyID0gbm91dmVhdV9jb25uZWN0b3Jf
YXV4X3hmZXI7CiAJCXNucHJpbnRmKGF1eF9uYW1lLCBzaXplb2YoYXV4X25hbWUpLCAic29yLSUw
NHgtJTA0eCIsCiAJCQkgZGNiZS0+aGFzaHQsIGRjYmUtPmhhc2htKTsKLS0gCjIuMjIuMAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
