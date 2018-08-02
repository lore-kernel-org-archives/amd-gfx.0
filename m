From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/6] amdgpu: always add all BOs to lockup table
Date: Thu, 2 Aug 2018 16:55:54 +0200
Message-ID: <2ede6f59-a1e6-fe9e-396f-2cc961db6df5@daenzer.net>
References: <20180802140452.23894-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180802140452.23894-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wOC0wMiAwNDowNCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBUaGlzIHdh
eSB3ZSBjYW4gYWx3YXlzIGZpbmQgYSBCTyBzdHJ1Y3R1cmUgYnkgaXRzIGhhbmRsZS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CgpUeXBvIGluIHRoZSBzaG9ydGxvZzogc2hvdWxkIGJlICJsb29rdXAiIGluc3RlYWQgb2YgImxv
Y2t1cCIuCgpBbHNvLCB0aGlzIHBhdGNoIHNob3VsZCByZWFsbHkgYmUgYWZ0ZXIgcGF0Y2ggNC4K
Cgo+IEBAIC0yNDAsMTQgKzIzNywxMSBAQCBpbnQgYW1kZ3B1X2JvX2V4cG9ydChhbWRncHVfYm9f
aGFuZGxlIGJvLAo+ICAJCXJldHVybiAwOwo+ICAKPiAgCWNhc2UgYW1kZ3B1X2JvX2hhbmRsZV90
eXBlX2ttczoKPiAtCQlhbWRncHVfYWRkX2hhbmRsZV90b190YWJsZShibyk7Cj4gLQkJLyogZmFs
bCB0aHJvdWdoICovCj4gIAljYXNlIGFtZGdwdV9ib19oYW5kbGVfdHlwZV9rbXNfbm9pbXBvcnQ6
Cj4gIAkJKnNoYXJlZF9oYW5kbGUgPSBiby0+aGFuZGxlOwo+ICAJCXJldHVybiAwOwoKVGhpcyBp
cyBhIGJpdCB1bmZvcnR1bmF0ZSwgYW1kZ3B1X2JvX2hhbmRsZV90eXBlX2ttc19ub2ltcG9ydCBv
bmx5IGp1c3QKbGFuZGVkIHRoaXMgd2VlayBmb3IgdGhlIDIuNC45MyByZWxlYXNlLCBub3cgaXQn
bGwgYWxyZWFkeSBiZSB1c2VsZXNzCm5vaXNlLi4uIEEgYml0IG1vcmUgY29vcmRpbmF0aW9uIHdv
dWxkIGhhdmUgYmVlbiBuaWNlLiA6KQoKCkFueXdheSwgd2l0aCB0aGUgdHlwbyBpbiBwYXRjaCAz
IGZpeGVkLCBwYXRjaGVzIDIgJiA0LTYgYXJlCgpSZXZpZXdlZC1ieTogTWljaGVsIETDpG56ZXIg
PG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29m
dHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2
ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
