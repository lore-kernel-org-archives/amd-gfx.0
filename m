From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/15] amdgpu: don't initialize range->list in amdgpu_hmm_init_range
Date: Tue,  6 Aug 2019 19:05:40 +0300
Message-ID: <20190806160554.14046-3-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

The list is used to add the range to another list as an entry in the
core hmm code, and intended as a private member not exposed to drivers.
There is no need to initialize it in a driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index b698b423b25d..60b9fc9561d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -484,6 +484,5 @@ void amdgpu_hmm_init_range(struct hmm_range *range)
 		range->flags = hmm_range_flags;
 		range->values = hmm_range_values;
 		range->pfn_shift = PAGE_SHIFT;
-		INIT_LIST_HEAD(&range->list);
 	}
 }
-- 
2.20.1
