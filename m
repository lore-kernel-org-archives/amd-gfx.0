From: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/5] drm/amdgpu: enable TMZ bit in sdma copy pkt for sdma v5
Date: Mon, 18 Nov 2019 13:18:35 +0800
Message-ID: <1574054316-2802-4-git-send-email-aaron.liu@amd.com>
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574054316-2802-1-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Luben.Tuikov-5C7GfCeVMHo@public.gmane.org, Ray.Huang-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>

RW5hYmxlIHNkbWEgVE1aIG1vZGUgdmlhIHNldHRpbmcgVE1aIGJpdCBpbiBzZG1hIGNvcHkgcGt0
CmZvciBzZG1hIHY1LgoKU2lnbmVkLW9mZi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYyB8IDMgKystCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwppbmRleCBiNmE3MWE3Li42NGM1M2VlIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwpAQCAtMTY2NCw3ICsxNjY0LDggQEAgc3Rh
dGljIHZvaWQgc2RtYV92NV8wX2VtaXRfY29weV9idWZmZXIoc3RydWN0IGFtZGdwdV9pYiAqaWIs
CiAJCQkJICAgICAgIGJvb2wgdG16KQogewogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IFNE
TUFfUEtUX0hFQURFUl9PUChTRE1BX09QX0NPUFkpIHwKLQkJU0RNQV9QS1RfSEVBREVSX1NVQl9P
UChTRE1BX1NVQk9QX0NPUFlfTElORUFSKTsKKwkJU0RNQV9QS1RfSEVBREVSX1NVQl9PUChTRE1B
X1NVQk9QX0NPUFlfTElORUFSKSB8CisJCVNETUFfUEtUX0NPUFlfTElORUFSX0hFQURFUl9UTVoo
dG16ID8gMSA6IDApOwogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IGJ5dGVfY291bnQgLSAx
OwogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IDA7IC8qIHNyYy9kc3QgZW5kaWFuIHN3YXAg
Ki8KIAlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSBsb3dlcl8zMl9iaXRzKHNyY19vZmZzZXQp
OwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
