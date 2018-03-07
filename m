From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 7 Mar 2018 18:50:42 +0100
Message-ID: <436764aa-a11b-24ba-1d81-648eda9d6150@daenzer.net>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <CADnq5_OAnM2p2NHnOAduCd+yomFXKqKhrag+JaayZD1Ri9z_2Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NykcGcvNp2q=1Ce68Wuddg6t9i18toB8ntXDFgcTcqDg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wMy0wNyAwNjozOCBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIFdlZCwgTWFy
IDcsIDIwMTggYXQgMTI6MjkgUE0sIFNhbXVlbCBMaSA8c2FtdWVsLmxpQGFtZC5jb20+IHdyb3Rl
Ogo+Pgo+PiBXaHkgc28gY29tcGxpY2F0ZWQ/IElmIG9sZCB1c2VyIHNwYWNlIGNvbXBhdGliaWxp
dHkgaXMgcmVxdWlyZWQsIGp1c3QgdXNlIHNnX2Rpc3BsYXk9MC4KPiAKPiBJdCB3aWxsIGFsd2F5
cyBqdXN0IHdvcmsgaW4gdGhhdCBjYXNlIGFuZCB3ZSBjYW4gYWRqdXN0IGZvciB0aGUKPiBvcHRp
bWFsIHNjZW5hcmlvIGJ5IGRlZmF1bHQgaW4gYWxsIGNhc2VzIHdpdGhvdXQgcmVxdWlyaW5nIHRo
ZSB1c2VyIHRvCj4gc2V0IG1pc2MgcGFyYW1ldGVycyB0byB0dW5lIHRoZWlyIHNldHVwIHRoYXQg
bWF5IGJyZWFrIGluIHRoZSBmdXR1cmUKPiBvciBoaWRlIGJ1Z3MgYmVjYXVzZSBhIHVzZXIgc2V0
cyBpdCBhbmQgZm9yZ2V0cyBpdC4KClJpZ2h0LiBJIGRvbid0IGFncmVlIGl0J3MgYWxsIHRoYXQg
Y29tcGxpY2F0ZWQgYW55d2F5LCB3ZSBkbyB0aGlzIHNvcnQKb2YgdGhpbmcgYWxsIHRoZSB0aW1l
LCBpdCBhbHNvIG1ha2VzIG91ciBsaXZlcyBlYXNpZXIgZG93biB0aGUgcm9hZC4KCgotLSAKRWFy
dGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6
Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
