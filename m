From: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] Revert "drm/amdgpu: disable stutter mode for renoir"
Date: Fri, 27 Sep 2019 03:23:27 +0000
Message-ID: <1569554593-18302-1-git-send-email-aaron.liu@amd.com>
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
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>

VGhpcyByZXZlcnRzIGNvbW1pdCBjNTEyZTZmZGZkMmRhOTE3YjViNjc5MjkwMmU3MjI0ZjU4YTc3
Zjk0LgoKU2luY2UgU0JJT1MgV0NEOTkyNU4sIE5NSSBwcmludGluZyBkaXNhcHBlYXJlZC4gSGVu
Y2UgZW5hYmxlIHN0dXR0ZXIKbW9kZS4KClNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24u
bGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4
IGJkYWIzZjcuLjlkOGQ3ZTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMjQ2Niw4ICsyNDY2LDYgQEAgc3RhdGljIGludCBh
bWRncHVfZG1faW5pdGlhbGl6ZV9kcm1fZGV2aWNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCiAJaWYgKGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQX0NBUlJJWk8gJiYgYWRldi0+YXNpY190
eXBlICE9IENISVBfU1RPTkVZKQogCQlkbS0+ZGMtPmRlYnVnLmRpc2FibGVfc3R1dHRlciA9IGFt
ZGdwdV9wcF9mZWF0dXJlX21hc2sgJiBQUF9TVFVUVEVSX01PREUgPyBmYWxzZSA6IHRydWU7Ci0J
aWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1JFTk9JUikKLQkJZG0tPmRjLT5kZWJ1Zy5kaXNh
YmxlX3N0dXR0ZXIgPSB0cnVlOwogCiAJcmV0dXJuIDA7CiBmYWlsOgotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
