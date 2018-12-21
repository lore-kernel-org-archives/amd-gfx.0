From: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu/virtual_dce: Need to pin the fb's bo
Date: Fri, 21 Dec 2018 08:45:02 +0000
Message-ID: <BN7PR12MB26449E825462ADBC0AC0A2E68FB80@BN7PR12MB2644.namprd12.prod.outlook.com>
References: <1545377209-10718-1-git-send-email-Emily.Deng@amd.com>
 <3d75c11d-1172-1d0e-17a6-b5931660fe61@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3d75c11d-1172-1d0e-17a6-b5931660fe61-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hl
bEBkYWVuemVyLm5ldD4NCj5TZW50OiBGcmlkYXksIERlY2VtYmVyIDIxLCAyMDE4IDQ6MzggUE0N
Cj5UbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT4NCj5DYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3ZpcnR1
YWxfZGNlOiBOZWVkIHRvIHBpbiB0aGUgZmIncyBibw0KPg0KPk9uIDIwMTgtMTItMjEgODoyNiBh
Lm0uLCBFbWlseSBEZW5nIHdyb3RlOg0KPj4gV2hlbiB0aGUgYm8gaXMgdXNlZCB0byBzZXQgbW9k
ZSwgdGhlIGJvIG5lZWQgdG8gYmUgcGlubmVkLg0KPg0KPk9uIHNlY29uZCB0aG91Z2h0LCB3aHkg
ZG9lcyB0aGUgQk8gbmVlZCB0byBiZSBwaW5uZWQ/IFdoZW4gdXNpbmcgdGhlIGRpc3BsYXkNCj5o
YXJkd2FyZSwgdGhlIEJPIG5lZWRzIHRvIGJlIHBpbm5lZCB0byBwcmV2ZW50IGl0IGZyb20gYmVp
bmcgbW92ZWQgd2hpbGUgdGhlDQo+aGFyZHdhcmUgaXMgc2Nhbm5pbmcgb3V0IGZyb20gaXQsIGJ1
dCB0aGF0IHNob3VsZG4ndCBiZSBuZWNlc3NhcnkgaGVyZS4NClRoZSBwaW4gaGVyZSBpcyB1c2Vk
IGZvciBzY2FuIG91dCB0aGUgYnVmZmVyIGJ5IHJlbW90ZSBkaXNwbGF5IGFwcC4NCg0KQmVzdCB3
aXNoZXMNCkVtaWx5IERlbmcNCg0KDQo+DQo+LS0NCj5FYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tDQo+TGlicmUg
c29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFgg
ZGV2ZWxvcGVyDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
