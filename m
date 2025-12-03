Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD577D12D5E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B6110E79C;
	Wed,  3 Dec 2025 13:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qDDlWc4l";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0F210E79C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skD6RF1GgOl8gNkb9hOF+qClf/wUoeHOkZXt7H3DXeJj+bWk4DWebKHetAnlI2yk0D+PdLx/g1C12kkA1wS5f2KbMeam2PcfOpzd7SA41YWAeUwSlZk0Et+rp4+Ib1VSMr1wtZhQKvkUsIGLYpxhLG/TMLnMGC1sKGOr7l0XHTmXP7ZBHns3rF2hS/mdWiLoY1mZoc7TcVOuegPaRmVDhotUsMEfhAiUvphRTYeutKLzY71pwKrVRfxENMfv1EhMHtoT44W5YniBtdxKvk1KMd8WM6osUIZ6fcB+85sdFrLmQtUpsGmLv63UdHh985LVLLmv+5ScQcUOKnUGyRQgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRdfbo2/jMhqJm4rDdCLmSEO1l83BfVxVTs0hzRa+TQ=;
 b=lyGhIp5AfSJBNVQuZjDjo5neTdkFnGTFw0a3tZnjprCeXt00dPoQwpvRpEMNLRgZ2TqQE3SiQpI7Zd6Lnge2V4KJ1YRuvCYkZ5WeCmnO2LLqFzdELiezy/Sge3FNAS5xrhyraXLbufd8fiCicijCaWlGwuEk8Mn7c19uKGX+5LtETlNU8T+wonkhrel5q7/R9annQv8SmTBKJnnABKXMt4lOZz8bcNpZw+mC6gShwm/i0RkgK122c1QUhGqwQ7i+cwbiItJv7pOYhaBGO3C8f300paHoqtCMTy6bRrUetFtQuuu1LrU8WTmiiA7X0Je0vsvZHBz2c45fPrJWfoHitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRdfbo2/jMhqJm4rDdCLmSEO1l83BfVxVTs0hzRa+TQ=;
 b=qDDlWc4lahAQuj5+JT9i89dJDFExLhRm6gxbzntdjzVcWQqll4489eVIrNcC0MT35gojPCfseKRMgEWWhi0tq/V89dCapz4FxC2UJgO/Fdnf3858s9m4J0iZak8HovPFgzwluXtS8Xjv/ckCgAAnQwZ/qM7MECzLThF9seDmwDs=
Received: from BN9PR03CA0158.namprd03.prod.outlook.com (2603:10b6:408:f4::13)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 13:05:05 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f4:cafe::69) by BN9PR03CA0158.outlook.office365.com
 (2603:10b6:408:f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Wed, 3
 Dec 2025 13:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Wed, 3 Dec 2025 13:05:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:04 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:05:03 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 03/10] drm/amdgpu: Fill cwsr save area details
Date: Wed, 3 Dec 2025 18:24:54 +0530
Message-ID: <20251203130436.745633-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203130436.745633-1-lijo.lazar@amd.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f7b23d-efbd-4cc8-891b-08de326c93d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NBqNjJHfwEzX48wuVicmfDE3uzYSDW0+i3Ve2Cqfb2E6PWSKF/xmP165USip?=
 =?us-ascii?Q?A0OJgtNHDQECuWV6dckCdueM7i0sRpX71f1JjRvxkZ6fwknvlXulM7qI2ve4?=
 =?us-ascii?Q?OFCCpPdwlxf/6LiKxaJ12h4suf8TBfgmsAXxAT2BEIo79TCRfKYSEZhzbze/?=
 =?us-ascii?Q?XfEkKogukXtaUqEj9Bdfm+z4J4kku88TDlWxFK7pk1Oa0/09ZjCHwr4oLdbK?=
 =?us-ascii?Q?0TpmEA2Lb+gLSe3RrfdrSbuXXLEmEpbR7xIoV0qgerhd+aus1q0Qsjn6l8vD?=
 =?us-ascii?Q?tC6jpl/WF3rxxWiT23/egftBBm3GAV9iQibQNw2VSAp+Tp7mpemKVC/yGnkN?=
 =?us-ascii?Q?K6Gy6gDGC/pfas093FCkAJjDLyE7ezQHyg01AKkVDXAVsAinfT2Wkhvlhv8A?=
 =?us-ascii?Q?EegToEtYFYSJoRPOmIYp83UWjOkP/AhI3wCe4/1246pa/FScLqa/E/X3LewR?=
 =?us-ascii?Q?8STfzVR7d7gOehvGCadzGJwy0Wf9/G6JE3u9A+Q8CRvStJPTRNyk+oOJ6Wrz?=
 =?us-ascii?Q?WJwa1AnMLrYUlufsWqhpAdksgfp9dr/jEI3M3CapE3xNAaQcqazVLXhaGEg/?=
 =?us-ascii?Q?4V4kAqqv3EOK0glO+h5v3U9k21hG41ITPREYd/Vh9TzSkPplnQE2CERX5X1X?=
 =?us-ascii?Q?YmuHmZqmWgKWnXCUsqWqR9dEyz1Rw3/ppP7s5du1v0bfMlwhvjzz59H/NqbQ?=
 =?us-ascii?Q?jUJymzrgUASHQfLhkmLsyQc8b1XiUBhAAoTjcVRDD6vx2mdTAEZLNxPNMl24?=
 =?us-ascii?Q?cxkCC6Vf3jMxWf1Lm2UB5ViiDaBzRqIjvCNpVtWsCGouuMnWrbP4Hvb1sD33?=
 =?us-ascii?Q?svlMBrwNSQEMXZ7ZxvsCx8v2jpt68dlCjR/XnQyKyXC2mMqedsiNOU+GYowF?=
 =?us-ascii?Q?0zaeBadWnM12Om7hdn4/bVJrwsYNMTVlEiHWUB0ftGQqfAXVO/2Iqshk3QPP?=
 =?us-ascii?Q?+jqwO7iSTu8Ph4ztRRt1QDfcntay0UTp0IJ4tUqYJe3NagRAEoGu6X+POhp1?=
 =?us-ascii?Q?h9nLZbdqhISALmPLIkUg3GsTZBht5vEeBrBHmRAg5iFMotBSu4OS2FYZvr3q?=
 =?us-ascii?Q?Kx+KYthIpuQdNfboyQGWuTv4FadAHj6Y5ZizHIZwIjTRyFHYnJUZB7zF7VqV?=
 =?us-ascii?Q?gcMdoX1/2xJLqKXJsjxfRvTnPDoT1iMXIEijuZLRNsMMP7MGMyMhUO9kfAho?=
 =?us-ascii?Q?l2LJQus1dUSygFsF6EQ3SZN+XbS0KL8RmQUDO7CeZ32wDlYK5Sh/WRr3WGtt?=
 =?us-ascii?Q?wAlWxMW5i6x4ffu6Cdwp0ent2M8WeEPj69R3LXUM1OSAj+R8OjoK+MQuvBaq?=
 =?us-ascii?Q?r4edgysXshV7JfUFQjhPSD6CfDIyEUBC6z8cCsXWZOL9d9evtzpQEd5vZjc+?=
 =?us-ascii?Q?gSufMIkq9QV2kjQvOSNTx6BoL+jOWxi1eLObO5XwK3kHlTbHlBwDI9FUsasg?=
 =?us-ascii?Q?myCPE7uwMyiYN8VGvk5MTApcZ257O3RRiC2t2b1FiSYdoJTMi9m1BXN9YxS7?=
 =?us-ascii?Q?w2PEMxIJKxoeR/6wL8/9F3yGrQ0xKsVVxISprCGrkwfXIibrFN9OUY7ppxgy?=
 =?us-ascii?Q?TfvReznulty8x6551ns=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:05.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f7b23d-efbd-4cc8-891b-08de326c93d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
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

Calculate control stack and total save area size required.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 103 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |   4 +
 2 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index c0fc5a383071..4252c31eac4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -32,6 +32,13 @@ extern int cwsr_enable;
 #define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
 #define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
 
+#define SGPR_SIZE_PER_CU 0x4000
+#define LDS_SIZE_PER_CU 0x10000
+#define HWREG_SIZE_PER_CU 0x1000
+#define DEBUGGER_BYTES_ALIGN 64
+#define DEBUGGER_BYTES_PER_WAVE 32
+#define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
+
 enum amdgpu_cwsr_region {
 	AMDGPU_CWSR_TBA,
 	AMDGPU_CWSR_TMA,
@@ -115,6 +122,100 @@ static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
 	}
 }
 
+static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+	uint32_t vgpr_size;
+
+	switch (gc_ver) {
+	case IP_VERSION(9, 4, 1): /* GFX_VERSION_ARCTURUS */
+	case IP_VERSION(9, 4, 2): /* GFX_VERSION_ALDEBARAN */
+	case IP_VERSION(9, 4, 3): /* GFX_VERSION_AQUA_VANJARAM */
+	case IP_VERSION(9, 4, 4): /* GFX_VERSION_AQUA_VANJARAM */
+	case IP_VERSION(9, 5, 0):
+		vgpr_size = 0x80000;
+		break;
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		vgpr_size = 0x60000;
+		break;
+	default:
+		vgpr_size = 0x40000;
+		break;
+	}
+
+	return vgpr_size;
+}
+
+static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
+{
+	uint32_t lds_sz_per_cu;
+
+	lds_sz_per_cu =
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) ?
+			(adev->gfx.cu_info.lds_size << 10) :
+			LDS_SIZE_PER_CU;
+
+	return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
+	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
+}
+
+static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
+{
+	uint32_t sz;
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 1, 0))
+		sz = 12;
+	else
+		sz = 8;
+	return sz;
+}
+
+static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
+					    struct amdgpu_cwsr_info *cwsr_info)
+{
+	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+	uint32_t ctl_stack_size, wg_data_size, dbg_mem_size;
+	uint32_t array_count;
+	uint32_t wave_num;
+	uint32_t cu_num;
+
+	if (gc_ver < IP_VERSION(9, 0, 1))
+		return;
+
+	array_count = gfx_info->max_shader_engines * gfx_info->max_sh_per_se;
+
+	cu_num = adev->gfx.cu_info.number / NUM_XCC(adev->gfx.xcc_mask);
+	wave_num = (gc_ver < IP_VERSION(10, 1, 0)) ? /* GFX_VERSION_NAVI10 */
+			   min(cu_num * 40,
+			       array_count / gfx_info->max_sh_per_se * 512) :
+			   cu_num * 32;
+
+	wg_data_size = ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_cu(adev),
+			     PAGE_SIZE);
+	ctl_stack_size =
+		wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
+	ctl_stack_size =
+		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
+		      PAGE_SIZE);
+	dbg_mem_size =
+		ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
+	/*
+	* HW design limits control stack size to 0x7000.
+	* This is insufficient for theoretical PM4 cases
+	* but sufficient for AQL, limited by SPI events.
+	*/
+	if (IP_VERSION_MAJ(gc_ver) == 10)
+		ctl_stack_size = min(ctl_stack_size, 0x7000);
+
+	cwsr_info->xcc_ctl_stack_sz = ctl_stack_size;
+	cwsr_info->xcc_cwsr_sz = ctl_stack_size + wg_data_size;
+	cwsr_info->xcc_dbg_mem_sz = dbg_mem_size;
+}
+
 int amdgpu_cwsr_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_cwsr_info *cwsr_info __free(kfree) = NULL;
@@ -139,6 +240,8 @@ int amdgpu_cwsr_init(struct amdgpu_device *adev)
 		return r;
 
 	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
+
+	amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
 	adev->cwsr_info = no_free_ptr(cwsr_info);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 26ed9308f70b..3c80d057bbed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -50,6 +50,10 @@ struct amdgpu_cwsr_info {
 	struct amdgpu_bo *isa_bo;
 	const void *isa_buf;
 	uint32_t isa_sz;
+	/* cwsr size info per XCC*/
+	uint32_t xcc_ctl_stack_sz;
+	uint32_t xcc_dbg_mem_sz;
+	uint32_t xcc_cwsr_sz;
 };
 
 int amdgpu_cwsr_init(struct amdgpu_device *adev);
-- 
2.49.0

