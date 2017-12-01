From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 19/20] drm/amd/display: Add TODO item to remove vector.c
Date: Fri, 1 Dec 2017 09:25:53 -0500
Message-ID: <20171201142554.11672-20-harry.wentland@amd.com>
References: <20171201142554.11672-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171201142554.11672-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+ClJl
dmlld2VkLWJ5OiBKb3JkYW4gTGF6YXJlIDxKb3JkYW4uTGF6YXJlQGFtZC5jb20+CkFja2VkLWJ5
OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvVE9ETyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L1RPRE8gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvVE9ETwppbmRleCA0NjQ2NDY3OGYyYjMuLjM1N2Q1
OTY0ODQwMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L1RPRE8KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L1RPRE8KQEAgLTEwNSwzICsxMDUsNiBAQCB1
c2VsZXNzIHdpdGggZmlsdGVyaW5nIG91dHB1dC4gZHluYW1pYyBkZWJ1ZyBwcmludGluZyBtaWdo
dCBiZSBhbiBvcHRpb24uCiAyMC4gVXNlIGtlcm5lbCBpMmMgZGV2aWNlIHRvIHByb2dyYW0gSERN
SSByZXRpbWVyLiBTb21lIGJvYXJkcyBoYXZlIGFuIEhETUkKIHJldGltZXIgdGhhdCB3ZSBuZWVk
IHRvIHByb2dyYW0gdG8gcGFzcyBQSFkgY29tcGxpYW5jZS4gQ3VycmVudGx5IHRoYXQncwogYnlw
YXNzaW5nIHRoZSBpMmMgZGV2aWNlIGFuZCBnb2VzIGRpcmVjdGx5IHRvIEhXLiBUaGlzIHNob3Vs
ZCBiZSBjaGFuZ2VkLgorCisyMS4gUmVtb3ZlIHZlY3Rvci5jIGZyb20gZGMvYmFzaWNzLiBJdCdz
IHVzZWQgaW4gRERDIGNvZGUgd2hpY2ggY2FuIHByb2JhYmx5CitiZSBzaW1wbGlmaWVkIGVub3Vn
aCB0byBubyBsb25nZXIgbmVlZCBhIHZlY3RvciBpbXBsZW1lbnRhdGlvbi4KLS0gCjIuMTQuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
