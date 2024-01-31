Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D72C48285
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CF810FCAB;
	Wed, 31 Jan 2024 20:14:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099DE10FC19
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5v84xd6Y5XpZQLfDHR8mOyBfqYboI1e5Dw0NcCHsB8BLkV+fARUu3SGB6mIWIb+KpL+HbpZ2p6mLF4YckXaxsvG7sD6K1JIIqjJhPmUbzRy/SasXP7WLyBByrlQMtey9bXmKJCun8EnHGTadesW4degKyEAA8mkrmv4y8fh5l81yiDvJORXlDPlikTW4Eg4DzB7Nj7l4PJ71tpFcdkRQlyjSjtt5Nu3tZct7/BJ+dQbBKJcz7/x5xzgcPpk/4IHDUt1b40wqEVmET/3jE+6i98I+9Ux1TMIMmngeWCQ7o4eWjk+yEsikxGsunWyX18HQRnrub26ZsW3B05vaYx9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbaPlDpqtFr4CqfTT3vDlschLw4C7hm7aalNk7qHAQQ=;
 b=JLAYmCuD+sGfffOMNCZClrkHwYOF8CPFXy/oBPpBu8qRQ85LqkshTXjZ0mNsGSjV7B6P+UPbdIr0UNcfoRZJeIlFjOnU7mqZKDVHjZnw9zWveA5xUkO503XhTW6Oplwu0Q4XSid9KbGf+fP+lCMKfIh9w0IRo5vtr/ZhQJ18esfa0AB7OrOR9gv0ZIvKQHfQN4p/RKpo50Sx0xs1AWkoAdjSu1PN4B3aiPyIV6l5O0fYi5tL7ZkALt1s16QMtV4MXaNOZSpybFkAa7fGQXZNg7Ihli7rc4dcA5w8mredqeyRR5qVocft+lSBmo1oHkhnnRoMNbu5hp3eaG1l2E54AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbaPlDpqtFr4CqfTT3vDlschLw4C7hm7aalNk7qHAQQ=;
 b=npK5YQb+TAgQndnUM2R/njv0lEO7FKCPcaDRzhhlOKrVzU+9i+NxaELZBw/h0h6uRG/KWxrvcvse0pPzUJKieo+NdBK94BCTFQj7IN2PWSbOPLFMghrBzVCO60TvVTBB3kOpmukA98o+RGxjamlHsJMOqdnEQ6DLf0pRErFK7xE=
Received: from SN7PR18CA0025.namprd18.prod.outlook.com (2603:10b6:806:f3::29)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:14:46 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::ff) by SN7PR18CA0025.outlook.office365.com
 (2603:10b6:806:f3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 20:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:14:22 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:13:27 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/21] drm/amd/display: Disable timeout in more places for
 dc_dmub_srv
Date: Wed, 31 Jan 2024 15:11:12 -0500
Message-ID: <20240131201220.19106-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: c6339293-3d8a-493c-d42e-08dc22994557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAGr1//dTkr2aJaMc/uyPH3fE6W1/IzVAm3tXFzzErTJTQFFvqwqW9VSpHUPrAqHpQcCVKLhxxl4AnMqYqdjCUChEUCAAC2x35IoDuSmXQAhovhnbBOQk+m/5OijngUwAEMdxn6GKyD67HM37iBkEnXsqkl9ADGuB0XBrpO9wULmYXp9YID/E8FdZJ5cCK40YIl0WmdsHI/q905dnnB/yKtLggGulD8fSIIRktahjC5FisilqBQonZsgNQhepyuTkoW7vToYUWuEbC+HkzHAiHRLnEi+7IHwFZF8YuJzKWV5A9bpqyo44IDDC+FTbkuDtfbclJfOhQRuDSVyttldeCwS4IaKd1IVniXMdZ/rcaBWoEf68VB5xbfzkRctiywa0Min2iKam7eVSAorL6mOFPyx4TO9j29Hd8Nk9KxglOhBZN/Hiq70RQF3ilQOw9XYHKqEm/+94PSi7QSDcdQpK8tyQ1Vp8G16M9pEl5chR5YGjYegrrmSROX4N0+G7jKu7o0s/tmeaL5iUupK9Xtse2DqpT/C7eeeI+4ptfpLSctdnYiKupN7NQjb/k/xRZIhyIBTIkJYLfRsyC1UZo1rhd8ZAu0ji8/4NJ7Qhqc1J5nsT6ElR6ya2AeUeBM6IT8N9gQm+Wbf8ch9hJrO8KP7TGS4/D6xKjgyikzR7KVNBdS5iwhUHvNO79cAwbHSrzUjL8YDG7mfIFDu0aM5hbUG53SQN3uv8RHHZ49zStdU1mTS8rmECAN/QM6BMy8lbVhqwxcB1X3k3o/8YV8DlE5IrhSqJFu+HrcejWJWkVw+39gfMQM0OyZAvXeb2yi8pzTK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(83380400001)(2906002)(426003)(336012)(2616005)(1076003)(5660300002)(36860700001)(16526019)(26005)(82740400003)(47076005)(54906003)(70206006)(70586007)(6666004)(4326008)(8936002)(8676002)(44832011)(316002)(6916009)(478600001)(86362001)(81166007)(356005)(40460700003)(41300700001)(36756003)(40480700001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:14:22.6144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6339293-3d8a-493c-d42e-08dc22994557
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We're still missing a few and we'd like to avoid continuining when
a hang occurs for debug purposes.

[How]
Add the loop anywhere we try to wait on rptr == wptr in dc_dmub_srv.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0ccdc0c979a1..838c43b74662 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -74,7 +74,10 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
 	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
 	enum dmub_status status;
 
-	status = dmub_srv_wait_for_idle(dmub, 100000);
+	do {
+		status = dmub_srv_wait_for_idle(dmub, 100000);
+	} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
+
 	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
 		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
@@ -145,7 +148,9 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 			if (status == DMUB_STATUS_POWER_STATE_D3)
 				return false;
 
-			dmub_srv_wait_for_idle(dmub, 100000);
+			do {
+				status = dmub_srv_wait_for_idle(dmub, 100000);
+			} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 			/* Requeue the command. */
 			status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
@@ -186,7 +191,9 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 
 	// Wait for DMUB to process command
 	if (wait_type != DM_DMUB_WAIT_TYPE_NO_WAIT) {
-		status = dmub_srv_wait_for_idle(dmub, 100000);
+		do {
+			status = dmub_srv_wait_for_idle(dmub, 100000);
+		} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 		if (status != DMUB_STATUS_OK) {
 			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
-- 
2.43.0

