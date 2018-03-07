From: Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 7 Mar 2018 13:53:45 -0500
Message-ID: <2ec2f77f-7e7d-dc06-921a-edfa53d49c9e@amd.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
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
 <e70cc3eb-b549-551b-7d31-6adfa3471f8d@amd.com>
 <CADnq5_NOVK1sgOwbioVtJ8-syfKthvJ44ifS5X549ZZEEZzUUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NOVK1sgOwbioVtJ8-syfKthvJ44ifS5X549ZZEEZzUUw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiBZb3UgbWlnaHQgYWxzbyB3YW50IHRvIHByZWZlciBWUkFNLCBidXQgYWxzbyBhbGxvdyBidWZm
ZXJzIHRvIGZhbGwgYmFjayB0byBHVFQgaWYKPiBuZWNlc3NhcnkuCkZvciBkaXNwbGF5IGJ1ZmZl
ciwgdGhpcyBjYXNlIHNlZW1zIG5vdCByZWFsbHkgYXR0cmFjdGl2ZS4gV2hlbiBkaXNwbGF5IGJ1
ZmZlciBjaGFuZ2VzIGJldHdlZW4gR1RUIGFuZCBWUkFNIGR5bmFtaWNhbGx5LCBvdXIgZHJpdmVy
IG5lZWRzIHRvIGFkcGF0IHRvbywgd2hpY2ggaXMgaGFyZCB0byBzZWUgdGhlIGJlbmVmaXRzIGFu
ZCBub3QgcmVhbGx5IHdvcnRoIHRoZSBlZmZvcnQuCgpTYW0KCgoKT24gMjAxOC0wMy0wNyAwMToy
NyBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIFdlZCwgTWFyIDcsIDIwMTggYXQgMToxOCBQ
TSwgU2FtdWVsIExpIDxzYW11ZWwubGlAYW1kLmNvbT4gd3JvdGU6Cj4+IEkgdGhpbmsgaXQncyBu
b3QgdXNlZnVsIHRob3VnaC4gVGhpbmsgYWJvdXQgdGhhdCwgU0cgZGlzcGxheSBmZWF0dXJlIGlz
IGludGVuZGVkIHRvIHVzZSBhcyBsZXNzIFZSQU0gYXMgcG9zc2libGUuIFdpbGwgc29tZW9uZSB3
YW50IGEgZGlzcGxheSBidWZmZXIgc29tZXRpbWVzIFZSQU0sIHNvbWV0aW1lcyBHVFQ/Cj4+IEhh
cmRseSBhIGNhc2UgdG8gbWUsIGFuZCBJIHRoaW5rIGl0J3MgYSB3YXN0ZSBvZiBlZmZvcnQuIFRo
YXQgYWxzbyBtaWdodCBleHBsYWluIG5vIGRyaXZlciBkb2VzIHRoYXQgbm93Lgo+IAo+IFlvdSBt
aWdodCB3YW50IGRpZmZlcmVudCBzdHJhdGVnaWVzIGRlcGVuZGluZyBvbiBob3cgbXVjaCBWUkFN
IHlvdQo+IGhhdmUuICBJZiB5b3UgaGF2ZSBhIGJ1bmNoIGFuZCBpdCBwZXJmb3JtcyBiZXR0ZXIs
IHByZWZlciBpdC4gIElmIHlvdQo+IGhhdmUgbGltaXRlZCBWUkFNLCB5b3UgbWlnaHQgd2FudCB0
byBwcmVmZXIgR1RULiAgWW91IG1pZ2h0IGFsc28gd2FudAo+IHRvIHByZWZlciBWUkFNLCBidXQg
YWxzbyBhbGxvdyBidWZmZXJzIHRvIGZhbGwgYmFjayB0byBHVFQgaWYKPiBuZWNlc3NhcnkuICBU
aGlzIHdvdWxkIG1ha2UgdGhlIGxvZ2ljIGR5bmFtaWMgYW5kIGFsbCBpbiBvbmUgcGxhY2UuCj4g
VGhlIGtlcm5lbCBjYW4gYWR2ZXJ0aXNlIHdoYXQgYXNpY3Mgc3VwcG9ydCBzY2Fub3V0IGZyb20g
c3lzdGVtIHJhbQo+IGFuZCB0aGVuIFVNRHMgY2FuIGp1c3QgcXVlcnkgdGhhdCB0byBjaG9vc2Ug
cGxhY2VtZW50cyByYXRoZXIgdGhhbgo+IGFkZGluZyBoYXJkY29kZWQgbG9naWMgZm9yIHNwZWNp
ZmljIGFzaWNzLgo+IAo+IEFsZXgKPiAKPj4KPj4gU2FtCj4+Cj4+Cj4+Cj4+IE9uIDIwMTgtMDMt
MDcgMTI6NTAgUE0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+Pj4gT24gMjAxOC0wMy0wNyAwNjoz
OCBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+Pj4+IE9uIFdlZCwgTWFyIDcsIDIwMTggYXQgMTI6
MjkgUE0sIFNhbXVlbCBMaSA8c2FtdWVsLmxpQGFtZC5jb20+IHdyb3RlOgo+Pj4+Pgo+Pj4+PiBX
aHkgc28gY29tcGxpY2F0ZWQ/IElmIG9sZCB1c2VyIHNwYWNlIGNvbXBhdGliaWxpdHkgaXMgcmVx
dWlyZWQsIGp1c3QgdXNlIHNnX2Rpc3BsYXk9MC4KPj4+Pgo+Pj4+IEl0IHdpbGwgYWx3YXlzIGp1
c3Qgd29yayBpbiB0aGF0IGNhc2UgYW5kIHdlIGNhbiBhZGp1c3QgZm9yIHRoZQo+Pj4+IG9wdGlt
YWwgc2NlbmFyaW8gYnkgZGVmYXVsdCBpbiBhbGwgY2FzZXMgd2l0aG91dCByZXF1aXJpbmcgdGhl
IHVzZXIgdG8KPj4+PiBzZXQgbWlzYyBwYXJhbWV0ZXJzIHRvIHR1bmUgdGhlaXIgc2V0dXAgdGhh
dCBtYXkgYnJlYWsgaW4gdGhlIGZ1dHVyZQo+Pj4+IG9yIGhpZGUgYnVncyBiZWNhdXNlIGEgdXNl
ciBzZXRzIGl0IGFuZCBmb3JnZXRzIGl0Lgo+Pj4KPj4+IFJpZ2h0LiBJIGRvbid0IGFncmVlIGl0
J3MgYWxsIHRoYXQgY29tcGxpY2F0ZWQgYW55d2F5LCB3ZSBkbyB0aGlzIHNvcnQKPj4+IG9mIHRo
aW5nIGFsbCB0aGUgdGltZSwgaXQgYWxzbyBtYWtlcyBvdXIgbGl2ZXMgZWFzaWVyIGRvd24gdGhl
IHJvYWQuCj4+Pgo+Pj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
