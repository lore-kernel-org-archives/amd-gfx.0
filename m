Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD1EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 19:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7266112D9C;
	Thu,  2 Jun 2022 19:31:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E11C112D9C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 19:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMUMN72vHyTYBvdqm9ZRtnnznd6zzB2nT7acikmIChKS4Yo+aX5Pzs0Rcz2CtfOqTnEHU/C/GuCBaS0+EPUEYI+8CXFRECqDxCtT8Ra6Wn5dFklNEpy5q4xYbYMvUM0RtrkYbA3tR2yy6xR7if05xFhVgOR2sZS/03xChLhtl1umquOV2XtCYL8aT7banW6hNRd+SN0s40+uNU3udzRAVQYVFH6DQcnB9z9vchxzvT2sQabr7sUyaDzAe8x2wHNe5vJc66olysWX4hbCyUepefXvErrZWBFcreVKL1evWxT++d1chX85Fh15ulaZ76Y+eRsym+voSrPgv+HXbtrBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mkhqq08VHuu5Ysy6WXOtnCDcRT94R3toWiBjyYK0ak=;
 b=btOVX22iM/3LnFaYbMOeSdHlTlmBBUO20Z9Xrcly6110wX7qM5T1Sz9rKKocj4GugyHkokwUvyDzk+hzltGuZx/0c9V7d+m3pJgtRNeo5+xjwNC5sT7gxR3qgm/+xwLC694TEpbMa4SKSDKfWFARHxGSXjPnxTN/0nVpD/JoEOy4B5KJPF66HhoNVaidMmHDuomV7lNGYckfEGfjnJzwSndngtdzq+0fTGNrOGupAkBepx0jA4tRoAVF+CFn9UvYanhkYKAjx+ycL2d9VZxWs4XvbFKv8rrpFd6eeOezKhGnqAyqOpq+5MvN34XK0a19esajGKZAxvXEsPUC3FdNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mkhqq08VHuu5Ysy6WXOtnCDcRT94R3toWiBjyYK0ak=;
 b=5BJw8pPq04V0XFjjPgFwUD283tJ7qFOxh272kJuW+EaXAhtem8guaW8myWHMCCV3cgb6uB6mow+pCJx/oxjtKZ9Q0uuIjhox/2pXLvYK9obvhQgoK95aAXy25/9+cuxCVgjH/prrAN/+bi3NTX7rzfxkzLOd+zLvLQoyh/ot6dg=
Received: from DS7PR03CA0216.namprd03.prod.outlook.com (2603:10b6:5:3ba::11)
 by DM5PR12MB1193.namprd12.prod.outlook.com (2603:10b6:3:70::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.17; Thu, 2 Jun 2022 19:31:33 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::15) by DS7PR03CA0216.outlook.office365.com
 (2603:10b6:5:3ba::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 2 Jun 2022 19:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 19:31:33 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 14:31:32 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amd/display: pass panel instance in dirty rect message
Date: Thu, 2 Jun 2022 14:03:46 -0400
Message-ID: <20220602180347.754067-4-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220602180347.754067-1-sunpeng.li@amd.com>
References: <20220602180347.754067-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b05ca1f9-e29f-4d2f-e742-08da44ce80a6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1193:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1193277CA64F8F0DA49415E782DE9@DM5PR12MB1193.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcAAX+GgspxEyJ/rsCKh6YU5mx0RNvsQRK/CEFGbSdMuc4KK7ENhD08f1acWnWMkCYyrPj8UbJZH4kShX2JpL8sV8qw9lrut1R2aFr4OXmDJ1bIpfWN+e02O29R0EKY0zKI6+RmFIamFuafFFj2BIzLzXtu8ic35cFPrly321qIKJW4fy5a6eNYPrSbeURmI4gEtUauKdPSu0xT07MP09O7kUXJi+DVs0xnerehZg33d3n762fclHqXzukTlt2oxOahX2n7bUp5xQvF/HbCfYyFh6bmoWxfIMm0X2zxSo+dBDImmU/8ziVmIfL57sg3ZGIj8mRJpjOUqm9W3MYBaPpWNpBv0IbmdXpfrrkWdEFXcupqgfbqHfIfb8eUdGeVdQtVON3/JSAh4lAkqT0jV2jK+MOe72X78SU+wOH9DM4FhR+FUH7M8yunm8PooB+9L/SX1qCGFXrzChkulUg9S/AQSdnFuGq8E8sB5ZwlZfApqJXOrwlySqpU35r3faclVRzCBufs/RsBr6/KKJ2rKxUmqN8eLSob04YS/wPGmjEiltU5Bcm+emR5/gOj/eOJ+I8UTQPaaBWPz7XdjEL739wuKfbpdzm8TaEL08cnQPNQEZ0uX0aq2YJUEmcTI+NdiSvWpjlCn7Go/9pBb/i0bqYbSVWigVHdznoeH+bwz9V78P4BpXNMUm2QMzqlPEP+5t8H9hdstc0LdpAN7n0JrA8OJfqUlTH6u1Qa4rwG93X8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(5660300002)(508600001)(86362001)(426003)(4326008)(47076005)(15650500001)(336012)(82310400005)(36756003)(316002)(70206006)(70586007)(54906003)(6916009)(40460700003)(8936002)(26005)(356005)(2876002)(2906002)(7696005)(6666004)(186003)(16526019)(2616005)(1076003)(83380400001)(36860700001)(81166007)(14143004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 19:31:33.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05ca1f9-e29f-4d2f-e742-08da44ce80a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1193
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
Cc: dingchen.zhang@amd.com, Leo Li <sunpeng.li@amd.com>, roman.li@amd.com,
 alexander.deucher@amd.com, Mikita Lipski <mikita.lipski@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Zhang <dingchen.zhang@amd.com>

[why]
DMUB FW uses OTG instance to get eDP panel instance. But in case
of MPO multiple pipe indexes are passed to updated the same panel.
The other OTG instance passed would be ignored causing in DMUB not
acknowledging the messages.

[how]
Add panel instance to dirty rectangle data and cursor update data
structures and pass to DMUB.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d4173be11903..31d83297bcb5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2837,10 +2837,14 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 	struct dc_context *dc_ctx = dc->ctx;
 	struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
 	unsigned int i, j;
+	unsigned int panel_inst = 0;
 
 	if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_SU_1)
 		return;
 
+	if (!dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
+		return;
+
 	memset(&cmd, 0x0, sizeof(cmd));
 	cmd.update_dirty_rect.header.type = DMUB_CMD__UPDATE_DIRTY_RECT;
 	cmd.update_dirty_rect.header.sub_type = 0;
@@ -2869,6 +2873,7 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 			if (pipe_ctx->plane_state != plane_state)
 				continue;
 
+			update_dirty_rect->panel_inst = panel_inst;
 			update_dirty_rect->pipe_idx = j;
 			dc_dmub_srv_cmd_queue(dc_ctx->dmub_srv, &cmd);
 			dc_dmub_srv_cmd_execute(dc_ctx->dmub_srv);
-- 
2.36.1

