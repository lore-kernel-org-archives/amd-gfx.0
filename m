Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7836ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025DC10E852;
	Wed, 14 Sep 2022 05:19:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A15710E852
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxzajCURQ55D62ef3GVD0rgBK3oLP+QmZ8uqaquw8nrdEuJN2xxOpGR30jm4avfrZkrtoPK5iUz62PvHaY9vB5pfpV/pcGyqvkqwCjhvkb3l50RAKzzel2EzvBzF98dvQCkzQ3Nq6Y3yd+vd0k7Cufrcpm4tfOeqgyza9cNvd5WBJxwfzicYlUO6GR1VE7z2GZoWacaozBOpv8vMDSL5qBt4xayk56tGUODBNPFGhgEYn3qotDAk5RZfd0F3r0B8SP5lXCNfTZ3OGiHXOf20JHoLEaCItGvd0QMChYLnH+n5wtVw94TtCo1Aswva4mYtjjzckaasbokgbjuFkjZNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYU8b/aNVUh5EWe9Up0KzuK/gQcEsuTKtNGsnq5/D4o=;
 b=N12t58LWejxhiIcoQqtOBVzcAyztHfUvx6cL2LezM3OVEfVyECxPNB6h7QlIAyIHIRzIvjtogRpD+mbQJBQA6JnEcLFanP6BPAs+A0zrKq2L/Svj/qCyD0MFI+d+KwrjWpjSZWtjuUZ6K6CORDD2fvp07mdF0roHoyPd5z1s8nmQsH9bkMvAg2dDrCgQsgtpr7UWBrRAHu5WCxWMRUOZfppGYkxru82T4uH1zlD940M9b1IBuzSANReUJ4Nu7DUVIFnypbnG0Gi1t06a36tjEPGRNJu2lWagNR4KdTitnB0X8i2f3QPsCvB/MwNFE2Ck6Z1qUGSVzPUr2aggQ0Qt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYU8b/aNVUh5EWe9Up0KzuK/gQcEsuTKtNGsnq5/D4o=;
 b=SpvnZE6YoUtBX0y/DLzbQ5HRSP3pqCQC6Nk3k8yIk+R82HRNri04mz/VLNuBQJbkiit5DqZj55Xub9WofnpxsAp6oAWfDy+Dh9pO1E7Tk4EmY5/2bqp1pZ2gfFHBzN5PjSTpt9b/6strv5XsipE9E9pqzP8H+AYEb4v04qWjEjc=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:19:06 +0000
Received: from CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::77) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT083.mail.protection.outlook.com (10.13.174.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:19:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:19:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:19:03 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:18:56 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 43/47] drm/amd/display: update dccg based on HW delta
Date: Wed, 14 Sep 2022 13:10:42 +0800
Message-ID: <20220914051046.1131186-44-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT083:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6d8590-d629-4fc0-25df-08da9610a56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWoMnEDX6rQGmwzF5MeqEHNervCsClFLOIE3AiaC+bCpuF46bmHinoC+WYVfz1g1VK9ew+nOihoKCh9KSgjYEr6EvOrnhYdA5htAJ8vVym/KiodIxQJHji4mtsEMydQ7cq+KLeBxrAI5DJZ29UKojEYjsdi2I7z9szjr8wsa9lR4i6jktRXc4n++JZWVAxt6pYwtRkt9Ey1wzDoHEfYUXEpEd0vfhxRjsIe2GTNMJbtHIV/KAP2jSmrLBU9sdXog2PSnBMTXkKMKOK2drPEAjyz7h69X8IFjJ/8apQIgt4ctgLROJBQVhBWW1cWKDsKTGUv3xprjRjljT0la6jg1jQWPoqy/VNiF//RNIJQ17R80mxartjeojNBXhPkicIJjXwelYQYdQ4EI3BDxNIdS1n0QNlCWTaVWHaNPqvKb3X+KQR5puElEpdcqCbENRLgw+rJ8lO4Tu0ajKBKxprwYSZLJKcGCgz9Ou2yjRGCX26lTg31cGJKYANXjJ2Bi3IcoMlJE9agobtGp2L/aEcv3AFlOFh7zWvlqQ1uQve1PAaRLbXJSyL9m7UlL/AFmz/mxRjjMPgyM2SPINMr4TtRG7rB1KWZr+C38OWlDrHriCy7mpLYlv2/k2uTD6icKyh1EX3NpCUWS/wsOlCtcA9+1nJx+DG+X86kN0z362gJgHeR28MkqsSSHBdztRoxtb5ftLy2i8yrltz2ZLvs/5GsJ5A7G53bUcCVcEb2sHqP4atgC7zGwh9wXcigXdLDPnB+cWcvMH4+pO57amcTGQ5nI+jok/WjGjxtG7FT2JMi06LebjDdeKxHZiUGT+JE1Lhjm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(356005)(26005)(86362001)(47076005)(426003)(8936002)(336012)(478600001)(82740400003)(83380400001)(6916009)(2906002)(1076003)(7696005)(36756003)(186003)(6666004)(5660300002)(70586007)(2616005)(316002)(15650500001)(70206006)(36860700001)(40480700001)(41300700001)(81166007)(40460700003)(82310400005)(54906003)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:19:06.3508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6d8590-d629-4fc0-25df-08da9610a56d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
update hw dccg based on HW delta, and reuse common src code

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  1 +
 .../drm/amd/display/dc/dcn201/dcn201_hwseq.c  |  3 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   | 70 ++++++++++++++-----
 3 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 2b9d3e63191b..915a20461c77 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -274,6 +274,7 @@ struct dccg_registers {
 	uint32_t DSCCLK2_DTO_PARAM;
 	uint32_t DPSTREAMCLK_ROOT_GATE_DISABLE;
 	uint32_t DPSTREAMCLK_GATE_DISABLE;
+	uint32_t DCCG_GATE_DISABLE_CNTL;
 	uint32_t DCCG_GATE_DISABLE_CNTL2;
 	uint32_t DCCG_GATE_DISABLE_CNTL3;
 	uint32_t HDMISTREAMCLK0_DTO_PARAM;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
index 05b3fba9ccce..61bcfa03c4e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
@@ -82,7 +82,7 @@ static bool patch_address_for_sbs_tb_stereo(
 	return false;
 }
 
-static void gpu_addr_to_uma(struct dce_hwseq *hwseq,
+static bool gpu_addr_to_uma(struct dce_hwseq *hwseq,
 		PHYSICAL_ADDRESS_LOC *addr)
 {
 	bool is_in_uma;
@@ -98,6 +98,7 @@ static void gpu_addr_to_uma(struct dce_hwseq *hwseq,
 	} else {
 		is_in_uma = false;
 	}
+	return is_in_uma;
 }
 
 static void plane_address_in_gpu_space_to_uma(struct dce_hwseq *hwseq,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
index 9a4a9efc0203..6a35986307af 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
@@ -63,34 +63,28 @@
 	DCCG_SRII(PHASE, DTBCLK_DTO, 3),\
 	SR(DCCG_AUDIO_DTBCLK_DTO_MODULO),\
 	SR(DCCG_AUDIO_DTBCLK_DTO_PHASE),\
+	SR(DCCG_AUDIO_DTO_SOURCE),\
+	SR(DENTIST_DISPCLK_CNTL),\
+	SR(DSCCLK0_DTO_PARAM),\
+	SR(DSCCLK1_DTO_PARAM),\
+	SR(DSCCLK2_DTO_PARAM),\
+	SR(DSCCLK_DTO_CTRL),\
+	SR(DCCG_GATE_DISABLE_CNTL2),\
+	SR(DCCG_GATE_DISABLE_CNTL3),\
+	SR(HDMISTREAMCLK0_DTO_PARAM),\
 	SR(OTG_PIXEL_RATE_DIV),\
 	SR(DTBCLK_P_CNTL),\
 	SR(DCCG_AUDIO_DTO_SOURCE)
 
-
-#define DCCG_MASK_SH_LIST_DCN314(mask_sh) \
-	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 0, mask_sh),\
+#define DCCG_MASK_SH_LIST_DCN314_COMMON(mask_sh) \
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 0, mask_sh),\
-	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 1, mask_sh),\
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 1, mask_sh),\
-	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 2, mask_sh),\
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 2, mask_sh),\
-	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 3, mask_sh),\
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 3, mask_sh),\
 	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_MODULO, mask_sh),\
 	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_EN, mask_sh),\
 	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_SRC_SEL, mask_sh),\
-	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
-	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_SRC_SEL, mask_sh),\
-	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_EN, mask_sh),\
-	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_SRC_SEL, mask_sh),\
-	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_EN, mask_sh),\
-	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_SRC_SEL, mask_sh),\
-	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_FORCE_EN, mask_sh),\
-	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_FORCE_SRC_SEL, mask_sh),\
-	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_FORCE_EN, mask_sh),\
-	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_FORCE_SRC_SEL, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK0_EN, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK1_EN, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK2_EN, mask_sh),\
@@ -100,7 +94,6 @@
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK2_SRC_SEL, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK3_SRC_SEL, mask_sh),\
 	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_EN, mask_sh),\
-	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_DTO_FORCE_DIS, mask_sh),\
 	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE0_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE1_SRC_SEL, mask_sh),\
@@ -148,7 +141,48 @@
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_SRC_SEL, mask_sh),\
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_EN, mask_sh),\
 	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
-	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh)
+	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_MODE, mask_sh),\
+	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_MODULO, mask_sh),\
+	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_MODULO, mask_sh),\
+	DCCG_SF(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_MODULO, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE2_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_PHASE, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_MODULO, mask_sh)
+
+#define DCCG_MASK_SH_LIST_DCN314(mask_sh) \
+	DCCG_MASK_SH_LIST_DCN314_COMMON(mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 0, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 1, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 2, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 3, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_DTO_FORCE_DIS, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK0_DTO_ENABLE, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_DTO_ENABLE, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_DTO_ENABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_GATE_DISABLE, mask_sh)
 
 struct dccg *dccg314_create(
 	struct dc_context *ctx,
-- 
2.37.3

