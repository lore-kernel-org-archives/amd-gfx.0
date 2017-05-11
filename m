From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] drm/radeon/ci: disable mclk switching for high refresh
 rates
Date: Thu, 11 May 2017 13:58:39 -0400
Message-ID: <1494525521-20864-2-git-send-email-alexander.deucher@amd.com>
References: <1494525521-20864-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1494525521-20864-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

RXZlbiBpZiB0aGUgdmJsYW5rIHBlcmlvZCB3b3VsZCBhbGxvdyBpdCwgaXQgc3RpbGwgc2VlbXMg
dG8KYmUgcHJvYmxlbWF0aWMgb24gc29tZSBjYXJkcy4KCmJ1ZzogaHR0cHM6Ly9idWdzLmZyZWVk
ZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9OTY4NjgKClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL2NpX2RwbS5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2NpX2RwbS5jIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9jaV9kcG0uYwppbmRleCA3YmE0NTA4Li41Y2VkNzMzIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2NpX2RwbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vY2lfZHBtLmMKQEAgLTc3Niw2ICs3NzYsMTIgQEAgYm9vbCBjaV9kcG1fdmJsYW5rX3Rv
b19zaG9ydChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldikKIAl1MzIgdmJsYW5rX3RpbWUgPSBy
NjAwX2RwbV9nZXRfdmJsYW5rX3RpbWUocmRldik7CiAJdTMyIHN3aXRjaF9saW1pdCA9IHBpLT5t
ZW1fZ2RkcjUgPyA0NTAgOiAzMDA7CiAKKwkvKiBkaXNhYmxlIG1jbGsgc3dpdGNoaW5nIGlmIHRo
ZSByZWZyZXNoIGlzID4xMjBIeiwgZXZlbiBpZiB0aGUKKyAgICAgICAgKiBibGFua2luZyBwZXJp
b2Qgd291bGQgYWxsb3cgaXQKKyAgICAgICAgKi8KKwlpZiAocjYwMF9kcG1fZ2V0X3ZyZWZyZXNo
KHJkZXYpID4gMTIwKQorCQlyZXR1cm4gZmFsc2U7CisKIAlpZiAodmJsYW5rX3RpbWUgPCBzd2l0
Y2hfbGltaXQpCiAJCXJldHVybiB0cnVlOwogCWVsc2UKLS0gCjIuNS41CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
