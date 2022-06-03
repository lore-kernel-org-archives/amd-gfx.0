Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410D5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 16:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB7EC11327D;
	Fri,  3 Jun 2022 16:33:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E808311327D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 16:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfZyn4XmKKp3u/c8T8nsNxmjTIIp5n4jFWj42w2+YYqpqn2b3f00hZZHZB3PX6PFOSp7BSQW3oll4IJVwGaqLmyp+FCDu3neR3wBbl2N1XU1I56YAhVKk203bSuiHYpjNTA3Lb3RP6mVs5sxD1KtEqvS1wewBACqW1untamqOeM9Nz/M1DTJLv+3Qsski/qG8kWoqy03g779gfaSs3QUTNrdUnw+hpK4KfJ9B7MJmUTK9pTQBx68Dsn5MOcU6QsxOs74rjLquCPrFNygwlRnGN9xdxIXjFVGV/uFBg9o909bdupKISihUXYKCO8py17ALTYLI38oAj3VoklXe8Pj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eStG2hbnDu+0x+SUKY7fm4JJoVxpJT1q/T4rxE/y1wM=;
 b=IpUKFoIaLU9H1FKurbcNEdyENqvczc7si/olJJazpxuV+rxThQ1civMDG2PCbAmkGOqkIIJtRUntXH0GOCRhZAjK/v1yMKMUNit0Ir07eFzxhz4dkjqzMgK+j5ws/qt8RJF5EyNk+FC4X5NymEKyRqjfpJYMEyIxY4f3X1oNYX0KzjSZJ2AZdqG5Wfua4S5aGKAmj8nRP5paQyLVnXgOm3SJ1t1B9aWDG/fcmNyMiNRS4XDLlSv8dQh+FIbk6dO7ngiB+W8NKR36DFi6QctSFMUbDr7Lu//khTJpzuUvEJTOpmSJDo1cKobwJQheylW/zw6LaHdbYPyxZLXl6oi3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eStG2hbnDu+0x+SUKY7fm4JJoVxpJT1q/T4rxE/y1wM=;
 b=o3BepOEj00KATm2bF7n12AKsty4eU6HnqHtDWoCCuEYEvES43i8g6X+A4kFjElCrrpwvDv9D9+9yOrJekLENWRFLLJ9KWaUW3bx2MMztHlxXrx7Kv49tXkfFZ0oeKpDTaElisXz2KnNj+GYmc0Hiraot7kby7Kk5qPuGcU7vuAg=
Received: from MW4PR04CA0314.namprd04.prod.outlook.com (2603:10b6:303:82::19)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 16:33:16 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::6e) by MW4PR04CA0314.outlook.office365.com
 (2603:10b6:303:82::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 16:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 16:33:15 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 11:33:14 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>
Subject: [PATCH v2 3/4] drm/amd/display: pass panel instance in DMUB dirty
 rect command
Date: Fri, 3 Jun 2022 12:32:19 -0400
Message-ID: <20220603163219.1134064-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220602180347.754067-4-sunpeng.li@amd.com>
References: <20220602180347.754067-4-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f817150-645b-4538-c699-08da457ec292
X-MS-TrafficTypeDiagnostic: SA0PR12MB4432:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4432B7C500707A7811F78A7282A19@SA0PR12MB4432.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOK40JguIKlmeN8qfmNI26Xk8xP/V5drPvyZ1TY15sOn8YDpGCmRjHzH0q7NoE/7aM+1jwNMbmdjEWl1DVeR1CFcA09ze2NPwwgVJuC2fg56ORzcQ7w0gyiLGXxcyQfVTmIVS8aHCtkKKcFYA6rjwMT9Sq3eGAGSjBXd6W4I3643LQHUmIv1gUNxhiR5DIAUED0UyBBIIqpEhPNOxbM7gM6gtyPPZwO/n5wYSknYFwMnVXtB+kk98KMF+NjBLySXkRoIySt2towVSCJHatT0FPZGyZCBn+lZMjou3MjbaCUq8t0S3rIA1WAcKdrW8qxs+7zOv3plckQ4A1VDqX9XEZsIH7sqje0uwwlTSw1bm191FmEHTeX8kNmOX/YJm2X665YfpSRKojwEmbK+Xz2/uUTG92UwyagH0El+fAc/tSiIEYdgGz+wJkXcJEoCYH35xbLG3F0bDOMjAV3B7engg1JtvS4ZNHus2cSJP6R/bUk8yYloVjRYzVo4ZlaSTY0iZfA88G5TdW0hfYvCWTVK2XLfE70Qgd5KIl1yCU/mLTZCs9VmVQMyyh50tRNnSyuiA5tApHCA5EWVr0vKIn4QdyEdaFLkkFNGoXJ1pOV/K+8BKnc0JjVsgnHt9+JMBpuMoc2FbOrl2vU4sZki6jEiUvTnll+CAYyKBT3lPuzmXMvYT9xrWXoZ1IHct66GekZBNx1aRoGTKyaGSpzXLxzLUJs3TzG4gnaV69I9wP386aY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(1076003)(2616005)(7696005)(82310400005)(316002)(36860700001)(36756003)(54906003)(6636002)(356005)(110136005)(4326008)(2876002)(336012)(83380400001)(47076005)(426003)(70586007)(70206006)(8676002)(86362001)(2906002)(16526019)(508600001)(26005)(186003)(8936002)(5660300002)(40460700003)(14143004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 16:33:15.7066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f817150-645b-4538-c699-08da457ec292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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
Cc: alexander.deucher@amd.com, Leo Li <sunpeng.li@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, dingchen.zhang@amd.com,
 roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Zhang <dingchen.zhang@amd.com>

[Why]

In cases where there are multiple eDP instances, DMUB needs to know
which instance the command is for. Today, the field for specifying the
panel_inst exists in both dmub_cmd_update_dirty_rect_data and
dmub_cmd_update_cursor_info_data.

For cursor updates, we already specify the panel_inst, but that's not
the case for dirty_rect updates. Today, a value of '0' is used (due
to initial memsetting of the cmd struct to 0)

[how]

In dc_dmub_update_dirty_rect(), Call dc_get_edp_link_panel_inst() to get
the panel_inst, and fill it in the DMUB cmd struct.

v2: Update commit message for clarity.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: David Zhang <dingchen.zhang@amd.com>
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

