From: Trigger Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: Skip IH reroute in Vega10 SR-IOV VF
Date: Tue, 7 May 2019 12:08:34 +0800
Message-ID: <1557202115-24444-2-git-send-email-Trigger.Huang@amd.com>
References: <1557202115-24444-1-git-send-email-Trigger.Huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1557202115-24444-1-git-send-email-Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Trigger.Huang-5C7GfCeVMHo@public.gmane.org

SUggcmVyb3V0ZSBjb21tYW5kcyBhcmUgbm90IHN1cHBvcnRlZCBvbiBWZWdhMTAgVkYKClNpZ25l
ZC1vZmYtYnk6IFRyaWdnZXIgSHVhbmcgPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjNfMS5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvcHNwX3YzXzEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92M18xLmMKaW5k
ZXggMTQzZjBmYS4uOWQ2ZTYwMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvcHNwX3YzXzEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjNfMS5j
CkBAIC0yNjAsNiArMjYwLDEwIEBAIHN0YXRpYyB2b2lkIHBzcF92M18xX3Jlcm91dGVfaWgoc3Ry
dWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3At
PmFkZXY7CiAJdWludDMyX3QgdG1wOwogCisJLyogcmVyb3V0ZV9paCBpcyBub3Qgc3VwcG9ydGVk
IG9uIFNSX0lPViBWRiAqLworCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpCisJCXJldHVybjsK
KwogCS8qIENoYW5nZSBJSCByaW5nIGZvciBWTUMgKi8KIAl0bXAgPSBSRUdfU0VUX0ZJRUxEKDAs
IElIX0NMSUVOVF9DRkdfREFUQSwgQ1JFRElUX1JFVFVSTl9BRERSLCAweDEyNDRiKTsKIAl0bXAg
PSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhfQ0xJRU5UX0NGR19EQVRBLCBDTElFTlRfVFlQRSwgMSk7
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
