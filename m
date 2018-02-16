From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 xf86-video-amdgpu] Don't bail from
 drmmode_set_desired_modes immediately
Date: Fri, 16 Feb 2018 09:18:10 -0500
Message-ID: <94783b02-adff-eece-18bd-1f3e82af8959@amd.com>
References: <20180215173931.11298-1-michel@daenzer.net>
 <20180215174900.11747-1-michel@daenzer.net>
 <8c0dbe40-dfd0-9801-1077-2a76c3124dfd@amd.com>
 <117021cd-1a9d-d9e2-a9ad-8e685ca272c8@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <117021cd-1a9d-d9e2-a9ad-8e685ca272c8-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMi0xNiAwMzoyOSBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
Mi0xNSAxMDowNSBQTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4+IE9uIDIwMTgtMDItMTUgMTI6
NDkgUE0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+Pj4gRnJvbTogTWljaGVsIETDpG56ZXIgPG1p
Y2hlbC5kYWVuemVyQGFtZC5jb20+Cj4+Pgo+Pj4gSWYgd2UgZmFpbCB0byBmaW5kIG9yIHNldCB0
aGUgbW9kZSBmb3IgYSBDUlRDLCBrZWVwIHRyeWluZyBmb3IgdGhlCj4+PiByZW1haW5pbmcgQ1JU
Q3MsIGFuZCBvbmx5IHJldHVybiBGQUxTRSBpZiB3ZSBmYWlsZWQgZm9yIGFsbCBDUlRDcyB0aGF0
Cj4+PiBzaG91bGQgYmUgb24uCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIg
PG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4+Cj4+IFRoYW5rcy4gVGhpcyBzaG91bGQgaGVscCB3
aGVuIGJhbmR3aWR0aCBjaGVja3MgaW4gREMgZmFpbC4KPiAKPiBJdCBtaWdodCBpbiBzb21lIGNh
c2VzLCB0aG91Z2ggSSdtIGFmcmFpZCBpdCB3b24ndCBtYWtlIGFueSBkaWZmZXJlbmNlCj4gaW4g
dGhlIGNhc2UgeW91J3JlIHByb2JhYmx5IHRoaW5raW5nIG9mIChub3QgZW5vdWdoIGJhbmR3aWR0
aCBmb3IgMyA0Swo+IG1vbml0b3JzIGNvbm5lY3RlZCB0byBhbiBBUFUpLCBpbiB0aGF0IGNhc2Ug
dHdvIG1vbml0b3JzIHNob3VsZCBsaWdodCB1cAo+IGVpdGhlciB3YXkuIEJ1dCBpZiB0aGVyZSB3
YXMgZS5nLiBhIGZvdXJ0aCAxMDgwIG1vbml0b3IgY29ubmVjdGVkLCB0aGF0Cj4gbWlnaHQgbGln
aHQgdXAgbm93LCB3aGVyZWFzIGl0IG1pZ2h0IG5vdCBoYXZlIGJlZm9yZS4KPiAKCkFyZSB5b3Ug
c2F5aW5nIHRoYXQgaWYgMyBAIDRrNjAgZmFpbCBERFggb3IgWCB3aWxsIHJldHJ5IGF0IGxvd2Vy
IHJlZnJlc2ggcmF0ZSBmb3Igb25lIChvciBhbGwgQ1JUQ3MpPwoKSGFycnkKCj4gCj4+IEFja2Vk
LWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPiAKPiBUaGFua3Mh
Cj4gCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
