Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B23C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7890C10F31D;
	Wed, 25 May 2022 16:20:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E088610E677
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su2wnoz0skm3PC69RYBeLZ5tFe8leDzO2Isqg35binQZ0wtnh7Rlm2xpKPl2b2GsUfjUq93Dbfixd+SpTuq08/j44BjW73C+wpDIfdl7rzicd4Xu5h55EifT4+nzZZtqR24xqjzEWLb1DQllFL+RjOTgbt6fLt5BoweqDe85pRZnZJaRXksqBj7EuR5fx8AjWQA9CJ0gVZm6nmkL3SITkWo5T4t6859M+n+rbIkqdX8zpSe7JDAAIW2iz5TYOSr5o7abT7X6o+TO4WjbRvRJTIUSCNy2B827pz62rOPiXQAQuej/y9OIa71l2o6RnC3qTvbGlkBdkIClUJKpj9dMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIem85x5UnZYMAR/6YbXl7eCO+VDhaJCi5xGgsN23sY=;
 b=S3aumWF4U+QI/IZBSmeozofQXVe74iMxC+tIIkHgaDZpBGc31tNoK3lwgFPN0aUK45K+hAVcKa+/V8UnTHLNRkU5fHLn0UVF+fTgFAtC2sL+qpkx4bFXfIufmJ/GBK11pJkQJN7ICoTH5pBOkiJ/19qMrFYW4r7USXJpNR0uovXkgOiNVNPh+5i6WZMRyGq8ww6JaqYARxIaPhVcGEv2TQZmDgon6fvlF9UCdjpuc937q19SQQhrI93sNHVdLpHv2Xi4YDyxEsSut9v/VGOax+iVD9M51GvG30EqkmfH+Kqzi3jsJZWEa6eEK8ujxfwlG/4foL2hceU6lVmFOfKgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIem85x5UnZYMAR/6YbXl7eCO+VDhaJCi5xGgsN23sY=;
 b=idbkB7hbW5EIgWvoHs8yX5/PAfth95b9GOLJGUNAT7hAvopuhMvL6G8ngCOWtIrfOW+lrcc+O2Sld+d8SnD3Vz5xCnkqkfd/Jp1EG3QQ/z7Ud86JmpyQ7vj2YNwcf2gzvc+C6eDxCWN9EP5zZpHnpo760y3vn2r4QcscM0ioYy4=
Received: from DM5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:3:d4::22) by
 BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 16:20:22 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::5) by DM5PR05CA0012.outlook.office365.com
 (2603:10b6:3:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 37/43] drm/amd/display: Match dprefclk with clk registers
Date: Wed, 25 May 2022 12:19:35 -0400
Message-ID: <20220525161941.2544055-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a93920c0-a3c8-41ba-e9cb-08da3e6a7813
X-MS-TrafficTypeDiagnostic: BL3PR12MB6545:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB6545DEDC69E554CCA3E65B33F7D69@BL3PR12MB6545.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0luigUxyDn9KM+jYMVFrKYTY2AjBwTqvNnAokO3hGtmXPnMy8OIyNZ1iXKTBn2Hc8TvpVQm3UUXdiw41WwH8GGf+1lYBu6zeLiVV3ZY4mxtTfjDcp55V0sCVD04nShgwoLk9G3b3B45Bnrh3cm3EGhRhH9wkuF2EUETFVTRuhqCMwx9L0mvlUBVZGtQOWt79RjgA+DyRgAQL4GJq5qIW1HXuMS2DwdcKd1vwC0sGwLPJCUjt08OTAwTIJY9xD6+6Rl1iY/6XV5XawkKP3Q0ZHceYjhl2U6oM4ynUejI5RsZpE7q6TB9YyIMSOx+XnnbcG2FKXkNwinsNNYsZXdq7V9SeNVnDmLa2N6T3HdOoFHW3RHJcdN5ZdoLz3yBz5DTYVMrk5DAHShluhac6rSGbCQ9Zx0YjktnZS9hwbN7aikkfvtVCMsA0F3AiX5CqjbHgbm4UMJcx8oD1OK6KLJi+n9IBloLGhdrayf8xwUFcZPtgoWxdF/2S737XgWXJkTHlkZ52/W3gnhMb9oKh6KZ/xdIL8OfJZVGqq8t3PkXiNZ9e3ejHDUmHhYUyD6UemPRHft0uODNZMCSH1ZG0k4BZslp0dIEq87CoLVu0g3oK6fI32J+lbKTN4s5qf7lsmGpV4upujKwzrltrtbhKfh82dKS9Vbu0x9p9qhBq5XpqtFGG+6u/DE3ayAD+ZX4uf8DBI8MSuMy7c7zObY2ngqce6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(8936002)(4326008)(356005)(70586007)(8676002)(336012)(1076003)(2616005)(426003)(16526019)(186003)(47076005)(6666004)(26005)(7696005)(86362001)(82310400005)(70206006)(36860700001)(508600001)(5660300002)(40460700003)(6916009)(316002)(54906003)(83380400001)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:22.7279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93920c0-a3c8-41ba-e9cb-08da3e6a7813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Samson Tam <Samson.Tam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

Update base.dprefclk_khz to match result from dcn32_dump_clk_registers()

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index f147c65137c6..bd2352e61040 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -598,7 +598,11 @@ void dcn32_clk_mgr_construct(
 	clk_mgr->ss_on_dprefclk = false;
 	clk_mgr->dfs_ref_freq_khz = 100000;
 
-	clk_mgr->base.dprefclk_khz = 717000; /* Changed as per DCN3.2_clock_frequency doc */
+	/* Changed from DCN3.2_clock_frequency doc to match
+	 * dcn32_dump_clk_registers from 4 * dentist_vco_freq_khz /
+	 * dprefclk DID divider
+	 */
+	clk_mgr->base.dprefclk_khz = 716666;
 	clk_mgr->dccg->ref_dtbclk_khz = 268750;
 
 	/* integer part is now VCO frequency in kHz */
@@ -612,8 +616,7 @@ void dcn32_clk_mgr_construct(
 	}
 
 	if (clk_mgr->base.boot_snapshot.dprefclk != 0) {
-		//ASSERT(clk_mgr->base.dprefclk_khz == clk_mgr->base.boot_snapshot.dprefclk);
-		//clk_mgr->base.dprefclk_khz = clk_mgr->base.boot_snapshot.dprefclk;
+		clk_mgr->base.dprefclk_khz = clk_mgr->base.boot_snapshot.dprefclk;
 	}
 	dcn32_clock_read_ss_info(clk_mgr);
 
-- 
2.35.3

