From: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: KASAN caught amdgpu / HMM use-after-free
Date: Wed, 27 Feb 2019 17:14:04 +0000
Message-ID: <83fde7eb-abab-e770-efd5-89bc9c39fdff@amd.com>
References: <e8466985-a66b-468b-5fff-6e743180da67@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e8466985-a66b-468b-5fff-6e743180da67-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <CCAA4E538C783F46A55E3D53C5408631-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgTWljaGVsLA0KDQpZZXMsIEkgZm91bmQgdGhlIHNhbWUgaXNzdWUgYW5kIHRoZSBidWcgaGFz
IGJlZW4gZml4ZWQgYnkgSmVyb21lOg0KDQo4NzZiNDYyMTIwYWEgbW0vaG1tOiB1c2UgcmVmZXJl
bmNlIGNvdW50aW5nIGZvciBITU0gc3RydWN0DQoNClRoZSBmaXggaXMgb24gaG1tLWZvci01LjEg
YnJhbmNoLCBJIGNoZXJyeS1waWNrIGl0IGludG8gbXkgbG9jYWwgYnJhbmNoIA0KdG8gd29ya2Fy
b3VuZCB0aGUgaXNzdWUuDQoNClJlZ2FyZHMsDQpQaGlsaXANCg0KT24gMjAxOS0wMi0yNyAxMjow
MiBwLm0uLCBNaWNoZWwgRMOkbnplciB3cm90ZToNCj4gDQo+IFNlZSB0aGUgYXR0YWNoZWQgZG1l
c2cgZXhjZXJwdC4gSSd2ZSBoaXQgdGhpcyBhIGZldyB0aW1lcyBydW5uaW5nIHBpZ2xpdA0KPiB3
aXRoIGFtZC1zdGFnaW5nLWRybS1uZXh0LCBmaXJzdCBvbiBGZWJydWFyeSAyMm5kLg0KPiANCj4g
VGhlIG1lbW9yeSB3YXMgZnJlZWQgYWZ0ZXIgY2FsbGluZyBobW1fbWlycm9yX3VucmVnaXN0ZXIg
aW4NCj4gYW1kZ3B1X21uX2Rlc3Ryb3kuDQo+IA0KPiANCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
