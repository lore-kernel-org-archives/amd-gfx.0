From: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Add DC feature mask to disable fractional
 pwm
Date: Wed, 23 Oct 2019 15:53:48 +0000
Message-ID: <5c7732e1-9a6a-7b27-9f26-779082d94460@amd.com>
References: <20191021193743.24339-1-sunpeng.li@amd.com>
 <20191021194414.24627-1-sunpeng.li@amd.com>
 <eb513969cc86a42a9be95e4ff7f3473eb24d6d4a.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <eb513969cc86a42a9be95e4ff7f3473eb24d6d4a.camel@gmail.com>
Content-Language: en-US
Content-ID: <D1F39321369B3648B71F3203E3E07F26@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?utf-8?B?THVrw6HFoSBLcmVqxI3DrQ==?= <lskrejci@gmail.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "Koo, Anthony" <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0xMC0yMyAxMDoxOSBhLm0uLCBMdWvDocWhIEtyZWrEjcOtIHdyb3RlOg0KPiBPbiBN
b24sIDIwMTktMTAtMjEgYXQgMTU6NDQgLTA0MDAsIHN1bnBlbmcubGlAYW1kLmNvbSB3cm90ZToN
Cj4+IEZyb206IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPg0KPj4NCj4+IFtXaHldDQo+Pg0K
Pj4gU29tZSBMRUQgcGFuZWwgZHJpdmVycyBtaWdodCBub3QgbGlrZSBmcmFjdGlvbmFsIFBXTS4g
SW4gc3VjaCBjYXNlcywNCj4+IGJhY2tsaWdodCBmbGlja2VyaW5nIG1heSBiZSBvYnNlcnZlZC4N
Cj4+DQo+PiBbSG93XQ0KPj4NCj4+IEFkZCBhIERDIGZlYXR1cmUgbWFzayB0byBkaXNhYmxlIGZy
YWN0aW9uYWwgUFdNLCBhbmQgYXNzb2NpYXRlIGl0IHdpdGgNCj4+IHRoZSBwcmVleGlzdGluZyBk
Y19jb25maWcgZmxhZy4NCj4+DQo+PiBUaGUgZmxhZyBpcyBvbmx5IHBsdW1iZWQgdGhyb3VnaCB0
aGUgZG1jdSBmaXJtd2FyZSwgc28gcGx1bWIgaXQgdGhyb3VnaA0KPj4gdGhlIGRyaXZlciBwYXRo
IGFzIHdlbGwuDQo+Pg0KPj4gVG8gZGlzYWJsZSwgYWRkIHRoZSBmb2xsb3dpbmcgdG8gdGhlIGxp
bnV4IGNtZGxpbmU6DQo+PiBhbWRncHUuZGNmZWF0dXJlbWFzaz0weDQNCj4+DQo+PiBCdWd6aWxs
YTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDQ5NTcNCj4+
IFNpZ25lZC1vZmYtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPg0KPj4gLS0tDQo+Pg0K
Pj4gdjI6IEFkZCBidWd6aWxsYSBsaW5rDQo+Pg0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzICsrKw0KPj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UvZGNlX2FibS5jICAgICAgfCA0ICsrKysNCj4+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oICAgICAgICAgIHwgMSArDQo+PiAgMyBmaWxl
cyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IFRlc3RlZCBvbiBVYnVudHUgMTkuMDQs
IHZhbmlsbGEgdjUuMy43IGtlcm5lbCB3aXRoIHRoZSBwYXRjaCBhcHBsaWVkDQo+IGFuZCBhbWRn
cHUuZGNmZWF0dXJlbWFzaz0weDQgYWRkZWQgdG8gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUsIG5v
DQo+IGlzc3VlcyBhZnRlciA4IHJlYm9vdHMuIChUaGUgaXNzdWUgY291bGQgYmUgcmVwcm9kdWNl
ZCB3aXRob3V0DQo+IGFtZGdwdS5kY2ZlYXR1cmVtYXNrPTB4NCBvbiBmaXJzdCBib290LikNCj4g
DQo+IFRlc3RlZC1ieTogTHVrw6HFoSBLcmVqxI3DrSA8bHNrcmVqY2lAZ21haWwuY29tPg0KDQpB
cHBsaWVkLCB0aGFua3MhDQpMZW8NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbA==
