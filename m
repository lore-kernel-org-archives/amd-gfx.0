From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: partial revert "cleanup ttm_tt_(unbind|destroy)"
 v2
Date: Fri, 5 Aug 2016 10:33:48 +0900
Message-ID: <3ab5dda6-6fae-d3eb-b257-7519615f0a1b@daenzer.net>
References: <1469193013-11482-1-git-send-email-deathsimple@vodafone.de>
 <95d462b5-7c20-2f40-c406-48f5aece0817@daenzer.net>
 <53b30c35-782a-2668-ea8b-199efae8b650@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <53b30c35-782a-2668-ea8b-199efae8b650-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDQuMDguMjAxNiAxOToxOCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyNy4wNy4y
MDE2IHVtIDA0OjI2IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIyLjA3LjIwMTYgMjI6
MTAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Pgo+Pj4gV2Ugc3RpbGwgbmVlZCB0byB1bmJpbmQg
ZXhwbGljaXRlbHkgZHVyaW5nIGEgbW92ZS4KPj4gVGhpcyBjaGFuZ2UgZml4ZWQgYSBoYW5nIGZv
ciBtZSB3aGVuIHJ1bm5pbmcgdGhlIHBpZ2xpdCB0ZXN0Cj4+IG1heC10ZXh0dXJlLXNpemUgd2l0
aCB0aGUgcmFkZW9uIGRyaXZlciBvbiBLYXZlcmkuCj4+Cj4+IEhvd2V2ZXIsIHRoZXJlJ3Mgc3Rp
bGwgYSBzaW1pbGFyIGhhbmcgbGVmdCB3aGVuIGxldHRpbmcgdGhlIHBpZ2xpdCB0ZXN0Cj4+IHRl
eDNkLW1heHNpemUgcnVuIGNvbmN1cnJlbnRseSB3aXRoIG90aGVyIHRlc3RzIChydW5uaW5nIHRl
eDNkLW1heHNpemUKPj4gYWxvbmUgZG9lc24ndCBoYW5nLCBidXQgZmFpbHMgZHVlIHRvIHJ1bm5p
bmcgb3V0IG9mIEdQVSBtZW1vcnk7IHRoYXQncyBhCj4+IHJlY2VudCByYWRlb25zaSByZWdyZXNz
aW9uKS4gVGhlcmUgYXJlCj4+Cj4+ICAgW1RUTV0gQnVmZmVyIGV2aWN0aW9uIGZhaWxlZAo+Pgo+
PiBtZXNzYWdlcyBpbiBkbWVzZyBzaG9ydGx5IGJlZm9yZSB0aGUgaGFuZy4KPj4KPj4gSSBoYXZl
bid0IHNlZW4gc3VjaCBoYW5ncyB3aXRoIG9sZGVyIGtlcm5lbHMuIEFueSBpZGVhcyBvZmZoYW5k
IHdoYXQgdGhlCj4+IHByb2JsZW0gY291bGQgYmU/IElmIG5vdCwgSSdsbCB0cnkgYmlzZWN0aW5n
Lgo+IE9mIGhhbmQgSSB3b3VsZCBjZXJ0YWlubHkgdHJ5IHRvIGRpc2FibGUgcGlwZWxpbmVkIGJ1
ZmZlciBtb3Zlcy4KPiAKPiBZb3UgY291bGQgYWxzbyB0cnkgdG8gcmV2ZXJ0ICI2YjVmNzc3OTky
NzRjMTUxZjZjYzU0NjdjNWFiZTZhZDM2NmE5NjVlCj4gZHJtL2FtZGdwdTogcmVtb3ZlIHByZSBt
b3ZlIHdhaXQiLgoKVGhpcyBpcyB1c2luZyB0aGUgcmFkZW9uIGRyaXZlci4KCgotLSAKRWFydGhs
aW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93
d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
