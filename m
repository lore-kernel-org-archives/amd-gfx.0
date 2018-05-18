From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: [PATCH libdrm 3/3] amdgpu: Destroy fd_hash table when the last device
 is removed.
Date: Fri, 18 May 2018 13:00:07 -0400
Message-ID: <20180518170007.2847-3-jan.vesely@rutgers.edu>
References: <20180518170007.2847-1-jan.vesely@rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180518170007.2847-1-jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Rml4ZXMgbWVtb3J5IGxlYWsgb24gbW9kdWxlIHVubG9hZC4KQW5hbG9nb3VzIHRvIG1lc2EgY29t
bWl0IG9mIHRoZSBzYW1lIG5hbWUuClNpZ25lZC1vZmYtYnk6IEphbiBWZXNlbHkgPGphbi52ZXNl
bHlAcnV0Z2Vycy5lZHU+Ci0tLQogYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDQgKysrKwogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMgYi9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IGUyM2RkM2IzLi4zNGFjOTVi
OCAxMDA2NDQKLS0tIGEvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCkBAIC0xMjgsNiArMTI4LDEwIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2Vf
ZnJlZV9pbnRlcm5hbChhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYpCiB7CiAJcHRocmVhZF9tdXRl
eF9sb2NrKCZmZF9tdXRleCk7CiAJdXRpbF9oYXNoX3RhYmxlX3JlbW92ZShmZF90YWIsIFVJTlRf
VE9fUFRSKGRldi0+ZmQpKTsKKwlpZiAodXRpbF9oYXNoX3RhYmxlX2NvdW50KGZkX3RhYikgPT0g
MCkgeworCQl1dGlsX2hhc2hfdGFibGVfZGVzdHJveShmZF90YWIpOworCQlmZF90YWIgPSBOVUxM
OworCX0KIAljbG9zZShkZXYtPmZkKTsKIAlpZiAoKGRldi0+ZmxpbmtfZmQgPj0gMCkgJiYgKGRl
di0+ZmQgIT0gZGV2LT5mbGlua19mZCkpCiAJCWNsb3NlKGRldi0+ZmxpbmtfZmQpOwotLSAKMi4x
Ny4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
