Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56671C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49AE10E13F;
	Tue, 30 Jun 2026 04:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5LJjagjV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5943C10E13F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu/5LgZeKXfhathGTkpl7oqomKNuhE4E4ixddXE7qf/dhruJR/E6a84watvYG0otHkdgQfqLv2ecj/jWn6oZCLZQ5+pBMGQpVsWTiWbXXasu7iCE8qopUuus/Drp9gOH1A9LI32k8Kl01+X1RirDotCy2Y6v1JG9OVhCpNu+vboNTZjy0Or/UNcPHsZe7ChpaVi0oVHAaHXkEwVVqQGfmY9+vhFuUc8pQx6yHFmop1Ra4IptA3Xx6/EiNzTpHvsCyCrKEEKh9THVcHupc8Kydkkyr5yA7Y7T87W6gIdvuc/E2Ly64uCHknVbZQUkghGUb+eFjuSr2YFUfuvvPVsrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgzVOmCY2/suQZn2AbbJKFCo+Yu3T3QKtpOHACsAPys=;
 b=ti1wjTVOSfkqe/0Oz5/JtpYd5/JP0+0SPtOrpxxc+fnHEP/jNwgKEokQWs0ubUK+i1hHtuuknYNPoawF/1j+SAcZvOrbDG6bYTH8x3VIwnZuM9wyyKoTSS4fvHdJohUJvQXCbBXWF2NJVUnoZbONI9jHljbJAG8eJswoiKZbzFQ4XsQhmcXmHEzUxIKGkJ8Yo41lbp8tc5ycHisf9q863HCnbjenmHRYpt9pbeIVlSfdqxagQYgz+OGCVOGHvSwWa8O2/h0V8Q3+YyQYKSHK7usqh6+3GVONKqoD5eZpnW0n85txVT6QxpU0c1EcIu7LBy8vsDZ6f9R9O2ikak3bSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgzVOmCY2/suQZn2AbbJKFCo+Yu3T3QKtpOHACsAPys=;
 b=5LJjagjVAyafwieo9kZWLTBC0Dg3EfHQM2j38wb8FTKK5IcXtfbBmh8ZMcMDJeyA/4jAtag3ANY5khHwHTJc1E9q8Qw8bqZFbDMa4xhk6x0RR7WFQwwVW9EmZ/zd3RGSTDtheIYy4c86ekSXgI+E7inrnRgPUJl9+ZxZCh9QkOE=
Received: from CH2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:610:5a::38)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 04:37:15 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::28) by CH2PR08CA0028.outlook.office365.com
 (2603:10b6:610:5a::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 04:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:37:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:37:14 -0500
Received: from granthali.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 21:37:12 -0700
From: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Pratik.Vishwakarma@amd.com>,
 <Suresh.Guttula@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>, Granthali Vinodkumar Dhandar
 <granthali.vinodkumardhandar@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu: add support for GC IP version 11.7.0
Date: Tue, 30 Jun 2026 10:06:51 +0530
Message-ID: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fcd789-f79d-459a-57a9-08ded66142c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: GZCZjY7NBwyNJAGVwAHZGY+N675WWcHu0bdXIy9ep/uzkI+aJ5lRD4di0wKAinZSPqAOod96NB7GO/yMIBAX7PJkh/KWB8rCTwvpoCQYuSqGZWQ4sxcgI8NBHSDtbP3g4/1iRPZ18Nf/MjVf7G/MQ7rhfwsMbL1nx6FxaqMh0EtacPYkOAio1t/JwYEQQczPusEwmE7oZ0qgf+UIfLeXst6XH9iOkToiUeyz8ptqmsZDvva3Ct2l2yDQh3Zz96tRnoSlSWdQAEXyrGB5g2ooBJqaYRu1jd2uiCDsit1nLdQmrLusebVHVoS4l026itl5R78O7dNE7XJ37U3Aib89qKlbxzxCK3VYgbkFxXY8NkLo8npMcMD4gj1OjHN8iJRRgGkA7+QF/3HJBXXqJsITP10oSGmrOHolUpQFF2dJkuc9tGFSbf0rBglL3dxkIFkZspch1DY6UTNX952uXTy8Jd1zxV5JLjk8vh6hIUA0Sq8M4qmF29UNRZv4s5VYAnvzqZFhMEOPRfdHTVw18hN62CGVd7JtvWzq80mCO0bXIVIdf1/v0zab76OR47abmLEOimI2sac3mbbqEoC73ltmFC34DVQslH5y5JHJexr8qGXbSIYNp+j8PQaqQ8nrBXflNa7WvuyP+4bbcXKxYbx5SAoD75u5v0b8JoX36WUYzTvGP2xpZXrsh0EQ61vgxAPyo1khd7HAp/3j6fkhXY2vXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AzOsmbhxadF73N0WqqxIVadf1ZeuHeDHFPz67OXiMKpNefa1fsAFQWzsFqzBC/W3xZKyZCpsh8CpuFwxtwZTOwSE5lTIBn5cDLe5eMhg7HaMAJwWL+aKKFq3Jc+5faxEjyOC9rbCudlCe3nrCWOg1VZ9Rlj7py1PH2SkBxDx138ZeBoEN2bHDdq21NqmjEJsXXucRI2F0OMGv9LuWaqwSyU5VCfn8DhzwClxMuSQZUErgK7oR8DSWdA1wXOGW8VWxvNzecoMPpUV2M1iZb3NSKzgGTBXruDmX9MxdRaIiVbv/zILQ5m9eeX0ai+BpqCVQzoHxPJJpOpJu4YufCM4t/PtLP4mfhdsKHqlLFQbSZXhRiTHlhEQiJocsdRbNozOUNp+tECjMnbv3SseaIV+jGKZRBWAt+0dcbSguVTpV3ftIaCIOzFpE1ppYBOvn5pv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:37:15.2782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fcd789-f79d-459a-57a9-08ded66142c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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

From: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>

Initialize GC IP 11_7_0

Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 28 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 ++++
 9 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a229fe9d043b..249b2d556bb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2336,6 +2336,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2397,6 +2398,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2723,6 +2725,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2941,6 +2944,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
@@ -3349,6 +3353,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -3378,6 +3383,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2b557c9096df..46b9a477fb42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -977,6 +977,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6346f16c4e61..26c02bcb05fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -133,6 +133,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
 
 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
@@ -1128,6 +1132,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1612,6 +1617,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 2;
@@ -3090,7 +3096,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 2) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 6))
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 6) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
@@ -5765,6 +5772,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(11, 5, 3):
 	        case IP_VERSION(11, 5, 4):
 		case IP_VERSION(11, 5, 6):
+		case IP_VERSION(11, 7, 0):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5805,6 +5813,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5841,6 +5850,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
 	        break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 8eb9847d9e1e..8a0a88551461 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -606,6 +606,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
 		break;
 	default:
@@ -781,6 +782,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index f5927c3553ce..177d702e612a 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -43,6 +43,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 9e27d01cbfa3..3ee0c9ee262b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -60,6 +60,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
 
 static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 963659deeaff..9b9b13e327d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -838,6 +838,34 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0xd0;
 		break;
+	case IP_VERSION(11, 7, 0):
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_DS |
+			AMD_CG_SUPPORT_HDP_SD |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG_DPG |
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_GFX_PG;
+		adev->external_rev_id = adev->rev_id + 0xF;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index f28259d13818..a6a7888c7a8d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1715,6 +1715,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 5, 3):
 		case IP_VERSION(11, 5, 4):
 		case IP_VERSION(11, 5, 6):
+		case IP_VERSION(11, 7, 0):
 			/* Cacheline size not available in IP discovery for gc11.
 			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
 			 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 67a17458f4e9..bc05ae15c1cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -169,6 +169,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
+	case IP_VERSION(11, 7, 0):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -451,6 +452,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
                         gfx_target_version = 110504;
                         f2g = &gfx_v11_kfd2kgd;
                         break;
+		case IP_VERSION(11, 7, 0):
+			gfx_target_version = 110700;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		case IP_VERSION(12, 0, 0):
 			gfx_target_version = 120000;
 			f2g = &gfx_v12_kfd2kgd;
-- 
2.43.0

