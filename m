From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add HDMI audio support for si dce6
Date: Tue, 21 Feb 2017 13:53:27 +0100
Message-ID: <4f505691-7c10-a739-4f96-5b585188e49f@vodafone.de>
References: <1487673594-1452-1-git-send-email-Xiaojie.Yuan@amd.com>
 <d2ba0088-cac6-7674-a6e7-d00d7f69b68c@folklore1984.net>
 <1e362d8c-d028-b787-8c2d-d952eaf741ef@vodafone.de>
 <CACiKqBccrTmW1B6Pgc58u2rk5_mEWigSUZg5zrvRWkVm5h6r3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACiKqBccrTmW1B6Pgc58u2rk5_mEWigSUZg5zrvRWkVm5h6r3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Andreas Boll <andreas.boll.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

QW0gMjEuMDIuMjAxNyB1bSAxMzo0NSBzY2hyaWViIEFuZHJlYXMgQm9sbDoKPiAyMDE3LTAyLTIx
IDEzOjE2IEdNVCswMTowMCBDaHJpc3RpYW4gS8O2bmlnIDxkZWF0aHNpbXBsZUB2b2RhZm9uZS5k
ZT46Cj4+IE5vdCBtdWNoIG9mIGFuIGlzc3VlLCBidXQgd2hlbiBzZW5kaW5nIG91dCBhIHNlY29u
ZCB2ZXJzaW9uIG9mIGEgcGF0Y2ggd2UKPj4gdXN1YWxseSBwdXQgYSB2MiBvbiB0aGUgc3ViamVj
dCBsaW5lIHRvIGluZGljYXRlIHRoYXQuCj4+Cj4+IEFkZGl0aW9uYWwgdG8gdGhhdCB0aGUgcGF0
Y2ggYWxzbyBuZWVkcyBhdCBsZWFzdCBhIGxpdHRsZSBiaXQgb2YgY29tbWl0Cj4+IG1lc3NhZ2Uu
Cj4+Cj4+IFdpdGggdGhhdCBmaXhlZCBpdCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPj4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+
Pgo+IEhpIENocmlzdGlhbiwKPgo+IEFGQUlLIHRoZXJlJ3Mgbm8gdjEgb24gdGhlIHB1YmxpYyBt
bC4KPiBJIGd1ZXNzIHlvdSBtaWdodCBiZSBjb25mdXNpbmcgSERNSSB3aXRoIERQIGF1ZGlvIHN1
cHBvcnQgZm9yIFNJLgo+IFRoaXMgcGF0Y2ggaXMgYWJvdXQgSERNSSBhdWRpby4gVGhlIG90aGVy
IG9uZSBpcyBhYm91dCBEUCBhdWRpbyBbMV0uCgpPaCwgaW5kZWVkLiBTb3JyeSBmb3IgdGhlIG5v
aXNlLgoKQnV0IGluIHRoaXMgY2FzZSB3aGVyZSBpcyB0aGUgVjIgb2YgdGhlIERQIHBhdGNoZXM/
IEplcnJ5IGhhZCBzb21lIApjb21tZW50cyBvbiB0aG9zZSBJSVJDIGFuZCB0aGlzIHBhdGNoIGlz
IGNsZWFybHkgYmFzZWQgb24gdGhhdC4KCkNocmlzdGlhbi4KCj4KPiBUaGFua3MsCj4gQW5kcmVh
cwo+Cj4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC8xMzk5MzIv
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
