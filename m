From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 1/2] mm/hmm: support automatic NUMA balancing
Date: Fri, 10 May 2019 16:13:32 -0400
Message-ID: <20190510201331.GF4507@redhat.com>
References: <20190510195258.9930-1-Felix.Kuehling@amd.com>
 <20190510195258.9930-2-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190510195258.9930-2-Felix.Kuehling@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "Yang, Philip" <Philip.Yang@amd.com>, "alex.deucher@amd.com" <alex.deucher@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBNYXkgMTAsIDIwMTkgYXQgMDc6NTM6MjNQTSArMDAwMCwgS3VlaGxpbmcsIEZlbGl4
IHdyb3RlOgo+IEZyb206IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPgo+IAo+IFdo
aWxlIHRoZSBwYWdlIGlzIG1pZ3JhdGluZyBieSBOVU1BIGJhbGFuY2luZywgSE1NIGZhaWxlZCB0
byBkZXRlY3QgdGhpcwo+IGNvbmRpdGlvbiBhbmQgc3RpbGwgcmV0dXJuIHRoZSBvbGQgcGFnZS4g
QXBwbGljYXRpb24gd2lsbCB1c2UgdGhlIG5ldwo+IHBhZ2UgbWlncmF0ZWQsIGJ1dCBkcml2ZXIg
cGFzcyB0aGUgb2xkIHBhZ2UgcGh5c2ljYWwgYWRkcmVzcyB0byBHUFUsCj4gdGhpcyBjcmFzaCB0
aGUgYXBwbGljYXRpb24gbGF0ZXIuCj4gCj4gVXNlIHB0ZV9wcm90bm9uZShwdGUpIHRvIHJldHVy
biB0aGlzIGNvbmRpdGlvbiBhbmQgdGhlbiBobW1fdm1hX2RvX2ZhdWx0Cj4gd2lsbCBhbGxvY2F0
ZSBuZXcgcGFnZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdA
YW1kLmNvbT4KClJldmlld2VkLWJ5OiBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNv
bT4KCj4gLS0tCj4gIG1tL2htbS5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbW0vaG1tLmMgYi9tbS9obW0u
Ywo+IGluZGV4IDc1ZDJlYTkwNmVmYi4uYjY1YzI3ZDVjMTE5IDEwMDY0NAo+IC0tLSBhL21tL2ht
bS5jCj4gKysrIGIvbW0vaG1tLmMKPiBAQCAtNTU0LDcgKzU1NCw3IEBAIHN0YXRpYyBpbnQgaG1t
X3ZtYV9oYW5kbGVfcG1kKHN0cnVjdCBtbV93YWxrICp3YWxrLAo+ICAKPiAgc3RhdGljIGlubGlu
ZSB1aW50NjRfdCBwdGVfdG9faG1tX3Bmbl9mbGFncyhzdHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSwg
cHRlX3QgcHRlKQo+ICB7Cj4gLQlpZiAocHRlX25vbmUocHRlKSB8fCAhcHRlX3ByZXNlbnQocHRl
KSkKPiArCWlmIChwdGVfbm9uZShwdGUpIHx8ICFwdGVfcHJlc2VudChwdGUpIHx8IHB0ZV9wcm90
bm9uZShwdGUpKQo+ICAJCXJldHVybiAwOwo+ICAJcmV0dXJuIHB0ZV93cml0ZShwdGUpID8gcmFu
Z2UtPmZsYWdzW0hNTV9QRk5fVkFMSURdIHwKPiAgCQkJCXJhbmdlLT5mbGFnc1tITU1fUEZOX1dS
SVRFXSA6Cj4gLS0gCj4gMi4xNy4xCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RyaS1kZXZlbA==
