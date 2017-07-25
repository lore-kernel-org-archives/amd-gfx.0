From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/81] drm/amd/display: Add clock info struct
Date: Tue, 25 Jul 2017 09:53:25 -0400
Message-ID: <1500990881-6100-6-git-send-email-sunpeng.li@amd.com>
References: <1500990881-6100-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1500990881-6100-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Corbin McElhanney <corbin.mcelhanney-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQ29yYmluIE1jRWxoYW5uZXkgPGNvcmJpbi5tY2VsaGFubmV5QGFtZC5jb20+CgpDaGFu
Z2UtSWQ6IEkyY2NhNGQ4ODZiMDk5M2ZjMDUxMjMxMmMzNWM0MmQwOGMzYWQzNGJlClNpZ25lZC1v
ZmYtYnk6IENvcmJpbiBNY0VsaGFubmV5IDxjb3JiaW4ubWNlbGhhbm5leUBhbWQuY29tPgpSZXZp
ZXdlZC1ieTogTG9nYXRoYXJzaGFuIFRob3RoaXJhbGluZ2FtIDxMb2dhdGhhcnNoYW4uVGhvdGhp
cmFsaW5nYW1AYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxIYXJyeS5XZW50bGFu
ZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9zZXJ2aWNl
c190eXBlcy5oIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2VydmljZXNfdHlw
ZXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9zZXJ2aWNlc190eXBlcy5o
CmluZGV4IGIyODMwNDUuLjRjMDRlYzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbV9zZXJ2aWNlc190eXBlcy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbV9zZXJ2aWNlc190eXBlcy5oCkBAIC0yNzEsNCArMjcxLDEwIEBAIHN0cnVj
dCBkbV9wcF9zdGF0aWNfY2xvY2tfaW5mbyB7CiAJZW51bSBkbV9wcF9jbG9ja3Nfc3RhdGUgbWF4
X2Nsb2Nrc19zdGF0ZTsKIH07CiAKK3N0cnVjdCBkdG5fbWluX2Nsa19pbmZvIHsKKwl1aW50MzJf
dCBkaXNwX2Nsa19raHo7CisJdWludDMyX3QgbWluX2VuZ2luZV9jbG9ja19raHo7CisJdWludDMy
X3QgbWluX21lbW9yeV9jbG9ja19raHo7Cit9OworCiAjZW5kaWYKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
