Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4CCC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B634112D41;
	Tue, 12 Mar 2024 09:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OD7/mW50";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C6B112D41
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGoJdm7ebEZ1C2pwUHTcgE+s6vPFeskXuFPXEcShQ1WKWoQ94wwlTRxE3zcvxvSioq/KEZMZzBMF7uqAh7c3hqUQvubFr71Pq+jM0zldX6hGTPqGvptkXckKJkNCXvxeUscdNTtOgoyL6KEiiNfwIttmj1VR3vMXFfRue3UDtA4b/UqqXudxeVj6Qk81+jA0ebilXxxvOLjQ4dtkiB73VAYsDnrSCZa0tf4Wq10AX1aTFLVtWYRWRLzzDml2X1HRMs6ud6khtY3np2CBgJ70gi97tzom3UxCBOCF5n5v85X7D8BkZPjHscCL5tcXpq0vADwyf4vsMJF8BegAk6VtMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Tr8eKBxWWZ+3NUDpOfffs9eT1uS8WI9A8pfVmXXAeU=;
 b=RkrpTR4TdZwbTNjprWHvQADmHyFy3D6JeTqFafE0b8+1LnMyZ5HebEJcVBvtvmdqOdWjilPQ4nSzAg8NdMFZpNC4Edeeb3fAVXxioTSz+Tz0Q7F1GVjj4lBvuR5ZYkR6eFAMmeZ0Ik+r4kocPgpp4QnZHiMRYe1cD65c4SIF/SeEBGnQSzyNitGW67FwOpcP4LaQhYMB8qXFANAv6pELM6ZCIqpZDJpyEOekwsA+U7jMGJ0dmGiZsMQUgAUTwFZenFDS7O3gDHNsIPg0ixTcEJp/ZJbtzb/tbPCjGdGJEZDJRdCc9B1eKVzXQfXlYC2zcAqAiT2acd/uGFbLIQa3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tr8eKBxWWZ+3NUDpOfffs9eT1uS8WI9A8pfVmXXAeU=;
 b=OD7/mW50tXDVNEEO0cYv1GcsmRr2HbDpbmHBp9JIc3jc2cqLdu1yY8NmpT7Zga6CQ3VezRUihWax60bHjEV8KKtRdR0SnpHsLIQBWtfEnUGsaUl6gGuDAJLA8pHaAI7Agzs5UJ12nKRZTS23NFo0atq9tQwrmLTkEYbBTRrdBlM=
Received: from CY8P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::19)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:24:34 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:47:cafe::17) by CY8P220CA0035.outlook.office365.com
 (2603:10b6:930:47::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:32 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>
Subject: [PATCH 35/43] drm/amd/display: Detect and disallow idle reallow
 during reentrancy
Date: Tue, 12 Mar 2024 17:20:28 +0800
Message-ID: <20240312092036.3283319-36-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f09d3b2-bce5-47de-d743-08dc42763abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8cFdJ+w8YhD5+MyIk3bDospiA9HAj1FTU/3lRMXm5mrL6EjaR61EVtBy56tzKfjO6n11gXaDkQF5NlZelHny/UqKhBxg4o7uSTdtQI7aiz4SmZS5Ibfcizs4Ghr3NkDDqylj969+iMU1u7b/1hCtA/Kj5n12QyfWL/gOcozoCtEFwgDBd+ZxwTBPi86MxP464atJiO0L2CW8fR3k/tdopGr6qq5zSA4/nCNF4r/hMllAY4nkXUP1CEt9vlOqrCm3BU62VPZHbXuHgHJ5ZJlAzVc7Y3TMpLqA1hwfcYfCsxQjh8+GNlVNfHCzDddWIFOLKFnN1rUpuCaUhTvodaIHC08XOsL1R45YB9D3ZzSFFw7gepCaZY9mp6Cwc/561fpvIzctLlXvGEUyl9CjM9k7GH+iunrrJv4S9Kc+/ZYZVsarEzWOyQ4QIhA9x0AgqGcQgrQ3cxAglMSRftDhhiZ48fdyox0eCOJ8e4zgoNj73jsC4QuszII0v6hPzvA1YP1MN6en68lcGOdvSGCFS6K2G6NVzwuyWRX2fbT0XmJFVsKJhPO2WoiP2FbzDc4d6wI3ADYSxJNfPJN0XobIALeFEt75NCa95Y1vyNcTsEFb6vq2WEiO1K5Kax6c5M99UiSrXNZRPZmFwKHdQJeaPb+GjI38xskpqyMBWd/l14UJwDnJVnwNFyDrfLgwrNk3njU5TEovYN8fF+sfVm8dsFf+WY2GKv9/qMqiZ+WtH3TDIH/EfvkalRf+CPib2KFIoyM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:33.7768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f09d3b2-bce5-47de-d743-08dc42763abd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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

[Why]
Cursor updates can be preempted by queued flips in some DMs.

The synchronization model causes this to occur within the same thread
at an intermediate level when we insert logs into the OS queue.

Since this occurs on the same thread and we're still holding the lock
(recursively) the cache is coherent.

The exit sequence will run twice since we technically haven't finished
the exit the first time, so we need a way to detect and avoid the
reallow in the middle of this call to prevent the hang on the cursor
update that was preempted.

[How]
Keep a counter that tracks the depth of the exit calls. Do not reallow
until the counter is zero.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 14 ++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index f796ed061879..4878e9e50440 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1437,6 +1437,8 @@ void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_
 	 */
 
 	if (!allow_idle) {
+		dc_dmub_srv->idle_exit_counter += 1;
+
 		dc_dmub_srv_exit_low_power_state(dc);
 		/*
 		 * Idle is considered fully exited only after the sequence above
@@ -1448,6 +1450,12 @@ void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_
 		 * dm_execute_dmub_cmd submission instead of the "wake" helpers.
 		 */
 		dc_dmub_srv->idle_allowed = false;
+
+		dc_dmub_srv->idle_exit_counter -= 1;
+		if (dc_dmub_srv->idle_exit_counter < 0) {
+			ASSERT(0);
+			dc_dmub_srv->idle_exit_counter = 0;
+		}
 	} else {
 		/* Consider idle as notified prior to the actual submission to
 		 * prevent multiple entries. */
@@ -1489,7 +1497,8 @@ bool dc_wake_and_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned in
 	else
 		result = dm_execute_dmub_cmd(ctx, cmd, wait_type);
 
-	if (result && reallow_idle && !ctx->dc->debug.disable_dmub_reallow_idle)
+	if (result && reallow_idle && dc_dmub_srv->idle_exit_counter == 0 &&
+	    !ctx->dc->debug.disable_dmub_reallow_idle)
 		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, true);
 
 	return result;
@@ -1538,7 +1547,8 @@ bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_com
 
 	result = dc_dmub_execute_gpint(ctx, command_code, param, response, wait_type);
 
-	if (result && reallow_idle && !ctx->dc->debug.disable_dmub_reallow_idle)
+	if (result && reallow_idle && dc_dmub_srv->idle_exit_counter == 0 &&
+	    !ctx->dc->debug.disable_dmub_reallow_idle)
 		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, true);
 
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 60c93e9e3533..c0a512a12531 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -51,6 +51,7 @@ struct dc_dmub_srv {
 	struct dc_context *ctx;
 	void *dm;
 
+	int32_t idle_exit_counter;
 	bool idle_allowed;
 	bool needs_idle_wake;
 };
-- 
2.37.3

