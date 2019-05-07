From: Trigger Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: Skip IH reroute in Vega20 SR-IOV VF
Date: Tue, 7 May 2019 12:08:35 +0800
Message-ID: <1557202115-24444-3-git-send-email-Trigger.Huang@amd.com>
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

SUggcmVyb3V0ZSBjb21tYW5kcyBhcmUgbm90IHN1cHBvcnRlZCBvbiBWZWdhMjAgVkYKClNpZ25l
ZC1vZmYtYnk6IFRyaWdnZXIgSHVhbmcgPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3BzcF92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8wLmMK
aW5kZXggYjkxZGY3Yi4uNGJkZDcwYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvcHNwX3YxMV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3Yx
MV8wLmMKQEAgLTIzMiw2ICsyMzIsMTAgQEAgc3RhdGljIHZvaWQgcHNwX3YxMV8wX3Jlcm91dGVf
aWgoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PSBwc3AtPmFkZXY7CiAJdWludDMyX3QgdG1wOwogCisJLyogcmVyb3V0ZV9paCBpcyBub3Qgc3Vw
cG9ydGVkIG9uIFNSX0lPViBWRiAqLworCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpCisJCXJl
dHVybjsKKwogCS8qIENoYW5nZSBJSCByaW5nIGZvciBWTUMgKi8KIAl0bXAgPSBSRUdfU0VUX0ZJ
RUxEKDAsIElIX0NMSUVOVF9DRkdfREFUQSwgQ1JFRElUX1JFVFVSTl9BRERSLCAweDEyNDRiKTsK
IAl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhfQ0xJRU5UX0NGR19EQVRBLCBDTElFTlRfVFlQ
RSwgMSk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
