From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: RFC for a render API to support adaptive sync and VRR
Date: Wed, 11 Apr 2018 17:45:41 +0200
Message-ID: <01298e03-3c50-f4a2-591b-cf065cfb3231@daenzer.net>
References: <c79421ce-9408-5cd6-5de3-0fa521146e4b@amd.com>
 <435ebd04-0435-5a6a-9f1e-e4c4fc629aa9@amd.com>
 <20180409214554.GB13967@intel.com>
 <1e8d1857-faba-85da-0136-ea7c29ec1b84@amd.com>
 <b75e31f7-ce59-de97-5445-cb4c03ff7336@daenzer.net>
 <ae9992e5-43ab-9636-13e1-8a5c692480b5@amd.com>
 <MWHPR12MB1837C57016A470A5199E855282BE0@MWHPR12MB1837.namprd12.prod.outlook.com>
 <fc53ce53-f02c-891d-4aa5-e9a11cbe3007@amd.com>
 <MWHPR12MB1837488A047C03E955282A4182BE0@MWHPR12MB1837.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <MWHPR12MB1837488A047C03E955282A4182BE0@MWHPR12MB1837.namprd12.prod.outlook.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Cyr, Aric" <Aric.Cyr@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, Manasi Navare <manasi.d.navare@intel.com>
Cc: "Haehnle, Nicolai" <Nicolai.Haehnle@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wNC0xMCAwNjoyNiBQTSwgQ3lyLCBBcmljIHdyb3RlOj4gPiBNeSBndWVzcyBpcyB0
aGV5IHByZWZlciB0bwrigJxkbyBub3RoaW5n4oCdIGFuZCBsZXQgZHJpdmVyL0hXIG1hbmFnZSBp
dCwKPiBvdGhlcndpc2UgeW91IGV4ZW1wdCBhbGwgZXhpc3RpbmcgZ2FtZXMgZnJvbSBzdXBwb3J0
aW5nIGFkYXB0aXZlIHN5bmMKPiB3aXRob3V0IGEgcmV3cml0ZSBvciB1cGRhdGUuCk5vYm9keSBp
cyBzYXlpbmcgYWRhcHRpdmUgc3luYyBzaG91bGQgb25seSB3b3JrIHdpdGggZXhwbGljaXQgdGFy
Z2V0CnByZXNlbnRhdGlvbiB0aW1lcyBwcm92aWRlZCBieSB0aGUgYXBwbGljYXRpb24uIFdlJ3Jl
IGp1c3QgYXJndWluZyB0aGF0CnRhcmdldCBwcmVzZW50YXRpb24gdGltZSBhcyBhIG1lY2hhbmlz
bSBpcyBzdXBlcmlvciB0byB0YXJnZXQgcmVmcmVzaApyYXRlLCBib3RoIGZvciB2aWRlbyBhbmQg
Z2FtZSB1c2UgY2FzZXMuIEl0IGFsc28gdHJpdmlhbGx5IGFsbG93cwplbXVsYXRpbmcgImFzIGVh
cmx5IGFzIHBvc3NpYmxlIiAodGFyZ2V0IHByZXNlbnRhdGlvbiB0aW1lID0gMCkgYW5kCiJmaXhl
ZCByZWZyZXNoIHJhdGUiICh0YXJnZXQgcHJlc2VudGF0aW9uIHRpbWUgPSBzdGFydCArIGkgKiB0
YXJnZXQKZnJhbWUgZHVyYXRpb24pIGJlaGF2aW91ciwgZXZlbiB0cmFuc3BhcmVudGx5IGZvciB0
aGUgYXBwbGljYXRpb24uCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50
aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
