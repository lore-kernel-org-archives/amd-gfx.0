From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix a kcq hang issue for SRIOV
Date: Tue, 27 Mar 2018 18:30:15 +0200
Message-ID: <97d802df-4563-7a6a-eae4-d14313762015@amd.com>
References: <1522130286-25401-1-git-send-email-Emily.Deng@amd.com>
 <CADnq5_N2p-qTNnMrUsCD1L1=Avmwc1Hb9pzMXdRm9pVMM5tC=w@mail.gmail.com>
 <CADnq5_MaXurcEuMw2d_jYnb2_4iL9xLy7Z4VYgW6pr9Kcm7nKg@mail.gmail.com>
 <183c370b-bcf5-fd80-429e-8418f2b1a105@gmail.com>
 <CADnq5_MPtDiJ3vx-yqWfa65xb3etO-e1xRuiM9mJR1bON=5Ecw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_MPtDiJ3vx-yqWfa65xb3etO-e1xRuiM9mJR1bON=5Ecw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

QW0gMjcuMDMuMjAxOCB1bSAxNzo1MiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBbU05JUF0KPj4+
IDIuIGFkZCB0aGUgbmV3IGNhbGxiYWNrIGltcGxlbWVudGF0aW9uIHRvIGdmeDkgYW5kIGdmeDgg
KEkgdGhpbmsgZ2Z4OAo+Pj4gd2lsbCBuZWVkIHRoaXMgYXMgd2VsbCBzaW5jZSB3ZSBzdXBwb3J0
IHNyLWlvdiB0aGVyZSB0b28pCj4+Cj4+IGdmeDggZG9lc24ndCBoYXZlIHRoZSBoYXJkd2FyZSBi
dWcgd2hpY2ggc2VlbXMgdG8gbWFrZSB0aGlzIG5lY2Vzc2FyeSwgbm90Cj4+IGRvZXMgaXQgaGF2
ZSB0aGUgc2FtZSBWTUhVQiBkZXNpZ24gYXMgZ2Z4OS4KPiBPaCwgcmlnaHQsIGluIHRoaXMgY2Fz
ZSBpdCdzIHRoZSByZXEvYWNrIGVuZ2luZXMgd2hpY2ggd2VyZSBuZXcgZm9yCj4gc29jMTUuICBX
ZSBtYXkgd2FudCB0aGUgc2FtZSBmaXggZm9yIHNkbWE0IHRob3VnaC4KCkFuZCBleGFjdGx5IHRo
YXQgaXMgb25lIG9mIHRoZSByZWFzb25zIHdoeSB0aGlzIHdvcmthcm91bmQgZG9lc24ndCB3b3Jr
IApjb3JyZWN0bHkuCgpUaGUgU0RNQSBpcyBub3QgZGlyZWN0bHkgY29ubmVjdGVkIHRvIHRoZSBH
RlhIVUIsIHNvIGV2ZW4gaWYgdGhlIFNETUEgCndvdWxkIHByb3ZpZGUgYSBzaW5nbGUgY29tbWFu
ZCBmb3IgdGhpcyB0aGUgd3JpdGUvd2FpdCB3b3VsZCBzdGlsbCBiZSAKZXhlY3V0ZWQgYXMgdHdv
IG9wZXJhdGlvbnMuCgpJbiBvdGhlciB3b3JkcyB3ZSBjYW4gYWdhaW4gcnVuIGludG8gdGhlIHBy
b2JsZW0gYW5kIHRoZSBzYW1lIHRoaW5nIAphcHBsaWVzIGZvciBDUFUgYmFzZWQgdXBkYXRlcy4K
ClRoZSBvbmx5IHJlYWwgd29ya2Fyb3VuZCB3b3VsZCBiZSB0byB3cml0ZSB0aGUgcmVxdWVzdCwg
cmVhZCB0aGUgCnJlZ2lzdGVyIGJhY2sgYW5kIGlmIHRoZSB3cml0ZSBkaWRuJ3Qgc3VjY2VlZGVk
IHdyaXRlIGl0IGFnYWluLgoKQnV0IHNlcmlvdXNseSByZW1lbWJlciB0aGF0IHRoaXMgaXNzdWUg
aXMgbm90IGxpbWl0ZWQgdG8gdGhlIFZNSFVCIApyZWdpc3RlcnMuIERvIHlvdSB3YW50IHRvIHdy
aXRlIGFuZCByZWFkIGJhY2sgZXZlcnkgcmVnaXN0ZXIgdG8gbWFrZSAKc3VyZSB0aGUgd3JpdGUg
c3VjY2VlZGVkPwoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
