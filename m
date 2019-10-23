From: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH] dc.c:use kzalloc without test
Date: Wed, 23 Oct 2019 13:35:09 +0000
Message-ID: <fa46cad1-8845-78b7-eb6a-45942813020b@amd.com>
References: <1571819543-15676-1-git-send-email-zhong.shiqi@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1571819543-15676-1-git-send-email-zhong.shiqi@zte.com.cn>
Content-Language: en-US
Content-ID: <F3FA943D0EB68E45B22BDE28854746E9@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: zhongshiqi <zhong.shiqi@zte.com.cn>, "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Lei,
 Jun" <Jun.Lei@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>, "David.Francis@amd.com" <David.Francis@amd.com>, "Liu,
 Wenjing" <Wenjing.Liu@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "cheng.shengyu@zte.com.cn" <cheng.shengyu@zte.com.cn>, "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Aidan.Wood@amd.com" <Aidan.Wood@amd.com>, "xue.zhihong@zte.com.cn" <xue.zhihong@zte.com.cn>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Park, Chris" <Chris.Park@amd.com>, "Yang, Eric" <Eric.Yang2@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Laktyushkin,
 Dmytro" <Dmytro.Laktyushkin@amd.com>, "Deucher,
 Alexander" <Alex>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0xMC0yMyA0OjMyIGEubS4sIHpob25nc2hpcWkgd3JvdGU6DQo+IGRjLmM6NTgzOm51
bGwgY2hlY2sgaXMgbmVlZGVkIGFmdGVyIHVzaW5nIGt6YWxsb2MgZnVuY3Rpb24NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IHpob25nc2hpcWkgPHpob25nLnNoaXFpQHp0ZS5jb20uY24+DQoNClJldmll
d2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCg0KSGFycnkN
Cg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgfCA0
ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYw0KPiBpbmRleCA1ZDFhZGVkLi40Yjg4MTlj
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMNCj4gQEAg
LTU4MCw2ICs1ODAsMTAgQEAgc3RhdGljIGJvb2wgY29uc3RydWN0KHN0cnVjdCBkYyAqZGMsDQo+
ICAjaWZkZWYgQ09ORklHX0RSTV9BTURfRENfRENOMl8wDQo+ICAJLy8gQWxsb2NhdGUgbWVtb3J5
IGZvciB0aGUgdm1faGVscGVyDQo+ICAJZGMtPnZtX2hlbHBlciA9IGt6YWxsb2Moc2l6ZW9mKHN0
cnVjdCB2bV9oZWxwZXIpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWRjLT52bV9oZWxwZXIpIHsN
Cj4gKwkJZG1fZXJyb3IoIiVzOiBmYWlsZWQgdG8gY3JlYXRlIGRjLT52bV9oZWxwZXJcbiIsIF9f
ZnVuY19fKTsNCj4gKwkJZ290byBmYWlsOw0KPiArCX0NCj4gIA0KPiAgI2VuZGlmDQo+ICAJbWVt
Y3B5KCZkYy0+YmJfb3ZlcnJpZGVzLCAmaW5pdF9wYXJhbXMtPmJiX292ZXJyaWRlcywgc2l6ZW9m
KGRjLT5iYl9vdmVycmlkZXMpKTsNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWw=
