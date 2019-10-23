From: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 18/37] drm/amd/display: Allow inverted gamma
Date: Wed, 23 Oct 2019 15:44:44 +0000
Message-ID: <8ca6d548-7a6b-a242-ac22-75a43efd0955@amd.com>
References: <20191017191329.11857-1-sunpeng.li@amd.com>
 <20191017191329.11857-19-sunpeng.li@amd.com>
 <82b4b639-d1c7-c26c-cb84-4c41bb16cb41@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <82b4b639-d1c7-c26c-cb84-4c41bb16cb41-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <E287FFCE9C774342AB877D89E804D4BC-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Kovac,
 Krunoslav" <Krunoslav.Kovac-5C7GfCeVMHo@public.gmane.org>, "Amini, Reza" <Reza.Amini-5C7GfCeVMHo@public.gmane.org>, "Yang,
 Aidan" <Aidan.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

DQoNCk9uIDIwMTktMTAtMjMgMTE6MjMgYS5tLiwgTWljaGVsIETDpG56ZXIgd3JvdGU6DQo+IE9u
IDIwMTktMTAtMTcgOToxMyBwLm0uLCBzdW5wZW5nLmxpQGFtZC5jb20gd3JvdGU6DQo+PiBGcm9t
OiBBaWRhbiBZYW5nIDxBaWRhbi5ZYW5nQGFtZC5jb20+DQo+Pg0KPj4gW3doeV0NCj4+IFRoZXJl
J3MgYSB1c2UgY2FzZSBmb3IgaW52ZXJ0ZWQgZ2FtbWENCj4+IGFuZCBpdCdzIGJlZW4gY29uZmly
bWVkIHRoYXQgbmVnYXRpdmUgc2xvcGVzIGFyZSBvay4NCj4+DQo+PiBbaG93XQ0KPj4gUmVtb3Zl
IGNvZGUgZm9yIGJsb2NraW5nIG5vbi1tb25vdG9uaWNhbGx5IGluY3JlYXNpbmcgZ2FtbWENCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBBaWRhbiBZYW5nIDxBaWRhbi5ZYW5nQGFtZC5jb20+DQo+PiBS
ZXZpZXdlZC1ieTogS3J1bm9zbGF2IEtvdmFjIDxLcnVub3NsYXYuS292YWNAYW1kLmNvbT4NCj4+
IEFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4NCj4+IEFja2VkLWJ5OiBSZXph
IEFtaW5pIDxSZXphLkFtaW5pQGFtZC5jb20+DQo+IA0KPiBEb2VzIHRoaXMgZml4IGh0dHBzOi8v
YnVncy5mcmVlZGVza3RvcC5vcmcvMTEwNjc3ID8gSWYgc28sIGl0IHNob3VsZCBiZQ0KPiByZWZl
cmVuY2VkIGluIHRoZSBjb21taXQgbG9nLCBhbmQgdGhlIHJlcG9ydCByZXNvbHZlZCBvbmNlIHRo
aXMgbGFuZHMgaW4NCj4gZHJtLW5leHQgb3IgTGludXMnIHRyZWUuDQoNCkkgZG9uJ3QgdGhpbmsg
aXQgd291bGQsIG5vdCBvbiByZXBvcnRlZCBwbGF0Zm9ybSBhdCBsZWFzdC4gVGhpcyBjaGFuZ2UN
Cm9ubHkgbW9kaWZpZXMgZm9yIERDTiBmYW1pbGllcywgc28gUlg1ODAgd291bGRuJ3QgYmUgYWZm
ZWN0ZWQuDQoNCkxlbw0KDQo+IA0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
