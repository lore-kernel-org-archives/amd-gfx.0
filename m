Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BAEC27C78
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587EC10E6E8;
	Tue, 11 Jun 2024 16:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xUQ4qGmI";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F0810E6DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9vq2VXRYDs/2U1R0k/pyk3MHfkgX8uYWA1eWXdbPK0a/apeWWEIlXFeIpiJDwuz6vjLNGIMhi3JUdm9jg1AtwqEeG4Tgd3yYwbBAnL7C9upKKJQZ2NBb4gjtk7hDqATBYrM4RL7L9/x4GcRw+XXo8b/ODyJa0IrcP/HvaTLlqtsbZs3rWDThFx+RMeZnXt9KgWho50aVSD0PAac/yu0/Zj7OSIgTfGOoBVBvTicQ/MwPheSTfJSj/W+C6cYTK9oybwK5LMGsVdp/LgqTmKmnRsj1PL7V/srYfA2cRxRH8iDuLE/Dub/+NGv2uz/WIrmmYaydOxCEDQqBATnn/IqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLIIOJ5E5F6vZRemUozPYnyYaPVxPHqgSXTM3XA/pWg=;
 b=L1G7gf+YoqQDSrRaq6bvvF8thRPuRXEX924+av4UfRm650dU8uGOkLctrnDuYwFOr1KiT3LGBuv2czIiwIavp8qhXxs1dNW/+O1lArjP+XPGYZO3gp5fYS4ELWQ3/LEUNqvpib5daWkwdImVmd3JxrvzUFNDnl/znQGFmM+znwxPIJ2rLQt5+YzmhU63vktY6tsdsbd7AurmVEAZCGG1iosKZguL1OmYIj+tcK9mbA7ZzN6tR2bXSJt5l3AR4YCvioAB5T+zUe2ATBOkU2C5xd+D09r7wH+agSqjlpIKd6rAYwCKpsqsxZOMxSK0oztRdkxliBfzvknHhWfg9l3TVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLIIOJ5E5F6vZRemUozPYnyYaPVxPHqgSXTM3XA/pWg=;
 b=xUQ4qGmI4GW500NHVWCS1f9RYTx0jn28LqARdPjaYY0cecxK1J41YWWkrbIyhZiXu8uUeX10I2eKJMhHib1xL/W50COM7lg0C6l0yLN9o/BT3DYwAVXqih87zqVVWD3KEgjRd+Hw3pDpQzvqHW8Tckqa76tN1o6WFZIOgalLU+I=
Received: from BL1PR13CA0158.namprd13.prod.outlook.com (2603:10b6:208:2bd::13)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:53 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::c) by BL1PR13CA0158.outlook.office365.com
 (2603:10b6:208:2bd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:53 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:52 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 34/36] drm/amd/display: Remove redundant null checks
Date: Tue, 11 Jun 2024 12:51:37 -0400
Message-ID: <20240611165204.195093-35-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: a0db6168-d9da-4427-fb66-08dc8a36efcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R/VtJQ5x9ChwHBQ5OZ7dB9INFr3Tzwp9EXzyih6SLf1IghG9BjwopGtviNhK?=
 =?us-ascii?Q?Q1IlVvpjb1HDtEWuACwvziHttAyh7wDIlFUcAzPYw1cBoVeTbcYlMeixnX6v?=
 =?us-ascii?Q?hNSootvQPuYdXJyOfOUk4lo9ScmlNDbzpJqMVx47IGVl+coUBRbOUJkcMGhm?=
 =?us-ascii?Q?xJkSpW1OmUDH65F07xQge+NJCcUhaXC5CGJXjAVsR4UGMXsH1JSPGnTQMGwj?=
 =?us-ascii?Q?C/6Ss81BQK2YXzQj4gr9KLasry2dEyS2xHNnEu5mmcWb5k35ZreXoBSqKiCg?=
 =?us-ascii?Q?rnxgn02BNOkguG6zHdHuTMxoTYcQB271ot1KOAWsSAlfQb7y69MLheWxf++k?=
 =?us-ascii?Q?+zPgp4ZBjvc2uwxB0LhbJRKXw4rZRkC7PLh4BllZcperg/r6kRjjOH8o17Fn?=
 =?us-ascii?Q?m4frPr/ZpCFCAv3GKHNWQnXKTgoI5tUKdkC7Pp/nOLFHH8eKQNCFp86c6vrL?=
 =?us-ascii?Q?hi4R2s/r2O1oqEqpsMaKPfDlu6fUQkXL5WX4f2RM2j2XgNTcvjGSSNTWc+U2?=
 =?us-ascii?Q?brcnbE6nJfeHqzS7RQpIcVr6M73ynCM3s+J4zVN1jImFsei1mirgbbtLISYX?=
 =?us-ascii?Q?KqIcS6e0BAeyg3nEPxtk8wq+TTKTrBzEteS9ckxfx6dqqP0R7ZoiZaoZto/s?=
 =?us-ascii?Q?Po3eiFqmpxUcC6FlVd5vg2dUbHdz+ikrbaUt7R6x+QpboxKn1vyha4iifL2G?=
 =?us-ascii?Q?Lj56Wv/dDEfBGI9+5PukLfWHbjOOpImC+WLfcIX6mr0oljAIEN+p5YW9U2ZM?=
 =?us-ascii?Q?YtT8J8UzDBWc7BUONRaxYLPTorCbXhnuMW519fOsZuuCAdN9gFCaay/qvSRP?=
 =?us-ascii?Q?JwFbs+YHC3KPFtr11fHSkVFcOLJIOSxj/iMZ95hwYV0OOqbWAi5Pu1rtc8Ru?=
 =?us-ascii?Q?Jq/D0VGu1FyjrD4oz1GiLusn7OsQaTIr5IwALT0qyw3EbKjmvvdXCfSod1mP?=
 =?us-ascii?Q?QdCW6ZZDoQa9C1YGZyXrA8AowrWZHDrPrjYQB/kn23xOxpzuNnaTySyZ+eqV?=
 =?us-ascii?Q?rzOdkbgYCLCnPyppiNxMDmIyzp9B9b7G518KlpWFcrbzCOX+qi/cOa5nrClF?=
 =?us-ascii?Q?mzGIP8KboHANDObpHVuUSBmb0nshEv5FvxirCeNs+I5lOIIeggMzHcpb2Jn3?=
 =?us-ascii?Q?XrAkbFGy+xxrvMLSl3WLzEe4CLWHbE6sFojFQJuqlPhiieVT1Dq2gFUrZVqS?=
 =?us-ascii?Q?ALEb8Swv6xjw1SmSUCnNYbWQwvM9uc/hlTg2IVq7BWx3eVWANV7w9SUE5t68?=
 =?us-ascii?Q?6rIde/LgOHoZlIrtSzhICTLEjinINCV0N/ASpQ6fQVQfKGWPar6a/lHic8r3?=
 =?us-ascii?Q?O2OJcLzJm5HrjGetReV49uOnQ8ugQHhFezPuarT0nPEH4Pk1FPtKN9pXGJ+r?=
 =?us-ascii?Q?g7bep/mi4BK4HC6efDhRWANUS5uDzd8zk9S57OyR5v2g1yQxSw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:53.4507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0db6168-d9da-4427-fb66-08dc8a36efcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
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

From: Alex Hung <alex.hung@amd.com>

The null checks for aconnector and aconnector->dc_link and
stream redundant as they were already dereferenced previously
as reported by Coverity; therefore the null checks are removed.

This fixes 4 REVERSE_INULL issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 6 +++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 3 ---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 48a9243ada7d..1fd851b93d40 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3180,7 +3180,7 @@ static int dm_resume(void *handle)
 		 * this is the case when traversing through already created end sink
 		 * MST connectors, should be skipped
 		 */
-		if (aconnector && aconnector->mst_root)
+		if (aconnector->mst_root)
 			continue;
 
 		mutex_lock(&aconnector->hpd_lock);
@@ -6422,13 +6422,13 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
 		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
 
-	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_EDP &&
+	if (sink->sink_signal == SIGNAL_TYPE_EDP &&
 	    !aconnector->dc_link->panel_config.dsc.disable_dsc_edp &&
 	    dc->caps.edp_dsc_support && aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE) {
 
 		apply_dsc_policy_for_edp(aconnector, sink, stream, dsc_caps, max_dsc_target_bpp_limit_override);
 
-	} else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
+	} else if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
 		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
 			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						dsc_caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 7cfa240a3cea..717d97191dda 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1420,7 +1420,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 	uint8_t param_nums = 0;
 	bool ret = false;
 
-	if (!aconnector || !aconnector->dc_link)
+	if (!aconnector->dc_link)
 		return -EINVAL;
 
 	if (size == 0)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 8eb2f10f2c38..659dd67be1ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -807,9 +807,6 @@ bool dm_helpers_dp_write_dsc_enable(
 	uint8_t enable_passthrough = enable ? DSC_PASSTHROUGH : DSC_DISABLE;
 	uint8_t ret = 0;
 
-	if (!stream)
-		return false;
-
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
 		if (!aconnector->dsc_aux)
 			return false;
-- 
2.45.1

