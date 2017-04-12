From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH 8/8] amdgpu: use sync file for shared semaphores (v3)
Date: Wed, 12 Apr 2017 12:25:46 +0200
Message-ID: <a76a6e6b-48c5-4038-5bad-a7125559cbe2@vodafone.de>
References: <20170412045726.13689-1-airlied@gmail.com>
 <20170412045726.13689-9-airlied@gmail.com>
 <43ed515c-7278-3687-022b-9ecd650669fb@vodafone.de>
 <20170412101855.GJ4250@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170412101855.GJ4250@nuc-i3427.alporthouse.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Chris Wilson <chris@chris-wilson.co.uk>, Dave Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTIuMDQuMjAxNyB1bSAxMjoxOCBzY2hyaWViIENocmlzIFdpbHNvbjoKPiBPbiBXZWQsIEFw
ciAxMiwgMjAxNyBhdCAxMTo1NToyNEFNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+
PiBBbSAxMi4wNC4yMDE3IHVtIDA2OjU3IHNjaHJpZWIgRGF2ZSBBaXJsaWU6Cj4+PiArc3RhdGlj
IGludCBhbWRncHVfc2VtX2xvb2t1cF9hbmRfcmVtb3ZlKHN0cnVjdCBhbWRncHVfY3NfcGFyc2Vy
ICpwLAo+Pj4gKwkJCQkgICAgICB1aW50MzJfdCBoYW5kbGUpCj4+PiArewo+Pj4gKwlpbnQgcjsK
Pj4+ICsJc3RydWN0IGRtYV9mZW5jZSAqb2xkX2ZlbmNlOwo+Pj4gKwo+Pj4gKwlyID0gZHJtX3N5
bmNvYmpfcmVwbGFjZV9mZW5jZShwLT5maWxwLCBoYW5kbGUsIE5VTEwpOwo+Pj4gKwlpZiAocikK
Pj4+ICsJCXJldHVybiByOwo+Pj4gKwlkbWFfZmVuY2VfcHV0KG9sZF9mZW5jZSk7Cj4+IEFtIEkg
d3Jvbmcgb3IgaXMgb2xkX2ZlbmNlIG5vdCBpbml0aWFsaXplZCBoZXJlPwo+Pgo+PiBBZGRpdGlv
bmFsIHRvIHRoYXQgd2hhdCBoYXBwZW5zIHdoZW4gdGhlIGZlbmNlIGluIHRoZSBzeW5jIG9iamVj
dAo+PiB3YXMgY2hhbmdlZCB3aGlsZSB3ZSBkbyB0aGUgQ1M/IE9yIGV2ZW4gd29yc2UgdGhlIGhh
bmRsZSBnb3QKPj4gYXNzaWduZWQgdG8gYSBuZXcgc3luYyBvYmplY3QuCj4gV2UgZWl0aGVyIHd3
X211dGV4IHRoZSBsb3QsIG9yIHJlZ2FyZCB0aGF0IGFzIGEgdXNlcnNwYWNlIHJhY2Ugd2hlcmUg
dGhlCj4gb3JkZXIgYmV0d2VlbiB0aGUgdHdvIGNvbmN1cnJlbnQgQ1MgZW1pdHMgaXMgdW5kZWZp
bmVkIGFuZCB3aG8gZ2V0cyB0aGUKPiBpbi1zZW1hcGhvcmUgaXMgaGFwcGVuc3RhbmNlLgoKTXkg
dGhpbmtpbmcgdG8gc29sdmUgdGhpcyB3YXMgcmF0aGVyIGEpIHJlc29sdmUgdGhlIGhhbmRsZSB0
byBhbiBvYmplY3QgCm9ubHkgb25jZSBhbmQgYikgcmVwbGFjZSB0aGUgb2xkIGZlbmNlIHdpdGgg
TlVMTCBvbmx5IGlmIGl0IGRpZG4ndCBjaGFuZ2VkLgoKTGV0dGluZyB1c2Vyc3BhY2UgcmFjZSBo
ZXJlIGlzIGFsc28gYW4gb3B0aW9uLCBidXQgSSB3b3VsZCBwcmVmZXIgaXQgCmFub3RoZXIgc29s
dXRpb24uCgpDaHJpc3RpYW4uCgo+IC1DaHJpcwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
