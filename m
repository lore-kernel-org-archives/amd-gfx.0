From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/14] drm/amd/display: track cursor width in ipp
Date: Fri, 23 Dec 2016 10:57:56 -0500
Message-ID: <20161223155806.12043-5-harry.wentland@amd.com>
References: <20161223155806.12043-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161223155806.12043-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVG9ueSBDaGVuZyA8dG9ueS5jaGVuZ0BhbWQuY29tPgoKQ2hhbmdlLUlkOiBJYTNjZWQx
YjNlY2JiOGU0NDQzYzEwODA4YTdmMWUwODg4ODJkNGYzZgpTaWduZWQtb2ZmLWJ5OiBUb255IENo
ZW5nIDx0b255LmNoZW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBZb25ncWlhbmcgU3VuIDx5b25n
cWlhbmcuc3VuQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8SGFycnkuV2VudGxh
bmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2h3L2lw
cC5oIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9ody9p
cHAuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvaHcvaXBwLmgKaW5kZXgg
ODFkZTk3NTY4ZDExLi5lOWVkMTY3YzllNDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9pbmMvaHcvaXBwLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2luYy9ody9pcHAuaApAQCAtMzUsOCArMzUsMTAgQEAKIC8qIElQUCBSRUxBVEVEICov
CiBzdHJ1Y3QgaW5wdXRfcGl4ZWxfcHJvY2Vzc29yIHsKIAlzdHJ1Y3QgIGRjX2NvbnRleHQgKmN0
eDsKLQl1aW50MzJfdCBpbnN0OworCXVuc2lnbmVkIGludCBpbnN0OwogCWNvbnN0IHN0cnVjdCBp
cHBfZnVuY3MgKmZ1bmNzOworCisJdW5zaWduZWQgaW50IGN1c29yX3dpZHRoOwogfTsKIAogZW51
bSBpcHBfcHJlc2NhbGVfbW9kZSB7Ci0tIAoyLjkuMwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
