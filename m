From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 50/54] drm/amd/display: add max scl ratio to soc bounding box
Date: Mon, 9 Jul 2018 20:37:28 -0400
Message-ID: <20180710003732.16836-51-harry.wentland@amd.com>
References: <20180710003732.16836-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180710003732.16836-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KClNp
Z25lZC1vZmYtYnk6IERteXRybyBMYWt0eXVzaGtpbiA8RG15dHJvLkxha3R5dXNoa2luQGFtZC5j
b20+ClJldmlld2VkLWJ5OiBDaGFybGVuZSBMaXUgPENoYXJsZW5lLkxpdUBhbWQuY29tPgpBY2tl
ZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVfc3RydWN0cy5oIHwgMiAr
KwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3N0cnVjdHMuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3N0cnVjdHMuaAppbmRl
eCA2OTQzODAxYzVmZDMuLmM0M2Q2OGJjOWQ1YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVfc3RydWN0cy5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3N0cnVjdHMuaApAQCAtMTEx
LDYgKzExMSw4IEBAIHN0cnVjdCBfdmNzX2RwaV9zb2NfYm91bmRpbmdfYm94X3N0IHsKIAlkb3Vi
bGUgeGZjX2J1c190cmFuc3BvcnRfdGltZV91czsKIAlkb3VibGUgeGZjX3hidWZfbGF0ZW5jeV90
b2xlcmFuY2VfdXM7CiAJaW50IHVzZV91cmdlbnRfYnVyc3RfYnc7CisJZG91YmxlIG1heF9oc2Ns
X3JhdGlvOworCWRvdWJsZSBtYXhfdnNjbF9yYXRpbzsKIAlzdHJ1Y3QgX3Zjc19kcGlfdm9sdGFn
ZV9zY2FsaW5nX3N0IGNsb2NrX2xpbWl0c1s3XTsKIH07CiAKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
