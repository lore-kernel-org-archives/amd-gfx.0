From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] tests/amdgpu: Restore return CUE_SUCCESS to
 suite_vcn_tests_clean.
Date: Fri, 15 Dec 2017 13:27:12 -0500
Message-ID: <1513362432-1866-1-git-send-email-andrey.grodzovsky@amd.com>
References: <CACvgo52uH62kzhS1ZDFOyrLiX8vZz5vcSV5P5ujWNwqdQdCi_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo52uH62kzhS1ZDFOyrLiX8vZz5vcSV5P5ujWNwqdQdCi_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

ICAgIGZpeGVzOiA4MDZkMDgwMzYwMDAwMGZhZWNiNDAyNWQ4ZTljNzQ5MGNiMDk3YzI1IChhbWRn
cHU6IFVzZSBuZXcgc3VpdGUvdGVzdCBkaXNhYmxpbmcgZnVuY3Rpb25hbGl0eS4pCiAgICBidWc6
IGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTEwNDI4MAoKU2ln
bmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+
Ci0tLQogdGVzdHMvYW1kZ3B1L3Zjbl90ZXN0cy5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS92Y25fdGVzdHMuYyBiL3Rl
c3RzL2FtZGdwdS92Y25fdGVzdHMuYwppbmRleCA1M2EyZDA4Li45MjI0YmMzIDEwMDY0NAotLS0g
YS90ZXN0cy9hbWRncHUvdmNuX3Rlc3RzLmMKKysrIGIvdGVzdHMvYW1kZ3B1L3Zjbl90ZXN0cy5j
CkBAIC0xNDQsNiArMTQ0LDggQEAgaW50IHN1aXRlX3Zjbl90ZXN0c19jbGVhbih2b2lkKQogCXIg
PSBhbWRncHVfZGV2aWNlX2RlaW5pdGlhbGl6ZShkZXZpY2VfaGFuZGxlKTsKIAlpZiAocikKIAkJ
cmV0dXJuIENVRV9TQ0xFQU5fRkFJTEVEOworCisJcmV0dXJuIENVRV9TVUNDRVNTOwogfQogCiBz
dGF0aWMgaW50IHN1Ym1pdCh1bnNpZ25lZCBuZHcsIHVuc2lnbmVkIGlwKQotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
