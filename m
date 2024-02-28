Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C538C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F225C10E478;
	Wed, 28 Feb 2024 18:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QlYhdNHZ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3887A10E478
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTwI/jJKSAW+oORDFyi+hopqjKWK4hzzPPvXA10SGz5nANd6v3jSyzHChosB1of1JM4Ytowj7XUVNKVH7D0JfyZWWSTEI4nqUmgi3JVta3V0XpgF0/6Ttd9NCnTlg6hWYg7b124SWhTmPbD0rIZKJyyBdPX+TARiTSBW2In0fFNzQS3mHo9OignFOBAtZoztKDFghvPY7gaGhBgYM+j8TrbYObva/3LGh3mIJIvqwgWwe2sWb2K5SDkf7Nuw1rKUl8NJMWXHMK0I6C21mtdMpfVGek0WEnws3P5Q5FktpkOIQv0Pk2Y9dEKfDBnbreM5XtoZmFMMuuHPPY83sNtmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPhk4wb/qszl5txx/GzukIEQOv/onBO5WO8Bvg6/NhY=;
 b=J6+JGc4/LHs/3+0fM/bFqCc72H9VF9lc3oCNDQ3M7R97xRTUQ0dmeVnhpD8TjIZpfeJNbfa/bxv2X82mOIQkli0frlbkehtqTatqKdzctuY4nAp3RDagMs/uImeN4ZmRwM+j3IPdyFBq5kWVfZtKr7n0VXoWrNjYrwpqR6PDZ3vp66zjdgU7KBNa0elcs9d/KQce1RCLUWEz2LobLYYq8vlKxGgfzTwqh4c3oOEauMQpNquM7GvnZuGr1n6Hj7g3SE+eetcqko4ZJjhDIlPjhBuH6ZvI2PdFkCvWzfayKz0PCrXf5ymABJMSwmQMJGv3N9FPihlhfeAI2p0l2Ol+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPhk4wb/qszl5txx/GzukIEQOv/onBO5WO8Bvg6/NhY=;
 b=QlYhdNHZ37797a6SWrQzICg6M2YpoZNiw6g6Jg79536t6h/O0oiruR6meoKxfvhYX/I366Sd7HSo/mUdTbMlkCXRjVxeEHvLQJwb4cj8Ug5YVqhdBK2+qXWLh0zfp1qaSLqCsRUR6shSgHdm8bUQi9YyEAU8YkOPdi3LDl8I0z8=
Received: from CYXPR02CA0013.namprd02.prod.outlook.com (2603:10b6:930:cf::24)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 18:42:48 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::e7) by CYXPR02CA0013.outlook.office365.com
 (2603:10b6:930:cf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:42:48 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:42:46 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Muhammad Ahmed
 <ahmed.ahmed@amd.com>, Charlene Liu <charlene.liu@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 09/34] drm/amd/display: Add debug key to allow disabling dtbclk
Date: Wed, 28 Feb 2024 11:39:15 -0700
Message-ID: <20240228183940.1883742-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: a208d8e8-f9ea-476f-9a36-08dc388d0fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DH545cO5M3TKYpWEGmjNJTT2AAinqKeOCYSVpwwfg1JMoNvqa91J/2BU1tjKUBEkwB0C+HxMflggDXbAKrM08ubmh365M0+LlZo7HtUUna5jh4+Qy07FTc51EUq9IXBwcDzqdrRUX8oJccr+4PQnde6B7CM5cfyNeK1AuLZ7rYA0KOTI5a+Y5kNjzEhmA5tiAzcAZzrVxaFcj3UuUT0qOo6Lt8X73J/4SbiSFgzOlyMddNK8BYTjEKXbap9ThWOFVz8cn28fkniF5JZD/gQfHoYUGOlXloQ1EYLj3NvWqvcStQh2FJI6c0c6NE33ooh2WEI00/C1duScaEXABPpBw1pxM9UPOfQYO/n3xYmcXu7GK/cQAxdQwk4TuAmt6PYz7a6jprNJY9HPft1MkRw7OuvnBLdZW/97T5seYbIY3tvNKXn9ptR5E3eBQubADLQLKpgEmtdeXpzZgmsVNidEbIkKKAef0N5rMdpiV0k1I9j8U5cX/ZHBdL5CV5COkK8xY2X9qMCfbMmDUjptR04VJrorPgm5JmzJJ2InQ+uuDioDwOGGWIPk7DTqluT2YavXbgEgqLYQ/I1RFP4ugPaDx9Z1UqtI6QhY/dLe06SuDlCej94KPLZEIACvm2PP8jzRhkKxdwojj2vVpdR+qVHcvPh0gZgq6j7s0Kak0gFqfkYmZKwTMsMu4u7VnsLJNhu3jQeAQ4iC8qwXASId1C+yP2n42jcNgE8fe1SjyktlZKrftU4r2dZ5bsqnwp5tZG2g
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:42:48.5744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a208d8e8-f9ea-476f-9a36-08dc388d0fd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
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

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[HOW]
Add debug key to allow disabling dtbclk

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dc.h                          | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index c378b879c76d..c6030bed95a0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -244,7 +244,8 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 
 		if (clk_mgr_base->clks.dtbclk_en && !new_clocks->dtbclk_en) {
-			dcn35_smu_set_dtbclk(clk_mgr, false);
+			if (clk_mgr->base.ctx->dc->config.allow_0_dtb_clk)
+				dcn35_smu_set_dtbclk(clk_mgr, false);
 			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
 		}
 		/* check that we're not already in lower */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ee8453bf958f..c1d8288a08b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -435,6 +435,7 @@ struct dc_config {
 	unsigned int disable_ips;
 	unsigned int disable_ips_in_vpb;
 	bool usb4_bw_alloc_support;
+	bool allow_0_dtb_clk;
 };
 
 enum visual_confirm {
-- 
2.34.1

