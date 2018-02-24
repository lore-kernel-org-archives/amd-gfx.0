From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/10] drm/amd/pp: Add new hw interface for auto wattman
 feature.
Date: Sat, 24 Feb 2018 21:56:00 +0800
Message-ID: <1519480567-23858-3-git-send-email-Rex.Zhu@amd.com>
References: <1519480567-23858-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519480567-23858-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

QXV0byB3YXR0bWFuIGZlYXR1cmUgd2FzIHVzZWQgZm9yIGFkanVzdCBkcG0Kb3B0aW1pemF0aW9u
IHNldHRpbmdzIGJhc2VkIG9uIHdvcmtsb2FkcwoKQ2hhbmdlLUlkOiBJNmU3NDdiZWI3Nzg2YzQ1
ZjczM2MzYzBmOWVmOWI0OGM5OGYwNDg0YwpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2h3bWdyLmggfCAy
ICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2h3bWdyLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9pbmMvaHdtZ3IuaAppbmRleCBhM2JlYjMxLi5kOWFlZjg4IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaAorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaApAQCAtMzQ3LDYgKzM0Nyw4IEBAIHN0
cnVjdCBwcF9od21ncl9mdW5jIHsKIAkJCQkJbG9uZyAqaW5wdXQsIHVpbnQzMl90IHNpemUpOwog
CWludCAoKnNldF9wb3dlcl9saW1pdCkoc3RydWN0IHBwX2h3bWdyICpod21nciwgdWludDMyX3Qg
bik7CiAJaW50ICgqc2V0X21taHViX3Bvd2VyZ2F0aW5nX2J5X3NtdSkoc3RydWN0IHBwX2h3bWdy
ICpod21ncik7CisJaW50ICgqdXBkYXRlX2F1dG9fd2F0dG1hbikoc3RydWN0IHBwX2h3bWdyICpo
d21ncik7CisJdm9pZCAoKnN0YXJ0X2F1dG9fd2F0dG1hbikoc3RydWN0IHBwX2h3bWdyICpod21n
ciwgYm9vbCBlbik7CiB9OwogCiBzdHJ1Y3QgcHBfdGFibGVfZnVuYyB7Ci0tIAoxLjkuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
