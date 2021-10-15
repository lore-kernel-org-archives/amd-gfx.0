Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F825C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9C960C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E9C960C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 813A76EDE9;
	Fri, 15 Oct 2021 18:44:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332CA6EDE2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiT+5jD482svEL6Ks/W+BTgRuRuoul1DFLJsFpQbTPEYdmm8IwbU4qJ3xtRDLC5BkaQjfx+pemTK/Q82llWPsAUbgGZ0GmNIUZqnZj12wCpmaEX1WyhI7aWHxAf8c7308xDxhBmMGdg6BCSpL1yk1eMBJcJdQxZRIezZanyyLp0RTMYfxX1eEQIDWpueMr3rftDWk2F+uH9GC7Qn/Dy5hbhZymqLbQWp+xcjlkE5PV32L0Hy2LCOHm8b9RiGZCh/2EoZFce4D/5kGQSY6w7BeZi5PZuU8PfWqFQPEjLRSBoXzwiWYGl5mUkBTNDdrLBXa4Rd3qkXr4Nu8msp/Wl9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKJcUPLlI198ojUvWGZcRH6skaIwwxZk5hX37AoUJqs=;
 b=hfTG4NHeH5JKEwcxjSmnRsNqc4h2MZ2fjQh4hr20Vuz8pjOOrMrOmKxIEBXu1EQMGpia/LK6dK6/D7Kz/2E2uRCtZiLUx+NxNormQtmrFDaLWhFSkJGKAx/7QomyMNQuWK+HMDBQ2S0Gq9AH1tIOZdb6ua522fUB1om6XplCpE92ut6ZLwJm30mf1M/F49iGIVLTxmYzfbuhy577Sg1M41PSZPjo//aMY7IWVuKH5L3AOli3Vrp5OJjiNUV9TQKbyXwdENBmVH6MS+1Rlv2BTjbPQjR0+ovpykWeyMW6yHnShO/bPPW7z/d1JMWX74RJQ0n3q/q17CDATuf/iYgQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKJcUPLlI198ojUvWGZcRH6skaIwwxZk5hX37AoUJqs=;
 b=fJ4ZShRQ/OA0FiiTLQNsWgbOMeXuU0sBneRUaWvnJRd8fNBHR7B9O8Xw9/21Onuh7ZWZ75RGFDvY+cWuLbx11AJxvqc3ZVvRYSSqSaDyKZJbNKYJpofMJyrjmyJPx9Z+eletldJqYxrQMxl8bJXwL9s8z6I7QflLIzmNSn9BQ40=
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 MN2PR12MB3150.namprd12.prod.outlook.com (2603:10b6:208:c7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Fri, 15 Oct 2021 18:44:12 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::b1) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:11 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:07 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jake Wang <haonan.wang2@amd.com>, Aric Cyr
 <Aric.Cyr@amd.com>, Eric Yang <eric.yang2@amd.com>
Subject: [PATCH 20/27] drm/amd/display: Moved dccg init to after bios golden
 init
Date: Fri, 15 Oct 2021 14:43:25 -0400
Message-ID: <20211015184332.221091-21-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc1d6c69-b403-4252-978b-08d9900bc79f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3150:
X-Microsoft-Antispam-PRVS: <MN2PR12MB315041C645924FA570E1066EF5B99@MN2PR12MB3150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeInO3W3OgwgGsHEbmw7AZzzMRfqIxn6MIhAmhsUhiN7qX5A6SqJd2EwpF4VZFoCsHT5aqG+NhPbtvUeKTGSMAd1buANcqXyp2QjFY8XqD/WFrkdEJyqy7kHn90jsLhfpkjkgDCnm2XfKgP7sR5Bsnlh486xL2tV3rlANDFzPtJOSsbu5RjxZBCIFzZb/SdkZUdioSKLI/V/8CrJzGd0UMa4VC08uDcnf5xSUGY6WT+ISRDNb+v5Xs9ggaq/IbiEEjnUHyy34w+KUUS0laCy0pootlSSmVK4LnAWaTuz0kaysgKWX7X/zuY9p2nvYLf12dOmuw1vozf3uVK5oOJSMPHMRLcSImb9kOoe2bSznNHqXG3Kp8fP2IX+GFHGNdwXXOqVd6ui31aty+tHatm0eGAIay1B/Z729uMtyM9QWaQb+gQ+y6wlB4uOGvgayC8qQBAOecHLgtUZFgRKxpt91udorksFQUUPgnWo3EZ0IgS9eB3qzm++qVYEyn9pnRzEVYFVmR6CIWVl/hjWv6z2wRneAYPpdaW8b96g1pXyhi3c0cMKghCbsxfQzVJSRCGaom3s3R0T2186j766Yr9xirVx5FYbzXqR/8emkbCcyDizfehEplNFMWBr9DkvQmreyPHBZRnhyciN24WT/OXxsjiA36bMgnI8SI5cK0Af3ziY5xOuuz4qsyWD2NR54R9SKbE+P/JymFkSFCmrYCRsR5fajgLO4CrmtgKegYobmOE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(2616005)(26005)(83380400001)(81166007)(426003)(16526019)(82310400003)(47076005)(5660300002)(6916009)(508600001)(36756003)(4326008)(36860700001)(44832011)(336012)(70586007)(8936002)(1076003)(316002)(8676002)(356005)(2906002)(54906003)(86362001)(70206006)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:11.6991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1d6c69-b403-4252-978b-08d9900bc79f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
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

From: Jake Wang <haonan.wang2@amd.com>

[Why]
bios_golden_init will override dccg_init during init_hw.

[How]
Move dccg_init to after bios_golden_init.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 65f66687af4c..186d08aec812 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -77,10 +77,6 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
-	// Initialize the dccg
-	if (res_pool->dccg->funcs->dccg_init)
-		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
-
 	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 
 		REG_WRITE(REFCLK_CNTL, 0);
@@ -107,6 +103,9 @@ void dcn31_init_hw(struct dc *dc)
 		hws->funcs.bios_golden_init(dc);
 		hws->funcs.disable_vga(dc->hwseq);
 	}
+	// Initialize the dccg
+	if (res_pool->dccg->funcs->dccg_init)
+		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
 
 	if (dc->debug.enable_mem_low_power.bits.dmcu) {
 		// Force ERAM to shutdown if DMCU is not enabled
-- 
2.25.1

