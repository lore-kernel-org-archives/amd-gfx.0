Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDD2C48BC4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 09:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A093510E246;
	Tue, 20 Feb 2024 09:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZdAlYB5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CB710E246
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 09:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TistbtXTDnKr4ThWPxCxJ/6nLtOJIThS9h9T7fuBf98xvCES+5On4qDsHFIr8gwr7lBZ1l8fSU7LBUHDHHEFF7QcjVbYA/HfsXxAfhuQPyS05JHGTJYYXHQjSS8jIURR0qchSYqRiIOaULzGnaGQYAouhB2qGF3QvymcPJ8DyojTsxLgLbJ68W2MVBstSGevse05Tgj2jwfYpO7g9OvwZkKLmYqgZ/WEH9bBPGAO7B7DHotTHKC5iDBzsokOP/5yBZobrhK7dS7P6VsmL0ycBuzdPAyz2WCAdQKSV7m87LwYpvq5+RBG3g+WVUIg0tF1XVavOylSZZMUxc50HrJA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsaJJCpie9s6GrF9fm/geW+tF+SFWaH4sYNvv5xLUHQ=;
 b=EbdOTS9LybGhWUWUhJZqQEb9F7f1LgPMeto18+bC0K7u3uWqCJ6zYb3IDZSBGaI0gKcn7/P0ViqpI6B4dmgUDXaOHtTAXWI+eZG+8lmhIFNTVqygsmY6VHuMJhEj3yAYAmaUH1CC8pqp7ujAk34N5qMUj+509OcHBaQZ/D8D80I4jU6LjuHdAwY2fq4uAgLeqOoJF3/q6cfeTfmsfldjVBc2EXadaP4ICNTZlH96K/5ayJaYx7OOlU+cc/mPLjQmb7+b6lxSp3MA/BeUt0bKTxnxKl/6f4fAd45a8wUyI23Y6GJP+eafcyBIPAKaJ9BtLS3OtIT7j1kE2pHKyjgOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsaJJCpie9s6GrF9fm/geW+tF+SFWaH4sYNvv5xLUHQ=;
 b=mZdAlYB5wSTbH/hN9EQgwURJE8SAwHfT8WFLd5qAhojIr6Yr0rcSIa/XMb328c8/DWJGX2wjeW6IdcttHqgRf1TQzs1A/ErnfQOXhdLDCLDR02A6FZ2G1P/J80hWnzQK3HiIB4wIMX2kXIGAO/EBglL4tv7ETzMv3eac2qFnL1I=
Received: from BN0PR04CA0134.namprd04.prod.outlook.com (2603:10b6:408:ed::19)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 09:06:42 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::76) by BN0PR04CA0134.outlook.office365.com
 (2603:10b6:408:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 09:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 09:06:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 03:06:37 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, "JinZe . Xu" <jinze.xu@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Josip Pavic <josip.pavic@amd.com>, Qingqing Zhuo
 <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix potential null pointer dereference in
 dc_dmub_srv
Date: Tue, 20 Feb 2024 14:36:23 +0530
Message-ID: <20240220090623.4156779-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: a65a37df-fd08-478c-4ea6-08dc31f34121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zwd6E0PY+9LZJj3z4Lp7ABFfOUhPQHmlqr0b00EUvGXf0N4AKOj2B0YTsb7LPA8gtMLoBDgS0QndOozTKRikX3GX3VY+MJKpu4So7bAvwuZks1/7BRved+YROrhOue15fDP2V4y8xEvapjII1W/V7Qc/0vT2lJ0OgZS3oFzinp3d5go1642N0E3syHC/BTZbYWxE9KRoKgEw89D4FqW08VYE6619egVCd+7qOFJWib3dgY9jcEUfRpPpvpuyFFETsoVqAyRFZySMnNrANZOddYRk123zRyDkDpQ3BBGLGDccABePeu/nyZ38sdgp0055QVLDE6IM9kdRSv3jl4i+auxeD0VQA7UMxTnDdJrdEAsxIcvKz9XKealzNR0Tjm5vqKTXV8WXBWo64MVBWs6CYAzcTtnJwCWodGdBFXMvt4bBuMR8IJrQBRboLA8bVpV+qv1rXc0BqL9o+WI2iD3UDCgQCp8pj6Z6VtqCwo03X25KWHb0J3tMGLHc/rMmgtXWqyNQzihOMTqx0mIJEuf9uDQpdJ1xYtrhGQXX6uBKxFeMViA+C3c6DsXcEw11Y3WbIdIj5l5OOz9593AXM948FMuwSjZ6swp0Hffw0UWJYQyxYDV8hUo6IgEOZHkiZSH46ufuY7HZMt82NKcM6Rkl9SBffquk8upDRTco0oouDzE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(40470700004)(46966006); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:06:41.8814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65a37df-fd08-478c-4ea6-08dc31f34121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
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

Fixes potential null pointer dereference warnings in the
dc_dmub_srv_cmd_list_queue_execute() and dc_dmub_srv_is_hw_pwr_up()
functions.

In both functions, the 'dc_dmub_srv' variable was being dereferenced
before it was checked for null. This could lead to a null pointer
dereference if 'dc_dmub_srv' is null. The fix is to check if
'dc_dmub_srv' is null before dereferencing it.

Thus moving the null checks for 'dc_dmub_srv' to the beginning of the
functions to ensure that 'dc_dmub_srv' is not null when it is
dereferenced.

Found by smatch & thus fixing the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:133 dc_dmub_srv_cmd_list_queue_execute() warn: variable dereferenced before check 'dc_dmub_srv' (see line 128)
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:1167 dc_dmub_srv_is_hw_pwr_up() warn: variable dereferenced before check 'dc_dmub_srv' (see line 1164)

Fixes: 01fbdc34c687 ("drm/amd/display: decouple dmcub execution to reduce lock granularity")
Fixes: 65138eb72e1f ("drm/amd/display: Add DCN35 DMUB")
Cc: JinZe.Xu <jinze.xu@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Josip Pavic <josip.pavic@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - For dc_dmub_srv_is_hw_pwr_up() move 'dc_ctx = dc_dmub_srv->ctx;'
   below 'if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)' (Tom) 

 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0bc32537e2eb..a115e1170ef5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -128,7 +128,7 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 		unsigned int count,
 		union dmub_rb_cmd *cmd_list)
 {
-	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	struct dc_context *dc_ctx;
 	struct dmub_srv *dmub;
 	enum dmub_status status;
 	int i;
@@ -136,6 +136,7 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
 
+	dc_ctx = dc_dmub_srv->ctx;
 	dmub = dc_dmub_srv->dmub;
 
 	for (i = 0 ; i < count; i++) {
@@ -1169,7 +1170,7 @@ void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, con
 
 bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 {
-	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	struct dc_context *dc_ctx;
 	enum dmub_status status;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
@@ -1177,6 +1178,8 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 
 	if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)
 		return true;
+
+	dc_ctx = dc_dmub_srv->ctx;
 
 	if (wait) {
 		if (dc_dmub_srv->ctx->dc->debug.disable_timeout) {
-- 
2.34.1

