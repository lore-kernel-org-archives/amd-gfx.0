From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdkfd: Print more sdma engine hqds in debug fs
Date: Fri, 4 Oct 2019 14:48:49 +0000
Message-ID: <1570200515-18992-2-git-send-email-Oak.Zeng@amd.com>
References: <1570200515-18992-1-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1570200515-18992-1-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Kim,
 Jonathan" <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>, "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>

UHJldmlvdXNseSBvbmx5IFBDSWUtb3B0aW1pemVkIFNETUEgZW5naW5lIGhxZHMgd2VyZQpleHBv
c2VkIGluIGRlYnVnIGZzLiBQcmludCBhbGwgU0RNQSBlbmdpbmUgaHFkcy4KCkNoYW5nZS1JZDog
STAzNzU2ZmMwZmE5OTE2OWQ4OGUyNjU1NjBmNTA1ZWQxODYyNDJiMDIKUmVwb3J0ZWQtYnk6IEpv
bmF0aGFuIEtpbSA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEpvbmF0aGFu
IEtpbSA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsu
WmVuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2Vf
cXVldWVfbWFuYWdlci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwppbmRleCBlNTVkMDIxLi4wZWJjNjA0IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIu
YwpAQCAtMjQxNiw3ICsyNDE2LDcgQEAgaW50IGRxbV9kZWJ1Z2ZzX2hxZHMoc3RydWN0IHNlcV9m
aWxlICptLCB2b2lkICpkYXRhKQogCQl9CiAJfQogCi0JZm9yIChwaXBlID0gMDsgcGlwZSA8IGdl
dF9udW1fc2RtYV9lbmdpbmVzKGRxbSk7IHBpcGUrKykgeworCWZvciAocGlwZSA9IDA7IHBpcGUg
PCBnZXRfbnVtX3NkbWFfZW5naW5lcyhkcW0pICsgZ2V0X251bV94Z21pX3NkbWFfZW5naW5lcyhk
cW0pOyBwaXBlKyspIHsKIAkJZm9yIChxdWV1ZSA9IDA7CiAJCSAgICAgcXVldWUgPCBkcW0tPmRl
di0+ZGV2aWNlX2luZm8tPm51bV9zZG1hX3F1ZXVlc19wZXJfZW5naW5lOwogCQkgICAgIHF1ZXVl
KyspIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
