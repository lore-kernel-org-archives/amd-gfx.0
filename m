From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 hmm 08/11] drm/radeon: use mmu_notifier_get/put for
	struct radeon_mn
Date: Thu, 15 Aug 2019 19:46:26 +0000
Message-ID: <20190815194621.GF22970@mellanox.com>
References: <20190806231548.25242-1-jgg@ziepe.ca>
	<20190806231548.25242-9-jgg@ziepe.ca>
	<2baff2e5-b923-c39b-98e5-b3e7f77bd6d3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2baff2e5-b923-c39b-98e5-b3e7f77bd6d3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Content-ID: <2697329F3A1E3A4682A1061BFB978A84-wNKe6lTLrGecE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dimitri Sivanich <sivanich-sJ/iWh9BUns@public.gmane.org>, Gavin Shan <shangw-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Andrea Righi <andrea-oIIqvOZpAevzfdHfmsDf5w@public.gmane.org>, "linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Kuehling,
	Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <intel-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBBdWcgMTUsIDIwMTkgYXQgMTA6Mjg6MjFBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToNCj4gQW0gMDcuMDguMTkgdW0gMDE6MTUgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6
DQo+ID4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPg0KPiA+IA0KPiA+
IHJhZGVvbiBpcyB1c2luZyBhIGRldmljZSBnbG9iYWwgaGFzaCB0YWJsZSB0byB0cmFjayB3aGF0
IG1tdV9ub3RpZmllcnMNCj4gPiBoYXZlIGJlZW4gcmVnaXN0ZXJlZCBvbiBzdHJ1Y3QgbW0uIFRo
aXMgaXMgYmV0dGVyIHNlcnZlZCB3aXRoIHRoZSBuZXcNCj4gPiBnZXQvcHV0IHNjaGVtZSBpbnN0
ZWFkLg0KPiA+IA0KPiA+IHJhZGVvbiBoYXMgYSBidWcgd2hlcmUgaXQgd2FzIG5vdCBibG9ja2lu
ZyBub3RpZmllciByZWxlYXNlKCkgdW50aWwgYWxsDQo+ID4gdGhlIEJPJ3MgaGFkIGJlZW4gaW52
YWxpZGF0ZWQuIFRoaXMgY291bGQgcmVzdWx0IGluIGEgdXNlIGFmdGVyIGZyZWUgb2YNCj4gPiBw
YWdlcyB0aGUgQk9zLiBUaGlzIGlzIHRpZWQgaW50byBhIHNlY29uZCBidWcgd2hlcmUgcmFkZW9u
IGxlZnQgdGhlDQo+ID4gbm90aWZpZXJzIHJ1bm5pbmcgZW5kbGVzc2x5IGV2ZW4gb25jZSB0aGUg
aW50ZXJ2YWwgdHJlZSBiZWNhbWUNCj4gPiBlbXB0eS4gVGhpcyBjb3VsZCByZXN1bHQgaW4gYSB1
c2UgYWZ0ZXIgZnJlZSB3aXRoIG1vZHVsZSB1bmxvYWQuDQo+ID4gDQo+ID4gQm90aCBhcmUgZml4
ZWQgYnkgY2hhbmdpbmcgdGhlIGxpZmV0aW1lIG1vZGVsLCB0aGUgQk9zIGV4aXN0IGluIHRoZQ0K
PiA+IGludGVydmFsIHRyZWUgd2l0aCB0aGVpciBuYXR1cmFsIGxpZmV0aW1lcyBpbmRlcGVuZGVu
dCBvZiB0aGUgbW1fc3RydWN0DQo+ID4gbGlmZXRpbWUgdXNpbmcgdGhlIGdldC9wdXQgc2NoZW1l
LiBUaGUgcmVsZWFzZSBydW5zIHN5bmNocm9ub3VzbHkgYW5kIGp1c3QNCj4gPiBkb2VzIGludmFs
aWRhdGVfc3RhcnQgYWNyb3NzIHRoZSBlbnRpcmUgaW50ZXJ2YWwgdHJlZSB0byBjcmVhdGUgdGhl
DQo+ID4gcmVxdWlyZWQgRE1BIGZlbmNlLg0KPiA+IA0KPiA+IEFkZGl0aW9ucyB0byB0aGUgaW50
ZXJ2YWwgdHJlZSBhZnRlciByZWxlYXNlIGFyZSBhbHJlYWR5IGltcG9zc2libGUgYXMNCj4gPiBv
bmx5IGN1cnJlbnQtPm1tIGlzIHVzZWQgZHVyaW5nIHRoZSBhZGQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPg0KPiANCj4gQWNrZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0KVGhhbmtz
IQ0KDQo+IEJ1dCBJJ20gd29uZGVyaW5nIGlmIHdlIHNob3VsZG4ndCBjb21wbGV0ZWx5IGRyb3Ag
cmFkZW9uIHVzZXJwdHIgc3VwcG9ydC4NCj4gSXQncyBqdXN0IHRvIGJ1Z2d5LA0KDQpJIHdvdWxk
IG5vdCBvYmplY3QgOikNCg0KSmFzb24NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
