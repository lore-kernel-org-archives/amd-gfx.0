Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09B7CD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5F410E87D;
	Wed, 10 Jun 2026 09:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t/Uuu2I1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0A310E87D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpxqaoP8+XNabfIMIfzruM/Ttt8oTx6dA1sfAuTB3zr2wixCX69Au88ZVXX8onSJdcsRPoifdLfbQySw0ar3M9H/RxW28A54y/uGd6Dh6KSMNnkb3UsAi9LyPBdr9lbNMfQGmH5+oYEsG2/PBozA5J/QeAigppFra7z4oFwqnXQS2NqILT/q+LnYgKEonr+0k8BwdGponvN79yvzMM3mE1ofqYKDhV2CUnBLnqGfm64ZW9koIMx5iuNpmsFBqepM3j2cnfmWKNtgg1Mj+NqbQzXiCI1Yf+o7RqmV7mjk1Pip6/SHI6ULV3g04EIugBhBHxwTyGrB+EbxEnVOKEERqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i2bGWW415c2i1yr/jDvidRKmzz0QdN2/gt6lvSrKJ8=;
 b=EW5DcvE1Pa5MsbpSagtqgfjT/GwcZxEL8/e6/VTCvwVPQHHiaSlnpmob6LZEmq2vZgweJ+alAvgGwS95zjpR5ANQ94EFW6mX3CH393jNsc6RqejeVm78H+50dB/LwWAPRdJ+7s/utrTfB47u00rJkaz0crujJURIeJuMlHg7mZeQwTq65nLO5vcFHhRobPe1kzKseE00L0VFQ9mMlFYnsOdD5P3qX4tGHzgV91PmzbLXIp+mE6XjTyx0FXeDXnaC3LT1B/R8oUq2xzWpk+jOGJatwCePmfUE6HesXFRGFCNt6cPrR0u0oNg0cdzCk6qol0TihPtutXdZAlQ9yfO4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i2bGWW415c2i1yr/jDvidRKmzz0QdN2/gt6lvSrKJ8=;
 b=t/Uuu2I1rrLWcE9NrndBvc6kJHhWi5hx+qtTqZXx5y2xADWdA6PLOFoey5qnKXkAEAjaqftD/3z6jp33fd8R9ig2AJ0Y2/vQR52zYoApLoXTwpnszL99HsqA0xvKg8iHSUnSVgUC8AO9peczba/6YEvr+6ynzl1FK1KBPDJgVvk=
Received: from BL1PR13CA0340.namprd13.prod.outlook.com (2603:10b6:208:2c6::15)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Wed, 10 Jun 2026
 09:49:56 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::d) by BL1PR13CA0340.outlook.office365.com
 (2603:10b6:208:2c6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 09:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:49:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:49:55 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:49:46 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Robin Chen <robin.chen@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 13/32] drm/amd/display: Add PSR Active VTotal Control
 capability
Date: Wed, 10 Jun 2026 17:44:57 +0800
Message-ID: <20260610094639.1965367-14-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: aea41f51-abce-4f85-c0b0-08dec6d5a0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gFoI3xcGkgaGGahV4zZZNc1gMYBzPQ/eW8N3BjqBIv/tVmwqc40UbQmrPaXoQWxWRRONI8Ve/yrK9Kbmiln+xt4GpLWe5Jjyu8A1UeqYdHSP+0X2IXqefQsoeFs1NG+Sb1+HLM5ePypbuNKBxlHopQcK9x2MRl9lIvPN66ualQ9Roqv0SuPUFlCrhdIuCDSuQMn/Nma1h5LXAy7mGbxFacA5HHHPYVv2x8maJRTAdAbAAiI+cJBm3d5PM3s/axBOI8blREv/Qb866fA52Thm0Z3w7s9Xnz+KvYcbMNwhgKfYkxJH+dEDfRLHILgkvPNe9V2mgK091+nS+nT3Kr1UIrWznBpTOen/68/fCYuPsjLOiJ6De9vto4P7nNpLOc35GHbM1U9KQCj4yrIDLcI4Q7I6vQ7Uzmd3S7A6tcSrTUEa4sA+24aK94jpvq2QnYORSUoM8PIgpvlPlGbhK8SOJxfzvQ4KZT5xM/S1H+8UMye+Y1Aancn3lZSY4nFZwt59VTDWQi1gfitOBwIvFe5pPGg5qY+gqnmX3UzLd7Qba0Vt0pHt83pP0RuSAM9Oq+BhVD4+x5AYL8DyE4f1s7lZhbiRimlRTxDDMsoO2uNKkBZ6oLPc+8SEPkI9AJvKc3c44RLGSRV3WycdVF/PpxzA88xZAeRFVpCyzD4jLchplpWI3gqdcwaObnNnbn5q4FZBRWMD2BPxTuxym7Cy37cd73VNK0jof10nDSN1cOQpR2o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: slpplq0wSc6ocioaFb5Xt5Pe2RQ52a5uO5skbxtWeHP/CUx1FDpqcmmaDNnTPqanEe7VHQaly1isNp/ykuFXqtEQSVXEjkcy/TqkJMoibIAGYhrJJJ5m36PvvcZGcQ9xFCbf2AMF7wAmWd12vaDUPAvY5Z7819O7TLphEXPiuiFc9LbvxoM1NLwABZzhbMwcsIVGdLOjna3XQo1i7xfl71ZJqwctWn4fB5VGPcEeJt6WnkB+iUHx6LnGNXqM14gTdPPM/z0pM7YHhIC/OwNgBnncB6sz1EDCGU/jovocGu+LPTLXUkEcYV1KtlHBVJDAPp0MMdRV8KB6W8IArZckEzvMfLOUXMGv2H7aufkBcbRdrRhtdVHoFUbqptMYzVLYM7pNWL1uH79F7g0Agh4iTOjj2b+WNhiHYYKX4V45ZEqOTQoEmVjDSFMSNbNcaPhU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:49:56.0144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea41f51-abce-4f85-c0b0-08dec6d5a0c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
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

From: Robin Chen <robin.chen@amd.com>

[WHY]
The PSRSU-RC capability should be populated in DC during edp detection.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                | 1 +
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 +++++-
 drivers/gpu/drm/amd/display/include/ddc_service_types.h     | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index fbef0dc743ff..d0ba9ad67a3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1146,6 +1146,7 @@ struct edp_psr_info {
 	union edp_psr_dpcd_caps psr_dpcd_caps;
 	uint8_t psr2_su_y_granularity_cap;
 	uint8_t force_psrsu_cap;
+	uint8_t psr_active_vtotal_control_cap;
 };
 
 struct replay_info {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 47abb4066709..d47aefecfc2d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2242,10 +2242,14 @@ void detect_edp_sink_caps(struct dc_link *link)
 	/*
 	 * ALPM is only valid for eDP v1.4 or higher.
 	 */
-	if (link->dpcd_caps.dpcd_rev.raw >= DP_EDP_14)
+	if (link->dpcd_caps.dpcd_rev.raw >= DP_EDP_14) {
 		core_link_read_dpcd(link, DP_RECEIVER_ALPM_CAP,
 			&link->dpcd_caps.alpm_caps.raw,
 			sizeof(link->dpcd_caps.alpm_caps.raw));
+		core_link_read_dpcd(link, DP_SINK_PSR_ACTIVE_VTOTAL_CONTROL_CAP,
+			&link->dpcd_caps.psr_info.psr_active_vtotal_control_cap,
+			sizeof(link->dpcd_caps.psr_info.psr_active_vtotal_control_cap));
+	}
 
 	/*
 	 * Read REPLAY info
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 53210e3aa0e0..827e9bd7c5cf 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -45,6 +45,7 @@
 #define DP_DEVICE_ID_BA4159 0xBA4159
 #define DP_FORCE_PSRSU_CAPABILITY 0x40F
 
+#define DP_SINK_PSR_ACTIVE_VTOTAL_CONTROL_CAP	0x370
 #define DP_SINK_PSR_ACTIVE_VTOTAL		0x373
 #define DP_SINK_PSR_ACTIVE_VTOTAL_CONTROL_MODE	0x375
 #define DP_SOURCE_PSR_ACTIVE_VTOTAL		0x376
-- 
2.43.0

