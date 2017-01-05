From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: code review of amdgpu change
Date: Thu, 5 Jan 2017 10:19:43 +0100
Message-ID: <a95fedf0-9158-e32e-9370-916fb0b572fa@vodafone.de>
References: <CY1PR12MB052498D1217DC8E697C5209FE1610@CY1PR12MB0524.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY1PR12MB052498D1217DC8E697C5209FE1610-1s8aH8ViOEdfE5pBYayoAQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Lin, Amber" <Amber.Lin-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Russell,
 Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

SW4gZ2VuZXJhbCBwbGVhc2UgZG9uJ3QgdXNlIEhUTUwgbWFpbCBmb3IgcHVibGljIG1haWxpbmcg
bGlzdHMsIHRob3NlIAptYWlscyBhcmUgdXN1YWxseSByZWplY3RlZCBieSBtb3N0IGxpc3RzIChi
dXQgbm90IGFtZC1nZngpLgoKQXBhcnQgZnJvbSB0aGF0IHRoZSBwYXRjaCBsb29rcyBzYW5lIHRv
IG1lIGFuZCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuIApLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAwNC4wMS4yMDE3IHVtIDIwOjU0IHNj
aHJpZWIgTGluLCBBbWJlcjoKPgo+IEN1cnJlbnQgYW1kZ3B1IGFsbG93cyB0byBkaXNhYmxlIFBD
SSBJTyBiYXIgYnV0IHRoZSBkbWVzZyBzdGlsbCBwcmludHMgCj4gaXQgYXMgYW4gZXJyb3IuIEl0
IG1pc2xlYWRzIGEgZmFsc2UgYWxhcm0gdG8gdGhlIHVzZXIgYW5kIHdlIGFyZSAKPiByZWNlaXZp
bmcgdGhvc2UgcmVwb3J0cyBmcm9tIHRpbWUgdG8gdGltZS4gQXR0YWNoZWQgcGF0Y2ggdHVybnMg
dGhpcyAKPiBwcmludCBmcm9tIEVSUk9SIHRvIElORk8uCj4KPiAqKgo+Cj4gKkFtYmVyIExpbioK
Pgo+IFZlcnRpY2FsIFdvcmtzdGF0aW9uL0NvbXB1dGUKPgo+IHg3MjEzNQo+Cj4gKDI4OSk2OTUt
MjEzNQo+Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
