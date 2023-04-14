Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06C3C77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCA910EDD8;
	Fri, 14 Apr 2023 15:55:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAEB10EDD8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9qNegxUTuTtB6QMbfIsbcNpjbyuR1ROBRS5mCIvBx2CKUYg/Ho/e3dfkPtdPdPuPWVJ0CCjO0IVP8Ib6AEk/ntzVEfInVw4D5BQeidD+bRMIeNMXH3Tvmyej99fd3PAM0P0h8SdXPTyyagAK/+PIpKmnRaNqH0WvwtuJbqvm2fdAiUSoWI+LLnnp8ewvMcOpoZ7pPll5oK9aoj3U+734FAcuXvzDY2VEUuNMlVL+QyK8pcYVDSWnBOTjlKQQNA+M5hzgRQQyHjVmrQAlAqnijXJRjkSq267PJSjn8PF4DGhift8rr+A8kpqTj0pQPvf/KgIbtJCJfa/JuXamtZ6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Awq1g2jvhsOknqCSJUIb1yE0jOKRKW6qirvc/h1KqPc=;
 b=jtoJGZFrBc+wmwIsfFklqLZ92fMg39pC69Qbd0LyWDa1Cb2jIqglX2PYMfYNWguF4zu7Iwtovt1MV7kea/7mQTr1u3sGHLmiAmGEuR9J03ywfCWzO4FaMQ+G3L0xeIE3EmXX4RJn4BV39A+34fkQ9xy6NTK6aGX32/r1idt3LpRbLk5xtjja/GK+w0y1lE52iN8ETiZK5SxQwAehgFSS5miMjcBQx5GPUQOSOhYhEYC85BFXzksGnLIUBpHJMVfbBNhHWezQ8LpYOx1ekl5zcSi9APNAAsqwQ3+t5AH7JzvVxk9sIf4ULw523Zdz2W1zBimwHmhaDHxG876CiJoC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awq1g2jvhsOknqCSJUIb1yE0jOKRKW6qirvc/h1KqPc=;
 b=QZ7ocVWD2lqIC6Wyv/8Vr4tDRP9NaulH3P8LrcGE3WLgW21Bu11W/ZsCmZ907PK/JBPWGrZva0+YWvhaDMPEd0giBN58uX15R6QPKttbp7XhoSEYbYncjU05+8lmeUSZtPFWIHZ0VfOTMQu8uYu4miA1yPFSGH3tduUVlpVlt8A=
Received: from BN1PR12CA0005.namprd12.prod.outlook.com (2603:10b6:408:e1::10)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 15:54:55 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::7f) by BN1PR12CA0005.outlook.office365.com
 (2603:10b6:408:e1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Fri, 14 Apr 2023 15:54:54 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:52 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 44/66] drm/amd/display: Fixes for dcn32_clk_mgr implementation
Date: Fri, 14 Apr 2023 11:53:08 -0400
Message-ID: <20230414155330.5215-45-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: cd76c559-909e-4e13-a6f6-08db3d0096de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 746erREI60nWpJt/RhoGxG16N04yyK0cO1+WmdK89Id6CvLRwThVjeqYQ+sSDYRrFbe8Lvqo6uHJ+RNDFQFg0TGHDia75RNhJdQgSiQgTcRNGM/j1fnv7efg8UBJknYZFQc6GhgieMM/ylbq7osfnmThIGKGilRIl8e7fajzQ5gCk7Y2Y8tzjXBzAuAzrKw0kVWAgo7wlcqkDakvlMOGVaRJ9uDcJepLe2bcTHIHSEryvD5tz9+8eqSDOQ5u2IM5VW1wyzVe6/4aJfB3hLfOzlucI8MgiivU8tEZFFtTZRqxuA6PJDZML6NCvMl2E3aT/WT/kmEFxQAEYwDhStBZ3CzoyjJD6Eu5i7hX/OzLITXzVutoL3V029EnfgZ4iJ9P7C9TCH50RDHHBuZnn9OPtr1ozBaQyAAH6CH681KRl7DZ8+3fDDMjhxEty54miiao0hMIC1gbxscQiNyTNhs5M23X3+lS5d+DZnMGY0+dmuHyCvHbuP9BtPk+zbC8fOVN1hjbdrRIatAXanySba0ayHT6ZDhnrPg1v2/05o6zMIQJTaj4B69YkqcLT6txiu3qRGeFFYAQpjyJzhEWw95hB9gtVw7ZakofQQUICC3pKDGIKHqCrKsZPlp76hIwtHG2Pln9M18nYKAPKc/Cffudfo+nsgyhyVhfsxLG73SsOu+LHW/JpwNnzV57p485QpBQWtrmBxhJEUe2a6LwQP2HrYPdCa+tRLjES57Yeo+MRfY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(16526019)(5660300002)(26005)(186003)(54906003)(1076003)(316002)(2906002)(82310400005)(70206006)(70586007)(6666004)(4326008)(6916009)(8676002)(40460700003)(8936002)(41300700001)(81166007)(47076005)(36756003)(83380400001)(336012)(426003)(2616005)(36860700001)(86362001)(356005)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:54.3056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd76c559-909e-4e13-a6f6-08db3d0096de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
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
Cc: stylon.wang@amd.com, Leo Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Fix CLK MGR early initialization and add logging.

Fixes: 265280b99822 ("drm/amd/display: add CLKMGR changes for DCN32/321")
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 2b8a81b6d53b..eea103908b09 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -905,6 +905,8 @@ void dcn32_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
+	struct clk_log_info log_info = {0};
+
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn32_funcs;
 	if (ASICREV_IS_GC_11_0_2(clk_mgr->base.ctx->asic_id.hw_internal_rev)) {
@@ -938,6 +940,7 @@ void dcn32_clk_mgr_construct(
 			clk_mgr->base.clks.ref_dtbclk_khz = 268750;
 	}
 
+
 	/* integer part is now VCO frequency in kHz */
 	clk_mgr->base.dentist_vco_freq_khz = dcn32_get_vco_frequency_from_reg(clk_mgr);
 
@@ -945,6 +948,8 @@ void dcn32_clk_mgr_construct(
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 4300000; /* Updated as per HW docs */
 
+	dcn32_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
+
 	if (ctx->dc->debug.disable_dtb_ref_clk_switch &&
 			clk_mgr->base.clks.ref_dtbclk_khz != clk_mgr->base.boot_snapshot.dtbclk) {
 		clk_mgr->base.clks.ref_dtbclk_khz = clk_mgr->base.boot_snapshot.dtbclk;
-- 
2.34.1

