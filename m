From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/5] drm/amdgpu: Get pci resource directly through adev
Date: Fri, 23 Mar 2018 19:10:23 +0800
Message-ID: <1521803425-17089-3-git-send-email-Rex.Zhu@amd.com>
References: <1521803425-17089-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521803425-17089-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

SW4gb3JkZXIgdG8gcmVtb3ZlIHRoZSBjZ3Mgd3JhcHBlciBmdW5jdGlvbgoKQ2hhbmdlLUlkOiBJ
ZWI3NzFkZGZiZDU3ZGVmOWIyYTViMGZjMTI0YjQ5NjQ0NGYxZmQ3YgpTaWduZWQtb2ZmLWJ5OiBS
ZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FjcC5jIHwgMTEgKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FjcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Fj
cC5jCmluZGV4IDZjY2E0ZDEuLjIwZjIwMDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hY3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYWNwLmMKQEAgLTI5NCwxMiArMjk0LDExIEBAIHN0YXRpYyBpbnQgYWNwX2h3X2luaXQo
dm9pZCAqaGFuZGxlKQogCWVsc2UgaWYgKHIpCiAJCXJldHVybiByOwogCi0JciA9IGNnc19nZXRf
cGNpX3Jlc291cmNlKGFkZXYtPmFjcC5jZ3NfZGV2aWNlLCBDR1NfUkVTT1VSQ0VfVFlQRV9NTUlP
LAotCQkJMHg1Mjg5LCAwLCAmYWNwX2Jhc2UpOwotCWlmIChyID09IC1FTk9ERVYpCi0JCXJldHVy
biAwOwotCWVsc2UgaWYgKHIpCi0JCXJldHVybiByOworCWlmIChhZGV2LT5ybW1pb19zaXplID09
IDAgfHwgYWRldi0+cm1taW9fc2l6ZSA8IDB4NTI4OSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlh
Y3BfYmFzZSA9IGFkZXYtPnJtbWlvX2Jhc2U7CisKIAlpZiAoYWRldi0+YXNpY190eXBlICE9IENI
SVBfU1RPTkVZKSB7CiAJCWFkZXYtPmFjcC5hY3BfZ2VucGQgPSBremFsbG9jKHNpemVvZihzdHJ1
Y3QgYWNwX3BtX2RvbWFpbiksIEdGUF9LRVJORUwpOwogCQlpZiAoYWRldi0+YWNwLmFjcF9nZW5w
ZCA9PSBOVUxMKQotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
