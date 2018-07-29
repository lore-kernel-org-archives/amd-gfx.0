From: Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/5] drm/amgpu/acp: Implement set_powergating_state for acp
Date: Sun, 29 Jul 2018 19:12:09 +0800
Message-ID: <1532862729-29907-5-git-send-email-rex.zhu@amd.com>
References: <1532862729-29907-1-git-send-email-rex.zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1532862729-29907-1-git-send-email-rex.zhu-5C7GfCeVMHo@public.gmane.org>
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

c28gZHJpdmVyIGNhbiBwb3dlcmdhdGUgYWNwIGJsb2NrIGFmdGVyIGFzaWMgaW5pdGlhbGl6ZWQK
dG8gc2F2ZSBwb3dlci4KClNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwLmMgfCA2ICsrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hY3AuYwppbmRleCBiNWI2NmMzLi4yOTdhNTQ5IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FjcC5jCkBAIC01MTQsNiArNTE0LDEyIEBAIHN0YXRpYyBpbnQgYWNw
X3NldF9jbG9ja2dhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsCiBzdGF0aWMgaW50IGFjcF9zZXRf
cG93ZXJnYXRpbmdfc3RhdGUodm9pZCAqaGFuZGxlLAogCQkJCSAgICAgZW51bSBhbWRfcG93ZXJn
YXRpbmdfc3RhdGUgc3RhdGUpCiB7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CisJYm9vbCBlbmFibGUgPSBzdGF0ZSA9PSBBTURf
UEdfU1RBVEVfR0FURSA/IHRydWUgOiBmYWxzZTsKKworCWlmIChhZGV2LT5wb3dlcnBsYXkucHBf
ZnVuY3MtPnNldF9wb3dlcmdhdGluZ19ieV9zbXUpCisJCWFtZGdwdV9kcG1fc2V0X3Bvd2VyZ2F0
aW5nX2J5X3NtdShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9BQ1AsIGVuYWJsZSk7CisKIAlyZXR1
cm4gMDsKIH0KIAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
