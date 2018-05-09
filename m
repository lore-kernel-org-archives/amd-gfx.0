From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 0/3] drm/connector: Provide generic support for underscan
Date: Wed, 9 May 2018 09:28:27 +0200
Message-ID: <20180509092827.0a62c620@bbrezillon>
References: <20180507144434.20466-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180507144434.20466-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

SGksCgpPbiBNb24sICA3IE1heSAyMDE4IDE2OjQ0OjMxICswMjAwCkJvcmlzIEJyZXppbGxvbiA8
Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gSGVsbG8sCj4gCj4gVGhpcyBp
cyBhbiBhdHRlbXB0IGF0IHByb3ZpZGluZyBnZW5lcmljIHN1cHBvcnQgZm9yIHVuZGVyc2NhbiBj
b25uZWN0b3IKPiBwcm9wcy4gV2UgYWxyZWFkeSBoYXZlIDMgZHJpdmVycyBkZWZpbmluZyB0aGUg
c2FtZSB1bmRlcnNjYW4sIHVuZGVyc2Nhbgo+IHZib3JkZXIgYW5kIHVuZGVyc2NhbiBoYm9yZGVy
IHByb3BlcnRpZXMgKGFtZCwgcmFkZW9uIGFuZCBub3V2ZWF1KSBhbmQKPiBJIGFtIGFib3V0IHRv
IGFkZCBhIG5ldyBvbmUsIGhlbmNlIG15IHByb3Bvc2FsIHRvIHB1dCB0aGUgcHJvcCBwYXJzaW5n
Cj4gY29kZSBpbiB0aGUgY29yZSBhbmQgYWRkIC0+dW5kZXJzY2FuIGZpZWxkcyB0byBkcm1fY29u
bmVjdG9yX3N0YXRlLgo+IAo+IE5vdGUgdGhhdCBJIHVzZSB0aGlzIG5ldyBpbmZyYXN0cnVjdHVy
ZSB0byBzdXBwb3J0IHVuZGVyc2NhbiBpbiBWQzQKPiAocGF0aCAyIGFuZCAzKSBidXQgZGlkIG5v
dCBwYXRjaCBleGlzdGluZyBkcml2ZXJzIHlldCwgbWFpbmx5IGJlY2F1c2UgSQo+IGRvbid0IHdh
bnQgdG8gZG8gdGhpcyB3b3JrIGJlZm9yZSBtYWtpbmcgc3VyZSBJIGdvdCB0aGUgZ2VuZXJpYyBi
aXRzCj4gcmlnaHQuCgpUaGFua3MgZXZlcnlvbmUgZm9yIHlvdXIgcmV2aWV3cy4gQWZ0ZXIgdGhl
IGRpc2N1c3Npb24gd2UgaGFkIG9uIElSQwphbmQgdGhlIGZlZWRiYWNrIEkgaGFkIG9uIHRoaXMg
cGF0Y2hzZXQgaXQncyBhIGJpdCB1bmNsZWFyIHRvIG1lIHdoYXQKdGhlIG5leHQgaXRlcmF0aW9u
IHNob3VsZCBsb29rIGxpa2UuIFNob3VsZCBJIGNvbnRpbnVlIHdpdGggdGhlCnVuZGVyc2NhbiBw
cm9wcywgc2hvdWxkIEkgdXNlIFRWIG1hcmdpbnMgZXhwb3NlZCBieSB0aGUgVFYgY29ubmVjdG9y
CnN0YXRlLCBzaG91bGQgSSBjcmVhdGUgbmV3IHByb3BzPwoKUmVtZW1iZXIgdGhhdCBhbGwgSSBu
ZWVkIGlzIGEgd2F5IHRvIGRlZmluZSBtYXJnaW5zIGluIG9yZGVyIHRvIGxldAp0aGUgVkM0IEhX
IHNjYWxlciBzaHJpbmsgdGhlIHBsYW5lcyBhbmQgYWRqdXN0IHRoZWlyIHBvc2l0aW9ucyBvbiB0
aGUKc2NyZWVuLgoKVGhhbmtzLAoKQm9yaXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbAo=
