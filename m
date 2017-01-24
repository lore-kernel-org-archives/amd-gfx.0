From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH libdrm 2/3] amdgpu: don't mess with shared_handle if
 amdgpu_bo_import() fails
Date: Tue, 24 Jan 2017 03:53:53 +0000
Message-ID: <CACvgo53aJ=orgv_y+NUPRKyeBTPApX-_16oEHTHwHfuaZmKB2A@mail.gmail.com>
References: <20170122184813.12995-1-emil.l.velikov@gmail.com>
 <20170122184813.12995-2-emil.l.velikov@gmail.com>
 <ce6bb726-b57a-a2a8-f63d-6ac9673a128b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <ce6bb726-b57a-a2a8-f63d-6ac9673a128b@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, ML dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjMgSmFudWFyeSAyMDE3IGF0IDE2OjE0LCBOaWNvbGFpIEjDpGhubGUgPG5oYWVobmxlQGdt
YWlsLmNvbT4gd3JvdGU6Cj4gSSBkb24ndCB0aGluayBpcyBjb3JyZWN0LiBUaGUgaW5jb21pbmcg
aGFuZGxlIGlzIGluIHNoYXJlZF9oYW5kbGUsIG5vdCBpbgo+IGhhbmRsZS4gT25jZSB0aGUgY29k
ZSBibG9jayBhcm91bmQgbGluZSAzMTAgaGFzIGV4ZWN1dGVkLCBzaGFyZWRfaGFuZGxlIGlzCj4g
dGhlIGhhbmRsZSBwcm9kdWNlZCBieSBkcm1QcmltZUZEVG9IYW5kbGUsIGFuZCBjbG9zaW5nIGl0
IG9uIGVycm9yIChhcyB0aGUKPiBjb2RlIGN1cnJlbnRseSBkb2VzKSBzaG91bGQgYmUgdGhlIGNv
cnJlY3QgdGhpbmcgdG8gZG8uCj4KSSd2ZSBnb3QgY29uZnVzZWQgd2l0aCB0aGUgc2hhcmVkX2hh
bmRsZSA8PiBoYW5kbGUgbmFtaW5nIC0gcmVhZCB0aGUKd3Jvbmcgb25lIHdoZXJlIEkgc2hvdWxk
bid0IGhhdmUgOy0pCgpZb3UncmUgc3BvdCBvbi4gVGhhbmtzIGZvciB0aGUgY29ycmVjdGlvbi4K
RW1pbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmkt
ZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
