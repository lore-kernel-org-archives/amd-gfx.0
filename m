From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 8/8] drm/amdgpu: drop drmP.h from vcn_v2_5.c
Date: Wed, 31 Jul 2019 10:52:46 -0500
Message-ID: <20190731155246.20603-8-alexander.deucher@amd.com>
References: <20190731155246.20603-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190731155246.20603-1-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VW51c2VkLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYwppbmRleCAwYzg0ZGJjNmE2MmQuLjM5NWMyMjU5Zjk3
OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jCkBAIC0yMiw3ICsyMiw3IEBA
CiAgKi8KIAogI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+Ci0jaW5jbHVkZSA8ZHJtL2RybVAu
aD4KKwogI2luY2x1ZGUgImFtZGdwdS5oIgogI2luY2x1ZGUgImFtZGdwdV92Y24uaCIKICNpbmNs
dWRlICJzb2MxNS5oIgotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWw=
