From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: access stolen VRAM directly on KV/KB
Date: Mon, 7 Nov 2016 10:33:46 +0100
Message-ID: <7be5b56d-fae3-d71b-485f-01227172859d@vodafone.de>
References: <1478510481-1768-1-git-send-email-deathsimple@vodafone.de>
 <9d218698-d588-090a-eb47-d0142cfdb623@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9d218698-d588-090a-eb47-d0142cfdb623-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDcuMTEuMjAxNiB1bSAxMDoyOSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDA3LzEx
LzE2IDA2OjIxIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBGcm9tOiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Cj4+IFdlIGRvbid0IG5lZWQgdG8g
dXNlIHRoZSBQQ0kgQkFSIG9uIEFQVXMuIFRoaXMgYWxsb3dzIHVzIHRvIGFjY2Vzcwo+PiB0aGUg
ZnVsbCBWUkFNIGRpcmVjdGx5IHdpdGhvdXQgYmVpbmcgbGltaXRlZCBieSB0aGUgQkFSIHNpemUu
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KPiBUaGUgc2VyaWVzIGlzCj4KPiBSZXZpZXdlZC1ieTogTWljaGVsIETDpG56ZXIg
PG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4KPgo+IFdlIGNvdWxkIGFsc28gZHJvcCB0aGUgSERQ
IGZsdXNoZXMgLyBpbnZhbGlkYXRlcyBpbiB0aGlzIGNhc2UsIHJpZ2h0PwpDb3VsZCBiZSwgYnV0
IEknbSBub3QgMTAwJSBzdXJlIGhvdyB0aG9zZSBhcmUgYWN0dWFsbHkgd2lyZWQgdXAgb24gQVBV
cy4KCk1pZ2h0IGJlIHRoYXQgdGhleSBhcmUgTk9QcyBhbnl3YXksIGJ1dCBjb3VsZCBiZSB0aGF0
IGF0IGxlYXN0IHRoZSAKZmx1c2hlcyBhcmUgc3RpbGwgdml0YWwuCgpSZWdhcmRzLApDaHJpc3Rp
YW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
