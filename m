From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Really leave SI support disabled by
 default
Date: Tue, 30 May 2017 12:26:02 +0900
Message-ID: <3f76e24c-d27c-62af-dd81-02080d058753@daenzer.net>
References: <20170529092026.5567-1-michel@daenzer.net>
 <b0db57f8-ccdf-4af7-c9fd-0a5cd3545099@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b0db57f8-ccdf-4af7-c9fd-0a5cd3545099-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

T24gMzAvMDUvMTcgMDI6MTggQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjkuMDUu
MjAxNyB1bSAxMToyMCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBGcm9tOiBNaWNoZWwgRMOk
bnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPj4KPj4gVGhlIGRlZmF1bHQgb3B0aW9uIHZh
bHVlIGRpZG4ndCBtYXRjaCB0aGUgaGVscCB0ZXh0IGFuZCBpbnRlbnRpb24uCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+IAo+IEkn
bSBzdGlsbCB1bnN1cmUgYWJvdXQgdGhlIGxhc3Qgb25lLiBUaGUgZmVhdHVyZSBwYXJpdHkgaXMg
YSBnb29kCj4gYXJndW1lbnQgYnV0IG9uIHRoZSBvdGhlciBoYW5kIHdlIHdhbnQgcGVvcGxlIHRv
IHVzZSBhbWRncHUgZm9yIENJSwo+IHRoZXNlIGRheXMsIGRvbid0IHdlPwoKV2Ugd2FudCB0byBt
YWtlIGl0IGVhc3kgZm9yIHBlb3BsZSB0byB0ZXN0IGFtZGdwdSBvbiBDSUssIHdoaWNoIGlzIHdo
YXQKdGhlIG9wdGlvbnMgYWRkZWQgYnkgRmVsaXggYXJlIGZvci4gSU1PIHdlIHNob3VsZCBub3Qg
ZmxpcCB0aGUgZGVmYXVsdAoodXBzdHJlYW0pIGJlZm9yZSB0aGVyZSBpcyBmZWF0dXJlIHBhcml0
eS4KCgo+IEFueXdheSBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPi4KClRoYW5rcywgSSBhc3N1bWUgdGhhdCBhcHBsaWVzIHRvIHRoZSB3aG9s
ZSBzZXJpZXM/CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
