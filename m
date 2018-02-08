From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/10] drm/amd/pp: Add new hw interface for auto wattman
 feature.
Date: Thu, 8 Feb 2018 17:14:16 +0800
Message-ID: <1518081259-18120-8-git-send-email-Rex.Zhu@amd.com>
References: <1518081259-18120-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1518081259-18120-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJYjM0YzI4MTVhYjk1ODkwYmE5MWY5YTYxYmMwNTk0YjBmNWUwYzNmZApTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaW5jL2h3bWdyLmggfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5j
L2h3bWdyLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaAppbmRl
eCAzMTk4OGQ3Li5kODA5ZDk2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9pbmMvaHdtZ3IuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMv
aHdtZ3IuaApAQCAtMzUxLDYgKzM1MSw4IEBAIHN0cnVjdCBwcF9od21ncl9mdW5jIHsKIAkJCQkJ
bG9uZyAqaW5wdXQsIHVpbnQzMl90IHNpemUpOwogCWludCAoKnNldF9wb3dlcl9saW1pdCkoc3Ry
dWN0IHBwX2h3bWdyICpod21nciwgdWludDMyX3Qgbik7CiAJaW50ICgqc2V0X21taHViX3Bvd2Vy
Z2F0aW5nX2J5X3NtdSkoc3RydWN0IHBwX2h3bWdyICpod21ncik7CisJaW50ICgqdXBkYXRlX2F1
dG9fd2F0dG1hbikoc3RydWN0IHBwX2h3bWdyICpod21ncik7CisJdm9pZCAoKnN0YXJ0X2F1dG9f
d2F0dG1hbikoc3RydWN0IHBwX2h3bWdyICpod21nciwgYm9vbCBlbik7CiB9OwogCiBzdHJ1Y3Qg
cHBfdGFibGVfZnVuYyB7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
