Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF39EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F153B10E5AB;
	Thu, 22 Jun 2023 21:58:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7069910E5AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob6JU7NCoarLmfEg9pPlHO4yBWkEJJPrhGEAjIA9iCShU+FFApvCuJYrSHu8cl0J9jQVv6ov2xH2nVbQcciagtLco/AfqjvEXZUVWn+dO86VQH62wBfffDnGwhJQwaGpA52eu/aCt0bZ7QOMRFiU3YqSMmPJdFFJAM+zY8mKdgUKRH53ociuZAba4F3niVSf8DqStEH7hxj1XtkIo/Xwlfg2IfaZYuseYCWTkEqW+57yN498Auo+MnPpHchE2AobRW2XJyxosmelKavoSw8d3rMtGLqftfwYuKhi8cIyIbdGI7oDv5CkkhuualXu1T+rW0vV+xj20gz8AmFrdsRuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMfSODZoxILPVqfi0RS186Z3ONDCgVP5rkZsKxkURiM=;
 b=ZfzzKhMgAzItVSrhC9tvktGSTR57GpNb4W2SmYtSRKmA+TPO/earHk4CNWkTVrOB6QknJZLYOlrKnsRdImYolNcRidTUo6ltiwZm+xlf6P2JaxltesEKIaiE9HRmCPvTRlki97XCqAazpeJT/SBzQmDBa6Ej78ZV3FaimdW1v3LTgqoxTY6FvuwLXzr50MyUSddgySJAHVrL/t9NWhQvEZR//PLzo9YvlooKABsV9e0SwigHWoDjU/IXLyy09dDpekB9iS0ngMZTxcZaeGltFbyActbLC9eC0MGBkwImR1e7e/ybKJNk00BpnUezqp6XTKVA+NlfnSo3uKACFXMzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMfSODZoxILPVqfi0RS186Z3ONDCgVP5rkZsKxkURiM=;
 b=0le9K5MOkoia2j4j/5dWhx9+kZjWnydNS8X1VssCCfvM9cgcJiLp5US5h+5G2vKoepyaZl6ntJuilV1Enos8A+kU0oHnppWRS9qcWx5hBArzTRLTmOiWAq353n86vVqQ6yQVMjvVrkMEWkjfUcx/rJn4PRtJJPg/+2zrm0CxGmc=
Received: from SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::10)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:58:09 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::6c) by SA1P222CA0128.outlook.office365.com
 (2603:10b6:806:3c2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 21:58:09 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amd/display: program DPP shaper and 3D LUT if
 updated
Date: Thu, 22 Jun 2023 15:57:27 -0600
Message-ID: <20230622215735.2026220-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f16daf-65f3-40c5-79f1-08db736bc440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oonOVu5Gu+BTXcQPmRCppNbEM2O2aW1iWKd+tBcCrSjCA+yM8ZjP7HhwGp/K9UuIBPSGOw66cMpe2TfqcL+atqQ6Dncbg+PGWc6VTba+s4BsYGFSj2fiZijYu7pXgtroLjvGtjn86WstTPh8L7udrY4N7z+9GMnGnBUglTtKTycKLIbDKrS5ymIGjB/bWgi2Lpx4ZQ+2OYMs2FPVhEAeyiRqb5cWdGHppxK+F02gGfEejKCK6z53edbVkypk4m3GDHSOTMLCONRm4MHDQWYSbIq62W+B0qVQaQcfUOKmcHhQ/KG4EffzZV/UzN9KPfGjcW5WdDf+rpQLbXiCg7CsHKjVIZgotKFNJQ4DEPhE7FIV3eFsqRoQFrTHPGVo+n1x0XBimZiFRnPffVk4Zapi2zsWjZaOSahprXL3B3+42/gC1MMzwj7FT4pWgixOpccWFUby/GaU+QTOwoPdl20hzyClYJQh/Cy4hrggTuZlsxHGaKuEqNdrSzmyFcX3UjkMVydjQJaUyAYxPg1gqZEIXAIF/pS8Tr3pFAdRQijSnN8+cpiyUbYCg2nX1yFRISo/BD+2xMSbln1W4KqZmYEiy/x19L721nDdjj7iq3UehK/lSgnpdv6lQzU76QNHmV2QlMwMUvEwZ8mVoKFMG/LySCAE62Nb6vbXhXxdfWeUJF6R61zZgWgfBctMuPEUQ5+3k3wcs9Z6dDnvz4lk5pX5FbvIHeEgIzhdbA+6HQpKIzsW27QOptcsGQlqWme2rlnnF7t6GFK1iyYO2qt0hSXpKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(82310400005)(4326008)(70206006)(70586007)(478600001)(6666004)(36756003)(6916009)(54906003)(40460700003)(316002)(86362001)(426003)(83380400001)(336012)(47076005)(1076003)(26005)(16526019)(2616005)(186003)(82740400003)(356005)(81166007)(5660300002)(2906002)(8936002)(15650500001)(41300700001)(36860700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:09.3843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f16daf-65f3-40c5-79f1-08db736bc440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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
Cc: stylon.wang@amd.com, Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Melissa Wen <mwen@igalia.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Melissa Wen <mwen@igalia.com>

If shaper and 3D LUT data updates, lut_3d bit in update_flag is updated
and we need to call set_input_transfer_func to program DPP shaper and 3D
LUTs. Small cleanup of code style in the related if-condition.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index eaf9e9ccad2a..4c8aa3dfb959 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1764,8 +1764,9 @@ static void dcn20_program_pipe(
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
 	if (pipe_ctx->update_flags.bits.enable ||
-			pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
-			pipe_ctx->plane_state->update_flags.bits.gamma_change)
+	    pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
+	    pipe_ctx->plane_state->update_flags.bits.gamma_change ||
+	    pipe_ctx->plane_state->update_flags.bits.lut_3d)
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
-- 
2.39.2

