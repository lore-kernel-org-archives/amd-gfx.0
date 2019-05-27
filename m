From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 19/26] drm/amd/display: Add writeback_config to VBA vars
Date: Mon, 27 May 2019 15:50:58 -0400
Message-ID: <1558986665-12964-20-git-send-email-sunpeng.li@amd.com>
References: <1558986665-12964-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1558986665-12964-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Ilya Bakoulin <Ilya.Bakoulin-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSWx5YSBCYWtvdWxpbiA8SWx5YS5CYWtvdWxpbkBhbWQuY29tPgoKQWRkaW5nIHdyaXRl
YmFja19jb25maWcgZW51bSB0byB2YmFfdmFyc19zdCwgcmVwbGFjaW5nIG9sZCBmbGFnLgpJbml0
aWFsaXplIHRvIGRtX25vcm1hbC4KClNpZ25lZC1vZmYtYnk6IElseWEgQmFrb3VsaW4gPElseWEu
QmFrb3VsaW5AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENoYXJsZW5lIExpdSA8Q2hhcmxlbmUuTGl1
QGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV9lbnVtcy5oIHwgNiAr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV9lbnVtcy5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVfZW51bXMuaAppbmRl
eCBjNTllNTgyLi4xNzRjNDE0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV9lbnVtcy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX2VudW1zLmgKQEAgLTE0Nyw0ICsxNDcsMTAgQEAg
ZW51bSBkbV92YWxpZGF0aW9uX3N0YXR1cyB7CiAJRE1MX0ZBSUxfVl9SQVRJT19QUkVGRVRDSCwK
IH07CiAKK2VudW0gd3JpdGViYWNrX2NvbmZpZyB7CisJZG1fbm9ybWFsLAorCWRtX3dob2xlX2J1
ZmZlcl9mb3Jfc2luZ2xlX3N0cmVhbV9ub19pbnRlcmxlYXZlLAorCWRtX3dob2xlX2J1ZmZlcl9m
b3Jfc2luZ2xlX3N0cmVhbV9pbnRlcmxlYXZlLAorfTsKKwogI2VuZGlmCi0tIAoyLjcuNAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
