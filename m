From: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: add job->preamble_status back to status value
Date: Tue, 18 Jun 2019 10:31:09 +0000
Message-ID: <1560853789-22977-1-git-send-email-Jack.Xiao@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>

am9iLT5wcmVhbWJsZV9zdGF0dXMgd2FzIGFjY2lkZW50bHkgZHJvcHBlZCBmcm9tIHRoZSBjb21i
aW5hdGlvbiB2YWx1ZQ0Kb2Ygc3RhdHVzIHZhcmFpYWJsZSB3aGljaCBpcyB0aGUgcGFyYW1ldGVy
IG9mIHNvbWUgcmluZyBsZXZlbCBmdW5jdGlvbi4NClRoZSBwYXRjaCBpcyB0byBhZGQgaXQgYmFj
ay4NCg0KU2lnbmVkLW9mZi1ieTogSmFjayBYaWFvIDxKYWNrLlhpYW9AYW1kLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIHwgMSArDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfaWIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
Yi5jDQppbmRleCA5MGNjMDg0Li42ODgyZWViIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2liLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9pYi5jDQpAQCAtMjA4LDYgKzIwOCw3IEBAIGludCBhbWRncHVfaWJfc2NoZWR1bGUo
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1bnNpZ25lZCBudW1faWJzLA0KIA0KIAlza2lwX3By
ZWFtYmxlID0gcmluZy0+Y3VycmVudF9jdHggPT0gZmVuY2VfY3R4Ow0KIAlpZiAoam9iICYmIHJp
bmctPmZ1bmNzLT5lbWl0X2NudHhjbnRsKSB7DQorCQlzdGF0dXMgfD0gam9iLT5wcmVhbWJsZV9z
dGF0dXM7DQogCQlzdGF0dXMgfD0gam9iLT5wcmVlbXB0aW9uX3N0YXR1czsNCiAJCWFtZGdwdV9y
aW5nX2VtaXRfY250eGNudGwocmluZywgc3RhdHVzKTsNCiAJfQ0KLS0gDQoxLjkuMQ0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
