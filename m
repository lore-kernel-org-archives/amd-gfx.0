Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CB4EA3F24
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 08:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F0510E4F7;
	Tue, 10 Feb 2026 08:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CPkbcJeK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7264A10E4E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 08:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diFQMr5vlr0nKFyJfctFcWKAJ1LJwgCdFRsWLjVsZ2ooCGu6dP24weF9sp6ZqjhEMS8CS/WIhGVADNDzBz49oy68GLdftthQcw0hFQhoatHywRYhwpUT6Xup2xw1jQgTmh8y58m9INSeosUP7phWrlbPpaA7AUVD78TowDDau+c+yE4gVzOMZUCNC3qBSKKULxRiuE2+1e+PXgFvxszGTCl/oYfw6eT1F6l3wRSHUKdYqToUzabfGgpR4cQAjwzd+eGOECtXGW8lj94iMtIBpIZhSojB2VdVt/hCjuSUCsPyegRaCBBNLy7sewttA9QsCySbiqymQIl53MQ5bySZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UVhFmkP7ldjc36QDRhcacdz1pPjyUr+y8eLZlly0so=;
 b=bL2BCGFE/ydMUOR9D8yo2JSB7xLM23m2o6QXuCjEs0cF4VQIgO58PJtrL24tmkGfFzi1kYzg44BvY2dCn3r2cSkbfAIt27HF5PDhU0Ke5EjnnI8fjXmY5Fr2YaOXj73AzKLLygOGAb3kG63II731XkgLOl53JEE99lRC6JNvxnW2I4DEHPClYA9uQnkcppHvYRgMwvoMii8vaPks760fT4AzzSQ66+0VSZyXFRt5D3rYe+2RWY9XIvZpzEqL53h/qMSGCCZCC8DrwY/j581FSaZaViScSofvq2J35nrRzt6jwS/bxlak4wHI/Z+2YucCHstM3zAxbqk6XkOF/O7hyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UVhFmkP7ldjc36QDRhcacdz1pPjyUr+y8eLZlly0so=;
 b=CPkbcJeKQLd6f6hPKyT/vrFl3OrBt5Bdrcswp7d+WFX77o6tvpQUme1AxDKShQDsrbLoT2iYGsP4loagEFQe2oMPUitA7DK+FULO02mIqphW1XSqvvmaCTA+p+KX0PimNgqdRQdiafDzeQvybZqFHh5iAa4XD2mjYnZ2Ou2rWaI=
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 08:20:19 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:331:cafe::1c) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 08:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 08:20:18 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 02:20:15 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amd/ras: use dedicated memory as vf ras command buffer
Date: Tue, 10 Feb 2026 16:19:35 +0800
Message-ID: <20260210081935.4055180-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc9b7ea-3b08-4528-3517-08de687d3a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xYJodLQvOeV7hkiBUnHmCWgCyziF8y/zKOq/W8sDilrqxHDV6D9I/QvsQ1lp?=
 =?us-ascii?Q?zwJtI1l8QX3PeXVPq0c8v92r1lHcREHyfmr6ohdePYQy9WnnEWIgDf0mVs1i?=
 =?us-ascii?Q?85fADeC/3di1iHVfRK9Ra63QripapgPLHypyzxS7+F6hOT4iYkURfjBwk8bH?=
 =?us-ascii?Q?Mio58VptLQkSTSWAuvoRNae89pxe7GcJ3uXwy6r0eIYAqMVTRWPBoWTGvhQb?=
 =?us-ascii?Q?1Xbnu6n6YnSFMeU4x2qS/Psp53rlv2NHbua2kG82l87NeVcsxs+YR9eDZ7fm?=
 =?us-ascii?Q?cA7OczIMhAHWG9sIHFtqEm5UIMl6jMR0ei9LGd18PHorvlyvstxe4rOu5sKt?=
 =?us-ascii?Q?CV1ZThg4dapkgH0VUCKVnNkUcqXjuDFzV3kI75eRCRBnI6cGtWRFesntY5K3?=
 =?us-ascii?Q?I6YkvqeNjOpuF4jnfuCoGcBOdJZKIsl31uDijJBfk+K1Yuf2o1XfYE6CydSU?=
 =?us-ascii?Q?MpEqzhdmfdKG3GxfM/auB5O48So1E30lvqBBWSvvrNqlQMYJlgRoSDTX10K6?=
 =?us-ascii?Q?sq+Li5Kdg9G84zPhYFUGfw7okKpApWoDeBQOEG05JWz8bR3NWv8MlhfVtd/J?=
 =?us-ascii?Q?FYxO3UrusFlsSY2cToq3OY0R/E9flIl74te8eMq1ffRLpmp7BFc2DjOAtCM9?=
 =?us-ascii?Q?EUR2VreEhN6pyCy+Aw+nnve7ye/CLjESwCmoyAgNR5rckKV5meITJpxut5bY?=
 =?us-ascii?Q?vcP6ufFpFynX9Cdv+2utw2sPP8jUCT6UWRh3Gk5RL54K+Xz/962eaq0ja+cG?=
 =?us-ascii?Q?RSaMgMQV9vU+kD7uJRU/ySoCQtYTyJOF3AXewVybMfl1877YxJx2smAjyCfJ?=
 =?us-ascii?Q?fFXAS2DYshvK3kjJVgCyn4jYmzd2K6RLhPNrZO1tOrxGNiNvjikJgxqzU/7r?=
 =?us-ascii?Q?/afZlmCls7DAU7vZkCVtoImUxWlwfaPE4GqJtXuutw8H6oIDUuyl6SKTT2Pe?=
 =?us-ascii?Q?pihiNkHMUIvO2ksmy5RBTP7z8q3L9gU7+WreG0RXfWbj9eGr2xLwv1iY3iJD?=
 =?us-ascii?Q?ih2y7qrobLpzvetypb2sYEkrP7NmOWTsjZa80m/+9JXVxQaaWWNBjgft1KIO?=
 =?us-ascii?Q?SwkwKPeKJwOpaqCM+8tO1tjt3V5z/T5EDOKyTZXIRmuXz7x1nTyF8YjBTg71?=
 =?us-ascii?Q?B94whpVfM2WXaGOVJgsAry0n92g+Y5BaKKZtzK+eMcJtBXHwK5nkiT01tQPN?=
 =?us-ascii?Q?sweOaYMvllUCbC4sJKFVGX8QZ8A4qG6NJyWNfHiSv6Mw9/RiCSv+ucSIHl0W?=
 =?us-ascii?Q?86ifBMlyV24ncGJ0Hm1gDXgCpymTlDyxSy+zkO3a65QAd/LEWN/aRrFauLvs?=
 =?us-ascii?Q?iSGLOdACKgpviOd2u4pgLJxBpLc3j++u/wvTmrtp6boqKTM63sA+WVVS6llj?=
 =?us-ascii?Q?AUU7D4T+h/Q311gY7Gi5KRsI1DuT7Vw+ypHY+B3fUL5BVTq6b1QqaWwFlv00?=
 =?us-ascii?Q?1w3o9tQdI1vxDz4V/m/DIfQTOw14cR2nN5akDLbH9dOG8wPE8fO4XDct+A8q?=
 =?us-ascii?Q?zeeCF5v/RBAjPkvcD5JrRTgkUNVACbECJ6OIfnFCenlVRJYyWtlURJmzpX1w?=
 =?us-ascii?Q?P7xqryqgO5dDPEal3FrzwD9mdkLOwtOWuNCCdiGUrnfXKIh3scoQKL+Mjc62?=
 =?us-ascii?Q?MDBlRwmwlUQYvtGYmu9Nkbf4Jy0PLBJp8O/Rc+ZFXp/aLydEdJz585DyfO0k?=
 =?us-ascii?Q?4AjemQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WEmANDULxnELcBBHOo4L1uELR+ofAe1c1v7ByC89Be3zbiCcnRGkHHUtTxURy4Kc7i5iXcGVhqne07+a2dXE40WOVvGJcmafuKx7wWTvmqKDuc965Lze4gYgTJQnEXqdusU/Hz+raCUBkD1ZjeCBGuVPf1JRXHEO0Nf9pXEGHp2HXYza6iAHOU4lO0h/z1TZ1azkJfpNUBaH9PEls/rbYbJHwQsScLXc4gspwLhCe/+QEhnbD8fFL0k1iHzZJkV713rK4Z9BH1jwu0yXfxgGyUZgxjZwt4u7CCHWHyE9mMj1MSh+YWXcabT+ucrZGXXSFPxvosFV6hmb/aQnJoFefXBcOQ2OcG3kWWO7+4yamnkAOT8946sIIDGwnyp80kg5n9Ykx+41UHSIRYsJng6bc5MpVttIvWwbBt3KkDqo4MAsbfTOF+Rg7dg41Dwr+Fis
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 08:20:18.6954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc9b7ea-3b08-4528-3517-08de687d3a1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  28 ++++-
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 114 ++++++++++++------
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |   9 +-
 3 files changed, 107 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index c20d10263492..067832b5936c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -498,14 +498,30 @@ struct amd_sriov_ras_chk_criti {
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
+
+	/* This is to prevent the size definition of the previous structure
+	 * from exceeding AMD_STROV_MSG.RAS_TELEMETRy_size_KB_V1.
+	 */
+	uint8_t reserved[AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 * 1024 -
+		sizeof(struct amd_sriov_ras_telemetry_header) -
+		sizeof(union amd_sriov_ras_host_push) -
+		sizeof(struct amd_sriov_uniras_shared_mem)];
 };
 
 /* version data stored in MAILBOX_MSGBUF_RCV_DW1 for future expansion */
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index a75479593864..0c72e1e5834c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -30,33 +30,82 @@
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
 	uint32_t mem_len = ALIGN(sizeof(*cmd) + output_size, AMDGPU_GPU_PAGE_SIZE);
 	struct ras_cmd_ctx *rcmd;
-	struct amdgpu_bo *rcmd_bo = NULL;
-	uint64_t mc_addr = 0;
-	void *cpu_addr = NULL;
+	struct amdgpu_virt_shared_mem shared_mem = {0};
 	int ret = 0;
 
-	ret = amdgpu_bo_create_kernel(adev, mem_len, PAGE_SIZE,
-			AMDGPU_GEM_DOMAIN_VRAM, &rcmd_bo, &mc_addr, (void **)&cpu_addr);
+	ret = amdgpu_virt_ras_get_cmd_shared_mem(ras_core, cmd->cmd_id, mem_len, &shared_mem);
 	if (ret)
 		return ret;
 
-	rcmd = (struct ras_cmd_ctx *)cpu_addr;
+	rcmd = (struct ras_cmd_ctx *)shared_mem.cpu_addr;
 	memset(rcmd, 0, mem_len);
 	memcpy(rcmd, cmd, sizeof(*cmd));
 
 	ret = amdgpu_virt_send_remote_ras_cmd(ras_core->dev,
-				mc_addr - adev->gmc.vram_start, mem_len);
+				shared_mem.gpa, mem_len);
 	if (!ret) {
-		if (rcmd->cmd_res) {
-			ret = rcmd->cmd_res;
-			goto out;
-		}
+		if (rcmd->cmd_res)
+			return rcmd->cmd_res;
 
 		cmd->cmd_res = rcmd->cmd_res;
 		cmd->output_size = rcmd->output_size;
@@ -64,9 +113,6 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
 			memcpy(output_data, rcmd->output_buff_raw, rcmd->output_size);
 	}
 
-out:
-	amdgpu_bo_free_kernel(&rcmd_bo, &mc_addr, &cpu_addr);
-
 	return ret;
 }
 
@@ -77,6 +123,9 @@ static int amdgpu_virt_ras_send_remote_cmd(struct ras_core_context *ras_core,
 	struct ras_cmd_ctx rcmd = {0};
 	int ret;
 
+	if (input_size > RAS_CMD_MAX_IN_SIZE)
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
 	rcmd.cmd_id = cmd_id;
 	rcmd.input_size = input_size;
 	memcpy(rcmd.input_buff_raw, input_data, input_size);
@@ -146,7 +195,7 @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core,
 	struct ras_cmd_batch_trace_record_rsp *rsp = rsp_cache;
 	struct batch_ras_trace_info *batch;
 	int ret = 0;
-	uint8_t i;
+	uint32_t i;
 
 	if (!rsp->real_batch_num || (batch_id < rsp->start_batch_id) ||
 		(batch_id >=  (rsp->start_batch_id + rsp->real_batch_num))) {
@@ -249,14 +298,14 @@ static int __fill_get_blocks_ecc_cmd(struct amdgpu_device *adev,
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
@@ -305,15 +354,15 @@ static int amdgpu_virt_ras_get_block_ecc(struct ras_core_context *ras_core,
 
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
@@ -392,11 +441,9 @@ int amdgpu_virt_ras_hw_init(struct amdgpu_device *adev)
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
@@ -409,18 +456,15 @@ int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev)
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
index 53b0f3f60103..001e4cfb823e 100644
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
 
-- 
2.43.0

