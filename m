From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amdkfd: Fix a && vs || typo
Date: Mon, 7 Oct 2019 11:52:10 +0300
Message-ID: <20191007085210.GC3865@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>, Yong Zhao <Yong.Zhao@amd.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

SW4gdGhlIGN1cnJlbnQgY29kZSBpZiAiZGV2aWNlX2luZm8iIGlzIGV2ZXIgTlVMTCB0aGVuIHRo
ZSBrZXJuZWwgd2lsbApPb3BzIHNvIHByb2JhYmx5IHx8IHdhcyBpbnRlbmRlZCBpbnN0ZWFkIG9m
ICYmLgoKRml4ZXM6IGUzOTJjODg3ZGY5NyAoImRybS9hbWRrZmQ6IFVzZSBhcnJheSB0byBwcm9i
ZSBrZmQya2dkX2NhbGxzIikKU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBvcmFjbGUuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZp
Y2UuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwppbmRleCAwZGIyNzM1ODdh
ZjQuLjA3MGM5YjU1OTNjOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2Uu
YwpAQCAtNDk4LDcgKzQ5OCw3IEBAIHN0cnVjdCBrZmRfZGV2ICprZ2Qya2ZkX3Byb2JlKHN0cnVj
dCBrZ2RfZGV2ICprZ2QsCiAJZGV2aWNlX2luZm8gPSBrZmRfc3VwcG9ydGVkX2RldmljZXNbYXNp
Y190eXBlXVt2Zl07CiAJZjJnID0ga2ZkMmtnZF9mdW5jc1thc2ljX3R5cGVdOwogCi0JaWYgKCFk
ZXZpY2VfaW5mbyAmJiAhZjJnKSB7CisJaWYgKCFkZXZpY2VfaW5mbyB8fCAhZjJnKSB7CiAJCWRl
dl9lcnIoa2ZkX2RldmljZSwgIiVzICVzIG5vdCBzdXBwb3J0ZWQgaW4ga2ZkXG4iLAogCQkJYW1k
Z3B1X2FzaWNfbmFtZVthc2ljX3R5cGVdLCB2ZiA/ICJWRiIgOiAiIik7CiAJCXJldHVybiBOVUxM
OwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWw=
