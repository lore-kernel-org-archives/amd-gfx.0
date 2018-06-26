From: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4] drm/amdgpu: s/disp_detetion_ports/disp_detection_ports/
Date: Mon, 25 Jun 2018 21:09:05 -0400
Message-ID: <20180626010916.20300-3-lyude@redhat.com>
References: <20180626010916.20300-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180626010916.20300-1-lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogTHl1ZGUgUGF1bCA8bHl1ZGVAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYXRweF9oYW5kbGVyLmMgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0cHhfaGFuZGxlci5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0cHhfaGFuZGxlci5jCmluZGV4IDFhZTVhZThj
NDVhNC4uNzE3Y2M1YTkwMzEzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYXRweF9oYW5kbGVyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2F0cHhfaGFuZGxlci5jCkBAIC0zMiw3ICszMiw3IEBAIHN0cnVjdCBhbWRncHVfYXRw
eF9mdW5jdGlvbnMgewogCWJvb2wgc3dpdGNoX3N0YXJ0OwogCWJvb2wgc3dpdGNoX2VuZDsKIAli
b29sIGRpc3BfY29ubmVjdG9yc19tYXBwaW5nOwotCWJvb2wgZGlzcF9kZXRldGlvbl9wb3J0czsK
Kwlib29sIGRpc3BfZGV0ZWN0aW9uX3BvcnRzOwogfTsKIAogc3RydWN0IGFtZGdwdV9hdHB4IHsK
QEAgLTE1Niw3ICsxNTYsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfYXRweF9wYXJzZV9mdW5jdGlv
bnMoc3RydWN0IGFtZGdwdV9hdHB4X2Z1bmN0aW9ucyAqZiwgdTMyIG1hcwogCWYtPnN3aXRjaF9z
dGFydCA9IG1hc2sgJiBBVFBYX0dSQVBISUNTX0RFVklDRV9TV0lUQ0hfU1RBUlRfTk9USUZJQ0FU
SU9OX1NVUFBPUlRFRDsKIAlmLT5zd2l0Y2hfZW5kID0gbWFzayAmIEFUUFhfR1JBUEhJQ1NfREVW
SUNFX1NXSVRDSF9FTkRfTk9USUZJQ0FUSU9OX1NVUFBPUlRFRDsKIAlmLT5kaXNwX2Nvbm5lY3Rv
cnNfbWFwcGluZyA9IG1hc2sgJiBBVFBYX0dFVF9ESVNQTEFZX0NPTk5FQ1RPUlNfTUFQUElOR19T
VVBQT1JURUQ7Ci0JZi0+ZGlzcF9kZXRldGlvbl9wb3J0cyA9IG1hc2sgJiBBVFBYX0dFVF9ESVNQ
TEFZX0RFVEVDVElPTl9QT1JUU19TVVBQT1JURUQ7CisJZi0+ZGlzcF9kZXRlY3Rpb25fcG9ydHMg
PSBtYXNrICYgQVRQWF9HRVRfRElTUExBWV9ERVRFQ1RJT05fUE9SVFNfU1VQUE9SVEVEOwogfQog
CiAvKioKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
