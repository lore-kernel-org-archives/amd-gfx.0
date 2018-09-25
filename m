From: James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/8] drm/amdgpu:Add DPG support flag
Date: Tue, 25 Sep 2018 19:03:12 -0400
Message-ID: <1537916597-24934-3-git-send-email-James.Zhu@amd.com>
References: <1537916597-24934-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537916597-24934-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
bWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L2FtZF9zaGFyZWQuaCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKaW5kZXggODZiMTY3ZS4uMjA4M2Mz
MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oCkBAIC0xMDksNiAr
MTA5LDcgQEAgZW51bSBhbWRfcG93ZXJnYXRpbmdfc3RhdGUgewogI2RlZmluZSBBTURfUEdfU1VQ
UE9SVF9HRlhfUElQRUxJTkUJCSgxIDw8IDEyKQogI2RlZmluZSBBTURfUEdfU1VQUE9SVF9NTUhV
QgkJCSgxIDw8IDEzKQogI2RlZmluZSBBTURfUEdfU1VQUE9SVF9WQ04JCQkoMSA8PCAxNCkKKyNk
ZWZpbmUgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRwkoMSA8PCAxNSkKIAogZW51bSBQUF9GRUFUVVJF
X01BU0sgewogCVBQX1NDTEtfRFBNX01BU0sgPSAweDEsCi0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
