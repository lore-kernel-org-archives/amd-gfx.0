From: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/1] amdgpu: move asic id table to a separate file
Date: Thu, 11 May 2017 21:13:21 +0000
Message-ID: <CY1PR1201MB1033C872BA2CF7916ED3A369F5ED0@CY1PR1201MB1033.namprd12.prod.outlook.com>
References: <1494449815-10162-1-git-send-email-Samuel.Li@amd.com>
 <DM3PR1201MB10392013EC4407011C4F9B84F5EC0@DM3PR1201MB1039.namprd12.prod.outlook.com>
 <fcbc7ab9-f5f7-c529-9526-d78772c0d830@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fcbc7ab9-f5f7-c529-9526-d78772c0d830-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

U3VibWl0dGVkIGEgcmVxdWVzdCB0byBjcmVhdGUgYSBuZXcgcmVwbyBvbiBmcmVlZGVza3RvcC4g
TWljaGVsLCBkbyB5b3UgaGF2ZSB0aGUgcHJpdmlsZWdlIHRvIGNyZWF0ZSBpdD8NCmh0dHBzOi8v
YnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTk5NTg5DQoNClNhbQ0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWljaGVsIETDpG56ZXIgW21haWx0bzptaWNo
ZWxAZGFlbnplci5uZXRdIA0KU2VudDogV2VkbmVzZGF5LCBNYXkgMTAsIDIwMTcgMTA6MzMgUE0N
ClRvOiBMaSwgU2FtdWVsIDxTYW11ZWwuTGlAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgWXVhbiwgWGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIIDEvMV0gYW1kZ3B1OiBtb3ZlIGFzaWMgaWQgdGFibGUgdG8gYSBzZXBh
cmF0ZSBmaWxlDQoNCk9uIDExLzA1LzE3IDA2OjEwIEFNLCBMaSwgU2FtdWVsIHdyb3RlOg0KPiBB
bHNvIGF0dGFjaCBhIHNhbXBsZSBpZHMgZmlsZSBmb3IgcmVmZXJlbmNlLiBUaGUgbmFtZXMgYXJl
IGZyb20gDQo+IG1hcmtldGluZywgbm90IHJlbGF0ZWQgdG8gc291cmNlIGNvZGUgYW5kIG5vIHJl
dmlld3MgbmVjZXNzYXJ5IGhlcmU6KQ0KDQpKdXN0IGJlY2F1c2UgaXQncyBub3Qgc291cmNlIGNv
ZGUgZG9lc24ndCBtZWFuIG5vIHJldmlldyBpcyBuZWNlc3NhcnkuIDopDQoNCg0KPiBJdCBjYW4g
YmUgcHV0IGluIGRpcmVjdG9yeSAvdXNyL3NoYXJlL2xpYmRybS4NCg0KV2hhdCBpcyB0aGUgY2Fu
b25pY2FsIGxvY2F0aW9uIHdoZXJlIGRpc3Ryb3Mgb3IgdXNlcnMgYnVpbGRpbmcgdXBzdHJlYW0g
bGliZHJtIGNhbiBnZXQgdGhpcyBmaWxlIGZyb20/IFRoZXJlIG5lZWRzIHRvIGJlIGEgZ29vZCBz
b2x1dGlvbiBmb3IgdGhhdCBiZWZvcmUgdGhpcyBjYW4gbGFuZC4NCg0KDQotLSANCkVhcnRobGlu
ZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3
LmFtZC5jb20NCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAg
ICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
