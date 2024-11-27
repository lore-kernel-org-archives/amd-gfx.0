Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763A8D609A1
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2024 06:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C4F10E34C;
	Wed, 27 Nov 2024 06:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wQK3FrZb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F8410E34C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2024 06:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVxYFivq/qEu7teQNFS37qyv2vKRR771mzRhcqMHlRgmqCwI070bO1R/kf1Q20/PAebaTzuw3HhzJevfIB/rJrFfYUB7HJJiVRtwCoJfMOmuWigBrz8Yn7cSsjS9QGre3x6Vmv7pMEesXo6GidPBmEnwUF4QCNSqiD0jyPBA0hcuknshEKYvJiNwfJYls3tu8L9MBDVdoiKHjJylJMmRGvCITnJywpctuoaVr6wVXTMsLUECia6lEbwNiiKW58aaXxarlBLKTv+JhEXzKdYb94idEcdzRtxaMRK6RtwFdiAuLFK2AL6H3gTfjdvdkOK293LHnopxVwKwm6f6ABgRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rtdd7Om34UyayNgdbB9Bmdmq41Ji3iBxQmmHkxteAkM=;
 b=E+MvpCglYQZNW+h6iXRSam1zweO+d0X+VdgnXHSUmrV26buBC/zKjEd8iRdd9bR9N4vsVTTDiZBWywcOoBQSelkwI/hdE7NAZmcoiq+T/YesC/Q+jeZ/WqszL0Xx80VBkzKfVKzSAXS7AVOpji8hGgVwtmZCznzHErsKCOtsC8UKni3gbPcF21DW4clrDsGWiv4ORvaxqAHQoq2QRLYnAKv76is595FBi+13Il3OJ4NLWdMuwxyxQNOwEtGdoCQExVXIfcfCnOsW+hNiLvQThtZm1MaDMkUw5Y6i31jR/0rEHvktKmiMkBk7J6p1YaA1X7i4OVA7oQhMCCNXn8nmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rtdd7Om34UyayNgdbB9Bmdmq41Ji3iBxQmmHkxteAkM=;
 b=wQK3FrZbAjBicdj1hoiJidD73lduONRjtTTkby3BU6Zz0Fq2KOnga77kQ5y1KPJ1B1UhJGo7s1IrlICulBL8bzTjLrUOuF5bOKMkbJq6Tsf89tPxKMPOVZNuUqVqTEGKsA/o5QhRlomzQan6lpRKQqq24JscdvNXJcrZ8SVraeQ=
Received: from MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 06:14:15 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::9b) by MN2PR22CA0024.outlook.office365.com
 (2603:10b6:208:238::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Wed,
 27 Nov 2024 06:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 06:14:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 00:14:13 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <sukhatri@amd.com>
Subject: [PATCH] drm/amdgpu: Remove gfxoff usage
Date: Wed, 27 Nov 2024 11:43:53 +0530
Message-ID: <20241127061353.3461098-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: bfea12d8-800e-4519-4a62-08dd0eaab7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m6GHzaqm2uduGZHPOHtc3S0+fjMQzoA1a4YINqjHEEEZJZ4zd/H0wzv6BqX+?=
 =?us-ascii?Q?J+mMDy/K9UUqsA0UfL6owgpyxYRFTiB+8Bvh89olXALeWKcLMYx66TWLKas1?=
 =?us-ascii?Q?KU01GTY70e/cn1hIKv58ocfbnsNoPySbpZ1yQDxQfkqBxbAJ9u8MlKaIg9aS?=
 =?us-ascii?Q?ma70JwS4uEl8DpHvdNdyaPFwO9zjJ8BNTpcvxRGh9MYgtXbjN4t6wNvh2P+4?=
 =?us-ascii?Q?BxVl2QIkgAVwXpgUt2MjHEwoDJUbBE53KApAOGKdw26KXFZyvRTFJCiNlRS5?=
 =?us-ascii?Q?dNTWBrK8++/+KxIhb5zshnPN/LzhWp7xw79dcW0JIPt4pxXRawQGqBwxDOLw?=
 =?us-ascii?Q?oEYtvtGiecSyDotE0ro1Zj+LFvgQZOFCYaECQ1FJaG1+Y5GWfiQeWvpvZydH?=
 =?us-ascii?Q?SQJKG0/NGS30OKWVhIG/VrnV2+RlofIO0sLhrnBFB8gJ0X27cUNhUdVEX40E?=
 =?us-ascii?Q?/2QgLKJYaDZVuKH30saYfg1JdE4g/v28x7E7Ap7Cg3tLfhyXZdx3LuQDUFo6?=
 =?us-ascii?Q?D3zrthM8sUPWDxbL09RvDOIKdenPq93UEPCfg59t5cGAjoQiThydaw8Pb/uz?=
 =?us-ascii?Q?MbHHH68Wc8gk6op31hMykOYQHFERW71g9onhyW/M9G2Te9svA6ZQItX5m7J2?=
 =?us-ascii?Q?mcJ0ZCWel1A1gMUkZ4Sm6fFsHTpIHQZ2gRVdJstBi0zuQTNG0l3M9tKbHzg6?=
 =?us-ascii?Q?U72lI+Mq0+ADydIuFWRmeZc1B9rs4sQzBDfRQ5WZjaDhS63odOgZ6Ov60Aol?=
 =?us-ascii?Q?wtqn17Lb8YG5ybII1ehiyiIPou+Yz+69IkrKGKjcDvGArJ8CXnJq1/hMSzoB?=
 =?us-ascii?Q?phSaFlrsIYqO/4T9yDkgt6Gcm2ygCl0tSSrxMTE2AmphkpHmdqst5/yUTk02?=
 =?us-ascii?Q?ktHQ/Fnl8XL9Ices0O/Gj16sepf7j0+2mypzAcWovHuKLnBV7nzC828R0Lht?=
 =?us-ascii?Q?fgzE+B8RV2HRpUtHFn4xmeZYEfKH/ZwMbkKVYCq/c8moNfY26PkJB1AtShGT?=
 =?us-ascii?Q?ShQqNJJWITsZYu7bapGShtChMHaKMXU3DyXn4KKnvHrK23uEcgbSRfqZhtte?=
 =?us-ascii?Q?6RZtWSrCFJOuALUophN8+5IL5PJpBmMVI7TLI6pohEmlYC8ND2eCjvULGlJt?=
 =?us-ascii?Q?t6h5zMK+u1FsnHyhcq7rzS+bSsUM+VCxvEq2OU2XuE3BhwjiKmQTKv6Czhty?=
 =?us-ascii?Q?NvTHPO6K33bs3Au7+1DOPl3rsenV/L/vBt+T9RaXdQ3ZPcUkOyjcQoPQcdb9?=
 =?us-ascii?Q?WdhLkLDHQIXW9mxZKiVmBnZJhEuoKkXjPa6OBwaHueX7UWAUMjgaN+TiIkvA?=
 =?us-ascii?Q?urseh/7Ht39oVwCcP4jB0J3jTWPM84uZxugDZ5ItaSCKt3xWuXh0NuLOCLg5?=
 =?us-ascii?Q?2sltb4KoQuobLmIUB8+I/qW1QbsSntbYztoCT0VyOimDudokMuPj1Sn6gpK9?=
 =?us-ascii?Q?Ic1fVJeLDtYS2FLz8+biA+/ZXETT8B9T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 06:14:14.9388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfea12d8-800e-4519-4a62-08dd0eaab7f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

GFXOFF is not valid for these IP versions. Also, SDMA v4.4.2 is not in
GFX domain.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f23df55d72fd..decb709707e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4651,7 +4651,6 @@ static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block *ip_block)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	amdgpu_gfx_off_ctrl(adev, false);
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
 		xcc_offset = xcc_id * reg_count;
 		for (i = 0; i < reg_count; i++)
@@ -4659,7 +4658,6 @@ static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block *ip_block)
 				RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_9_4_3[i],
 								   GET_INST(GC, xcc_id)));
 	}
-	amdgpu_gfx_off_ctrl(adev, true);
 
 	/* dump compute queue registers for all instances */
 	if (!adev->gfx.ip_dump_compute_queues)
@@ -4668,7 +4666,6 @@ static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block *ip_block)
 	num_inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
 		adev->gfx.mec.num_queue_per_pipe;
 	reg_count = ARRAY_SIZE(gc_cp_reg_list_9_4_3);
-	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->srbm_mutex);
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
 		xcc_offset = xcc_id * reg_count * num_inst;
@@ -4695,7 +4692,6 @@ static void gfx_v9_4_3_ip_dump(struct amdgpu_ip_block *ip_block)
 	}
 	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static void gfx_v9_4_3_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index e70460693ef2..f206e98f2069 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1948,7 +1948,6 @@ static void sdma_v4_4_2_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->sdma.ip_dump)
 		return;
 
-	amdgpu_gfx_off_ctrl(adev, false);
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		instance_offset = i * reg_count;
 		for (j = 0; j < reg_count; j++)
@@ -1956,7 +1955,6 @@ static void sdma_v4_4_2_dump_ip_state(struct amdgpu_ip_block *ip_block)
 				RREG32(sdma_v4_4_2_get_reg_offset(adev, i,
 				       sdma_reg_list_4_4_2[j].reg_offset));
 	}
-	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 const struct amd_ip_funcs sdma_v4_4_2_ip_funcs = {
-- 
2.25.1

