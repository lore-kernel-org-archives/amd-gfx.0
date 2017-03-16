From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/4] amdgpu: add new VA operations CLEAR and REPLACE
Date: Thu, 16 Mar 2017 11:56:38 +0800
Message-ID: <1489636601-31486-2-git-send-email-Jerry.Zhang@amd.com>
References: <1489636601-31486-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489636601-31486-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGlu
Y2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL2Ry
bS9hbWRncHVfZHJtLmgKaW5kZXggNjlhNzM0MC4uMzRmODI4MiAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9kcm0vYW1kZ3B1X2RybS5oCisrKyBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaApAQCAtNDEw
LDYgKzQxMCw4IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2dlbV9vcCB7CiAKICNkZWZpbmUgQU1ER1BV
X1ZBX09QX01BUAkJCTEKICNkZWZpbmUgQU1ER1BVX1ZBX09QX1VOTUFQCQkJMgorI2RlZmluZSBB
TURHUFVfVkFfT1BfQ0xFQVIJCQkzCisjZGVmaW5lIEFNREdQVV9WQV9PUF9SRVBMQUNFCQkJNAog
CiAvKiBEZWxheSB0aGUgcGFnZSB0YWJsZSB1cGRhdGUgdGlsbCB0aGUgbmV4dCBDUyAqLwogI2Rl
ZmluZSBBTURHUFVfVk1fREVMQVlfVVBEQVRFCQkoMSA8PCAwKQotLSAKMS45LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
