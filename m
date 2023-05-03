Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6477C77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 01:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B91510E17F;
	Wed,  3 May 2023 01:39:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312CD10E17F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 01:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQxkElc76ij9STWY+KTWumk7X1rcrdSRvjP8XLcVbq/9ihVfms+FlorqzhMcS8FJd3+6cMeacmRyfmzF6qfYWjHgxYFWyWODmeDpb5Vw7BiFr5OgdC4xnXG+GEoFvFSn/fEAXRFOXGjoqRo4uVRrZ8kDR99hQkmKvEVxWtwfdPsdrt4M1rZmFPqqfljaKKW0UkGtOgRX7xl5I79KFIlAJuf7UCRv9RhSApi1H0Li9mdpGcge606sifycHrIXmQqenvDapj/o1nfjhbXs1xDLinhNcxmR11aVehf15OCZZ1ehA8QPJncx85/6jg4MDbq9Y6P5e7LPyuqKd0mfRiz/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B38lLG2SZ+Uu2DK1Gx3FnteSCpHExi7R4qJPmsivgZo=;
 b=WZ60xtWkHp8j/obnLG6iEKXvvEt1frflcgeVdKfQfOVII1DP1X9Koynbddw54ScW5tL85DxXiZyUclZ+pv3rG9iy28VQueoMp/gDvTfBnDcuTSKavgU+GJTNjQsHHSsYrXs6aO+I9N7JvgLDboVPMfn+HEko/Ly+cIFvzqtofIAJ5U6Zjhk633y1yr32BnvOVj4onNGyD5IalkHum0Cf4oT1+oRzulanq1W3atLT6ifOjiqfcxLvuVeOFE6o4LTRPmfhphgZqU1i8LmhTN0Rmbfm9/IGkbyEqSQRh4ztv6RzWOuXNoDUUaXvtYzbYOri9V/bIrCA3uqLYKg2fYh9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B38lLG2SZ+Uu2DK1Gx3FnteSCpHExi7R4qJPmsivgZo=;
 b=aCbcbfmm9w6gcs2SIxGtRoFu1+gpLxprk4qCPhptO3/KzKkZq7shGCod66av98p3BYRqyoGJ7ZnqNbu+Lpd6NOrEQH8nfuZ974Sw4D3D9o+glC8p8y0QIM03VHc6bziobQN81pAQ8FEfIG9omLPOiCBS3OSNjiHBdeLTV7WZsJA=
Received: from DM6PR11CA0059.namprd11.prod.outlook.com (2603:10b6:5:14c::36)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.31; Wed, 3 May 2023 01:39:44 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::10) by DM6PR11CA0059.outlook.office365.com
 (2603:10b6:5:14c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Wed, 3 May 2023 01:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Wed, 3 May 2023 01:39:44 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 20:39:41 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amd/display: Add additional pstate registers to HW
 state query
Date: Tue, 2 May 2023 19:38:46 -0600
Message-ID: <20230503013853.2266793-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503013853.2266793-1-alex.hung@amd.com>
References: <20230503013853.2266793-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: f96f7aba-dc60-4694-f43a-08db4b774570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 941MeSbR8DL56Tpvxd7rd70Diy2nz6ukK9M8penWCzLiXNsx99q1/4iNMswAo08toGvCgCsEtjKIsUMPkYk8P9G5FKIUKReQYj5f1dm7iyKFl6CR1tWM/RXuKEFo3Ctdf24V/42AijrYwgiJ6bd7tNJiKKpa95Tvb82sWRNuY/sVeCv0BMMxqJOlTy4cViBX11TBuZGfcYB+t2/sVIRVrPs+hVM5d5DShYo+49ovN57j6+6vh+ZuxWAsGcSQWeZuhL+ueI544hJ48u5zblhNMk2gT2sLSLhHyxk2uGzi7LNBO7M2/ghaUAagkNojxdxhVWwR6RfNHXPqUvUlzG7ZSw/BgWoKddh+/jFwOyBIkdI9HeHJed/QeQbh/9FTBowFxzH/xatUZV6FCuuL5/WE/Spq0Zl1uMnhSRnrAguLv4mdZi7ZuPFGPSXs1wMmG51L4c601nY4eQz64qxBJnHYSAcssSQOWFbauHXIn0HkpIto38CkYDIyVRz356yrRHlvXPyoojL33EtF2Qiy+bRA0jlTduLWFfIjACxeYFItX0jXnjlmLBfQ2lmMyErPMhr6q9Dm1T6r5K1bkJBNSe7RsW6DWAbMw9mRXrn5CJ+77p6yITMFl3BWpGy/JRhZOVEk5USjx4ucUI+rN9cEqPlQdel67SWCZJhuek6imO62/sxpd3Ae2FBiSF9bmHtp/SSvI/IU9EZJP6VMY5JzuKgA6cU8XfbMRFUI3vGyPd44HDY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(81166007)(356005)(478600001)(2906002)(16526019)(186003)(8676002)(8936002)(1076003)(26005)(82740400003)(54906003)(44832011)(2616005)(7696005)(36860700001)(70586007)(70206006)(336012)(40460700003)(82310400005)(40480700001)(86362001)(36756003)(41300700001)(6916009)(426003)(4326008)(316002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:39:44.0341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96f7aba-dc60-4694-f43a-08db4b774570
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Sung Lee <sunglee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sunglee@amd.com>

[WHY]
These registers would be useful to know when debugging pstate issues.

[HOW]
Add additional registers to hw state query.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Sung Lee <sunglee@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c   | 6 ++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h    | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
index 0b17c2993ca5..09784222cc03 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
@@ -690,6 +690,8 @@ struct dcn_hubp_state {
 	uint32_t primary_surface_addr_hi;
 	uint32_t primary_meta_addr_lo;
 	uint32_t primary_meta_addr_hi;
+	uint32_t uclk_pstate_force;
+	uint32_t hubp_cntl;
 };
 
 struct dcn10_hubp {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index 0ddd310cc971..6eebcb22e317 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -628,6 +628,12 @@ void hubbub2_read_state(struct hubbub *hubbub, struct dcn_hubbub_state *hubbub_s
 		REG_WRITE(DCHUBBUB_TEST_DEBUG_INDEX, 0x6);
 		hubbub_state->test_debug_data = REG_READ(DCHUBBUB_TEST_DEBUG_DATA);
 	}
+
+	if (REG(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL))
+		hubbub_state->watermark_change_cntl = REG_READ(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL);
+
+	if (REG(DCHUBBUB_ARB_DRAM_STATE_CNTL))
+		hubbub_state->dram_state_cntl = REG_READ(DCHUBBUB_ARB_DRAM_STATE_CNTL);
 }
 
 static const struct hubbub_funcs hubbub2_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index e46bbe7ddcc9..2861d974fcf6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -449,6 +449,12 @@ void hubp3_read_state(struct hubp *hubp)
 		SWATH_HEIGHT_C, &rq_regs->rq_regs_c.swath_height,
 		PTE_ROW_HEIGHT_LINEAR_C, &rq_regs->rq_regs_c.pte_row_height_linear);
 
+	if (REG(UCLK_PSTATE_FORCE))
+		s->uclk_pstate_force = REG_READ(UCLK_PSTATE_FORCE);
+
+	if (REG(DCHUBP_CNTL))
+		s->hubp_cntl = REG_READ(DCHUBP_CNTL);
+
 }
 
 void hubp3_setup(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index aa80b3f2ca3f..aaa293613846 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -112,6 +112,8 @@ struct dcn_hubbub_state {
 	uint32_t vm_error_pipe;
 	uint32_t vm_error_mode;
 	uint32_t test_debug_data;
+	uint32_t watermark_change_cntl;
+	uint32_t dram_state_cntl;
 };
 
 struct hubbub_funcs {
-- 
2.40.0

