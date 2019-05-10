From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] mm/hmm: support automatic NUMA balancing
Date: Fri, 10 May 2019 19:53:23 +0000
Message-ID: <20190510195258.9930-2-Felix.Kuehling@amd.com>
References: <20190510195258.9930-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190510195258.9930-1-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: "jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "alex.deucher-5C7GfCeVMHo@public.gmane.org" <alex.deucher-5C7GfCeVMHo@public.gmane.org>, "airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+DQoNCldoaWxlIHRoZSBwYWdl
IGlzIG1pZ3JhdGluZyBieSBOVU1BIGJhbGFuY2luZywgSE1NIGZhaWxlZCB0byBkZXRlY3QgdGhp
cw0KY29uZGl0aW9uIGFuZCBzdGlsbCByZXR1cm4gdGhlIG9sZCBwYWdlLiBBcHBsaWNhdGlvbiB3
aWxsIHVzZSB0aGUgbmV3DQpwYWdlIG1pZ3JhdGVkLCBidXQgZHJpdmVyIHBhc3MgdGhlIG9sZCBw
YWdlIHBoeXNpY2FsIGFkZHJlc3MgdG8gR1BVLA0KdGhpcyBjcmFzaCB0aGUgYXBwbGljYXRpb24g
bGF0ZXIuDQoNClVzZSBwdGVfcHJvdG5vbmUocHRlKSB0byByZXR1cm4gdGhpcyBjb25kaXRpb24g
YW5kIHRoZW4gaG1tX3ZtYV9kb19mYXVsdA0Kd2lsbCBhbGxvY2F0ZSBuZXcgcGFnZS4NCg0KU2ln
bmVkLW9mZi1ieTogUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+DQotLS0NCiBtbS9o
bW0uYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCg0KZGlmZiAtLWdpdCBhL21tL2htbS5jIGIvbW0vaG1tLmMNCmluZGV4IDc1ZDJlYTkwNmVm
Yi4uYjY1YzI3ZDVjMTE5IDEwMDY0NA0KLS0tIGEvbW0vaG1tLmMNCisrKyBiL21tL2htbS5jDQpA
QCAtNTU0LDcgKzU1NCw3IEBAIHN0YXRpYyBpbnQgaG1tX3ZtYV9oYW5kbGVfcG1kKHN0cnVjdCBt
bV93YWxrICp3YWxrLA0KIA0KIHN0YXRpYyBpbmxpbmUgdWludDY0X3QgcHRlX3RvX2htbV9wZm5f
ZmxhZ3Moc3RydWN0IGhtbV9yYW5nZSAqcmFuZ2UsIHB0ZV90IHB0ZSkNCiB7DQotCWlmIChwdGVf
bm9uZShwdGUpIHx8ICFwdGVfcHJlc2VudChwdGUpKQ0KKwlpZiAocHRlX25vbmUocHRlKSB8fCAh
cHRlX3ByZXNlbnQocHRlKSB8fCBwdGVfcHJvdG5vbmUocHRlKSkNCiAJCXJldHVybiAwOw0KIAly
ZXR1cm4gcHRlX3dyaXRlKHB0ZSkgPyByYW5nZS0+ZmxhZ3NbSE1NX1BGTl9WQUxJRF0gfA0KIAkJ
CQlyYW5nZS0+ZmxhZ3NbSE1NX1BGTl9XUklURV0gOg0KLS0gDQoyLjE3LjENCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
