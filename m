Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DC0C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 16:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B8D10E18C;
	Tue, 21 May 2024 16:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Iyi6Sp8A";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6946A10E1F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 16:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg5rrSMmpbh2t8hzmwa+vrLZOMwdm9jGS/gyVPdCO14AiZGG4PHV7ZFqgayMVEb7G8qP3X22vpHyA/07krR6B5IYK5BpuSMzhC2NH6K/TF7yqzAvfXX5nbfdqpsa1nQphonuEt1IJ41bXcGmc1jvTirBQ9OwDrWvDxqA4QcLYXos7lxwmrAOCtG5CnLIQEmOBHMFFPiNdFBUAOF27lv4i030xbHHHnA3KoA4EsiyUNhckSR9DsCtzYA/fzIRhrTqQGMrBcRfGSzVG39iXESWtkM890ffNmN60ZzP9E4ufLn+xt6q/nWVG2HsbhlO3avi1LNn4Y3/1COY+J2irCBniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bpa/GmRMJLngwpSbI9i2h902xlF27eCp6V+uVYlddI=;
 b=foKo4NgKVAKA4mvxy62nZv0hOpx0X8/GPjyPUDnyBHyyiTffS2cu2TGsG+5Si+Fl5PhAM+AdVrw/FHd8LRjQBCmdk/z7PSy/KgEQE+VC6nLLpZLFkj9gO+7D9SWNdHtY8Eyc07WlZbNmXClNtc/vz/x43fzCRelMXS2nwtQr2H3P24pmBvvU/tmYHPpquxS0UkN2MgUpvgF+b0lhNROleaB4kdf62OtdyLg3JG+pb6KMPGJb+IiZjLDFe4i8D48i9gcax8aZKkp/XqTzWNaWGQkuduP49aTN+/1vOgXQNQ8ioSwCLU+2WGSzWiVLbD2rU/24n/qZ5YtR/6rNytXHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bpa/GmRMJLngwpSbI9i2h902xlF27eCp6V+uVYlddI=;
 b=Iyi6Sp8ATHBZRmPai00CuAejpjSM6zT9xWCYth5HsF8lRtdAHkz6ynUBLzR70R9+Qdwo+GGIzxhfCxK55nnJaZrcOoBWGDH5w7oGRG2e7PcyBRfMzuZGLGXIXC3VOSBYSmtAUp8iZDWIsz+Cq/ZGs3cA/k2Cih8yYFoSy/oXamI=
Received: from BYAPR06CA0033.namprd06.prod.outlook.com (2603:10b6:a03:d4::46)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Tue, 21 May 2024 16:49:03 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::b8) by BYAPR06CA0033.outlook.office365.com
 (2603:10b6:a03:d4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Tue, 21 May 2024 16:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 16:49:03 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 11:48:59 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v1 2/3] drm/amd/amdgpu: Add ISP4.1.0 and ISP4.1.1 modules
Date: Tue, 21 May 2024 12:48:40 -0400
Message-ID: <20240521164841.36101-3-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521164841.36101-1-pratap.nirujogi@amd.com>
References: <20240521164841.36101-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: cf39bf86-9a18-4f87-e67a-08dc79b5ec16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ReJ/gYyee67dhK3E6OD4QDdkz/lc43Ha2CwDhB/zVCHlMb6/RX41gK3fpUNP?=
 =?us-ascii?Q?ONCft6+UTMVvB4xHaNcZ8LyfHbXCbUAPVbFw6JGCj3uX8SQtUgJ/nWow/FBE?=
 =?us-ascii?Q?RTkFp9te8o3ms1SDcBf/xm9LNwDEI+Vxrg9u2IZj1x7A6t5NygTzsI6kIc4Y?=
 =?us-ascii?Q?dwLJ4qvlEWdqyhcpeUZ3BtLf9qSp/biCxLdE/3w6ZfoAHSWAu+pQKJ5pmqiH?=
 =?us-ascii?Q?wQ3St0sryjPEl+VPnrXFVqzhJ+4Fa3gWF4uyOZdQJwAbe15lZP0tX+acUn7G?=
 =?us-ascii?Q?ssC6TocU6Z4DLDWKTbXql2vlfQcQGPzZLtnMbr/L06uU0xtFJn9CeBdBVZaQ?=
 =?us-ascii?Q?P3FnlLS0YM0m47q5sPvOHNOA58pB0pLIDvHWVqyLvLBmZxR1czMju40afPXc?=
 =?us-ascii?Q?Z0DooI7SwTGB5Tgt9jsC4b4QzbBKDeUI4RY0xezMYxWhlBQjbi5pzqsWZ5Vn?=
 =?us-ascii?Q?cjy/jCA2n5CfGAOZ1Ct97wsaU02KrQK/EmX08cVDjIbeDHrGBADvt8Zo0S7p?=
 =?us-ascii?Q?F/YsfnyJXuJLV4c2dtl1JdalLDOXEARK8qEdh+tf/taXZL2HmGyTKxF//nqy?=
 =?us-ascii?Q?yO0cQojOPbbukvn4GJLTOKCvyStohoYSB48MHlfmlpcGfiHSzsD1cUD5Azo3?=
 =?us-ascii?Q?/ei0DjZ1AWdw3xOEKyD8oYL/VABYGDf7SHYqYnrMF0rShw4z8NTurwtNodHG?=
 =?us-ascii?Q?I98xtC5GEp/pRjJurGtSHsf4Nnw60dOqtFSYt+uDfSXGXC8rR0jG4ipyUGZK?=
 =?us-ascii?Q?6Zm3XEPKOPgSUdWUPC+3O2gWoaGRdFmgH9u8aMYaCCd3nFe8rYGlthgsYHak?=
 =?us-ascii?Q?c+OD9c9JZOL+WwmEJJntP2AkBw1TkWNhouL9WOHtY729dbIOTofhGKScy6+B?=
 =?us-ascii?Q?pWwMaX3uUHtDDBnOzOvP0NBsQ5eADEE56HM9KQSW+8mZ/w/AzrJ8qr6GPnwy?=
 =?us-ascii?Q?ZhYn5GwKegpX1oL+EpvY4gXxp6jLICZn8dv27ekV60V+lbV+xuxf+hMwn8oV?=
 =?us-ascii?Q?V75yy46B6KaUJU1uvtFmRlP0bua0Ie6RIr28tx+4mpTgMaCnQsKH6F0nFq1E?=
 =?us-ascii?Q?UVrCBPgyUL4lwNQjrF+rqmWLKXCNeCntzLobul+PE16mm9aL/i8o2y7QsAhf?=
 =?us-ascii?Q?Ti+RBjZq78Ug+pkURlYYJ0Gq0yn4NA7CdY4Inyp7gvx0IdK1u8/Pa5Kzo3Hp?=
 =?us-ascii?Q?44lncQjui2ekNGHDOeRtEzRF00Mu5GTNrxoIidc93RFA7g8IDd6s+4oIg/3+?=
 =?us-ascii?Q?qP1WaFa2GMKxoTjK+CwmZy8/xYsyTtPHf0VRh7r5JIEU4T1xMNKQJldOqfP7?=
 =?us-ascii?Q?q12xDpbMqN6Pfuoou/9CkpVqkqeThP6+l/50Kmej4LRUZBBCF+AzYv72XVGu?=
 =?us-ascii?Q?xIw01AgPA6A5oKqbQgGTCYwpt2f2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:49:03.5483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf39bf86-9a18-4f87-e67a-08dc79b5ec16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add independent IP centric modules for ISP4.1.0 and ISP4.1.1 hw blocks.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       | 167 ++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h       |  13 +-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c       | 149 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h       |  46 +++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c       | 137 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h       |  39 ++++
 8 files changed, 427 insertions(+), 133 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c95ec19a3826..6e3d7f51616f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -326,7 +326,10 @@ endif
 
 # add isp block
 ifneq ($(CONFIG_DRM_AMD_ISP),)
-amdgpu-y += amdgpu_isp.o
+amdgpu-y += \
+	amdgpu_isp.o \
+	isp_v4_1_0.o \
+	isp_v4_1_1.o
 endif
 
 obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0535596fa831..92172b9ceb1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2409,8 +2409,10 @@ static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_ISP)
 	switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
 	case IP_VERSION(4, 1, 0):
+		amdgpu_device_ip_block_add(adev, &isp_v4_1_0_ip_block);
+		break;
 	case IP_VERSION(4, 1, 1):
-		amdgpu_device_ip_block_add(adev, &isp_ip_block);
+		amdgpu_device_ip_block_add(adev, &isp_v4_1_1_ip_block);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 52e53d2b8748..240408486d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -30,47 +30,16 @@
 
 #include "amdgpu.h"
 #include "amdgpu_isp.h"
-
-#include "ivsrcid/isp/irqsrcs_isp_4_1.h"
-
-#define mmDAGB0_WRCLI5_V4_1	0x6811C
-#define mmDAGB0_WRCLI9_V4_1	0x6812C
-#define mmDAGB0_WRCLI10_V4_1	0x68130
-#define mmDAGB0_WRCLI14_V4_1	0x68140
-#define mmDAGB0_WRCLI19_V4_1	0x68154
-#define mmDAGB0_WRCLI20_V4_1	0x68158
-
-static const unsigned int isp_int_srcid[MAX_ISP_INT_SRC] = {
-	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT9,
-	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT10,
-	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT11,
-	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT12,
-	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT13,
-	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT14,
-	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT15,
-	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
-};
+#include "isp_v4_1_0.h"
+#include "isp_v4_1_1.h"
 
 static int isp_sw_init(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	adev->isp.parent = adev->dev;
-
-	adev->isp.cgs_device = amdgpu_cgs_create_device(adev);
-	if (!adev->isp.cgs_device)
-		return -EINVAL;
-
 	return 0;
 }
 
 static int isp_sw_fini(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	if (adev->isp.cgs_device)
-		amdgpu_cgs_destroy_device(adev->isp.cgs_device);
-
 	return 0;
 }
 
@@ -83,93 +52,18 @@ static int isp_sw_fini(void *handle)
 static int isp_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_isp *isp = &adev->isp;
+
 	const struct amdgpu_ip_block *ip_block =
 		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP);
-	u64 isp_base;
-	int int_idx;
-	int r;
 
 	if (!ip_block)
 		return -EINVAL;
 
-	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
-		return -EINVAL;
-
-	isp_base = adev->rmmio_base;
-
-	adev->isp.isp_cell = kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL);
-	if (!adev->isp.isp_cell) {
-		r = -ENOMEM;
-		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
-		goto failure;
-	}
-
-	adev->isp.isp_res = kcalloc(9, sizeof(struct resource), GFP_KERNEL);
-	if (!adev->isp.isp_res) {
-		r = -ENOMEM;
-		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
-		goto failure;
-	}
-
-	adev->isp.isp_pdata = kzalloc(sizeof(*adev->isp.isp_pdata), GFP_KERNEL);
-	if (!adev->isp.isp_pdata) {
-		r = -ENOMEM;
-		DRM_ERROR("%s: isp platform data alloc failed\n", __func__);
-		goto failure;
-	}
-
-	/* initialize isp platform data */
-	adev->isp.isp_pdata->adev = (void *)adev;
-	adev->isp.isp_pdata->asic_type = adev->asic_type;
-	adev->isp.isp_pdata->base_rmmio_size = adev->rmmio_size;
-
-	adev->isp.isp_res[0].name = "isp_reg";
-	adev->isp.isp_res[0].flags = IORESOURCE_MEM;
-	adev->isp.isp_res[0].start = isp_base;
-	adev->isp.isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
-
-	for (int_idx = 0; int_idx < MAX_ISP_INT_SRC; int_idx++) {
-		adev->isp.isp_res[int_idx + 1].name = "isp_irq";
-		adev->isp.isp_res[int_idx + 1].flags = IORESOURCE_IRQ;
-		adev->isp.isp_res[int_idx + 1].start =
-			amdgpu_irq_create_mapping(adev, isp_int_srcid[int_idx]);
-		adev->isp.isp_res[int_idx + 1].end =
-			adev->isp.isp_res[int_idx + 1].start;
-	}
-
-	adev->isp.isp_cell[0].name = "amd_isp_capture";
-	adev->isp.isp_cell[0].num_resources = 9;
-	adev->isp.isp_cell[0].resources = &adev->isp.isp_res[0];
-	adev->isp.isp_cell[0].platform_data = adev->isp.isp_pdata;
-	adev->isp.isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
+	if (isp->funcs->hw_init != NULL)
+		return isp->funcs->hw_init(isp);
 
-	r = mfd_add_hotplug_devices(adev->isp.parent, adev->isp.isp_cell, 1);
-	if (r) {
-		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
-		goto failure;
-	}
-
-	/*
-	 * Temporary WA added to disable MMHUB TLSi until the GART initialization
-	 * is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
-	 * using the TLSi path
-	 */
-	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI5_V4_1 >> 2, 0xFE5FEAA8);
-	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI9_V4_1 >> 2, 0xFE5FEAA8);
-	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI10_V4_1 >> 2, 0xFE5FEAA8);
-	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI14_V4_1 >> 2, 0xFE5FEAA8);
-	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI19_V4_1 >> 2, 0xFE5FEAA8);
-	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI20_V4_1 >> 2, 0xFE5FEAA8);
-
-	return 0;
-
-failure:
-
-	kfree(adev->isp.isp_pdata);
-	kfree(adev->isp.isp_res);
-	kfree(adev->isp.isp_cell);
-
-	return r;
+	return -ENODEV;
 }
 
 /**
@@ -181,15 +75,12 @@ static int isp_hw_init(void *handle)
 static int isp_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_isp *isp = &adev->isp;
 
-	/* remove isp mfd device */
-	mfd_remove_devices(adev->isp.parent);
+	if (isp->funcs->hw_fini != NULL)
+		return isp->funcs->hw_fini(isp);
 
-	kfree(adev->isp.isp_res);
-	kfree(adev->isp.isp_cell);
-	kfree(adev->isp.isp_pdata);
-
-	return 0;
+	return -ENODEV;
 }
 
 static int isp_suspend(void *handle)
@@ -235,17 +126,29 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
 
 static int isp_early_init(void *handle)
 {
-	int ret = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_isp *isp = &adev->isp;
+
+	switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
+	case IP_VERSION(4, 1, 0):
+		isp_v4_1_0_set_isp_funcs(isp);
+		break;
+	case IP_VERSION(4, 1, 1):
+		isp_v4_1_1_set_isp_funcs(isp);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	isp->adev = adev;
+	isp->parent = adev->dev;
 
-	ret = isp_load_fw_by_psp(adev);
-	if (ret) {
-		DRM_WARN("%s: isp fw load failed %d\n", __func__, ret);
-		/* allow amdgpu init to proceed though isp fw load fails */
-		ret = 0;
+	if (isp_load_fw_by_psp(adev)) {
+		DRM_WARN("%s: isp fw load failed\n", __func__);
+		return 0;
 	}
 
-	return ret;
+	return 0;
 }
 
 static bool isp_is_idle(void *handle)
@@ -292,10 +195,18 @@ static const struct amd_ip_funcs isp_ip_funcs = {
 	.set_powergating_state = isp_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version isp_ip_block = {
+const struct amdgpu_ip_block_version isp_v4_1_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_ISP,
 	.major = 4,
 	.minor = 1,
 	.rev = 0,
 	.funcs = &isp_ip_funcs,
 };
+
+const struct amdgpu_ip_block_version isp_v4_1_1_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_ISP,
+	.major = 4,
+	.minor = 1,
+	.rev = 1,
+	.funcs = &isp_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index 764d70beb9e9..44e2ea8c9728 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -30,7 +30,7 @@
 
 #define ISP_REGS_OFFSET_END 0x629A4
 
-#define MAX_ISP_INT_SRC 8
+struct amdgpu_isp;
 
 struct isp_platform_data {
 	void *adev;
@@ -38,9 +38,15 @@ struct isp_platform_data {
 	resource_size_t base_rmmio_size;
 };
 
+struct isp_funcs {
+	int (*hw_init)(struct amdgpu_isp *isp);
+	int (*hw_fini)(struct amdgpu_isp *isp);
+};
+
 struct amdgpu_isp {
 	struct device *parent;
-	struct cgs_device *cgs_device;
+	struct amdgpu_device	*adev;
+	const struct isp_funcs	*funcs;
 	struct mfd_cell *isp_cell;
 	struct resource *isp_res;
 	struct isp_platform_data *isp_pdata;
@@ -48,6 +54,7 @@ struct amdgpu_isp {
 	const struct firmware	*fw;
 };
 
-extern const struct amdgpu_ip_block_version isp_ip_block;
+extern const struct amdgpu_ip_block_version isp_v4_1_0_ip_block;
+extern const struct amdgpu_ip_block_version isp_v4_1_1_ip_block;
 
 #endif /* __AMDGPU_ISP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
new file mode 100644
index 000000000000..962da37fb1f7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ */
+
+#include "amdgpu.h"
+#include "isp_v4_1_0.h"
+
+static const unsigned int isp_4_1_0_int_srcid[MAX_ISP410_INT_SRC] = {
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT9,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT10,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT11,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT12,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT13,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT14,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT15,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
+};
+
+static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
+{
+	struct amdgpu_device *adev = isp->adev;
+	u64 isp_base;
+	int int_idx;
+	int r;
+
+	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
+		return -EINVAL;
+
+	isp_base = adev->rmmio_base;
+
+	isp->isp_cell = kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL);
+	if (!isp->isp_cell) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
+		goto failure;
+	}
+
+	isp->isp_res = kcalloc(MAX_ISP410_INT_SRC + 1, sizeof(struct resource),
+			       GFP_KERNEL);
+	if (!isp->isp_res) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
+		goto failure;
+	}
+
+	isp->isp_pdata = kzalloc(sizeof(*isp->isp_pdata), GFP_KERNEL);
+	if (!isp->isp_pdata) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp platform data alloc failed\n", __func__);
+		goto failure;
+	}
+
+	/* initialize isp platform data */
+	isp->isp_pdata->adev = (void *)adev;
+	isp->isp_pdata->asic_type = adev->asic_type;
+	isp->isp_pdata->base_rmmio_size = adev->rmmio_size;
+
+	isp->isp_res[0].name = "isp_4_1_0_reg";
+	isp->isp_res[0].flags = IORESOURCE_MEM;
+	isp->isp_res[0].start = isp_base;
+	isp->isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
+
+	for (int_idx = 0; int_idx < MAX_ISP410_INT_SRC; int_idx++) {
+		isp->isp_res[int_idx + 1].name = "isp_4_1_0_irq";
+		isp->isp_res[int_idx + 1].flags = IORESOURCE_IRQ;
+		isp->isp_res[int_idx + 1].start =
+			amdgpu_irq_create_mapping(adev, isp_4_1_0_int_srcid[int_idx]);
+		isp->isp_res[int_idx + 1].end =
+			isp->isp_res[int_idx + 1].start;
+	}
+
+	isp->isp_cell[0].name = "amd_isp_capture";
+	isp->isp_cell[0].num_resources = MAX_ISP410_INT_SRC + 1;
+	isp->isp_cell[0].resources = &isp->isp_res[0];
+	isp->isp_cell[0].platform_data = isp->isp_pdata;
+	isp->isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
+
+	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 1);
+	if (r) {
+		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
+		goto failure;
+	}
+
+	/*
+	 * Temporary WA added to disable MMHUB TLSi until the GART initialization
+	 * is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
+	 * using the TLSi path
+	 */
+	WREG32(mmDAGB0_WRCLI5_V4_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB0_WRCLI9_V4_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB0_WRCLI10_V4_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB0_WRCLI14_V4_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB0_WRCLI19_V4_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB0_WRCLI20_V4_1 >> 2, 0xFE5FEAA8);
+
+	return 0;
+
+failure:
+
+	kfree(isp->isp_pdata);
+	kfree(isp->isp_res);
+	kfree(isp->isp_cell);
+
+	return r;
+}
+
+static int isp_v4_1_0_hw_fini(struct amdgpu_isp *isp)
+{
+	mfd_remove_devices(isp->parent);
+
+	kfree(isp->isp_res);
+	kfree(isp->isp_cell);
+	kfree(isp->isp_pdata);
+
+	return 0;
+}
+
+static const struct isp_funcs isp_v4_1_0_funcs = {
+	.hw_init = isp_v4_1_0_hw_init,
+	.hw_fini = isp_v4_1_0_hw_fini,
+};
+
+void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp)
+{
+	isp->funcs = &isp_v4_1_0_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
new file mode 100644
index 000000000000..bd9e1f13c748
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ */
+
+#ifndef __ISP_V4_1_0_H__
+#define __ISP_V4_1_0_H__
+
+#include "amdgpu_isp.h"
+
+#include "ivsrcid/isp/irqsrcs_isp_4_1.h"
+
+#define mmDAGB0_WRCLI5_V4_1	0x6811C
+#define mmDAGB0_WRCLI9_V4_1	0x6812C
+#define mmDAGB0_WRCLI10_V4_1	0x68130
+#define mmDAGB0_WRCLI14_V4_1	0x68140
+#define mmDAGB0_WRCLI19_V4_1	0x68154
+#define mmDAGB0_WRCLI20_V4_1	0x68158
+
+#define MAX_ISP410_INT_SRC 8
+
+void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
new file mode 100644
index 000000000000..4e17fa03f7b5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ */
+
+#include "amdgpu.h"
+#include "isp_v4_1_1.h"
+
+static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT9,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT10,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT11,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT12,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT13,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT14,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT15,
+	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
+};
+
+static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
+{
+	struct amdgpu_device *adev = isp->adev;
+	u64 isp_base;
+	int int_idx;
+	int r;
+
+	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
+		return -EINVAL;
+
+	isp_base = adev->rmmio_base;
+
+	isp->isp_cell = kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL);
+	if (!isp->isp_cell) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
+		goto failure;
+	}
+
+	isp->isp_res = kcalloc(MAX_ISP411_INT_SRC + 1, sizeof(struct resource),
+			       GFP_KERNEL);
+	if (!isp->isp_res) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
+		goto failure;
+	}
+
+	isp->isp_pdata = kzalloc(sizeof(*isp->isp_pdata), GFP_KERNEL);
+	if (!isp->isp_pdata) {
+		r = -ENOMEM;
+		DRM_ERROR("%s: isp platform data alloc failed\n", __func__);
+		goto failure;
+	}
+
+	/* initialize isp platform data */
+	isp->isp_pdata->adev = (void *)adev;
+	isp->isp_pdata->asic_type = adev->asic_type;
+	isp->isp_pdata->base_rmmio_size = adev->rmmio_size;
+
+	isp->isp_res[0].name = "isp_4_1_1_reg";
+	isp->isp_res[0].flags = IORESOURCE_MEM;
+	isp->isp_res[0].start = isp_base;
+	isp->isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
+
+	for (int_idx = 0; int_idx < MAX_ISP411_INT_SRC; int_idx++) {
+		isp->isp_res[int_idx + 1].name = "isp_4_1_1_irq";
+		isp->isp_res[int_idx + 1].flags = IORESOURCE_IRQ;
+		isp->isp_res[int_idx + 1].start =
+			amdgpu_irq_create_mapping(adev, isp_4_1_1_int_srcid[int_idx]);
+		isp->isp_res[int_idx + 1].end =
+			isp->isp_res[int_idx + 1].start;
+	}
+
+	isp->isp_cell[0].name = "amd_isp_capture";
+	isp->isp_cell[0].num_resources = MAX_ISP411_INT_SRC + 1;
+	isp->isp_cell[0].resources = &isp->isp_res[0];
+	isp->isp_cell[0].platform_data = isp->isp_pdata;
+	isp->isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
+
+	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 1);
+	if (r) {
+		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
+		goto failure;
+	}
+
+	return 0;
+
+failure:
+
+	kfree(isp->isp_pdata);
+	kfree(isp->isp_res);
+	kfree(isp->isp_cell);
+
+	return r;
+}
+
+static int isp_v4_1_1_hw_fini(struct amdgpu_isp *isp)
+{
+	mfd_remove_devices(isp->parent);
+
+	kfree(isp->isp_res);
+	kfree(isp->isp_cell);
+	kfree(isp->isp_pdata);
+
+	return 0;
+}
+
+static const struct isp_funcs isp_v4_1_1_funcs = {
+	.hw_init = isp_v4_1_1_hw_init,
+	.hw_fini = isp_v4_1_1_hw_fini,
+};
+
+void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
+{
+	isp->funcs = &isp_v4_1_1_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
new file mode 100644
index 000000000000..dfb9522c9d6a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ */
+
+#ifndef __ISP_V4_1_1_H__
+#define __ISP_V4_1_1_H__
+
+#include "amdgpu_isp.h"
+
+#include "ivsrcid/isp/irqsrcs_isp_4_1.h"
+
+#define MAX_ISP411_INT_SRC 8
+
+void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
+
+#endif
-- 
2.34.1

