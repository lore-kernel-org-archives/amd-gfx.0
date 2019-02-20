From: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: select ARCH_HAS_HMM and ZONE_DEVICE option
Date: Wed, 20 Feb 2019 18:56:15 +0000
Message-ID: <20190220185544.19602-1-Philip.Yang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>

VGhvc2Ugb3B0aW9ucyBhcmUgbmVlZGVkIHRvIHN1cHBvcnQgSE1NCgpDaGFuZ2UtSWQ6IEllYjdi
YjNiY2VjMDcyNDVkNzlhMDI3OTNlNjcyODIyOGRlY2M0MDBhClNpZ25lZC1vZmYtYnk6IFBoaWxp
cCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L0tjb25maWcgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvS2NvbmZpZyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L0tjb25maWcKaW5kZXggOTYwYTYzMzU1NzA1Li42M2YwNTQyYmMzNGIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L0tjb25maWcKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvS2NvbmZpZwpAQCAtMjYsNyArMjYsOSBAQCBjb25maWcg
RFJNX0FNREdQVV9DSUsKIGNvbmZpZyBEUk1fQU1ER1BVX1VTRVJQVFIKIAlib29sICJBbHdheXMg
ZW5hYmxlIHVzZXJwdHIgd3JpdGUgc3VwcG9ydCIKIAlkZXBlbmRzIG9uIERSTV9BTURHUFUKKwlz
ZWxlY3QgQVJDSF9IQVNfSE1NCiAJc2VsZWN0IEhNTV9NSVJST1IKKwlzZWxlY3QgWk9ORV9ERVZJ
Q0UKIAloZWxwCiAJICBUaGlzIG9wdGlvbiBzZWxlY3RzIENPTkZJR19ITU0gYW5kIENPTkZJR19I
TU1fTUlSUk9SIGlmIGl0CiAJICBpc24ndCBhbHJlYWR5IHNlbGVjdGVkIHRvIGVuYWJsZWQgZnVs
bCB1c2VycHRyIHN1cHBvcnQuCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
