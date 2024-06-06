Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BD5C27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222F110EAC1;
	Thu,  6 Jun 2024 21:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rfdbi/Pg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A34910EAC1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx5gzvDgS5s4tqGQR8TtUQ+1s8fESyPkjV0KFzbuIONd/D3rbgyoNvL/gic/MlU44sgFYptVj+AoG7m0Aib+z1itBwIEyVl5HL8rl5ggmg4HynUu+hUVCzfqv0yKxV3Nw35D1rhlaffwCHoc77hOHHSKt1zgszmcJ5bjZjUGg9VcG+13VjdQ4vy0YYUtpShZqJz8xF2xP8Rq6ey5wQ7hkQUt3D7EbKpRV2ZrJKEzjBVlNwu7AcsH9UW3VT7sN9wsfuontPgO/ikHjs+Sz4zDxIz3B1gNn70AZJvqPwIUt8lhkOXjppiJKYSuOENZGaiWuEVyMIm2hp+n6dZ7fvtOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iZ0/6eRpAQQem8rqORnHUeOfKNVgxw1V+Q2S9BA9Pw=;
 b=LcmyUDvk2w9UEJAwDK6ms6rARhejNOFO7Dj4KuOLP8NOkTxd0WXquaSZIQZ9VpysE0XWwFuvetnBicN32R2KRYAKuFV5yoxzWvtwjAfGFbEMzvOqzJ42aSsdQwCvJAybW+ZUkZUJnc9fH5Mr/B19Id9kuYql41BGqeEA4tmQUn5nhUwl7QzI/CD5ixuRpOd6vARVZiGChzBJs0oJQ01FAiEIXZHSLNZF702aaqeH9wqAO/ejPvOt/cmYCj3IAcRn635mKXrOBV1VEqLVczh4xCav/S1lQ0XL6fbP3y/qv+2DiR4UcheWsJZ1Nxn/erDRIou204r9ZGHPPnGjzVRHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iZ0/6eRpAQQem8rqORnHUeOfKNVgxw1V+Q2S9BA9Pw=;
 b=Rfdbi/PgAo57lMuJQYGhpSggsG77EQGhzuSlkWqomYPJaMVukn4tWWwtcfWulaAlsFy+K8j3Kf7kieg+HlBZL8WOxvxjA7z3oyAhXogvJ901jSN1TB12xwW6z0CS9FHjH5jvFpVDnl8SLsZURoRnE7E+jpttUQWWxob3Yp6PyjA=
Received: from MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:57:07 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::cb) by MN2PR20CA0066.outlook.office365.com
 (2603:10b6:208:235::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:07 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:05 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Nicholas Choi
 <nicholas.choi@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 12/67] drm/amd/display: Remove NULL assignment for
 stream_status
Date: Thu, 6 Jun 2024 17:55:37 -0400
Message-ID: <20240606215632.4061204-13-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0aea90-f4c5-4dfa-c9bd-08dc86739bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oosA74KZtxEMynB9wfNoJAj6T4ZiBjJU3Sq9jI4x06ieIM3LEdaz6wRN21IC?=
 =?us-ascii?Q?lVQu2AvEmuqngnPg/WAUQ4cVsArugslyMiehimUzG69ZqfDaYvxUmz1Ha9pR?=
 =?us-ascii?Q?CUwOp02aOVSeaSO3lP5MRNau/ykx4NEcg5D7RCeRbYkzl792PBkvEV50wUu5?=
 =?us-ascii?Q?gyVa2yVVkLilea5uGSphkXX5D+nL/YaiSJpl+gQokLjNuLO355+jnZO/HC6K?=
 =?us-ascii?Q?PU/uw7ZiduxzJk/eB0N0L3Xq18X2mCuVdDiH4GB1frdpArQATCBYLcYrU3pY?=
 =?us-ascii?Q?5Mppl3l6ezifT8N56DsSGggQ51NZPXzXWAEWJacYe8x3Nih61QCEfJ3UEEuE?=
 =?us-ascii?Q?673zGXoYp1J2iV6zTshQPmYCDHpHRVVNuRMFEAAglwp/oBbK77ac/nop+wqX?=
 =?us-ascii?Q?o9ldmqqWWmHfBzus0m58qUxqKZ8vZ/MqOLShehtfLoAqu5D/Krb1je7rLw4u?=
 =?us-ascii?Q?+nN+4GqVehPkTQPgGWpsX+mbLgnR85By4lGZTAu89C/rMm/1hqKaSkUnVCWB?=
 =?us-ascii?Q?uTQ4Vt8gY+x/1wC4aq38d9EqMZWq7/I3+Fh0UeCIv0gMK/dEDvHxz4CXBqvp?=
 =?us-ascii?Q?f84X9TzfssFqFjPcez4rMfryQZxjZTtzajvL0Bge0HwxONf0zxw+14j2MhTs?=
 =?us-ascii?Q?kXRtMve05sdWWEikMpgHTGPQRAEzI/1tCarDTP7Eam1RveKF5BkpBnMVA2GE?=
 =?us-ascii?Q?LcRfuwSvcsHqU6hHvAzxzPUJdbYIuxMpY5ebE78RxCIPH/U6qW/A5mHkhyq9?=
 =?us-ascii?Q?u5yNtJmUv4UPdPIUFP5wcDZVC/v4gktNvBn+Xi3wDHujk+RBDmp+ZR3kpaR+?=
 =?us-ascii?Q?SnGTYWKcQDwn4/pivCBxLXMCH3kQlyNbrRR+KA6WGUmdsdkiNUFo+2xUQd5V?=
 =?us-ascii?Q?eaF9QJ+GejV/XP7OTaaGfBSyZdvUiGMUTAGrEcWhuu+sUgpAQhwCq9XTUaC3?=
 =?us-ascii?Q?sFqCy4wqBfHlv4rK69GsWF4B2XhjE9q2ZjODm/n6YHx9cojFfbLFCCaH4E+L?=
 =?us-ascii?Q?UEGurYOYxh3nJ25+sAu3H0RMhMl+C/NaoYEbZpvGOIUc5WGaKOkZI65Uc9Xw?=
 =?us-ascii?Q?QfhSnS/K15b/M3iR81F5k0ytcIfgqZ4qKSM+SYl3EzE1C43WRDVKTAU99/m2?=
 =?us-ascii?Q?IqBCSY4KBa8VpVLT4cHrkSRimw/hGPOxza16VbmmtOrI17rNt22LYPYd+wnE?=
 =?us-ascii?Q?V57qX1rAW+25yFHkEAQ84uibjyvJh7iFFoB05W592spxfy3P2X94HyLx5PiE?=
 =?us-ascii?Q?TKEMmPdwcM2YMjxKXyrNMD9HAajg9ROBchWdwcsVEOVNutuUX6orc0Qj4Lft?=
 =?us-ascii?Q?uIWeRvKf/yxVLF7oKi/OUu8DvzLKQHsVjUw5k4d8OM80KmyjDM1P1YKzSNj/?=
 =?us-ascii?Q?4JcKV8+yD8TMnWeWpBd+VdZatk8KJ64CA1qohrb0SZbweAf36g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:07.2368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0aea90-f4c5-4dfa-c9bd-08dc86739bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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
No need to assign stream_status NULL because it is always
re-assigned before usage. This change is to fix coverity
errors.

Reviewed-by: Nicholas Choi <nicholas.choi@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 873993a6513c..12687d400092 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -444,7 +444,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-			stream_status = NULL;
 			if (!pipe->stream)
 				continue;
 
@@ -464,7 +463,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	for (i = 0, k = 0; context && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		stream_status = NULL;
 		if (!resource_is_pipe_type(pipe, OTG_MASTER))
 			continue;
 
-- 
2.34.1

