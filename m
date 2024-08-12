Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD8FC52D7B
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 03:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182D010E09F;
	Mon, 12 Aug 2024 03:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HuizTfY6";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DB110E095
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 03:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIktdwVuFqeIznk42FGwq9qK9WVKFBWyIKifcW32GJ/YjmtXFnmr9U4yEQ0YWt8XdgXCj0gRjyzdaAfjKNCWhvBd8m8Kv2veCDDCOvVmHX1ysjqMTLWnVYa0Vloz1tRI4DtOJtSe96Daqy1EqKF2scMqwShvdPYHpZNVjDKvbYtfpRJP8ild+ulzMB1CX2um353GOfNK8SIQvsM7XNtD5PfmxJdMWQc0VU4/DRVjHqQ7x2Lv31voVPfRxjtLXTXjcU/9XRSmzg8Kwxbl7q+GjUwKtASIxcivQOo2HsCBy1QToGrAxU9rSOdlk3klf8n933gTEWLndZfEqh/IuwXJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMH7rNuN1B+m/HoO+bJlNHhv0Z+DXIyc1q17NHOHPtY=;
 b=gp6Gnwff1qVSomg0Ucx/Fd0NNBC1znmBCGvn8WWeKPqFIbRcpfhAiquNitXCTDZEKXgej0ecroOWLieQq7zt2uFWLe3/zU9u4Y42p1UDcQIMFyDxcfZB8B5inE5zGUtCOhcjpj0XKUuxcWnegzcBibzh05ZRbubL6W2SZIWpDibzhooVoHuYAfte1+DITsIHnxzPHYdrVSQ+GRQQt0BdGwAuyY2bVweu/+hoYs3xUbzu3EWuBwdCxP0TyFMBG5HNY9n2tsQfFtsbiOZn5VgtTUKDJkHork6EVrWJPMJvZPzOpe8ncJhPCT60vg42oW9o5IJSUFsbSjQAsJfZAtb9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMH7rNuN1B+m/HoO+bJlNHhv0Z+DXIyc1q17NHOHPtY=;
 b=HuizTfY6v+jqjy6p5s3V7uQxi1Q8fU0fmgm0YsroT2+11aF7nJpY4lbh+NHEhSteTuCRBR/FRKvBo+dA3l0we7FBVLM/qj69UjhiAjYJ00LIZIU6eTZjxzcFkFFvtH2LZrvc4y/0F0qaqxKUcTvjeI83zE8hUFqLH9Re4cBdTo0=
Received: from SJ0PR13CA0237.namprd13.prod.outlook.com (2603:10b6:a03:2c1::32)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 03:25:51 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::61) by SJ0PR13CA0237.outlook.office365.com
 (2603:10b6:a03:2c1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Mon, 12 Aug 2024 03:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Mon, 12 Aug 2024 03:25:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 Aug
 2024 22:25:49 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Sun, 11 Aug 2024 22:25:48
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poison
 recovery
Date: Mon, 12 Aug 2024 11:25:46 +0800
Message-ID: <20240812032546.8006-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b51488a-e185-42e1-39b5-08dcba7e76fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MEbcgKRJx4YHOS201B0s9x/8EunZRJm/oA5QOhnfQ2PsbkWnN7xxDhSdZ3ZH?=
 =?us-ascii?Q?c2wq63lPKK+Q0LjpE2qqi4PaoF4OaLkhigh/K207WF8wg7wVBkaDLRavyex8?=
 =?us-ascii?Q?lK6gA5JMKIjSVRTRIbqP6ytm5hZ0L1tRwhxhdpyGiyP25EGpOgFFoRQSR6oy?=
 =?us-ascii?Q?Kt4p5kPl1QkgRQ/S37yZV8vBWKqLwvH56xa1+zffK95LcDsFk5aBz8DkeG7M?=
 =?us-ascii?Q?RoB/H0OQtDbYgB4J2wiaRHsbHReYIleU2CH7npA9m8cfn0VaFhwNxQwFoMa2?=
 =?us-ascii?Q?qG9XGzKJyJxtKYix90skc0nb49DwittV5YsdPRnFHMEQXRvNN/hMG5avSYXU?=
 =?us-ascii?Q?i8oaI+B0x1PvKoUE98bGrHUR7L9sGV/TF2A+zsIrDVksFCp/FfXsSqzK6tTI?=
 =?us-ascii?Q?X2T4P4/C1WUHe5Am8LxNcPMEEiCLBYjCeiHjq8jnyAf/554WN6ABu/nh93fl?=
 =?us-ascii?Q?gkhH7Xeqi6SDc3P+OmENKNYWGUm3B+3ITSbgycfjVySVaii93lO7EUmBYdid?=
 =?us-ascii?Q?bI+Lyj6bhaUorpAMVtOuckw8ACSu3Hi4J96lHGRWjJ0XbapKa1FroiV0T0en?=
 =?us-ascii?Q?4RL4CPd2aNelTO08i442LME5wRK7i+j6QEQvCDXq+GJgR+JTXXHlVDyXcstv?=
 =?us-ascii?Q?5wTXMpTkWe0fNktKKHf7o8HupoTi4NEnKd+wWTQRJBAyBuftFwLl7Muwh56N?=
 =?us-ascii?Q?YtDLd8arj5LGtrA6/jayN/uDFfMirF1qyfb8qv8gx+w8qzkQQPZG80miFZVU?=
 =?us-ascii?Q?ejTMKPuopibevMmiVsN2J+BM+iZm++y12eWGolnUwXK3G894qVeNWAqWi28g?=
 =?us-ascii?Q?Y3SyuHs07SVcFyazL8xPUdv3BRa40+CtUpElwl8k0ycUrFjbAXSsTLzvTsv3?=
 =?us-ascii?Q?FVYgnpK4rK1Ra8CdMqmG0DLXeIZUZx+RI+GdSKXqzkD+6zpRDvWdhmgrnptu?=
 =?us-ascii?Q?Sfh/y2aXD0f4BoEYPgAr9z+0u9stcqAhmaFwZZnolG+Ynv7W2x0DTNLUanhd?=
 =?us-ascii?Q?ZwM1+H11K84HFdE80xt4EAHWnR2jFAzEYUnn7Bche/1QAWfMOBgX+p0y387T?=
 =?us-ascii?Q?zYjhGrcZyyVqnSslHuXlN0wFAz05+zgaHuSShwPWbG9SX7KKNDS8nIou41+k?=
 =?us-ascii?Q?0Uzef/m7GhLKlXYTpR6ld4miewoDPOK5jTNXUg27w2lQckDyaPQpCeZo4Ffz?=
 =?us-ascii?Q?fcnniR6Du5IjuSgD6KvDvCtA+TCrhdkNLkQhSzotjocWR9uK/MMKDK7SUahX?=
 =?us-ascii?Q?bXQyDx224lmOONSWIqCW6gPBKbw4GoXAYLVEURVUrg2N1GG/ibP1GcjsOeTn?=
 =?us-ascii?Q?bbfYbZZl9dJAd5umqI3O+avQElUyVdK7TUPFbBufU0w68z5SDukE+BtuamEE?=
 =?us-ascii?Q?4dUBzwrfycmD8pgKpDQMMSNAPC9KQO/j0ncyw56UmBSio/RYzg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 03:25:50.3067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b51488a-e185-42e1-39b5-08dcba7e76fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823
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

Add debug option to enable mode2 for poison recovery
for testing purpose only.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h             |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 16 ++++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e6b641cb362a..c34819f947ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1201,6 +1201,7 @@ struct amdgpu_device {
 	bool                            debug_disable_soft_recovery;
 	bool                            debug_use_vram_fw_buf;
 	bool                            debug_enable_ras_aca;
+	bool				debug_mode2_for_poison_recovery;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index afe3b8bd35a1..be6b920933d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -133,6 +133,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
 	AMDGPU_DEBUG_USE_VRAM_FW_BUF = BIT(3),
 	AMDGPU_DEBUG_ENABLE_RAS_ACA = BIT(4),
+	AMDGPU_DEBUG_MODE2_FOR_POISON_RECOVERY = BIT(5),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2229,6 +2230,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: enable RAS ACA\n");
 		adev->debug_enable_ras_aca = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_MODE2_FOR_POISON_RECOVERY) {
+		pr_info("debug: enable mode2 reset for poison consumption recovery");
+		adev->debug_mode2_for_poison_recovery = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 816800555f7f..a355b2bc2214 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -164,10 +164,12 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
 		block = AMDGPU_RAS_BLOCK__GFX;
-		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
-			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
-		else
+		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
+			reset = ((dev->adev->debug_mode2_for_poison_recovery) ?
+				 AMDGPU_RAS_GPU_RESET_MODE2_RESET : AMDGPU_RAS_GPU_RESET_MODE1_RESET);
+		} else {
 			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		}
 		break;
 	case SOC15_IH_CLIENTID_VMC:
 	case SOC15_IH_CLIENTID_VMC1:
@@ -180,10 +182,12 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
 		block = AMDGPU_RAS_BLOCK__SDMA;
-		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
-			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
-		else
+		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
+			reset = ((dev->adev->debug_mode2_for_poison_recovery) ?
+				 AMDGPU_RAS_GPU_RESET_MODE2_RESET : AMDGPU_RAS_GPU_RESET_MODE1_RESET);
+		} else {
 			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		}
 		break;
 	default:
 		dev_warn(dev->adev->dev,
-- 
2.17.1

