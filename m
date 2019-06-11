From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Add CHIP_VEGAM to amdgpu_amdkfd_device_probe
Date: Tue, 11 Jun 2019 12:44:10 +0000
Message-ID: <20190611124400.13823-1-kent.russell@amd.com>
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
Cc: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

V2UgaGF2ZSB0aGUgcmVzdCBvZiB0aGUgc3VwcG9ydCBpbiB0aGUga2VybmUsIGJ1dCB3ZSBkb24n
dCBhY3R1YWxseSBib290IEtGRA0Kb24gdGhlIGRldmljZSB3aXRob3V0IHRoaXMgY2hhbmdlDQoN
CkNoYW5nZS1JZDogSWZjYzVjNWUwNThkNzJlMzNhMmYzZjk0NWYyNjliYTZkMjYxM2I3YjANClNp
Z25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5jb20+DQotLS0NCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCAxICsNCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuYw0KaW5kZXggNGFmMzk4OWU0YTc1Li5iNzU4MmI5YWExY2QgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYw0KQEAgLTc4LDYgKzc4LDcg
QEAgdm9pZCBhbWRncHVfYW1ka2ZkX2RldmljZV9wcm9iZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCiAJY2FzZSBDSElQX1BPTEFSSVMxMDoNCiAJY2FzZSBDSElQX1BPTEFSSVMxMToNCiAJ
Y2FzZSBDSElQX1BPTEFSSVMxMjoNCisJY2FzZSBDSElQX1ZFR0FNOg0KIAkJa2ZkMmtnZCA9IGFt
ZGdwdV9hbWRrZmRfZ2Z4XzhfMF9nZXRfZnVuY3Rpb25zKCk7DQogCQlicmVhazsNCiAJY2FzZSBD
SElQX1ZFR0ExMDoNCi0tIA0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
