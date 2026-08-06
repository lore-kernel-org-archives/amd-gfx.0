Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2703C56208
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 13:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A49610E306;
	Thu,  6 Aug 2026 13:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Iybk2CU";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010037.outbound.protection.outlook.com
 [52.101.193.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B566610E306
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 13:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR+BxLmtmx6bOw5Wlzhud0X5uCx/QlrjZBP8A2tjcE9WeK6V0PX9SEfKYb6F2IaQrLF8ZDIpLeJMVGKYg7TVkr9PfLcUni0AYAY5MiLHm1txz32XXckTLJHdJdUA/pIlOKfbnbcA64vTP37FWVBWOZy7E/zb20hrjbQDVMAF2jLYTEHf5ejWq19qLR2LDKwVTsGqlCuJuQCJiyg61fpL2mvzng8EnUfc7aPs/82QPfUnC4CDB6ea+pIs8PKHHZCrZczZ/HprXhan0STNQQWMB47yEKPM9sjbcvJJlzyVy1LDbHKK0tc0Y9OokwmRzyhYJ8s72KNFNVkwQOU93tRJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj2+lvZ5pNkBQ+5lzxNeTb5SSaNaMHnH0KbKtvF6o3g=;
 b=ET68HgeboVPdVzydM5v3PujyJKiCyFqiGGaGxhHsPZTOeEc2uM9i9yO1fkOgzzzFsQOPz+xo5LDYbS0Ies8PoMINdjA/TkvGfcSCNkoQ5IF/yWV1L3ZzQHrqRTEhwo5MjJZxJ4HtOnxLHsp5hTAK892fQwKJanSEopCXo45S6zCRi+cvtBjd6vX4Jqmim1VLGLAiUHXPF7xnbqtbPMXNILi61lDke6beISD5weEYnzjWdO4kx4y2kMsyHnY+zCI2sjwFbW+boSFqAgS9MqwN8QVA3vrYHc6nDCTdEzg9af4mOFmr223nLZiumEQCERVTZ+8H33nFpv9gxuzdgyBIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj2+lvZ5pNkBQ+5lzxNeTb5SSaNaMHnH0KbKtvF6o3g=;
 b=5Iybk2CUBTYBmpWV6VhGuTbQuD7kU0UUqIPy7zxEpaoqAVJWAl0J1V5DjNg1DnaQf8+X/4hRSJnuFdXqzBYpY0Co+mQovfmcVB7IQbKap7M52s+JeWwkvOFHP+x8AMgY2RRZ/1OB4mtEJpKO2R6Xmh5k+lrDSPYOE0RzLha0D6k=
Received: from BN9PR03CA0290.namprd03.prod.outlook.com (2603:10b6:408:f5::25)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 13:25:51 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::44) by BN9PR03CA0290.outlook.office365.com
 (2603:10b6:408:f5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Thu, 6
 Aug 2026 13:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 13:25:50 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 6 Aug 2026 08:25:48 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <Lijo.Lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] drm/amdgpu: Enable GFXOFF functionality for SMU IP v15.0.5
Date: Thu, 6 Aug 2026 18:54:38 +0530
Message-ID: <20260806132526.2810055-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 864b61d1-4c6d-473b-4fb9-08def3be3bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: wwTkTEAWurHa14uS+0tzSodw5MoUp84HU5SjJJutNfL9vzrqwUyo1FFpHScNXytLf7azO0xD5I8GeKoE/5ah/pooEbNEX8A3PooEv5RuwMZXSM1NiZj1x4bXTy368N3EM2+XrL/y5QQ08Rql304SLaHUOT+GVT5dYenAE5lBjb0bNnxLgBUNKi7iJjNaTEei4hhu1WMRArd0QKPtdfSjSmsxNuiOX2p4rOdQb4GpHGO+U6RHoK1dxf8Z5hIXxK1TzpVAD6m2AO2IZlnjThv8U87FKt1nXkqbF4HNKevt/crL73fLyxpf6NczglT04XKpSCd3A/rf3uPR0+lnkd0E8ZIRrsfwGlrdNO8S99teWWxdbMvL7Vyl+US0gEKfqvoCyw3ribpb6Uvd12aAucdsFOgaF/zX3LDN5TqNiMRAiu/6tSz4KqarNjM6SIFTjDI/ocu6WdSCWdteJoOiIurl4Aj++JZQ+SyX6mKJRYhxxyanA8mxcUHZ+9HaUmGAqDZlLNJq6GxBFV9ckR47oDfPXeOeh+8wxaQrPvGKVaa+Nkwqk7pQz6l6RIRgSFa/3fXIRCJ8nRl1MNfU+TlZdzNEM4T/VdKhGN8N4IMWz5aflKrBOAvE1ca+GiRyl0Hr59Y60lMChM0PUWEbrAULKxqvsHkEmH0PBUwHHN3RYlcaSerkuGzJ6M1h823bX3DDC/k/uy6vesdX2fX8LXwHhU6p8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mDZSmH9pZQ39sui7vyosEXZR04MmjyOKsNhqRIU5I5RKLeO+woSX+iIi7YcjEagGgmaaZa6f2drb7J1TC7cUBnaTmtAhboXpv3OOSVnZjsRuyoB8lHGzTP/32BXnprZXB91Dck6odVQ8HGQSBZHzFgSEXNKqJnKw5012iXij+76vombuoADm8IJG2q6kGO/8ECISfCxPkx+R674SlO67C73Yse4SxOqyzGd67Uk3EbA4KIhzxyoZylQRnQq0xvp+t0ukH36g1U9KG7bVM/m68NYaouhsOy3p8gOP/ZxJLK5GCq3I2VgyI0bbWm4zzOI5w6BsIlU4LEalCSKHTkkr045kAfIhdfdSsjVPOzstyzpIf51eePaQFqB5ke3L8spnDmiBHHmVvfiTj7Zp1JnzSNM0tpFmIt/md2tM2O8GI8gLiQdl5sforKgtZZjc5swq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 13:25:50.4680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 864b61d1-4c6d-473b-4fb9-08def3be3bc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
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

Add clockgating and powergating flags for GC 11.5.6
and allow/disallow GFXOFF for SMU 15.0.5

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 21 +++++++++++++++++--
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 1f9a9c46377a..5a6c84c802f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -825,8 +825,25 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 		adev->external_rev_id = adev->rev_id + 0x1;
                break;
 	case IP_VERSION(11, 5, 6):
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
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
+		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0xd0;
 		break;
 	case IP_VERSION(11, 7, 0):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 14d0eb296a00..4c0236196de4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -583,6 +583,7 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 5):
 	case IP_VERSION(15, 0, 9):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
-- 
2.43.0

