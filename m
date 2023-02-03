Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD18C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49EE10E7EA;
	Fri,  3 Feb 2023 15:25:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB1710E7E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7DW2uh6JUJSFT8aEI9AUKzIcCijdbOhqk8GN5vz7M+P0vbE5iXW/HsGIpQwHhXBZTwfx3theohmAUW49se5AU5T/MBI7y+s4fI++y5JYVdwqVFGpQF4Fbc00YrU7dsqlFi2IBg8L9CrsKV3XAjugUYSX2MGxokzC8sk3sRTtgHfbgcPGr9aZlyGEzKawhkcZ9h5iQqbBu4Yss8YfEB9H6RNBrdbsisPyS7emsOpQhh2Rsz4JnU7C3xi4h0aOn0Xvlgjhvz95MIQozdeUvrsxpiFsoEjbXpOo7mzL7Ct+IRJgLirJKz25WJhPkBZ/JBbFEf/rBevXp929h2v89Y7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjGPSS5GOvOiIzt08AGzSh1GZ+Blb8TUozcZeZctOmU=;
 b=VUXHlTdlPj+OuuuiyaYruSrh4Hc4sxvQJwC3NI4X2lgZsR1l2GzuqEkdDl7UNwU4+nHhzSLTnuCrHa2hZxiKJhst0oVgp+88BWTbISBDYgcMgJxPlRLiwzQhuf+I9DDWvL8pAtX+vjkIkKLOq0FgonPDfvaXzUdJZmJwMTIQljjzxiD3pcVGsbslq0qK6aj1IMidnGs3EUrWPqjEbDe6OQjZj0nyO1Y9o5o1cuQgVXkMaynyA0vLbAg1rtzS2e5G9kogwwCmtnIyOq6etz9rD6A1kXanWA7kI/WGu7e7QVgmSzrAh9cv+CY+6eXN9+VX5ak1J3weG/JYSXEqmvF+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjGPSS5GOvOiIzt08AGzSh1GZ+Blb8TUozcZeZctOmU=;
 b=bjWukv92drSowt1mrJnoigW4DnQKbfVvXdSpAV4BdqB1YNyFahhzYm3Y4RO9Lsp2WHwYtp7lyCeycIeJdgHOzoZoePOmw4/gNqMnw7DqPPQwMRZMQZOk03Ne218R3IpfTm9l5G0V9TS7xm+Q1j1xQOsGxTc/LbydVy0x9wyI7dA=
Received: from MN2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:23a::13)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 15:25:26 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::d5) by MN2PR03CA0008.outlook.office365.com
 (2603:10b6:208:23a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:25 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:23 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: Do not set DRR on pipe commit
Date: Fri, 3 Feb 2023 10:24:41 -0500
Message-ID: <20230203152452.1441747-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b4d752-c2e1-4276-fb7e-08db05fadfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEvINzc6HydgtMSo3bPhwbHKP8yU/ico/KJSrZ3gYlm2vigKrRmslE3i9/8VDwmFL1CX1sjxGoUpSXjy4x2zuL/p8YRqpkBBz0BDlnusCRzmRVqHdA3vzCberrtHH4jVl/v+4ToeBWKK17pdzGKQwLPQIuah1LDEbuVoeQiPrOwEZZi6xaA+YNzV/SRsfyLOOyecM93sA7sQ6mTp72DuzMPf952ZNnFqBDN2xna6MwxpxuE8Z6Hb3pP/dkZJMnAufrNHUaD8Cr94fnuGbeUejirtkf91P7B4RUDdPi7jE6WEaAlnUNVaVchOT2R6K0klx4czx8EduLBZpvRrjUsuZmYULsIit5vLvXzVqg3yaSdw/xhNY1IyjLsp6gfDP3iGjydGzR3ebHDOXqjyOkTEzlCR4K+k1oCAwKxDKt3WcPd0t+lEo5mywzkb9x2eNH2IDa4oWoUtIql5c9sae4DqS7pkPvsSiI8TEacVU7AYbRX3TvY69Y8NMywGSb0Yc9e1UBR8turxe0HoJhYxeQ8ZGPcMos8wfaFcBbPBiyb88bAHsUtd8WcOFyAdaF074+2I+w51rUGmTjZx6UWAC1qHANZlwBH4VUSyvti9ZUp4DQOQfYVhcRS2GkY+U+f7qSt38PkE+ZqsUd5xDI9BIHGYwt4AwK9SPAejaliwyFEui3LIuNLGv7H6Iyb3S3z66DX85L335d2W8ku0WAQmxoMIh/0/wmyOBrqIjMWqXsD59Xc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(426003)(8936002)(36756003)(5660300002)(47076005)(44832011)(40460700003)(1076003)(6666004)(356005)(54906003)(316002)(82740400003)(478600001)(81166007)(336012)(8676002)(70206006)(70586007)(4326008)(2616005)(6916009)(83380400001)(41300700001)(86362001)(36860700001)(40480700001)(16526019)(26005)(186003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:25.6704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b4d752-c2e1-4276-fb7e-08db05fadfca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
pipe commit can cause underflow.

[HOW]
Defer all DPP adjustment requests till optimized_required is false.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 444f9fad3de6..40b6de19a013 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -997,8 +997,5 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
-
-	dc_dmub_srv_p_state_delegate(dc,
-		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching, context);
 }
 
-- 
2.25.1

