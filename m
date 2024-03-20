Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F9C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C5310E805;
	Wed, 20 Mar 2024 06:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rsnsdxQ5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6831C10E805
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJxXkFyb7h8pgHCiD23pNe80F09B/gnpuW17DpaPIGEgJBmE83BgQNDkoegyGTAZHk3EVvGPEIQfCpcw4uZYUAxrWN91yhmjqnn4b8hoIbGFdg/HBfWALYmJaEMN8Jg9H2M6nKVy2n/4NTPp1EtyCiF+qtoD4byiTyqpCETsD5FvLUpmtPeWlQ3lFE+netQfPnYn0pAlJ7Lexc0Y4pdr//6VBU1QDDT8PtdiIYnP5GesrK60DwbOwvUu38wItbt8lCMFuOii5PxKzRKaJokimkJaVL+UJWxdEPjloLWpfEYoNZokZQS8/F5laKd+bvtDsnCVyuOSUA9Mcm7KtYsKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN9OlSxrtUNzJ95usc0FGJM173UnzbpL90qahWqYBaE=;
 b=SXB+2FKU6VoG0LIUmvQ/jJVe7X1NLLp5FX4qrNm2UF1zx1irgdyTEYgnmSCaoHh7MEIoFRE+jgksIqraPg4mEbjoGfUR2BVrbHrUhckKBj02NbOnl1bpWTcgstnLWpDIXyTwMcpIb8jc8+F67fpEwJsHNFZVHT4zKxTrG2Id9+ds3mNd8s+vnBpUxFtIocsiLS9J3hSOA++cF5kZBV9u1gMfAAuE2LuCWHPFhR2juVqgBLWkcQfQro3V6M0yp/xAGi/aC1L/XiIIKQtsiItrRYGRvtAoLdq1CgnpmZJf6LGSz0GV/0pelwaj7+4OeZrfjWFlTyJ713DmA3N6T9Tw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN9OlSxrtUNzJ95usc0FGJM173UnzbpL90qahWqYBaE=;
 b=rsnsdxQ5kwUpeR/fLBdAo1+jge/LI4QLv9jnZP/kx5h5FuFzHOcsF0mCopwGdBXW0D4UETPPJzLJuuYLJ7ZOZ3heDEA2gWqtmcyRlbhnk95NUWqfNtnznc7iHJKBW5zaKbQU7mAAH66oyG06GBaE4ibZbdEBKDKjg99sAYlz5Hw=
Received: from BLAPR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:36e::28)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:36:18 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::b7) by BLAPR05CA0013.outlook.office365.com
 (2603:10b6:208:36e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 23:36:17 -0700
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:14 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Taimur Hassan
 <syed.hassan@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 03/22] drm/amd/display: Send DTBCLK disable message on first
 commit
Date: Wed, 20 Mar 2024 14:35:37 +0800
Message-ID: <20240320063556.1326615-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: a6297b30-acc3-4592-44d0-08dc48a80cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpPLiNwJg4Mrt1UyHvjlY7icfZex9khe3CiriSafz6Gys+0YH+7kgMiSdLH08CXvDDXIAhoPQjgI6qA3sMLTPpmDrfJXwA7XN1sWck1rLiwih5DiU6pXpfyJmzZD6xFEcW/PPCv0zgRfGWT33qZSZ//HwdR5d0S08Z1rNbu9OmkpqDf8aVk9WoHDMG3xmbHD4DTm4Ydv/gLUPP5D69S6wU4wpogBBVMDQQjehdWuCAZWhNc3GvFi5p0QkiQpXyUvyo90ef7oL0HZ1q8cqgjmkM+RUIZoTh4mR11b4mOyPbLT6sY0GtBHJ6AJd/yRciHQ0H0TrJ6F6UjD/b4enDdr86d25CWLPp6JAaUAMrXcJGGWYrwb34c0SY1/Ld0vA0tS52HuoEi8FY7HqvtLNaNAIf5s1BkLkVheomOm1nkl8kwOghiB8QDtLv5tMdZ4LkpSr5EHnKC4sU/LNFwQlvbRZikNr4kOt6S3RoA2Ridoco63lqDXJiADk+pbekca0cMxd1DPyCciQh7H8ko+BPLZJo42QXcNjTdxtGVu915I3SqgIE0QzvhYj5cOTLURvuv2rhI8a4a/MWk1Iukwq8MN8ed9Dk1NcdymZDXW4kDB8BYwP+7sjZQGtTEKoxF7jVwsQQm43bo3/RdoC09mjwCP5xIjAm2o3I9cxQLTen0yVtn2to08sbmXnwU29Cle05oEWoGxhCc9Q475PrhnsrJjvE9J9dr9uR7XKyibMBB+9YyX9KSXSqM74eurhPh84wEO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:18.4931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6297b30-acc3-4592-44d0-08dc48a80cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
Previous patch to allow DTBCLK disable didn't address boot case. Driver
thinks DTBCLK is disabled by default, so we don't send disable message to
PMFW. DTBCLK is then enabled at idle desktop on boot, burning power.

[How]
Set dtbclk_en to true on boot so that disable message is sent during first
commit.

Fixes: 27750e176a4f ("drm/amd/display: Allow DTBCLK disable for DCN35")
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index c6030bed95a0..dafa07671d00 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -73,6 +73,8 @@
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK		0x000F0000L
 
+#define SMU_VER_THRESHOLD 0x5D4A00 //93.74.0
+
 #define REG(reg_name) \
 	(ctx->clk_reg_offsets[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
 
@@ -412,9 +414,12 @@ static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 
 static void init_clk_states(struct clk_mgr *clk_mgr)
 {
+	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 
+	if (clk_mgr_int->smu_ver >= SMU_VER_THRESHOLD)
+		clk_mgr->clks.dtbclk_en = true; // request DTBCLK disable on first commit
 	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
 	clk_mgr->clks.p_state_change_support = true;
 	clk_mgr->clks.prev_p_state_change_support = true;
-- 
2.34.1

