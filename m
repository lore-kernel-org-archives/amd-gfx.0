Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71809CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 09:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D42410E330;
	Fri, 26 Jun 2026 09:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGX2Aq+t";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D728110E330
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 09:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJ50Icr9I93mAshgIjOrs8IvJ98aoj5O4+cfkkkPmN26kQGzrSYQTz3zhHis723rlGRTDCdOSOHokN9z/IWk2DfdxvwBsa0nWUCR0Qw5p8fcI10cHOB3W/DciIBn9/F1xAVyE08XBvy0VkpbfyHvDF89piINHjYgGwo7PNYo52eZvhUM21XqSnvvKXwKm8N5WwfWA+5oscltlbMXAcVMYuVoqZydpS9s0qNRDehWWK8Lta/ot3ptxKMBmJYJQa3/pvO9cmNGGgA7BvWGrf6oZvl9+AnhoxnAFeNC+3MH7IpB2khntafW5r454VrHWkBfQzFWfafU1v16TJxVh4B+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgzVOmCY2/suQZn2AbbJKFCo+Yu3T3QKtpOHACsAPys=;
 b=M4DnW2oMnl6zQiueF2T9rlj3pM80X7Y6gCe/pPr/TIhZnXtfdw0P3t6nQ+k7VaVuKtlOmxjT0D6q9AxCD8Fwq5BNWUGgSrm+PXkHApZ6DTPsaTG7sO1EOd5Apv5tjn8H8HhZqhJQMtPtyLWCc45D0BBB2Cx8iIDmqlBhaunX3yICAr2G4IPU/4PVb3r+TdIYrlUq9OXS88h3F5as27qzR8Oo77S6EMzemZXawpe7vOLZcHYzruUESib6ojkZjqGLjMfRoAF6LS//Ny5o7IUDNvQwKESGzHiG77CeS9YNYRq9qTD/LvGmhLdFdZDlzjeYAclKQgqB//d1wm7IxPvo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgzVOmCY2/suQZn2AbbJKFCo+Yu3T3QKtpOHACsAPys=;
 b=GGX2Aq+tcFlUgmqUnHr+ikjigQ7yQZ570Mzk9MxBH5iau7A7NOxRm41eTdAdCBe6k8w5q3Hj0YK7XMpa/pZWMJAh9cD6iJE2DhWa82LAD8NpR8UGNTvv+obupemxgGVB9o55jh/9oR6R8W5Nk1p0sssNTv/pgRtxdT8h12P2HXQ=
Received: from CY5PR22CA0078.namprd22.prod.outlook.com (2603:10b6:930:80::25)
 by LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Fri, 26 Jun
 2026 09:46:05 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:930:80:cafe::4f) by CY5PR22CA0078.outlook.office365.com
 (2603:10b6:930:80::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Fri,
 26 Jun 2026 09:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 09:46:03 +0000
Received: from granthali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 04:45:58 -0500
From: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>
CC: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add support for GC IP version 11.7.0
Date: Fri, 26 Jun 2026 15:15:40 +0530
Message-ID: <20260626094543.1195245-1-Granthali.VinodkumarDhandar@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9c4a9a-cfbc-4a0d-6469-08ded367bce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Vrtsj7lLAjvkTqwsO0gDPWusnhIDNgpyXw0J342AWrcoz4R3Jd+6pYu1pEKoohwyKkHNa5Yz2QWEg+/FyXWj9H7aic60tKKQqrw0yP7f46eWR1c6NjFiXmnXT/KhwU1RGk96xZ44czc3P/BR73g72QQ9oKpR8urCA4o3fx1NCcXZSpk51x4uOhTWyvJK3N/gwg+Z/J5YC2kPqNz6/qsMZz45xU7y0m1E7Dl1G5i6nTTYH/5fLBJ+VbgttQL6OUR4FYv4VDzTKnU8JZTM9e0uYMLZK54tICCyuowb+rkgNSBYddv6oHn09YhDKr7IGOpRKaKCGz61BtHVuudiQrkeDonihJ6AFXP2j/Dd3Efy2LCUJWkpG92pVlmvrYMI7TYTLxmNzTQlgP0gNoZ+LpZEVxvmqNjoxNvNAQZ9OX3zH7smSSbG2JWKErou1cPk2Qk60omzsJUbu5FR3i05g7gcIHCKpv1H01NZOkAikXVcUbZdfUBjCCoAMoOa6sTUpHw9Wy1ACMLySWuc1i6qOSbRi/+96PUM1HI6bQ0DIPcKahjuaFop4qbqvNKSbTmEvF02d4lBKi5LwkuGGLecwDm2qEJ2TxZxV7xMEf2gQq3ObI+c6Ie3/JHukx8nYEeufvnp4B/O+2FkNI+XB30x5EZZZ2fWOTu1oyqxqhVs8cCUsL6ucd8oUY4iLZn/B1aDIOhowe9JvWik8lsCr4HrkttmYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6ux0Usw5P+DZba+Nwu7JXVqCxT+t5ruZi7vmd47XwSOBkvcx5C/o9KECSgQ/BjirpG6/34FIhO7URDTpylfEYjQx1TnNnHTamp6jJYGnjyZhUyvrX0c2TdXgHOZkqGr9bfk3yUAh0ewGEgqRuWf2x56dGdodikPzLsexEl66sYUE7fIpx+gEuWlm+i1HT9G+Dj/TGYvM/TZ0IqPdcAF0d5PgI13UdvS3aGPU4+9LPY5C7iTDkx6b2bi8Kk+2g3t5JptaqYQckvluEW1UWvJBmZFCaPEK0jgh4ix/YJmMrc1lRQGu7DC5L+AVxpfhB9FutYrMJfWqMULkCpwVLsR8xdch8RWt5Th86v4q2I6dhdtZOr5Bh5dGd2htMyYfK/YDIuzMpKaKD9Qs3SbSkSMOxyQea1zIMQBkH/HXpuaI3VA4rX22TzuhrlaHoktJsVm2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:46:03.7046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9c4a9a-cfbc-4a0d-6469-08ded367bce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097
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

