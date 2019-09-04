From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/10] drm/amdkfd: add renoir typs for the workaround of iommu
 v2
Date: Wed, 4 Sep 2019 15:48:28 +0000
Message-ID: <20190904154803.5102-5-ray.huang@amd.com>
References: <20190904154803.5102-1-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190904154803.5102-1-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

UmVub2lyIGlzIHRoZSBzYW1lIHdpdGggUmF2ZW4sIHdpbGwgZW5hYmxlIGlvbW11IGV2ZW50IGlu
IGZ1dHVyZS4KClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jIHwgMyArKy0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMKaW5kZXggM2UyMmZhMy4uYmIzYTY0MiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYwpAQCAtOTg3LDcgKzk4Nyw4IEBAIHZvaWQg
a2ZkX3NpZ25hbF9pb21tdV9ldmVudChzdHJ1Y3Qga2ZkX2RldiAqZGV2LCB1bnNpZ25lZCBpbnQg
cGFzaWQsCiAJICogYmVmb3JlIElPTU1VIGlzIGFibGUgdG8gZmluaXNoIHByb2Nlc3NpbmcgYWxs
IHRoZSBleGNlc3NpdmUgUFBScwogCSAqIHRyaWdnZXJlZCBkdWUgdG8gSFcgZmxhd3MuCiAJICov
Ci0JaWYgKGRldi0+ZGV2aWNlX2luZm8tPmFzaWNfZmFtaWx5ICE9IENISVBfUkFWRU4pIHsKKwlp
ZiAoZGV2LT5kZXZpY2VfaW5mby0+YXNpY19mYW1pbHkgIT0gQ0hJUF9SQVZFTiB8fAorCSAgICBk
ZXYtPmRldmljZV9pbmZvLT5hc2ljX2ZhbWlseSAhPSBDSElQX1JFTk9JUikgewogCQltdXRleF9s
b2NrKCZwLT5ldmVudF9tdXRleCk7CiAKIAkJLyogTG9va3VwIGV2ZW50cyBieSB0eXBlIGFuZCBz
aWduYWwgdGhlbSAqLwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
