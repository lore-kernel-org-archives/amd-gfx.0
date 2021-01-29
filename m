Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D730C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0625B64E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0625B64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1AAA6EC2C;
	Fri, 29 Jan 2021 21:28:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB7C6EC36
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy8A3XQn2rk+A2kgpupMby2BQLWr5yqtyP8MCjbGtYnX1MVawYRwpBSq8tg71zemlFfr9MxRHJBVE4C0jlKcRHeHPxsHCpPm/wwddSiqEqFwJw9s4o+e8PtioUVyW2be3sbVO9iK8JaRQdwNR9BWPs/NtAsuQzzS9gdQLeOsFOGOEI2OPTrrRwUz/sTLLRux7K0KwuHAtKUv02LH13CaA0PC9iDBDny4tyhkEpKO8MgV1famYaPlWftMebjSIxzlOePn5eZ3FTUO1Bv3D3GwgiaxPePa5a1CaaxBHlHex7T7IgIL+Gl5j+cFhRHvfo6ZGmxLLy/0N23sIDNgDrNTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbqDB6lLjmP+w0mR3fMg6hApxUvvrXfUuqxevqAUfZM=;
 b=VIOKZ9JmvwguiClB0Su2Ll/TdTgFVHRNI1a19MyLTXo5MsmHUnugOaVPnZ/dUlGvbXgZ1sxDdDZdYxylXjLS/zemb3xhOsbop6U1qM+D491Bw7n+NoHjtooXPI7hzyVhsGPWjYurlUpHzCS/3yt/tjS93K1Pd8mhKvyiyO5ikg+zg7hYfxBBr1g7Cv9YwhAfi/o8QGCh7fY/+ggR09ouv9PDeshjLY4LqK0lMDF5EeCCdc+ctby/bO5CN78+3LLRyrQp/p0R/rxlaiCTASpx8EyADNHiNrRd4DDnWMCw06pY0jrUHbrQNGHRDyT+YJNH+zvU8A5sZlYe258l/xEJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbqDB6lLjmP+w0mR3fMg6hApxUvvrXfUuqxevqAUfZM=;
 b=n1SojXKTJi1k19BGuPO9eysts5ZaI2rcYpRmF8BNB3pjAuHxMG7zqVLKf2ZhJ1/jaFA9i97MKkBoZxjoeqHdfIUJijQYTELV6Zcv5g7oyyot3aEL+LGvZpl3DotP/byDBuSN+mtiP6mRepYk23crEn6fRJVmbfy8Augb3XTnLms=
Received: from MW4PR03CA0247.namprd03.prod.outlook.com (2603:10b6:303:b4::12)
 by CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 29 Jan
 2021 21:28:40 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::54) by MW4PR03CA0247.outlook.office365.com
 (2603:10b6:303:b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:27 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:27 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:26 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/27] drm/amd/display: Better handling of dummy p-state table
Date: Fri, 29 Jan 2021 16:27:49 -0500
Message-ID: <20210129212752.38865-25-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6ef2269-5eab-4474-ffce-08d8c49cd824
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2550:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB255045FE2826BF7D166D81FBEBB99@CY4PR1201MB2550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGcwo2Y5Sdu5GB8n9MpVn5wVWYsqWb4FWb2LlG1d6qwkicwpLbBShFJqZNYXbNmAEl9DaGAXs/MlqVvMpzeLiUVzuun5NEUCpXDmJagCcKypZGgzEZ80b41kc/uFTSGzx4ANa2JQPfhPFfp/9QOMJzvGtcpcotmaUH3qdqMdr41IabhAsaJH4Znt28Uz57Nl7SRmyURUjgUkd887FymR6PDi7oCN07KlSQySV/iSkkPVMvLc72z1FTtEA8BzJ8rBaknsEJ2DDmEyhQJScDFmU3DH1eq2JElxPGVqYV31qFk3NYKjTS+y9/nllpADpdg1Mj4H2FT0M5wta8R6K9QBGisBe5MOC4/jR6izaTbfdwNPyARbmO2fPvBnTpuxbhU4wFMAiRq1TvBpzByRGZnJzw1DjqmpfM1Z92npF7ROseN9LmU01PTehO9ZLhTwsU4PYNyShg1FNEO87lOSy6+IRpQ3oqRheV0DjYOLs2C0Zn5avRB7jhSXOO/VgpJ+xkoi4cExlePett5pvzo/yxcYM8V5i3eROFYvGPvSo3FILmhma9mYWZuPFrNfzFpb1Twx10dxh95Jleg8oVolWmjYoUmzo5xZNTtFfu8k4a9sTs8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(478600001)(7696005)(2906002)(186003)(36756003)(316002)(81166007)(356005)(54906003)(6666004)(70206006)(86362001)(1076003)(82310400003)(6916009)(82740400003)(426003)(8676002)(8936002)(336012)(2616005)(47076005)(26005)(70586007)(4326008)(83380400001)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:39.1541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ef2269-5eab-4474-ffce-08d8c49cd824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Some scenarios where we use a UCLK frequency in between dummy p-state table
entries result in a p-state hang, due to the table not having a close
enough match, so the default DPM0 latency is used, which can be too long to
support dummy p-state switching in these scenarios.

[How]
 - old: match if current freq is within +- margin of table entry
 - new: find largest table entry that is lower than current freq + margin
   - lower than DPM0 will still use DPM0

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c    | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 22ae6a547cd3..8d0f663489ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2189,17 +2189,15 @@ static noinline void dcn30_calculate_wm_and_dlg_fp(
 		unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
 		unsigned int min_dram_speed_mts_margin = 160;
 
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[0].dummy_pstate_latency_us;
-
 		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_unsupported)
 			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
 
-		for (i = 3; i > 0; i--) {
-			if ((min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts) &&
-					(min_dram_speed_mts - min_dram_speed_mts_margin < dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts))
-				context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
-		}
+		/* find largest table entry that is lower than dram speed, but lower than DPM0 still uses DPM0 */
+		for (i = 3; i > 0; i--)
+			if (min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts)
+				break;
 
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
