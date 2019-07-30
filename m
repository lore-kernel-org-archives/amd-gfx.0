From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 09/13] mm: don't abuse pte_index() in
 hmm_vma_handle_pmd
Date: Tue, 30 Jul 2019 08:51:59 +0300
Message-ID: <20190730055203.28467-10-hch@lst.de>
References: <20190730055203.28467-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190730055203.28467-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: amd-gfx.lists.freedesktop.org

cHRlX2luZGV4IGlzIGFuIGludGVybmFsIGFyY2ggaGVscGVyIGluIHZhcmlvdXMgYXJjaGl0ZWN0
dXJlcywKd2l0aG91dCBjb25zaXN0ZW50IHNlbWFudGljcy4gIE9wZW4gY29kZSB0aGF0IGNhbGN1
bGF0aW9uIG9mIGEgUE1ECmluZGV4IGJhc2VkIG9uIHRoZSB2aXJ0dWFsIGFkZHJlc3MgaW5zdGVh
ZC4KClNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgotLS0KIG1t
L2htbS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvbW0vaG1tLmMgYi9tbS9obW0uYwppbmRleCA4OGI3N2E0YTZhMWUu
LmU2M2FiN2YxMTMzNCAxMDA2NDQKLS0tIGEvbW0vaG1tLmMKKysrIGIvbW0vaG1tLmMKQEAgLTQ4
Niw3ICs0ODYsNyBAQCBzdGF0aWMgaW50IGhtbV92bWFfaGFuZGxlX3BtZChzdHJ1Y3QgbW1fd2Fs
ayAqd2FsaywKIAlpZiAocG1kX3Byb3Rub25lKHBtZCkgfHwgZmF1bHQgfHwgd3JpdGVfZmF1bHQp
CiAJCXJldHVybiBobW1fdm1hX3dhbGtfaG9sZV8oYWRkciwgZW5kLCBmYXVsdCwgd3JpdGVfZmF1
bHQsIHdhbGspOwogCi0JcGZuID0gcG1kX3BmbihwbWQpICsgcHRlX2luZGV4KGFkZHIpOworCXBm
biA9IHBtZF9wZm4ocG1kKSArICgoYWRkciAmIH5QTURfTUFTSykgPj4gUEFHRV9TSElGVCk7CiAJ
Zm9yIChpID0gMDsgYWRkciA8IGVuZDsgYWRkciArPSBQQUdFX1NJWkUsIGkrKywgcGZuKyspIHsK
IAkJaWYgKHBtZF9kZXZtYXAocG1kKSkgewogCQkJcGdtYXAgPSBnZXRfZGV2X3BhZ2VtYXAocGZu
LCBwZ21hcCk7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCk5vdXZlYXUgbWFpbGluZyBsaXN0Ck5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vbm91
dmVhdQ==
