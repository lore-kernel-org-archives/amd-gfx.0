From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Add documentation for PRIME related code
Date: Fri, 1 Jun 2018 09:44:15 -0400
Message-ID: <CADnq5_M-kS58ScgOBVQG7Mxxepae9b9gqUdMdFgaPaaxQ4NkjQ@mail.gmail.com>
References: <20180531161708.5894-1-michel@daenzer.net>
 <20180531161708.5894-3-michel@daenzer.net>
 <CADnq5_O5-m_=xqszq41eOAVaLTytHUHmtDaSc1MeEorZML6T5g@mail.gmail.com>
 <b458561f-b4e5-58bb-eee0-e3451312ae41@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <b458561f-b4e5-58bb-eee0-e3451312ae41@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBKdW4gMSwgMjAxOCBhdCA5OjQwIEFNLCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPiBPbiAyMDE4LTA2LTAxIDAyOjU4IFBNLCBBbGV4IERldWNoZXIg
d3JvdGU6Cj4+IE9uIFRodSwgTWF5IDMxLCAyMDE4IGF0IDEyOjE3IFBNLCBNaWNoZWwgRMOkbnpl
ciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPj4+IEZyb206IE1pY2hlbCBEw6RuemVyIDxt
aWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6Ru
emVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pgo+PiBTZXJpZXMgaXM6Cj4+IFJldmlld2Vk
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4KPiBUaGFua3Mu
IElzIGl0IG9rYXkgdG8gbWVyZ2UgYWxsIG9mIHRoZXNlIHZpYSB0aGUgYW1kZ3B1IHRyZWUsIG9y
IHNob3VsZAo+IEkgd2FpdCBmb3IgYW4gYWNrIGZyb20gSm9uIGFuZC9vciBjb3JlIERSTSBtYWlu
dGFpbmVycyBmb3IgdGhhdD8KCkdQVSBkb2N1bWVudGF0aW9uIHVzdWFsbHkgZ29lcyB0aHJvdWdo
IHRoZSBkcm0gdHJlZXMuICBZb3UgbWlnaHQgd2FudAp0byBwdXNoIHBhdGNoIDEgKGRybV9tbS5y
c3QgZml4KSB2aWEgZHJtX21pc2MsIGJ1dCB0aGUgcmVzdCBhcmUgY2FuIGdvCmluIHZpYSB0aGUg
YW1kZ3B1IHRyZWUgc2luY2UgdGhleSBhcmUgYW1kZ3B1IHNwZWNpZmljLgoKQWxleApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
