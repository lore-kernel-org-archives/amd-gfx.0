Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2384C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275F810E560;
	Wed, 28 Feb 2024 18:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eqZZAu1+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C816610E560
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwXyxtrphRKnyaifTCbV3pwfwpqselfbiQI49tcXW5sa1C5buaRI5HNRO0ZdW9FW607N5CaIkZiF51QTRSBwCmV5TvG4krN07+Zg4RXRnPkI/OvK4TtefmvSkxh+gK/fKMAlJqvfRgVLPCvBOUk7lewyB3Rkpm+1aJZ47XePVa9e9YhSMaValYrz0GnzeAtuYEFzgqZSJJYKeV0mh6wbLgGNBXcb+kqXVFRSgD7Fc8PKvscg8rNaMboAsmeWSFsHzyPptYsu/YMZpZRlWQPShDSSEzcUjItABOikra0ib8YcdfoV5nsNEtLrG+/Y3nRl6yToqjiVE1woKqeq3LKmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLsPcqdNWXAsOJRGOARuc6qt3BQGhwGxRyM1OnBtg2w=;
 b=Es4teREY4zxsAKT6ydLLBG+UMbL5iGLZMIZc5Yyq5c1g8iVzdEFJm55BLl3mn/Y/8SyzHJbB0oF7KIQZ5JbltILYTrY4vW93jxjNvKe4ZtQeu4Q3FYdWZOoGWr/8qvF3s2CEgBX7Ac88lYh9jWm68DNnaxemQ4fi1QdtIZ8/yUR1Q+5v/B1vEqRdwFTj9oY2Wl4nSu2AT+Op6iXQcvx3iWSuM0EuZvemDAnPG1iWdVbYhlf5IwOu2cCi/UB7fTSo10PB6Ruru1QOBaMUSw1DmiYoa5Kxq5sHPZdj6YI/KIyis1UjDLt/cLpRE+w7afBGcWuLt5CT8J5zMYoIZ2822Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLsPcqdNWXAsOJRGOARuc6qt3BQGhwGxRyM1OnBtg2w=;
 b=eqZZAu1+4PbZ6s3cC/7Uvm+7qxWt+jfrCiD7kj/9b9xkmuyhDX775WEXjjw2J5IbLl5uh7MKYXDxAkcAYQ6lnp23sr/UY8Rfk3yN6huXEUaAuKrd/H2gvaO1U2bMAeuVQUpClpzIpvyU7P4TSl1zdnhHiCTL/JMrlFTQp/dsmW8=
Received: from DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7) by
 MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:45:04 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::fe) by DS7PR05CA0086.outlook.office365.com
 (2603:10b6:8:56::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.13 via Frontend
 Transport; Wed, 28 Feb 2024 18:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:45:04 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:45:01 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 19/34] drm/amd/display: Add guards for idle on reg read/write
Date: Wed, 28 Feb 2024 11:39:25 -0700
Message-ID: <20240228183940.1883742-20-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MN2PR12MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: a718b56a-ff3a-4b85-f27c-08dc388d608f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OK151Py8dSJjUU3NYBuJWSqT0sErlXpmoraH9nYhHtO5injx08FTLKlZb+0RSUpcOnHAMFwkcP8foeadz+ytSsDGQnanLqoRrTfcvy0D2vbt5OBCq00PqLqK6ZhZdlBCFoGBbEOhlOScCHLmGJsoDK65AOWyurKCmWIxeRACgrgqqWlZzW8x1GzQ79R6p7wqGmhFu52Gkd7hoI7afx1WZVgJ5MeEEwda/SIMUAPvzL6mMVZS5OpSDsw2vcrGsVZtBgrKSpm0dXXfKhdsVYjG4QiFLhSVqgTRV3Zid0Gi+bN/MbOBKChkliGqVd0W+7ma288cX0novv6GujmbEXaaL5W3zqW0zpuPmzMyUWNm4cfz9kXFmqCGuYN/cHPE8gDcZIbQlr5Z6rWkbZ+jZHk/eCgfTek5QG6Ir7Xtfwk5PFvu8vrfWt/S4wOU59/FBf+XtxVy/euzxRpE2WdPJ0PAbFrNKeJPGGD8b4RUrVggU7TFj2lWPXJ71DoCqjvG4W5OhcZXY4mXU4/8WvK018WsR1vZlN5CSi7GOk7nVZHNbCEcjJD/eIHy1iynf23fYhhr+spPlDalOsWMZnhqDhGK4gli75DKbDwYvt0FAGxHKiXC6+rO9gHZG9mqzK+Je2T5PmFbc20z0CB40O3s97hhB15tPWd2bNTGqeDEUDoj6L0HaUAW766s6mYo5jLLzRh/Xgkk/coZcgOZLS7IvYsQDE7/NP7D+NFjDOqn5m6qXhRMPmb57zOUKiY4tDIzGjy7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:45:04.0420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a718b56a-ff3a-4b85-f27c-08dc388d608f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[WHY]
If DCN is in idle then we should not be accessing DCN registers or
it can lead to hangs.

[HOW]
Log the error and return 0 or drop the write if it's in idle.

This is skipped in the exit sequence itself since the boolean flips
before it starts.

It also does not cover accesses from external clients outside of DM/DC
like firmware or the kernel mode driver.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b168dfc79381..938e8cb2fec1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1270,6 +1270,10 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 	/* NOTE: This does not use the "wake" interface since this is part of the wake path. */
 	/* We also do not perform a wait since DMCUB could enter idle after the notification. */
 	dm_execute_dmub_cmd(dc->ctx, &cmd, allow_idle ? DM_DMUB_WAIT_TYPE_NO_WAIT : DM_DMUB_WAIT_TYPE_WAIT);
+
+	/* Register access should stop at this point. */
+	if (allow_idle)
+		dc_dmub_srv->needs_idle_wake = true;
 }
 
 static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
@@ -1301,6 +1305,11 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 			ips_fw->signals.bits.ips1_commit,
 			ips_fw->signals.bits.ips2_commit);
 
+		/* Note: register access has technically not resumed for DCN here, but we
+		 * need to be message PMFW through our standard register interface.
+		 */
+		dc_dmub_srv->needs_idle_wake = false;
+
 		if (prev_driver_signals.bits.allow_ips2) {
 			DC_LOG_IPS(
 				"wait IPS2 eval (ips1_commit=%d ips2_commit=%d)",
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 952bfb368886..60c93e9e3533 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -52,6 +52,7 @@ struct dc_dmub_srv {
 	void *dm;
 
 	bool idle_allowed;
+	bool needs_idle_wake;
 };
 
 void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
-- 
2.34.1

