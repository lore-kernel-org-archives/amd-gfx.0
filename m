From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 13/42] drm/amd/display: Add bios firmware info version for VG12
Date: Wed, 21 Mar 2018 08:46:10 -0500
Message-ID: <20180321134639.18782-13-alexander.deucher@amd.com>
References: <20180321134639.18782-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180321134639.18782-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>

RnJvbTogIkplcnJ5IChGYW5nemhpKSBadW8iIDxKZXJyeS5adW9AYW1kLmNvbT4KClZHMTIgc2hv
d3MgbWlub3IgcmV2aXNpb24gdmVyc2lvbiBvZiAyIHdoaWNoIGlzIG5vdCBoYW5kbGVkIGluCmJp
b3NfcGFyc2VyX2dldF9maXJtd2FyZV9pbmZvKCkgcm91dGluZS4KClNpZ25lZC1vZmYtYnk6IEpl
cnJ5IChGYW5nemhpKSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9iaW9zL2Jpb3NfcGFyc2VyMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2Jpb3MvYmlvc19wYXJzZXIyLmMKaW5kZXggZTc2ODBjNDFmMTE3Li45ODVmZThjMjI4NzUgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2Vy
Mi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2Vy
Mi5jCkBAIC0xMzIxLDYgKzEzMjEsNyBAQCBzdGF0aWMgZW51bSBicF9yZXN1bHQgYmlvc19wYXJz
ZXJfZ2V0X2Zpcm13YXJlX2luZm8oCiAJCWNhc2UgMzoKIAkJCXN3aXRjaCAocmV2aXNpb24ubWlu
b3IpIHsKIAkJCWNhc2UgMToKKwkJCWNhc2UgMjoKIAkJCQlyZXN1bHQgPSBnZXRfZmlybXdhcmVf
aW5mb192M18xKGJwLCBpbmZvKTsKIAkJCQlicmVhazsKIAkJCWRlZmF1bHQ6Ci0tIAoyLjEzLjYK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
