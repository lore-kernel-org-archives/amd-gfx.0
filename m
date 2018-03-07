From: Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 7 Mar 2018 13:18:36 -0500
Message-ID: <e70cc3eb-b549-551b-7d31-6adfa3471f8d@amd.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <BY1PR12MB05044ACBE8424866B3CCA243F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <898d3377-ee2b-a33d-dbff-b4cb692d650d@amd.com>
 <BY1PR12MB050407EA9472CB2B6E101CE7F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <e416ff00-018b-f206-123e-90b09b4ccd9f@gmail.com>
 <ebe01500-9fa5-e541-86c3-30ff0168e792@daenzer.net>
 <cd4659cb-f030-4938-af44-2fa1389ccdfb@gmail.com>
 <6febc0d1-0171-3cc1-ff22-69aa4ef36036@daenzer.net>
 <12178e4c-6b48-2c3b-9970-2ca30624a5bb@gmail.com>
 <29dba5ab-f4f3-551b-ec94-2d6433e8aa21@daenzer.net>
 <1141c511-597e-c81b-6ffd-800ff846f2c1@gmail.com>
 <55efd18e-296f-fc60-9561-522650847080@daenzer.net>
 <5a228d74-0c3b-bc70-1c17-215cc2bb6a70@amd.com>
 <1ed86df5-1b0d-b409-bb2d-d1c70299ea99@daenzer.net>
 <a3fb9f28-9223-0997-6f4a-419e57a44848@amd.com>
 <CADnq5_NykcGcvNp2q=1Ce68Wuddg6t9i18toB8ntXDFgcTcqDg@mail.gmail.com>
 <436764aa-a11b-24ba-1d81-648eda9d6150@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <436764aa-a11b-24ba-1d81-648eda9d6150-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SSB0aGluayBpdCdzIG5vdCB1c2VmdWwgdGhvdWdoLiBUaGluayBhYm91dCB0aGF0LCBTRyBkaXNw
bGF5IGZlYXR1cmUgaXMgaW50ZW5kZWQgdG8gdXNlIGFzIGxlc3MgVlJBTSBhcyBwb3NzaWJsZS4g
V2lsbCBzb21lb25lIHdhbnQgYSBkaXNwbGF5IGJ1ZmZlciBzb21ldGltZXMgVlJBTSwgc29tZXRp
bWVzIEdUVD8KSGFyZGx5IGEgY2FzZSB0byBtZSwgYW5kIEkgdGhpbmsgaXQncyBhIHdhc3RlIG9m
IGVmZm9ydC4gVGhhdCBhbHNvIG1pZ2h0IGV4cGxhaW4gbm8gZHJpdmVyIGRvZXMgdGhhdCBub3cu
CgpTYW0KCgoKT24gMjAxOC0wMy0wNyAxMjo1MCBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4g
T24gMjAxOC0wMy0wNyAwNjozOCBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBPbiBXZWQsIE1h
ciA3LCAyMDE4IGF0IDEyOjI5IFBNLCBTYW11ZWwgTGkgPHNhbXVlbC5saUBhbWQuY29tPiB3cm90
ZToKPj4+Cj4+PiBXaHkgc28gY29tcGxpY2F0ZWQ/IElmIG9sZCB1c2VyIHNwYWNlIGNvbXBhdGli
aWxpdHkgaXMgcmVxdWlyZWQsIGp1c3QgdXNlIHNnX2Rpc3BsYXk9MC4KPj4KPj4gSXQgd2lsbCBh
bHdheXMganVzdCB3b3JrIGluIHRoYXQgY2FzZSBhbmQgd2UgY2FuIGFkanVzdCBmb3IgdGhlCj4+
IG9wdGltYWwgc2NlbmFyaW8gYnkgZGVmYXVsdCBpbiBhbGwgY2FzZXMgd2l0aG91dCByZXF1aXJp
bmcgdGhlIHVzZXIgdG8KPj4gc2V0IG1pc2MgcGFyYW1ldGVycyB0byB0dW5lIHRoZWlyIHNldHVw
IHRoYXQgbWF5IGJyZWFrIGluIHRoZSBmdXR1cmUKPj4gb3IgaGlkZSBidWdzIGJlY2F1c2UgYSB1
c2VyIHNldHMgaXQgYW5kIGZvcmdldHMgaXQuCj4gCj4gUmlnaHQuIEkgZG9uJ3QgYWdyZWUgaXQn
cyBhbGwgdGhhdCBjb21wbGljYXRlZCBhbnl3YXksIHdlIGRvIHRoaXMgc29ydAo+IG9mIHRoaW5n
IGFsbCB0aGUgdGltZSwgaXQgYWxzbyBtYWtlcyBvdXIgbGl2ZXMgZWFzaWVyIGRvd24gdGhlIHJv
YWQuCj4gCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
