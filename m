Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E51606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WsZjBnan
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9F510F8C7;
	Wed, 11 Nov 2026 01:41:52 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9CB10F8C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjWG5YU7uZi/qhv8dtyJXadHdspkICVm2HzvZ6zqAOx0ZK8DgtsC93RCLYtYgmOBd5WAZdTanCN4teJrqPPaJicO0tH5vMe2Wt6NfeZDOfyerhxFSyt5y+qKgBLWGBkK1B9n1JFGTAHnH5jTrOlP4ihhRW2brBdn1LVwVLhrC6w9rsFDMwJ+zKkOQ3+YgKLPqfgGw9BL4KxoehziruDAj+GxFs1Th8+WGlKP28z1Y+zO57sO30gDyQhc1ZxCdQ9nHrGHEVNOtoBf3mw7xQMiYmzdId9WovNrwUhQv4UZnmxw6WayM9i2ash8um3NMibqllZhrQ0MooB3JC1u8Yqkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsX0StDsOppoZY0bIX1gqbR7xbBQNwFH3HyKivCd5Lc=;
 b=D04J/L8EAMJ0tTmdn66l0LJPdziycWx/yUikyi4X0GHIJIFyL/HnzVaBPGeMXez9VKiDDSZbDm6UK6A2aAv7hWFRBtJbPRY/HCUsitBRZO7SnjeRz+LbUdGcM0F5p5ENVhpPUO6rhIv1oE04td06C8OzSUGY+Fb7jdxyT2En+/8yN1tn2SEPhLYCuhQ7x3CVygBqYI09eetuXjYPgPOpELJPS2mDsAtHHMngN4emN0xiP0wP91nCCUkIC7Dgipk975mZKS9/T342RwhRYiPE+7yjtpRaGyQAbMLzwI6THTEkLVJhcKS4K8lzz8ASe4ffmJuKuZwHnwmMgsW8Tk4GaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsX0StDsOppoZY0bIX1gqbR7xbBQNwFH3HyKivCd5Lc=;
 b=WsZjBnannxNyjtchCWr4hjAk4VJb6U/85eliOU5e88HvQ+liRmY0Q7sU8QNUNdoCfzLuDLTxWy/0Y9wkrrt1HP7R6h4+k5oAOngcIX4/X+fF7sJdzPJflvRv/s2BD+rqFzIUN6U3hww/zLiFl8yVT62aIGgO/r8t3kPaw/ArgHI=
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 01:41:41 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::1b) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:39 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:36 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 20/74] drm/amd/display: Update default VCO frequency
Date: Wed, 11 Nov 2026 09:28:26 +0800
Message-ID: <20261111014100.3596072-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: b481a912-50b4-4b28-2d9e-08df3f94ef07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|22082099003|18002099003|10067099003|261026121527099003|11063799006|261021121427099003|261022075727099003|261021123027099003|261009223027099003|261102123227099003|56012099006;
X-Microsoft-Antispam-Message-Info: Z6ZCRHS/BZ4C+lTCrFTDo/rbr+Rv8XLKmM8FDyvcsDZ1IyM934w8NceVTRDP7p7CVTBDOvtjYSHYwQ2nlBGXGgBrbzAACPEHlscPWWtja+Ff/mGHpbgrIaWhEkiPZz4pBx2n8dgaBAvjv+o8UmJmzRdtza8v4XpFZNjfeEhC0AjkHesaioJZ8SRxuOTbYvVDtVkhTkpcg/yLeX5CD6HU1f2irACQr1jYwVdIcpdrMgplqJR/8/3AmOYY/ySOxVMCCqUvM7MZhgUlpBAWlW5E7YuCCt0xUkvqMV4cpvX8qkFTi+coX5SeAum90A8ZKvonv1N04z2cKpdkAsHIfA/NnuTy7gJr1xqLCJXB3YEA3IoKasn54o1IngxVWdvaXWOOc3MCvzU4zLpkaBxc2GRlHIKMxJy+bbtxxIHfXYqLd3XhzDv3N+94r9VMU4aVLynM5YMPRQkXjhUr+xb3QdykiiHLzPtdY/2DNOwGzOjPU7JOXe8yc8xSAiTXNXAe0jAfEEv0a8E+sFztOEwS9aWaGjD+n+eFUo3rM4eJ+nIrRYz1WFb1tY+QxGURcNzDlzIH99iAQz/sXYRrCSltEKzZOH6hUjrQEGcKb2FoJpdFXj1PUZlphwRIvarb4CFHGcceLvjyRYtY3YCOLhKzjYIMX6NANZUZ+f/h5kD2KO3sUwpRXRTCxKDk5ay2Cya0LUvflMYJTFFy+fkFPfB0NQnFlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261026121527099003)(11063799006)(261021121427099003)(261022075727099003)(261021123027099003)(261009223027099003)(261102123227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P/NrY+Vcefb2YG7pDm3iANnDdPexcECe4K46JH7YlM+bFT1hbwuFhuF2IkoBJmKi35kXeFl04fLhfrHo85YNMRc0Qmq/HXRxgofUfhEF7Qh74ekxfcqfd5aRNxaACvzE+mEDi29r/9hFq/mcXdXckwpEwwnDF2j5dQ+oOhSJZJRxKgCj+aBQdIw5XKuevi5upQlDAsXWcGFBOnl2Z/ephBmYg1KoQ1v8yy5cuxdy3EgWWcwudcFaVAEAYQ59LDTazYTPa5U6CViNx0OzAa4Za4apghkbM4wyeMcup5p56ZimuPOpasGDKXBMUo6sm4xw9Z2L1w7o15gWqCbWbGiTyiBQa6I0Z0FJ5YD9bng25DtT07yRK5Yu/d87AFIAz+Uris+cTPZGbyxQqwvFAGld4bvQuJdRFIuVrM6Z3HrfNc7wyqhw6RQ71jxhnMDOgu/9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:40.6562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b481a912-50b4-4b28-2d9e-08df3f94ef07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nevenko Stupar <Nevenko.Stupar@amd.com>

[Why & How]
No need to check for a specific variant. The default VCO frequency
is 4.1 GHz for all DCN6 variants when the register reads zero.
dprefclk_khz is 607407 for every DCN6 variant.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 43d1932085b7..8eee54c7d5d5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1753,7 +1753,6 @@ struct clk_mgr_internal *dcn60_clk_mgr_construct(
 {
 	struct dcn60_clk_mgr *clk_mgr60 = kzalloc(sizeof(struct dcn60_clk_mgr), GFP_KERNEL);
 	struct clk_mgr_internal *clk_mgr;
-	bool variant_clocks = ASICREV_IS_DCN6_VARIANT_LITE3(ctx->asic_id.hw_internal_rev);
 
 	if (!clk_mgr60)
 		return NULL;
@@ -1778,14 +1777,14 @@ struct clk_mgr_internal *dcn60_clk_mgr_construct(
 	 * dcn60_dump_clk_registers from 4 * dentist_vco_freq_khz /
 	 * dprefclk DID divider
 	 */
-	clk_mgr->base.dprefclk_khz = variant_clocks ? 607407 : 720000;
+	clk_mgr->base.dprefclk_khz = 607407;
 
 		/* integer part is now VCO frequency in kHz */
 		clk_mgr->base.dentist_vco_freq_khz = dcn60_get_vco_frequency_from_reg(clk_mgr);
 
 		/* in case we don't get a value from the register, use default */
 		if (clk_mgr->base.dentist_vco_freq_khz == 0)
-			clk_mgr->base.dentist_vco_freq_khz = variant_clocks ? 4100000 : 4500000;
+			clk_mgr->base.dentist_vco_freq_khz = 4100000;
 
 	clk_mgr->dfs_bypass_enabled = false;
 
-- 
2.43.0

