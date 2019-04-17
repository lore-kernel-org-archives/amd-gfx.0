From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: dynamic DMA-buf sharing between devices
Date: Wed, 17 Apr 2019 13:52:06 +0000
Message-ID: <b19612a3-0143-f8b5-7758-7e80c46d33d4@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190416183841.1577-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <A300D655748B3F4387A3AC013957A106-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VGhhbmtzIENocmlzdGlhbiwgZ3JlYXQgam9iLiBJIHdpbGwgdmVyaWZ5IGl0IHRoaXMgd2VlayB3
aGVuIEkgZmluaXNoIG15IA0KY3VycmVudCB3b3JrIG9uIGhhbmQuDQoNCi1EYXZpZA0KDQrlnKgg
MjAxOS80LzE3IDI6MzgsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+IEhpIGV2ZXJ5Ym9keSwN
Cj4NCj4gY29yZSBpZGVhIGluIHRoaXMgcGF0Y2ggc2V0IGlzIHRoYXQgRE1BLWJ1ZiBpbXBvcnRl
cnMgY2FuIG5vdyBwcm92aWRlIGFuIG9wdGlvbmFsIGludmFsaWRhdGUgY2FsbGJhY2suIFVzaW5n
IHRoaXMgY2FsbGJhY2sgYW5kIHRoZSByZXNlcnZhdGlvbiBvYmplY3QgZXhwb3J0ZXJzIGNhbiBu
b3cgYXZvaWQgcGlubmluZyBETUEtYnVmIG1lbW9yeSBmb3IgYSBsb25nIHRpbWUgd2hpbGUgc2hh
cmluZyBpdCBiZXR3ZWVuIGRldmljZXMuDQo+DQo+IEkndmUgYWxyZWFkeSBzZW5kIG91dCBhbiBv
bGRlciB2ZXJzaW9uIHJvdWdobHkgYSB5ZWFyIGFnbywgYnV0IGRpZG4ndCBoYWQgdGltZSB0byBm
dXJ0aGVyIGxvb2sgaW50byBjbGVhbmluZyB0aGlzIHVwLg0KPg0KPiBUaGUgbGFzdCB0aW1lIGEg
bWFqb3IgcHJvYmxlbSB3YXMgdGhhdCB3ZSB3b3VsZCBoYWQgdG8gZml4IHVwIGFsbCBkcml2ZXJz
IGltcGxlbWVudGluZyBETUEtYnVmIGF0IG9uY2UuDQo+DQo+IE5vdyBJIGF2b2lkIHRoaXMgYnkg
YWxsb3dpbmcgbWFwcGluZ3MgdG8gYmUgY2FjaGVkIGluIHRoZSBETUEtYnVmIGF0dGFjaG1lbnQg
YW5kIHNvIGRyaXZlciBjYW4gb3B0aW9uYWxseSBtb3ZlIG92ZXIgdG8gdGhlIG5ldyBpbnRlcmZh
Y2Ugb25lIGJ5IG9uZS4NCj4NCj4gVGhpcyBpcyBhbHNvIGEgcHJlcmVxdWlzaXRlIHRvIG15IHBh
dGNoc2V0IGVuYWJsaW5nIHNoYXJpbmcgb2YgZGV2aWNlIG1lbW9yeSB3aXRoIERNQS1idWYuDQo+
DQo+IFBsZWFzZSByZXZpZXcgYW5kL29yIGNvbW1lbnQsDQo+IENocmlzdGlhbi4NCj4NCj4NCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gZHJpLWRl
dmVsIG1haWxpbmcgbGlzdA0KPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
