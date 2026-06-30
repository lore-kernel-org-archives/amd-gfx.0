Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FA0C43327
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EF410E165;
	Tue, 30 Jun 2026 04:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wew4GNun";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6706610E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjfrMvoJyKJVDVFgQBnExhR11fZajUSlVVKVr80BWblEq21SPFdx75svMBdtkz/suf/U9E7aSYBMNnjUcx4iJyqw8xpbZRZJYXdr9HmFd9lVHmP1TAw+XtPQkMMoYlfcQKXgQNLB47mVzVPqgD0KdPXVF6yIZkxBmt4y8fsXsE09S82dgZwzrJ5mkcdILeNKFbZW3iE0aj0wpQsnW3NzQjaAx98uRg/xrNt0A4v0KHNwtWNY/62fyqEsjnj6lEH91VT7+NWOGqEoX7RhJ/7eenqgmYsnJ5gMGdrwZ5+Z6H7dammfwyQqq3Y9ZKm3ik7whfKZrlWJB3aEf7EoCJ0gpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL+1qpwSvrzF1rGDfTZA3IAo564yhz1MVo1swayM0LU=;
 b=c87XXYmR0k0IOaBzpSO3wb8kkSgkAwwo3ow/RhdRE7BcUmfGdogI+7d2YoIjFHGUe9JK6sUAsdX9Odtwc3nnqEwtVgpA0TaxKAPlcv29TYrXA62NgTzJhUr8WO0f9rshkMoNEv82pNmk/hJemTx9HgOBlGVGt9eAtks6gnqF3TzQPWOCYX0ivgkx2ukj/qBa8bK51UNhsHVZNdC5IY0jko5Di6cSBvxTadRinKJR2RdGKhFIv0GGI9ET+vTmPfutaAY8XkcU9jKj7zk3SCSvOTeZykV3BsOD+e7SYcrxOcpFOonANQL1TLSpWumMs9CfpPFGIls+aG/Wx57mB2XRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL+1qpwSvrzF1rGDfTZA3IAo564yhz1MVo1swayM0LU=;
 b=Wew4GNun3Km3J1N1hgBsfqUMB8i5veAWB+MABm1DM8xGO119RacsbQYvXSfxb+tG0eHy1leeGVBCs7YWecy9PqyGdhGYhLsLZ1RcldW35DAwFItaH0XjY5GfIbTv0CoPSylGoood1CR7o4JgtldnmBcUilZM6v7Fhi2gNaqwA7A=
Received: from CH2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:610:60::17)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:37:19 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::5b) by CH2PR14CA0007.outlook.office365.com
 (2603:10b6:610:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 04:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:37:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:37:18 -0500
Received: from granthali.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 21:37:16 -0700
From: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Pratik.Vishwakarma@amd.com>,
 <Suresh.Guttula@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>, Granthali Vinodkumar Dhandar
 <granthali.vinodkumardhandar@amd.com>
Subject: [PATCH v2 2/5] drm/amdgpu: add support for GC IP version 11.7.1
Date: Tue, 30 Jun 2026 10:06:52 +0530
Message-ID: <20260630043655.1284069-2-Granthali.VinodkumarDhandar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
References: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c23b774-bbc5-4fe9-33b4-08ded66144e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u3e34lBkvFhAdNlC92szfwJvo4IlCySiH6nD56V+Id3ALVGEw/NqnqpsYuDi2lDHRpd49OZnU1XiZFuIGulY+JyJniDNKw9zMN0K50pBPQFPCj7msgdNlrB7hgii6VVAhrbptJHQdjHoNSGU9aXGTrRNFf7s/fex4qzp2QtS5FqBbALyjjj6pnINayLhAjQ8y9OQHP8Rt7tDx+/1+2CIupJDVA4SySbYD98kbgdBhKaFMLDoEsOrLj+VjQuhRW8Nvwbfg+0xFSUjxzn0vfptFHCsFLqpnv384A5b63rRWzyzVqipiAFSAwzJCQoEXp9UCvKl1yGERE13N8lA4QHd6LqUhiH6vaGQipG2aEXT+aGPItjUdy6DyGD7wZ7VMxJQVPHz6xw9CeFF0PLm+7FbjnEi7I7aFpKu6GfyRu3PpGL1j0Op0dJ/OfTWCmC0RuQPHwF3h6Lp6DaDw75aHe9UaMUYY2LcZSmlSZOOJU7klE9lxgin3PUI7j7Hbbkenhpd7iYAeoz6F1alTRIoDEL/nJ17zHRIjNzCTX5C8t/eeVUyVJXCzjqUjlKsMu9iDbt334+eWu2+yYoSbYsBmJzAh7KttTOonhiI3FtGaR+zkMVsuo6gPe9UjWYXR0o2Qw3CL4/iNMhjjER07YWot3mtRDCRXc6VNRPC+yYW9IpybOD9EbMQXw06BldsO7kP/+/uX1auE5GR3b4XAB/0rDUHMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CkY5vMGCRr5V21061UqW/XrAii97R31dcwpByjt/yA9LoQJbNLxXQwr/0RHgTOckdA5U9i13kY2JAQyyvQWAhBxUT7q4Jj6oD1xeGJrkYwI9Oq2OItrr4ocNQ3lHPmSs2zAIiU7fa2jWBk8h3JY+CjsF4m55Y/jnsviLb8nE9JRd4ek5rD57nL32KUMlgl+zekUEScns68NcwsDrFIQcmzL1FX3yAk56D2SCYBrWPaKVFe7PwLP2uM3PgehNbzppuHtMmszDgoD/UqMayInATAocvGEwLlJUeTiTMWRqmXVvogPDLnNJPd38Td6NaVAaC5jNR+CPsKxkql0hmFKXJhM/jwRE0PiCdl/Zm2UItd/I78+zQe0aWmg49RbeouprZRBV24IuDWGRfiEb1Kwk/+dA47q3gzB71uelr96LuOc6UNU0MbpTHumYae7A7btU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:37:18.8718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c23b774-bbc5-4fe9-33b4-08ded66144e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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

Initialize GC IP 11_7_1

Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 28 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 ++++
 10 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 249b2d556bb3..d345bea4f390 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2337,6 +2337,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2399,6 +2400,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2726,6 +2728,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2945,6 +2948,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
@@ -3354,6 +3358,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -3384,6 +3389,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 46b9a477fb42..61c528c5db5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -978,6 +978,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 26c02bcb05fa..64e58cf15c1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -137,6 +137,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
 
 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
@@ -1133,6 +1137,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1618,6 +1623,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 2;
@@ -3097,7 +3103,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 6) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0))
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 1))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
@@ -5773,6 +5780,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 	        case IP_VERSION(11, 5, 4):
 		case IP_VERSION(11, 5, 6):
 		case IP_VERSION(11, 7, 0):
+		case IP_VERSION(11, 7, 1):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5814,6 +5822,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5851,6 +5860,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
 	        break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 8a0a88551461..c40d9c467204 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -607,6 +607,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
 		break;
 	default:
@@ -783,6 +784,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 177d702e612a..05b164f38c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -44,6 +44,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3ee0c9ee262b..73c1525ad289 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -62,6 +62,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
 
 static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 2a8582e87f2b..2a4d91368ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -33,6 +33,8 @@
 
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
 
 static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9b9b13e327d8..1677e88a4e36 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -866,6 +866,34 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0xF;
 		break;
+	case IP_VERSION(11, 7, 1):
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
+		adev->external_rev_id = adev->rev_id + 0x40;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index a6a7888c7a8d..2a239f45fc24 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1716,6 +1716,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 5, 4):
 		case IP_VERSION(11, 5, 6):
 		case IP_VERSION(11, 7, 0):
+		case IP_VERSION(11, 7, 1):
 			/* Cacheline size not available in IP discovery for gc11.
 			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
 			 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bc05ae15c1cc..1c3e8b61d4f8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -170,6 +170,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -456,6 +457,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 110700;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
+		case IP_VERSION(11, 7, 1):
+			gfx_target_version = 110701;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		case IP_VERSION(12, 0, 0):
 			gfx_target_version = 120000;
 			f2g = &gfx_v12_kfd2kgd;
-- 
2.43.0

