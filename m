From: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pages
 for pool
Date: Thu, 17 Aug 2017 02:21:01 +0000
Message-ID: <BY2PR1201MB093589C5D6BECA7E316A00DEEB830@BY2PR1201MB0935.namprd12.prod.outlook.com>
References: <1502868046-32511-1-git-send-email-Xiangliang.Yu@amd.com>
 <BLUPR12MB044923B80FB13FACC4DA726E84820@BLUPR12MB0449.namprd12.prod.outlook.com>
 <8f64cef6-e7f7-e245-93b9-a0d1bbc411aa@vodafone.de>
 <140f09b5-32de-eb00-c2b1-8a660182344d@amd.com>
 <BY2PR1201MB0935AC81E9620D14D382CFF8EB820@BY2PR1201MB0935.namprd12.prod.outlook.com>
 <177a0567-733d-8b72-5051-fe8d2b9dbafb@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <177a0567-733d-8b72-5051-fe8d2b9dbafb-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SSBtZWFuIEkgZG9uJ3Qga25vdyBpZiB0aGUgcGF0Y2ggY2FuIGZpeCBtZW0gbGVhayBpc3N1ZS4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggW21haWx0bzphbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnXSBPbiBCZWhhbGYgT2YgTWljaGVsIEQ/
bnplcg0KU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTYsIDIwMTcgNjowMyBQTQ0KVG86IFl1LCBY
aWFuZ2xpYW5nIDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+OyBaaG91LCBEYXZpZChDaHVuTWluZykg
PERhdmlkMS5aaG91QGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBkcm0vdHRtOiBGaXggYWNjb3VudGluZyBlcnJvciB3
aGVuIGZhaWwgdG8gZ2V0IHBhZ2VzIGZvciBwb29sDQoNCk9uIDE2LzA4LzE3IDA2OjQzIFBNLCBZ
dSwgWGlhbmdsaWFuZyB3cm90ZToNCj4gSSBkb27igJl0IGtub3csIGJ1dCBpdCBpcyBvYnZpb3Vz
IGlzc3VlLiBMYXRlciBJ4oCZbGwgcnVuIHRlc3Qgd2l0aCB0aGUgcGF0Y2guDQoNCkluIHRoZSBm
dXR1cmUsIHBsZWFzZSB0ZXN0IHBhdGNoZXMgYmVmb3JlIHN1Ym1pdHRpbmcgdGhlbSBmb3IgcmV2
aWV3LiA6KQ0KDQoNCi0tIA0KRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQ0KTGlicmUgc29mdHdhcmUgZW50aHVz
aWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWls
aW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
