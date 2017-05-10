From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 082/117] uapi/drm: add AMDGPU_HW_IP_VCN_ENC for encode CS
Date: Wed, 10 May 2017 14:47:13 -0400
Message-ID: <1494442068-8202-75-git-send-email-alexander.deucher@amd.com>
References: <1494442068-8202-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1494442068-8202-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8
bGVvLmxpdUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggfCAzICsrLQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIGIvaW5jbHVkZS91YXBpL2RybS9hbWRn
cHVfZHJtLmgKaW5kZXggZWVhYTA0YS4uYzk5ZmU2MyAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBp
L2RybS9hbWRncHVfZHJtLmgKKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKQEAg
LTQzNCw3ICs0MzQsOCBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9nZW1fdmEgewogI2RlZmluZSBBTURH
UFVfSFdfSVBfVkNFICAgICAgICAgIDQKICNkZWZpbmUgQU1ER1BVX0hXX0lQX1VWRF9FTkMgICAg
ICA1CiAjZGVmaW5lIEFNREdQVV9IV19JUF9WQ05fREVDICAgICAgNgotI2RlZmluZSBBTURHUFVf
SFdfSVBfTlVNICAgICAgICAgIDcKKyNkZWZpbmUgQU1ER1BVX0hXX0lQX1ZDTl9FTkMgICAgICA3
CisjZGVmaW5lIEFNREdQVV9IV19JUF9OVU0gICAgICAgICAgOAogCiAjZGVmaW5lIEFNREdQVV9I
V19JUF9JTlNUQU5DRV9NQVhfQ09VTlQgMQogCi0tIAoyLjUuNQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
