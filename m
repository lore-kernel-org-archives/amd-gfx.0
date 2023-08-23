Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4B5EE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83EBE10E441;
	Wed, 23 Aug 2023 15:51:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E13510E43A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXYDOKnRzNKb/ZZa2cYsE3zEJzouXBBzRokFMftzCAGPiSN07Y/0XraAWuU37yqBNQw1ELDRolfR2YL5pqsMrbTA+7gXqU/8J4xbbwlZpTCp2ZCD8HLTHVHf9UMyPbOsI3w72QOWynO6EtNr35i5GKUPaW/luSaV30uoa1c8AJJulrz5MTrGkhpAP6nEB6tRURLrD8PusuGlr6ozUiQ8ztHQXyRbWxRUsmIMdTAeegdX/Hfmv08Vkt5+K1LvbUdP4t/QRfAuEdB1eNzzL80VGzVnde0pW+1E3uYXm5plEqQT60b8vW8j2U99TKvkGfr+3UgoNxdibaXBz4aM2XtbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EUder+fa32qo2lH/S46ApzBiFCEk3sbuRdNJmPD8kc=;
 b=l84v7T/CFDA2gQSMkuBVvLGfBZ3NyOTr9Kpp7SZiICZreNW+nGH8LRaUdX/7l69/HUZp5dVQtTpR4w3CbQTevUeHc6JaYILzFc8maSj1QKcf1indROxX9+/ge34gLAMIHSPoULnfMe0GUf2spQGmRLdY0j3z7l88uJJEWm8KhuV+CxeCHWegBdI07SqxpSaXM149YECzE/cnYBx1HVtv/6yG3WkMVE27QyVrYfPEOPmc1MmXFh4gZPN60TJTaYZVqKcsrMJ7RqPCrpRZNyZlsR3rkn7CEibzAR43qmV0jdH8/lzybmQQJKGC4lcHqUVjiQllBWTajfiF/HHHOL6AnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EUder+fa32qo2lH/S46ApzBiFCEk3sbuRdNJmPD8kc=;
 b=yXzpFhFJIcFSblRgoGYlsfnm/Gf6fuY98Z2G/TPMUhTpwhv1FKK0Nd21JFNiFBzl4BDNtP2bZ0/2isCBHGER3YKQWCP3J1UOCiKxgMx9mZZD7OOxV7bvIjCZNsl43491WCr8kKKrdUH9RdJpMtVW8pjVSX/qaOyDM2P7xCPKJBE=
Received: from DM6PR21CA0008.namprd21.prod.outlook.com (2603:10b6:5:174::18)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:11 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::d0) by DM6PR21CA0008.outlook.office365.com
 (2603:10b6:5:174::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.10 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/35] drm/amd/display: Update DCN31 for DCN35 support
Date: Wed, 23 Aug 2023 11:50:21 -0400
Message-ID: <20230823155048.2526343-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: a09024a7-663e-48b0-586b-08dba3f0c5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JThCzJdegvw6ax7oT3/NKjj0MpKEi2diAz5ZcBy8bzRRO6wmdRBkFg0+REz9uWBYX2D2/V71jV21RQJkOtz7JyPBw2n8TIi1D486IN0MuGjFVCRS8noQFxGpEc+yvKOohVzElw3SBDbLp8ajL2EI9A+8pqWMPeRbu22QwAoqspFtgPRSJpGYIgGcVeufOI4LJsrTo8hT/zp6rZsJtw6Go56ktcX3y3YwAEP2rQGFqQqvwrmM8DxPBjre2/Kv4Odr79LVKls58e7EOX4XNMSWpgJ1IbJLbcbijlLMXebZLhYXC71MQ+1/s6ZsXW4IH5RvdGABtJwMWQxXRwHtLuHGSNMN/QhVsNdb4aLGXgU3fOnnesYYcDodjbP9LUdcRjwgvknnTJYGum+LeVq2bFxoKH9LGtIh1CAOlGpy/pIZ+02UXUbmn+6krtxznjmPhjsUR3ZdVQ5zD5XjK0xxoFqCGCMH6A5cNVKyMPc0LkA1HBxH1nxADNyZSPzPt+Pi6CE4BghiUYkFavTwBFkp9U2z56MERJE6KntgyuaN4H2xerDfU9SqES3vuYE8dYN+F5+Hleat58MUwSYPI4jbP0FA1L43uX5hxEK7DCXRQC4ePAPYKfTeKKpIpUAilDHoaVJ8AVeh8NOTepQGa4GqLdqYcD3DVKUf8Z4xO7zHW65ayVs4tEg8Ue3rXxcpTnAPgcYSc8uK+mRVD+qfWxKavcYJpSxfV0r0pXBxTOCpY3fp3WKd8GgVieMTO4cApB6VVaOMp516+oRI2sDSSseojra+LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(6666004)(40480700001)(8676002)(8936002)(4326008)(478600001)(316002)(6916009)(54906003)(70206006)(70586007)(7696005)(41300700001)(47076005)(81166007)(82740400003)(356005)(36860700001)(426003)(36756003)(26005)(16526019)(83380400001)(336012)(40460700003)(5660300002)(1076003)(2616005)(86362001)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:11.1091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a09024a7-663e-48b0-586b-08dba3f0c5fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Update DCN31 files for DCN35 usage.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h   | 10 ++++++++--
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c      |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h      |  3 +++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
index e324e9b83136..51f5781325e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
@@ -104,7 +104,10 @@ struct dcn31_hpo_dp_link_encoder_registers {
 	uint32_t RDPCSTX_PHY_CNTL6[5];
 };
 
-#define DCN3_1_HPO_DP_LINK_ENC_MASK_SH_LIST(mask_sh)\
+#define DCN3_1_HPO_DP_LINK_ENC_RDPCSTX_MASK_SH_LIST(mask_sh)\
+	SE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh)
+
+#define DCN3_1_HPO_DP_LINK_ENC_COMMON_MASK_SH_LIST(mask_sh)\
 	SE_SF(DP_LINK_ENC0_DP_LINK_ENC_CLOCK_CONTROL, DP_LINK_ENC_CLOCK_EN, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_CONTROL, DPHY_RESET, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_CONTROL, DPHY_ENABLE, mask_sh),\
@@ -126,11 +129,14 @@ struct dcn31_hpo_dp_link_encoder_registers {
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_SQ_PULSE, TP_SQ_PULSE_WIDTH, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_VC0, SAT_STREAM_SOURCE, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_VC0, SAT_SLOT_COUNT, mask_sh),\
-	SE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_VC_RATE_CNTL0, STREAM_VC_RATE_X, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_VC_RATE_CNTL0, STREAM_VC_RATE_Y, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_UPDATE, SAT_UPDATE, mask_sh)
 
+#define DCN3_1_HPO_DP_LINK_ENC_MASK_SH_LIST(mask_sh)\
+	DCN3_1_HPO_DP_LINK_ENC_COMMON_MASK_SH_LIST(mask_sh),\
+	DCN3_1_HPO_DP_LINK_ENC_RDPCSTX_MASK_SH_LIST(mask_sh)\
+
 #define DCN3_1_HPO_DP_LINK_ENC_REG_FIELD_LIST(type) \
 	type DP_LINK_ENC_CLOCK_EN;\
 	type DPHY_RESET;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
index 39a57bcd7866..8394e8c06919 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
@@ -62,6 +62,12 @@ static void hubp31_program_extended_blank(struct hubp *hubp,
 	REG_UPDATE(BLANK_OFFSET_1, MIN_DST_Y_NEXT_START, min_dst_y_next_start_optimized);
 }
 
+void hubp31_program_extended_blank_value(
+	struct hubp *hubp, unsigned int min_dst_y_next_start_optimized)
+{
+	hubp31_program_extended_blank(hubp, min_dst_y_next_start_optimized);
+}
+
 static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h
index c31a7b8f81ee..d688db79b750 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h
@@ -243,4 +243,7 @@ void hubp31_soft_reset(struct hubp *hubp, bool reset);
 
 void hubp31_set_unbounded_requesting(struct hubp *hubp, bool enable);
 
+void hubp31_program_extended_blank_value(
+	struct hubp *hubp, unsigned int min_dst_y_next_start_optimized);
+
 #endif /* __DC_HUBP_DCN31_H__ */
-- 
2.41.0

