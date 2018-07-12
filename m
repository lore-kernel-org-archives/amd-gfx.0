From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] amd/dc/dce100: On dce100, set clocks to 0 on suspend
Date: Thu, 12 Jul 2018 16:18:34 +0200
Message-ID: <1d3973cb-75c5-10e1-866e-e323b175a6de@daenzer.net>
References: <20180712140749.7706-1-David.Francis@amd.com>
 <2d781fe6-b6e4-efbc-43fe-1249e211300d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2d781fe6-b6e4-efbc-43fe-1249e211300d-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNy0xMiAwNDoxMyBQTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gT24gMjAxOC0w
Ny0xMiAxMDowNyBBTSwgRGF2aWQgRnJhbmNpcyB3cm90ZToKPj4gW1doeV0KPj4gV2hlbiBhIGRj
ZTEwMCBhc2ljIHdhcyBzdXNwZW5kZWQsIHRoZSBjbG9ja3Mgd2VyZSBub3Qgc2V0IHRvIDAuCj4+
IFVwb24gcmVzdW1lLCB0aGUgbmV3IGNsb2NrIHdhcyBjb21wYXJlZCB0byB0aGUgZXhpc3Rpbmcg
Y2xvY2ssCj4+IHRoZXkgd2VyZSBmb3VuZCB0byBiZSB0aGUgc2FtZSwgYW5kIHNvIHRoZSBjbG9j
ayB3YXMgbm90IHNldC4KPj4gVGhpcyByZXN1bHRlZCBpbiBhIHBlcm5pY2lvdXMgYmxhY2tzY3Jl
ZW4uCj4+Cj4+IFtIb3ddCj4+IEluIGF0b21pYyBjb21taXQsIGNoZWNrIHRvIHNlZSBpZiB0aGVy
ZSBhcmUgYW55IGFjdGl2ZSBwaXBlcy4KPj4gSWYgbm8sIHNldCBjbG9ja3MgdG8gMAo+Pgo+IAo+
IFBsZWFzZSBhZGQgRml4ZXM6IHRhZyB3aXRoIGxpbmsgdG8gZnJlZWRlc2t0b3AgYnVnemlsbGEg
YnVnIHRoYXQgdGhpcyBmaXhlcy4KClRoYXQgd291bGQgYmUKCkJ1Z3ppbGxhOiBodHRwczovLy4u
LgoKKHRoZSBGaXhlcyB0YWcgaXMgZm9yIHJlZmVyZW5jaW5nIGFub3RoZXIgY29tbWl0IHdoaWNo
IGlzIGZpeGVkIGJ5IHRoaXMgb25lKQoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3
YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVs
b3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
