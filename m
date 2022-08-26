Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98995C3DA6B
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9025210EB52;
	Sat, 27 Aug 2022 02:50:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03AD10EB52
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL4VDIbgTrM/Gzf6ZpueKU2MmM+zne+ZyfCwyaSS3sCB9NdtGov49/SV/E5pv8kskqLpubCo/SXUz6r8q1l17+0PI+1ewOk9nGItQm1Ydu6058I5XAN0UdKC1eCBm9JQSoStYoMX/15wE9PEGoLZmtOvlroPsLxPdl1SdQUGvrv/7VJRHtPY3yIv8gcTnkoNSE0cAI9trJ9GuW2teldc5BwMUfxRCLQmN6r+FlizpznW7+iDqa7WulesOr98dPUqV/1W9rcrwvXl9Z9oZlMYFH8IJCfgISPnhkDO4Wao92TEgBywVqmA4ZagOnHdB2KV5L4ozPyOv/QtHNymbo3LPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7SZpYLShHfaise23ft6cm089es4md2GoyDC8ltV188=;
 b=aDFEaORteHxeKOYBA3K8updXfJfFly5CKj+qWutn88H7VZIlXEO56xv29jWljEGbATbBsQm5GporXZF3m5Wzu2DmcmOkHs3g6syLsh4xUExZzcsywLOvbqV0S92izYfdQbltThbV4Htr/p/e/hMGGcQlMKgtCk6V37DFjpvuQA40KGiT5EjOGjKVTuSSzs6F0nWfOzxmXwKDbfwL6nqgdS5EhpHs1ih0uJJi/UTYI/ZjTxShoD5IbdD24AUjsFgy+wK/EaJOv8KPpUMolT98wgjVoel32VSXNrmwCK5cJ32GiJ4zYB4hSKnOwE8S5kEwkOFS2M81J6eznOOMBZGUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7SZpYLShHfaise23ft6cm089es4md2GoyDC8ltV188=;
 b=0516Fye1DtWuuSfWEni+E2NnuRR5pQvVwalXmuQbRg4p2H/8QN69N4GW0D99JWBSoRWd7HqYiGs0sUEmVyCcVCQGp/gBCkOB2X/obXDurE+xAY2szoiKaX2Tnc69CTcUa5+tgvVDawUnX9Ra8Cb/qXz4XCml7VM90ZOnmzP+s2Y=
Received: from CY5PR19CA0028.namprd19.prod.outlook.com (2603:10b6:930:15::24)
 by BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Sat, 27 Aug
 2022 02:50:13 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::41) by CY5PR19CA0028.outlook.office365.com
 (2603:10b6:930:15::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:50:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:12 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:08
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/33] drm/amd/display: Set ODM policy based on number of DSC
 slices
Date: Sat, 27 Aug 2022 06:50:21 +0800
Message-ID: <20220826225053.1435588-2-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11666895-11a0-4926-5f69-08da87d6dd41
X-MS-TrafficTypeDiagnostic: BYAPR12MB3592:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dE539OlwzTcon0k5DAgba71X8E/TMmaRVKpZTKhYYBMP/hlHoMVq2aVncgi2k79IIVYnEOHeGsbYBMjhPU4iG7QvoHODfPjNS0zbJrOCmJt6ZbJnammM1kinrDK6Wrk+HSWSIGTAsTnvPaE8eiBaef46MY5QGY8nk8g3dB/A65M3BhpOIlnD+S4nt7I0beHHYRsXJT1B4e5OHt14FonPSTQHMoFiX79Sj/HtjX+Hfw5kwlXKmq8GpLWM6v7Uh14iouc7paRm/DZcU3T/enfTx/dm+s/juWgrQ7R3Olz7REIEvsNs0ZiNI21NVDYa2yG/7JmSYOgNwZDULHUxTUaN6T7RBUjDwGR/20uY0wS5Gj8L4qZc8cgablrFf68IvLkpNwD3XAvtm7ZQkKV7QbzUGOWUXFIZy+itxBGR+sz1rKNzRmMluhK0ENebk0gZazyJAJ5hm1h1UfvNOJQFSN4CdhBlhwUgEM2F3z8HeLeNuDFbnbj+EsHXXVl3KzVnvUkdshQKw2L7B4Q+ZqLSZ+iqowsyJbDiy5v4lOQ0uLESbnB+11caYjrBC8TtgpbqnU7wt/thfWWFgd05awx7mg64qx+C/eV1YbZpDq/ebU68SrJJffKCQ+9Rg/WEpEFQVPdGZEwL3JY5S8Rkj7/8gP8CrlbcE3r7/UCx6fOC+W6PjqCoF0Fzl/U13GjIQAcB6vqTJCH/KUbD7xriHWr0i16Gvr7vfmQakJ9y6ibbFfsI+WRDIVnJh4NR4BsajuiX7+N92yF4iszlstGm8XEY3xul7XDSqiX6UFAI5gQK36ERhR9HAee5QbNnfY2yiLb2RkP0atRFwCCZ8Pui9xXwqtEFpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(40470700004)(36860700001)(2906002)(6666004)(82310400005)(7696005)(1076003)(186003)(426003)(47076005)(2616005)(40480700001)(26005)(83380400001)(40460700003)(316002)(4326008)(8676002)(70206006)(70586007)(6916009)(54906003)(336012)(81166007)(41300700001)(8936002)(5660300002)(82740400003)(36756003)(86362001)(478600001)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:12.9896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11666895-11a0-4926-5f69-08da87d6dd41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3592
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
Add addtional check in CalculateODMMode for cases where the ODM combine
is needed due to number of DSC slices.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 ++
 .../amd/display/dc/dml/dcn32/display_mode_vba_util_32.c    | 7 +++++--
 .../amd/display/dc/dml/dcn32/display_mode_vba_util_32.h    | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index cb2025771646..f831855db022 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2045,6 +2045,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
 						mode_lib->vba.DISPCLKRampingMargin,
 						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
+						mode_lib->vba.NumberOfDSCSlices[k],
 
 						/* Output */
 						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportNoDSC,
@@ -2066,6 +2067,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading,
 						mode_lib->vba.DISPCLKRampingMargin,
 						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
+						mode_lib->vba.NumberOfDSCSlices[k],
 
 						/* Output */
 						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportDSC,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 05fc14a47fba..6b3c4dbb140b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1193,6 +1193,7 @@ void dml32_CalculateODMMode(
 		double DISPCLKDPPCLKDSCCLKDownSpreading,
 		double DISPCLKRampingMargin,
 		double DISPCLKDPPCLKVCOSpeed,
+		unsigned int NumberOfDSCSlices,
 
 		/* Output */
 		bool *TotalAvailablePipesSupport,
@@ -1228,7 +1229,8 @@ void dml32_CalculateODMMode(
 
 	if (!(Output == dm_hdmi || Output == dm_dp || Output == dm_edp) && (ODMUse == dm_odm_combine_policy_4to1 ||
 			((SurfaceRequiredDISPCLKWithODMCombineTwoToOne > StateDispclk ||
-					(DSCEnable && (HActive > 2 * MaximumPixelsPerLinePerDSCUnit)))))) {
+					(DSCEnable && (HActive > 2 * MaximumPixelsPerLinePerDSCUnit))
+					|| NumberOfDSCSlices > 8)))) {
 		if (TotalNumberOfActiveDPP + 4 <= MaxNumDPP) {
 			*ODMMode = dm_odm_combine_mode_4to1;
 			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineFourToOne;
@@ -1239,7 +1241,8 @@ void dml32_CalculateODMMode(
 	} else if (Output != dm_hdmi && (ODMUse == dm_odm_combine_policy_2to1 ||
 			(((SurfaceRequiredDISPCLKWithoutODMCombine > StateDispclk &&
 					SurfaceRequiredDISPCLKWithODMCombineTwoToOne <= StateDispclk) ||
-					(DSCEnable && (HActive > MaximumPixelsPerLinePerDSCUnit)))))) {
+					(DSCEnable && (HActive > MaximumPixelsPerLinePerDSCUnit))
+					|| (NumberOfDSCSlices <= 8 && NumberOfDSCSlices > 4))))) {
 		if (TotalNumberOfActiveDPP + 2 <= MaxNumDPP) {
 			*ODMMode = dm_odm_combine_mode_2to1;
 			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineTwoToOne;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index d293856ba906..626f6605e2d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -226,6 +226,7 @@ void dml32_CalculateODMMode(
 		double DISPCLKDPPCLKDSCCLKDownSpreading,
 		double DISPCLKRampingMargin,
 		double DISPCLKDPPCLKVCOSpeed,
+		unsigned int NumberOfDSCSlices,
 
 		/* Output */
 		bool *TotalAvailablePipesSupport,
-- 
2.25.1

