From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Tue, 28 Mar 2017 18:36:47 +0900
Message-ID: <8c7a81e7-40c6-f2c0-b647-576b8dc4e5e0@daenzer.net>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com>
 <5f26f8a1-e5bd-ca7a-c7ee-08c8f04f2110@daenzer.net>
 <CAHWPjbUEQCr4Qox5W-C8LYep7-fH=3FV_qhYydpOg2LvqGbZUw@mail.gmail.com>
 <CAHWPjbX8rv2FJniBjfYtqtXo-iCjvC9bNem0kv4bfbp=gbSBAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAHWPjbX8rv2FJniBjfYtqtXo-iCjvC9bNem0kv4bfbp=gbSBAQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Julien Isorce <julien.isorce@gmail.com>
Cc: Zachary Michaels <zmichaels@oblong.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Julien Isorce <jisorce@oblong.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjgvMDMvMTcgMDU6MjQgUE0sIEp1bGllbiBJc29yY2Ugd3JvdGU6Cj4gSGkgTWljaGVsLAo+
IAo+IEFib3V0IHRoZSBoYXJkIGxvY2t1cCwgSSBub3RpY2VkIHRoYXQgSSBjYW5ub3QgaGF2ZSBp
dCB3aXRoIHRoZQo+IGZvbGxvd2luZyBjb25kaXRpb25zOgo+IAo+IDEuIHNvZnQgbG9ja3VwIGZp
eCAodGhlIDAtPmkgY2hhbmdlIHdoaWNoIGF2b2lkcyBpbmZpbml0ZSBsb29wKQo+IDIuIFlvdXIg
c3VnZ2VzdGlvbjogKCEocmJvLT5mbGFncyAmIFJBREVPTl9HRU1fQ1BVX0FDQ0VTUykKPiAzLiBy
YWRlb24uZ2FydHNpemU9NTEyIHJhZGVvbi52cmFtbGltaXQ9MTAyNCAoYW55IG90aGVyIHZhbHVl
cyBhYm92ZSBkbwo+IG5vdCBoZWxwLCBmb3IgZXhhbXBsZSAoMTAyNCwgMTAyNCkgb3IgKDEwMjQs
IDIwNDgpKQo+IAo+IFdpdGhvdXQgMSBhbmQgMiwgYnV0IHdpdGggMywgb3VyIHRlc3QgcmVwcm9k
dWNlcyB0aGUgc29mdCBsb2NrdXAgKGp1c3QKPiBkaXNjb3ZlcmVkIGZldyBkYXlzIGFnbykuCj4g
V2l0aG91dCAzIChhbmQgd2l0aCBvciB3aXRob3V0IDEuLCAyLiksIG91ciB0ZXN0IHJlcHJvZHVj
ZXMgdGhlIGhhcmQKPiBsb2NrdXAgd2hpY2ggb25lIGRvZXMgbm90IGdpdmUgYW55IGluZm8gaW4g
a2Vybi5sb2cgKHNvbWV0aW1lcyBzb21lIE5VTAo+IF5AIGNoYXJhY3RlcnMgYnV0IG5vdCBhbHdh
eXMpLgoKV2hhdCBleGFjdGx5IGRvZXMgImhhcmQgbG9ja3VwIiBtZWFuPyBXaGF0IGFyZSB0aGUg
c3ltcHRvbXM/CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
