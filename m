From: <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 16/18] uapi/drm: add AMDGPU_HW_IP_VCN_JPEG for jpeg CS
Date: Wed, 30 May 2018 16:27:31 -0400
Message-ID: <1527712053-15027-16-git-send-email-boyuan.zhang@amd.com>
References: <1527712053-15027-1-git-send-email-boyuan.zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527712053-15027-1-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>, leo.liu-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

RnJvbTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KCkFkZCBBTURHUFVfSFdf
SVBfVkNOX0pQRUcgZGVmaW5lIGZvciBqcGVnIENTCgpTaWduZWQtb2ZmLWJ5OiBCb3l1YW4gWmhh
bmcgPGJveXVhbi56aGFuZ0BhbWQuY29tPgotLS0KIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2Ry
bS5oIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUv
dWFwaS9kcm0vYW1kZ3B1X2RybS5oCmluZGV4IDViMDA3ZmEuLmViODUxNWQgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCisrKyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1k
Z3B1X2RybS5oCkBAIC00ODYsNyArNDg2LDggQEAgc3RydWN0IGRybV9hbWRncHVfZ2VtX3ZhIHsK
ICNkZWZpbmUgQU1ER1BVX0hXX0lQX1VWRF9FTkMgICAgICA1CiAjZGVmaW5lIEFNREdQVV9IV19J
UF9WQ05fREVDICAgICAgNgogI2RlZmluZSBBTURHUFVfSFdfSVBfVkNOX0VOQyAgICAgIDcKLSNk
ZWZpbmUgQU1ER1BVX0hXX0lQX05VTSAgICAgICAgICA4CisjZGVmaW5lIEFNREdQVV9IV19JUF9W
Q05fSlBFRyAgICAgOAorI2RlZmluZSBBTURHUFVfSFdfSVBfTlVNICAgICAgICAgIDkKIAogI2Rl
ZmluZSBBTURHUFVfSFdfSVBfSU5TVEFOQ0VfTUFYX0NPVU5UIDEKIAotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
