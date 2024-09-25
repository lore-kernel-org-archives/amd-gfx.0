Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE62CF9C71
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 03:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEA410E773;
	Wed, 25 Sep 2024 03:12:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKlmc8h7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A42D10E773
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 03:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkDUtQWs+2BsXTN/IX0DM2ayyJtpQaDGfFEMpJpOinJoj+WnmjwCt+Q/lz+FeVG4X2pX0MVf5jgiGiAM7+LgYVMBGimBH4pfYN/IzlIZvJTgQIxAXnTBqCPvivwEl8gxY66mL/Dduz+oLpr5Ggg/19JAqe7DcCe6mIKlOp+qVVWm0+5uG1S+8JuCkq1/LsUwtdYc1muX7Q7i4gamth36A9IuJveeWT5UJT+rkkvhtyChMwg5apag1Mzds852+rlS6VaAAY1a3w7cjcuQKe9VTJ5AOvwnmnJe/I7QSddBez0TVhNxybx1snFcUVBdQ2NnwFGC0MU6ZqiCUD89LVYRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6ef1swI0OR4zRqai9srppMCKjvcUKQYFcUuhzu/utM=;
 b=irqAei6lIBIxHlW78+H2/7XQEc33RuqnJJxTPVMwEh40xhtxClt9o/mV6ilglqy7d48GW8nmqqkbjANrI3g0BhjvFsWPNrvVSbypROYosQEFcwRMu8lnRHGL7phD/Fxz7U1J7qAWdrgQkfXIYyN7FDlb4C9Aj7qWHuSNbWriHCi+beDdampLoTMBrVTHxqW7KirOvx+b8tBhxkCE4nXK1GKPcVVfK/WPQNTcOj9ro+le2cqeBUGycohNYxxVBJlIbVQDf6rT2dDcnyuR3P5c7H8W73FjEtjxn/DmO1Et0Idz5gmErb6e0U+mkQ8hDY7QfpWBPwzQWAoHOPoCTKoT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6ef1swI0OR4zRqai9srppMCKjvcUKQYFcUuhzu/utM=;
 b=zKlmc8h7tN8BGO7mESOGDBxgKGXgtbDvDZ+5NR6RUOxQBGRxsPGBVLmrKro8McpF3G5RaXzZ7DDVdlFH4P+JhTQ6BKhwVFK3HVdoOiocLQkV9mE4Xdwze73hJ+W9U6BJ/sBw/aAayUX3dpDMsALSY4EenI7Gj8M2YYYSwSl/0Os=
Received: from CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::19)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 03:12:00 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:610:116:cafe::a8) by CH0P223CA0008.outlook.office365.com
 (2603:10b6:610:116::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 03:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 03:12:00 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 22:11:14 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Du Bin <bin.du@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: init saw registers for mmhub v1.0
Date: Wed, 25 Sep 2024 11:09:51 +0800
Message-ID: <20240925030951.603486-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240925030951.603486-1-lingshan.zhu@amd.com>
References: <20240925030951.603486-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 990057d9-0395-4da4-a3aa-08dcdd0fd25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EYErCF6HxKiQ83i7vTgqORqwJpXq3IAR8wI6xN9HwOZ6pqyYZTwZqc611SF+?=
 =?us-ascii?Q?S4GhObgCFHI9kw76M9PsLfvhfPM3VAVbAn2HukO4IGknvqfGT3lk1R5glTgW?=
 =?us-ascii?Q?SYtFIUDGTQzMQIv3EecSK8r7NkbntJIQdq0LbITiFs7CyuGTv4mfUW8+obvk?=
 =?us-ascii?Q?u9wnmlVY5qdng+8Us6IHon69Y5pO8nsDMDvwrfWcFtGTGo8xRv7Z0N14Sa5m?=
 =?us-ascii?Q?4j2RMlHgAd5ttvZSoOJgHbjEpd+jF+IYSQMdk5aPyqmiy2aDbYacjXHUsjUD?=
 =?us-ascii?Q?bbiGH9z9m2bGLd0v/2V4eIW8o4tsmOBN7WlZi57bBoIeXHfXPECUJGI2kXbi?=
 =?us-ascii?Q?00SZKcjGAhx0n8gMrFENRs3Pchh0aS1jEQjLkYkx50LUfhtTCCd9FFgGv9Up?=
 =?us-ascii?Q?TzGyBtNG/xRfEFyfNy7i6s7sMUTF+Lqqe4bUhJ/Ois3YKkrE6iRr9mLftOqC?=
 =?us-ascii?Q?kX8fGkBwLA/CNXB6TfXqxaeFiuGBNfZOJ1Nk996KHQxtNsZw/lkpzzVIAX/z?=
 =?us-ascii?Q?1hjXhZaP1ahg/xXbVxjaUaVGvoyHVWKcjPpTtxPLGI5feb3vPT3lHxNMuU0X?=
 =?us-ascii?Q?Gs3E3SDtmqaHsz4aykOtvzPcxh9060LItQkE9VW80pp16OY9slPhzD5Zxl/F?=
 =?us-ascii?Q?0omA+czg8ouwOLUa5CcX8zIplKmPaYjF5pk89dCHj4I6BAeOSZ1QTSpiQYAo?=
 =?us-ascii?Q?bhLbU3k8SF0IYmLrf4t/K7nt5ZtjogO637xtO6Efhw+kfVvFXMVII3K3fFRc?=
 =?us-ascii?Q?6pb4zhv+5UwQFq6D0pkdYRs+GZYSFZRQkiJWY6GbP8976NSpMWB9fQY9eFFl?=
 =?us-ascii?Q?lQUJqSyxZSjcgvZdh3BK4WTf5xzt9bfHQyxgL4RBwq+uU1BC3+cp7nuSON3Y?=
 =?us-ascii?Q?vPzoMc2vC4hC4TP4Z+WaiYSVzmbfiUCPqXXAn2KitUgvRjLockuxgyx3aAL3?=
 =?us-ascii?Q?f//jNJsHNswQdRXqdiRkh1Otw5MazTekAqLs+Sws9xKpK6oUymEJxeT0sC5J?=
 =?us-ascii?Q?1kLNgoJvTn8tuWNU4RxB2w/DljkIko25VzV9J7wSHxatnfm5SxBPxro6QWoB?=
 =?us-ascii?Q?dUCzl+SyU6Iv29xDVdHmTOYB3w7msp1kJocIuoEh+ClKK56/fBigfULa8/LY?=
 =?us-ascii?Q?3ycAj1gLpq1MsOPY5jQJN7EYaVFi3P2XkWtAlXdVI9qDqMjaNHZaoIQeIjmT?=
 =?us-ascii?Q?u5oLDLP3x6GgP7QfoURwyPOmWijIEvGHGaRkH+BTxN1hlaFT2qzZkEhllgTf?=
 =?us-ascii?Q?RlDClGvTePyO4odYVOOYNaf26seK/JD10mHmnz0h2w6KgKTC0k0CzKY8drD7?=
 =?us-ascii?Q?f5+wrB08q4X5yS3Hc+YjW/OA6TCuIbG1U2FC9KJWujCmg6UnMLA8y3gNlO+2?=
 =?us-ascii?Q?0gNL17oYAnq0z9pd2afTNMSp0VS1RbMrsd5pkjNXrdr6DFf9yLoBE/BEdoF4?=
 =?us-ascii?Q?tUwtfiqK60nKrYwHwhvNWad9823r7N+H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 03:12:00.1517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990057d9-0395-4da4-a3aa-08dcdd0fd25b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
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

This commits init registers in the Stand Along Walker
for mmhub v1.0, to support ISP use cases.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reported-and-Tested-by: Du Bin <bin.du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       | 49 +++++++++++++++++++
 .../include/asic_reg/mmhub/mmhub_1_0_offset.h | 23 +++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index e3ddd22aa172..e9a6f33ca710 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -229,6 +229,52 @@ static void mmhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
 		     0);
 }
 
+static void mmhub_v1_0_init_saw(struct amdgpu_device *adev)
+{
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+	uint32_t tmp;
+
+	/* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32 */
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+			    lower_32_bits(pt_base >> 12));
+
+	/* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32 */
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+			    upper_32_bits(pt_base >> 12));
+
+	/* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32 */
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+			    (u32)(adev->gmc.gart_start >> 12));
+
+	/* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32 */
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+			    (u32)(adev->gmc.gart_start >> 44));
+
+	/* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32 */
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+			    (u32)(adev->gmc.gart_end >> 12));
+
+	/* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32 */
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+			    (u32)(adev->gmc.gart_end >> 44));
+
+	/* Program SAW CONTEXT0 CNTL */
+	tmp = RREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_CNTL);
+	tmp |= 1 << CONTEXT0_CNTL_ENABLE_OFFSET;
+	tmp &= ~(3 << CONTEXT0_CNTL_PAGE_TABLE_DEPTH_OFFSET);
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_CNTL, tmp);
+
+	/* Disable all Contexts except Context0 */
+	tmp = 0xfffe;
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXTS_DISABLE, tmp);
+
+	/* Program SAW CNTL4 */
+	tmp = RREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CNTL4);
+	tmp |= 1 << VMC_TAP_PDE_REQUEST_SNOOP_OFFSET;
+	tmp |= 1 << VMC_TAP_PTE_REQUEST_SNOOP_OFFSET;
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CNTL4, tmp);
+}
+
 static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
@@ -283,6 +329,9 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	if (amdgpu_ip_version(adev, ISP_HWIP, 0))
+		mmhub_v1_0_init_saw(adev);
 }
 
 static void mmhub_v1_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h
index 2c3ce243861a..380e44230bda 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h
@@ -1232,6 +1232,29 @@
 #define mmMC_VM_MX_L1_PERFCOUNTER_HI                                                                   0x059d
 #define mmMC_VM_MX_L1_PERFCOUNTER_HI_BASE_IDX                                                          0
 
+// Stand Alone Walker Registers
+#define VMC_TAP_PDE_REQUEST_SNOOP_OFFSET								8
+#define VMC_TAP_PTE_REQUEST_SNOOP_OFFSET								11
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32                                                 0x0606
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32_BASE_IDX                                        0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32                                                 0x0607
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32_BASE_IDX                                        0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32                                                0x0608
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32_BASE_IDX                                       0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32                                                0x0609
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32_BASE_IDX                                       0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32                                                  0x060a
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32_BASE_IDX                                         0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32                                                  0x060b
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32_BASE_IDX                                         0
+#define mmVM_L2_SAW_CONTEXT0_CNTL                                                                      0x0604
+#define mmVM_L2_SAW_CONTEXT0_CNTL_BASE_IDX                                                             0
+#define CONTEXT0_CNTL_ENABLE_OFFSET									0
+#define CONTEXT0_CNTL_PAGE_TABLE_DEPTH_OFFSET								1
+#define mmVM_L2_SAW_CONTEXTS_DISABLE                                                                   0x060c
+#define mmVM_L2_SAW_CONTEXTS_DISABLE_BASE_IDX                                                          0
+#define mmVM_L2_SAW_CNTL4                                                                              0x0603
+#define mmVM_L2_SAW_CNTL4_BASE_IDX                                                                     0
 
 // addressBlock: mmhub_utcl2_atcl2dec
 // base address: 0x69900
-- 
2.43.5

