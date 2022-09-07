Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7D5C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA0010E809;
	Wed,  7 Sep 2022 18:12:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F325F10E7FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=od/Qz+r+b1qAZKZYaqPrB3OKOkS+nr/Z6k5A01HtzePxw7ESlHeQ8jb5DhFk8fICIgAcI2+R99Ldsf+lExpzOFMXCI3/VVqqPZF3yjdibqTQyag5U/vJk2W72BNvKy0L6vlz5nH/3fSvmZFtJpJWyksYnOv6Vs39SIFsvNTCpFwhKVaDq9/vL9QiA/VNzItqSIzwsRE6ZCeQnvvrj0ISSUh6vctNJQm+/4ffAcxrYv3fqeR9b4MpJbRHQ7teWjYCjUJE2xfamCA6UWYniWK8mmd5uyIANdGxWBxaJL9LseuQAy7MVeqSiz7zIb3L6+KXM6nH/KocVa9zTf/rDMXoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUXCs/LNZNyVWFjISWP5MGJKSNzOjdlGBFQ3nLF5QCo=;
 b=HaiI6dvEjJxWjRGZM1Ke7aSxI2V4HDw2C0biBCfaNfGkcoJ3FyjfkT9DYuihsQrXUa/cJojPHYNkNIt/1DOIIuzfcugINoZo8G/pfv2CjKfOge71sN9OeeX1FbhvN8+ySZQTB642f3jxASCCSYENNx1ZdREbhhqGPrUiJntpcWR6E7Qjp1Qpd3hwISFb/r6s3z6FlDtMblPv9CFAeIwDuKx2RFMBQPvrrC/85JQ1pK+frW/79o/kV99CkqjCeLiYw9BaYHxDzTp7qEGg/qkzPzPgYkMbZxxWHyNqpyD87MvBSqXJUFLfAg+diTl1zpxRtr+PdbXrXv73znWyXwkAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUXCs/LNZNyVWFjISWP5MGJKSNzOjdlGBFQ3nLF5QCo=;
 b=4dFtWuqpKZc9fGgxgqHHiugOFHddx1gnwe51GTVf3YWXPUVXH9Pjbxqi3tm7i19AXrVtOqClzzXcj44NGm/xqhL0UuHqbrHl0sdArxE3pOc3mIXWbZ7JpRMdMRNpKN5I0sYwn5u+iAT/iJJ49xGuu0mCdo9btPMo37Fz/mP29Nw=
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Wed, 7 Sep 2022 18:12:27 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::34) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:27 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:25 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/21] drm/amd/display: Correct dram channel width for dcn314
Date: Wed, 7 Sep 2022 14:11:49 -0400
Message-ID: <20220907181200.54726-10-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|DM4PR12MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bd7281-b577-4fa2-ce07-08da90fc8583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHyZHerJSeZ10hQJ18YrjNqLnLttJx9HlyrtjaZv9kqZ8CXTKb8IvFp2UsVaUV8vVJ89GCP2DRaN0+GGv+SShri/dOvS7K9om0i4HFb1WZ+24pqgj+2OJ6SpyMC4Sv02JAUpl+Ax+qPdeYxySRHiHIW3R6vF6JXIAHP97EAIlgDOXj9AvF42F5qZKkH6MKw4TnSU8O2Jnujq7h4kmWmGgz+AP6/INE+MI2F5dTOlvML7dNuBgluo7bIxsFOB9hkOPOglFJ8j/pT5UmPTvzxLWUZgRW8YouIWnT2vNKTdjNaFajImzbGbpkzgzgR7GGicu+HXm723AeS1G8JRg8mYMgl0Pw9BqAcECcmdElBTSCZ3+E+Phj+WwL27J3dUy+dOruc/Mmq4z7mD0eKmGDADOehJZuBIpdRvXphLvST8b0ZmKVkqoaElTF6xz/XuG2vvjd8YtPMucPJ6c63I1jJKApKPaRs31X4nOi48EBkofg8trhSVdxGQbwcLH+JpOcZI9nchwu9cWE+Yix3CnsZ233mZY3rGHtIHXnn1EEOAofCDbJn4/LwXSLfoy4NFG7TuE8VjhunSi/He7BGMGXi4tSN+GadKu6rykzYwV7BxthDL7v7OOGsp/QbW0rDFJMTLKcSQU4ou1vMUIPn2XmmIrt0MVZnmK0hRHwrmpBwO8zm5+//CymzsydZHR3lcRrhqsNj21MoKeayfad//layeGdiD1PvWKkIuNucRPRBWsCtDnD5TxijzOhTX7fUpvbLKtkksO+4nu82MD81l2oUS8uwnJMUxRZCA0b2X2VCR8Xh5DRdfnEt17d6LAsNL1YNU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(36840700001)(40470700004)(2616005)(5660300002)(41300700001)(44832011)(6666004)(26005)(2906002)(40460700003)(86362001)(40480700001)(82740400003)(7696005)(8936002)(36860700001)(82310400005)(336012)(16526019)(426003)(186003)(356005)(47076005)(81166007)(1076003)(83380400001)(4326008)(6916009)(478600001)(316002)(8676002)(70206006)(70586007)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:27.1575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd7281-b577-4fa2-ce07-08da90fc8583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
The interpretation of the number of memory channels
differ by memory type, and this affects channel width
for the DML input.

[How]
Set dram channel width according to memory type for
dcn314.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c         | 3 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h                | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 171c38fac6a3..cd86aa912e3c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -677,6 +677,8 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 	}
 	ASSERT(bw_params->clk_table.entries[i-1].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
+
+	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 	bw_params->num_channels = bios_info->ma_channel_number ? bios_info->ma_channel_number : 4;
 
 	for (i = 0; i < WM_SET_COUNT; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index fc5529fa51b3..4bb3b31ea7e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -194,6 +194,9 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 		dcn3_14_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
 		dcn3_14_ip.max_num_dpp = dc->res_pool->pipe_count;
 
+		if (bw_params->dram_channel_width_bytes > 0)
+			dcn3_14_soc.dram_channel_width_bytes = bw_params->dram_channel_width_bytes;
+
 		if (bw_params->num_channels > 0)
 			dcn3_14_soc.num_chans = bw_params->num_channels;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 5d2b028e5dad..d9f1b0a4fbd4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -214,6 +214,7 @@ struct dummy_pstate_entry {
 struct clk_bw_params {
 	unsigned int vram_type;
 	unsigned int num_channels;
+	unsigned int dram_channel_width_bytes;
  	unsigned int dispclk_vco_khz;
 	unsigned int dc_mode_softmax_memclk;
 	struct clk_limit_table clk_table;
-- 
2.34.1

