From: "Chalmers, Kenneth" <Ken.Chalmers-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 29/45] drm/amd/display: Use 100 Hz precision for pipe
 pixel clocks
Date: Wed, 12 Dec 2018 18:29:16 +0000
Message-ID: <DM3PR12MB07477DDBEB36D3C660E683B19CA70@DM3PR12MB0747.namprd12.prod.outlook.com>
References: <1544569071-7114-1-git-send-email-sunpeng.li@amd.com>
 <1544569071-7114-30-git-send-email-sunpeng.li@amd.com>
 <2cf9b879-6c37-6879-e4bb-12fb309f8e94@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2cf9b879-6c37-6879-e4bb-12fb309f8e94-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiA+IEZyb206IEtlbiBDaGFsbWVycyA8a2VuLmNoYWxtZXJzQGFtZC5jb20+DQo+ID4NCj4gPiBb
V2h5XQ0KPiA+IFVzZXJzIHdvdWxkIGxpa2UgbW9yZSBhY2N1cmF0ZSBwaXhlbCBjbG9ja3MsIGVz
cGVjaWFsbHkgZm9yIGZyYWN0aW9uYWwNCj4gPiAiVFYiIGZyYW1lIHJhdGVzIGxpa2UgNTkuOTQg
SHouDQo+ID4NCj4gPiBbSG93XQ0KPiA+IFN0b3JlIGFuZCBjb21tdW5pY2F0ZSBwaXhlbCBjbG9j
a3Mgd2l0aCAxMDAgSHogYWNjdXJhY3kgZnJvbQ0KPiA+IGRjX2NydGNfdGltaW5nIHRocm91Z2gg
dG8gQklPUyBjb21tYW5kIHRhYmxlIHNldHBpeGVsY2xvY2sgY2FsbC4NCj4gDQo+IFdoeSBub3Qg
ZGlyZWN0bHkgdXNlIEh6Pw0KPiANCj4gSSBtZWFuIHdlIGRvbid0IGhhdmUgYW55IHBpeGVsIGNs
b2NrcyBhYm92ZSA0R0h6LCBkb24ndCB3ZT8gU28gYSAzMmJpdA0KPiBpbnRlZ2VyIHNob3VsZCBi
ZSBhIHBlcmZlY3QgZml0Lg0KPiANCj4gQ2hyaXN0aWFuLg0KDQpDdXJyZW50bHkgdGhlIFZCSU9T
IG9ubHkgc3VwcG9ydHMgMTAwIEh6IHByZWNpc2lvbiwgc28gdGhlcmUncyBubyBpbW1lZGlhdGUg
DQpiZW5lZml0IHRvIG1vdmluZyB0byBncmVhdGVyIHRoYW4gMTAwIEh6IHByZWNpc2lvbi4NCg0K
RXZlbiBzbywgdXNpbmcgSHogZGlyZWN0bHkgd2FzIGFjdHVhbGx5IGRpc2N1c3NlZCBkdXJpbmcg
ZGV2ZWxvcG1lbnQsIGJ1dCANCnRoZSBzdW1tYXJ5IGZyb20gYW4gYXJjaGl0ZWN0IHdhczoNCg0K
PiBJIGFncmVlIGxvbmcgdGVybSBIWiBpcyBiZXR0ZXIuICBQaXhlbCBjbG9jayB2YWx1ZSB3aWxs
IGZpdCB3aXRoaW4NCj4gMzJiaXQsIGJ1dCB3ZSBoYXZlIG1hbnkgY2FsY3VsYXRpb24gYmFzZWQg
b24gcGl4ZWwgY2xvY2sgYW5kIGNoYW5naW5nDQo+IHRvIEhaIHdpbGwgcmVxdWlyZSBiaWdnZXIg
ZWZmb3J0IHRvIG1ha2Ugc3VyZSB0aGUgbWF0aCAodGhlcmUgYXJlIHBsYWNlcw0KPiB3ZSBtdWx0
aXBsZSBwaXhlbCBjbG9jaykgZG9lc27igJl0IG92ZXJmbG93IDMyYml0IGludGVnZXIuICAxMDBo
eiBpcyBhIA0KPiBjb21wcm9taXNlZCBzaG9ydCB0ZXJtIHNvbHV0aW9uLg0KDQogICAgLUtlbg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
