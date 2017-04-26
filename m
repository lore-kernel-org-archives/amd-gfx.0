From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [RFC] drm/amdgpu: avoid scheduling on fence status query
Date: Wed, 26 Apr 2017 10:09:03 +0900
Message-ID: <316ec198-f681-cb5b-913a-0a64a65b2feb@daenzer.net>
References: <20170426002830.6099-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170426002830.6099-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjYvMDQvMTcgMDk6MjggQU0sIEFuZHJlcyBSb2RyaWd1ZXogd3JvdGU6Cj4gV2hlbiBhbWRn
cHVfY3Nfd2FpdF9pb2N0bCBpcyBjYWxsZWQgd2l0aCBhIHRpbWVvdXQgb2YgemVybywgdGhlIGNh
bGxlcgo+IGlzIGp1c3QgaW50ZXJlc3RlZCBpbiB0aGUgY3VycmVudCBzdGF0dXMgb2YgdGhlIGZl
bmNlLgo+IAo+IFRoZSBkZWZhdWx0IGltcGxlbWVudGF0aW9uIG9mIGRtYV9mZW5jZV93YWl0X3Rp
bWVvdXQgb24gYW4gdW5zaWduYWxlZAo+IGZlbmNlIHdpbGwgYWx3YXlzIGNhbGwgc2NoZWR1bGVf
dGltZW91dCgpLCBldmVuIGlmIHRoZSB0aW1lb3V0IGlzIHplcm8uCj4gVGhpcyBtYXkgcmVzdWx0
IGluIHNpZ25pZmljYW50IG92ZXJoZWFkIGZvciBjbGllbnRzIHRoYXQgaGVhdmlseSB1c2UKPiB0
aGlzIGludGVyZmFjZS4KPiAKPiBUaGlzIHBhdGNoIGF2b2lkcyB0aGUgZG1hX2ZlbmNlX3dhaXRf
dGltZW91dCBvdmVyaGVhZCBieSBkaXJlY3RseQo+IGNoZWNraW5nIHRoZSBmZW5jZSBzdGF0dXMu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVzIFJvZHJpZ3VleiA8YW5kcmVzeDdAZ21haWwuY29t
Pgo+IC0tLQo+IAo+IEknbSBub3Qgc3VyZSBpZiB3ZSBzaG91bGQgYmUgd29ya2luZyBhcm91bmQg
dGhpcyBpc3N1ZSBhdCB0aGUgYW1kZ3B1Cj4gbGV2ZWwsIG9yIGF0IGZpeGluZyB0aGUgZG1hX2Zl
bmNlX2RlZmF1bHRfd2FpdCBsZXZlbCBpbnN0ZWFkLgoKSSdkIHNheSB0aGUgbGF0dGVyLCBhc3N1
bWluZyBpdCBjYW4gZ2l2ZSB0aGUgc2FtZSBiZW5lZml0LgoKCi0tIApFYXJ0aGxpbmcgTWljaGVs
IETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29t
CkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNh
IGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
