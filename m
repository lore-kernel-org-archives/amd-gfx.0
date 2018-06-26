From: rex zhu <rezhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/display: Fix dm-pp clks type convert error
Date: Tue, 26 Jun 2018 13:53:15 +0800
Message-ID: <1529992395-8694-2-git-send-email-rezhu@amd.com>
References: <1529992395-8694-1-git-send-email-rezhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1529992395-8694-1-git-send-email-rezhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: rex zhu <rezhu-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Zml4IGEgdHlwbyB3aGVuIGNvbnZlcnQgZGlzcGxheXBoeWNsayB0eXBlLgoKU2lnbmVkLW9mZi1i
eTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jCmluZGV4IDJhY2JjYzcuLmNmOTJkN2Eg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtX3BwX3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtX3BwX3NtdS5jCkBAIC0xNjcsNiArMTY3LDkgQEAgc3RhdGljIGVudW0gYW1kX3Bw
X2Nsb2NrX3R5cGUgZGNfdG9fcHBfY2xvY2tfdHlwZSgKIAkJYW1kX3BwX2Nsa190eXBlID0gYW1k
X3BwX2ZfY2xvY2s7CiAJCWJyZWFrOwogCWNhc2UgRE1fUFBfQ0xPQ0tfVFlQRV9ESVNQTEFZUEhZ
Q0xLOgorCQlhbWRfcHBfY2xrX3R5cGUgPSBhbWRfcHBfcGh5X2Nsb2NrOworCQlicmVhazsKKwlj
YXNlIERNX1BQX0NMT0NLX1RZUEVfRFBQQ0xLOgogCQlhbWRfcHBfY2xrX3R5cGUgPSBhbWRfcHBf
ZHBwX2Nsb2NrOwogCQlicmVhazsKIAlkZWZhdWx0OgotLSAKMS45LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
