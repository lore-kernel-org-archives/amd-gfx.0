Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF094CDE008
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 09:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A58010F556;
	Fri, 26 Jun 2026 09:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f1HsbbyI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0B410F52B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 09:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De+C2J82WysacqQV2TVzJtmbqJVzkiiCMOu+I8Szhl+6UB8IwRzp8Iq/v7vQoAKInkg41MXjJALy2TwxBFKVlGk0hrEBl7hcO1N8ap33D3uQKthQFJBVW4wr82QoTFSusy2wbyK8ZXR774m2LJUVZsBQi3K5SjSsb7w/EmBBeTkiNW4b1u2FFYskqoAZfJr1Id/qvLxeEylbFq//57diH6du4qejlSwtYtgxKSaDBYihjMoaXn//8ZGYbFpECypRqoPzBhsZeast9Ve+AAmtdH3T9luWWs6WaT74siHeQU8DJ2RUhykGrE3EA2k9Jl2TxlgnxTjrTQFaTEBzF1n89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixWFDnxRvE3SFtFQ8HLfQfRznLU7lk20pwRIut1jtn4=;
 b=plsnwg3Yp3tgGzBmWu7OMzCnEF3s3hY2BMzUq0zmgdDV8KSh3xAzv1Er8BQhjzIgR/FYH/qtTKwMSScHqdfPTOHIvMfRD7ZrVAXkInSPLXBQyQkW34GuI8Ti4HUtgraQEwdNigun9lPzGtNzpqA2MKkkMPUJvr2pzB6T61ETg7N1Lf5fC+4rMBbhoofzIKftmL0mo8nqgx+xyPqR1Su29hS/Hl2T26fuE3WjufoWODap7e7WhXCSwuoqfRN0bHx2bY1eLcQQKgeFGj1URbTdGiWSfNG+sq5gAgK2E3upkFyr7azobBlXp7PMCjXv5PLAsmcRlq1Bm5lhTM6jnguJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixWFDnxRvE3SFtFQ8HLfQfRznLU7lk20pwRIut1jtn4=;
 b=f1HsbbyIAyTTTVtJI6xoR9ymZUTKpFW0xdX3CFAopKfVzNWcT0qAIXuuldGHnwAIPwrdk5cd6VN5a5GLo1Q+nh9hamG2YAixByKntYpivD/i21D+ISTG80H3y0691+4ONspjFUR0qS+guV1Z/YAB0AUX6bcaMZTjxNA4PH6STZc=
Received: from CY5PR22CA0068.namprd22.prod.outlook.com (2603:10b6:930:80::11)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Fri, 26 Jun
 2026 09:46:05 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:930:80:cafe::87) by CY5PR22CA0068.outlook.office365.com
 (2603:10b6:930:80::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 09:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 09:46:05 +0000
Received: from granthali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 04:46:02 -0500
From: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>
CC: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add support for GC IP version 11.7.1
Date: Fri, 26 Jun 2026 15:15:41 +0530
Message-ID: <20260626094543.1195245-2-Granthali.VinodkumarDhandar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626094543.1195245-1-Granthali.VinodkumarDhandar@amd.com>
References: <20260626094543.1195245-1-Granthali.VinodkumarDhandar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a5ed6b-3d9b-4b95-7b81-08ded367bdfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8lTVuQl8cbjC5jABvWJ9qmZne0xrvL4vHW9Ydkw6T/1C4ce+yDBAl0Dsp2wSPUqFBV1xOaigu+WGoPb/hx97IUv3qy4v7JMAgYhkNRW24t0nnebG0svOGCrp2VZZVZ0/kw7gTTmKArvoMJ9+roch3eT47ioLlL18OYf3FzfHF5R1jcHCXUPkM1n0aCyCr2YLdFyn2fQ2MfSyK8uNoYQUpn4L1Uk8D5+8HBe9iqQcfwU4LbokO+OX3CxobV+F39Ssjc2awNOHSiBsFiHVecyKjLWhc6U3rb7laPHECf8iAPbeAHN62mCZa+XpwKlUTxGfqIQf9HZGzFMw4iGGwj8mNdg4CmT0MP49j9ehRfk21JKk5hjtNTzpvfvdIgS/B5YfXZD9YFodhmqlo7XX2WdIpKHQMxaUTomozTtuOnZdFUI9TUBFOZMNbH+7wr0NnR413Aji8EYjBezJmoFeS6EXlm3V7QhJt9MH+djpaRfh/08yFUb/lsUTj9+/0EWBXHLhBWYVv+1XZvC9IqNFyMPUg2+jGH64vmd6ar8hTcRwk5cOYJc3EG4vK9IBPnc0SYyh3HsM8wDKTco82KaUOCToHbm4YEAwnxMOZSl1+HDxkNPVPTjGxv5eL3lhM5MIPzDCzlpbNvJTfadS2p8nogK/j621ivBytvQbbaTRQzEH2+/U/sgIMAA3aVpqQDgsA/boDhwiOlwP1ZMUeFXpjuMlTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZP7r65ge0Vm1C7QAiJj5r88aUQgh3dtpmbwdC7lSwt9UrcRic50u89cZ+PrgDRHKhAzCiBGcvargOX0zHxY3KNF4iAfTs+Ct+feRNf7oan39XiCPIjamA/X87256yioftHnfTKesEMi2tTHby3a9hoTu94savXHIZmiwikvOJWoqiJ1uHsd8pKZsGg23PsdNocP+fW+Gpj62DUse9kzbEII19Yt9Q60Vr1r/DYO0RhoGussnDDrDGalUQT107AT2MgLALpTVfHE8KISFMfRVVHIqW9aMX91LPg0W7cYJkbpc1yc43WOnMYhecaqZ7NJ4YusybWKzjPtDakZRmHneH44MdNFwS91ZSnas8idbttHoOm7yXw7fUzhHczwfY6BTCI+GhPBtm3KtholShN8jCQVN2djSHmBRgeyAeNjvMbnUCVIFmfB/I5nxP00SrEVO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:46:05.5191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a5ed6b-3d9b-4b95-7b81-08ded367bdfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  9 +++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 28 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 ++++
 7 files changed, 51 insertions(+), 1 deletion(-)

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
index 26c02bcb05fa..60e2fb968124 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -137,6 +137,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
 
 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
@@ -1133,6 +1134,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1618,6 +1620,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 2;
@@ -3097,7 +3100,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 6) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0))
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 1))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
@@ -5773,6 +5777,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 	        case IP_VERSION(11, 5, 4):
 		case IP_VERSION(11, 5, 6):
 		case IP_VERSION(11, 7, 0):
+		case IP_VERSION(11, 7, 1):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5814,6 +5819,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 4):
 	case IP_VERSION(11, 5, 6):
 	case IP_VERSION(11, 7, 0):
+	case IP_VERSION(11, 7, 1):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5851,6 +5857,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
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

