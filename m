From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/12] drm/amdgpu/sriov:accurate description for
 sriov_gpu_reset
Date: Sat, 30 Sep 2017 14:03:45 +0800
Message-ID: <1506751432-21789-6-git-send-email-Monk.Liu@amd.com>
References: <1506751432-21789-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1506751432-21789-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNDEyMGYxNDZlNjhjYjM4ZGI2OTQxODQyNjc0MGQ0MDlkZTg2MTAxYQpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YwppbmRleCA1NmE5ZWJlLi4zMWE1NjA4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCkBAIC0yNzQxLDYgKzI3NDEsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9y
ZWNvdmVyX3ZyYW1fZnJvbV9zaGFkb3coc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAgKgog
ICogQXR0ZW1wdCB0aGUgcmVzZXQgdGhlIEdQVSBpZiBpdCBoYXMgaHVuZyAoYWxsIGFzaWNzKS4K
ICAqIGZvciBTUklPViBjYXNlLgorICogaWYgQGpvYiBpcyBudWxsLCBpdCB3aWxsIG5vdCBkcm9w
IGFueSBqb2IsIGluc3RlYWQgaXQganVzdCByZXBlYXQgdGhvc2UKKyAqIGpvYnMuCisgKgogICog
UmV0dXJucyAwIGZvciBzdWNjZXNzIG9yIGFuIGVycm9yIG9uIGZhaWx1cmUuCiAgKi8KIGludCBh
bWRncHVfc3Jpb3ZfZ3B1X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qg
YW1kZ3B1X2pvYiAqam9iKQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
