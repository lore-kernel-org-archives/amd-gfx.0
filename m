From: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/3] always enable PCIE atomics
Date: Wed, 29 May 2019 06:32:11 +0000
Message-ID: <1559111516-21940-1-git-send-email-Jack.Xiao@amd.com>
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
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>

R1BVIGF0b21pY3Mgb3BlcmF0aW9uIGRlcGVuZHMgb24gUENJRSBhdG9taWNzIHN1cHBvcnQuDQpB
bHdheXMgZW5hYmxlIFBDSUUgYXRvbWljcyBvcHMgc3VwcG9ydCBpbiBjYXNlIHRoYXQNCml0IGhh
c24ndCBiZWVuIGVuYWJsZWQuDQoNCkFkZCBmaWVsZCB0byBhbWRncHUgZGV2aWNlLCB0aGF0IGNh
biBiZSBleHBvc2VkIHRvIFVNRCBvcg0Ka2ZkIGluZGljYXRpbmcgd2hldGhlciB0aGUgc3lzdGVt
IGhhcyBQQ0lFIGF0b21pY3Mgc3VwcG9ydC4NCg0KSmFjayBYaWFvICgzKToNCiAgZHJtL2FtZGdw
dTogYWRkIGZpZWxkIGluZGljYXRpbmcgaWYgaGFzIFBDSUUgYXRvbWljcyBzdXBwb3J0DQogIGRy
bS9hbWRncHU6IGVuYWJsZSBQQ0lFIGF0b21pY3Mgb3BzIHN1cHBvcnQNCiAgZHJtL2FtZGtmZDog
cmVtb3ZlIGR1cGxpY2F0ZWQgUENJRSBhdG9taWNzIHJlcXVlc3QNCg0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCAgNyArKysrKysrDQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIHwgIDEgKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYyB8IDExICsrKysrKysrKysrDQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZS5jICAgIHwgMTAgKysrKy0tLS0tLQ0KIDUgZmlsZXMgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KLS0gDQoxLjkuMQ0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
