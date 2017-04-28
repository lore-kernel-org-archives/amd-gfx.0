From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: Refactor flip into prepare submit and
 submit. (v2)"
Date: Fri, 28 Apr 2017 10:57:53 +0200
Message-ID: <ab10cee1-ed96-6055-d1e4-ea82b08101a8@vodafone.de>
References: <20170427081838.2424-1-michel@daenzer.net>
 <4e89bf8d-1620-e0e8-a331-9e2d53341635@vodafone.de>
 <64d1457a-8edb-b4bd-8b22-c8cad1bc53d9@daenzer.net>
 <a9e60838-eee6-f420-7c66-210158f72262@vodafone.de>
 <36fdc234-42e9-5e94-8d6a-886ff5ad5ea3@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <36fdc234-42e9-5e94-8d6a-886ff5ad5ea3-otUistvHUpPR7s880joybQ@public.gmane.org>
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

QW0gMjguMDQuMjAxNyB1bSAxMDo0OCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDI4LzA0
LzE3IDA1OjIzIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyOC4wNC4yMDE3IHVt
IDA4OjU5IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+PiBPbiAyNy8wNC8xNyAwNzowNCBQTSwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBBbSAyNy4wNC4yMDE3IHVtIDEwOjE4IHNjaHJp
ZWIgTWljaGVsIETDpG56ZXI6Cj4+Pj4+IEZyb206IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFl
bnplckBhbWQuY29tPgo+Pj4+Pgo+Pj4+PiBUaGlzIHJldmVydHMgY29tbWl0IGNiMzQxYTMxOWY3
ZTY2Zjg3OWQ2OWFmOTI5YzNkYWRmYzFhOGYzMWUuCj4+Pj4+Cj4+Pj4+IFRoZSBwdXJwb3NlIG9m
IHRoZSByZWZhY3RvciB3YXMgZm9yIGFtZGdwdV9jcnRjX3ByZXBhcmUvc3VibWl0X2ZsaXAgdG8K
Pj4+Pj4gYmUgdXNlZCBieSB0aGUgREMgY29kZSwgYnV0IHRoYXQncyBubyBsb25nZXIgdGhlIGNh
c2UuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFl
bnplckBhbWQuY29tPgo+Pj4gWy4uLl0KPj4+Cj4+Pj4+ICtwZmxpcF9jbGVhbnVwOgo+Pj4+PiAr
ICAgIGlmICh1bmxpa2VseShhbWRncHVfYm9fcmVzZXJ2ZShuZXdfYWJvLCBmYWxzZSkgIT0gMCkp
IHsKPj4+PiBXZWxsIGhlcmUgd2UgZXhwbGljaXRseSBzaG91bGRuJ3QgdXNlIGFuIGludGVycnVw
dGlibGUgd2FpdCwgb3RoZXJ3aXNlCj4+Pj4gd2Ugd291bGQga2VlcCB0aGUgQk8gcGlubmVkLgo+
Pj4gTWFrZXMgc2Vuc2UsIGJ1dCB0aGlzIHBhdGNoIGp1c3QgcmV2ZXJ0cyBhbm90aGVyIGNvbW1p
dCBhbmQgbW92ZXMgdGhpcwo+Pj4gY29kZSB1bmNoYW5nZWQuCj4gQWN0dWFsbHksIGFmdGVyIHJl
YmFzaW5nIHRvIGN1cnJlbnQgYW1kLXN0YWdpbmctNC45LCBpdCBhbHJlYWR5IGxvb2tzCj4gbGlr
ZSB5b3Ugc3VnZ2VzdGVkLiBDYW4gSSBnZXQgeW91ciBSZXZpZXdlZC1ieSBmb3IgdGhhdD8KClll
cywgZmVlbCBmcmVlIHRvIGFkZCBteSByYi4KCkNocmlzdGlhbi4KCj4KPgo+Pj4gSSdsbCBzZW5k
IGEgZm9sbG93LXVwIHBhdGNoIHdoaWNoIGZpeGVzIHRoaXMgKHBvc3NpYmx5IGFsc28gaW4gb3Ro
ZXIKPj4+IGVycm9yIHBhdGhzKS4KPj4gU291bmRzIGdvb2QsIGFuZCBmZWVsIGZyZWUgdG8gQ0Mg
bWUgYXMgd2VsbC4KPiBEb25lLgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
