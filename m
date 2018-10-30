From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Intel-gfx] [PATCH] RFC: Make igts for cross-driver stuff
 mandatory?
Date: Tue, 30 Oct 2018 12:17:30 +1000
Message-ID: <CAPM=9tykF1U0Kah42ej7GR=6HyKe+WeV-LRe7_xB0VEUkikdPQ@mail.gmail.com>
References: <20181019085049.25482-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181019085049.25482-1-daniel.vetter-/w4YWyX8dFk@public.gmane.org>
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
To: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Cc: igt-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCAxOSBPY3QgMjAxOCBhdCAxODo1MSwgRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRl
ckBmZndsbC5jaD4gd3JvdGU6Cj4KPiBIaSBhbGwsCj4KPiBUaGlzIGlzIGp1c3QgdG8gY29sbGVj
dCBmZWVkYmFjayBvbiB0aGlzIGlkZWEsIGFuZCBzZWUgd2hldGhlciB0aGUKPiBvdmVyYWxsIGRy
aS1kZXZlbCBjb21tdW5pdHkgc3RhbmRzIG9uIGFsbCB0aGlzLiBJIHRoaW5rIHRoZSBwYXN0IGZl
dwo+IGNyb3NzLXZlbmRvciB1YXBpIGV4dGVuc2lvbnMgYWxsIGNhbWUgd2l0aCBpZ3RzIGF0dGFj
aGVkLCBhbmQKPiBwZXJzb25hbGx5IEkgdGhpbmsgdGhlcmUncyBsb3RzIG9mIHZhbHVlIGluIGhh
dmluZyB0aGVtOiBBCj4gY3Jvc3MtdmVuZG9yIGludGVyZmFjZSBpc24ndCB1c2VmdWwgaWYgZXZl
cnkgZHJpdmVyIGltcGxlbWVudHMgaXQKPiBzbGlnaHRseSBkaWZmZXJlbnRseS4KPgo+IEkgdGhp
bmsgdGhlcmUncyAyIHF1ZXN0aW9ucyBoZXJlOgo+Cj4gLSBEbyB3ZSB3YW50IHRvIG1ha2Ugc3Vj
aCB0ZXN0Y2FzZXMgbWFuZGF0b3J5PwoKWWVzIEkgdGhpbmsgaWYgYXQgYWxsIHByYWN0aWNhbCBp
dCBwcm9iYWJseSBtYWtlcyBzZW5zZSB0byBoYXZlIHNvbWUKbWFuZGF0b3J5IHRlc3QgY2FzZXMg
Zm9yIGFsbCBjcm9zcy12ZW5kb3IgZmVhdHVyZXMsIG9yIGZlYXR1cmVzIHRoYXQKbWlnaHQgYmVj
b21lIGNyb3NzIHZlbmRvciBpbiB0aGUgZnV0dXJlLgoKPgo+IC0gSWYgeWVzLCBhcmUgd2UgdGhl
cmUgeWV0LCBvciBpcyB0aGVyZSBzb21ldGhpbmcgY3J1Y2lhbGx5IG1pc3NpbmcKPiAgIHN0aWxs
PwoKSSB0aGluayB0aGUgZG9lcyBpZ3QgYnVpbGQgaW4gYWxsIHRoZSBwbGFjZXMgbmVlZGVkIGlz
IHRoZSBtYWluIG9uZSwKSSd2ZSBubyBpZGVhIHdoYXQgYSBiYXNlbGluZSBJR1QgdGVzdCBydW4g
bG9va3MgbGlrZSBvbiBub24taW50ZWwgaHcsCmhvdyB1c2VmdWwgaXMgaXQ/CgpBY2tlZC1ieTog
RGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
