From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/6] drm/amdgpu: report more sdma amdgpu_fence_info
Date: Wed, 31 Oct 2018 20:25:32 +0800
Message-ID: <1540988736-14311-2-git-send-email-Rex.Zhu@amd.com>
References: <1540988736-14311-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540988736-14311-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

VGhpcyBjYW4gaGVscCBjaGVja2luZyBNQ0JQIGZlYXR1cmUgb24gc2RtYS4KCklmIHByZWVtcHRp
b24gb2NjdXJyZWQgaW4gdGhlCnByZXZpb3VzIElCIHRoZSBhZGRyZXNzIGlzIGFkanVzdGVkIGJ5
IDIgRFdzLgoKU2lnbmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgMyArKy0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCmluZGV4IDU0NDhjZjIuLmFhNzQxNWMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCkBAIC02NzksNyArNjc5LDggQEAg
c3RhdGljIGludCBhbWRncHVfZGVidWdmc19mZW5jZV9pbmZvKHN0cnVjdCBzZXFfZmlsZSAqbSwg
dm9pZCAqZGF0YSkKIAkJc2VxX3ByaW50ZihtLCAiTGFzdCBlbWl0dGVkICAgICAgICAweCUwOHhc
biIsCiAJCQkgICByaW5nLT5mZW5jZV9kcnYuc3luY19zZXEpOwogCi0JCWlmIChyaW5nLT5mdW5j
cy0+dHlwZSAhPSBBTURHUFVfUklOR19UWVBFX0dGWCkKKwkJaWYgKHJpbmctPmZ1bmNzLT50eXBl
ICE9IEFNREdQVV9SSU5HX1RZUEVfR0ZYICYmCisJCQlyaW5nLT5mdW5jcy0+dHlwZSAhPSBBTURH
UFVfUklOR19UWVBFX1NETUEpCiAJCQljb250aW51ZTsKIAogCQkvKiBzZXQgaW4gQ1BfVk1JRF9Q
UkVFTVBUIGFuZCBwcmVlbXB0aW9uIG9jY3VycmVkICovCi0tIAoxLjkuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
