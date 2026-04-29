Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A888FF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABF210E39E;
	Wed, 29 Apr 2026 01:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KER84V++";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9108310E39E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5/pWEhz/hXWQx0VT8wAnppMCYwmaQhilbHD2e9vZqlH0fAaH+9WjcB30qkxLxEdvSOdnuM+OpfRW/NmI3wFNESCtNO+x9FOFiNweypHeHf+mYqNWYpHXYDemHCRGCLSkogML66TsKL5qBdGNxB1/OZ/1gb+cGydvr3W+O3Vk1mo8pkBY5f63urBNZUBO17aB9EI2LSmC4bw7fa2OhABeEmj5j0eW07C74ggegCwe1fH3liQD6N8EvT01TIXjvEVKQrmLURHDgFcRhvFlu/1fzi25P4tdRM9YWGAMahMoFg80pM5Ke7+3947hyfbmzVANix4+p5aH7o4/QUrctn1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jXXet2N7aNXJZLGOUYENB2ynX4OIucXDazY4NxCXhw=;
 b=gZpdKISzoTUp0LZbwZ7rgEDEPvGvrSdpwnXn2eZmxPft0EtHiFlzRGAaEowjEGid+PEH/DgLNQzxH01aDEXmT2EioKURsliyAYDJd809f6tGv8+JL0ujoEQTe5J+hHzhX/ZjdlbwJ0s0f/YJZ+kIJ4kM2J3CPGUPBmANZEQrmAlWllA9G12OztbAMkaYSrR85qvv0FMpDlRXmiraRy3UM8VXPIQf4gs0DMrHxySm43jbi4BW1CHd46szWDTD+U0HGfD/NmcjMm7l1FE5khvw4LQG3hML779HzspBhNDQ0vpErhUxk2mPdHCJdnMgCJ/riLSu5fpBiOZDJCecL/ChuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jXXet2N7aNXJZLGOUYENB2ynX4OIucXDazY4NxCXhw=;
 b=KER84V++M67VLPIFWBuGtaacTItVD0nQ/XDa+6saYZc6jsY7u2zVTmWqQV51/98WSd+X9g53fDREJ3MGeGPgbDj2Vl5bYH3b6KSxQQeRl5Lgr8PvSph34l0YzEfdndgA8cxBNsOHrbkdy+cOpFNdDeHuFquD3cuygBVhcJ+ov8A=
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by IA0PPFA8EB66EE9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bde) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 01:52:56 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::35) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 01:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:52:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:52:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 18:52:54 -0700
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:52:46 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, "Dmytro
 Laktyushkin" <dmytro.laktyushkin@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 07/17] drm/amd/display: remove watermark range notify
Date: Wed, 29 Apr 2026 09:19:16 +0800
Message-ID: <20260429012055.2065869-8-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA0PPFA8EB66EE9:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9ad413-efec-42c7-449a-08dea5920878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9V6FxG2Ln5oGNz2hplIZW71JeBZdNdOegor+ciA+lQ3Bhn5tyQjIxKND9HKR7XnXcsJmKMibsZo7SOQEs09wmqAFL3fzAWoEk2ZsR/w+VFO6aaoNVsWNWNYbBS46paseRm5nfacBepUKjmoO61ydM/OFIxQX/dAOgqKP17Ywsdbil38AqlMoKi0goC/bqgaCv+CkSMFBjF7ZW8ca9X9BP6JMdv5qcnV1EU/d2hVsHPG9h/ONhTPVmr7kViILvkaI6C1taeiIETr2iY7vR1jvfC4msld+rM6GqehxKICtQdTPDoWP/rsYbjI/2rzkeaEgr1ihFQkkCb391qj9RZERVIQLCsHRBja5Vy0sWQ1ajUIYSuZZ6z8JI7xgUHr8WzoBdzNoqKKe+V8mHqT0IT9So18iokd1EoR1V0fuKWFnIqXIXp5+mqetOdO/yYPyn4Zq2Kt1ocQTJ+Qnlv8i2hioCrZHXjh9p/qYKMPVyLWROQERKEpbFWwmpqcdvc6DkeAz8/itgNN7n3x92Hw+IUPYZmmzpvCsss87jklohwMVUC+F3DntyOsU8mUxQ4bB+8HUJC5mGPb7oeA1pmn2WW+ml6vt23psMHJKpAW7vnMQDLmxEFAJlfIEMT9TbD5bde3Cye6ST4IWdLbuzunrt8KchZAsdeAEt0mw3YNvxdEHjymbmC0h5qv6dI5c6zguc/qTZ4/DoMv3CmYNJ9Mh+fUdOLBauw+frf5cFWocBXT/mj8C5z8lPgv6ztbwGvQj/00pmIntReaDIqf54eS/3cvLuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aVMER+E4b8C9Kidq42qxnIc0QjfvkO1862nmcytA63Z7Biqus+4wuYSp/uv8yiidT8HPdviWhZVywCozWtpRaJBGA8Bu8FLOkpuNqlVh2Q6w+j5zlsOD6Kgp00CpGHd/dB/dQQyyOULg4WwblRaayCbz5lR+HmJWCMKpGuOYW8OXFpbl378FQAPsvsDtGsPMixdwmQO4FevcaVbFALRXjqcZ28/XjomqsP33vjN60IfymTY1xYow0rieS1GK8JysFK1aUQwO4A3zWcgYHczhs6uc4xnLx/KTvL3y8S/G/J1nA/L0FL41vvXZzW7ULZPP4AA9dx38JL0dYcxT1lBsZQMCZAWnRBQlqeHjckejW/pAXw5koNd0pDoCrMgXwNoNC7+2Zb4S177wwQ+1U3PyxO1vvA2AhhPdDT1V4NdirAY/Y62BZrZi1bDbSJM/lV0E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:52:55.7747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9ad413-efec-42c7-449a-08dea5920878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
dcn42 only use one set of watermark A,
driver always update set A runtime.
no need to notify pmfw the clock range.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index a0cdaf69056e..c4ed6c3594c2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -1020,7 +1020,7 @@ static struct clk_mgr_funcs dcn42_funcs = {
 	.init_clocks = dcn42_init_clocks,
 	.enable_pme_wa = dcn42_enable_pme_wa,
 	.are_clock_states_equal = dcn42_are_clock_states_equal,
-	.notify_wm_ranges = dcn42_notify_wm_ranges,
+	.notify_wm_ranges = NULL,
 	.set_low_power_state = dcn42_set_low_power_state,
 	.exit_low_power_state = dcn42_exit_low_power_state,
 	.get_max_clock_khz = dcn42_get_max_clock_khz,
-- 
2.43.0

