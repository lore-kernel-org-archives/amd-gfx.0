From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdkfd: Fix byte align on VegaM
Date: Tue, 23 Jul 2019 14:22:07 +0000
Message-ID: <20190723142156.4863-1-kent.russell@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

VGhpcyB3YXMgbWlzc2VkIGR1cmluZyB0aGUgYWRkaXRpb24gb2YgVmVnYU0gc3VwcG9ydAoKQ2hh
bmdlLUlkOiBJNjFjOGZiYmVhNzczMzgxMjZlM2ViZGZhNzRjMjg2YjY2NWJkZDY3MApTaWduZWQt
b2ZmLWJ5OiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDMgKystCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCmluZGV4IGY1ZWNmMjhlYjM3
Yy4uMzE3OTExN2FjNDM0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9ncHV2bS5jCkBAIC0xMTM5LDcgKzExMzksOCBAQCBpbnQgYW1kZ3B1X2FtZGtm
ZF9ncHV2bV9hbGxvY19tZW1vcnlfb2ZfZ3B1KAogCQkJYWRldi0+YXNpY190eXBlICE9IENISVBf
RklKSSAmJgogCQkJYWRldi0+YXNpY190eXBlICE9IENISVBfUE9MQVJJUzEwICYmCiAJCQlhZGV2
LT5hc2ljX3R5cGUgIT0gQ0hJUF9QT0xBUklTMTEgJiYKLQkJCWFkZXYtPmFzaWNfdHlwZSAhPSBD
SElQX1BPTEFSSVMxMikgPworCQkJYWRldi0+YXNpY190eXBlICE9IENISVBfUE9MQVJJUzEyICYm
CisJCQlhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9WRUdBTSkgPwogCQkJVklfQk9fU0laRV9BTElH
TiA6IDE7CiAKIAltYXBwaW5nX2ZsYWdzID0gQU1ER1BVX1ZNX1BBR0VfUkVBREFCTEU7Ci0tIAoy
LjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
