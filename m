From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: Refactor flip into prepare submit and
 submit. (v2)"
Date: Fri, 28 Apr 2017 10:23:49 +0200
Message-ID: <a9e60838-eee6-f420-7c66-210158f72262@vodafone.de>
References: <20170427081838.2424-1-michel@daenzer.net>
 <4e89bf8d-1620-e0e8-a331-9e2d53341635@vodafone.de>
 <64d1457a-8edb-b4bd-8b22-c8cad1bc53d9@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <64d1457a-8edb-b4bd-8b22-c8cad1bc53d9-otUistvHUpPR7s880joybQ@public.gmane.org>
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

QW0gMjguMDQuMjAxNyB1bSAwODo1OSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDI3LzA0
LzE3IDA3OjA0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyNy4wNC4yMDE3IHVt
IDEwOjE4IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+PiBGcm9tOiBNaWNoZWwgRMOkbnplciA8
bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPj4+Cj4+PiBUaGlzIHJldmVydHMgY29tbWl0IGNiMzQx
YTMxOWY3ZTY2Zjg3OWQ2OWFmOTI5YzNkYWRmYzFhOGYzMWUuCj4+Pgo+Pj4gVGhlIHB1cnBvc2Ug
b2YgdGhlIHJlZmFjdG9yIHdhcyBmb3IgYW1kZ3B1X2NydGNfcHJlcGFyZS9zdWJtaXRfZmxpcCB0
bwo+Pj4gYmUgdXNlZCBieSB0aGUgREMgY29kZSwgYnV0IHRoYXQncyBubyBsb25nZXIgdGhlIGNh
c2UuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVy
QGFtZC5jb20+Cj4gWy4uLl0KPgo+Pj4gK3BmbGlwX2NsZWFudXA6Cj4+PiArICAgIGlmICh1bmxp
a2VseShhbWRncHVfYm9fcmVzZXJ2ZShuZXdfYWJvLCBmYWxzZSkgIT0gMCkpIHsKPj4gV2VsbCBo
ZXJlIHdlIGV4cGxpY2l0bHkgc2hvdWxkbid0IHVzZSBhbiBpbnRlcnJ1cHRpYmxlIHdhaXQsIG90
aGVyd2lzZQo+PiB3ZSB3b3VsZCBrZWVwIHRoZSBCTyBwaW5uZWQuCj4gTWFrZXMgc2Vuc2UsIGJ1
dCB0aGlzIHBhdGNoIGp1c3QgcmV2ZXJ0cyBhbm90aGVyIGNvbW1pdCBhbmQgbW92ZXMgdGhpcwo+
IGNvZGUgdW5jaGFuZ2VkLiBJJ2xsIHNlbmQgYSBmb2xsb3ctdXAgcGF0Y2ggd2hpY2ggZml4ZXMg
dGhpcyAocG9zc2libHkKPiBhbHNvIGluIG90aGVyIGVycm9yIHBhdGhzKS4KClNvdW5kcyBnb29k
LCBhbmQgZmVlbCBmcmVlIHRvIENDIG1lIGFzIHdlbGwuCgpDaHJpc3RpYW4uCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
