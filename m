Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C5EC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39F823B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39F823B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA4189B97;
	Fri, 18 Dec 2020 22:30:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDF989A08
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhcoGFGxse09moGr/DbvaQmcn/yOmtpb3fE1ad57zyOZA29YkW24mTCS6nyGi/fSotmlQWV+ae7dZUWYr8FYi3z3JxVZIf5CX30zlTVUgAwGMtQGqtDdYaC6lK2LkoBTlNRw+3KWAP0UuVRfS2nH/x03NS0YO7LFQP8sSzXoB8Ew9eRPbDZVYHDUOzlfrIfj20TMvVrEE6w7xx+BUQ+/YBAZLP+GS1YVCNckQQwYpehqAn+jX+718WTdL2DO+d3C/CSlV+5saHLyte8qiJ2W0dlhe0LuQdXU016x4EF+JGFv40AFWhlOxsidMZgB4aI8w6t3Rf6llwhEBIcslMmffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmoPfOilu8HVcC+80/zLb9pFakHpd30lUIna8C05tz8=;
 b=OlMc6wuzqIe7Iknb2Unj8k5Vn0JQywFgDB2TsF6bPjWnZuK4etS7KvKg5NgLZAB9FuDn+A7y03OS5zIVN+iwPMrZu7xc4VhlXK7T0+JrpJglJwJZ4Imq8wSy9Vf+ccQnLWAql19PfFr0nHIXg62l/D2U9CNL8T0PfIOriNHzf+rSEpQaVwmk0Wa7ZqBQgoUcLN7HJvKpqSC+M1BYcDKpimEHf2rJdBT6NAsegEV7KxfIELbpQ/a2+Ju+JT7qwy9uBIPX4usjfHPueA+7rlOuzPYo0Vmf9/bXSRiBG/YM5MaAMDLkWIJJ//8FR1bn/axFJA+gDOQY7MMAu9K1zJsdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmoPfOilu8HVcC+80/zLb9pFakHpd30lUIna8C05tz8=;
 b=e4W7+SXO+zaSy54GPpjbZQanO1UCY1NmqMP/FPpUjp2gLyjNFWU4MbslNLQDi39MHJp7BMdcNv3QJchrLKQqABoDiYhViUFpGZxBm1SpU4fpBhWI78/egldP45C3eJKISOEpviMfozTGpUARAch+X80Iaf0294p+l9QEUcZg2Ps=
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by SN1PR12MB2589.namprd12.prod.outlook.com (2603:10b6:802:2c::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.25; Fri, 18 Dec
 2020 22:29:58 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::60) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13 via Frontend
 Transport; Fri, 18 Dec 2020 22:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:29:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:56 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:55 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:29:55 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: Update RN/VGH active display count
 workaround
Date: Fri, 18 Dec 2020 17:28:57 -0500
Message-ID: <20201218222904.393785-8-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9efd502-3c8f-421b-99cf-08d8a3a472a5
X-MS-TrafficTypeDiagnostic: SN1PR12MB2589:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25898024435D68F63597FC06F5C30@SN1PR12MB2589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7qPpXFbFEI2DoMZJwB0jnAUI5+DLx5SCcSVsExmoZkwcYjMsiNdzxiCOzzDIkWgkS+Ovnq0Nq2nxnoWJzk9GlINqgUJ5quu/ebukG2KitdWeU8+AOagLCQ/t5jn3OutgM7065va9HZXEGtiCcG6qXtTd3ZkmmSBOVrPPJcTMrWgB/u2tAKo2Td/5fctBybTvbv8S6gj3BLkjF3hN+6K/Uwg90ZTQwcaFDdINgYdou+pk3NleFFvK18II+leiulZLMXcdGH3LQR/71u+gnNWkycyqcIDb+RsiGwr4CvqqywhtsQGZgNn6TeuBfeidW3pfkBb2LsmV31v5v8gKReoTTCJRWWdDfh14FxBMyh3kwfIfuOOG5aEk4XoFTm4rP1Wca5YHS/SdZml0e/lS/jTJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(2906002)(1076003)(83380400001)(86362001)(7696005)(26005)(4326008)(81166007)(336012)(5660300002)(6916009)(2616005)(478600001)(54906003)(70586007)(8936002)(70206006)(186003)(426003)(356005)(36756003)(47076004)(316002)(82310400003)(8676002)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:29:56.5904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9efd502-3c8f-421b-99cf-08d8a3a472a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2589
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Virtual signals were previously counted as a workaround to S0i2 hang
which is fixed on Renoir. This blocks S0i3 diags testing.

[HOW]
Stop counting virtual signals as S0i2 hang is fixed on Renoir.

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c    | 9 +--------
 .../gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c   | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index d00b02553d62..9aa1b63bb161 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -75,15 +75,8 @@ int rn_get_active_display_cnt_wa(
 	for (i = 0; i < dc->link_count; i++) {
 		const struct dc_link *link = dc->links[i];
 
-		/*
-		 * Only notify active stream or virtual stream.
-		 * Need to notify virtual stream to work around
-		 * headless case. HPD does not fire when system is in
-		 * S0i2.
-		 */
 		/* abusing the fact that the dig and phy are coupled to see if the phy is enabled */
-		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL ||
-				link->link_enc->funcs->is_dig_enabled(link->link_enc))
+		if (link->link_enc->funcs->is_dig_enabled(link->link_enc))
 			display_count++;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 9a8e66bba9c0..991b9c5beaa3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -74,15 +74,8 @@ int vg_get_active_display_cnt_wa(
 	for (i = 0; i < dc->link_count; i++) {
 		const struct dc_link *link = dc->links[i];
 
-		/*
-		 * Only notify active stream or virtual stream.
-		 * Need to notify virtual stream to work around
-		 * headless case. HPD does not fire when system is in
-		 * S0i2.
-		 */
 		/* abusing the fact that the dig and phy are coupled to see if the phy is enabled */
-		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL ||
-				link->link_enc->funcs->is_dig_enabled(link->link_enc))
+		if (link->link_enc->funcs->is_dig_enabled(link->link_enc))
 			display_count++;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
