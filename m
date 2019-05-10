From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] mm/hmm: Only set FAULT_FLAG_ALLOW_RETRY for non-blocking
Date: Fri, 10 May 2019 19:53:24 +0000
Message-ID: <20190510195258.9930-3-Felix.Kuehling@amd.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

RG9uJ3Qgc2V0IHRoaXMgZmxhZyBieSBkZWZhdWx0IGluIGhtbV92bWFfZG9fZmF1bHQuIEl0IGlz
IHNldA0KY29uZGl0aW9uYWxseSBqdXN0IGEgZmV3IGxpbmVzIGJlbG93LiBTZXR0aW5nIGl0IHVu
Y29uZGl0aW9uYWxseQ0KY2FuIGxlYWQgdG8gaGFuZGxlX21tX2ZhdWx0IGRvaW5nIGEgbm9uLWJs
b2NraW5nIGZhdWx0LCByZXR1cm5pbmcNCi1FQlVTWSBhbmQgdW5sb2NraW5nIG1tYXBfc2VtIHVu
ZXhwZWN0ZWRseS4NCg0KU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+DQotLS0NCiBtbS9obW0uYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL21tL2htbS5jIGIvbW0v
aG1tLmMNCmluZGV4IGI2NWMyN2Q1YzExOS4uM2M0ZjFkNjIyMDJmIDEwMDY0NA0KLS0tIGEvbW0v
aG1tLmMNCisrKyBiL21tL2htbS5jDQpAQCAtMzM5LDcgKzMzOSw3IEBAIHN0cnVjdCBobW1fdm1h
X3dhbGsgew0KIHN0YXRpYyBpbnQgaG1tX3ZtYV9kb19mYXVsdChzdHJ1Y3QgbW1fd2FsayAqd2Fs
aywgdW5zaWduZWQgbG9uZyBhZGRyLA0KIAkJCSAgICBib29sIHdyaXRlX2ZhdWx0LCB1aW50NjRf
dCAqcGZuKQ0KIHsNCi0JdW5zaWduZWQgaW50IGZsYWdzID0gRkFVTFRfRkxBR19BTExPV19SRVRS
WSB8IEZBVUxUX0ZMQUdfUkVNT1RFOw0KKwl1bnNpZ25lZCBpbnQgZmxhZ3MgPSBGQVVMVF9GTEFH
X1JFTU9URTsNCiAJc3RydWN0IGhtbV92bWFfd2FsayAqaG1tX3ZtYV93YWxrID0gd2Fsay0+cHJp
dmF0ZTsNCiAJc3RydWN0IGhtbV9yYW5nZSAqcmFuZ2UgPSBobW1fdm1hX3dhbGstPnJhbmdlOw0K
IAlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IHdhbGstPnZtYTsNCi0tIA0KMi4xNy4xDQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
