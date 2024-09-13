Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5F4EEE279
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 01:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D7210EC1F;
	Fri, 13 Sep 2024 01:40:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3FvsU/bO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B503B10EC02
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 01:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrLI32sQkIuws+9pH4UChfgoc5VxYqf44FwP52fXJoQUz82J/Gox6sv8hYR9cpRHC+vZblbWzhkY9FH5prPh9QeUurzJBhmYKHPKS+Z2qUtiLfJ64vyaQc0IM8GCN4rSkZ3VBxnYrPcjzJU+eOwLBDTTzYm046sg6gSoSSIkm8oVtVpZUiw8q9ngdSD75IFSJYLYtlj7jPxyyhCzIcYqIM2lPxeJLJ07k+eCL4imsY56Q0gdGBC7+l8H2eAt6RtMvnNmKKedYn9iCwWwsOBfgqwmVSerBT9JSTBgbkvEYFdNbWarskxuw2jm1sG08fz/EH5EPntL9gQxT8HH1F2KNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZASahaXz2ZyXWJlWHjCbOG++ddt1x9QihsyFoId272g=;
 b=d/oMEp2k0TzNQDfL9/SXeF68TKCh8VNTGK6q2C7FeoBU+HRmQ8W77qA5qg07aFRAjggZx9WTcTLcpVU6ogTnMaVifD8L5QvGiWd/09UoPaz1kEWxi32V0MT7tp/ydk2NOW60rmXFOcdKCqQV7VDWCi9p1c5X1cB5jgxSwTiJ2+p/4EUoXnP2TaFb/VOWIPxxL5o2NZMCxg0aX3/eNc5Fkjsbq1Y1PjWF8FVZ41F4rHXdPUppmcS7nnL2U/hcchDkbFdCCMTM13R3/Etz72Rwm1e+RPiOS0haHNE8s9HR4DKyIDYtdNt2dmqrHRWdWx/vHkWqV20DwalRp3w2VtGboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZASahaXz2ZyXWJlWHjCbOG++ddt1x9QihsyFoId272g=;
 b=3FvsU/bO+2KLfOGZCWlQ66MnHjxmeII15Tc4Yoijvf2glh1Y4GOxjLZsptbUxSTF96SEhitZjIx/6SPfIDMUe6zvkOAqKeL9AUzM4EzWpwjjbOXUSgjSGgD5Hzf6CygrgitWO6kWjWfUuTvB8npvzcrU4Ha6+epc+UFiWFhHmZc=
Received: from SA9PR13CA0096.namprd13.prod.outlook.com (2603:10b6:806:24::11)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 01:40:00 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::e2) by SA9PR13CA0096.outlook.office365.com
 (2603:10b6:806:24::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 01:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 01:39:59 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 20:39:22 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Du Bin <bin.du@amd.com>
Subject: [PATCH] AMDGPU: init saw registers for mmhub v1.0
Date: Fri, 13 Sep 2024 09:38:37 +0800
Message-ID: <20240913013837.311481-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: aa405865-c717-47da-e101-08dcd394faf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wqZxwnSZTHJ65cqzcP0c+ipB3ODhResM3GX09+eJgxH3fwBdw3MNfzFenD2U?=
 =?us-ascii?Q?YcYNNnT7Jx6H/TeVD+sc7KwQtPH8K3NY5V0cJywnYEyPME7BjxcKUv4mJyfQ?=
 =?us-ascii?Q?wCqXa+SC1Mw8GRXDWQq0+nzZpyfWbXwsLoNLYn6Me0MnnPsV+yolLXmtmrlP?=
 =?us-ascii?Q?iukNGX/+mJgAnqcwOYJS0lALVYAC1yPtgvk4NyTXrE7HWEWwlBte+F4wJZZP?=
 =?us-ascii?Q?0KBNGRsry1rp/bLp4s/xu8Vbz+LvzWsljMwE36sdKXx400XLAcZDdLESArxW?=
 =?us-ascii?Q?Yb2oP4qseRZ/aXoJwyKQMPTbC6IPv7xSCpbK5AY99V1S86PB/QX0jKT/MIeo?=
 =?us-ascii?Q?kNQjsSsyIrVfxytnTOcteiZNq17PKibCjGQ7v/dI8IcWlLcQEJu7tvr28W/S?=
 =?us-ascii?Q?sfzcxgYiUJlgVtjgvWnWfGKq2rkPW6Sm10H8rp5zX6iQ2NdkQy4EI/nW0F2H?=
 =?us-ascii?Q?UJMagsuTVjL7nfPXt/mDHpu+OW94Anj8FLQIYqiPWmW0mwMnEopXw1reMBTH?=
 =?us-ascii?Q?yoldBFRCiik+zL6Nn5+WaxM2+7L6mE9yYih5oH4OMB7S4USIkkdjqAX9ROxq?=
 =?us-ascii?Q?6MZAuR2pO384Lixo4bOdvOl5tNEOsV4r0OKmCjJ9LxubxmyIWHmsgKrDON++?=
 =?us-ascii?Q?UHWrBW3qor6ma68WUX8V2sQ00ulKGXgQgjuQnNTML5qjqofO4DzHD0nPgOy9?=
 =?us-ascii?Q?jO/L0fGtrLMm/JemAK5kr7HrcEkxb3VEAOYYyVCmhDUwXybwwc/W7VyQl8uV?=
 =?us-ascii?Q?Kc2MP5CjKbb3PyYrkVjRQoPAD1MGdtwwJz93tzOf2d0D13whAjQ+ggpwoG2O?=
 =?us-ascii?Q?GQWuSMYlAkKVVUZHfmlzgBkUndUGM2c3Mqv7H/TlyHoIyJi4l0EPQdEfAvSk?=
 =?us-ascii?Q?WQ/1sK9P8LNpNURZ61KilhjDU2omue/ddWNqbPrqR3jDOwUOnuRWnny1064Y?=
 =?us-ascii?Q?zOqIMgJ5AJb2NNkQ8LYo0EhO6nX8V8xqB+BhXbKzdct22C3gNX0/2ZbKzNfm?=
 =?us-ascii?Q?A8KjBYEOy2gOwJTkJRdqPg0tPdvgFCZzB+szse0Me2ECUP/Bfs90vWgyktgL?=
 =?us-ascii?Q?TqwxSv9VGn9Fr//7HzCa42ipVOPwn6rmTlZ224H7BYCvBqVyXLjMd8BqJmFA?=
 =?us-ascii?Q?YtIs1NFuq5e4p6U8BHbrUXRosZ2bFDSxcW0sNnMSXSqS05/Xhn5GTMDyJPm3?=
 =?us-ascii?Q?nN70AxjqJzmafu6RbvmUtj1NQGl8VT4RuOmtVhPMf6WVKBYKPeI/pkfl6Ctn?=
 =?us-ascii?Q?D0qmQxxBhIsw+XCYYlNFemTMDa9VLGXpiSVOHurY2mixdR1TgdRdVRXbRFfK?=
 =?us-ascii?Q?RyKRYPEKsSUKmdhYc+GLp0YzdhcFG8wrIuPR2BJR8Y4zeMQhyGRuebbJdRNt?=
 =?us-ascii?Q?o+hbl4un2XvwsTUazAW7BM9dO039v6DbhQ9Cx/JVDda0E+NquMNSxFD1y3qH?=
 =?us-ascii?Q?IIIJ8fyUfgeYLRkDs8h6fWMQ/TUek+dZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 01:39:59.7999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa405865-c717-47da-e101-08dcd394faf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       | 48 +++++++++++++++++++
 .../include/asic_reg/mmhub/mmhub_1_0_offset.h | 23 +++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index e3ddd22aa172..80864898b480 100644
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
@@ -283,6 +329,8 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	mmhub_v1_0_init_saw(adev);
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

