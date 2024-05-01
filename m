Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A11C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B37D1130B6;
	Wed,  1 May 2024 07:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gfjOHoLe";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F7791130B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgzsE/ZJUvC4atHowyaKeZecyn747scZ9wE421/hxMuKZq4gpH+rmyyJk6hbz9o9i6VTxi5HIuOWr2avyQUQQOvrmS4z8rvVVsgOy8t7WCPQYjCHoYpi7NY45xl6bNn8jcVfj16xDD8V0oZ97HcMoDDzmY4sKQ3nGGmIFP2PWuIHJmgmPEP4htpuc0qyax+uedBhjFpD0whAIDAk8OzlJLYJEBSm66Hy3TzCrMPWkd9c8GiOUfAwXswiCE9a707+ut+p0PJQeuId3DLlgB3v63IcTEtDBmWpdSYK1JkG/A8M8TJccUmKclFi/n7SygrtP7Ci/EQutef6r1cHApL9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfcI5e3OdtxoTn7TyQOH23W7z2qQO5uaWytsNlpNWwM=;
 b=hZuBVavAdGdFqegKzdfSow9NfKfRsZT4orrq8fK4wNOKVjWHLfNRxwGjybXi3jkUe5hKnuHxhzDkkmKhcykQdYcf3RSZYXytxwHXpDZPDfMpbjMrGYMMb1C4AQujgeyNzgFtv4Ss1n4H8dSBeklLxlwArZMy4YuBnMcDEv53lgbcIi6dhkPV3FyheJ30RTrTQAOw9NlvxqHggl67SxpevhUFt+DmJU6W6RzsNhrMWMw+U5So0/+WgSesTfEi2eI3u+apROXKKrP77rPwKWfGS8X62CS5aADjm4P5vlgglhJN+YBxpEz+MUx3aV0yfh4ZWBcGSurqe11BT9kPm9C6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfcI5e3OdtxoTn7TyQOH23W7z2qQO5uaWytsNlpNWwM=;
 b=gfjOHoLeGdQp9pdHf0atqKO9WnqUG6I1tr5YA8YMK5jp1HE5TrtBeIC0u0ekj50m9UHnIE5a84PAbpSBiRWKnu413I+u4y7//ZN/Hr2jvyYhJZFsjz/ZXJOS+WB+F7de6KWqHQviInjTZ/Tpd7v3skMvBYaMlu9ofQ2+gDBCvIw=
Received: from SA9PR13CA0073.namprd13.prod.outlook.com (2603:10b6:806:23::18)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Wed, 1 May
 2024 07:18:46 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:23:cafe::fa) by SA9PR13CA0073.outlook.office365.com
 (2603:10b6:806:23::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 07:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:18:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:43 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:35 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 18/45] drm/amd/display: Check index for aux_rd_interval before
 using
Date: Wed, 1 May 2024 15:16:24 +0800
Message-ID: <20240501071651.3541919-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 426dea2c-2ad3-4043-d643-08dc69aef0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CNlxKRcTa0lJhfkSnCCgfHRAX3C/JDNVNpkmBRjy9s+Z5Basv+KihdI/T/bQ?=
 =?us-ascii?Q?4ljEJYGLP0bDZDSZQwo8X8J/67ZEfE+o2nzy4MUbw9+YNRxaZml3fWNxH+m5?=
 =?us-ascii?Q?4nbyfSOAUW9lJTxPHz/GNWR2OXEPoAAIqJ4bX0SokR+8cNIxWahhHkeo/bPb?=
 =?us-ascii?Q?NJnAlIovc8re57zYOxy/j1Dc+edlthixMxH7kuiklgGIG8T9ZnbdCZxvb+OH?=
 =?us-ascii?Q?90HlL5JvSeYhauR+oVV8sUmLT86rc81Fx9icc+uEmcChowYTXBTC+PCl8D+Q?=
 =?us-ascii?Q?hWfeCmD2mSJv+zHa/+YEzO/X1vna9Gf4Bx+kttRUGWMYNUb7343oJka5amdX?=
 =?us-ascii?Q?mJSWw/6a+ERdxnVM8lYoM6Tgr5RmJ4Ns+XYb34xTDs3UwcpY0CV0NybdFguf?=
 =?us-ascii?Q?/85fChCFvoAMlRq5n6lqO3QuaHCQrZNZZBrfo1iFWb44TnNSuq14lWcOQp38?=
 =?us-ascii?Q?k5ouR7pB+c3DyxeL5VM9BOtVDjvVigTgLAPBMtqxSJu0sutXIvfJ4A5w2nLK?=
 =?us-ascii?Q?Dj562WSi3IXuNXqH3mX+L/EmKPkZ1LoxRKMOVqBhnynpKaqlhaC0jFIz6Pb/?=
 =?us-ascii?Q?BQCx/Z+Bp/n95+3Sc8jDyD+MQjJeO6BKKH+1m+AS7h4Mk8AksT6J5jr370L/?=
 =?us-ascii?Q?kmH9bLDuKjv6QWOt+x7LSRa6JcObKVmtYBOTgn4P8YY5/3m4sm6SX3HBUDh9?=
 =?us-ascii?Q?rnGrQdHm96vKDBi2Sj/17mDbya3wCPb+zJWc+kNCdgrAKc3BxLQBt56KZMbN?=
 =?us-ascii?Q?6jZLGNyP9/5MmvWsLhx7omjThcg6JkeIfAv341MEOdBOUfcTmeg1pTzg1OA/?=
 =?us-ascii?Q?9ylmOF6oHd7cyxt0JfgHFGOqxT8V1E+ZN8M+WpX3u/vUXBqeLvErYmDQ6mhQ?=
 =?us-ascii?Q?UIGtoDhh0fHTpvJow+bPNr8e+BQjlk2AAvEI10dp6qgX4z76cKmFIymuIFHD?=
 =?us-ascii?Q?+HlMloE0BdpSRWIkhJ6TD7OmxmwU6oIgWlupzKjWogjLFbAfsDUX4W1okXLM?=
 =?us-ascii?Q?YIIwzD91kznMk0I7/Xs17q/fIyPapuVJLU485P6j0ebZvuyCUnd0DpsARDkb?=
 =?us-ascii?Q?jjPlQgAz+ZX/M0AJVgZjRLxMnHEag0p/x8PKoM8FNaDJ5GUvqX2R/gCqTb2K?=
 =?us-ascii?Q?2Cp2QdVVeKRNFH7FhPc/AtlyUtNp/JXAFfh5aBxo1s+JESbiV9bqJJ1cLlcv?=
 =?us-ascii?Q?KMNNlxLd8yhGG9EoDO2eM90+u+hMVdk48iHyb2j01XRb1W1Husf6+yO4jcW6?=
 =?us-ascii?Q?yIW3lrKPo03X2cfpBVOjcnFOgPNwXwTSuyd7GrkrmL4Xjgv5p2mEz31GMqok?=
 =?us-ascii?Q?bNjEPsHnWrXt6gZBSRRE7YkJ4EgK4psx7IHzZ6na1u66LZyVg4294PywJ8Su?=
 =?us-ascii?Q?KEd69Xc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:46.2464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426dea2c-2ad3-4043-d643-08dc69aef0b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

aux_rd_interval has size of 7 and should be checked.

This fixes 3 OVERRUN and 1 INTEGER_OVERFLOW issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 1818970b8eaf..b8e704dbe956 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -914,10 +914,10 @@ static enum dc_status configure_lttpr_mode_non_transparent(
 			/* Driver does not need to train the first hop. Skip DPCD read and clear
 			 * AUX_RD_INTERVAL for DPTX-to-DPIA hop.
 			 */
-			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && repeater_cnt > 0 && repeater_cnt < MAX_REPEATER_CNT)
 				link->dpcd_caps.lttpr_caps.aux_rd_interval[--repeater_cnt] = 0;
 
-			for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
+			for (repeater_id = repeater_cnt; repeater_id > 0 && repeater_id < MAX_REPEATER_CNT; repeater_id--) {
 				aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
 						((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (repeater_id - 1));
 				core_link_read_dpcd(
-- 
2.34.1

