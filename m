From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/ttm: cleanup and optimize ttm_bo_mem_compat
Date: Thu, 30 Mar 2017 10:41:37 +0200
Message-ID: <c3a8cfd1-2f43-831c-6dac-80c330fc5278@vodafone.de>
References: <1490792146-2218-1-git-send-email-deathsimple@vodafone.de>
 <1490792146-2218-2-git-send-email-deathsimple@vodafone.de>
 <0aeb9046-86c6-f14f-490e-cbf74079e107@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0aeb9046-86c6-f14f-490e-cbf74079e107-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMzAuMDMuMjAxNyB1bSAwODozOCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDI5LzAz
LzE3IDA5OjU1IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBGcm9tOiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Cj4+IE5vIG5lZWQgdG8gaW1wbGVt
ZW50IHRoZSBzYW1lIGxvZ2ljIHR3aWNlLiBBbHNvIGNoZWNrIGlmIHRoZSBidXN5IHBsYWNlbWVu
dHMKPj4gYXJlIGlkZW50aWNhbCB0byB0aGUgYWxyZWFkeSBzY2FubmVkIHBsYWNlbWVudHMgYmVm
b3JlIGNoZWNraW5nIHRoZW0uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBbLi4uXQo+Cj4+IEBAIC0xMDc3LDYgKzEwNjUs
MjMgQEAgYm9vbCB0dG1fYm9fbWVtX2NvbXBhdChzdHJ1Y3QgdHRtX3BsYWNlbWVudCAqcGxhY2Vt
ZW50LAo+PiAgIAkJICAgICgqbmV3X2ZsYWdzICYgbWVtLT5wbGFjZW1lbnQgJiBUVE1fUExfTUFT
S19NRU0pKQo+PiAgIAkJCXJldHVybiB0cnVlOwo+PiAgIAl9Cj4+ICsJcmV0dXJuIGZhbHNlOwo+
PiArfQo+PiArCj4+ICtib29sIHR0bV9ib19tZW1fY29tcGF0KHN0cnVjdCB0dG1fcGxhY2VtZW50
ICpwbGFjZW1lbnQsCj4+ICsJCSAgICAgICBzdHJ1Y3QgdHRtX21lbV9yZWcgKm1lbSwKPj4gKwkJ
ICAgICAgIHVpbnQzMl90ICpuZXdfZmxhZ3MpCj4+ICt7Cj4+ICsJaWYgKHR0bV9ib19wbGFjZXNf
Y29tcGF0KHBsYWNlbWVudC0+cGxhY2VtZW50LCBwbGFjZW1lbnQtPm51bV9wbGFjZW1lbnQsCj4+
ICsJCQkJIG1lbSwgbmV3X2ZsYWdzKSkKPj4gKwkJcmV0dXJuIHRydWU7Cj4+ICsKPj4gKwlpZiAo
KHBsYWNlbWVudC0+YnVzeV9wbGFjZW1lbnQgIT0gcGxhY2VtZW50LT5wbGFjZW1lbnQgfHwKPj4g
KwkgICAgIHBsYWNlbWVudC0+bnVtX2J1c3lfcGxhY2VtZW50ICE9IHBsYWNlbWVudC0+bnVtX3Bs
YWNlbWVudCkgJiYKPiAJICAgICBwbGFjZW1lbnQtPm51bV9idXN5X3BsYWNlbWVudCA+IHBsYWNl
bWVudC0+bnVtX3BsYWNlbWVudCkgJiYKPgo+ID8KCkdvb2QgaWRlYS4KCkNocmlzdGlhbi4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
