From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu/display: disable FBC
Date: Mon,  5 Nov 2018 14:27:50 -0500
Message-ID: <20181105192750.14135-2-alexander.deucher@amd.com>
References: <20181105192750.14135-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181105192750.14135-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Q2F1c2VzIGEgYmxhY2sgc2NyZWVuIG9uIFN0b25leSBsYXB0b3AuCgpidWc6IGh0dHBzOi8vYnVn
cy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTEwODU3NwpTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfcmVzb3VyY2UuYyB8IDMgKystCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfcmVzb3VyY2UuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3Jlc291cmNlLmMK
aW5kZXggMWE5MGUxYTM4MDU1Li5hZDU5NDM2YTkxYjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3Jlc291cmNlLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfcmVzb3VyY2UuYwpAQCAtMTM1
NCw3ICsxMzU0LDggQEAgc3RhdGljIGJvb2wgY29uc3RydWN0KAogCQlwb29sLT5iYXNlLnN3X2ky
Y3NbaV0gPSBOVUxMOwogCX0KIAotCWRjLT5mYmNfY29tcHJlc3NvciA9IGRjZTExMF9jb21wcmVz
c29yX2NyZWF0ZShjdHgpOworCS8qIGRpc2FibGUgRkJDIGZvciBub3cgKi8KKwkvKiBkYy0+ZmJj
X2NvbXByZXNzb3IgPSBkY2UxMTBfY29tcHJlc3Nvcl9jcmVhdGUoY3R4KTsgKi8KIAogCWlmICgh
dW5kZXJsYXlfY3JlYXRlKGN0eCwgJnBvb2wtPmJhc2UpKQogCQlnb3RvIHJlc19jcmVhdGVfZmFp
bDsKLS0gCjIuMTMuNgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
