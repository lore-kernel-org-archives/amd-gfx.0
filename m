From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag
 TTM_PAGE_FLAG_TRANSHUGE
Date: Tue, 1 May 2018 09:15:19 +1000
Message-ID: <CAPM=9tzmmT5G5a_2WCH5xpRr6rhY6sHdi-Kg5my0az_=haVZTw@mail.gmail.com>
References: <20180426150618.13470-1-michel@daenzer.net>
 <20180427130811.7642-1-michel@daenzer.net>
 <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
 <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
 <d5f9459e-801c-e592-d06d-c9052ef3ad4d@amd.com>
 <e5256136-6da0-cc5e-9490-5a70c89dfd83@daenzer.net>
 <361a765a-f491-4450-867e-fa88857827ee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <361a765a-f491-4450-867e-fa88857827ee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Koenig, Christian" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Pgo+Cj4gWWVzLCBJIGZpeGVkIHRoZSBvcmlnaW5hbCBmYWxzZSBwb3NpdGl2ZSBtZXNzYWdlcyBt
eXNlbGYgd2l0aCB0aGUgc3dpb3RsYgo+IG1haW50YWluZXIgYW5kIEkgd2FzIENDZWQgaW4gZml4
aW5nIHRoZSByZWNlbnQgZmFsbG91dCBmcm9tIENocmlzIGNoYW5nZXMgYXMKPiB3ZWxsLgoKU28g
ZG8gd2UgaGF2ZSBhIGdvb2Qgc3VtbWFyeSBvZiB3aGVyZSB0aGlzIGF0IG5vdz8KCkknbSBnZXR0
aW5nIHJlcG9ydHMgb24gNC4xNi40IHN0aWxsIGRpc3BsYXlpbmcgdGhlc2UsIHdoYXQgaGFtbWVy
IGRvIEkKbmVlZCB0byBoaXQgdGhpbmdzIHdpdGggdG8gZ2V0IDQuMTYueCsxIHRvIG5vdCBkbyB0
aGlzPwoKSXMgdGhlcmUgc3RpbGwgb3V0c3RhbmRpbmcgaXNzdWVzIHVwc3RyZWFtLgoKRm9yIGZ1
dHVyZSByZWZlcmVuY2UgSSB0aGluayBob3cgdGhpcyBzaG91bGQgaGF2ZSBnb25lIGRvd24gaXMK
CmEpIEFNRCBpbXBsZW1lbnQgYSBwdWJsaWMgQ0kgd2l0aCBpZ3QgdGVzdHMgZm9yIGFsbCBvZiB0
aGlzCmIpIHdlIGdldCB0aGVzZSBwYXRjaGVzIHB1c2hlZCBhbmQgZGVidWdnZWQuCgpUaG91Z2gg
dG8gYmUgYSBiaXQgbW9yZSBjb25zdHJ1Y3RpdmUsIEkgdGhpbmsgeW91IHNob3VsZCBoYXZlIHNh
aWQgYXQKLXJjNiBvciA3IHRoaXMgaXNuJ3Qgd29ya2luZyBmb3IgdGhpcyBrZXJuZWwgY3ljbGUs
CnB1c2ggYSBtaW5pbWFsIHBhdGNoIHRvIGJhY2sgaXQgb2ZmLCBldmVuIGlmIHRoZSBidWcgaXMg
aW4gc3dpb3RsYiwgd2UKZG9uJ3QganVzdCBhZGQgc3R1ZmYgYnJva2VuIGxpa2UgdGhpcywgZXZl
biBpZiBpdCdzIG5vdAp5b3VyIGJ1ZyB3ZSBzaG91bGQgaGF2ZSBiYWNrZWQgb2ZmIGZvciBhIGtl
cm5lbCBvciB0d28gdW50aWwgd2UgaGFkCnRoZSB1bmRlcmx5aW5nIGluZnJhc3RydWN0dXJlIGZp
eGVkLiBPdGhlcndpc2Ugd2UKZ2V0IHdoYXQgd2UgaGF2ZSBub3csIHdoaWNoIGlzIGJpdCBvZiBh
IGNyYXBwaWxlLCBiZWNhdXNlIG5vdyBJJ3ZlIG5vCmlkZWEgaWYgdGhlIHN3aW90bGIgdGhpbmdz
IHBlb3BsZSByZXBvcnQgYXJlCnRoZSBmYWxzZSBwb3NpdGl2ZSwgb3Igc29tZSBuZXcgdGhpbmcu
CgpEYXZlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
