Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D56ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E9210E820;
	Wed, 14 Sep 2022 03:57:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDB710E81F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aicu0bHHVYaF/zOT8NzOrq1E4qNa2TGZAc+/rxM/iAXiaaQwq0Qg6XhisvHx434/h+A8m3wSwlZz4w3oqO2u7/WDlYbZh+dABF7cAMxRKYpI6nc1KX/qdMVKOwBNVWD36nHKk4BVEOFIFq+yJp+VhDbgVQ1PLaqZINkfnh+ONI6tWhvAW6ShoKh2AFuO/ZnWAwh3wPNX+WRq4wEWT8OkGRv/dLm0AVpcGbaAsNiXRO3ucoTrSLxRJmhyTdgeLr2dLIgnHR9aMs/AaOIJDFyKru/PmhZFeGbpnJ1slxGF5Ub6woddhUPVWSBzoRWgDPXhRebHpGP5Imqtb63sdnw5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYU8b/aNVUh5EWe9Up0KzuK/gQcEsuTKtNGsnq5/D4o=;
 b=VLycbuTS44nVXWUBSr+SkOLDTWsqh4NQZ+/RfEgOs9eXCacvRrIQzJYKcI0Ujad7R/2d4o562Ournz8O40y2yHaoQ3r0CcMQQ1GSG7eSG2xo9ZG4XaztJYOZFliHpx8hhIiiwwp4Jc+g0JE5B8M6ri9pWdwhv2KDR33Ug2rsIwPXkGYb6J3/mAVWYYOsDdv7ni0vv5QU3nLX/p6snXDS0hqA2BwhL7DxVJ4Jb+NS0f21MTFJoXrkXFeRsXCcO9mNAGP+yFqqa6gAp00as0yl663Wz6CIwY4Ckklmhv35l96xTMjxLcbqKbvVeoNNdkI0pspiTo7FewJgbW+7Kkxi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYU8b/aNVUh5EWe9Up0KzuK/gQcEsuTKtNGsnq5/D4o=;
 b=TYdZsgw4GT+hqdtXoylO5HyIrM15POs5RJFiH1v2FiiAwMuSIviINYQBOZXSB2KI/v7g/wUYY8Gpd7c1WAcQypLrXTQWvmwC+tuJJsKWfOTZ9R20U/CFWW6HFftfcCFfSUXIa7dM2UfrSz1RCF3sDd9J1KDRrDkgGa7P4Z6/7dA=
Received: from BN8PR15CA0030.namprd15.prod.outlook.com (2603:10b6:408:c0::43)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:57:19 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::16) by BN8PR15CA0030.outlook.office365.com
 (2603:10b6:408:c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:57:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:57:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:57:16 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:57:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 43/47] drm/amd/display: update dccg based on HW delta
Date: Wed, 14 Sep 2022 11:48:04 +0800
Message-ID: <20220914034808.1093521-44-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fa0f48-bd14-4da1-d05c-08da9605387c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIZtRthnaajLAgD4hb1dPOjv47tdbD2NH7o/tCZBTDdcu82TJSHky5uHc8wM3AE81YGl8jdxH0jYbSExUcjpxQsiRn+9awZ1/MWcEd5r7N/oC2MwG6/CYSwML3wt40K3vDSSHMxgpjAemJ4WuaetvGPx4ZuS1q/v2g7VvoUgENH4yGjDZDRXQ5kbdPmUYdCdj3180mt32JoEU4C4plu3ju1JYJpgxDHuX0GkMdwFcgSGVc435LsEeSoW2ityAt1i3YfhkNNsj6dYQ/2+aZTy2M4FsA+TpLBt6/KvofNexjcImt795f25m1FJttcRTIcISAtnsoOlOPfvQlzQuwEiEmLBKZSSY+7Lg/aeXLDeGKSf0f6UYeIE1fAtqlxyuJwKQwzBeCuATOX+YLm6dUPIJ21d/tm80noZPH/v5z6lNSbqf0SUFxYBFotYnBkUSv5Ll538UibZE9TLGjRjt7DcOuLKPnezdsmOGGZv/xmO/UTBGEb+n65/2ZNiTX+WmDau5sxTh3QoV3bIJsmghDMCi4q5IBL2H4sFRJ3tBFRxhdSdkWrH5qw09yQ+IJmqGpcFQ7qgUV+ryOi+kGsXYDib+0MZORs0u3KhrbR7eiuG3Li5nGEA0r2gRBDoqDZuYef12KZcsy7I5pgj77C1NgNupo8CrRSpsdmwaT0FF8pE3wLj5ojwehuQkifhyPcpHadEm8AQB3o4NF6vop2tPyWBkpo873ACT+qNVWjR1yBlDfCfpAPU7kirMIkjqxCZYzTYyX1n8F3wGzPtr6usROisFHDh447GM2uJkNaztNIFwdCk8+mlk9vbmPEJEvnPRpHl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(54906003)(81166007)(82310400005)(356005)(70206006)(40480700001)(15650500001)(186003)(8676002)(1076003)(478600001)(7696005)(5660300002)(2616005)(47076005)(316002)(82740400003)(4326008)(36756003)(83380400001)(6666004)(26005)(70586007)(6916009)(8936002)(41300700001)(40460700003)(86362001)(336012)(36860700001)(2906002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:57:19.2272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fa0f48-bd14-4da1-d05c-08da9605387c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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

