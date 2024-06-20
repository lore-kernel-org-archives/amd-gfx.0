Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB1BC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D4210EB25;
	Thu, 20 Jun 2024 16:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MnCshCuy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2947110EB25
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5IIKgTRoRh9bVbmrqmjM/ODkU/edcPVhCzE8zHhOBc+/h/edBqvPZT2kguFlKcj1QRByAKCD5ZnY8EWsJ4O2vikMgluL4IjtOpOyPa+ngiqVhqLQs67jkN4WMf+G/5fPv+1ncPyIjlff6Q28QaRe6C77SsNzXk99KAJZrqVPxsRzzHOETNHEIg5EXxnzY5O/vFZVPcPZvUIcflZIDKhilAwKExeW0p42n1tAirT8x4qVAAyh3AOPoJkNa12Rar1S3YydYo0c8/PGb7XWQh4fr4BL5RJGo13SLBp3kkT0gtVP4C40zNO0BpDVsp3Twdz7d0j11EKZQL4ZpsAaFG7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjeaAu980NNF/NXI0GfCyrV8sxY3dasgdkNCjpB+h7U=;
 b=BF4qbKoji/yaw5Y0n402eEhV5o2P+/4Lm2HSiY018vxtID/caliw0pRtU6jn6Bhp7gizZ39mWLUgCrXp77UdcQpZAwQs2ZG45VCTMPPAXlerV2M/jOtCZ5FH0RmfJKb6fJSoW60Z2CdpQlopswe9cDoJv4OGlkHjb4Pz87U6UNzM1tSYxt/mmyq1p+s5SlAvmmxPJutRe5SImTrWW9j8QFX4wBano2/bpaTR87fYnBHz3RJmpA0TGoapOzLg3LKl/X8ohJSDZK9D91lg6IJk0TJdslzuH9GXEVGAD/54SWZndy859F5YsEl2mwCIbPb1Tz5/DhoAMcbEvsE9Ip8kVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjeaAu980NNF/NXI0GfCyrV8sxY3dasgdkNCjpB+h7U=;
 b=MnCshCuyoOFRfHEVWKADkleMHXlBMBAgt0T+3k46deEuR5kvXX7p7cy1mXoEKir4izWtcdGKu1xTaAe+Lr6HMn7mf7hdu2Scqq1QID8779moT80rm8TaO/CyhVf4QQOIV2aFnSjCADo7NKh7lF5+u1ONTf7GDMZSxzZhRmkMeXA=
Received: from CH5P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::14)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:20:46 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::3b) by CH5P220CA0010.outlook.office365.com
 (2603:10b6:610:1ef::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 16:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:20:45 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:20:43 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 36/39] drm/amd/display: Remove duplicate null check
Date: Thu, 20 Jun 2024 10:11:42 -0600
Message-ID: <20240620161145.2489774-37-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8dcd26-5425-4246-0cba-08dc9144f081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?exuOu14ymiIU2qoINHLopp3EBSdE51K2w4JwdEwaRVwv901eexG7q9/f2d0h?=
 =?us-ascii?Q?S92zMUGbJRObi4P8RYyC/+nZhp9fl4IMf+83JRvluUBqGTkbiOhrZ0OKCGq0?=
 =?us-ascii?Q?qPNoI4/GGoHPbt4DHib94jJKKYlDwqC1YnhQLdJbaDEBrxy+zQuNBoWVJOUb?=
 =?us-ascii?Q?mcYglShTT/4t8fDPb2f+mhDuJHcvIsDprEfcy/Romag1OsLHldOy9ur4ef18?=
 =?us-ascii?Q?M8PmKjMDfbJFofG/2FAZ6IwWDnf7ZCDbOgKzcLRImuuBabEslRYqAC1zlqoV?=
 =?us-ascii?Q?9mCcgZi9IYiaylUgxQcVyXzCqpKVDugyBVhL0dDopwPuXJpLqYxMkxswVbu8?=
 =?us-ascii?Q?DDF+A9BnAkdpsGfu074zjZshCAbYwnSAW9uoXYNKnMprsMFyCuQ5m/HQXWtv?=
 =?us-ascii?Q?hbVPRRHFLId7UTxsvUqh3VGXoMIPXRpn7YPqiK9of7y2uPsI+H/1bxaZciY5?=
 =?us-ascii?Q?oG4YursVdizPT5GESXCEUHO9kwsml5Y44meIlYiNU0mG7Z9i05op2jigX9Xn?=
 =?us-ascii?Q?WEH+tWgHD5cuMHCbLBJIQZsYCOgor9LHMhXDVT7P2NbyZZ4x0Hj8iv14VIYB?=
 =?us-ascii?Q?b2hkWI72vLZJ/EOPs70PhpmVCXya6xuKQa86Y9GciX6SsC1SiTtXrtiDGK4f?=
 =?us-ascii?Q?EMl6Kv1fs9r2eenVtBeNqyiy26t2QeXYSjxYY7+6WGpFWZYfVYci4yeqBV4v?=
 =?us-ascii?Q?Dgf3IQjqh2DYXuREsWZHvM0M/OxX5teWWOdWCvb1MFndZN4HIWDTe9pT6Ijm?=
 =?us-ascii?Q?zvxVpzLRioyKGGtf61emuzRjKisny7OKKnYWsJt0VjmB+A4t19x1F6paBLBj?=
 =?us-ascii?Q?bBF2coZrNlV1kRP9PoXpVrC6EnuZ5KgoPiyWoPrlLkzBUHLfOunAPQk1peZh?=
 =?us-ascii?Q?RY8nUHMEzC9i0ccrZgVycPfeuO4pchOeAZJgnoDhN7hVoxnhJC7y7qbE6FUt?=
 =?us-ascii?Q?tdh6lJm1rp6VkTuZCHE5RhiQM2SUDTpEkXF3fWXfJS2A0EFWQ5N6M9eFHrDT?=
 =?us-ascii?Q?aEt/q/QnjHnf3ZR05XtZyYnCgnihkQ/vlg/YxJLALy3E3eT83wJIK4QCxxEi?=
 =?us-ascii?Q?w2V6iDYTwvYIX7l/2qcCadvopxlRMpJulFQKbqLjcUwE1HMQeqX1qiRA8tsh?=
 =?us-ascii?Q?gzq6gRpyw4CG04yQgRdzxbGoEAnZ9gzNMBwjdLDnbVe3487jm4Kk4sLONudz?=
 =?us-ascii?Q?MUWH0Pgp+tqgBuOX6ceSW6ohBWJpVcGJMBJsmtfvkobtLtLYAKpHQFp+QHa5?=
 =?us-ascii?Q?N4P8xhmwHANBAaOhRYadq9WOHxxQtoDz7MVfu0z3nxFWSDVCqhW7vr+KmnAI?=
 =?us-ascii?Q?2wtFkVRjKoh+JJ/mufnQVAWdBOzlZRhdzzzf1F8OdChIMmmQyq8LupikoAp2?=
 =?us-ascii?Q?cDPbuWwq5BQDIUScMhejNZvG+6xRBi9iql5rWBgVBKcJ7ihpZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:20:45.7779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8dcd26-5425-4246-0cba-08dc9144f081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
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

[WHAT & HOW]
The same display null check was a few lines above.

This fixes 1 DEADCODE issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 7c9805705fd3..8c137d7c032e 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -513,9 +513,6 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
-	if (!display)
-		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
-
 	hdcp_cmd->in_msg.hdcp2_create_session_v2.display_handle = display->index;
 
 	if (hdcp->connection.link.adjust.hdcp2.force_type == MOD_HDCP_FORCE_TYPE_0)
-- 
2.34.1

