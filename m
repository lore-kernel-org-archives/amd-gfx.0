From: "Sahu, Satyajit" <Satyajit.Sahu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: get the temperature on CZ
Date: Fri, 6 Oct 2017 06:28:16 +0000
Message-ID: <DM5PR12MB1625B61639D9078BBE564589F5710@DM5PR12MB1625.namprd12.prod.outlook.com>
References: <1507270909-25473-1-git-send-email-akshua@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507270909-25473-1-git-send-email-akshua-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>

RnJvbTogU2F0eWFqaXQgU2FodSA8c2F0eWFqaXQuc2FodUBhbWQuY29tPgoKU2V0dGluZyB0aGUg
ZnVuY3Rpb24gcG9pbnRlciB0byB0aGUgZ2V0IHRoZSB0ZW1wZXJhdHVyZSBvbiBDWi4KCkNoYW5n
ZS1JZDogSTFmMzY4NjQ5YTY4NjY5ZjNhYTY5ODhjZTQ5NmI2YzlhOTA5MTYzNTUKU2lnbmVkLW9m
Zi1ieTogU2F0eWFqaXQgU2FodSA8c2F0eWFqaXQuc2FodUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2N6X2h3bWdyLmMgfCAxICsKIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2h3bWdyL2N6X2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9o
d21nci9jel9od21nci5jCmluZGV4IDdmM2IyNGYuLjZiODM3MjQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2N6X2h3bWdyLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvY3pfaHdtZ3IuYwpAQCAtMTk1OSw2ICsxOTU5LDcg
QEAgc3RhdGljIGludCBjel9yZWFkX3NlbnNvcihzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCBpbnQg
aWR4LAogCS5nZXRfY3VycmVudF9zaGFsbG93X3NsZWVwX2Nsb2NrcyA9IGN6X2dldF9jdXJyZW50
X3NoYWxsb3dfc2xlZXBfY2xvY2tzLAogCS5nZXRfY2xvY2tfYnlfdHlwZSA9IGN6X2dldF9jbG9j
a19ieV90eXBlLAogCS5nZXRfbWF4X2hpZ2hfY2xvY2tzID0gY3pfZ2V0X21heF9oaWdoX2Nsb2Nr
cywKKwkuZ2V0X3RlbXBlcmF0dXJlID0gY3pfdGhlcm1hbF9nZXRfdGVtcGVyYXR1cmUsCiAJLnJl
YWRfc2Vuc29yID0gY3pfcmVhZF9zZW5zb3IsCiB9OwogCi0tIAoxLjkuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
