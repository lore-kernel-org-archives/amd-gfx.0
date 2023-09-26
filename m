Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AE8E7F13B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFFC10E43C;
	Tue, 26 Sep 2023 21:54:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDFA10E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcTxSlVGDvbnry+mvb/fkKANnGTf4Wfd9++6MGBr9aabchNe1ObLkSsXSRd2hBIo7Is2hsCxvu79PE7eMEEKZmHtahBjI1A/S06dFNUV8AuQaRGPUtu4AAtFsnWsvc8GJn5z0MEHhYfdmW0E0r3K2646iZDhJvIvhBrZPjKsmBXT/8BaT/6WG/hQEHruSJYXgqdysgrWO3H4t8jIn6GkMLtJdsVqYyknF8T12YCkdIsSXbdW7STF3/Y0eCgwNUOLK5RAV1KnwXiZE5Hm2mZFbd9+XjG3SkfqRGUvZO1TwyPdG2w1xqvuXNlDTcEQQcVihf5UqOz0B5oIOeGnpA7T6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcAQaZy15pueI8O4UpBulj427DzxGUqJhPaaPtozENw=;
 b=J3KoRo00KjluAdSW/5uIZVl0P6tUJllWncAlIdLqMnYu8GExil6A1/uER9Xnta6lAEJ7lzoEsG7StonFAIYv8JOW+NBQRciQLsORG35BSzRQ8XTiFxKk68xoewOHNzNJ2hipFJdicxXOaJbTsCQ98MGWQdWxvBzo8srW/dDp9EJ3ScA0tZ4+uXBYQ9zXhFN3Bpoo0hrsKSFLNLHH4Tbm7unbsDpfl/yMnEaDA6JcJoYxHaRuoQ7uzTCUhtRtYH8tcHV/4TXk62zriIuD/V1bEuJN6FZ/35D7C1TbAQSdLRPc2VOPfTQvql/eDkjeOAv8hIZb1iQuJkIvH3LPWO+NHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcAQaZy15pueI8O4UpBulj427DzxGUqJhPaaPtozENw=;
 b=SJa79bkQa7L5dxfD3yi1UDbOmhR0xmwCYfK+/4Uy652SYFF1CiW8Nr3/H2bOa2HQ7ybFwTd5frqlpjDxfc6rBzjbHtqHI25g2ofUesWmm3yLP8B1dg4MufduMw15p1s29qNvkatPM146auvxUWNLxULi8gd8wyayEoCvoF+iMww=
Received: from CH2PR08CA0027.namprd08.prod.outlook.com (2603:10b6:610:5a::37)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Tue, 26 Sep
 2023 21:53:53 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::8a) by CH2PR08CA0027.outlook.office365.com
 (2603:10b6:610:5a::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:52 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:52 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Add a check for idle power optimization
Date: Tue, 26 Sep 2023 17:47:01 -0400
Message-ID: <20230926215335.200765-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: fd14b8cc-8df1-4cf6-837d-08dbbedb136e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZK6RLmBgpkNWEFt5dUTwQRHJIoltNiPPQ3jrMgLfNQSk37JMHNgM2WdWue+byqYW5X8ZvXZoSaGgAvjYHv2qOVLUVhFaC8o3cMarrcqVA8LtISCwDUKb5mhfHDdSAuPadzd8U1xgElGkGCvu2DFvT8Va3+qOoKyws4G4tSkSnYrPGeCozrPvnB8HmkkoUS6Slp8XPpXya+TZINKPXfecYjHc5gY/13SEKu0dm99+43CAzio/XCx2vTfzusrClhF75iE3d3UKIAdJ2Dw6VUrvRBkqPgmkmG5+6PAMAdI446G9en398S+wskR3bFNhyRoATO0dyQZRbVSEzEH5O2olmCen3scGsM/diGezFEMHofOG0mzNjIOMGBP5JntceLFs8aH5BLozLtWUUhX0KxanoRo5iobpQGbU0auCBSqQOu3kNCxkrRXzKvrefUAovtutggrI8CrmXuW8eDua+awDpsgQiAi6HWgS5ksrzqRYtQ39BYCZAbq14Mc/qChgjrMhk5kxETjPEtk6pL9mUeZGdzVmCnRNsRMlSn+oThuCP6C/hMQj8R1+1bYAN8j4lyRUh23NDUY+5eoTIu+z7lVarM0bvDww2e584bfK0zicWaWSpLzXY+NxLauLQKxpZ1zjqT8MAxJJ0TUiUy0iULjjauU5R9Tl/lKXLwY8b2/My18fsG8Sg7N1uHgYcF5T/J/RRxzYyMiUJXlXPREsVPmHMUkzo5Ub8JrqhBZ4Bhm63/GPQ2qQngSqm3fRngXlP0hutXBdDbShpQPGlYjjdUnSXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(2906002)(47076005)(356005)(83380400001)(36860700001)(81166007)(82740400003)(70206006)(54906003)(70586007)(26005)(5660300002)(6666004)(7696005)(1076003)(336012)(8936002)(4326008)(478600001)(8676002)(44832011)(316002)(41300700001)(426003)(6916009)(2616005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:53.5400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd14b8cc-8df1-4cf6-837d-08dbbedb136e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, "Kim, Sung joon" <Sungjoon.Kim@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Kim, Sung joon" <Sungjoon.Kim@amd.com>

[why]
Need a helper function to check idle power is allowed
so that dc doesn't access any registers that are power-gated.

[how]
Implement helper function to check idle power optimization.
Enable a hook to check if detection is allowed.

Signed-off-by: Sung Joon Kim sungkim@amd.com
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8beb7324c421..ad844c904279 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4805,7 +4805,8 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 {
-	if (dc->debug.disable_idle_power_optimizations)
+	if (dc->debug.disable_idle_power_optimizations ||
+		(dc->caps.ips_support && dc->config.disable_ips))
 		return;
 
 	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->is_smu_present)
@@ -4819,6 +4820,23 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 		dc->idle_optimizations_allowed = allow;
 }
 
+bool dc_is_idle_power_optimized(struct dc *dc)
+{
+	uint32_t idle_state = 0;
+
+	if (dc->debug.disable_idle_power_optimizations)
+		return false;
+
+	if (dc->hwss.get_idle_state)
+		idle_state = dc->hwss.get_idle_state(dc);
+
+	if ((idle_state & DMUB_IPS1_ALLOW_MASK) ||
+		(idle_state & DMUB_IPS2_ALLOW_MASK))
+		return true;
+
+	return false;
+}
+
 /* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 51272f895c24..00710f784af3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2358,6 +2358,7 @@ bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_
 				struct dc_cursor_attributes *cursor_attr);
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow);
+bool dc_is_idle_power_optimized(struct dc *dc);
 
 /* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index b99db771e071..e43e8d4bfe37 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -352,6 +352,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->init_reg_offsets = dmub_srv_dcn35_regs_init;
 
 			funcs->is_hw_powered_up = dmub_dcn35_is_hw_powered_up;
+			funcs->should_detect = dmub_dcn35_should_detect;
 			break;
 
 	default:
-- 
2.42.0

