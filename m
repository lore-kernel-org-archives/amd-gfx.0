From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/5] drm/amd/display: some fixes for gcc warning
Date: Mon, 7 Oct 2019 14:19:33 +0000
Message-ID: <85a8ffa0-6458-32fc-41b0-6e14dcdb61d8@amd.com>
References: <1570243476-44419-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1570243476-44419-1-git-send-email-zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <62239618D1819D4EBC2136EE47B77940-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

U2VyaWVzIGlzDQpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFt
ZC5jb20+DQoNCkhhcnJ5DQoNCk9uIDIwMTktMTAtMDQgMTA6NDQgcC5tLiwgemhlbmdiaW4gd3Jv
dGU6DQo+IHpoZW5nYmluICg1KToNCj4gICBkcm0vYW1kL2Rpc3BsYXk6IE1ha2UgZnVuY3Rpb24g
d2FpdF9mb3JfYWx0X21vZGUgc3RhdGljDQo+ICAgZHJtL2FtZC9kaXNwbGF5OiBSZW1vdmUgc2V0
IGJ1dCBub3QgdXNlZCB2YXJpYWJsZSAnc291cmNlX2JwcCcNCj4gICBkcm0vYW1kL2Rpc3BsYXk6
IFJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlcw0KPiAgICAgJ2hfcmF0aW9fY2hyb21h
Jywndl9yYXRpb19jaHJvbWEnDQo+ICAgZHJtL2FtZC9kaXNwbGF5OiBSZW1vdmUgc2V0IGJ1dCBu
b3QgdXNlZCB2YXJpYWJsZSAncGl4ZWxfd2lkdGgnDQo+ICAgZHJtL2FtZC9kaXNwbGF5OiBSZW1v
dmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZXMgJ3BwX3NtdScsJ29sZF9waXBlJw0KPiANCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYyAgICAgICAgICAg
ICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNl
MTEwX2h3X3NlcXVlbmNlci5jIHwgMTIgLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfZHBwLmMgICAgICAgICAgICB8ICA3IC0tLS0tLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9kd2Jfc2NsLmMg
ICAgICAgIHwgIDQgLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RzYy9y
Y19jYWxjLmMgICAgICAgICAgICAgICAgfCAgMyAtLS0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDI3IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gMi43LjQNCj4gDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
