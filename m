From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 30/30] drm/amd/display: Expose dpp1_set_cursor_attributes
Date: Wed, 13 Dec 2017 17:35:02 -0500
Message-ID: <20171213223502.25224-31-harry.wentland@amd.com>
References: <20171213223502.25224-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171213223502.25224-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Yue Hin Lau <Yuehin.Lau-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWXVlIEhpbiBMYXUgPFl1ZWhpbi5MYXVAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6IFl1
ZSBIaW4gTGF1IDxZdWVoaW4uTGF1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxU
b255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxh
bmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNu
MTBfZHBwLmggfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfZHBwLmgg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfZHBwLmgKaW5kZXgg
NjQwZWRmYTA1Yzk0Li5mNTZlZTRkMDhkODkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9kcHAuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfZHBwLmgKQEAgLTEyODMsNiArMTI4MywxMCBAQCBlbnVt
IGRjbjEwX2lucHV0X2NzY19zZWxlY3QgewogCUlOUFVUX0NTQ19TRUxFQ1RfQ09NQQogfTsKIAor
dm9pZCBkcHAxX3NldF9jdXJzb3JfYXR0cmlidXRlcygKKwkJc3RydWN0IGRwcCAqZHBwX2Jhc2Us
CisJCWVudW0gZGNfY3Vyc29yX2NvbG9yX2Zvcm1hdCBjb2xvcl9mb3JtYXQpOworCiBib29sIGRw
cDFfZHNjbF9pc19sYl9jb25mX3ZhbGlkKAogCQlpbnQgY2VpbF92cmF0aW8sCiAJCWludCBudW1f
cGFydGl0aW9ucywKLS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
