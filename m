From: Nicholas Kazlauskas <nkazlaus-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Add fast path for cursor plane updates
Date: Thu, 6 Dec 2018 15:59:34 +0000
Message-ID: <78e6ff7a-c7f4-324b-7fb2-9df282cb2c7e@amd.com>
References: <20181205195907.9501-1-nicholas.kazlauskas@amd.com>
 <8b305d43-56e1-5505-95d3-35e92f3f8494@amd.com>
 <6352276b-5d47-94ea-2dd1-0f955ceed408@amd.com>
 <73996dfc-1cd6-e707-9e2b-48a5c89d6cac@amd.com>
 <5c4c64a1-cc84-e9c2-6275-ca8ac76237b1@amd.com>
 <a7bad892-8215-16a8-65a6-328533395d03@amd.com>
 <13f4b0bc-fcda-be57-2416-aa3ba5ff065c@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <13f4b0bc-fcda-be57-2416-aa3ba5ff065c-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <7A831281685CD640BB583FF3BFD3FD8A-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0xMi0wNiAxMDozNiBhLm0uLCBHcm9kem92c2t5LCBBbmRyZXkgd3JvdGU6DQo+IE5v
dCBhbiBleHBlcnQgb24gRnJlZXN5bmMgc28gbWF5YmUgc3R1cGlkIHF1ZXN0aW9uIGJ1dCBmcm9t
IGhlIGNvbW1lbnQNCj4gbG9va3MgbGlrZSB0aGlzIHBpcGUgbG9ja2luZyBpcyBvbmx5IGZvciB0
aGUgc2FrZSBvZiBGcmVlc3luYyBtb2RlIHRoZXJlDQo+IC0gd2h5IGlzIGl0IHRoZW4gY2FsbGVk
IHVuY29uZGl0aW9uYWxseSB3L28gY2hlY2tpbmcgaWYgeW91IGV2ZW4gcnVuIGluDQo+IEZyZWVz
eW5jIG1vZGUgPw0KPiANCj4gQW5kcmV5DQpJIGRvbid0IHRoaW5rIHRoZXJlJ3MgYW55IHNvcnQg
b2Ygc3RhdGUgdHJhY2tpbmcgZG9uZSBpbiBEQyBmb3IgRnJlZVN5bmMgDQpzdGF0ZSBjaGFuZ2Vz
IG9uIGEgc3RyZWFtIHNvIGl0IHdhcyBwcm9iYWJseSBlYXNpZXIgdG8gZG8gdGhpcy4gR2l2ZW4g
DQp0aGUgYWdlIG9mIHRoZSBwaXBlIGxvY2sgYWRkaXRpb24gSSB3b3VsZCBiZSB3b3JyaWVkIGFi
b3V0IG90aGVyIA0KYmVoYXZpb3IgcmVseWluZyBvbiBpdCBub3cgaWYgaXQgd2FzIGp1c3QgY29u
ZGl0aW9uYWxseSBkb25lIG9uIHRoYXQuDQoNCkluIHByYWN0aWNlIEkgdGhpbmsgdGhlIHdvcnN0
IGNhc2UgZWZmZWN0IG9mIGd1YXJkaW5nIHRoZXNlIGNhbGxzIHdpdGggYSANCm11dGV4IGlzIDwx
MDB1cyBvZiBkZWxheS4gVGhhdCdzIGZvciB0d28gc2VwYXJhdGUgdGhyZWFkcyBpc3N1aW5nIHR3
byANCmNvbW1pdHMgYXQgdGhlIHNhbWUgdGltZSB3aXRoIHRoZSBwbGFuZXMgY2hhbmdlZC4NCg0K
TmljaG9sYXMgS2F6bGF1c2thcw0KDQo+IA0KPiANCj4gT24gMTIvMDYvMjAxOCAwODo0MiBBTSwg
S2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6DQo+PiBBIHJlYWRlci93cml0ZXIgbG9jayB3b3Vs
ZG4ndCBoZWxwIGhlcmUsIGFjdHVhbGx5Lg0KPj4NCj4+IEZhc3QgdXBkYXRlcyAoYW5kIHBhZ2Ug
ZmxpcHMgaW4gcGFydGljdWxhcikgbmVlZCB0byBsb2NrIHRoZSBwaXBlIGFzDQo+PiB3ZWxsLCBz
ZWU6IGNvbW1pdF9wbGFuZXNfZm9yX3N0cmVhbS4NCj4+DQo+PiBOaWNob2xhcyBLYXpsYXVza2Fz
DQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
