From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Disallow enabling CRTC without primary
 plane with FB
Date: Thu, 19 Apr 2018 19:00:04 +0200
Message-ID: <d341d108-d04d-4b6e-0e34-e530fb1a365c@daenzer.net>
References: <20180418202647.25532-1-harry.wentland@amd.com>
 <9e38b52d-9e9b-b4df-e5bb-9bda1862c18a@daenzer.net>
 <3c912b9f-6756-e585-c7a7-63170e752688@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3c912b9f-6756-e585-c7a7-63170e752688-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Shirish.S-5C7GfCeVMHo@public.gmane.org

T24gMjAxOC0wNC0xOSAwNDozOCBQTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gT24gMjAxOC0w
NC0xOSAwMzo0MyBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+IE9uIDIwMTgtMDQtMTggMTA6
MjYgUE0sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+Pj4gVGhlIGJlbG93IGNvbW1pdAo+Pj4KPj4+
ICAgICAiZHJtL2F0b21pYzogVHJ5IHRvIHByZXNlcnZlIHRoZSBjcnRjIGVuYWJsZWQgc3RhdGUg
aW4gZHJtX2F0b21pY19yZW1vdmVfZmIsIHYyIgo+Pj4KPj4+IGludHJvZHVjZXMgYSBzbGlnaHQg
YmVoYXZpb3JhbCBjaGFuZ2UgdG8gcm1mYi4gSW5zdGVhZCBvZiBkaXNhYmxpbmcgYSBjcnRjCj4+
PiB3aGVuIHRoZSBwcmltYXJ5IHBsYW5lIGlzIGRpc2FibGVkLCBpdCBub3cgcHJlc2VydmVzIGl0
Lgo+Pj4KPj4+IFNpbmNlIERDIGlzIGN1cnJlbnRseSBub3QgZXF1aXBwZWQgdG8gaGFuZGxlIHRo
aXMgd2UgbmVlZCB0byBmYWlsIHN1Y2gKPj4+IGEgY29tbWl0LCBvdGhlcndpc2Ugd2UgbWlnaHQg
c2VlIGEgY29ycnVwdGVkIHNjcmVlbi4KPj4KPj4gSG93IGRvZXMgdGhlIGNhbGxlciByZWFjdCB0
byBmYWlsaW5nIHN1Y2ggYSBjb21taXQ/Cj4gCj4gVGhlIGNhbGxlciAoZHJtX2F0b21pY19yZW1v
dmVfZmIgaW4gdGhpcyBjYXNlKSB3aWxsIHJldHJ5IHdpdGggdGhlIG9sZCBiZWhhdmlvciBhbmQg
ZGlzYWJsZSB0aGUgQ1JUQy4KCkkgc2VlLCB0aGFua3MuCgpGV0lXLCBzdG9wcGluZyBnZG0zIHdv
cmtzIGZpbmUgd2l0aCB0aGlzIHBhdGNoIGFzIHdlbGwuCgpUZXN0ZWQtYnk6IE1pY2hlbCBEw6Ru
emVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56
ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJl
IHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBY
IGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
