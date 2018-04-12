From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v4 1/2] drm/amdgpu/gmc: steal the appropriate amount of
 vram for fw hand-over
Date: Thu, 12 Apr 2018 09:49:50 +0200
Message-ID: <f14880e8-f6c1-6ade-65d2-d3f81a50bcae@daenzer.net>
References: <1523506110-14002-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_Nw0Cwh-pg9==CWLRC2E709b2S8LEWMd93Eo+ZRfZ7GCQ@mail.gmail.com>
 <5e42d9cf-2581-14e1-80fd-0378323617c5@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5e42d9cf-2581-14e1-80fd-0378323617c5-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Ranjbar,
 Ramin" <ramin.ranjbar-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wNC0xMiAwNjoyNSBBTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4gT24gMDQv
MTIvMjAxOCAxMjoxNiBBTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBPbiBUaHUsIEFwciAxMiwg
MjAxOCBhdCAxMjowOCBBTSwgQW5kcmV5IEdyb2R6b3Zza3kKPj4gPGFuZHJleS5ncm9kem92c2t5
QGFtZC5jb20+IHdyb3RlOgo+Pj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFp
bC5jb20+Cj4+Pgo+Pj4gU3RlYWwgOSBNQiBmb3IgdmdhIGVtdWxhdGlvbiBhbmQgZmIgaWYgdmdh
IGlzIGVuYWJsZWQsIG90aGVyd2lzZSwKPj4+IHN0ZWFsIGVub3VnaCB0byBjb3ZlciB0aGUgY3Vy
cmVudCBkaXNwbGF5IHNpemUgYXMgc2V0IGJ5IHRoZSB2Ymlvcy4KPj4+Cj4+PiBJZiBubyBtZW1v
cnkgaXMgdXNlZCAoZS5nLiwgc2Vjb25kYXJ5IG9yIGhlYWRsZXNzIGNhcmQpLCBza2lwCj4+PiBz
dG9sZW4gbWVtb3J5IHJlc2VydmUuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+PiBMb29rcyBsaWtlIHlvdSB1c2VkIHYxIHJh
dGhlciB0aGFuIHYyIG9mIHRoaXMgcGF0Y2g6Cj4+IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNr
dG9wLm9yZy9wYXRjaC8yMTU1NjYvCj4+Cj4+IEFsZXgKPiAKPiBUbyBtdWNoIHBhdGNoZXMgY2ly
Y2xpbmcgYXJvdW5kLCBOUCwgd2lsbCByZXNwaW4gdG9tb3Jyb3cuCgpGV0lXLCBpdCBtaWdodCBo
ZWxwIGlmIGV2ZXJ5Ym9keSBrZXB0IHRoZSBzdGF0dXMgb2YgdGhlaXIgcGF0Y2hlcyB1cCB0bwpk
YXRlIG9uIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wcm9qZWN0L2FtZC14b3Jn
LWRkeC9wYXRjaGVzLyA6KQoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
