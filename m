From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 17/25] uapi: Fix type used in ioctl parameter structures
Date: Fri, 26 Jan 2018 20:09:33 -0500
Message-ID: <1517015381-1080-18-git-send-email-Felix.Kuehling@amd.com>
References: <1517015381-1080-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1517015381-1080-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

VXNlIF9fdTMyIGFuZCBfX3U2NCBpbnN0ZWFkIG9mIFBPU0lYIHR5cGVzIHRoYXQgbWF5IG5vdCBi
ZSBkZWZpbmVkCmluIHVzZXIgbW9kZSBidWlsZHMuCgpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVo
bGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KLS0tCiBpbmNsdWRlL3VhcGkvbGludXgva2Zk
X2lvY3RsLmggfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwu
aCBiL2luY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaAppbmRleCBmNGNhYjViLi4xMTFkNzNi
IDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva2ZkX2lvY3RsLmgKKysrIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oCkBAIC0yNjMsMTAgKzI2MywxMCBAQCBzdHJ1Y3Qga2Zk
X2lvY3RsX2dldF90aWxlX2NvbmZpZ19hcmdzIHsKIH07CiAKIHN0cnVjdCBrZmRfaW9jdGxfc2V0
X3RyYXBfaGFuZGxlcl9hcmdzIHsKLQl1aW50NjRfdCB0YmFfYWRkcjsJCS8qIHRvIEtGRCAqLwot
CXVpbnQ2NF90IHRtYV9hZGRyOwkJLyogdG8gS0ZEICovCi0JdWludDMyX3QgZ3B1X2lkOwkJLyog
dG8gS0ZEICovCi0JdWludDMyX3QgcGFkOworCV9fdTY0IHRiYV9hZGRyOwkJLyogdG8gS0ZEICov
CisJX191NjQgdG1hX2FkZHI7CQkvKiB0byBLRkQgKi8KKwlfX3UzMiBncHVfaWQ7CQkvKiB0byBL
RkQgKi8KKwlfX3UzMiBwYWQ7CiB9OwogCiAjZGVmaW5lIEFNREtGRF9JT0NUTF9CQVNFICdLJwot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
