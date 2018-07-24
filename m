From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix RLC safe mode test in
 gfx_v9_0_enter_rlc_safe_mode
Date: Tue, 24 Jul 2018 19:24:00 +0200
Message-ID: <58d76a9a-2747-1293-cc1c-3a31ef4605b0@daenzer.net>
References: <20180720163301.9376-1-michel@daenzer.net>
 <cd8a8d33-2fa5-6cdc-fe62-86a38f04c207@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cd8a8d33-2fa5-6cdc-fe62-86a38f04c207-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
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
To: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNy0yNCAwNzoyMCBQTSwgUGF1bCBNZW56ZWwgd3JvdGU6Cj4gT24gMDcvMjAvMTgg
MTg6MzMsIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+PiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWlj
aGVsLmRhZW56ZXJAYW1kLmNvbT4KPj4KPj4gV2Ugd2VyZSB0ZXN0aW5nIHRoZSByZWdpc3RlciBv
ZmZzZXQsIGluc3RlYWQgb2YgdGhlIHZhbHVlIHN0b3JlZCBpbiB0aGUKPj4gcmVnaXN0ZXIsIHRo
ZXJlZm9yZSBhbHdheXMgdGltaW5nIG91dCB0aGUgbG9vcC4KPj4KPj4gVGhpcyByZWR1Y2VzIHN1
c3BlbmQgdGltZSBvZiB0aGUgc3lzdGVtIGluIHRoZSBidWcgcmVwb3J0IGJlbG93IGJ5IH42MDAK
Pj4gbXMuCj4+Cj4+IEJ1Z3ppbGxhOiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnLzEwNzI3
Nwo+PiBUZXN0ZWQtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+Cj4+IFNp
Z25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+IAo+
IFvigKZdCj4gCj4gQXMgdGhpcyBsaW5lIGlzIHByZXNlbnQgc2luY2UgdjQuMTItcmMxLCBjb3Vs
ZCB5b3UgcGxlYXNlIHRhZyB0aGlzIHRvIGJlCj4gcGlja2VkIHVwIGZvciB0aGUgc3RhYmxlIHNl
cmllcyAoNC4xNC54KT8KCkkgYWRkZWQgdGhlIENjOiBzdGFibGUgdGFnIGJlZm9yZSBwdXNoaW5n
IHRvIHRoZSBpbnRlcm5hbAphbWQtc3RhZ2luZy1kcm0tbmV4dCBicmFuY2guCgoKLS0gCkVhcnRo
bGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8v
d3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
