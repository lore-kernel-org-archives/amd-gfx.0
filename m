From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH v2 0/3] Cleanup evergreen/si IRQ handling code
Date: Sat, 20 May 2017 13:39:42 +0200
Message-ID: <51a14f4e-8771-3bca-b05f-25732da50b34@vodafone.de>
References: <20170516211202.20325-1-lyude@redhat.com>
 <20170519234840.5644-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170519234840.5644-1-lyude@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lyude <lyude@redhat.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjAuMDUuMjAxNyB1bSAwMTo0OCBzY2hyaWViIEx5dWRlOgo+IFRoaXMgaXMgdGhlIGZpcnN0
IHBhcnQgb2YgbWUgZ29pbmcgdGhyb3VnaCBhbmQgY2xlYW5pbmcgdXAgdGhlIElSUSBoYW5kbGlu
Zwo+IGNvZGUgZm9yIHJhZGVvbiwgc2luY2UgYWZ0ZXIgdGFraW5nIGEgbG9vayBhdCBpdCB0aGUg
b3RoZXIgZGF5IHdoaWxlIHRyeWluZyB0bwo+IGRlYnVnIHNvbWV0aGluZyBJIHJlYWxpemVkIGJh
c2ljYWxseSBhbGwgb2YgdGhlIGNvZGUgd2FzIGNvcHkgcGFzdGVkCj4gZXZlcnl3aGVyZSwgYW5k
IHF1aXRlIGRpZmZpY3VsdCB0byBhY3R1YWxseSByZWFkIHRocm91Z2guCj4KPiBXaWxsIGNvbWUg
dXAgd2l0aCBzb21ldGhpbmcgZm9yIHI2MDAgYW5kIGNpayBvbmNlIEkndmUgZ290IHRoZSBjaGlw
c2V0cyBvbiBoYW5kCj4gdG8gdGVzdCB3aXRoLgo+Cj4gTHl1ZGUgKDMpOgo+ICAgIGRybS9yYWRl
b246IENsZWFudXAgZGlzcGxheSBpbnRlcnJ1cHQgaGFuZGxpbmcgZm9yIGV2ZXJncmVlbiwgc2kK
PiAgICBkcm0vcmFkZW9uOiBDbGVhbnVwIEhETUkgYXVkaW8gaW50ZXJydXB0IGhhbmRsaW5nIGZv
ciBldmVyZ3JlZW4KPiAgICBkcm0vcmFkZW9uOiBDbGVhbnVwIHBhZ2VmbGlwcGluZyBJUlEgaGFu
ZGxpbmcgZm9yIGV2ZXJncmVlbiwgc2kKCkkgZG9uJ3QgaGF2ZSB0aW1lIHRvIGRvIGEgbGluZSBi
eSBsaW5lIHJldmlldywgYnV0IHdoYXQgSSBzYXcgbG9va2VkIAp2ZXJ5IGdvb2QgdG8gbWUuCgpT
byB0aGUgd2hvbGUgc2VyZXMgaXMgQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4uCgpCVFc6IFlvdSBkb24ndCB3YW50IHRvIHRha2UgYSBsb29rIGF0
IHRoZSBvdGhlciBodyBnZW5lcmF0aW9ucyBhcyB3ZWxsPwoKUmVnYXJkcywKQ2hyaXN0aWFuLgoK
Pgo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYyAgICAgIHwgOTQzICsrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbi5oICAgICAgICAgfCAgMjcgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X2lycV9rbXMuYyB8ICAzNSArKwo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5jICAgICAg
ICAgICAgIHwgNjU1ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDQgZmlsZXMgY2hhbmdlZCwg
MzQ0IGluc2VydGlvbnMoKyksIDEzMTYgZGVsZXRpb25zKC0pCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
