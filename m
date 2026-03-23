Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C55AFC72A8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 07:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1EC10E079;
	Mon, 23 Mar 2026 07:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xd6x3v/X";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3379D10E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 07:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCpYYM6WPp0d/7GQWOU2L3WWziicNcksVh0FbhNWohGGtWYJq5u4Hg6MAEEap0A4qkBpaGhXTe3UVMURYfKQDy3g/IF30KEm0ne7TrbOvHqD1oePv0R4r9tL7acMFkjhcPicU7YKPKXCyunc92njNqlHUdNbfYR7p6QqW30FZzBq4yJ3BGLwBu/qDG0gAModKajd/bVD5cuCHkYgJksWCn+4QGtD50efOO0GHr5kFZV/LzqYybM+0S5vywu3FhkJ4e/ZWeT2+7SzKVmrY57Zb48Hst0Ntbm24rl+ic447t0b4iNDFBY5+0VJ2w0XUNOVt3YEA8HovWbopXrNBNzwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJhl9zA50E47NH+jElfC2mjTmjvf6p8QhIQeJWXIW1U=;
 b=kAOAVlLDtQOSK8ZB4MCFPF/Z+22Ct5nNctmW/P8eK59brTemzXhU56X5RZgO2banVkkBz7sihaLOOXot8VAncGVq//29UA0L8ibH2ADxY6VobuyelfrZnUDZnXMsiYkSCWzsPtYLbi/gUfq9v13Arnf8XvdOWtBTDejJ2JiBTXHBFQN2cPhcFbnU3C6ToOejVlTzmDM+KWOlsdTT8WgMIgTMHtlfzfqG5g0xktTIGrduyElS6PHzMYlkC7GcTdfeaqjLh/GfaHFE1CNZkrOnHH22BfVu51fqckrc5JAhxS5lc2T1BjdnwCRk5kR9mUk/KBMudrcYkyKkN7XQiVPB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJhl9zA50E47NH+jElfC2mjTmjvf6p8QhIQeJWXIW1U=;
 b=Xd6x3v/XU5+Dusv8twB519TK//R++wm79EOvTnpZe3XT5oxOMh/fQJLJvackS/xOcgSZkT8kVtr4p2vql0VYPADrZ7RocbNSqLJ8dZtCockUx2Xl60KBf2uSjaejfRN0puIfFSITk78E0PHnu+aUr4h3sDfZoHrxdm8c9n6DjJE=
Received: from BL1P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::11)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 07:33:11 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::aa) by BL1P222CA0006.outlook.office365.com
 (2603:10b6:208:2c7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 07:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 07:33:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 02:33:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Avoid NULL dereference in dc_dmub_srv error
 paths
Date: Mon, 23 Mar 2026 13:02:09 +0530
Message-ID: <20260323073209.2045385-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 976ec2f6-b128-4276-9143-08de88ae6fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rBB+gqVYuRNJcCLWLEJXCtNI/rPOPRI4dk/97Tg3CyfnSyWEe06PaT2eK4LG44fjO3Br6o41ptrgl66Po1IJ5wMtIxX4D4LM9zLZiBS53sWHM2diOz+fvBjYMJRgANyYSBZ+rnsED2tWWfFgX9P2CIShlod8CX4iraA8R6/03XkXIyxztXX1CJ2KY1SFdMOcWzpKOlE5DZlq0waC6LEiAR+2+TA5l7jnlpxKeHczFKH/tgVr8U+/du7WqzOPEDYXGgCmKf65oQjYzQzWqZovMstMjDOnTqDaCk7xIBvTSRobgKiqmGllOrWx48LE2WDRYDuZnRYLmwEm7xMCvNcCFGKNXx1I3G6FxxZbNuZzbXaP6x6BSdiFgpbAFXl7NA5l4cCNCm2eVqHTVxOj9aSi8MYahaHh4BmfWs5Ie/4jKq4zYcqcxr0Yal6aM9xm0iKgjhbF4Ry0D1aUvS6jkxxtVRZwofXsn0nhnluKOWwI7hIti75N8PX/12P6v6flBWO0DsGPwDLjnWk9NJSPTQZVHZ3yQCeH7w4RKg3YLWtK/NjkECk3De0DhTbfU0rwW0EldwR3yAho6o/sicdFhhJYeC31iU6B6sfe7dhbB+cmn51FTd7TxgDWfoGcLtQramcXN8saVq8AcW/ziWIl3ryCGFdi0BPyhzjIygbNlufbwGbbiJT2Qdqff9B17SIrJXT7dDYQkXfxBxVbCZ3AnKqmWd0mxrWQybonkIwEWlgw+cRXUF9IkJxGZBii0Nys3G8Zw7SbZ+h7u1YVgUy8oyPo0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C3c6rJ+6gU70nXpF+E4Q6WOdIgA7iokRdyrEhUP9NHg3LpUiqSGyprHjLrP8Jmsbg43B8pgsBjs1YB6E8ps285OZpSeKIEiLzTpo4+ttcYLfIA2tuPXJC1WNO2gVnyDEYWTU/bvD9XcBJ9JZZr6sB8umozKkjMqjHB8sD1BC96DArOvJYtaW1EDiSgXLd0f2XP1Z97tdy9vtuuIAhJFhHo1CCzpvIHrYI7oQXzPyDIeYQL1xSPrXKzKNJPYBL2tvgv8eQhcmzw7DZ885UGS6R/h02gKTsNC2QHMCVzFollm73gl4pdgDBG+fd8PI3DJf65nb/MKedRrV/Qsyl0esHXcJXXbSzqPWt1gNFfxGxPdGt2kLkFGWeEqYhQgoTQqzJVihhuiqZ6szYP7SKQ3b8EdOU6CXuBdxJLZfRqrShol5YL1a+IPTgw/pAwahftL8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:33:11.2151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976ec2f6-b128-4276-9143-08de88ae6fae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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

In dc_dmub_srv_log_diagnostic_data() and
dc_dmub_srv_enable_dpia_trace().

Both functions check:

  if (!dc_dmub_srv || !dc_dmub_srv->dmub)

and then call DC_LOG_ERROR() inside that block.

DC_LOG_ERROR() uses dc_dmub_srv->ctx internally. So if
dc_dmub_srv is NULL, the logging itself can dereference a
NULL pointer and cause a crash.

Fix this by splitting the checks.

First check if dc_dmub_srv is NULL and return immediately.
Then check dc_dmub_srv->dmub and log the error only when
dc_dmub_srv is valid.

Fixes the below:
../display/dc/dc_dmub_srv.c:962 dc_dmub_srv_log_diagnostic_data() error: we previously assumed 'dc_dmub_srv' could be null (see line 961)
../display/dc/dc_dmub_srv.c:1167 dc_dmub_srv_enable_dpia_trace() error: we previously assumed 'dc_dmub_srv' could be null (see line 1166)

Fixes: 2631ac1ac328 ("drm/amd/display: add DMUB registers to crash dump diagnostic data.")
Fixes: 71ba6b577a35 ("drm/amd/display: Add interface to enable DPIA trace")
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index d6a08064456b..cab8fb4c56d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -958,7 +958,10 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 {
 	uint32_t i;
 
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
+	if (!dc_dmub_srv)
+		return;
+
+	if (!dc_dmub_srv->dmub) {
 		DC_LOG_ERROR("%s: invalid parameters.", __func__);
 		return;
 	}
@@ -1163,7 +1166,10 @@ void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
 {
 	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
 
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
+	if (!dc_dmub_srv)
+		return;
+
+	if (!dc_dmub_srv->dmub) {
 		DC_LOG_ERROR("%s: invalid parameters.", __func__);
 		return;
 	}
-- 
2.34.1

