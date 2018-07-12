From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/6] drm/amdkfd: Avoid flooding dmesg on Raven due to IOMMU
 issues
Date: Thu, 12 Jul 2018 17:24:51 -0400
Message-ID: <1531430694-23966-4-git-send-email-Felix.Kuehling@amd.com>
References: <1531430694-23966-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1531430694-23966-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWW9uZyBaaGFvIDx5b25nLnpoYW9AYW1kLmNvbT4KCk9uIFJhdmVuIEludmFsaWQgUFBS
cyBjYW4gYmUgcmVwb3J0ZWQgYmVjYXVzZSBtdWx0aXBsZSBQUFJzIGNhbiBiZQpzdGlsbCBxdWV1
ZWQgd2hlbiBtZW1vcnkgaXMgZnJlZWQuIEFwcGx5IGEgcmF0ZSBsaW1pdCB0byBhdm9pZApmbG9v
ZGluZyB0aGUgbG9nIGluIHRoaXMgY2FzZS4KClNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8eW9u
Zy56aGFvQGFtZC5jb20+ClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5n
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2lvbW11LmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW9tbXUuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pb21tdS5jCmluZGV4IGM3MTgxNzkuLjdhNjFmMzggMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pb21tdS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pb21tdS5jCkBAIC0xOTAsNyArMTkwLDcgQEAg
c3RhdGljIGludCBpb21tdV9pbnZhbGlkX3Bwcl9jYihzdHJ1Y3QgcGNpX2RldiAqcGRldiwgaW50
IHBhc2lkLAogewogCXN0cnVjdCBrZmRfZGV2ICpkZXY7CiAKLQlkZXZfd2FybihrZmRfZGV2aWNl
LAorCWRldl93YXJuX3JhdGVsaW1pdGVkKGtmZF9kZXZpY2UsCiAJCQkiSW52YWxpZCBQUFIgZGV2
aWNlICV4OiV4LiV4IHBhc2lkICVkIGFkZHJlc3MgMHglbFggZmxhZ3MgMHglWCIsCiAJCQlQQ0lf
QlVTX05VTShwZGV2LT5kZXZmbiksCiAJCQlQQ0lfU0xPVChwZGV2LT5kZXZmbiksCi0tIAoyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
