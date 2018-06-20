From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amd/display: Fix a loop timeout in
 wait_for_fbc_state_changed()
Date: Wed, 20 Jun 2018 15:05:07 +0300
Message-ID: <20180620120507.qztby4wtgehc65f2@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

V2UgY2hhbmdlZCB0aGlzIGxvb3Agc28gbm93IGl0IGxvb3BzIDEwMDAgdGltZXMgaW5zdGVhZCBv
ZiAxMC4gIFdlIG5lZWQKdG8gbWFrZSB0aGUgY291bnRlciBsYXJnZXIgYmVjYXVzZSBhIHVpbnQ4
X3QgY2FuJ3QgZ28gdXAgdG8gMTAwMCBhbmQKd2UgbmVlZCB0byB1cGRhdGUgdGhlIHRlc3QgYXQg
dGhlIGVuZCB0byB0ZXN0IGZvciAxMDAwIGluc3RlYWQgb2YgMTAuCgpGaXhlczogMmI2MTk5YTFk
MWI3ICgiZHJtL2FtZC9kaXNwbGF5OiByZXBsYWNlIG1zbGVlcCB3aXRoIHVkZWxheSBpbiBmYmMg
cGF0aCIpClNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbT4KCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEw
L2RjZTExMF9jb21wcmVzc29yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
MTEwL2RjZTExMF9jb21wcmVzc29yLmMKaW5kZXggZTI5OTRkMzM3MDQ0Li44ZTgzZWM2NmZkMjIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEw
X2NvbXByZXNzb3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEw
L2RjZTExMF9jb21wcmVzc29yLmMKQEAgLTE0Myw3ICsxNDMsNyBAQCBzdGF0aWMgdm9pZCB3YWl0
X2Zvcl9mYmNfc3RhdGVfY2hhbmdlZCgKIAlzdHJ1Y3QgZGNlMTEwX2NvbXByZXNzb3IgKmNwMTEw
LAogCWJvb2wgZW5hYmxlZCkKIHsKLQl1aW50OF90IGNvdW50ZXIgPSAwOworCWludCBjb3VudGVy
ID0gMDsKIAl1aW50MzJfdCBhZGRyID0gbW1GQkNfU1RBVFVTOwogCXVpbnQzMl90IHZhbHVlOwog
CkBAIC0xNTgsNyArMTU4LDcgQEAgc3RhdGljIHZvaWQgd2FpdF9mb3JfZmJjX3N0YXRlX2NoYW5n
ZWQoCiAJCWNvdW50ZXIrKzsKIAl9CiAKLQlpZiAoY291bnRlciA9PSAxMCkgeworCWlmIChjb3Vu
dGVyID09IDEwMDApIHsKIAkJRENfTE9HX1dBUk5JTkcoIiVzOiB3YWl0IGNvdW50ZXIgZXhjZWVk
ZWQsIGNoYW5nZXMgdG8gSFcgbm90IGFwcGxpZWQiLAogCQkJX19mdW5jX18pOwogCX0gZWxzZSB7
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
