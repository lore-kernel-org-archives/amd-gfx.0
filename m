From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xserver 0/6] modesetting: add DRI2 page flip support
Date: Fri, 19 Aug 2016 08:57:05 +0100
Message-ID: <CACvgo51CgrEqe+pE-0-FOrhk3NhLSygLA54RU2U3aoFfHEvXGw@mail.gmail.com>
References: <1471429751-17269-1-git-send-email-Qiang.Yu@amd.com>
 <CACvgo52vhzcyAS384uQdYy_XrA0LmKRdsRnLF0UB0OhV49A7uw@mail.gmail.com>
 <MWHPR12MB121593BB7CA6C60D65B21E6B8F160@MWHPR12MB1215.namprd12.prod.outlook.com>
 <09c2176a-6a7e-b28d-d7e1-6a4bb76dab58@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
In-Reply-To: <09c2176a-6a7e-b28d-d7e1-6a4bb76dab58-otUistvHUpPR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.x.org/mailman/options/xorg-devel>,
 <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.x.org/archives/xorg-devel>
List-Post: <mailto:xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.x.org/mailman/listinfo/xorg-devel>,
 <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Sender: "xorg-devel" <xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Yu, Qiang" <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>, ML xorg-devel <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTkgQXVndXN0IDIwMTYgYXQgMDM6MDksIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnpl
ci5uZXQ+IHdyb3RlOgo+IE9uIDE5LzA4LzE2IDExOjAyIEFNLCBZdSwgUWlhbmcgd3JvdGU6Cj4+
Cj4+IEVhY2ggcG9pbnQgb2YgdGhlIHBhdGNoIHNldCBpcyBub3QgYnJva2VuLiBQYXRjaGVzIGFy
ZSBhcnJhbmdlZCBsaWtlCj4+IHRoaXMgdG8gc2hvdyBob3cgSSBkbyBpdDoKPj4gMS4gY3JlYXRl
IGEgcGFnZWZsaXAuYyB0byBob3N0IGNvbW1vbiBwYWdlIGZsaXAgY29kZQo+PiAyLiBjb3B5IGFt
ZGdwdSBERFggRFJJMiBwYWdlIGZsaXAgY29kZSB0byBtb2Rlc2V0dGluZyBkcmkyLmMKPj4gMy4g
bWVyZ2UgY29tbW9uIERSSTIgYW5kIHByZXNlbnQgcGFnZSBmbGlwIGNvZGUgdG8gcGFnZWZsaXAu
Ywo+Pgo+PiBQYXRjaCA0IGlzIG5vdCBhIGZpeCBmb3IgYnJva2VuIGNvZGUsIGp1c3QgYSBjb21t
aXQgZnJvbSBhbWRncHUgRERYCj4+IHRvIHByZXZlbnQgcHJlc2VudCBhbmQgRFJJMiBmcm9tIGZs
aXBwaW5nIGF0IHRoZSBzYW1lIHRpbWUuCj4KPiBUaGlzIGRvZXMgbWVhbiB0aG91Z2ggdGhhdCBp
ZiBvbmUgaGFzIG9ubHkgdXAgdG8gcGF0Y2ggMyBhcHBsaWVkIChlLmcuCj4gZHVyaW5nIGEgYmlz
ZWN0aW9uKSwgb25lIGlzIGV4cG9zZWQgdG8gdGhlIGlzc3VlcyBmaXhlZCBieSBwYXRjaCA0LiBT
bwo+IG1heWJlIHBhdGNoIDQgc2hvdWxkIGJlIHNxdWFzaGVkIGludG8gcGF0Y2ggMy4KPgpQcmVj
aXNlbHkgd2hhdCBJIG1lYW50IHdpdGggImJyb2tlbiIgLSBuZXcgY29kZSBpbnRyb2R1Y2VzIGEK
ZnVuY3Rpb25hbGl0eSB3aGljaCBjb25mbGljdHMgd2l0aCBleGlzdGluZyBvbmUuCgpBbmQgeWVz
LCBvbmUgY2FuIHNlZSB0aGUgY29kZSBmbG93IChhbmQgdGhhdCBpdCdzIHBhcnRpYWxseSBjb3Bp
ZWQKZnJvbSBhbWRncHUvYXRpKSBBcy1pcyB0aGUgc2VyaWVzIGJyaW5ncyB1bm5lY2Vzc2FyeSBj
aHVybiwgc2luY2UgaXQKYWRkcyBuZXcgY29kZSBvbmx5IHRvIChyZSltb3ZlIGl0LgpTb21ldGhp
bmcgbWFueSBkZXZlbG9wZXJzL3Byb2plY3RzIGNvbnNpZGVyIGEgYmFkIHdheSB0byBzcGxpdCBw
YXRjaGVzLgoKVGhhbmtzCkVtaWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KeG9yZy1kZXZlbEBsaXN0cy54Lm9yZzogWC5PcmcgZGV2ZWxvcG1lbnQKQXJj
aGl2ZXM6IGh0dHA6Ly9saXN0cy54Lm9yZy9hcmNoaXZlcy94b3JnLWRldmVsCkluZm86IGh0dHBz
Oi8vbGlzdHMueC5vcmcvbWFpbG1hbi9saXN0aW5mby94b3JnLWRldmVs
