From: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amdgpu/uvd:Add uvd enc session bo
Date: Tue, 15 Oct 2019 22:08:07 +0000
Message-ID: <1571177279-9435-2-git-send-email-James.Zhu@amd.com>
References: <1571177279-9435-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1571177279-9435-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>

QWRkIHV2ZCBlbmMgc2Vzc2lvbiBibyBmb3IgdXZkIGVuY29kZSBJQiB0ZXN0LgoKU2lnbmVkLW9m
Zi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdXZkLmggfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXZkLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmgKaW5kZXggNWVi
NjMyOC4uMWUzOWM4YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3V2ZC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuaApA
QCAtNjcsNiArNjcsMTAgQEAgc3RydWN0IGFtZGdwdV91dmQgewogCXVuc2lnbmVkCQloYXJ2ZXN0
X2NvbmZpZzsKIAkvKiBzdG9yZSBpbWFnZSB3aWR0aCB0byBhZGp1c3QgbmIgbWVtb3J5IHN0YXRl
ICovCiAJdW5zaWduZWQJCWRlY29kZV9pbWFnZV93aWR0aDsKKworCXN0cnVjdCBhbWRncHVfYm8g
KmVuY19zZXNzaW9uX2JvOworCXZvaWQJCQkgKmVuY19zZXNzaW9uX2NwdV9hZGRyOworCXVpbnQ2
NF90CQkgIGVuY19zZXNzaW9uX2dwdV9hZGRyOwogfTsKIAogaW50IGFtZGdwdV91dmRfc3dfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
