From: Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 6/7] mm/hmm: remove hugetlbfs check in hmm_vma_walk_pmd
Date: Thu, 25 Jul 2019 17:56:49 -0700
Message-ID: <20190726005650.2566-7-rcampbell@nvidia.com>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-mm@kvack.org
Cc: Ralph Campbell <rcampbell@nvidia.com>, nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
List-Id: amd-gfx.lists.freedesktop.org

d2Fsa19wYWdlX3JhbmdlKCkgd2lsbCBvbmx5IGNhbGwgaG1tX3ZtYV93YWxrX2h1Z2V0bGJfZW50
cnkoKSBmb3IKaHVnZXRsYmZzIHBhZ2VzIGFuZCBkb2Vzbid0IGNhbGwgaG1tX3ZtYV93YWxrX3Bt
ZCgpIGluIHRoaXMgY2FzZS4KVGhlcmVmb3JlLCBpdCBpcyBzYWZlIHRvIHJlbW92ZSB0aGUgY2hl
Y2sgZm9yIHZtYS0+dm1fZmxhZ3MgJiBWTV9IVUdFVExCCmluIGhtbV92bWFfd2Fsa19wbWQoKS4K
ClNpZ25lZC1vZmYtYnk6IFJhbHBoIENhbXBiZWxsIDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4KQ2M6
ICJKw6lyw7RtZSBHbGlzc2UiIDxqZ2xpc3NlQHJlZGhhdC5jb20+CkNjOiBKYXNvbiBHdW50aG9y
cGUgPGpnZ0BtZWxsYW5veC5jb20+CkNjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4K
LS0tCiBtbS9obW0uYyB8IDMgLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9tbS9obW0uYyBiL21tL2htbS5jCmluZGV4IDgzOGNkMWQ1MDQ5Ny4uMjlmMzIy
Y2E1ZDU4IDEwMDY0NAotLS0gYS9tbS9obW0uYworKysgYi9tbS9obW0uYwpAQCAtNjMwLDkgKzYz
MCw2IEBAIHN0YXRpYyBpbnQgaG1tX3ZtYV93YWxrX3BtZChwbWRfdCAqcG1kcCwKIAlpZiAocG1k
X25vbmUocG1kKSkKIAkJcmV0dXJuIGhtbV92bWFfd2Fsa19ob2xlKHN0YXJ0LCBlbmQsIHdhbGsp
OwogCi0JaWYgKHBtZF9odWdlKHBtZCkgJiYgKHJhbmdlLT52bWEtPnZtX2ZsYWdzICYgVk1fSFVH
RVRMQikpCi0JCXJldHVybiBobW1fcGZuc19iYWQoc3RhcnQsIGVuZCwgd2Fsayk7Ci0KIAlpZiAo
dGhwX21pZ3JhdGlvbl9zdXBwb3J0ZWQoKSAmJiBpc19wbWRfbWlncmF0aW9uX2VudHJ5KHBtZCkp
IHsKIAkJYm9vbCBmYXVsdCwgd3JpdGVfZmF1bHQ7CiAJCXVuc2lnbmVkIGxvbmcgbnBhZ2VzOwot
LSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
