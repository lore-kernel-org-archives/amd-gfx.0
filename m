From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: hide an unused variable
Date: Thu, 19 Sep 2019 13:45:28 +0000
Message-ID: <73842ec4-2767-c918-6ede-d05ff653255c@amd.com>
References: <20190918195418.2042610-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190918195418.2042610-1-arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
Content-ID: <38226A466B92D14284C17B0056D246D3-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhang,
 Dingchen (David)" <Dingchen.Zhang-5C7GfCeVMHo@public.gmane.org>, "Francis,
 David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wOS0xOCAzOjUzIHAubS4sIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IFdpdGhvdXQg
Q09ORklHX0RFQlVHX0ZTLCB3ZSBnZXQgYSB3YXJuaW5nIGZvciBhbiB1bnVzZWQNCj4gdmFyaWFi
bGU6DQo+IA0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYzo2MDIwOjMzOiBlcnJvcjogdW51c2VkIHZhcmlhYmxlICdzb3VyY2UnIFst
V2Vycm9yLC1XdW51c2VkLXZhcmlhYmxlXQ0KPiANCj4gSGlkZSB0aGUgdmFyaWFibGUgaW4gYW4g
I2lmZGVmIGxpa2UgaXRzIG9ubHkgdXNlcnMuDQo+IA0KPiBGaXhlczogMTRiMjU4NDYzNmM2ICgi
ZHJtL2FtZC9kaXNwbGF5OiBhZGQgZnVuY3Rpb25hbGl0eSB0byBncmFiIERQUlggQ1JDIGVudHJp
ZXMuIikNCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCg0K
UmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpI
YXJyeQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYw0KPiBpbmRleCBlMWIwOWJiNDMyYmQuLjc0MjUyZjU3YmFmYiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+IEBA
IC02MDE3LDcgKzYwMTcsOSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG1fZW5hYmxlX2NydGNfaW50
ZXJydXB0cyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiAgCXN0cnVjdCBkcm1fY3J0YyAqY3J0
YzsNCj4gIAlzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKm9sZF9jcnRjX3N0YXRlLCAqbmV3X2NydGNf
c3RhdGU7DQo+ICAJaW50IGk7DQo+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ICAJZW51bSBh
bWRncHVfZG1fcGlwZV9jcmNfc291cmNlIHNvdXJjZTsNCj4gKyNlbmRpZg0KPiAgDQo+ICAJZm9y
X2VhY2hfb2xkbmV3X2NydGNfaW5fc3RhdGUoc3RhdGUsIGNydGMsIG9sZF9jcnRjX3N0YXRlLA0K
PiAgCQkJCSAgICAgIG5ld19jcnRjX3N0YXRlLCBpKSB7DQo+IA0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
