Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AF5C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 05:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92AFD10E240;
	Thu, 24 Apr 2025 05:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWhCM+zi";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 016E810E439
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 05:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1jH27wHokFvByLs6fnhZh51KwlkgAcGEoaaG31oTD4+QhFGVW51NScwh+Rk58Ei/IELUhWDUvLN9ds6/ZPBqBtZ7jvPvS52st/NT0Rigf7e9uy4clvl3w7/C1KTst5yqKgX0Dufh7DJjcnSJndjMUpPw8OLLKt3Nb3GRuyHunfSKhwXija4HB11JzHq/iMLvcjDc1ifyYJsJkVFrEVsqir2bS6jzFU+kKHYaSt/EJiZVtHUNPDcjHKHaVbcJIt4e0HREtMZm/KFrztU+wcDRZ6xgr9RFdR1x/G0gvELaztGiLm+svUwEHyFbbTZabqG5oidMB/q2HOBFdYznMPWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRVRLYWaoN0gko8trlIsFFP1IHbLx8vqusGVuCGKWHs=;
 b=Z/E3ohFTT46X0Pn1LKpP/gIJWsi+BdFCHE53XygKl56DIm4R+7Pp4PsEaRs0EzHR68h+SNq/97MdrPYeA+9nbn/hsQes1xwE4/Sec+p7C1HpE0dPj0xuonqDPqCHQyv+9VmtR4S1oSXaa+vudR+ZekR40sS/cew1Hy9hY+HPeL+tPgJ2ZzP8Yb5Uf/Suuou18ZlIvobNa2ylv2ce2hoZe9P1I5z+9Fan4RB/SbetY+vkz/WkXb/AqV8hWNpX+8DvO7yInZDITwf/M/MyInBBIVoCULOhqri5OnHeZ68UOZ9SHwGIzhVRoBdCveMGnrw4dOq4RvLPfy74juym/FLbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRVRLYWaoN0gko8trlIsFFP1IHbLx8vqusGVuCGKWHs=;
 b=JWhCM+zif9Ej2zf5pI18yX6+LuEg61EVNDwMjcCfYl8gLRtu1kgBOn1Q16+begbm1ztf5GWl61yYJPviniRISxagHOzdQLXoFkmOgy5dUCHDH3YFSBmkv4ZVnHauSSi34h0uPFYMyTSFIuCYqdKpRE5b1n5A8UQ/xktV5wytYcA=
Received: from CH2PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610::27) by
 IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 05:54:40 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::d7) by CH2PR05CA0014.outlook.office365.com
 (2603:10b6:610::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.13 via Frontend Transport; Thu,
 24 Apr 2025 05:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 05:54:40 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 00:54:38 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
CC: Shane Xiao <shane.xiao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add debug bit for userptr usage
Date: Thu, 24 Apr 2025 13:54:25 +0800
Message-ID: <20250424055426.1471075-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: d70dc8dc-0819-4344-9181-08dd82f480f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AdwwdswiIM8gcnTVfG7e4g/BHEkzXTqdN/NXrqNmKpEbsTkjEwu9Vc/VOVIL?=
 =?us-ascii?Q?LQqFSuzFjpLFlddy35s8m1kmwRRJrsNuGGf/rHvCBqJcE7yu1BGU7Pk6iG0a?=
 =?us-ascii?Q?p0UTxD2dq4qPIBKkSNZjFeOh28ABujI3fAd/ZQ6sAh1WbrwrXfJU94RddHil?=
 =?us-ascii?Q?qML52bKvYp+9xBrN4OBBdHlKr30Ynu06WS3PXCTqTZygpU3io0pbZL5wUS9R?=
 =?us-ascii?Q?hAzQi2IYkk7jthsZRZsgtjdWHWA294A/D49flKQP+LgoH2hadjnwW2ACoRdX?=
 =?us-ascii?Q?GZUx9BXdpStrUNHuaY5jfRlKX3exru4gLGF9vR67EDdAVxw230y1q6pso9Jp?=
 =?us-ascii?Q?+T18qu1AcrkXBAVMOg0X6m7XIM9YSECQEk+oilrawL24Ya7Ag7EdolFf23YB?=
 =?us-ascii?Q?/KHUZ4nC+gMnkymMiCRppl+AOx1QJffAmJITBxSNWFoweE0jcPK4fXsMZXEZ?=
 =?us-ascii?Q?YkI5KGSgDdnpXzZyv/+YjhW72ymdcY/K7+3GmTJnfTSZrRemwsRNpR/RfVGk?=
 =?us-ascii?Q?cB9EVN+NJ1AT/5T/82soAqXjpwVStR/nJRAx5IR3cWav0XDSKIGxSLxMvIYr?=
 =?us-ascii?Q?zeLhzzFWkcIVqDtc5Ke2m7TP/eAMzqrzJ0ROsMXpot+nPl5n31E50nVBjZ52?=
 =?us-ascii?Q?kCKxH0S1EVooFJQUY8pNyp6PcvdCa1cEm9cvEIpn73Rm+CUFslgMuryM/nqy?=
 =?us-ascii?Q?vxpdiXc0KynGDYaACdJe37EdQ6V2hqbkKiTihi9FET71fZsRnjfABtZ10WZt?=
 =?us-ascii?Q?FPj88Um5eFTrF2whw1nsxyQVXaJb8rOXRFyG3oQ8gGkGCHgzVrGMjFHdIPI/?=
 =?us-ascii?Q?1jSZcJmnL5IV7ttU5sw7gRf/IDS/MecROsbGYniEvaMDMYTrYe4yar94EIAf?=
 =?us-ascii?Q?aYQrNIHxEtYLCuMeciATdUfhEUOlk4uxr4tvRNBz+tdP41xooB24I7pyC/9x?=
 =?us-ascii?Q?ks3wCiEZa1xfxs57bD7L7BfqU9ZiFfmzVrjoHGagor2TRpCrm69+1l0QOejv?=
 =?us-ascii?Q?yS43CJP5gcO3iPNcCven7j63FiuU0K/HkYueO1c/4utkIqaEeodqvAKJMPfe?=
 =?us-ascii?Q?hEMYrnin3P9IEC209qMFBXdsQeWVfB2Yk59/DCRmQ+fw2Tt9fXKhDyD0AN00?=
 =?us-ascii?Q?0D1XZPswRAI36BnQAiqf0iOFk10imLUPdkmhxX880mtQjGoQmB+MnsIgigep?=
 =?us-ascii?Q?TbYc7FxQG6oFDJOenFVFEKOleek0H1v1CQXPGWE/af/3lEawxstHS8gSARE4?=
 =?us-ascii?Q?aP9OyibTSavyxKVs94lg4YxFp7hw8SaQCL9sOUZ1c4FbAQq5mywCRA+D+DCf?=
 =?us-ascii?Q?bZHQctgw6qUkIVT30jpXJO983UnuquiWM57X0aeXy1oxaSXzv2Ihk2VYG/Gk?=
 =?us-ascii?Q?4JhqdRC1F6NRukAc3Tga9nfh2f4V5xiMFJON9EQM/dg7LSJ1e/Dd8s0mT5BK?=
 =?us-ascii?Q?cEfgAaWMfS2EVmCLth596N5rJRgmVaJNVMzS2hUVpeR1CEnLalDw61/kPDWD?=
 =?us-ascii?Q?qjbFN7mjPqb4s3/yB+bRTCLXYfUR5pInSbJQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 05:54:40.2775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d70dc8dc-0819-4344-9181-08dd82f480f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
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

In VM debug mode, it is desirable to notify the application
to correct the freeing sequence by unmapping the memory before
destroying the userptr in the old userptr path. Add a bitmask
to decide whether to send gpu vm fault to the applition.

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843..6a4c75124ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1230,6 +1230,7 @@ struct amdgpu_device {
 	bool                            debug_enable_ras_aca;
 	bool                            debug_exp_resets;
 	bool                            debug_disable_gpu_ring_reset;
+	bool                            debug_vm_userptr;
 
 	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9a1ef343c79..0ea3693a94de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -143,6 +143,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_ENABLE_EXP_RESETS = BIT(5),
 	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
 	AMDGPU_DEBUG_SMU_POOL = BIT(7),
+	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2272,6 +2273,10 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: use vram for smu pool\n");
 		adev->pm.smu_debug_mask |= SMU_DEBUG_POOL_USE_VRAM;
 	}
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_VM_USERPTR) {
+		pr_info("debug: VM mode debug for userptr is enabled\n");
+		adev->debug_vm_userptr = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
-- 
2.25.1

