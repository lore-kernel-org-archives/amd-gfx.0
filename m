Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5700AEDF044
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 06:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99DB10E1DF;
	Thu, 12 Feb 2026 06:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fugaomAe";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2298F10E1DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 06:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYiHKVXS6BrOREfh0L77l7LC+/Js1onE5SrV2/2A30H6NPk30hYwrjyc5orJJYoL2VlQEZ/vOaKIde51zw2TO6007ZfncblkxLjVCOkeBvW045UtwZTRFTFbF1jd77g0ETrTmNqBWgXJ8qPKKAgKSn4435WWYiic387LWdhqP83v5auHc33KfjD21KQDBN0IqFSdzrdd55zEt6Nl/e2IcY1A0vgTmdOE2XfRyN4wps9RLBQuazZ/XLNZJ/9i6rBcHv48nRFPUDWDL5i+T51x1m0sJi0CaRVYxTZgU7+lvxP7rArfMzyW2TGVnbLesjVW/jLRE+hBfzFJHlbYWXYsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJmDtxRSPpIV+nSd0P9uZqsy9JHSYfGuQ3klWUwJYRY=;
 b=Qkaw8Em4nplB1/7lhnLwpmJ78JZ5pImNELXY9GRYBmsXbWmJHF08FvW6Zfr4vep18HNhxzVSk4bnXitAEs6H/3f//A/Yp3iL5AZegs6nGG+JGYexH+Eb7RoJAMRflCuG6FmNttIA8mvPcZw5cXttBpwZO1u6BEv2dBjQBcKqccj+4FQmHi/j8ng1Mwnm0+n3BTclla7U30nqMxrdKSJ79hhwpdXOAYKnXAy8ufIBv4JgS/MjeA5m49csbGux2HHBZU3HOposdEmoUlMO1dA5mOLi1EwQwns9otBLrZO13DzLRmnDBE+F379Xp349UfhnYueoCe2J3Zywd7BAPNy2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJmDtxRSPpIV+nSd0P9uZqsy9JHSYfGuQ3klWUwJYRY=;
 b=fugaomAeHGVmKOKawkz44q/ceKucWNQbrlje5Jzv7SXQT2ioBfZygm+Xq5fIHWIT40/NzZjPjLw49JELRGj6BV/HBFp8SPU5gdKofC0hHwHj/tX+XzrR84fU11nuKnh576TX88OrMkups8yk4FdSHRLrq0lYDfZQ20bJLJgRKr8=
Received: from CH0P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::18)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 06:10:51 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::9a) by CH0P221CA0030.outlook.office365.com
 (2603:10b6:610:11d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 06:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 06:10:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 00:10:49 -0600
Received: from amd-03.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 22:07:38 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amd/ras: use dedicated memory as vf ras command buffer
Date: Thu, 12 Feb 2026 14:07:02 +0800
Message-ID: <20260212060702.4153469-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4175a1-1b89-42ad-26b8-08de69fd7859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FBqoTjUL1J86ObFcAPDnzJwKD0yQTtdTL8WLIV7YryYWHwhV2DY6C+MYGTrO?=
 =?us-ascii?Q?bz2ev3n07Es0iZtmb5NH59167U+K6uRkH6Jytwu0CZdz+mfWuoFQghqEVYhK?=
 =?us-ascii?Q?RH6LOwDhOGHvq/RNq2Ff4X8cHORmYqsbig5UXgyR4Q1DFlPky5dYnXBQXctV?=
 =?us-ascii?Q?R2zn6YLml6k7twiL6NtUAsLaYvlQLx9ebifnHtT6JozexklVpLVYmvZvwEvF?=
 =?us-ascii?Q?J3Pca+JVwo8CHxE/Wgb+jrJfXbysBKWRGVcRLKduHmVFgmcteliUnOcH2kVW?=
 =?us-ascii?Q?rKhzBJGpsYWhFtUvM61trqrHnzTlesbui+RW3Rxlpe47Mg4OFdZd79wAz2VE?=
 =?us-ascii?Q?Z19VLe1q8rywG3dpyfdo+8PAAn0+m0PqNxtXz3Utdm2r7oXZZtoXC/mAYI0x?=
 =?us-ascii?Q?+HBSYo3f0BJOUYzDYy37qmdCU14kZzyI6qGTzSDjNoDxIoKBeV2xYGiEw0tI?=
 =?us-ascii?Q?fByJkDY71lhFAggtXZKUFKAe+6KIsHJjJyQyzEZHag2cCNQykrPnBssdBXte?=
 =?us-ascii?Q?Sb75kRAzMHYsjZdTUI7aEPFAiZ36jl95kabgBHycqhUe/+v/0i57MiZSZZqe?=
 =?us-ascii?Q?rcmmxiAAYJGwezgUEjiKPNlt2lNB5e12LBoSJ1Sxdx42WMmVxDGOJRWxdgRk?=
 =?us-ascii?Q?bf2i8dZ34eE5Kx5bmgDYJ8sHrzRFxcuxzdiklRD6YKYGsx0D9gcG5yyCeXsv?=
 =?us-ascii?Q?76tAJ3JpyRHyFtI1ADB7UccL7pzZu0hplFx2pMkNZW65qTLYvwqFhWHNzZ4N?=
 =?us-ascii?Q?UkzMBu6Q6Jwm14DQxaoarCSJq31fM2ethOEmASvF54yLpD2IZQiTm71GHPnP?=
 =?us-ascii?Q?R7wtck1laZlCUo6ZN4M3L+97YBWUO7l3xm54Erxurjr7VZEge7TtEKAawTop?=
 =?us-ascii?Q?3F49Nfj1W2alfM6/I18oNXzn2WJP9ksWbm19sEb+FleaUH/4PMB3iQA3p7Bd?=
 =?us-ascii?Q?v5LDHRbTja/XKMRkAr2cC1IUi4e3f84tFS+s/pMp94kopUNDIbethQQc0lKv?=
 =?us-ascii?Q?ttw4094OKh87kH7QoTnROFDT7wuwThTPW/3rJkc97OfTI20eK/BP1DRn7lq0?=
 =?us-ascii?Q?16ygwQC9gUVTp+G4Ww1QBXZWFmfcdc0MpFJHCxBvznLAxGizc1xri0d5yEKA?=
 =?us-ascii?Q?fmzfFObD3myHr9EFBodHQZpqATN3EDOEadjrq8oBSxlMcysf++ZyCG9G4w9i?=
 =?us-ascii?Q?MQmCsFjqzrHvkdb7sC4uegkCnP1fOde2So7SzWN+2WJOVrYEF83+j9QkHLBr?=
 =?us-ascii?Q?GhWApbo7yHo2iqBdpQrU6A9ee2QvsPeY4WRWKfi/vkJq5AfbfB2aLPx8BkeR?=
 =?us-ascii?Q?zkV8+mo8EKF5wEKop1gerBWAse4pBqH7rlVPvAfuDrvkFwm82D/S8KPdC35Z?=
 =?us-ascii?Q?2rkz4HKGiz42x4pi5gmYuANu2zZADaoipERfdbxUYTjruzERRzNdpaOifIST?=
 =?us-ascii?Q?qZWxGy4qSs2plsJz3pIBpcWkEXh/FZqYGfNGtsEEoyVKr91GxLmJxT+3BhHE?=
 =?us-ascii?Q?Mg7Y7S3HEtOSz27QAKDpVpvSILKYu0c1pz7bSEAnioMsHQi50vkkD+eRIWkr?=
 =?us-ascii?Q?idQ1TNTXo0iato+WePLGxULcz8uGUFRkutlkgzeV3m5iIxCRrn723bYxOWkY?=
 =?us-ascii?Q?6FoSOx3nru9Qve3OFG+St+98+ylca/89dRqSUIt+JkGoxLd5ho9oEAHJCfeB?=
 =?us-ascii?Q?4IrZjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6s4fLbcZIHYAxSFD6lOIWAIqnhJISscQsJZCrMMi/7ZOEU+1ZlrE6gNMqc/1FAXdjENLpvV5v9A2SAJDMhoE3sKrPiP3TEH38mlCqDqqfclgBXYTpfw6NrxpNHL4VwbKEDX7kM8tNtrESYUWl9y7PxRAw7eMFhykV/mlsgp1G8hj13lDdSYhatx8XoOHS5gOH0DVNmj8P6AvnHDqWPQGBlZUq+6ny/II9LbfkrDyIgY6ZaMlU4vbvlb58yPKrC/PD2YUxTRQ+z1ATzMJ8OUcESMbNf6IDTmLXpTIgdLNzP4kGVGg/FeH94YzXJH85MMKBjL+5ZS9tNtdPkKJKgdJdqyBUI5ygd89ktSm9++SNlFqf4rQ9mGhcVbs2y44pwwalzDaSN7m/euKCr22GX71P27HguKVKglFhDDq2rhyv+SYfKDqxpTv22IxxA3dN9/k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 06:10:49.9619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4175a1-1b89-42ad-26b8-08de69fd7859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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

Use dedicated memory as vf ras command buffer.

V2:
  Add lock to ensure serialization of sending vf ras commands.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  24 +++-
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 120 +++++++++++++-----
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |  10 +-
 3 files changed, 114 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index c20d10263492..aa8871515212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -498,14 +498,22 @@ struct amd_sriov_ras_chk_criti {
 	uint32_t hit;
 };
 
+union amd_sriov_ras_host_push {
+	struct amd_sriov_ras_telemetry_error_count error_count;
+	struct amd_sriov_ras_cper_dump cper_dump;
+	struct amd_sriov_ras_chk_criti chk_criti;
+};
+
+#define AMD_SRIOV_UNIRAS_CMD_MAX_SIZE (PAGE_SIZE * 13)
+struct amd_sriov_uniras_shared_mem {
+	uint8_t blocks_ecc_buf[PAGE_SIZE];
+	uint8_t cmd_buf[AMD_SRIOV_UNIRAS_CMD_MAX_SIZE];
+};
+
 struct amdsriov_ras_telemetry {
 	struct amd_sriov_ras_telemetry_header header;
-
-	union {
-		struct amd_sriov_ras_telemetry_error_count error_count;
-		struct amd_sriov_ras_cper_dump cper_dump;
-		struct amd_sriov_ras_chk_criti chk_criti;
-	} body;
+	union amd_sriov_ras_host_push body;
+	struct amd_sriov_uniras_shared_mem uniras_shared_mem;
 };
 
 /* version data stored in MAILBOX_MSGBUF_RCV_DW1 for future expansion */
@@ -538,6 +546,10 @@ _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
 _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE > AMD_SRIOV_UCODE_ID__MAX,
 	       "AMD_SRIOV_MSG_RESERVE_UCODE must be bigger than AMD_SRIOV_UCODE_ID__MAX");
 
+_Static_assert(
+	sizeof(struct amdsriov_ras_telemetry) <= AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10,
+"amdsriov_ras_telemetry must be " stringification(AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1) " KB");
+
 #undef _stringification
 #undef stringification
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index a75479593864..c101743b6299 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -30,28 +30,83 @@
 #include "amdgpu_virt_ras_cmd.h"
 #include "amdgpu_ras_mgr.h"
 
+static int amdgpu_virt_ras_get_cmd_shared_mem(struct ras_core_context *ras_core,
+		uint32_t cmd, uint32_t mem_size, struct amdgpu_virt_shared_mem *shared_mem)
+{
+	struct amdgpu_device *adev = ras_core->dev;
+	struct amdsriov_ras_telemetry *ras_telemetry_cpu;
+	struct amdsriov_ras_telemetry *ras_telemetry_gpu;
+	uint64_t fw_vram_usage_start_offset = 0;
+	uint64_t ras_telemetry_offset = 0;
+
+	if (!adev->virt.fw_reserve.ras_telemetry)
+		return -EINVAL;
+
+	if (adev->mman.fw_vram_usage_va &&
+	    adev->mman.fw_vram_usage_va <= adev->virt.fw_reserve.ras_telemetry) {
+		fw_vram_usage_start_offset = adev->mman.fw_vram_usage_start_offset;
+		ras_telemetry_offset = (uintptr_t)adev->virt.fw_reserve.ras_telemetry -
+				(uintptr_t)adev->mman.fw_vram_usage_va;
+	} else if (adev->mman.drv_vram_usage_va &&
+		adev->mman.drv_vram_usage_va <= adev->virt.fw_reserve.ras_telemetry) {
+		fw_vram_usage_start_offset = adev->mman.drv_vram_usage_start_offset;
+		ras_telemetry_offset = (uintptr_t)adev->virt.fw_reserve.ras_telemetry -
+				(uintptr_t)adev->mman.drv_vram_usage_va;
+	} else {
+		return -EINVAL;
+	}
+
+	ras_telemetry_cpu =
+		(struct amdsriov_ras_telemetry *)adev->virt.fw_reserve.ras_telemetry;
+	ras_telemetry_gpu =
+		(struct amdsriov_ras_telemetry *)(fw_vram_usage_start_offset +
+				ras_telemetry_offset);
+
+	if (cmd == RAS_CMD__GET_ALL_BLOCK_ECC_STATUS) {
+		if (mem_size > PAGE_SIZE)
+			return -ENOMEM;
+
+		shared_mem->cpu_addr = ras_telemetry_cpu->uniras_shared_mem.blocks_ecc_buf;
+		shared_mem->gpa =
+			(uintptr_t)ras_telemetry_gpu->uniras_shared_mem.blocks_ecc_buf -
+					adev->gmc.vram_start;
+		shared_mem->size = mem_size;
+	} else {
+		if (mem_size > AMD_SRIOV_UNIRAS_CMD_MAX_SIZE)
+			return -ENOMEM;
+
+		shared_mem->cpu_addr = ras_telemetry_cpu->uniras_shared_mem.cmd_buf;
+		shared_mem->gpa =
+			(uintptr_t)ras_telemetry_gpu->uniras_shared_mem.cmd_buf -
+					adev->gmc.vram_start;
+		shared_mem->size = mem_size;
+	}
+
+	return 0;
+}
+
 static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
 			struct ras_cmd_ctx *cmd, void *output_data, uint32_t output_size)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(ras_core->dev);
+	struct amdgpu_virt_ras_cmd *virt_ras = ras_mgr->virt_ras_cmd;
 	uint32_t mem_len = ALIGN(sizeof(*cmd) + output_size, AMDGPU_GPU_PAGE_SIZE);
 	struct ras_cmd_ctx *rcmd;
-	struct amdgpu_bo *rcmd_bo = NULL;
-	uint64_t mc_addr = 0;
-	void *cpu_addr = NULL;
+	struct amdgpu_virt_shared_mem shared_mem = {0};
 	int ret = 0;
 
-	ret = amdgpu_bo_create_kernel(adev, mem_len, PAGE_SIZE,
-			AMDGPU_GEM_DOMAIN_VRAM, &rcmd_bo, &mc_addr, (void **)&cpu_addr);
+	mutex_lock(&virt_ras->remote_access_lock);
+
+	ret = amdgpu_virt_ras_get_cmd_shared_mem(ras_core, cmd->cmd_id, mem_len, &shared_mem);
 	if (ret)
-		return ret;
+		goto out;
 
-	rcmd = (struct ras_cmd_ctx *)cpu_addr;
+	rcmd = (struct ras_cmd_ctx *)shared_mem.cpu_addr;
 	memset(rcmd, 0, mem_len);
 	memcpy(rcmd, cmd, sizeof(*cmd));
 
 	ret = amdgpu_virt_send_remote_ras_cmd(ras_core->dev,
-				mc_addr - adev->gmc.vram_start, mem_len);
+				shared_mem.gpa, mem_len);
 	if (!ret) {
 		if (rcmd->cmd_res) {
 			ret = rcmd->cmd_res;
@@ -65,8 +120,7 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
 	}
 
 out:
-	amdgpu_bo_free_kernel(&rcmd_bo, &mc_addr, &cpu_addr);
-
+	mutex_unlock(&virt_ras->remote_access_lock);
 	return ret;
 }
 
@@ -77,6 +131,9 @@ static int amdgpu_virt_ras_send_remote_cmd(struct ras_core_context *ras_core,
 	struct ras_cmd_ctx rcmd = {0};
 	int ret;
 
+	if (input_size > RAS_CMD_MAX_IN_SIZE)
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
 	rcmd.cmd_id = cmd_id;
 	rcmd.input_size = input_size;
 	memcpy(rcmd.input_buff_raw, input_data, input_size);
@@ -146,7 +203,7 @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core,
 	struct ras_cmd_batch_trace_record_rsp *rsp = rsp_cache;
 	struct batch_ras_trace_info *batch;
 	int ret = 0;
-	uint8_t i;
+	uint32_t i;
 
 	if (!rsp->real_batch_num || (batch_id < rsp->start_batch_id) ||
 		(batch_id >=  (rsp->start_batch_id + rsp->real_batch_num))) {
@@ -249,14 +306,14 @@ static int __fill_get_blocks_ecc_cmd(struct amdgpu_device *adev,
 {
 	struct ras_cmd_ctx *rcmd;
 
-	if (!blks_ecc || !blks_ecc->bo || !blks_ecc->cpu_addr)
+	if (!blks_ecc || !blks_ecc->shared_mem.cpu_addr)
 		return -EINVAL;
 
-	rcmd = (struct ras_cmd_ctx *)blks_ecc->cpu_addr;
+	rcmd = (struct ras_cmd_ctx *)blks_ecc->shared_mem.cpu_addr;
 
 	rcmd->cmd_id = RAS_CMD__GET_ALL_BLOCK_ECC_STATUS;
 	rcmd->input_size = sizeof(struct ras_cmd_blocks_ecc_req);
-	rcmd->output_buf_size = blks_ecc->size - sizeof(*rcmd);
+	rcmd->output_buf_size = blks_ecc->shared_mem.size - sizeof(*rcmd);
 
 	return 0;
 }
@@ -305,15 +362,15 @@ static int amdgpu_virt_ras_get_block_ecc(struct ras_core_context *ras_core,
 
 	if (!virt_ras->blocks_ecc.auto_update_actived) {
 		ret = __set_cmd_auto_update(adev, RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
-				blks_ecc->mc_addr - adev->gmc.vram_start,
-				blks_ecc->size, true);
+				blks_ecc->shared_mem.gpa,
+				blks_ecc->shared_mem.size, true);
 		if (ret)
 			return ret;
 
 		blks_ecc->auto_update_actived = true;
 	}
 
-	blks_ecc_cmd_ctx = blks_ecc->cpu_addr;
+	blks_ecc_cmd_ctx = blks_ecc->shared_mem.cpu_addr;
 	blks_ecc_rsp = (struct ras_cmd_blocks_ecc_rsp *)blks_ecc_cmd_ctx->output_buff_raw;
 
 	output_data->ce_count = blks_ecc_rsp->blocks[input_data->block_id].ce_count;
@@ -364,18 +421,24 @@ int amdgpu_virt_ras_handle_cmd(struct ras_core_context *ras_core,
 int amdgpu_virt_ras_sw_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_virt_ras_cmd *virt_ras_cmd;
 
 	ras_mgr->virt_ras_cmd = kzalloc(sizeof(struct amdgpu_virt_ras_cmd), GFP_KERNEL);
 	if (!ras_mgr->virt_ras_cmd)
 		return -ENOMEM;
 
+	virt_ras_cmd = ras_mgr->virt_ras_cmd;
+	mutex_init(&virt_ras_cmd->remote_access_lock);
+
 	return 0;
 }
 
 int amdgpu_virt_ras_sw_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_virt_ras_cmd *virt_ras_cmd = ras_mgr->virt_ras_cmd;
 
+	mutex_destroy(&virt_ras_cmd->remote_access_lock);
 	kfree(ras_mgr->virt_ras_cmd);
 	ras_mgr->virt_ras_cmd = NULL;
 
@@ -392,11 +455,9 @@ int amdgpu_virt_ras_hw_init(struct amdgpu_device *adev)
 	amdgpu_virt_get_ras_capability(adev);
 
 	memset(blks_ecc, 0, sizeof(*blks_ecc));
-	blks_ecc->size = PAGE_SIZE;
-	if (amdgpu_bo_create_kernel(adev, blks_ecc->size,
-			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-			&blks_ecc->bo, &blks_ecc->mc_addr,
-			(void **)&blks_ecc->cpu_addr))
+	if (amdgpu_virt_ras_get_cmd_shared_mem(ras_mgr->ras_core,
+			RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
+			PAGE_SIZE, &blks_ecc->shared_mem))
 		return -ENOMEM;
 
 	return 0;
@@ -409,18 +470,15 @@ int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev)
 			(struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
 	struct vram_blocks_ecc *blks_ecc = &virt_ras->blocks_ecc;
 
-	if (blks_ecc->bo) {
+	if (blks_ecc->shared_mem.cpu_addr) {
 		__set_cmd_auto_update(adev,
 			RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
-			blks_ecc->mc_addr - adev->gmc.vram_start,
-			blks_ecc->size, false);
+			blks_ecc->shared_mem.gpa,
+			blks_ecc->shared_mem.size, false);
 
-		memset(blks_ecc->cpu_addr, 0, blks_ecc->size);
-		amdgpu_bo_free_kernel(&blks_ecc->bo,
-			&blks_ecc->mc_addr, &blks_ecc->cpu_addr);
-
-		memset(blks_ecc, 0, sizeof(*blks_ecc));
+		memset(blks_ecc->shared_mem.cpu_addr, 0, blks_ecc->shared_mem.size);
 	}
+	memset(blks_ecc, 0, sizeof(*blks_ecc));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
index 53b0f3f60103..482a5fda72ab 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
@@ -30,11 +30,14 @@ struct remote_batch_trace_mgr {
 	struct ras_cmd_batch_trace_record_rsp  batch_trace;
 };
 
-struct vram_blocks_ecc {
-	struct amdgpu_bo *bo;
-	uint64_t mc_addr;
+struct amdgpu_virt_shared_mem {
+	uint64_t gpa;
 	void *cpu_addr;
 	uint32_t size;
+};
+
+struct vram_blocks_ecc {
+	struct amdgpu_virt_shared_mem shared_mem;
 	bool auto_update_actived;
 };
 
@@ -42,6 +45,7 @@ struct amdgpu_virt_ras_cmd {
 	bool remote_uniras_supported;
 	struct remote_batch_trace_mgr batch_mgr;
 	struct vram_blocks_ecc blocks_ecc;
+	struct mutex remote_access_lock;
 };
 
 int amdgpu_virt_ras_sw_init(struct amdgpu_device *adev);
-- 
2.43.0

