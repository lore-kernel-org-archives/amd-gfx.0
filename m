Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB28DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7941A10F8DF;
	Tue, 24 May 2022 17:58:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE5510F8DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYU/TE5Qx+vAoZX++F3tM7x6aP3c4mqjnaVBfe9rgtbIKOdLFacq0wFXuxIBtKsMou6RmcCaPHSmAfZFQUf9WVSI3bK7C2/LALyD+mKrun9opbDhTmCmBhsimFrwENsZgaPQNR2ewB3oZq3DDV9f3fNbEkjkfOMqiMkWADyjcgH71d82REg7WXB+oOVDefbcOTeBLQufJNLUEF0AEl3b080AQN5pL1QTcSYFUbXezvR9sPUPutw/J1FK+rtwkz1B8qzHZjkb/xmH5JnlH+itLxJaiZ/uFh6B6n1fJwng9nqihOF6NZLzHuXdjRcr44Najlf0z2+1EK/FvqJmvepqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdX4aLKo2Vasn3pUHJeqvFgn6ckRQ0VCu0EVnkcMA44=;
 b=PEDkcjvYrMKhrXg41/UKYW3o76uRyqsX77kXDNQtGMKJAPasGxNm5/jemxqmj6br/28T93u7KGVWEOYCKpm8QpicTZsAaq6vmqtrg7EmUav6e9JNqjsxMZm4ST9OnkQrUBIyMbx0ForQtp7C0dO7qo2LSbf4Am9Wff0ZeaMZim58EoMGwKOBIpuzGzWmky1TMnx6q47GM6qN6PBrZm6N4YBvi/SlKAQ1wt8/L0N4Z04kmlbe4UoTGhT2ufOjlDzySDXKYpRHZ409MXr6cwXMY1JYklhdL4TXsoQ7Q/ilRZwDNvY3U4RnYx5wspux1ao30W8SDJUZmkocK2zVAwxkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdX4aLKo2Vasn3pUHJeqvFgn6ckRQ0VCu0EVnkcMA44=;
 b=anGORgVUyPl5xj9zt8VRnjirvENnfNxNR0LBNYz8Pw6DHLQEqSY96IDyrcPJssbr7naYTRSZok+v6NLi94nZLmYA0qdK4L/mAdGz8Gnc/HHsnNG7AhkHs3YKWKTSLw6qrytARytVd/+o5QVK7/p9JHHmG+qmFbMejY6DIQjPsak=
Received: from BN9P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::17)
 by BYAPR12MB3543.namprd12.prod.outlook.com (2603:10b6:a03:130::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 17:58:00 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::2a) by BN9P220CA0012.outlook.office365.com
 (2603:10b6:408:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Tue, 24 May 2022 17:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:58:00 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:57:57 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amd/display: Don't clear ref_dtbclk value
Date: Tue, 24 May 2022 13:57:21 -0400
Message-ID: <20220524175724.126380-6-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524175724.126380-1-jdhillon@amd.com>
References: <20220524175724.126380-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2d6b1d1-8fcb-4b70-fd38-08da3daef0f8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3543:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3543679B115B36DED1A3F3A6FBD79@BYAPR12MB3543.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BryCMZ94pvzn7rfHmAWvnOKujLRa6RwRkQ95BMgAlAvS8K2Do4Jib2comdOVFyep+MCv1/swQyIRyBwgIM61AUp+s5RzzSVFRmeySLKWM/oWz5bxjo90iJCD+TujiptQGgJjLRyJyq1PCH1p69N+E499Bz8ZWA8pnnzthBOsIG/74XAyarFF4zty6y7n/FGHg69SCVOCOP7AyB5H/kjB+qLnftnEwrWxCjmGzQQ/OxZgoDhnV8KYs7enXkDz/y+kyArWRkr9OkWE4FhbzXW8B/PbfU/k4LsJG5Ssdl57xttlineU3Nvf8Xg4leE6BFpEJ+6twEazYI/73QGQNS0EHSOfDCAVd93Pe0E5zeQDzgpPdpzNvEAxE0HkS0nL9lRb6keNro0Gr48ylxnRyvnaSM0tM+d5LnI5NjzXBFD3nTvGmQCjaQLk/yPl9BvUG0sk23dpcq+aGNz2EQtB8lfj9HP/LlBLTVUVzuFzO+vRhfRr/WyFbdwfuiUCxR5eJuMDDebtB9KKNojOTYmiZWY1/Uk+T5LSTSfhSECFszpFaDIA3jaVGseDwMuhcnhZIZZ4CqRk5Fc0OJrMx5hsqSyoDqHYfNkUpZCI2vJZr4A/M8C2u3OtuADaVgCeaqgmJoPoFZDM83QboA/vH0greGXoMTHVlBVxxjZs11TlkrG2RWQDM6REdIoDPkyTr+9vRSGeUYX8WQPVzp2J0k8O0sKEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(81166007)(356005)(508600001)(26005)(36756003)(5660300002)(2906002)(8936002)(6666004)(47076005)(316002)(4326008)(8676002)(54906003)(6916009)(36860700001)(40460700003)(83380400001)(186003)(70586007)(70206006)(16526019)(2616005)(82310400005)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:58:00.2174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d6b1d1-8fcb-4b70-fd38-08da3daef0f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3543
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin <Alvin.Lee2@amd.com>

[Description]
ref_dtbclk value is assigned in clk_mgr_construct,
but the clks struct is cleared in init_clocks.
Make sure to restore the value or we will get
0 value for ref_dtbclk in DCN31.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c            | 3 ---
 drivers/gpu/drm/amd/display/include/ddc_service_types.h      | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 7310482b2784..6a81c1aea0be 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -287,8 +287,11 @@ static void dcn31_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 
 void dcn31_init_clocks(struct clk_mgr *clk_mgr)
 {
+	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
+
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 	// Assumption is that boot state always supports pstate
+	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
 	clk_mgr->clks.p_state_change_support = true;
 	clk_mgr->clks.prev_p_state_change_support = true;
 	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 0eb89e117a6a..bbc58d167c63 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -572,9 +572,6 @@ static void dccg31_set_dtbclk_dto(
 				PIPE_DTO_SRC_SEL[params->otg_inst], 0,
 				DTBCLK_DTO_DIV[params->otg_inst], dtbdto_div);
 
-		REG_WRITE(DTBCLK_DTO_MODULO[dtbclk_inst], 0);
-		REG_WRITE(DTBCLK_DTO_PHASE[dtbclk_inst], 0);
-
 		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
 		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 73b9e0a87e54..8248e032f0e5 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -127,6 +127,8 @@ struct av_sync_data {
 static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
 static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
 
+static const uint8_t DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
+
 /*MST Dock*/
 static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
 
-- 
2.25.1

