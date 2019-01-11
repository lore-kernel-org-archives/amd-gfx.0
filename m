From: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/5] drm/amdgpu: use BACO reset on vega20 if platform support
Date: Fri, 11 Jan 2019 11:19:50 +0800
Message-ID: <20190111031950.32475-6-Jim.Qu@amd.com>
References: <20190111031950.32475-1-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190111031950.32475-1-Jim.Qu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNTMxZmE4M2NjZjRhYmY1OTMxOTRhZmQ2ZmYwNzAyYmExMzkzZDZjNwpTaWdu
ZWQtb2ZmLWJ5OiBKaW0gUXUgPEppbS5RdUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IGVjZTZmY2E0NzZkNC4uYmFmOTAzODBkZjZkIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTQ2Miw2ICs0NjIsNyBAQCBzdGF0aWMgaW50
IHNvYzE1X2FzaWNfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAKIAlzd2l0Y2gg
KGFkZXYtPmFzaWNfdHlwZSkgewogCWNhc2UgQ0hJUF9WRUdBMTA6CisJY2FzZSBDSElQX1ZFR0Ey
MDoKIAkJc29jMTVfYXNpY19nZXRfYmFjb19jYXBhYmlsaXR5KGFkZXYsICZiYWNvX3Jlc2V0KTsK
IAkJYnJlYWs7CiAJZGVmYXVsdDoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
