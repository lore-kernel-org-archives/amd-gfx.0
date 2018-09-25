From: James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/8] drm/amdgpu:Add DPG support flag
Date: Tue, 25 Sep 2018 15:55:18 -0400
Message-ID: <1537905323-27071-3-git-send-email-James.Zhu@amd.com>
References: <1537905323-27071-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537905323-27071-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: james.zhu-5C7GfCeVMHo@public.gmane.org

QWRkIERQRyBzdXBwb3J0IGZsYWcgZm9yIFZDTiBEUEcgbW9kZS4KClNpZ25lZC1vZmYtYnk6IEph
bWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNs
dWRlL2FtZF9zaGFyZWQuaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaAppbmRleCA4NmIxNjdlLi4y
ZjZiZGYxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJl
ZC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKQEAgLTEx
MCw2ICsxMTAsOCBAQCBlbnVtIGFtZF9wb3dlcmdhdGluZ19zdGF0ZSB7CiAjZGVmaW5lIEFNRF9Q
R19TVVBQT1JUX01NSFVCCQkJKDEgPDwgMTMpCiAjZGVmaW5lIEFNRF9QR19TVVBQT1JUX1ZDTgkJ
CSgxIDw8IDE0KQogCisjZGVmaW5lIEFNRF9QR19TVVBQT1JUX0RQRwkJCSgxIDw8IDE1KQorCiBl
bnVtIFBQX0ZFQVRVUkVfTUFTSyB7CiAJUFBfU0NMS19EUE1fTUFTSyA9IDB4MSwKIAlQUF9NQ0xL
X0RQTV9NQVNLID0gMHgyLAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
