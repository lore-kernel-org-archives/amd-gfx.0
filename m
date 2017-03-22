From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 14/17] drm/amd/display: Set cursor pitch to cursor width (in
 pixels).
Date: Wed, 22 Mar 2017 13:05:01 -0400
Message-ID: <20170322170504.31481-15-harry.wentland@amd.com>
References: <20170322170504.31481-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170322170504.31481-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQW5kcmV5IEdyb2R6b3Zza3kgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+CgpDaGFu
Z2UtSWQ6IEkyZTM3YjAzYzM4YzA3ZDQ0ODE2OWVkNTM0Nzg0Y2UzOGIyNTQxZDc0ClNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPgpSZXZp
ZXdlZC1ieTogSm9yZGFuIExhemFyZSA8Sm9yZGFuLkxhemFyZUBhbWQuY29tPgpSZXZpZXdlZC1i
eTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHlwZXMuYyB8IDIgKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV90eXBlcy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHlwZXMuYwppbmRleCBkMmUyNDg1
YmRmN2EuLjkyOWE0YzhlYTYyZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHlwZXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV90eXBlcy5jCkBAIC05Nyw2ICs5Nyw4IEBAIHN0
YXRpYyB2b2lkIGRtX3NldF9jdXJzb3IoCiAJYXR0cmlidXRlcy5yb3RhdGlvbl9hbmdsZSAgICA9
IDA7CiAJYXR0cmlidXRlcy5hdHRyaWJ1dGVfZmxhZ3MudmFsdWUgPSAwOwogCisJYXR0cmlidXRl
cy5waXRjaCA9IGF0dHJpYnV0ZXMud2lkdGg7CisKIAl4ID0gYW1kZ3B1X2NydGMtPmN1cnNvcl94
OwogCXkgPSBhbWRncHVfY3J0Yy0+Y3Vyc29yX3k7CiAKLS0gCjIuMTEuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
