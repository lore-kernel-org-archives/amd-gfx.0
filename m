From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable
 'core_freesync'
Date: Mon, 7 Oct 2019 14:06:46 +0000
Message-ID: <db644945-24df-7d67-7fc6-880833466593@amd.com>
References: <20191006105735.60708-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191006105735.60708-1-yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <ABB90FE0D76EB24289D707AB2965C821-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "Koo, Anthony" <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, "Cyr, Aric" <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>, "Harmanprit.Tatla-5C7GfCeVMHo@public.gmane.org" <Harmanprit.Tatla-5C7GfCeVMHo@public.gmane.org>, "bayan.zabihiyan-5C7GfCeVMHo@public.gmane.org" <bayan.zabihiyan-5C7GfCeVMHo@public.gmane.org>, "Othman, Ahmad" <Ahmad.Othman-5C7GfCeVMHo@public.gmane.org>, "Amini, Reza" <Reza.Amini-5C7GfCeVMHo@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gMjAxOS0xMC0wNiA2OjU3IGEubS4sIFl1ZUhhaWJpbmcgd3JvdGU6DQo+IEZpeGVzIGdjYyAn
LVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZScgd2FybmluZzoNCj4gDQo+IHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmM6DQo+ICBJ
biBmdW5jdGlvbiBtb2RfZnJlZXN5bmNfZ2V0X3NldHRpbmdzOg0KPiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9kaXNwbGF5L21vZHVsZXMvZnJlZXN5bmMvZnJlZXN5bmMuYzo5ODQ6MjQ6
DQo+ICB3YXJuaW5nOiB2YXJpYWJsZSBjb3JlX2ZyZWVzeW5jIHNldCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+IA0KPiBJdCBpcyBub3QgdXNlZCBzaW5jZSBjb21t
aXQgOThlNjQzNmQzYWY1ICgiZHJtL2FtZC9kaXNwbGF5OiBSZWZhY3RvciBGcmVlU3luYyBtb2R1
bGUiKQ0KPiANCj4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQoNClJl
dmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCg0KSGFy
cnkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2ZyZWVz
eW5jL2ZyZWVzeW5jLmMgfCA0IC0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVz
L2ZyZWVzeW5jL2ZyZWVzeW5jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxl
cy9mcmVlc3luYy9mcmVlc3luYy5jDQo+IGluZGV4IDljZTU2YTguLjIzN2RkYTcgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVz
eW5jLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvZnJlZXN5
bmMvZnJlZXN5bmMuYw0KPiBAQCAtOTgxLDEzICs5ODEsOSBAQCB2b2lkIG1vZF9mcmVlc3luY19n
ZXRfc2V0dGluZ3Moc3RydWN0IG1vZF9mcmVlc3luYyAqbW9kX2ZyZWVzeW5jLA0KPiAgCQl1bnNp
Z25lZCBpbnQgKmluc2VydGVkX2ZyYW1lcywNCj4gIAkJdW5zaWduZWQgaW50ICppbnNlcnRlZF9k
dXJhdGlvbl9pbl91cykNCj4gIHsNCj4gLQlzdHJ1Y3QgY29yZV9mcmVlc3luYyAqY29yZV9mcmVl
c3luYyA9IE5VTEw7DQo+IC0NCj4gIAlpZiAobW9kX2ZyZWVzeW5jID09IE5VTEwpDQo+ICAJCXJl
dHVybjsNCj4gIA0KPiAtCWNvcmVfZnJlZXN5bmMgPSBNT0RfRlJFRVNZTkNfVE9fQ09SRShtb2Rf
ZnJlZXN5bmMpOw0KPiAtDQo+ICAJaWYgKHZyci0+c3VwcG9ydGVkKSB7DQo+ICAJCSp2X3RvdGFs
X21pbiA9IHZyci0+YWRqdXN0LnZfdG90YWxfbWluOw0KPiAgCQkqdl90b3RhbF9tYXggPSB2cnIt
PmFkanVzdC52X3RvdGFsX21heDsNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
