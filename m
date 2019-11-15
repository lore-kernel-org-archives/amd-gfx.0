From: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/12] tests/amdgpu: add secure buffer allocation test for
 system memory
Date: Fri, 15 Nov 2019 11:34:46 +0800
Message-ID: <1573788895-3936-3-git-send-email-aaron.liu@amd.com>
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
IHNlY3VyZSBidWZmZXIgYWxsb2NhdGlvbiB0ZXN0IGZvciBzeXN0ZW0gbWVtb3J5LgoKU2lnbmVk
LW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUvc2Vj
dXJpdHlfdGVzdHMuYyB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMgYi90ZXN0cy9h
bWRncHUvc2VjdXJpdHlfdGVzdHMuYwppbmRleCAxODJiMDNkLi5hZmU3OWU1IDEwMDY0NAotLS0g
YS90ZXN0cy9hbWRncHUvc2VjdXJpdHlfdGVzdHMuYworKysgYi90ZXN0cy9hbWRncHUvc2VjdXJp
dHlfdGVzdHMuYwpAQCAtOTMsNCArOTMsMTMgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3NlY3VyaXR5
X2FsbG9jX2J1Zl90ZXN0KHZvaWQpCiAKIAlyID0gZ3B1X21lbV9mcmVlKGJvLCB2YV9oYW5kbGUs
IGJvX21jLCA0MDk2KTsKIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7CisKKwkvKiBUZXN0IHNlY3Vy
ZSBidWZmZXIgYWxsb2NhdGlvbiBpbiBzeXN0ZW0gbWVtb3J5ICovCisJYm8gPSBncHVfbWVtX2Fs
bG9jKGRldmljZV9oYW5kbGUsIDQwOTYsIDQwOTYsCisJCQkgICBBTURHUFVfR0VNX0RPTUFJTl9H
VFQsCisJCQkgICBBTURHUFVfR0VNX0NSRUFURV9FTkNSWVBURUQsCisJCQkgICAmYm9fbWMsICZ2
YV9oYW5kbGUpOworCisJciA9IGdwdV9tZW1fZnJlZShibywgdmFfaGFuZGxlLCBib19tYywgNDA5
Nik7CisJQ1VfQVNTRVJUX0VRVUFMKHIsIDApOwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
