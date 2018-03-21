From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [Linaro-mm-sig] [PATCH 1/5] dma-buf: add optional
 invalidate_mappings callback v2
Date: Wed, 21 Mar 2018 09:28:39 +0100
Message-ID: <20180321082839.GA14155@phenom.ffwll.local>
References: <20180316132049.1748-1-christian.koenig@amd.com>
 <20180316132049.1748-2-christian.koenig@amd.com>
 <152120831102.25315.4326885184264378830@mail.alporthouse.com>
 <21879456-db47-589c-b5e2-dfe8333d9e4c@gmail.com>
 <152147480241.18954.4556582215766884582@mail.alporthouse.com>
 <0bd85f69-c64c-70d1-a4a0-10ae0ed8b4e8@gmail.com>
 <CAKMK7uH3xNkx3UFBMdcJ415F2WsC7s_D+CDAjLAh1p-xo5RfSA@mail.gmail.com>
 <19ed21a5-805d-271f-9120-49e0c00f510f@amd.com>
 <20180320140810.GU14155@phenom.ffwll.local>
 <37ba7394-2a5c-a0bc-cc51-c8a0edc2991d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <37ba7394-2a5c-a0bc-cc51-c8a0edc2991d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gVHVlLCBNYXIgMjAsIDIwMTggYXQgMDY6NDc6NTdQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyMC4wMy4yMDE4IHVtIDE1OjA4IHNjaHJpZWIgRGFuaWVsIFZldHRlcjoK
PiA+IFtTTklQXQo+ID4gRm9yIHRoZSBpbi1kcml2ZXIgcmVzZXJ2YXRpb24gcGF0aCAoQ1MpIGhh
dmluZyBhIHNsb3ctcGF0aCB0aGF0IGdyYWJzIGEKPiA+IHRlbXBvcmFyeSByZWZlcmVuY2UsIGRy
b3BzIHRoZSB2cmFtIGxvY2sgYW5kIHRoZW4gbG9ja3MgdGhlIHJlc2VydmF0aW9uCj4gPiBub3Jt
YWxseSAodXNpbmcgdGhlIGFjcXVpcmUgY29udGV4dCB1c2VkIGFscmVhZHkgZm9yIHRoZSBlbnRp
cmUgQ1MpIGlzIGEKPiA+IGJpdCB0cmlja3ksIGJ1dCB0b3RhbGx5IGZlYXNpYmxlLiBUdG0gZG9l
c24ndCBkbyB0aGF0IHRob3VnaC4KPiAKPiBUaGF0IGlzIGV4YWN0bHkgd2hhdCB3ZSBkbyBpbiBh
bWRncHUgYXMgd2VsbCwgaXQncyBqdXN0IG5vdCB2ZXJ5IGVmZmljaWVudAo+IG5vciByZWxpYWJs
ZSB0byByZXRyeSBnZXR0aW5nIHRoZSByaWdodCBwYWdlcyBmb3IgYSBzdWJtaXNzaW9uIG92ZXIg
YW5kIG92ZXIKPiBhZ2Fpbi4KCk91dCBvZiBjdXJpb3NpdHksIHdoZXJlJ3MgdGhhdCBjb2RlPyBJ
IGRpZCByZWFkIHRoZSB0dG0gZXZpY3Rpb24gY29kZSB3YXkKYmFjaywgYW5kIHRoYXQgb25lIGRl
ZmluaXRlbHkgZGlkbid0IGRvIHRoYXQuIFdvdWxkIGJlIGludGVyZXN0aW5nIHRvCnVwZGF0ZSBt
eSB1bmRlcnN0YW5kaW5nLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2lu
ZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
