From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: CPU mapping of split VRAM buffers
Date: Wed, 29 Mar 2017 19:44:09 +0200
Message-ID: <b9776872-63f9-0b3f-e0d7-ccd63c53a48a@vodafone.de>
References: <1490792146-2218-1-git-send-email-deathsimple@vodafone.de>
 <BN6PR12MB1652DD0CE69D4972798E40DEF7350@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652DD0CE69D4972798E40DEF7350-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

QW0gMjkuMDMuMjAxNyB1bSAxNzozNiBzY2hyaWViIERldWNoZXIsIEFsZXhhbmRlcjoKPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogYW1kLWdmeCBbbWFpbHRvOmFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmddIE9uIEJlaGFsZgo+PiBPZiBDaHJpc3RpYW4g
S8O2bmlnCj4+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjksIDIwMTcgODo1NiBBTQo+PiBUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gQ2M6IG1hcmFlb0BnbWFpbC5jb20KPj4g
U3ViamVjdDogQ1BVIG1hcHBpbmcgb2Ygc3BsaXQgVlJBTSBidWZmZXJzCj4+Cj4+IEhpIGd1eXMs
Cj4+Cj4+IHRoaXMgc2V0IGltcGxlbWVudHMgQ1BVIG1hcHBpbmcgb2Ygc3BsaXQgVlJBTSBidWZm
ZXJzIGFuZCBjb3VsZAo+PiBoZWxwIHdpdGggc29tZSBwZXJmb3JtYW5jZSBpc3N1ZXMgcmVnYXJk
aW5nIHRoaXMuCj4+Cj4+IFBsZWFzZSByZXZpZXcgYW5kL29yIGNvbW1lbnQsCj4gU2hvdWxkIHBy
b2JhYmx5IHJlc2VuZCB0aGVtIHRvIGRyaS1kZXZlbCBhcyB3ZWxsIHNpbmNlIHRoZXkgdG91Y2gg
Y29yZSB0dG0uCgpVcHMsIGluZGVlZC4gSnVzdCBmaXhlZCB0aGF0LgoKQ2hyaXN0aWFuLgoKPgo+
IEFsZXgKPgo+PiBDaHJpc3RpYW4uCj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
