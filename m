Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73558C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B5B10F4DC;
	Fri, 17 Jun 2022 19:36:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8372A10F3F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYdaHnYCN3BhEUOkglAlruX+oyIbryU0cxazpCAFshqZmfI3aNVqTdANcmpO2U5RINCSlHOxyChdQ5a2AoLXckZUUsH6/5xcZYlYcLI3pBcrM3YC28wgelaNHhurumUXCan7SKXb4INwoqw05I48fuHWwKS5XttTbsXa3J3gFpgHdr01aN/KYVM8GCSRXrR0kxqhowpFtlEjhkH37cx27SYwDBgW+sUABHcCGcKBoN6sxYUahMHzXdJarWRKckxBEXb8k/G384upxloVyJeZMrOuUc5KwJsHOJf5k5Aaoro5tKviKUXyWMPSBAA2aZCqIpeRwX8LKUmMd3Z2QdG6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0tvICe1j6jdIkNiZW4JeARaEUjBQ7c6F3XpSL91JJ8=;
 b=Wu3YYUIaP6B8ozCxQmWg3QAHGgBW9fiasW/6a/XUWSKcEuA8/pX+CALxtiEaeZmSuqIbgy4qsdwNcirN4QU71Ij7lUrTZhSc4fjckQzXyeTOSXbCzxAtEv6FxbcrJYgWeytVLcuFQrXfGPbLKRhoyIe4Da6l7padl8UzgaRCaQQdwC75NiIP3I6mln1DCzVLGJb7X+lmcrQQgytDdEnztO9+ZO7aNdnudj7Xzgfja6eCXnMEeYgrB/HtYSENqShOzSfZu7x1mGMVfeKnhLnF5c/GP+AN9bjjzgE4EyAVDUIcLnwdUAnN4Xn7NFtaYpgjhU5zPvKk782UpihdUuxESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0tvICe1j6jdIkNiZW4JeARaEUjBQ7c6F3XpSL91JJ8=;
 b=tycwYud9nfKweuR/yG4hQdyuF/mOSrKJ1ci9bzoWnTGhw6sVvcvxxD4SVS5x9YGTcj/i5xZ+/NLjQxbYPZFQ7wO6jWDl/T2NJnw2KOtZGg9fjST5LYP3roslM19vIaScZVNa/bR3Diiip34NQerSzLvLAM78F05PwVdOicm/8Ec=
Received: from BN9PR03CA0779.namprd03.prod.outlook.com (2603:10b6:408:13a::34)
 by SN1PR12MB2400.namprd12.prod.outlook.com (2603:10b6:802:2f::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 19:36:09 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::a3) by BN9PR03CA0779.outlook.office365.com
 (2603:10b6:408:13a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:09 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:36:04 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/31] drm/amd/display: Update hook dcn32_funcs
Date: Fri, 17 Jun 2022 15:35:10 -0400
Message-ID: <20220617193512.3471076-30-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 097db25a-3c27-4243-5bc1-08da5098a110
X-MS-TrafficTypeDiagnostic: SN1PR12MB2400:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2400DFC59F09AA4FD2E8C6AD98AF9@SN1PR12MB2400.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzzlTDPiaQR4JBCrGTFchpbp6d+dBdHhG+heDmhLOLOzhR3DSIE8xNSQI0Az8v2yti5J1ZXBpTg/4ziGV6CaTDa5yEIduvZ6usl8Xco0AKHStnsjCJ4gF5k0H16YjWOijKDbjSd3Box6N64baoyjPkAZUGWtzqriTYrGrlzpac59N2uCyg/VPdFVKXaIdFBp8K4e1bVk4xzxJ1Y4l0A8qkpAI9mqLc7wH/69ihVrdgNQ7x9u1Qj+mSvw6l8k96zYTzrt1cZ3XknJfnfyB0sk1N6qCmw3osP0N6ffCOnrciDRI2+WNnoHGDYpOIvzFJdCN6hRlH453YyW8PHeTzLFTZB5AuVqoepVLKg6M7r9r0/okLIxkxiIvSbi95/edyu3AWJH9I6Bz1f/OF5XZ3Ixy/wt7N3dVjjnIQukriZrj9kLkRPvn/nS18wZroM3FElgFJttbBe0sCxUoFT9UswJ8ifXa+JWz5aVTXAioCNP6gz1gi2UAYeCMg2k3zdro22BtCUYtd2oY6Wla6a1ARy+T+H+ntM5IJQRexHXUwja+idwkGwvc9W4F19n4AP5DEwkdyN3v/rEpmQNiWDgNVB9YoCPSWg8YCek42Wk0xYf1rN7EPyc8M9gstmULVRylE3jr+3jlWYknlnkDq1Rowpy8u/KAFEDaSy6nDuls0JJuG7r1uBmlWr5dI91VYItW/TxYJnlljB14hN4zwpwu8SZhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(6916009)(54906003)(316002)(6666004)(7696005)(83380400001)(498600001)(82310400005)(15650500001)(26005)(70206006)(70586007)(8676002)(2906002)(4326008)(5660300002)(8936002)(36860700001)(40460700003)(81166007)(36756003)(86362001)(426003)(356005)(2616005)(186003)(336012)(16526019)(47076005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:09.3176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097db25a-3c27-4243-5bc1-08da5098a110
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
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
 solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In DCN32 clk hook functions, we are using the wrong reference for
get_dp_ref_clk_frequency and missing the get_dtb_ref_clk_frequency
reference. This commit adds those references.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index b31adf5238d0..113f93b3d3b2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -768,7 +768,8 @@ static bool dcn32_is_smu_present(struct clk_mgr *clk_mgr_base)
 
 
 static struct clk_mgr_funcs dcn32_funcs = {
-		.get_dp_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
+		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+		.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 		.update_clocks = dcn32_update_clocks,
 		.dump_clk_registers = dcn32_dump_clk_registers,
 		.init_clocks = dcn32_init_clocks,
-- 
2.25.1

