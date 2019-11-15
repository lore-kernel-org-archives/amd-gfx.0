From: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/12] tests/amdgpu: add secure buffer allocation test for
 invisible VRAM
Date: Fri, 15 Nov 2019 11:34:47 +0800
Message-ID: <1573788895-3936-4-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Marek.Olsak-5C7GfCeVMHo@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Luben.Tuikov-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Leo.Liu-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KClRoaXMgcGF0Y2ggaXMgdG8gYWRk
IHNlY3VyZSBidWZmZXIgYWxsb2NhdGlvbiB0ZXN0IGZvciBpbnZpc2libGUgVlJBTS4KClNpZ25l
ZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogdGVzdHMvYW1kZ3B1L3Nl
Y3VyaXR5X3Rlc3RzLmMgfCAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jIGIvdGVz
dHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKaW5kZXggYWZlNzllNS4uYTM4MDdlZSAxMDA2NDQK
LS0tIGEvdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKKysrIGIvdGVzdHMvYW1kZ3B1L3Nl
Y3VyaXR5X3Rlc3RzLmMKQEAgLTEwMiw0ICsxMDIsMTQgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Nl
Y3VyaXR5X2FsbG9jX2J1Zl90ZXN0KHZvaWQpCiAKIAlyID0gZ3B1X21lbV9mcmVlKGJvLCB2YV9o
YW5kbGUsIGJvX21jLCA0MDk2KTsKIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7CisKKwkvKiBUZXN0
IHNlY3VyZSBidWZmZXIgYWxsb2NhdGlvbiBpbiBpbnZpc2libGUgVlJBTSAqLworCWJvID0gZ3B1
X21lbV9hbGxvYyhkZXZpY2VfaGFuZGxlLCA0MDk2LCA0MDk2LAorCQkJICAgQU1ER1BVX0dFTV9E
T01BSU5fR1RULAorCQkJICAgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEIHwKKwkJCSAgIEFN
REdQVV9HRU1fQ1JFQVRFX05PX0NQVV9BQ0NFU1MsCisJCQkgICAmYm9fbWMsICZ2YV9oYW5kbGUp
OworCisJciA9IGdwdV9tZW1fZnJlZShibywgdmFfaGFuZGxlLCBib19tYywgNDA5Nik7CisJQ1Vf
QVNTRVJUX0VRVUFMKHIsIDApOwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
