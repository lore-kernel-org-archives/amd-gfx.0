Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7C7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8527E61250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8527E61250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081BF6E210;
	Fri, 24 Sep 2021 19:10:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E516E20F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq5m4up5tAZevFtqEBlM5RWBn3Lo6HoKMKWoj4IX1xyr0kkb1kVOOZ+pI3txFNK4jcBnR3yJj2KEeDd8hBpVtwYaim6SXiYL+aPIO4RvDSsknPHAtGUezldci5aGJGBQvvOtk1iBEFTOwMipIE3bs7c4jdGJO7jshOAc7U5tjYodz2nNvgLtWrkUWY6TRNAd1tGK6MVN7KROhZl8VV86S9mmasg0xGV2zt9MYMUh564VR/oSBbxPYvcd2qnGNerApIBLAexmNunVeb01Ml6BPKog+oxYunmSROlAvp2fSr8HmaLYNTRd0NoNUDpVqy7aFhi6MC20Loa8czVeXpsUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=4rvc2Lp4moooOusR7glEpX/6vmmluCTNZEAQ4M0E5R8=;
 b=hgFPH2stzKLUfnNcxZk3ztECA1fEH5Vr3I+pyCMGcTvR/KdgVtuf/O+p2CKPRnvW11cCGZsIvsYgVGv9I5NP2hUshhX0WqF3UooXtp769QNF4KcGvX5VCukn7D1dY6BR8nHoy1z/B4sJrNV2NK17k3skaKczKZtUpCQLrUcyi/vyGYAMOXKl62lPxTlfWY7uzoPgK+YNDlRVrkYnX7IOhWPTuUvcft058K3xgzSs9+nc5FVpWppJTCiBpT8YRpxPAJKMIKiZlzRli9nqqiliXPFNNR02LkrunkHSfwsxp/U2Xqtju3w0SOnHf9yjeQt3CkiN4CTwLPag18CjmXyFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rvc2Lp4moooOusR7glEpX/6vmmluCTNZEAQ4M0E5R8=;
 b=LPvV6hr3/mBE7XlILsmKeOiEZwq2tibArWcPeHPv+AvIVx6PtmMoO3e+Mb9LWKa8klNKWBDrY05VWxgpT1IudgmHG7T65UJ+NmXcIBDhHvIIz/TB5/Q37EZ/Ctv/LFMC2vSUX5pquT2baeowf/tDi+1RV4MD46A7BXNWtVxDM5o=
Received: from BN0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:408:141::29)
 by BN8PR12MB2898.namprd12.prod.outlook.com (2603:10b6:408:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 19:09:55 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::87) by BN0PR07CA0027.outlook.office365.com
 (2603:10b6:408:141::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 19:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:09:55 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:09:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:09:54 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:09:52 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, David Galiffi
 <David.Galiffi@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>
Subject: [PATCH 05/24] drm/amd/display: Add debug support to override the
 Minimum DRAM Clock
Date: Fri, 24 Sep 2021 15:09:15 -0400
Message-ID: <20210924190934.1193379-6-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a29112-1b6a-4590-9b98-08d97f8ee507
X-MS-TrafficTypeDiagnostic: BN8PR12MB2898:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2898176D78A1CC7632781099EBA49@BN8PR12MB2898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdcE5R5z7zY8Jc0RqJ2lrhVVFR2I/mRhkf0yk1b4mraT4siA0irWg9y4L15z8Mdd9zWiQboEG9g9IrQyATIaE1e6/YJIyuZkYldj65fx93WFU/TzLy6PVY92lxhO/2Q/AKFgPWBKMVQo6oRVUWXP+X0oKlEA3QK7BblHmZVLR3Pxs7mdBF26gYNlE3Ak5sF9AseaZoosVXAIgxtwKaKys5uxISsfqCJ3MOLHLEqCpoydUfLNKBmHGDwt1zmsrwlwGJbM5CZMKUcnLxuttMRAOsbsQiBVoon1RUFRhgS8wHeBm33Q69RGReWUeTiRgjtR5jf2/eaz1Nq4h5Rs/9Eh/uRurHXw9zMdMhn+MRaW3tz4wwSJxki9BUANI7Cuh86breqtUL3QsOLUancTp0l3wwlDbao5ju9CGRwoiqcNS8Ba48j0x9luIQKahE9mgKokqdUx4G/uDJeOecKGElokLK9R/S4EDEXpTDVtOPiPDg3NbFWnsXmtXNxcbRr9ILs8slmR3LsDZ+bPFpGx4fVhaFJUqHeQic9aDUOG/rggzTdtQBcwkaNXevsdyN1LucXrXf9Y/Oz1qBaZY0OUToYNiXqvHFwiqMZ9ydAfEmI12adxFyjK26oBtewDCs7G/IlvjHpBAQ0cv6/SrC10D3SvKEK1PoRhb+Gj8GSbmy+PxbvtpejrvMQJDyWj/8pMPdsWlwOgGCkJArUOvxHIJiAbkOUG+RZ+5qUUrwzW+hF81+0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(8936002)(7696005)(6916009)(81166007)(1076003)(82310400003)(426003)(54906003)(5660300002)(86362001)(8676002)(4326008)(47076005)(336012)(508600001)(316002)(70206006)(36756003)(2906002)(26005)(83380400001)(6666004)(70586007)(36860700001)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:09:55.3770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a29112-1b6a-4590-9b98-08d97f8ee507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2898
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[Why]
Requested feature to assist with Thermal, Acoustic, Power, and
Performance tuning.

[How]
Add a debug field that will override calculated minimum DRAM clock,
if the debug value is larger than the calculate value.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b194a2727bd8..a46c663ed8c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -565,6 +565,7 @@ struct dc_debug_options {
 	enum wm_report_mode pplib_wm_report_mode;
 	unsigned int min_disp_clk_khz;
 	unsigned int min_dpp_clk_khz;
+	unsigned int min_dram_clk_khz;
 	int sr_exit_time_dpm0_ns;
 	int sr_enter_plus_exit_time_dpm0_ns;
 	int sr_exit_time_ns;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 3c388afa06dc..aeb868ace31c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3117,6 +3117,10 @@ void dcn20_calculate_dlg_params(
 	context->bw_ctx.bw.dcn.clk.dcfclk_khz = context->bw_ctx.dml.vba.DCFCLK * 1000;
 	context->bw_ctx.bw.dcn.clk.socclk_khz = context->bw_ctx.dml.vba.SOCCLK * 1000;
 	context->bw_ctx.bw.dcn.clk.dramclk_khz = context->bw_ctx.dml.vba.DRAMSpeed * 1000 / 16;
+
+	if (dc->debug.min_dram_clk_khz > context->bw_ctx.bw.dcn.clk.dramclk_khz)
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = dc->debug.min_dram_clk_khz;
+
 	context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = context->bw_ctx.dml.vba.DCFCLKDeepSleep * 1000;
 	context->bw_ctx.bw.dcn.clk.fclk_khz = context->bw_ctx.dml.vba.FabricClock * 1000;
 	context->bw_ctx.bw.dcn.clk.p_state_change_support =
-- 
2.25.1

