From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu accesses
 dma buf.
Date: Thu, 14 Dec 2017 17:16:00 +0100
Message-ID: <ef8d316c-23c7-723b-e18b-51ad860ea70b@daenzer.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3c4474d9-bdc4-25ab-9fe8-9732ee95a391-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-CA
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxNy0xMi0xNCAwOTowNyBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBQbGVhc2Ug
Q0MgTWljaGVsIGFzIHdlbGwsCgpObyBuZWVkLCBJIHJlYWQgdGhlIGxpc3RzIChqdXN0IHNvbWV0
aW1lcyBnZXQgYSBsaXR0bGUgc3dhbXBlZCBhbmQgdGFrZQp0aW1lIHRvIGNhdGNoIHVwKS4KCgo+
IGhlIG9yaWdpbmFsbHkgY29tbWVudGVkIHRoYXQgd2Ugc2hvdWxkIHRyeSB0byBzb2x2ZSB0aGlz
IGluIHRoZSBERFggaW5zdGVhZC4KCkkgZG9uJ3QgdGhpbmsgYSBERFggZHJpdmVyIGlzIGV2ZW4g
aW52b2x2ZWQgaW4gdGhlIHNjZW5hcmlvIFNhbSdzCndvcmtpbmcgb24uCgpEbyB5b3UgbWVhbiB0
aGF0IHRoZSBCTyBzaG91bGQgYmUgY3JlYXRlZCBpbiBHVFQgaW4gdGhlIGZpcnN0IHBsYWNlIGlm
CnBvc3NpYmxlPyBJIGRpZCBzdWdnZXN0IHRoYXQgYmVmb3JlLCBidXQgSSdtIG5vdCBzdXJlIGl0
J3MgZmVhc2libGUgaW4KdGhpcyBzY2VuYXJpby4KCgo+IEFuZCBCVFc6IFdoeSBkb24ndCB3ZSBq
dXN0IGRvIHRoZSBtaWdyYXRpb24gZHVyaW5nIHRoZSBtbWFwIGNhbGw/CgpBdCBtbWFwIHRpbWUs
IHdlIGRvbid0IGtub3cgd2hlbiB0aGUgQk8gd2lsbCBhY3R1YWxseSBiZSBhY2Nlc3NlZCBieSB0
aGUKQ1BVIChvciBpbmRlZWQgd2hldGhlciBhdCBhbGwpLiBJZiB3ZSBkbyB0aGUgbWlncmF0aW9u
IGF0IHRoYXQgcG9pbnQsCnRoZXJlJ3Mgbm8gZ3VhcmFudGVlIHRoYXQgdGhlIEJPIHdpbGwgc3Rp
bGwgYmUgaW4gR1RUIHdoZW4gaXQncyBhY2Nlc3NlZApieSB0aGUgQ1BVLgoKCi0tIApFYXJ0aGxp
bmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3
dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAg
ICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
