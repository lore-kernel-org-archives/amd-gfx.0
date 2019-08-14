From: Gang Ba <gaba-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] Update VM function point when VM state changed.
Date: Wed, 14 Aug 2019 15:01:45 +0000
Message-ID: <1565794853-25275-1-git-send-email-gaba@amd.com>
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
Cc: "Ba, Gang" <Gang.Ba-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYmNmYWRhNTYwYTAwYzlhZWViZmQ5MjJhZTQ4ZGU5MjBlNDRhNTg2NgpTaWdu
ZWQtb2ZmLWJ5OiBHYW5nIEJhIDxnYWJhQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggYzFiYWYz
ZC4uNzJkZDQzNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTI4
NjIsNiArMjg2MiwxMiBAQCBpbnQgYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sIHVucwogCVdBUk5fT05DRSgodm0t
PnVzZV9jcHVfZm9yX3VwZGF0ZSAmJiAhYW1kZ3B1X2dtY192cmFtX2Z1bGxfdmlzaWJsZSgmYWRl
di0+Z21jKSksCiAJCSAgIkNQVSB1cGRhdGUgb2YgVk0gcmVjb21tZW5kZWQgb25seSBmb3IgbGFy
Z2UgQkFSIHN5c3RlbVxuIik7CiAKKwlpZiAodm0tPnVzZV9jcHVfZm9yX3VwZGF0ZSkKKwkJdm0t
PnVwZGF0ZV9mdW5jcyA9ICZhbWRncHVfdm1fY3B1X2Z1bmNzOworCWVsc2UKKwkJdm0tPnVwZGF0
ZV9mdW5jcyA9ICZhbWRncHVfdm1fc2RtYV9mdW5jczsKKwl2bS0+bGFzdF91cGRhdGUgPSBOVUxM
OworCiAJaWYgKHZtLT5wYXNpZCkgewogCQl1bnNpZ25lZCBsb25nIGZsYWdzOwogCi0tIAoyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
