From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/24] drm_framebuffer boilerplate removal
Date: Fri, 30 Mar 2018 11:03:02 -0400
Message-ID: <CADnq5_OPHED3TnE5yV6uEQOdSjMNebCttO=YVAx0i1dPEU_CeQ@mail.gmail.com>
References: <CAPj87rPKDwBK7qoOoY2zXoS6T02toATPRsk=39m_OBr=s1kXTw@mail.gmail.com>
 <CADnq5_MSsXgUdGNPu76c0qE1As5wmTbJr147KfTeG8E-LGG5ig@mail.gmail.com>
 <CAPj87rOfg18u1xBioeu1D0MoD4My2rZy1Nw3yfA4DhdX2R7g7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPj87rOfg18u1xBioeu1D0MoD4My2rZy1Nw3yfA4DhdX2R7g7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Daniel Stone <daniels-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBNYXIgMzAsIDIwMTggYXQgMTE6MDAgQU0sIERhbmllbCBTdG9uZSA8ZGFuaWVsc0Bj
b2xsYWJvcmEuY29tPiB3cm90ZToKPiBIaSBBbGV4LAo+Cj4gT24gMzAgTWFyY2ggMjAxOCBhdCAx
NTo0NywgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+PiBPbiBG
cmksIE1hciAzMCwgMjAxOCBhdCAxMDoxMSBBTSwgRGFuaWVsIFN0b25lIDxkYW5pZWxzQGNvbGxh
Ym9yYS5jb20+IHdyb3RlOgo+Pj4gSSBpbnRlbmQgdG8gcmVtb3ZlIGNyZWF0ZV9oYW5kbGUgd2hl
biBhbGwgZHJpdmVycyBhcmUgY29udmVydGVkIG92ZXIKPj4+IHRvIHBsYWNpbmcgQk9zIGRpcmVj
dGx5IGluc2lkZSBkcm1fZnJhbWVidWZmZXIuIEZvciBtb3N0IGRyaXZlcnMKPj4+IHRoZXJlJ3Mg
YSByZWxhdGl2ZWx5IGVhc3kgY29udmVyc2lvbiB0byB1c2luZyB0aGUgaGVscGVycyBmb3IKPj4+
IGJhc2ljYWxseSBhbGwgZnJhbWVidWZmZXIgaGFuZGxpbmcgYW5kIGZiZGV2IGVtdWxhdGlvbiBh
cyB3ZWxsLCB0aG91Z2gKPj4+IHRoYXQncyBhIGJpdCBmdXJ0aGVyIHRoYW4gSSB3YXMgd2lsbGlu
ZyB0byBnbyB3aXRob3V0IGhhcmR3YXJlIHRvIHRlc3QKPj4+IG9uIC4uLgo+Pgo+PiBTZXJpZXMg
aXM6Cj4+IEFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
Cj4KPiBUaGFua3MgYSBsb3QgZm9yIHRoZSByZXZpZXchIEFyZSB5b3UgdGFraW5nIHRoZSByYWRl
b24vYW1kZ3B1IHBhdGNoZXMKPiB0aHJvdWdoIHlvdXIgdHJlZT8gVGhleSBkb24ndCBoYXZlIGFu
eSBkZXBlbmRlbmNpZXMgb24gY29yZSBjb2RlLgoKU3VyZS4gIEknbGwgZ3JhYiB0aGVtIG5vdy4K
CkFsZXgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
