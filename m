From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu accesses
 dma buf.
Date: Thu, 14 Dec 2017 18:27:16 +0100
Message-ID: <78d70000-10ee-295d-6bf2-f6144ba053a9@amd.com>
References: <1512771734-13581-1-git-send-email-Samuel.Li@amd.com>
 <BLUPR12MB0628724406FBB250987B1B41F5340@BLUPR12MB0628.namprd12.prod.outlook.com>
 <212eeef1-2c32-bef9-82a6-a1884ef002da@amd.com>
 <82599e20-60fa-fe6f-2c91-4882ffcff4ce@amd.com>
 <154804e5-cdbb-a5f8-2ad8-506b0752943b@amd.com>
 <53b66de8-3fe3-c139-9887-7358bf1d95b5@amd.com>
 <141a2180-104a-4a75-7757-6de3b522c578@amd.com>
 <e92edd07-27fb-4717-bddd-e97ce5fbc266@amd.com>
 <BN6PR12MB1652331B4826780B9442CA67F7350@BN6PR12MB1652.namprd12.prod.outlook.com>
 <BLUPR12MB06283F027DB3101FEDFF46A0F5350@BLUPR12MB0628.namprd12.prod.outlook.com>
 <3c4474d9-bdc4-25ab-9fe8-9732ee95a391@gmail.com>
 <ef8d316c-23c7-723b-e18b-51ad860ea70b@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ef8d316c-23c7-723b-e18b-51ad860ea70b-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTQuMTIuMjAxNyB1bSAxNzoxNiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTct
MTItMTQgMDk6MDcgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFBsZWFzZSBDQyBNaWNo
ZWwgYXMgd2VsbCwKPiBObyBuZWVkLCBJIHJlYWQgdGhlIGxpc3RzIChqdXN0IHNvbWV0aW1lcyBn
ZXQgYSBsaXR0bGUgc3dhbXBlZCBhbmQgdGFrZQo+IHRpbWUgdG8gY2F0Y2ggdXApLgo+Cj4KPj4g
aGUgb3JpZ2luYWxseSBjb21tZW50ZWQgdGhhdCB3ZSBzaG91bGQgdHJ5IHRvIHNvbHZlIHRoaXMg
aW4gdGhlIEREWCBpbnN0ZWFkLgo+IEkgZG9uJ3QgdGhpbmsgYSBERFggZHJpdmVyIGlzIGV2ZW4g
aW52b2x2ZWQgaW4gdGhlIHNjZW5hcmlvIFNhbSdzCj4gd29ya2luZyBvbi4KPgo+IERvIHlvdSBt
ZWFuIHRoYXQgdGhlIEJPIHNob3VsZCBiZSBjcmVhdGVkIGluIEdUVCBpbiB0aGUgZmlyc3QgcGxh
Y2UgaWYKPiBwb3NzaWJsZT8KClllcywgd2VsbCBhcyBmYXIgYXMgSSB1bmRlcnN0b29kIHRoYXQn
cyB3aGF0IHlvdSBzdWdnZXN0ZWQuCgo+ICAgSSBkaWQgc3VnZ2VzdCB0aGF0IGJlZm9yZSwgYnV0
IEknbSBub3Qgc3VyZSBpdCdzIGZlYXNpYmxlIGluCj4gdGhpcyBzY2VuYXJpby4KCkkgYWdyZWUs
IG5vdCB0aGUgc2xpZ2h0ZXN0IGlkZWEgaG93IHRoZSB1c2VyIHNwYWNlIGFwcCBjcmVhdGVkIHRo
ZSBCTyBpbiAKdGhlIGZpcnN0IHBsYWNlLgoKPgo+Cj4+IEFuZCBCVFc6IFdoeSBkb24ndCB3ZSBq
dXN0IGRvIHRoZSBtaWdyYXRpb24gZHVyaW5nIHRoZSBtbWFwIGNhbGw/Cj4gQXQgbW1hcCB0aW1l
LCB3ZSBkb24ndCBrbm93IHdoZW4gdGhlIEJPIHdpbGwgYWN0dWFsbHkgYmUgYWNjZXNzZWQgYnkg
dGhlCj4gQ1BVIChvciBpbmRlZWQgd2hldGhlciBhdCBhbGwpLiBJZiB3ZSBkbyB0aGUgbWlncmF0
aW9uIGF0IHRoYXQgcG9pbnQsCj4gdGhlcmUncyBubyBndWFyYW50ZWUgdGhhdCB0aGUgQk8gd2ls
bCBzdGlsbCBiZSBpbiBHVFQgd2hlbiBpdCdzIGFjY2Vzc2VkCj4gYnkgdGhlIENQVS4KClRoaXMg
aXMgZm9yIHRoZSBETUEtYnVmIG1hcHBpbmcgZnVuY3Rpb24sIG5vdCB0aGUgbm9ybWFsIGRyaXZl
ciBtbWFwIAppbXBsZW1lbnRhdGlvbi4gU28gd2UgY2FuIGJlIHByZXR0eSBzdXJlIHRoYXQgdGhl
IG1lbW9yeSB3aWxsIGJlIENQVSAKYWNjZXNzZWQuCgpUaGUgcXVlc3Rpb24gaW4gbXkgbWluZCBp
cyBpZiBpdCByZWFsbHkgaXMgc3VjaCBhIGdvb2QgaWRlYSB0byBwaW5nL3BvbmcgCnRoZSBwYWdl
IHdoZW4gdGhlIEdQVS9DUFUgaXMgYWNjZXNzaW5nIHRoZW0uIE5vdCB0aGF0IEkgd2FudCB0byBi
bG9jayAKdGhpcyBwYXRjaCwgYnV0IHRoYXQgaXMgdXN1YWxseSBzb21ldGhpbmcgd2UgdHJ5IHRv
IGF2b2lkLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
