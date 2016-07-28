From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [Part II PATCH 15/15] drm/amd/powerplay: add DPM running checking back
Date: Thu, 28 Jul 2016 15:25:05 +0800
Message-ID: <1469690705-877-16-git-send-email-ray.huang@amd.com>
References: <1469690705-877-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469690705-877-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCBhZGRzIERQTSBydW5uaW5nIGNoZWNraW5nIGJhY2ssIGJlY2F1c2UgdGhlIERQ
TSBpc3N1ZSBpcwpmaXhlZC4KClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFt
ZC5jb20+ClJldmlld2VkLWJ5OiBLZW4gV2FuZyA8UWluZ3FpbmcuV2FuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2ljZWxhbmRfaHdtZ3IuYyB8IDIg
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2ljZWxhbmRfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2ljZWxhbmRfaHdtZ3IuYwppbmRleCBkNTM4ZDI4Li5k
OGNhNTliIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9p
Y2VsYW5kX2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Iv
aWNlbGFuZF9od21nci5jCkBAIC00MjM5LDExICs0MjM5LDkgQEAgaW50IGljZWxhbmRfdW5mb3Jj
ZV9kcG1fbGV2ZWxzKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiB7CiAJaWNlbGFuZF9od21nciAq
ZGF0YSA9IChpY2VsYW5kX2h3bWdyICopKGh3bWdyLT5iYWNrZW5kKTsKIAotI2lmIDAKIAlQUF9B
U1NFUlRfV0lUSF9DT0RFICgwID09IGljZWxhbmRfaXNfZHBtX3J1bm5pbmcoaHdtZ3IpLAogCQki
VHJ5aW5nIHRvIFVuZm9yY2UgRFBNIHdoZW4gRFBNIGlzIGRpc2FibGVkLiBSZXR1cm5pbmcgd2l0
aG91dCBzZW5kaW5nIFNNQyBtZXNzYWdlLiIsCiAJCXJldHVybiAtMSk7Ci0jZW5kaWYKIAogCWlm
ICgwID09IGRhdGEtPnNjbGtfZHBtX2tleV9kaXNhYmxlZCkgewogCQlQUF9BU1NFUlRfV0lUSF9D
T0RFKCgwID09IHNtdW1fc2VuZF9tc2dfdG9fc21jKAotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
