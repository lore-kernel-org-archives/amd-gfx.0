From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/amdkfd: Use ARRAY_SIZE macro in
 kfd_build_sysfs_node_entry
Date: Thu, 18 Jan 2018 18:39:55 -0600
Message-ID: <20180119003955.GA28885@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c6a7609..7783250 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -677,7 +677,7 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 	}
 
 	/* All hardware blocks have the same number of attributes. */
-	num_attrs = sizeof(perf_attr_iommu)/sizeof(struct kfd_perf_attr);
+	num_attrs = ARRAY_SIZE(perf_attr_iommu);
 	list_for_each_entry(perf, &dev->perf_props, list) {
 		perf->attr_group = kzalloc(sizeof(struct kfd_perf_attr)
 			* num_attrs + sizeof(struct attribute_group),
-- 
2.7.4
