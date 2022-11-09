Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87D2C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D220410E590;
	Wed,  9 Nov 2022 06:18:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D9510E590
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3WFtJoKdoVgE85ZDC9cKsup5tYNWW1f7S4wXK81jqRiVP9PbXB6mbFhsYnf7BBCDK4JoQSWBz6pKX8hgsSiMHxw4+9IjbKZ29+W/1k4k2wtlLaHuL8cDUqyvyFtN4LGYm7+b9ZhhjH+4vCXXDX2L8VOqd0yTLmHQV7DLOnJFrsA5c95bMTvwRGAreNKzLjYj7/CSIqHP5XSQz/B4Dg4QVhmkXp69OEW9WDlpg7zhT1P5B31QGQaQqPeGOkv+uABqv4iw7GWcRlW15lN3J6CWwoS8Ylb2jfEeoyZvZOu7dc8al1FgADcQxtvdqYVgY0iqSUOI5B9c04cOQ8GLpK20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBf1l0CGgvXjrX79IZZvEw2BnghVVNZcdeFjRWnR40M=;
 b=B6L1aqqSTc9FT0zMSGsobgm536+FfwlDnb79ejNwUpHDY6Coor5b8SjlA20b00icSAXHesBZbj4XaCzn2fc0UXJfJ9F6Yh0/hWaTAjfdwKw8KbuMiFSPcyVEA6IWNwQyrUVjxpJhf4qn9GWcCcjvGlj2+JyLIHL5npUXAsPN+4rKq1wqIKBDUwbUPMqxuG8lDE3FE4LW0EgeE85z3n6nYKB+TotGbEOEI8/TWVqGVhKX30HFGebpHvSiRP4WT8jdojbG8qTtQmXtZDAO6zsOzxFZdrcD6PsYamtsfD8sAnuCGluNtlgr9Z8/AmWi54fFn5zISYzfsBkOoav3m4/+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBf1l0CGgvXjrX79IZZvEw2BnghVVNZcdeFjRWnR40M=;
 b=3EDRXhTEkKZSr7E/ZwSmWfwR0n4zO4WkTkOg6c+vqFfntnuEnaby54oDDEPMq7ce8s7t9QkmGVGGupdxrVTh1FXStFDt/YarjDINB5OhospnOOtI84jJierUZvZnQPfGX3XtGBpqyNvlKsahydxzx3dKfRyb1ycmlrBr3rjPDqA=
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 06:17:56 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::a1) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:17:55 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:17:53 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:17:48 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/29] drm/amd/display: Set max for prefetch lines on dcn32
Date: Wed, 9 Nov 2022 14:13:15 +0800
Message-ID: <20221109061319.2870943-26-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: e392844e-f26a-4c87-4c11-08dac21a241f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVvO1+9lilY9ByRDFQ8vCAzZn3ja6IYmGN39FB7Plm8zr0fTX5VtxnlW1eeiYq7rL1BSj0blgpKuQYAlmDD8KpPzQ/fZzvm4w9EHiokD5seuaj9gYt/R1/ItxmivjzTtjUoDnj0shyLz0AC/9HsdgQvtD3wvECXFkQpCWkqq9Pelp1mZwFR5+2m1dniOL5MC1QjHaHlW/4SXWQauRZJjDn7MNHL8dyIEukIWi3Oqpg7zNmpD5M17jkqPlMLQRSeLuseFdBJdOiBrtqwdGkHayI8kNnk3B2yB8F2+1jQRWxNzp24DOZ0IJ5hiT3QYmK4xvn5JiXY+BxqaOoF+v924LqiClbzmvNKYd2Diu3BgXzrBsomGCW6b3amE6FzKyfLxO8p/6wyfZX0ztVtIS9a0sU7DZb2D91sPJ3dWb5qMaAok3fhzW0elQQ/LtavKqWKW+QzHal2B9m6pHIALfd7YIvtMrXv5y1OKB79RPO91yL7MqsgnjssufHcWk4QLriH6P6Bt53co3+aDH+7t1bfUOrPoNUllw1VPDoO/RM/tWAKotq/AJKpoefbJWDRLjLz7bL52YStltkCOxcnfdDVPmR9mCN0ulYfscoutpJHd+eFdXo3c4vhBS7qyK2MlSw4nIfs3n/TAKTc7qP8R/59EUxLmntFfCiXsvyFg+foGlMpHC3d5UGACLOqGO3nULSai398KBs3bOVp0WzNLgwAGq3LhkjnRzQaXTvR7Bq/SGZPheXL6/HbdbiqaowLEqFLyBZVS3C7jVAurTWGgOlG8vBJ9y0MccbSy1o0cB0EC7BPMLkgClBwihDHS5+P/rrtygJOc0K1ca//ta6wcaDoBKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(336012)(1076003)(26005)(6666004)(2616005)(186003)(36860700001)(47076005)(426003)(83380400001)(7696005)(2906002)(40480700001)(40460700003)(8676002)(478600001)(316002)(54906003)(82310400005)(41300700001)(5660300002)(8936002)(4326008)(70586007)(6916009)(70206006)(36756003)(81166007)(82740400003)(356005)(86362001)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:17:55.5585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e392844e-f26a-4c87-4c11-08dac21a241f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
Max number of lines that can be used for prefetch due to type constraints is
63.75.

[HOW?]
Enforce maximum prefetch lines as 63.75.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h | 2 ++
 .../amd/display/dc/dml/dcn32/display_mode_vba_util_32.c    | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
index f82e14cd9d8a..c8b28c83ddf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -46,6 +46,8 @@
 // Prefetch schedule max vratio
 #define __DML_MAX_VRATIO_PRE__ 4.0
 
+#define __DML_VBA_MAX_DST_Y_PRE__    63.75
+
 #define BPP_INVALID 0
 #define BPP_BLENDED_PIPE 0xffffffff
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 635fc54338fa..debe46b24a3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3475,7 +3475,6 @@ bool dml32_CalculatePrefetchSchedule(
 	double  min_Lsw;
 	double  Tsw_est1 = 0;
 	double  Tsw_est3 = 0;
-	double  TPreMargin = 0;
 
 	if (v->GPUVMEnable == true && v->HostVMEnable == true)
 		HostVMDynamicLevelsTrips = v->HostVMMaxNonCachedPageTableLevels;
@@ -3669,6 +3668,7 @@ bool dml32_CalculatePrefetchSchedule(
 	dst_y_prefetch_equ = VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime -
 			(*DSTYAfterScaler + (double) *DSTXAfterScaler / (double) myPipe->HTotal);
 
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, __DML_VBA_MAX_DST_Y_PRE__);
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: HTotal = %d\n", __func__, myPipe->HTotal);
 	dml_print("DML::%s: min_Lsw = %f\n", __func__, min_Lsw);
@@ -3701,8 +3701,6 @@ bool dml32_CalculatePrefetchSchedule(
 
 	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
 	Tpre_rounded = dst_y_prefetch_equ * LineTime;
-
-	TPreMargin = Tpre_rounded - TPreReq;
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: dst_y_prefetch_equ: %f (after round)\n", __func__, dst_y_prefetch_equ);
 	dml_print("DML::%s: LineTime: %f\n", __func__, LineTime);
@@ -3730,7 +3728,8 @@ bool dml32_CalculatePrefetchSchedule(
 	*VRatioPrefetchY = 0;
 	*VRatioPrefetchC = 0;
 	*RequiredPrefetchPixDataBWLuma = 0;
-	if (dst_y_prefetch_equ > 1 && TPreMargin > 0.0) {
+	if (dst_y_prefetch_equ > 1 &&
+			(Tpre_rounded >= TPreReq || dst_y_prefetch_equ == __DML_VBA_MAX_DST_Y_PRE__)) {
 		double PrefetchBandwidth1;
 		double PrefetchBandwidth2;
 		double PrefetchBandwidth3;
-- 
2.25.1

