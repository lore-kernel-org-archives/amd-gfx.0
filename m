From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix parser init error path to avoid crash in
 parser fini
Date: Fri, 10 Mar 2017 12:13:04 +1000
Message-ID: <20170310021304.13391-1-airlied@gmail.com>
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

RnJvbTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KCklmIHdlIGRvbid0IHJlc2V0
IHRoZSBjaHVuayBpbmZvIGluIHRoZSBlcnJvciBwYXRoLCB0aGUgc3Vic2VxdWVudApmaW5pIHBh
dGggd2lsbCBkb3VibGUgZnJlZS4KClNpZ25lZC1vZmYtYnk6IERhdmUgQWlybGllIDxhaXJsaWVk
QHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMg
fCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3MuYwppbmRleCBkMmQwZjYwLi45OTQyNGNiIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwpAQCAtMjQwLDYgKzI0MCw4IEBAIGludCBhbWRncHVf
Y3NfcGFyc2VyX2luaXQoc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnAsIHZvaWQgKmRhdGEpCiAJ
Zm9yICg7IGkgPj0gMDsgaS0tKQogCQlkcm1fZnJlZV9sYXJnZShwLT5jaHVua3NbaV0ua2RhdGEp
OwogCWtmcmVlKHAtPmNodW5rcyk7CisJcC0+Y2h1bmtzID0gTlVMTDsKKwlwLT5uY2h1bmtzID0g
MDsKIHB1dF9jdHg6CiAJYW1kZ3B1X2N0eF9wdXQocC0+Y3R4KTsKIGZyZWVfY2h1bms6Ci0tIAoy
LjkuMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
