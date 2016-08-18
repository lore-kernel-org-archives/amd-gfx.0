From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xserver 0/6] modesetting: add DRI2 page flip support
Date: Thu, 18 Aug 2016 12:03:12 +0100
Message-ID: <CACvgo52vhzcyAS384uQdYy_XrA0LmKRdsRnLF0UB0OhV49A7uw@mail.gmail.com>
References: <1471429751-17269-1-git-send-email-Qiang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
In-Reply-To: <1471429751-17269-1-git-send-email-Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.x.org/mailman/options/xorg-devel>,
 <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.x.org/archives/xorg-devel>
List-Post: <mailto:xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.x.org/mailman/listinfo/xorg-devel>,
 <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Sender: "xorg-devel" <xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
To: Qiang Yu <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
Cc: ML xorg-devel <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: amd-gfx.lists.freedesktop.org

SGkgUWlhbmcsCgpPbiAxNyBBdWd1c3QgMjAxNiBhdCAxMToyOSwgUWlhbmcgWXUgPFFpYW5nLll1
QGFtZC5jb20+IHdyb3RlOgo+IEhpIGd1eXMsCj4KPiBUaGlzIHBhdGNoIHNldCBpcyBmb3IgYWRk
aW5nIERSSTIgcGFnZSBmbGlwIHN1cHBvcnQgdG8gbW9kZXNldHRpbmcKPiBkcml2ZXIuIEkgbWFp
bmx5IHRha2UgcmVmZXJlbmNlIG9mIGFtZGdwdSBERFggYW5kIHJldXNlIHByZXNlbnQKPiBwYWdl
IGZsaXAgY29kZSBpbiB0aGUgbW9kZXNldHRpbmcgZHJpdmVyLgo+Cj4gUmVnYXJkcywKPiBRaWFu
Zwo+Cj4gUWlhbmcgWXUgKDYpOgo+ICAgbW9kZXNldHRpbmc6IG1ha2UgbXNfZG9fcGFnZWZsaXAg
Z2VuZXJpYyBmb3Igc2hhcmUgd2l0aCBEUkkyCj4gICBtb2Rlc2V0dGluZzogbW92ZSBtc19kb19w
YWdlZmxpcCB0byBwYWdlZmxpcC5jCj4gICBtb2Rlc2V0dGluZzogYWRkIERSSTIgcGFnZSBmbGlw
IHN1cHBvcnQKPiAgIG1vZGVzZXR0aW5nOiBleGNsdWRlIERSSTIgYW5kIFByZXNlbnQgcGFnZSBm
bGlwCj4gICBtb2Rlc2V0dGluZzogbWVyZ2UgY29tbW9uIHBhZ2UgZmxpcCBjb2RlIGZvciBwcmVz
ZW50IGFuZCBkcmkyCj4gICBtb2Rlc2V0dGluZzogcmVtb3ZlIHJlZHVuZGVudCBwaXhtYXAgZGVz
dHJveQo+ClRoZSB3b3JrIGl0c2VsZiBpcyBxdWl0ZSBpbnRlcmVzdGluZyB0aGFua3MgZm9yIHRo
YXQgIQoKSXMgaXQgbWUgb3IgdGhlIG5ld2x5IGFkZGVkIGNvZGUgKHdpdGggcGF0Y2ggMykgc2Vl
bXMgaW50ZXJtaXR0ZW50bHkKYnJva2VuIChmaXhlZCB3aXRoIHBhdGNoIDQpLCBhbmQgdGhlbiBy
ZW1vdmVkIHdpdGggYSBsYXRlciBwYXRjaCAoNSkgPwpTaG91bGQgb25lIGZhY3RvciB0aGUgY29t
bW9uIHBhZ2VmbGlwIGNvZGUgZmlyc3QsIHRoZW4gYWRkIHRoZQpkaXN0aW5jdGlvbiBiZXR3ZWVu
IGRyaTIgYW5kIHByZXNlbnQgZmxpcHMsIHRoZW4gZmluYWxseSBhZGQgdGhlIGRyaTIKaW1wbGVt
ZW50YXRpb24gPwoKUmVnYXJkcywKRW1pbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwp4b3JnLWRldmVsQGxpc3RzLngub3JnOiBYLk9yZyBkZXZlbG9wbWVu
dApBcmNoaXZlczogaHR0cDovL2xpc3RzLngub3JnL2FyY2hpdmVzL3hvcmctZGV2ZWwKSW5mbzog
aHR0cHM6Ly9saXN0cy54Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hvcmctZGV2ZWw=
