Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723F5C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 05:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB38B10E25B;
	Thu, 24 Nov 2022 05:50:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FA210E25B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 05:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ1YJI0L1hWMnY9+J09CKpqRYqmA8cLe5syfIJCLEybmz5DcuZmZYbjoXNzBh2TzBT9KK9EWOv/qTkTrcPFhIPD00AlUuwh4p+lGLthyIK91yj8Ck1KZLxZmMWXnaLO5+atbtiEU6qkjd2oiOb30972jzh0oxaQEJ7+qfsyXD+lnGXzApWlKbzfZSbccwzcVMUhtLM3VbGQCqNeDRmE5TJ14BJUKBN0Zse/HHg2ursSqFO7Q0IWIM0gZtkReL9gKSwKSsz1eiG4lZhD5QUb4CWMQyCwfjxGw+kbFQekyh3ddzlo0sIZXP6agIQ73b+h7ycW9RQboy/t5dDlQbmJWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VRt8JGZuhrfLcXEUp77uEcE3mdSu9jmsqgujCCFX38=;
 b=Rd4Vj5Z1ktXJ2A2AjZs1W2Un/mrg3NzXtqBI3Nvyg232ZeteY6u/fNlcBgf7Kl1utACxNiL6VpPnLe66JeNJ0rnqvoUGiAjOPePJl4FXs/6H3zzkcrzXtGlhp0/1QqT5h/1zWs5pDloHe1BQrVJG/oGztlLz4qMgLyI1+auFwTO1STdZmbWcxx/a6Gy0xuz5Kt/l4OGPj+YODtf+SyFyIHWnGBkOQ4qo/MTbFKBVoe8DMiMP3k+0RZWo9qNgi3Nd8inM0JD3YuZ63i2UeR3bN1LVoBi5Kq3T6CCMdVNPb5141dNFcsvOcTZSUMWwvQFI+U/nZ+e33RgQYmnCTUyHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VRt8JGZuhrfLcXEUp77uEcE3mdSu9jmsqgujCCFX38=;
 b=PAhiAmtbom8Va5IZ/NWgCtwNj5iA2usx5genZAY0b/Ve2/AeSJRb7eUXPOETEgImdXl42tVHacM37SWKGUFptc65FKrS5KDha/ca9l7TnHE0qZ7DtyMnc1x4QD1NEMk5CVtFdjXlZc/orYnBD7NQxNzJskWyhzOwKZNTBcP5kCE=
Received: from DM6PR02CA0094.namprd02.prod.outlook.com (2603:10b6:5:1f4::35)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 24 Nov
 2022 05:50:40 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::79) by DM6PR02CA0094.outlook.office365.com
 (2603:10b6:5:1f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 05:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 05:50:39 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Nov
 2022 23:50:33 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add amdgpu vram usage information into
 amdgpu_vram_mm
Date: Thu, 24 Nov 2022 13:49:45 +0800
Message-ID: <20221124054945.3409867-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 9087842d-975f-4e23-d54a-08dacddfd11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mxXTKaw3vtDle4mwT3aH7ZGh+6QjSrVJRjcQ3JkFADShmLWrmg234KA9dqKpraoPsgB7zmXhY7jMmBMt2ShMj5vYypNHduds2DfdfBgOwWA84KxsEgboku1nWSi2PDJcRkI2gh925rmliLKPvdwKYeCCWLd5IZ/DwcJf2ZZ0VooKSyv3Ih1812tRgaUwgHW1dJ97ZCEBaIzwkLFVmRgZ63qk6fSDGF/jhYzcBp82DpxV33N1jeO6MrLKL8LYbfLHGoEWKJlldO7KRaPBHG4OXkP+7VniFwiZDn8Kf/u5WE8F8Q2zSzhm4KFhZUktoroGBqEveM19j8dFiKYviwhqR1MD8Lm6cpwXNegdkH4z13ngkjjclIObhTimiC/fMNN/KXW59Lr2q3QaAWncubHCKwE4ezyyk9YRInATC0Xl/l70xL/4/QIIYQWdIm9gcbE01MF9WGExCzSlzy8pJ2m+y/mfYiO1/drBSQjxJoxUE1B8dKHlOXz8x2ahS5Z37xShH2FRPGJwqiHWrLFxOI585nzqxWjeb9oOJMAkRqPvdNFeBK24XeEpXq20OlQGcKml5VhvsdwXwx4FDpugdhqYiz3kD3Ml4rN1Ch1rJkzKaI3CHXMjARh7y57WO/PrXuaL9+7G2ptTvGJHzMHur1OVFdLyXV+oo0uCvsGui1edOfYIS+qhvBc5YLtXE9zBVdEyyGu6XQDaml1lVsGICa/HkuVlONjftfiI0nH5mY6RXe9TdsuEfXou+adrdZGub9egxIBwieCgaGjNHY+cJfhV5fxzvBHYG8YqwXT18cXUus=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(83380400001)(82310400005)(40480700001)(2906002)(36860700001)(82740400003)(5660300002)(8936002)(81166007)(40460700003)(356005)(1076003)(426003)(186003)(2616005)(47076005)(336012)(16526019)(316002)(7696005)(41300700001)(6666004)(26005)(6916009)(478600001)(8676002)(70206006)(4326008)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 05:50:39.5646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9087842d-975f-4e23-d54a-08dacddfd11f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Yang Wang <KevinYang.Wang@amd.com>, Hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add vram usage information into dri debugfs amdgpu_vram_mm node.

Background:
when amdgpu driver introduces drm buddy allocator, the kernel driver
(and developer) is difficult to track the vram usage information.

Field:
0xaaaaaaaa-0xbbbbbbbb: vram usaged range.
type: kernel, device, sg
usage: normal, vm, user
domain: C-CPU, G-GTT, V-VRAM, P-PRIV
@xxxxx: the address of "amdgpu_bo" object in kernel space.
4096: vram range range.

Example:
0x00000003fea68000-0x00000003fea68fff: (type:kernel usage:vm       domain:--V- --V-) @000000001d33dfee 4096 bytes
0x00000003fea69000-0x00000003fea69fff: (type:kernel usage:vm       domain:--V- --V-) @00000000a79155b5 4096 bytes
0x00000003fea6b000-0x00000003fea6bfff: (type:kernel usage:vm       domain:--V- --V-) @0000000038ad633b 4096 bytes
0x00000003fea6c000-0x00000003fea6cfff: (type:device usage:user     domain:--V- --V-) @00000000e302f90b 4096 bytes
0x00000003fea6d000-0x00000003fea6dfff: (type:device usage:user     domain:--V- --V-) @00000000e664c172 4096 bytes
0x00000003fea6e000-0x00000003fea6efff: (type:kernel usage:vm       domain:--V- --V-) @000000004528cb2f 4096 bytes
0x00000003fea6f000-0x00000003fea6ffff: (type:kernel usage:vm       domain:--V- --V-) @00000000a446bdbf 4096 bytes
0x00000003fea70000-0x00000003fea7ffff: (type:device usage:user     domain:--V- --V-) @0000000078fae42f 65536 bytes
0x00000003fead8000-0x00000003feadbfff: (type:kernel usage:normal   domain:--V- --V-) @000000001327b7ff 16384 bytes
0x00000003feadc000-0x00000003feadcfff: (type:kernel usage:normal   domain:--V- --V-) @000000001327b7ff 4096 bytes
0x00000003feadd000-0x00000003feaddfff: (type:kernel usage:normal   domain:--V- --V-) @00000000b9706fc1 4096 bytes
0x00000003feade000-0x00000003feadefff: (type:kernel usage:vm       domain:--V- --V-) @0000000071a25571 4096 bytes

Note:
although some vram ranges can be merged in the example above,
but this can reflect the actual distribution of drm buddy allocator.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 130 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |   1 +
 4 files changed, 136 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 90eb07106609..117c754409b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -53,7 +53,7 @@
  *
  */
 
-static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
+void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 
@@ -66,7 +66,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	kvfree(bo);
 }
 
-static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
+void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 	struct amdgpu_bo_user *ubo;
@@ -76,7 +76,7 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
 	amdgpu_bo_destroy(tbo);
 }
 
-static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
+void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 147b79c10cbb..3f6a687309a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -332,6 +332,9 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 			     struct dma_fence **fence);
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 					    uint32_t domain);
+void amdgpu_bo_destroy(struct ttm_buffer_object *tbo);
+void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo);
+void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo);
 
 /*
  * sub allocation
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 27159f1d112e..165f4f1a8141 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -23,9 +23,11 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/interval_tree_generic.h>
 #include <drm/ttm/ttm_range_manager.h>
 
 #include "amdgpu.h"
+#include "amdgpu_object.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_res_cursor.h"
 #include "amdgpu_atomfirmware.h"
@@ -38,6 +40,122 @@ struct amdgpu_vram_reservation {
 	struct list_head blocks;
 };
 
+struct amdgpu_vram_node {
+	struct rb_node node;
+	u64 start;
+	u64 last;
+	u64 __subtree_last;
+	struct ttm_buffer_object *tbo;
+};
+
+#define START(node) ((node)->start)
+#define LAST(node) ((node)->last)
+
+INTERVAL_TREE_DEFINE(struct amdgpu_vram_node, node, u64, __subtree_last,
+		     START, LAST, static, amdgpu_vram_it)
+
+#undef START
+#undef LAST
+
+#define for_each_vram_mm_node(node, mgr) \
+	for (node = amdgpu_vram_it_iter_first(&(mgr)->root, 0, U64_MAX); node; \
+	     node = amdgpu_vram_it_iter_next(node, 0, U64_MAX))
+
+static void amdgpu_vram_mm_add_block(struct drm_buddy_block *block, struct amdgpu_vram_mgr *mgr, struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_vram_node *node;
+
+	node = kvzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return;
+
+	node->start = amdgpu_vram_mgr_block_start(block);
+	node->last = node->start + amdgpu_vram_mgr_block_size(block) - 1;
+	node->tbo = tbo;
+
+	amdgpu_vram_it_insert(node, &mgr->root);
+}
+
+static void amdgpu_vram_mm_remove_block(struct drm_buddy_block *block, struct amdgpu_vram_mgr *mgr)
+{
+	struct amdgpu_vram_node *node;
+	u64 start, last;
+
+	start = amdgpu_vram_mgr_block_start(block);
+	last = start + amdgpu_vram_mgr_block_size(block) - 1;
+
+	node = amdgpu_vram_it_iter_first(&mgr->root, start, last);
+	if (node) {
+		amdgpu_vram_it_remove(node, &mgr->root);
+		kvfree(node);
+	}
+}
+
+static inline const char* ttm_bo_type2str(enum ttm_bo_type type)
+{
+	switch (type) {
+	case ttm_bo_type_kernel:
+		return "kernel";
+	case ttm_bo_type_device:
+		return "device";
+	case ttm_bo_type_sg:
+		return "sg";
+	default:
+		return "unknow";
+	}
+}
+
+static inline const char* amdgpu_vram_domain_str(u32 domain, char *tmp)
+{
+	int index = 0;
+
+	tmp[index++] = domain & AMDGPU_GEM_DOMAIN_CPU ? 'C' : '-';
+	tmp[index++] = domain & AMDGPU_GEM_DOMAIN_GTT ? 'G' : '-';
+	tmp[index++] = domain & AMDGPU_GEM_DOMAIN_VRAM ? 'V' : '-';
+	tmp[index++] = domain & (AMDGPU_GEM_DOMAIN_GDS | AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA) ?
+		'P' : '-';
+	tmp[index++] = '\0';
+
+	return tmp;
+}
+
+static inline const char* amdgpu_vram_bo_usage(struct ttm_buffer_object *tbo)
+{
+	if (tbo->destroy == &amdgpu_bo_destroy)
+		return "normal";
+	else if (tbo->destroy == &amdgpu_bo_user_destroy)
+		return "user";
+	else if (tbo->destroy == &amdgpu_bo_vm_destroy)
+		return "vm";
+	else
+		return "unknow";
+}
+
+static void amdgpu_vram_mm_debug(struct amdgpu_vram_mgr *mgr, struct drm_printer *p)
+{
+	struct amdgpu_vram_node *node;
+	struct ttm_buffer_object *tbo;
+	struct amdgpu_bo *abo;
+	char tmp[5];
+
+	for_each_vram_mm_node(node, mgr) {
+		tbo = node->tbo;
+		abo = ttm_to_amdgpu_bo(tbo);
+		drm_printf(p, "%#018llx-%#018llx:", node->start, node->last);
+		if (abo)
+			drm_printf(p, " (type:%-5s usage:%-8s domain:%s %s) @%p",
+				   ttm_bo_type2str(tbo->type),
+				   amdgpu_vram_bo_usage(tbo),
+				   amdgpu_vram_domain_str(abo->preferred_domains, tmp),
+				   amdgpu_vram_domain_str(abo->allowed_domains, tmp),
+				   abo);
+		else
+			drm_printf(p, " (reserved)");
+		drm_printf(p, " %llu bytes\n",
+			   node->last - node->start + 1);
+	}
+}
+
 static inline struct amdgpu_vram_mgr *
 to_vram_mgr(struct ttm_resource_manager *man)
 {
@@ -288,6 +406,7 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
 			rsv->start, rsv->size);
 
+		amdgpu_vram_mm_add_block(block, mgr, NULL);
 		vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
 		atomic64_add(vis_usage, &mgr->vis_usage);
 		spin_lock(&man->bdev->lru_lock);
@@ -540,6 +659,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 		vres->base.start = max(vres->base.start, start);
 
 		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
+
+		amdgpu_vram_mm_add_block(block, mgr, tbo);
 	}
 
 	if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
@@ -583,8 +704,10 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
 	uint64_t vis_usage = 0;
 
 	mutex_lock(&mgr->lock);
-	list_for_each_entry(block, &vres->blocks, link)
+	list_for_each_entry(block, &vres->blocks, link) {
 		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
+		amdgpu_vram_mm_remove_block(block, mgr);
+	}
 
 	amdgpu_vram_mgr_do_reserve(man);
 
@@ -747,6 +870,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	drm_printf(printer, "reserved:\n");
 	list_for_each_entry(block, &mgr->reserved_pages, link)
 		drm_buddy_block_print(mm, block, printer);
+	drm_printf(printer, "vram usage:\n");
+	amdgpu_vram_mm_debug(mgr, printer);
+
 	mutex_unlock(&mgr->lock);
 }
 
@@ -769,6 +895,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	struct ttm_resource_manager *man = &mgr->manager;
 	int err;
 
+	mgr->root = RB_ROOT_CACHED;
+
 	ttm_resource_manager_init(man, &adev->mman.bdev,
 				  adev->gmc.real_vram_size);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index 0e04e42cf809..a14c56e1e407 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -28,6 +28,7 @@
 
 struct amdgpu_vram_mgr {
 	struct ttm_resource_manager manager;
+	struct rb_root_cached root;
 	struct drm_buddy mm;
 	/* protects access to buffer objects */
 	struct mutex lock;
-- 
2.25.1

