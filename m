From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 01/10] dma-buf: make fence sequence numbers 64 bit v2
Date: Tue, 04 Dec 2018 12:57:02 +0000
Message-ID: <154392822277.11526.11552567287106535090@skylake-alporthouse-com>
References: <20181204115948.15202-1-christian.koenig@amd.com>
 <154392793531.11526.17927449302716457070@skylake-alporthouse-com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <154392793531.11526.17927449302716457070@skylake-alporthouse-com>
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
To: =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UXVvdGluZyBDaHJpcyBXaWxzb24gKDIwMTgtMTItMDQgMTI6NTI6MTUpCj4gUXVvdGluZyBDaHJp
c3RpYW4gS8O2bmlnICgyMDE4LTEyLTA0IDExOjU5OjM5KQo+ID4gLXN0YXRpYyBpbmxpbmUgYm9v
bCBfX2RtYV9mZW5jZV9pc19sYXRlcih1MzIgZjEsIHUzMiBmMikKPiA+ICtzdGF0aWMgaW5saW5l
IGJvb2wgX19kbWFfZmVuY2VfaXNfbGF0ZXIodTY0IGYxLCB1NjQgZjIpCj4gPiAgewo+ID4gLSAg
ICAgICByZXR1cm4gKGludCkoZjEgLSBmMikgPiAwOwo+ID4gKyAgICAgICAvKiBUaGlzIGlzIGZv
ciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IHdpdGggZHJpdmVycyB3aGljaCBjYW4gb25seSBoYW5k
bGUKPiA+ICsgICAgICAgICogMzJiaXQgc2VxdWVuY2UgbnVtYmVycy4gVXNlIGEgNjRiaXQgY29t
cGFyZSB3aGVuIGFueSBvZiB0aGUgaGlnaGVyCj4gPiArICAgICAgICAqIGJpdHMgYXJlIG5vbmUg
emVybywgb3RoZXJ3aXNlIHVzZSBhIDMyYml0IGNvbXBhcmUgd2l0aCB3cmFwIGFyb3VuZAo+ID4g
KyAgICAgICAgKiBoYW5kbGluZy4KPiA+ICsgICAgICAgICovCj4gPiArICAgICAgIGlmICh1cHBl
cl8zMl9iaXRzKGYxKSB8fCB1cHBlcl8zMl9iaXRzKGYyKSkKPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gZjEgPiBmMjsKPiA+ICsKPiA+ICsgICAgICAgcmV0dXJuIChpbnQpKGxvd2VyXzMyX2Jp
dHMoZjEpIC0gbG93ZXJfMzJfYml0cyhmMikpID4gMDsKPiAKPiBPciBqdXN0ICIoaW50NjRfdCko
ZjEgLSBmMikgPiAwIiwgd29ya3MgaWYgZHJpdmVycyBhcmUgb25seSB1c2luZyB0aGUgbG93Cj4g
MzJiIGFuZCBpZiB0aGV5IHVzZSB0aGUgZnVsbCA2NGIuCgpObywgaXQgZG9lc24ndC4KLUNocmlz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
