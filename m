From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/6] drm/amdkfd: Avoid flooding dmesg on Raven due to IOMMU
 issues
Date: Fri, 13 Jul 2018 16:17:45 -0400
Message-ID: <1531513068-3805-4-git-send-email-Felix.Kuehling@amd.com>
References: <1531513068-3805-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1531513068-3805-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
cyAocGVyaXBoZXJhbCBwYWdlIHJlcXVlc3RzKSBjYW4gYmUgcmVwb3J0ZWQKYmVjYXVzZSBtdWx0
aXBsZSBQUFJzIGNhbiBiZSBzdGlsbCBxdWV1ZWQgd2hlbiBtZW1vcnkgaXMgZnJlZWQuCkFwcGx5
IGEgcmF0ZSBsaW1pdCB0byBhdm9pZCBmbG9vZGluZyB0aGUgbG9nIGluIHRoaXMgY2FzZS4KClNp
Z25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8eW9uZy56aGFvQGFtZC5jb20+ClJldmlld2VkLWJ5OiBG
ZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogRmVs
aXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CkFja2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2lvbW11LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfaW9tbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pb21tdS5jCmluZGV4
IGM3MTgxNzkuLjdhNjFmMzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9pb21tdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pb21tdS5j
CkBAIC0xOTAsNyArMTkwLDcgQEAgc3RhdGljIGludCBpb21tdV9pbnZhbGlkX3Bwcl9jYihzdHJ1
Y3QgcGNpX2RldiAqcGRldiwgaW50IHBhc2lkLAogewogCXN0cnVjdCBrZmRfZGV2ICpkZXY7CiAK
LQlkZXZfd2FybihrZmRfZGV2aWNlLAorCWRldl93YXJuX3JhdGVsaW1pdGVkKGtmZF9kZXZpY2Us
CiAJCQkiSW52YWxpZCBQUFIgZGV2aWNlICV4OiV4LiV4IHBhc2lkICVkIGFkZHJlc3MgMHglbFgg
ZmxhZ3MgMHglWCIsCiAJCQlQQ0lfQlVTX05VTShwZGV2LT5kZXZmbiksCiAJCQlQQ0lfU0xPVChw
ZGV2LT5kZXZmbiksCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
