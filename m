From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Add fast path for cursor plane updates
Date: Thu, 6 Dec 2018 15:36:25 +0000
Message-ID: <13f4b0bc-fcda-be57-2416-aa3ba5ff065c@amd.com>
References: <20181205195907.9501-1-nicholas.kazlauskas@amd.com>
 <8b305d43-56e1-5505-95d3-35e92f3f8494@amd.com>
 <6352276b-5d47-94ea-2dd1-0f955ceed408@amd.com>
 <73996dfc-1cd6-e707-9e2b-48a5c89d6cac@amd.com>
 <5c4c64a1-cc84-e9c2-6275-ca8ac76237b1@amd.com>
 <a7bad892-8215-16a8-65a6-328533395d03@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a7bad892-8215-16a8-65a6-328533395d03-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <E328B0D3B5DBDA4E978E17E91376B0D3-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

Tm90IGFuIGV4cGVydCBvbiBGcmVlc3luYyBzbyBtYXliZSBzdHVwaWQgcXVlc3Rpb24gYnV0IGZy
b20gaGUgY29tbWVudCANCmxvb2tzIGxpa2UgdGhpcyBwaXBlIGxvY2tpbmcgaXMgb25seSBmb3Ig
dGhlIHNha2Ugb2YgRnJlZXN5bmMgbW9kZSB0aGVyZSANCi0gd2h5IGlzIGl0IHRoZW4gY2FsbGVk
IHVuY29uZGl0aW9uYWxseSB3L28gY2hlY2tpbmcgaWYgeW91IGV2ZW4gcnVuIGluIA0KRnJlZXN5
bmMgbW9kZSA/DQoNCkFuZHJleQ0KDQoNCk9uIDEyLzA2LzIwMTggMDg6NDIgQU0sIEthemxhdXNr
YXMsIE5pY2hvbGFzIHdyb3RlOg0KPiBBIHJlYWRlci93cml0ZXIgbG9jayB3b3VsZG4ndCBoZWxw
IGhlcmUsIGFjdHVhbGx5Lg0KPg0KPiBGYXN0IHVwZGF0ZXMgKGFuZCBwYWdlIGZsaXBzIGluIHBh
cnRpY3VsYXIpIG5lZWQgdG8gbG9jayB0aGUgcGlwZSBhcw0KPiB3ZWxsLCBzZWU6IGNvbW1pdF9w
bGFuZXNfZm9yX3N0cmVhbS4NCj4NCj4gTmljaG9sYXMgS2F6bGF1c2thcw0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
