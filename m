Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F354AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331D510F7ED;
	Wed, 25 May 2022 16:20:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5A510EE21
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Re8TwLopDlgk8BFY48U1G2O9gGmb4rzjqjF355ei8F1rsnqapQQ3j+r04Ta+/LZMDzVycxAVsO9oJII6fBTlgwL1cjSZqIILLtV2iSUPjuzcPfGlFE3F0wgLKGkc2FJBTCILK0PzvjGTDrjUJST9c5TUjKAt6gFj2OyzDOqhobUyDhGhaMi8Wj9flWRIMhyVaA2F3mcC48W0Rhgu9/kJlxrkGAFFKCXZy2oGVXEtDueY8gYCaBmsvVjI7rAFkgELT228fRD6EWBBEnUpLgBWs9vxLm3a+9OCioy7hfHUvop1Jm0ZVd/PT/Y9vsxRsBWObdkcaKuSfAJBMQ43X4H69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79iz72dZIjJdpxZOzTV3PmmyluNn8n0Gyw1XXbq5v4s=;
 b=ETYoGU1kj++TVhBNarvYq6sYHSIxls7zyvXaGCGmdp6zi2/B5uBaOjdHq1TbgaR6jQWOYpGofvCuiOq4YcsvDSg75FOHacK6v8JMwr1etL9O+r1JNZ8Yao5SJBpb/z9Pj114m8pUSBeSYvuJ+pwEaG53jpLe6l9W/4hzwFf13r/yTUSp6O66WQd2ok1RiIszVYbeM3JlKkjG3KJRK/hKH2Sz/NoGTZ2H5zLaql3U7vFG2VoYNXnCe6BsKn1RO45MBsAn13uCYeS/yZatJZ3KPY8fVO8VFnZyUIjPVh1Rum6Mu0QkOLMCNwqiGKOsEzciN53VuzpB2M/FtIYJ68SWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79iz72dZIjJdpxZOzTV3PmmyluNn8n0Gyw1XXbq5v4s=;
 b=no7094h0xktgw9Ow0fIg6d4NP6OiG/sPqXaBS7Hm5d8fwBcxBBWyR3ZFV3Qk5ckq3Gc5zi1V64MhJcVttCzk4ZDoB25YJxiQZx1OJCD0Olinxre/S20ySBXRugC+aXjBIyG7RMssGJu8wUStorC65gV+QaheKRLH9/Cql5/hrFk=
Received: from DM5PR05CA0019.namprd05.prod.outlook.com (2603:10b6:3:d4::29) by
 SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Wed, 25 May 2022 16:20:16 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::fa) by DM5PR05CA0019.outlook.office365.com
 (2603:10b6:3:d4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/43] drm/amd/display: use updated clock source init routine
Date: Wed, 25 May 2022 12:19:22 -0400
Message-ID: <20220525161941.2544055-24-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef5b8f24-1a9c-434a-25e8-08da3e6a7453
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25427F4AB50C4EE99F7613A8F7D69@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLQnxCIMPB1uIsTzZDqakrfYp2+B9PB2zdak+6WxjsPwwHI3p0nb1nSROeIvru6QLy33SqEQ0Fe5BeHI6tugVsqrnD/ko9uoAgNjrY5Rgbeogv5GbktIpyoNKl6Njqk608LMyzjqyeu0lA+mI7AK2V0iYMzJNKVdZXs2kxdt/GLmRNmcXdLX0tgj2sw4/jCmelWXvJmzs5QAufAuwZn/iJYeEwiO+gfc5Mq0v2XIaeGMWv4J6HTIfvKafw1c2sQav44Ui48gWyn0L/VWuWkQkbDErbYjuNPCtx/fZLbhb8ALbIeEvYReaImGniD5E4DT3SSvFauXofeQ1rP3FYfWC8fYSlrlso2f/O8LhMoei0Z6e7AW/ZFLMDwOZjxpi8eA43KdDc76KG5CYODjCHTUvwzo5FHJHPgKXjzorOabGRjWz3bdQT6aWU4ftmydD/tvr+Sf880gDYAhQcc9+HHAYppPL4PCF7HUG4UUKIIGc0gxlz5Ah3vRYo3bXS/3Y7gNf0I/IrJtrIBkC82EDtay53qc8MLt9Jmr1jqH6xTPUtHwe7brqKdG+VitD3RQGNYsj2is6U261JqUzJ6+sUTLSorsGwlUok1qlC4yoh42LoHS7tPgZgL/kiDC2LqbAhpDYYk7/CzrmzUNbU7lDgTtSp5EhgrjFGOK0lM4EeRt7eaoDmp87Bmjhf1XmpQrfb6IAQ7LBsccxZ4Q1juoWM9MpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(426003)(6666004)(54906003)(1076003)(6916009)(2616005)(82310400005)(26005)(7696005)(508600001)(186003)(40460700003)(356005)(83380400001)(81166007)(47076005)(36860700001)(16526019)(86362001)(4326008)(336012)(8676002)(2906002)(8936002)(70586007)(70206006)(5660300002)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:16.4470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5b8f24-1a9c-434a-25e8-08da3e6a7453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Charlene Liu <Charlene.Liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Use correct clock source initialization routine for DCN32/321

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 64d1a6bf0683..7772beadd000 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1090,7 +1090,7 @@ static struct clock_source *dcn32_clock_source_create(
 	if (!clk_src)
 		return NULL;
 
-	if (dcn3_clk_src_construct(clk_src, ctx, bios, id,
+	if (dcn31_clk_src_construct(clk_src, ctx, bios, id,
 			regs, &cs_shift, &cs_mask)) {
 		clk_src->base.dp_clk_src = dp_clk_src;
 		return &clk_src->base;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 28e4d7904d54..0b420466b6dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1088,7 +1088,7 @@ static struct clock_source *dcn321_clock_source_create(
 	if (!clk_src)
 		return NULL;
 
-	if (dcn3_clk_src_construct(clk_src, ctx, bios, id,
+	if (dcn31_clk_src_construct(clk_src, ctx, bios, id,
 			regs, &cs_shift, &cs_mask)) {
 		clk_src->base.dp_clk_src = dp_clk_src;
 		return &clk_src->base;
-- 
2.35.3

