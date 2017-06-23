From: John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 4/9] drm/amdgpu: Don't force BOs into visible VRAM if they can
 go to GTT instead
Date: Fri, 23 Jun 2017 13:39:35 -0400
Message-ID: <1498239580-17360-5-git-send-email-john@fastquake.com>
References: <1498239580-17360-1-git-send-email-john@fastquake.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498239580-17360-1-git-send-email-john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

YW1kZ3B1X3R0bV9wbGFjZW1lbnRfaW5pdCgpIGNhbGxlcnMgdGhhdCBhcmUgdXNpbmcgYm90aCBW
UkFNIGFuZCBHVFQgYXMKZG9tYWlucyB1c3VhbGx5IGRvbid0IHdhbnQgdmlzaWJsZSBWUkFNIGFz
IGEgYnVzeSBwbGFjZW1lbnQuCgpTaWduZWQtb2ZmLWJ5OiBKb2huIEJyb29rcyA8am9obkBmYXN0
cXVha2UuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
YyB8IDEwICsrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5k
ZXggNzUxYmMwNS4uMGZmNTU1YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYwpAQCAtMTM4LDcgKzEzOCwxNSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdHRtX3Bs
YWNlbWVudF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlpZiAoZmxhZ3MgJiBB
TURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMpCiAJCQlwbGFjZXNbY10uZmxhZ3MgfD0g
VFRNX1BMX0ZMQUdfQ09OVElHVU9VUzsKIAotCQlidXN5X3BsYWNlc1tiYysrXSA9IHBsYWNlc1tj
KytdOworCQkvKiBEb24ndCBzZXQgbGltaXRlZCB2aXNpYmxlIFZSQU0gYXMgYSBidXN5IHBsYWNl
bWVudCBpZiB3ZSBjYW4KKwkJICogdXNlIEdUVCBpbnN0ZWFkCisJCSAqLworCQlpZiAoISgoZmxh
Z3MgJiBBTURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEKSAmJgorCQkgICAgICBh
ZGV2LT5tYy52aXNpYmxlX3ZyYW1fc2l6ZSA8IGFkZXYtPm1jLnJlYWxfdnJhbV9zaXplICYmCisJ
CSAgICAgIChkb21haW4gJiBBTURHUFVfR0VNX0RPTUFJTl9HVFQpKSkKKwkJCWJ1c3lfcGxhY2Vz
W2JjKytdID0gcGxhY2VzW2NdOworCisJCWMrKzsKIAl9CiAKIAlpZiAoZG9tYWluICYgQU1ER1BV
X0dFTV9ET01BSU5fR1RUKSB7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
