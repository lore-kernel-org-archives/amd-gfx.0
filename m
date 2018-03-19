From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 1/5] dma-buf: add optional invalidate_mappings callback v2
Date: Mon, 19 Mar 2018 15:53:22 +0000
Message-ID: <152147480241.18954.4556582215766884582@mail.alporthouse.com>
References: <20180316132049.1748-1-christian.koenig@amd.com>
 <20180316132049.1748-2-christian.koenig@amd.com>
 <152120831102.25315.4326885184264378830@mail.alporthouse.com>
 <21879456-db47-589c-b5e2-dfe8333d9e4c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <21879456-db47-589c-b5e2-dfe8333d9e4c@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: christian.koenig@amd.com, =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

UXVvdGluZyBDaHJpc3RpYW4gS8O2bmlnICgyMDE4LTAzLTE2IDE0OjIyOjMyKQpbc25pcCwgcHJv
YmFibHkgbG9zdCB0b28gbXVzdCBjb250ZXh0XQo+IFRoaXMgYWxsb3dzIGZvciBmdWxsIGdyb3du
IHBpcGVsaW5pbmcsIGUuZy4gdGhlIGV4cG9ydGVyIGNhbiBzYXkgSSBuZWVkIAo+IHRvIG1vdmUg
dGhlIGJ1ZmZlciBmb3Igc29tZSBvcGVyYXRpb24uIFRoZW4gbGV0IHRoZSBtb3ZlIG9wZXJhdGlv
biB3YWl0IAo+IGZvciBhbGwgZXhpc3RpbmcgZmVuY2VzIGluIHRoZSByZXNlcnZhdGlvbiBvYmpl
Y3QgYW5kIGluc3RhbGwgdGhlIGZlbmNlIAo+IG9mIHRoZSBtb3ZlIG9wZXJhdGlvbiBhcyBleGNs
dXNpdmUgZmVuY2UuCgpPaywgdGhlIHNpdHVhdGlvbiBJIGhhdmUgaW4gbWluZCBpcyB0aGUgbm9u
LXBpcGVsaW5lZCBjYXNlOiByZXZva2luZwpkbWEtYnVmIGZvciBtbXVfaW52YWxpZGF0ZV9yYW5n
ZSBvciBzaHJpbmtfc2xhYi4gSSB3b3VsZCBuZWVkIGEKY29tcGxldGlvbiBldmVudCB0aGF0IGNh
biBiZSB3YWl0ZWQgb24gdGhlIGNwdSBmb3IgYWxsIHRoZSBpbnZhbGlkYXRlCmNhbGxiYWNrcy4g
KEVzc2VudGlhbGx5IGFuIGF0b21pY190IGNvdW50ZXIgcGx1cyBzdHJ1Y3QgY29tcGxldGlvbjsg
YQpsaWdodGVyIHZlcnNpb24gb2YgZG1hX2ZlbmNlLCBJIHdvbmRlciB3aGVyZSBJJ3ZlIHNlZW4g
dGhhdCBiZWZvcmUgOykKCkV2ZW4gc28sIGl0IGJhc2ljYWxseSBtZWFucyBwYXNzaW5nIGEgZmVu
Y2Ugb2JqZWN0IGRvd24gdG8gdGhlIGFzeW5jCmNhbGxiYWNrcyBmb3IgdGhlbSB0byBzaWduYWwg
d2hlbiB0aGV5IGFyZSBjb21wbGV0ZS4gSnVzdCB0byBoYW5kbGUgdGhlCm5vbi1waXBlbGluZWQg
dmVyc2lvbi4gOnwKLUNocmlzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ry
aS1kZXZlbAo=
