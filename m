From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 08/15] xen/gntdev: Use select for
 DMA_SHARED_BUFFER
Date: Mon, 28 Oct 2019 17:10:25 -0300
Message-ID: <20191028201032.6352-9-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc: Juergen Gross <jgross@suse.com>, David Zhou <David1.Zhou@amd.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, linux-rdma@vger.kernel.org, nouveau@lists.freedesktop.org, Dennis Dalessandro <dennis.dalessandro@intel.com>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Petr Cvek <petrcvekcz@gmail.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKRE1BX1NIQVJFRF9CVUZG
RVIgY2FuIG5vdCBiZSBlbmFibGVkIGJ5IHRoZSB1c2VyIChpdCByZXByZXNlbnRzIGEgbGlicmFy
eQpzZXQgaW4gdGhlIGtlcm5lbCkuIFRoZSBrY29uZmlnIGNvbnZlbnRpb24gaXMgdG8gdXNlIHNl
bGVjdCBmb3Igc3VjaApzeW1ib2xzIHNvIHRoZXkgYXJlIHR1cm5lZCBvbiBpbXBsaWNpdGx5IHdo
ZW4gdGhlIHVzZXIgZW5hYmxlcyBhIGtjb25maWcKdGhhdCBuZWVkcyB0aGVtLgoKT3RoZXJ3aXNl
IHRoZSBYRU5fR05UREVWX0RNQUJVRiBrY29uZmlnIGlzIG92ZXJseSBkaWZmaWN1bHQgdG8gZW5h
YmxlLgoKRml4ZXM6IDkzMmQ2NTYyMTc5ZSAoInhlbi9nbnRkZXY6IEFkZCBpbml0aWFsIHN1cHBv
cnQgZm9yIGRtYS1idWYgVUFQSSIpCkNjOiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xla3Nh
bmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+CkNjOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9z
dHJvdnNreUBvcmFjbGUuY29tPgpDYzogeGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCkNj
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+CkNjOiBTdGVmYW5vIFN0YWJlbGxpbmkg
PHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+ClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+ClJldmlld2VkLWJ5OiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xla3Nh
bmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+ClNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3Jw
ZSA8amdnQG1lbGxhbm94LmNvbT4KLS0tCiBkcml2ZXJzL3hlbi9LY29uZmlnIHwgMyArKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3hlbi9LY29uZmlnIGIvZHJpdmVycy94ZW4vS2NvbmZpZwppbmRleCA3OWNjNzUw
OTZmNDIzMi4uYTUwZGFkZDAxMDkzMzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMveGVuL0tjb25maWcK
KysrIGIvZHJpdmVycy94ZW4vS2NvbmZpZwpAQCAtMTQxLDcgKzE0MSw4IEBAIGNvbmZpZyBYRU5f
R05UREVWCiAKIGNvbmZpZyBYRU5fR05UREVWX0RNQUJVRgogCWJvb2wgIkFkZCBzdXBwb3J0IGZv
ciBkbWEtYnVmIGdyYW50IGFjY2VzcyBkZXZpY2UgZHJpdmVyIGV4dGVuc2lvbiIKLQlkZXBlbmRz
IG9uIFhFTl9HTlRERVYgJiYgWEVOX0dSQU5UX0RNQV9BTExPQyAmJiBETUFfU0hBUkVEX0JVRkZF
UgorCWRlcGVuZHMgb24gWEVOX0dOVERFViAmJiBYRU5fR1JBTlRfRE1BX0FMTE9DCisJc2VsZWN0
IERNQV9TSEFSRURfQlVGRkVSCiAJaGVscAogCSAgQWxsb3dzIHVzZXJzcGFjZSBwcm9jZXNzZXMg
YW5kIGtlcm5lbCBtb2R1bGVzIHRvIHVzZSBYZW4gYmFja2VkCiAJICBkbWEtYnVmIGltcGxlbWVu
dGF0aW9uLiBXaXRoIHRoaXMgZXh0ZW5zaW9uIGdyYW50IHJlZmVyZW5jZXMgdG8KLS0gCjIuMjMu
MAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1k
ZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8v
bGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=
