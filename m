From: Dave Airlie <airlied@gmail.com>
Subject: Re: Soliciting DRM feedback on latest DC rework
Date: Tue, 9 May 2017 05:07:28 +1000
Message-ID: <CAPM=9tw0au4Kji77nKh-M91OX9ioyEfEz3qG6iWJZnS5r8demg@mail.gmail.com>
References: <6409067e-8f25-d2f8-37ee-fb3ed3c06ea2@amd.com>
 <3a91983c-3599-dc8d-12af-642eacb1f6c2@amd.com>
 <20170503150236.pkr3r2o5l2pjx5m5@phenom.ffwll.local>
 <244fc211-ec97-cb99-9f2f-b16b02f874b2@amd.com>
 <ad7a0d85-817c-aee7-a596-374db23b8a2d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <ad7a0d85-817c-aee7-a596-374db23b8a2d@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Harry Wentland <harry.wentland@amd.com>
Cc: dc_upstream <dc_upstream@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gOSBNYXkgMjAxNyBhdCAwNDo1NCwgSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFt
ZC5jb20+IHdyb3RlOgo+IEhpIERhbmllbCwKPgo+IFRoYW5rcyBmb3IgdGFraW5nIHRoZSB0aW1l
IHRvIGxvb2sgYXQgREMuCj4KPiBJIGhhZCBhIGNvdXBsZSBtb3JlIHF1ZXN0aW9ucy9jb21tZW50
cyBpbiByZWdhcmQgdG8gdGhlIHBhdGNoIHlvdSBwb3N0ZWQgb24KPiBJUkM6IGh0dHA6Ly9wYXN0
ZS5kZWJpYW4ubmV0L3BsYWluLzkzMDcwNAo+Cj4gTXkgaW1wcmVzc2lvbiBpcyB0aGF0IHRoaXMg
aXRlbSBpcyB0aGUgbW9zdCBpbXBvcnRhbnQgbmV4dCBzdGVwIGZvciB1czoKPgo+PiAgICAgRnJv
bSBhIHF1aWNrIGdsYW5jZSBJIHRoaW5rIHdoYXQgd2Ugd2FudCBpbnN0ZWFkIGlzOgo+PiAgICAg
LSBhbWRncHVfY3J0Y19zdGF0ZSBhbmQgYW1kZ3B1X3BsYW5lX3N0YXRlIGFzIGZvbGxvd2luZzoK
Pj4KPj4gICAgIHN0cnVjdCBhbWRncHVfY3J0Y19zdGF0ZSB7Cj4+ICAgICAgICAgICAgIHN0cnVj
dCBkcm1fY3J0Y19zdGF0ZSBiYXNlOwo+PiAgICAgICAgICAgICBzdHJ1Y3QgZGNfc3RyZWFtOwo+
PiAgICAgfTsKPgo+Cj4gVW5mb3J0dW5hdGVseSBhcyBza2V0Y2hlZCBoZXJlIGl0IGRvZXNuJ3Qg
cXVpdGUgbWVzaCB3aXRoIHdoYXQgd2UgY3VycmVudGx5Cj4gaGF2ZSwgd2hpY2ggaXM6Cj4KPiBz
dHJ1Y3Qgc3RyZWFtIHsKPiAgICAgICAgIHN0cnVjdCBjb3JlX3N0cmVhbSBwcm90ZWN0ZWQ7Cj4g
ICAgICAgICAuLi4KPiB9Cj4KPiBzdHJ1Y3QgY29yZV9zdHJlYW0gewo+ICAgICAgICAgc3RydWN0
IGRjX3N0cmVhbSBwdWJsaWM7Cj4gICAgICAgICAuLi4KPiB9Cj4KPiBzdHJ1Y3QgZGNfc3RyZWFt
IHsKPiAgICAgICAgIC4uLgo+IH0KPgoKSXMgdGhlcmUgYW55IG1ham9yIHJlYXNvbiB0byBrZWVw
IGFsbCB0aG9zZSBhYnN0cmFjdGlvbnM/CgpDb3VsZCB5b3UgY29sbGFwc2UgZXZlcnl0aGluZyBp
bnRvIHN0cnVjdCBkY19zdHJlYW0/CgpJIGhhdmVuJ3QgbG9va2VkIHJlY2VudGx5IGJ1dCBJIGRp
ZG4ndCBnZXQgdGhlIGltcHJlc3Npb24gdGhlcmUgd2FzIGEKbG90IG9mIGRlc2lnbiBhcm91bmQg
d2hhdCB3YXMgcHVibGljL3Byb3RlY3RlZCwgbW9yZSB3aGF0ZXZlciBuZWVkZWQKdG8gYmUgdXNl
ZCBieSBzb21lb25lIGVsc2Ugd2FzIGluIHB1YmxpYy4KCkRhdmUuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
