From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/4] share semaphore across process
Date: Thu, 18 Aug 2016 15:55:55 +0800
Message-ID: <1471506959-905-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David.Mao-5C7GfCeVMHo@public.gmane.org

YWZ0ZXIgY3R4IGlkIGlzIHZhbGlkIGluIGdsb2JhbCBzaWRlLCB3ZSBzaGFyZSBzZW1hcGhvcmUg
YWNyb3NzIHByb2Nlc3MgYmFzZWQgb24gQk8gc2hhcmluZyBtZWNoYW5pc20uClRoYXQgbWVhbnMg
d2UgbWFwIHNlbWFwaG9yZSBvYmplY3QgdG8gYSBibywgdGhlbiBzaGFyaW5nIGJvIHdpdGggb3Ro
ZXIgcHJvY2VzcywgdGhlIG90aGVyIHByb2Nlc3MgY2FuCmdldCB0aGUgc2VtYXBob3JlIG9iamVj
dCBmcm9tIHRoZSBzaGFyaW5nIGJvLgoKQ2h1bm1pbmcgWmhvdSAoNCk6CiAgYW1kZ3B1OiB1c2Ug
ZHJtX2FtZGdwdV9mZW5jZSBpbnN0ZWFkIG9mIGFtZGdwdV9jc19mZW5jZSBpbiBzZW1hcGhvcmUK
ICAgIHN0cnVjdHVyZQogIGFtZGdwdTogYWRkIGV4cG9ydC9pbXBvcnQgc2VtYXBob3JlIGFwaXMK
ICBhbWRncHU6IGFkZCBtdXRleCBmb3IgYWNyb3NzIHByb2Nlc3MgcmVhc29uCiAgdGVzdHMvYW1k
Z3B1OiBhZGQgc2VtYXBob3JlIGFjcm9zcyBwcm9jZXNzIHRlc3QKCiBhbWRncHUvYW1kZ3B1Lmgg
ICAgICAgICAgICB8ICA0MCArKysrKysrKysrKysrKwogYW1kZ3B1L2FtZGdwdV9jcy5jICAgICAg
ICAgfCAxMTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KIGFtZGdwdS9h
bWRncHVfaW50ZXJuYWwuaCAgIHwgICA2ICsrLQogdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMg
fCAxMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA0IGZp
bGVzIGNoYW5nZWQsIDI3MyBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCi0tIAoxLjku
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
