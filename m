From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/display: Convert 10kHz clks from PPLib into
 kHz for Vega
Date: Thu, 12 Jul 2018 16:20:05 +0200
Message-ID: <6dee2b28-6381-a98b-bbc3-33bf4653386b@daenzer.net>
References: <20180712133605.13625-1-harry.wentland@amd.com>
 <20180712140909.15981-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180712140909.15981-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org
Cc: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNy0xMiAwNDowOSBQTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gVGhlIGRyaXZl
ciBpcyBleHBlY3RpbmcgY2xvY2sgZnJlcXVlbmN5IGluIGtIeiwgd2hpbGUgU01VIHJldHVybnMK
PiB0aGUgdmFsdWVzIGluIDEwa0h6LCB3aGljaCBjYXVzZXMgdGhlIGJhbmR3aWR0aCB2YWxpZGF0
aW9uIHRvIGZhaWwKPiAKPiA0LjE4IGhhcyB0aGUgZmF1bHR5IGNsb2NrIGFzc2lnbm1lbnQgaW4g
cHBfdG9fZGNfY2xvY2tfbGV2ZWxzX3dpdGhfbGF0ZW5jeQo+IG9ubHksIHdoaWNoIGlzIG9ubHkg
dXNlZCBieSBWZWdhLiBNYWtlIHN1cmUgd2UgbXVsdGlwbHkgdGhlc2UgdmFsdWVzCj4gYnkgMTAg
aGVyZSwgYXMgd2UgZG8gZm9yIG90aGVyIEFTSUNzIGFzIHBvd2VycGxheSBhc3NpZ25lZCB0aGVt
Cj4gd3JvbmcuIDQuMTkgaGFzIHRoZSBwcm9wZXIgZml4IGluIHBvd2VycGxheS4KPiAKPiB2Mjog
QWRkIEZpeGVzIHRhZwo+IAo+IEZpeGVzOiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3No
b3dfYnVnLmNnaT9pZD0xMDcwODIKCkJ1Z3ppbGxhOiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Au
b3JnLzEwNzA4MgoKV2l0aCB0aGF0IGZpeGVkLAoKQWNrZWQtYnk6IE1pY2hlbCBEw6RuemVyIDxt
aWNoZWwuZGFlbnplckBhbWQuY29tPgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3
YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVs
b3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
