Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D9BC25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1465510E50D;
	Fri, 31 May 2024 16:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nek5tS/2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A6F10E65F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg7oXfZbROkw6Ur5Sj+APQlmZFWpDhWSO+C0txRFeuejZVdWF3F5l01nu9tljjfxIRfgxdpQ7Kk/QWU1xXvudTDatQhNYExbmbbibZF1bDqp7lV1O9UfuP6HzrU1FEeaV79XPMV8L/bmYvlR6DYYr7I9Q+AvOxnFjczm/w+unrfg+aXl8QZAu0kZ+WjyKltyniU9kXwAlFDnvmmD2EVhxmvWFl18iA46TZ4l0MEIS7kd9y5eCt2+rJr4aDMfxE86XE6NMph+JzJ+xtRPOYacD/dgX0KDxfJZFnp4PWD39+3aymRL4hAvh9rUjRXyB5IHitZDpwHuL7GPYm6TyWsTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCED6/yZEizNWWgSopJ4r7XrZWQ5gXxl99T/2RvRcWA=;
 b=epE/vyWMcDFcDEMTTuB+M1gEhkjerwuEsq1HMmCElf2CeaZUDTRWrHc99boAGJRpmVNXbk9S3lsdPC3TvT4D4beUw2kfDP1SapTxNibRnp61Z+Fomyd4yxcXyMusOtDjfq7cFBCkbPLp549xvAGIz/9rTmyEkaplkNEQDQNFV9mRw0YLYbmkC3PLFywH0n6LirYLQJa1Bsyp16bdD5PKr7XtQVmuMPfyn1danpQPiy+BT0eYtPyWWkuNgCyEo6J7vMPnG3WfeKKuiF1aHzKtNW1wpGcrH2x/F8bxkxg8l2XbjR+704A/N2bV1UOhzyA0lX4AupIQ7CBVADsWw0c87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCED6/yZEizNWWgSopJ4r7XrZWQ5gXxl99T/2RvRcWA=;
 b=nek5tS/2dDZOgv/q/5GloBye045CL/3sQaPRnTwTJMu2YsXClpY/HmGHUtoFGyKsvsd8N8TdqrE0NL4//aTr5ujpIcNsZpB7Um9wOKxSR41PorQKd4FbHfHm0v+1yjoP33/1Kx5C2UQe3DJ3TkNSI9gZnOd6nj1rz8mBnAwloYk=
Received: from PH7PR10CA0021.namprd10.prod.outlook.com (2603:10b6:510:23d::20)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 16:52:38 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::5e) by PH7PR10CA0021.outlook.office365.com
 (2603:10b6:510:23d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:37 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:32 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Samson Tam
 <samson.tam@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 12/32] drm/amd/display: Use current_state when checking
 old_pipe subvp type
Date: Fri, 31 May 2024 12:51:25 -0400
Message-ID: <20240531165145.1874966-13-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 6187f292-88d4-485f-ca9d-08dc819213a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?el4saplIOmrdKgmhhoXbgT3KYFvif0GJHhBD8F3gPm7mHy+Uhvhki3QoVuys?=
 =?us-ascii?Q?QoDO5IyB15AFeYDpkYR5Kc7D+pT8WfLZDbscFenVrC1/F1jB4uhmn7Q2o4dK?=
 =?us-ascii?Q?J3fhd607mSJzoO129+3prSiGwUXFoBIoZMZqizk6diGcvVOdSzJdmSlfRoUc?=
 =?us-ascii?Q?M8ea5to5gsxPstgWgfVI8ygXupJoklLLNjc9RnldTz+lk0XSmwhsM/rBpoy9?=
 =?us-ascii?Q?CWAQ4LQAlsXAP3/fXYFX61GRpcAqYdCOZd+SlV6NiIJ7bdC8X5UPaOrOiF7l?=
 =?us-ascii?Q?87hK+OHwTVQBYL3Q/6aU+9UjKkMbAv+lXkyjoQptCdylNLjofPBAzxhs4jfM?=
 =?us-ascii?Q?+35ddKqt0O4jo/lZXD7SQ5+0Ko/Sh/tutsY3tj9y4F8R8icw97R8diyDExry?=
 =?us-ascii?Q?MrdoW7DPnAAz5JmBCTRgvxDN10WQDMtcoCwKLtLFM7Duqn/DqqNo/H/BSJXC?=
 =?us-ascii?Q?CnTjIIfiyac/6/lmSkhgWRtnJ6iiGefxt0pPEbpHFdQOSWedO8p9xd4GKUkW?=
 =?us-ascii?Q?clMhXmdbCuRKelKSaAym4THHMNcqHzotcWHbDLzsq+G4XSis+e1KyPDo+b5q?=
 =?us-ascii?Q?SoJHDqWv1qoVAdGmK6ATrFcq7QvxNfzsOjRijxH9hayruOE7PI69D8eDjGsu?=
 =?us-ascii?Q?jd9Bqq5RmWEf2WnFllBwuv266wTNfYo+XVsK477Oep3eGgivNzil7hzhLINJ?=
 =?us-ascii?Q?Aq5G7Xu9/meY4WEu5Ae5c19AOKYn3iyLaF89xJ9otjWrO2eqUBVG6b6xszTW?=
 =?us-ascii?Q?NaLsxRdOReItwiUAxfb4R+GaAwco+f2FcnXQ4wd6dbhxiN0+SCvRRdoh2Bkf?=
 =?us-ascii?Q?rjhhZcJ+Cg//xx/9EH9Y3RVFlcWgRvz+/6sqyrKbN/11b8Ov+m+dQ6bI8OZQ?=
 =?us-ascii?Q?Rl3B6AM7cavg2a/e36apnMgKmO80x8YpKpRmlENJJDyG1qa1Ro0GJaEqVpi/?=
 =?us-ascii?Q?xCernFjlNy1H1OB5KJO/0LMjQB6iCHoGHv8hfvMORSp9QkxS0XAh/aT1Lq7s?=
 =?us-ascii?Q?+VSEeq5qCHTqS1Ps/1Sjj1swvxl7x8QAfvAVVXyFwIxSJ0QqUsdPxTlTBg5l?=
 =?us-ascii?Q?ruRyzM5K7etGGnVre3ktuz0LRg3vYgaXQ6/C96G39ZfeIJSe1jbNd6vYbfq+?=
 =?us-ascii?Q?GLqTf7Ms/yz3qTw63GlGyELXihz2kzVpoZ+yYFEv7uTBTHtpFy9C/XEj/jYk?=
 =?us-ascii?Q?YgGgP+e2VB8eArMPhPBWlaHh6cAZx+3jiSjdrbamfYzzViOMb6I2NeZXDQcI?=
 =?us-ascii?Q?b7ioX5nbMrXul9RShpShhP3qn3TDfeztyAW6Q3b+JRiRtg65+2c4A1c6yEZq?=
 =?us-ascii?Q?TMwReaiw9V8FdT4LbHUhr1f3kgHLnqb4TELPxnLBahIVfsOWQcOw8CRueEgH?=
 =?us-ascii?Q?PQq2rua/P6iZXryg0uHmkj+2pvkl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:37.3867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6187f292-88d4-485f-ca9d-08dc819213a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
When checking the subvp type of the previous state we must
pass in current_state to the interface instead of context
otherwise we will get the wrong result.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 25c9a407779b..0d27eec724b4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -643,7 +643,7 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 
 		if (pipe->stream && (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN ||
 				(stream_status && stream_status->fpo_in_use)) &&
-				(!old_pipe->stream || (dc_state_get_pipe_subvp_type(context, old_pipe) != SUBVP_MAIN &&
+				(!old_pipe->stream || (dc_state_get_pipe_subvp_type(dc->current_state, old_pipe) != SUBVP_MAIN &&
 				(old_stream_status && !old_stream_status->fpo_in_use)))) {
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
 				hubp->funcs->hubp_update_force_pstate_disallow(hubp, true);
-- 
2.34.1

