From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/5] drm/amdgpu: Support snooped PTE flag
Date: Wed, 7 Aug 2019 02:31:13 +0000
Message-ID: <1565145062-16674-4-git-send-email-Oak.Zeng@amd.com>
References: <1565145062-16674-1-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565145062-16674-1-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Keely,
 Sean" <Sean.Keely-5C7GfCeVMHo@public.gmane.org>

U2V0IHNub29wZWQgUFRFIGZsYWcgYWNjb3JkaW5nIHRvIG1hcHBpbmcgZmxhZwoKQ2hhbmdlLUlk
OiBJNzk5ZjY4ZWM3YTVhMWFiZjMyMDc1ZjVlZjMxMDUxNjQxYTBiMzczNgpTaWduZWQtb2ZmLWJ5
OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCBhZGFkN2M0Li44YmVlZmFm
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKQEAgLTYzOSw2ICs2MzksOSBA
QCBzdGF0aWMgdWludDY0X3QgZ21jX3Y5XzBfYXJjdHVydXNfZ2V0X3ZtX3B0ZV9mbGFncyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlpZiAoZmxhZ3MgJiBBTURHUFVfVk1fUEFHRV9QUlQp
CiAJCXB0ZV9mbGFnIHw9IEFNREdQVV9QVEVfUFJUOwogCisJaWYgKGZsYWdzICYgQU1ER1BVX1ZN
X1BBR0VfU05PT1BFRCkKKwkJcHRlX2ZsYWcgfD0gQU1ER1BVX1BURV9TTk9PUEVEOworCiAJcmV0
dXJuIHB0ZV9mbGFnOwogfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
