Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB6C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834B510F654;
	Wed, 24 Jan 2024 07:04:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090D410F64B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKUdxiBOYXL9ms9R2c1ofRfagvyLRxJ9Cz3UtQIWemuv+e+1HogxebXHIoqwG+quv31/4eHT4pdrkNNC0LQ7cHDzbgVHgr4JTrWvopyeZK76BNKzc+mNUORESrZNaDGgA6UCvWX5prEQzNSJJc+U/2Og6pEQ+bL1sJ8r2d438oQvoP5eMyuDjCyUr+Y8CX6c9uf/AtDV1GtCGM7hz4C2iq5uPjWrdHGSN8O1B7mI+yQeFN8A3dWHKo7MLFUaxiWD1XKwUWIYVxPIj0iHR2e37QGf+uhrrfwmBv4xxfIdVaTtI1c3a+lHuFtEVAXYO6lgVnBGOPx7Hy6nI47eyAAVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHHWXkf9z7ZiT/F/01Ubts6dQHOrqg/kz6skDGg6l7U=;
 b=h3w8poBJ0cbfeJ8L9dvCClnMF2VJ1W4ow+GVSCqTs+/UXkw9pzH6YAuPzLXHIAXVAAw23Gei9o8Tb1KH3qxaN9+BEG2F0n/AWBps9LgKpNwY8MbmxWfB1xJNo3sM8bPv+XzU+MJdCvC3t96fRRVDaYAnAT42fsrFrB+FI3LlKQzHQe5gm780fZy5N1ru9v/+GGCl+9XtqNtzPmkIzC+cSEpt2YDGeKtlGwkuagzIqq9wN9Y8CJZHIoY3bB6K+28tcPuRddTAR85hlOB54zgF3b3pQv7QNXLDb8UAEIG36tOjAhPqo5o3jMIulNInUI59XjCyl7zwRFeTsfgHuRiepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHHWXkf9z7ZiT/F/01Ubts6dQHOrqg/kz6skDGg6l7U=;
 b=y4noY9N8mg4mPKKJxlY/MhD7dMhBQOPP1HXk+iLcyA3QroUmTrPM5sTnm+pK3QWJikgfeVJ3iPftsjEY+QmI46MFScsjnyg1z0tXtTQ8N4gRNFmawI485m6Y7GaOMd81P6ilUNkU+dLHALIDkqY7KBUduDsQOBbFiC0miwPn1C8=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:03:58 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::30) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:03:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:46 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:03:10 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/22] drm/amd/display: clkmgr unittest with removal of warn &
 rename DCN35 ips handshake for idle
Date: Wed, 24 Jan 2024 15:01:55 +0800
Message-ID: <20240124070159.1900622-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BL1PR12MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: a8604456-fc79-448c-5c35-08dc1caaa2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2t8NS1MkBEZkzdro8keoBuy/GJXNFWl8ycPh6K1gEixmJkrMjn08HxrhaETiZAhiWtMCvd9Gio3ni7bDE3LMni1XDUasGNRrpeW5eY7CAcQkCYSr3EZcKndTxjanmAq+d4zNcnami5k3FaNUcyLFz7twbxUoXcNRJZ17yrPQKZqwkC1t0AyWoGQCh6ZykPhXUiUxrP2EpS3966A7PEOq++YGUYqajxLqLtrT/D5IioZQ5buoiHIEQnhawoxT8h+IgHpPxL161QPMTRuyFZsryiGv8memnanfWOiuXGvP/gGUWc/i61qQKcTIfRo7JYSI1IBJc37ABCtW+w1M2ouXp4iReR5jXSUj4f1QXAz7asbf/mcdKBH7AOM+qkAFS5xL8rQefnYHj6iiYUvTI786JOlRSHp2h8YIc6sQ20LQthRL6mKcKR3Ng5iTNMdqhfBPSQbfPuWmSoR3v2V5moC72r4HG+0SuP4SPkHimQoDoCAx/TLbRZX3pxWZ622FLRWvY39EUNW1a+Op9qm0JHLRQhEEs6yw1+mUwSGRhEwVPQEWeCPgE0lLmNyUJHaNJKbc9JRCni0CwHE/Vzt7M0mXBYEWhSsiXy7SzkAn4URt3RlNOYruw3FMxPudg677yek0wd8qlQf4didzFG7rXpz9bAc+u9Z/3uz5F+svIqBmLpcbeRLGYK/SUtsaPfWipGHZzir/JxxTGtPWhdp98Zpkd54UB3vD2XSNMyKBif6A4M1PwvuosRDiIfRVWZjhYlg+UAI7VIAhWfeYoLyjv26ddq+fo29e3eee2oKQy0vXaiIXj4/t0/p3E9kbRMLth1TOYDVIVKyjOLS/FbVPFSwnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(7696005)(2616005)(6666004)(336012)(426003)(26005)(41300700001)(83380400001)(36860700001)(4326008)(2906002)(5660300002)(8676002)(8936002)(47076005)(478600001)(70206006)(1076003)(6916009)(316002)(82740400003)(54906003)(81166007)(70586007)(356005)(36756003)(86362001)(40460700003)(40480700001)(40753002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:03:58.1294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8604456-fc79-448c-5c35-08dc1caaa2e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Mounika Adhuri <moadhuri@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mounika Adhuri <moadhuri@amd.com>

[why]
To Remove warnings of clk_mgr.

[How]
Added code to remove warnings by resolving redefinations.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Mounika Adhuri <moadhuri@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index eda39d739ff9..06edca50a8fa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -830,7 +830,7 @@ static void dcn35_set_low_power_state(struct clk_mgr *clk_mgr_base)
 	}
 }
 
-static void dcn35_set_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
+static void dcn35_set_ips_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc *dc = clk_mgr_base->ctx->dc;
@@ -878,7 +878,7 @@ static bool dcn35_is_ips_supported(struct clk_mgr *clk_mgr_base)
 	return ips_supported;
 }
 
-static uint32_t dcn35_get_idle_state(struct clk_mgr *clk_mgr_base)
+static uint32_t dcn35_get_ips_idle_state(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 
@@ -972,8 +972,8 @@ static struct clk_mgr_funcs dcn35_funcs = {
 	.set_low_power_state = dcn35_set_low_power_state,
 	.exit_low_power_state = dcn35_exit_low_power_state,
 	.is_ips_supported = dcn35_is_ips_supported,
-	.set_idle_state = dcn35_set_idle_state,
-	.get_idle_state = dcn35_get_idle_state
+	.set_idle_state = dcn35_set_ips_idle_state,
+	.get_idle_state = dcn35_get_ips_idle_state
 };
 
 struct clk_mgr_funcs dcn35_fpga_funcs = {
-- 
2.34.1

