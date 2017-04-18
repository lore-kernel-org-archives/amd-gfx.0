From: Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/7] sync_file: get rid of internal reference count.
Date: Tue, 18 Apr 2017 11:38:01 -0300
Message-ID: <20170418143801.GB15339@joana>
References: <20170413014144.637-1-airlied@gmail.com>
 <20170413014144.637-2-airlied@gmail.com>
 <20170417131311.GA15339@joana>
 <CAO_48GHYX7oDv3MtD5XhoQOSyYZOF_byP+niV0YC7f1ZhHvL1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAO_48GHYX7oDv3MtD5XhoQOSyYZOF_byP+niV0YC7f1ZhHvL1A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DRI mailing list <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

MjAxNy0wNC0xNyBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPjoKCj4gT24g
MTcgQXByaWwgMjAxNyBhdCAxODo0MywgR3VzdGF2byBQYWRvdmFuIDxndXN0YXZvQHBhZG92YW4u
b3JnPiB3cm90ZToKPiA+IDIwMTctMDQtMTMgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29t
PjoKPiA+Cj4gPj4gRnJvbTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KPiA+Pgo+
ID4+IHN5bmNfZmlsZSB1c2VzIHRoZSByZWZlcmVuY2UgY291bnQgb2YgdGhlIGZpbGUsIHRoZSBp
bnRlcm5hbAo+ID4+IGtyZWYgd2FzIG5ldmVyIGdldHRpbmcgbW92ZWQgcGFzdCAxLgo+ID4+Cj4g
Pj4gV2UgY2FuIHJlaW50cm9kdWNlIHRoaXMgaWYgd2UgZGVjaWRlIHdlIG5lZWQgaXQgbGF0ZXIu
Cj4gPj4KPiA+PiBbYWlybGllZDogZml4IGJ1aWxkYm90IHdhcm5pbmdzXQo+ID4+Cj4gPj4gUmV2
aWV3ZWQtYnk6IENocmlzIFdpbHNvbiA8Y2hyaXNAY2hyaXMtd2lsc29uLmNvLnVrPgo+ID4+IFNp
Z25lZC1vZmYtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+Cj4gPj4gLS0tCj4g
Pj4gIGRyaXZlcnMvZG1hLWJ1Zi9zeW5jX2ZpbGUuYyB8IDEzICsrLS0tLS0tLS0tLS0KPiA+PiAg
aW5jbHVkZS9saW51eC9zeW5jX2ZpbGUuaCAgIHwgIDMgLS0tCj4gPj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBSZXZpZXdlZC1ieTog
R3VzdGF2byBQYWRvdmFuIDxndXN0YXZvLnBhZG92YW5AY29sbGFib3JhLmNvbT4KPiBBY2tlZC1i
eTogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KPiA+Cj4gPiBPciBzaG91
bGQgSSBqdXN0IHB1c2ggdGhpcyBvbmU/Cj4gT2YgY291cnNlLCBnbyByaWdodCBhaGVhZCwgR3Vz
dGF2byA6KQoKcHVzaGVkIHRvIGRybS1taXNjLW5leHQuCgpHdXN0YXZvCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
