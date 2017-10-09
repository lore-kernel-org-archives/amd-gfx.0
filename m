From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/9] drm/amd/powerplay: add new function point in hwmgr.
Date: Mon, 9 Oct 2017 12:41:59 +0800
Message-ID: <1507524126-28194-2-git-send-email-Rex.Zhu@amd.com>
References: <1507524126-28194-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507524126-28194-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

dXNlZCBmb3Igbm90aWZ5IFNNVSB0aGUgYWxsb2NhdGVkIGJ1ZmZlciBhZGRyZXNzLgoKQ2hhbmdl
LUlkOiBJOTFiYWRjYTc3MjliOGQ5YzM1ZmFmN2ZjMDlkYmRlZTcwYzI2MDk5YQpTaWduZWQtb2Zm
LWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaW5jL2h3bWdyLmggfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9o
d21nci5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2h3bWdyLmgKaW5kZXgg
MTI2YjQ0ZC4uMDA0YTQwZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaW5jL2h3bWdyLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2h3
bWdyLmgKQEAgLTM2Myw2ICszNjMsMTIgQEAgc3RydWN0IHBwX2h3bWdyX2Z1bmMgewogCWludCAo
KnNldF9hY3RpdmVfZGlzcGxheV9jb3VudCkoc3RydWN0IHBwX2h3bWdyICpod21nciwgdWludDMy
X3QgY291bnQpOwogCWludCAoKnNldF9kZWVwX3NsZWVwX2RjZWZjbGspKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IsIHVpbnQzMl90IGNsb2NrKTsKIAlpbnQgKCpzdGFydF90aGVybWFsX2NvbnRyb2xs
ZXIpKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIHN0cnVjdCBQUF9UZW1wZXJhdHVyZVJhbmdlICpy
YW5nZSk7CisJaW50ICgqbm90aWZ5X2NhY19idWZmZXJfaW5mbykoc3RydWN0IHBwX2h3bWdyICpo
d21nciwKKwkJCQkJdWludDMyX3QgdmlydHVhbF9hZGRyX2xvdywKKwkJCQkJdWludDMyX3Qgdmly
dHVhbF9hZGRyX2hpLAorCQkJCQl1aW50MzJfdCBtY19hZGRyX2xvdywKKwkJCQkJdWludDMyX3Qg
bWNfYWRkcl9oaSwKKwkJCQkJdWludDMyX3Qgc2l6ZSk7CiB9OwogCiBzdHJ1Y3QgcHBfdGFibGVf
ZnVuYyB7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
