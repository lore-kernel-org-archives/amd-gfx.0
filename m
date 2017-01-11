From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: fix bug set incorrect value to vce register
Date: Wed, 11 Jan 2017 11:48:38 +0800
Message-ID: <1484106519-10827-1-git-send-email-Rex.Zhu@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMTQ5NTg5NGQwMWNhMTBlNWQ0OTZlNzFmNWQ0YjFhOTNhMTIzMzZmMwpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNlX3YzXzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZjZV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jCmlu
ZGV4IGUzYmFkODJkLi4wYWM0OTgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y2VfdjNfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18w
LmMKQEAgLTE3NSw3ICsxNzUsNyBAQCBzdGF0aWMgdm9pZCB2Y2VfdjNfMF9zZXRfdmNlX3N3X2Ns
b2NrX2dhdGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJV1JFRzMyKG1tVkNFX1VF
TkNfQ0xPQ0tfR0FUSU5HXzIsIGRhdGEpOwogCiAJCWRhdGEgPSBSUkVHMzIobW1WQ0VfVUVOQ19S
RUdfQ0xPQ0tfR0FUSU5HKTsKLQkJZGF0YSAmPSB+MHhmZmMwMDAwMDsKKwkJZGF0YSAmPSB+MHgz
ZmY7CiAJCVdSRUczMihtbVZDRV9VRU5DX1JFR19DTE9DS19HQVRJTkcsIGRhdGEpOwogCiAJCWRh
dGEgPSBSUkVHMzIobW1WQ0VfVUVOQ19ETUFfRENMS19DVFJMKTsKLS0gCjEuOS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
