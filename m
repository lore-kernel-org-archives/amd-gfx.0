From: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/4] drm/radeon: Remove initialization of
 shared_resources.num_mec
Date: Thu, 13 Jul 2017 20:21:55 -0500
Message-ID: <1499995316-4544-3-git-send-email-Jay.Cornwall@amd.com>
References: <1499995316-4544-1-git-send-email-Jay.Cornwall@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499995316-4544-1-git-send-email-Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
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
Cc: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>

RGVhZCBjb2RlLgoKQ2hhbmdlLUlkOiBJMjM4M2UwYjU0MWVkNTUyODg1NzBiNmEwZWM4YTBkNDlj
ZGQ0ZGY4OQpTaWduZWQtb2ZmLWJ5OiBKYXkgQ29ybndhbGwgPEpheS5Db3Jud2FsbEBhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2tmZC5jIHwgMSAtCiAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2tmZC5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa2ZkLmMKaW5k
ZXggNzE5ZWE1MS4uOGY4YzdjMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fa2ZkLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa2ZkLmMKQEAg
LTI1MSw3ICsyNTEsNiBAQCB2b2lkIHJhZGVvbl9rZmRfZGV2aWNlX2luaXQoc3RydWN0IHJhZGVv
bl9kZXZpY2UgKnJkZXYpCiAJaWYgKHJkZXYtPmtmZCkgewogCQlzdHJ1Y3Qga2dkMmtmZF9zaGFy
ZWRfcmVzb3VyY2VzIGdwdV9yZXNvdXJjZXMgPSB7CiAJCQkuY29tcHV0ZV92bWlkX2JpdG1hcCA9
IDB4RkYwMCwKLQkJCS5udW1fbWVjID0gMSwKIAkJCS5udW1fcGlwZV9wZXJfbWVjID0gNCwKIAkJ
CS5udW1fcXVldWVfcGVyX3BpcGUgPSA4LAogCQkJLmdwdXZtX3NpemUgPSAodWludDY0X3QpcmFk
ZW9uX3ZtX3NpemUgPDwgMzAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
