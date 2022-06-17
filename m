Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A9CCCA479
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABD410F4AF;
	Fri, 17 Jun 2022 19:36:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0934C10F466
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To6IEwijC0R++ohqShaZrb/xtnJD2AlRbU2QK26ftCLb/GQE8dKdhUlRawNdIBrejmHpWX3aPEn+ky3stDj3P/1j3pHUufEPndRlQ3m0LF0yG2CpCQkm5bzdBAQyqmn96r6dDG1srZ1SyrF6rRrqqTIwfUtS4qjeSQ0/R5XPbweNyOMIQJPqVItB2nRC3Pux1uV8tBlvlOZyDfvH3iLNFcu+cfefjglzD1dh+vsnFNpikcyYkXImDEQr2kgh5Cx+mok8Cx0zBNZ2uXGH848t9zM4p+I0v9DRUhX2FuGdtgO8rBSo4PQCt7JceWtsaxBRO6vJrqBxLxrCDMuukT4Vfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY8KawkPaPutUfzF4UjALo2sBNm9hGB11qUczB40pKY=;
 b=IxavviEWC+x2JZ7hJsNrTyhut6Q6fQyS+lW/5nNCgrFVl7cWPjaSbVn+da4d3HO5pQop8aH1jIOElR+s3rkkozTBU+2PC6Tc7W5yqwmjfWTYxtGT/yfqzTVOItMtKDzvpIXekod7IKznIpHpXmGKpdpgccuTcPKyVc77Fpj8HUNNAUI8Y4pph0d3bdjq9c+wuZ97xd7RrO5z5E6KjbSw7/J//Fc7LavUVXUV7DnNvnahpgIkeKQgX+GNiR9Q4VpbGcFmKFvbGDfgjPtDgLdz2DwCPKBRz97Qexm8z8ZKPCQkftkc9JGJCfts+5UCsfw25uZ2ehy5Lms3S8mubbMHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY8KawkPaPutUfzF4UjALo2sBNm9hGB11qUczB40pKY=;
 b=V9qMkq/xZyv6KKL5JaCwAi2Vo9MINLGwqTETslX3eyurpVlZBwXPfe2QNDv5Hx5OnQ8rtOt1Tyx060qun6MY7HyoFUpMs5cnpYup3HyvYW/dV8CbpJ2urjWSrClZ5Zjk+Hu81fU7/FQ+zz/KNRCqukzzmjS0SeEnHqLK6h8Qc2g=
Received: from BN9PR03CA0762.namprd03.prod.outlook.com (2603:10b6:408:13a::17)
 by SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 19:36:07 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::d1) by BN9PR03CA0762.outlook.office365.com
 (2603:10b6:408:13a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:07 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:36:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/31] drm/amd/display: Fix divide-by-zero in DPPCLK and
 DISPCLK calculation
Date: Fri, 17 Jun 2022 15:35:06 -0400
Message-ID: <20220617193512.3471076-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f1bb32e-e5ea-414e-1fd8-08da50989feb
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814EF042FDE22DCBAAEBE1B98AF9@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/QrS+yxBrtLgiHT0R3CYVL6R03CmI0UibyqwPpFsGYsRoI1wKteXtvZ+ZoVjkZSo2qf8/HhyjmyM5pvF/+NxptbwiNVNhKJ+R++MmFkQ/yTsayc8NaJVa+AVizoZRboyLvMaDMDR81qjavxKtDnDPmvSREWeRldAY4fpybmY2Y2Rcf/hQGAe2opA5YNJiJuvphzScTdvpnlOnxQdwDAhViDL/FBSHHzzqKIYuECeJtoQ9Zmw6sZALX4nev+nk37E7j/gZ5Gnir044S1g9zn7oh7I1PhTdBVMiR7f/HzR7FAQ2zx67QT3JGJlLWeBJ9FRanGmNuzmICggE2PkOawmbq6D+Dbs7qqRQs1oYj3fY87sJmV0Mn/ALtoGQ4nFxJl4fP7Rg4PLJZy0i94hmFI2u9TZdNuzrp0ug8c/iq5Wr761YOY9hvkE0l/9wGQ4AuShkIdokrOwqnrWctvA00Ad3lyeWbZeVvgcMoAcC57RHrRiq4sUvpPmq7RQhV9qqz3QZuUZwBKXXxcnyt8bXDyYqoKT0ga/xsUMFKmbUgBdhRfGye0h+laEGEbgSggbliDOe22RVqyOM1liXWXx4LjlGMT2T+MMSxwYC7IpqaBqO7soCdMi8hzpaZJKbNoBuBEQ/1Vgfqx7WUR6ZhafVT1cWzFl/nkcesGN0B1u45QD7oHDcVSaqJPQ0Gl1Ulj191FPgLjv0l4nO6pY3bn5wtmZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(36860700001)(36756003)(40460700003)(86362001)(316002)(498600001)(5660300002)(2906002)(356005)(70206006)(54906003)(8676002)(4326008)(81166007)(6916009)(70586007)(336012)(7696005)(426003)(186003)(16526019)(47076005)(83380400001)(8936002)(2616005)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:07.3802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1bb32e-e5ea-414e-1fd8-08da50989feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Certain use cases will pass in zero in the new_clocks parameter for all
clocks. This results in a divide-by-zero error when attempting to round
up the new clock.

When new_clocks are zero, no rounding is required, so we can skip it.

[How]
Guard the division calculation with a check to make sure clocks are not
zero.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index bab85f3c9c67..8ece88ddfb5b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -335,14 +335,16 @@ static void dcn32_update_dppclk_dispclk_freq(struct clk_mgr_internal *clk_mgr, s
 	int dpp_divider = 0;
 	int disp_divider = 0;
 
-	dpp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz / new_clocks->dppclk_khz;
-	disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz / new_clocks->dispclk_khz;
-
-	// Divide back the previous result to round up to the actual clock value that will be set from divider
-	new_clocks->dppclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / dpp_divider;
-	new_clocks->dispclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / disp_divider;
+	if (new_clocks->dppclk_khz) {
+		dpp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+				* clk_mgr->base.dentist_vco_freq_khz / new_clocks->dppclk_khz;
+		new_clocks->dppclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / dpp_divider;
+	}
+	if (new_clocks->dispclk_khz > 0) {
+		disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+				* clk_mgr->base.dentist_vco_freq_khz / new_clocks->dispclk_khz;
+		new_clocks->dispclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / disp_divider;
+	}
 }
 
 static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
-- 
2.25.1

