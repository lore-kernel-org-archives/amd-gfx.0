From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: partial revert "cleanup ttm_tt_(unbind|destroy)"
 v2
Date: Thu, 4 Aug 2016 12:18:13 +0200
Message-ID: <53b30c35-782a-2668-ea8b-199efae8b650@vodafone.de>
References: <1469193013-11482-1-git-send-email-deathsimple@vodafone.de>
 <95d462b5-7c20-2f40-c406-48f5aece0817@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <95d462b5-7c20-2f40-c406-48f5aece0817-otUistvHUpPR7s880joybQ@public.gmane.org>
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

QW0gMjcuMDcuMjAxNiB1bSAwNDoyNiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIyLjA3
LjIwMTYgMjI6MTAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEZyb206IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4KPj4gV2Ugc3RpbGwgbmVlZCB0byB1
bmJpbmQgZXhwbGljaXRlbHkgZHVyaW5nIGEgbW92ZS4KPiBUaGlzIGNoYW5nZSBmaXhlZCBhIGhh
bmcgZm9yIG1lIHdoZW4gcnVubmluZyB0aGUgcGlnbGl0IHRlc3QKPiBtYXgtdGV4dHVyZS1zaXpl
IHdpdGggdGhlIHJhZGVvbiBkcml2ZXIgb24gS2F2ZXJpLgo+Cj4gSG93ZXZlciwgdGhlcmUncyBz
dGlsbCBhIHNpbWlsYXIgaGFuZyBsZWZ0IHdoZW4gbGV0dGluZyB0aGUgcGlnbGl0IHRlc3QKPiB0
ZXgzZC1tYXhzaXplIHJ1biBjb25jdXJyZW50bHkgd2l0aCBvdGhlciB0ZXN0cyAocnVubmluZyB0
ZXgzZC1tYXhzaXplCj4gYWxvbmUgZG9lc24ndCBoYW5nLCBidXQgZmFpbHMgZHVlIHRvIHJ1bm5p
bmcgb3V0IG9mIEdQVSBtZW1vcnk7IHRoYXQncyBhCj4gcmVjZW50IHJhZGVvbnNpIHJlZ3Jlc3Np
b24pLiBUaGVyZSBhcmUKPgo+ICAgW1RUTV0gQnVmZmVyIGV2aWN0aW9uIGZhaWxlZAo+Cj4gbWVz
c2FnZXMgaW4gZG1lc2cgc2hvcnRseSBiZWZvcmUgdGhlIGhhbmcuCj4KPiBJIGhhdmVuJ3Qgc2Vl
biBzdWNoIGhhbmdzIHdpdGggb2xkZXIga2VybmVscy4gQW55IGlkZWFzIG9mZmhhbmQgd2hhdCB0
aGUKPiBwcm9ibGVtIGNvdWxkIGJlPyBJZiBub3QsIEknbGwgdHJ5IGJpc2VjdGluZy4KT2YgaGFu
ZCBJIHdvdWxkIGNlcnRhaW5seSB0cnkgdG8gZGlzYWJsZSBwaXBlbGluZWQgYnVmZmVyIG1vdmVz
LgoKWW91IGNvdWxkIGFsc28gdHJ5IHRvIHJldmVydCAiNmI1Zjc3Nzk5Mjc0YzE1MWY2Y2M1NDY3
YzVhYmU2YWQzNjZhOTY1ZSAKZHJtL2FtZGdwdTogcmVtb3ZlIHByZSBtb3ZlIHdhaXQiLgoKUmVn
YXJkcywKQ2hyaXN0aWFuLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
