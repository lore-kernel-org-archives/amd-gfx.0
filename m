From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Make KIQ read/write register routine be atomic
Date: Fri, 30 Jun 2017 09:57:03 +0200
Message-ID: <d9834700-f977-e5d5-2c79-7c2332ba44e9@vodafone.de>
References: <1498770496-28032-1-git-send-email-Shaoyun.Liu@amd.com>
 <14d97048-a0ba-69cd-1eac-e82c4462c51f@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <14d97048-a0ba-69cd-1eac-e82c4462c51f-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMzAuMDYuMjAxNyB1bSAwMzoyMSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDMwLzA2
LzE3IDA2OjA4IEFNLCBTaGFveXVuIExpdSB3cm90ZToKPj4gMS4gVXNlIHNwaW4gbG9jayBpbnN0
ZWFkIG9mIG11dGV4IGluIEtJUQo+PiAyLiBEaXJlY3RseSB3cml0ZSB0byBLSVEgZmVuY2UgYWRk
cmVzcyBpbnN0ZWFkIG9mIHVzaW5nIGZlbmNlX2VtaXQoKQo+PiAzLiBEaXNhYmxlIHRoZSBpbnRl
cnJ1cHQgZm9yIEtJUSByZWFkL3dyaXRlIGFuZCB1c2UgQ1BVIHBvbGxpbmcKPiBUaGlzIGxpc3Qg
aW5kaWNhdGVzIHRoYXQgdGhpcyBwYXRjaCBzaG91bGQgYmUgc3BsaXQgdXAgaW4gYXQgbGVhc3Qg
dGhyZWUKPiBwYXRjaGVzLiA6KQpZZWFoLCBhcGFydCBmcm9tIHRoYXQgaXMgaXMgbm90IGEgZ29v
ZCBpZGVhIHRvIG1lc3Mgd2l0aCB0aGUgZmVuY2UgCmludGVybmFscyBkaXJlY3RseSBpbiB0aGUg
S0lRIGNvZGUsIHBsZWFzZSBhZGQgYSBoZWxwZXIgaW4gdGhlIGZlbmNlIApjb2RlIGZvciB0aGlz
LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
