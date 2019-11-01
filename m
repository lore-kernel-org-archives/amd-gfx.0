From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 08/15] xen/gntdev: Use select for
 DMA_SHARED_BUFFER
Date: Fri, 1 Nov 2019 15:26:11 -0300
Message-ID: <20191101182611.GA31478@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-9-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
Content-Disposition: inline
In-Reply-To: <20191028201032.6352-9-jgg@ziepe.ca>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, linux-rdma@vger.kernel.org, nouveau@lists.freedesktop.org, Dennis Dalessandro <dennis.dalessandro@intel.com>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMDU6MTA6MjVQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4KPiAKPiBE
TUFfU0hBUkVEX0JVRkZFUiBjYW4gbm90IGJlIGVuYWJsZWQgYnkgdGhlIHVzZXIgKGl0IHJlcHJl
c2VudHMgYSBsaWJyYXJ5Cj4gc2V0IGluIHRoZSBrZXJuZWwpLiBUaGUga2NvbmZpZyBjb252ZW50
aW9uIGlzIHRvIHVzZSBzZWxlY3QgZm9yIHN1Y2gKPiBzeW1ib2xzIHNvIHRoZXkgYXJlIHR1cm5l
ZCBvbiBpbXBsaWNpdGx5IHdoZW4gdGhlIHVzZXIgZW5hYmxlcyBhIGtjb25maWcKPiB0aGF0IG5l
ZWRzIHRoZW0uCj4gCj4gT3RoZXJ3aXNlIHRoZSBYRU5fR05UREVWX0RNQUJVRiBrY29uZmlnIGlz
IG92ZXJseSBkaWZmaWN1bHQgdG8gZW5hYmxlLgo+IAo+IEZpeGVzOiA5MzJkNjU2MjE3OWUgKCJ4
ZW4vZ250ZGV2OiBBZGQgaW5pdGlhbCBzdXBwb3J0IGZvciBkbWEtYnVmIFVBUEkiKQo+IENjOiBP
bGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xla3NhbmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+
Cj4gQ2M6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+Cj4gQ2M6
IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZwo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+Cj4gQ2M6IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVs
Lm9yZz4KPiBSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgo+IFJl
dmlld2VkLWJ5OiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xla3NhbmRyX2FuZHJ1c2hjaGVu
a29AZXBhbS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFu
b3guY29tPgo+IC0tLQo+ICBkcml2ZXJzL3hlbi9LY29uZmlnIHwgMyArKy0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKSnVlcmdlbi9PbGVrc2FuZHIv
WGVuIE1haW50YWluZXJzOgoKV291bGQgeW91IHRha2UgdGhpcyBwYXRjaCB0aHJvdWdoIGEgeGVu
IHJlbGF0ZWQgdHJlZT8gVGhlIG9ubHkgcmVhc29uCkkgaGFkIGluIHRoaXMgc2VyaWVzIGlzIHRv
IG1ha2UgaXQgZWFzaWVyIHRvIGNvbXBpbGUtdGVzdCB0aGUgZ250ZGV2CmNoYW5nZXMuCgpTaW5j
ZSBpdCBpcyBsb29raW5nIGxpa2UgdGhlIGdudGRldiByZXdvcmsgbWlnaHQgbm90IG1ha2UgaXQg
dGhpcwpjeWNsZSBpdCBpcyBwcm9iYWJseSBiZXN0IGZvciB5b3UgdG8gdGFrZSBpdC4KClRoYW5r
cywKSmFzb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Clhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0
dHBzOi8vbGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=
