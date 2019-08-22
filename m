From: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH][drm-next] drm/amd/display: fix a potential null pointer
 dereference
Date: Thu, 22 Aug 2019 19:21:12 +0000
Message-ID: <5981f677-3347-1450-f787-853e97496bd4@amd.com>
References: <20190816221011.10750-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190816221011.10750-1-colin.king@canonical.com>
Content-Language: en-US
Content-ID: <BF8966527E0E3940B6309A7EBD82C85D@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Colin King <colin.king@canonical.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wOC0xNiA2OjEwIHAubS4sIENvbGluIEtpbmcgd3JvdGU6DQo+IEZyb206IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBDdXJyZW50bHkgdGhl
IHBvaW50ZXIgaW5pdF9kYXRhIGlzIGRlcmVmZXJlbmNlZCBvbiB0aGUgYXNzaWdubWVudA0KPiBv
ZiBmd19pbmZvIGJlZm9yZSBpbml0X2RhdGEgaXMgc2FuaXR5IGNoZWNrZWQgdG8gc2VlIGlmIGl0
IGlzIG51bGwuDQo+IEZpeCB0ZSBwb3RlbnRpYWwgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIG9u
IGluaXRfZGF0YSBieSBvbmx5DQo+IHBlcmZvcm1pbmcgZGVyZWZlcmVuY2UgYWZ0ZXIgaXQgaXMg
bnVsbCBjaGVja2VkLg0KPiANCj4gQWRkcmVzc2VzLUNvdmVyaXR5OiAoIkRlcmVmZXJlbmNlIGJl
Zm9yZSBudWxsIGNoZWNrIikNCj4gRml4ZXM6IDlhZGM4MDUwYmYzYyAoImRybS9hbWQvZGlzcGxh
eTogbWFrZSBmaXJtd2FyZSBpbmZvIG9ubHkgbG9hZCBvbmNlIGR1cmluZyBkY19iaW9zIGNyZWF0
ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNh
bC5jb20+DQoNClJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1k
LmNvbT4NCg0KSGFycnkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UvZGNlX2Nsb2NrX3NvdXJjZS5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja19zb3VyY2UuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2Nsb2NrX3NvdXJjZS5jDQo+IGluZGV4IGJlZTgx
YmYyODhiZS4uOTI2OTU0YzgwNGE2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja19zb3VyY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja19zb3VyY2UuYw0KPiBAQCAtMTIzNSw3ICsx
MjM1LDcgQEAgc3RhdGljIGJvb2wgY2FsY19wbGxfbWF4X3Zjb19jb25zdHJ1Y3QoDQo+ICAJCQlz
dHJ1Y3QgY2FsY19wbGxfY2xvY2tfc291cmNlX2luaXRfZGF0YSAqaW5pdF9kYXRhKQ0KPiAgew0K
PiAgCXVpbnQzMl90IGk7DQo+IC0Jc3RydWN0IGRjX2Zpcm13YXJlX2luZm8gKmZ3X2luZm8gPSAm
aW5pdF9kYXRhLT5icC0+ZndfaW5mbzsNCj4gKwlzdHJ1Y3QgZGNfZmlybXdhcmVfaW5mbyAqZndf
aW5mbzsNCj4gIAlpZiAoY2FsY19wbGxfY3MgPT0gTlVMTCB8fA0KPiAgCQkJaW5pdF9kYXRhID09
IE5VTEwgfHwNCj4gIAkJCWluaXRfZGF0YS0+YnAgPT0gTlVMTCkNCj4gQEAgLTEyNDQsNiArMTI0
NCw3IEBAIHN0YXRpYyBib29sIGNhbGNfcGxsX21heF92Y29fY29uc3RydWN0KA0KPiAgCWlmIChp
bml0X2RhdGEtPmJwLT5md19pbmZvX3ZhbGlkKQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4g
Kwlmd19pbmZvID0gJmluaXRfZGF0YS0+YnAtPmZ3X2luZm87DQo+ICAJY2FsY19wbGxfY3MtPmN0
eCA9IGluaXRfZGF0YS0+Y3R4Ow0KPiAgCWNhbGNfcGxsX2NzLT5yZWZfZnJlcV9raHogPSBmd19p
bmZvLT5wbGxfaW5mby5jcnlzdGFsX2ZyZXF1ZW5jeTsNCj4gIAljYWxjX3BsbF9jcy0+bWluX3Zj
b19raHogPQ0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bA==
