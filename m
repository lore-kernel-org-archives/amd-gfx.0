Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222E2C3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF05E10E8C4;
	Wed, 10 Jul 2024 19:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZjE7yMQC";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705E310E8C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoWjYYIgzkeZRnyM52OLbtkv9shl/5dQsOsu6Py/KSTIzZZIeW6uLDYE6ftijWB8UZGKJuiSAmU7ogLYT5PBs+lTueuAgaRuskB3mbqdabEZaqcGhYHoAuEfH7QEhXJKt88hIUCRrfk9FmEWmDhe0QZoS8lzo3fqY8LfULl0kWRi8cHyJadyyDPf35o2Go48p4JJKdwWp8oUB22nNv5ZQb8EqB95jU3/3FzCJrppRz8dShtG6x5CXnBGqgIJbLdHFqfB8P/ip0s6Hc5GMAgmRFbI1n+Y7IGmc9nc9fR1kp5uKJgnGwoZbiTwJhnPtr7qTHgNZRZMYq5SNQR+D5j1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bium/Kbs/ewERxI4eOdU5Bz9UQbk2jRLNIsVTKvjY0M=;
 b=JErLowXhUGMJPNpwBD85FZHSq6WXshRgJ5ElTeGOO/e28c/0gdr9Srq5oZcBtVTlpxUp79bVy9RIebsgfEkUd8xYBirXaNWLNoNmp0X7FwgqU8ch18GPOXsAeRlF3/kOtonKwdjxxmU42Q+t+jpNeXzegGt88zYPGRWHyb6z/PiLGuhKozRNTX3KnMwwTQkP/sfnO813vAxfsAuNQ+m4CN71672VPjAhwn6QCjv8+sV+c7HuAkSa8D4RYHGH/y7vGtKwaADFuF8riL1pb01gL7ZuI6yrgw9D54pu4Qz4xP1SYi/YaTTF8lA7WJbZCEOXynw/ufwPVShxSyKuJh0jdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bium/Kbs/ewERxI4eOdU5Bz9UQbk2jRLNIsVTKvjY0M=;
 b=ZjE7yMQCbb0xhg1D8zCxNt4SFkZDQmf0C7RWOslh7thn0251MGl1xGko4Biunx7qMQErSjLC98bezdP9GghEhNRuYhbUwkOmioG6mG38Inyh3UurAfPSHo1hfAUWlIwLTnpuZp8fI72KbrNJA8R05yZG/PqEV2QSBhQ9zk336c8=
Received: from MN2PR06CA0009.namprd06.prod.outlook.com (2603:10b6:208:23d::14)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:40:17 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::5d) by MN2PR06CA0009.outlook.office365.com
 (2603:10b6:208:23d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:12 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:12 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Fudongwang <fudong.wang@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 39/50] drm/amd/display: add dmcub support check
Date: Wed, 10 Jul 2024 15:36:56 -0400
Message-ID: <20240710193707.43754-40-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 737b4544-2a80-42fc-40ca-08dca118202f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K7/Bn3v6Oer8jDcaO8LdBY/pdus4yDXwyqLLoCiPcphvxhEDOTJYarosa0Hn?=
 =?us-ascii?Q?6vrTQy2W6G5u5FaYf5+hv7I+tszBdc+rDQ/9xdWqBLMpKlU4/n+QtwlF2KQl?=
 =?us-ascii?Q?+mR4WGwiXgJTNyW9gDAAtzXDswPJTU7JzhB7lU9wADaKlJa2RlyorK/+Lv85?=
 =?us-ascii?Q?nC4YvMhB3Ken5U1XmPTp+Kkygx1M60M/RlvvvtKt9H7+xw4zKU5AkYoptEcM?=
 =?us-ascii?Q?sGz0wBN/q30iActKadtRym9YtkURuSWnpgms5fJKmZCy3YLoE9Kf7R4r/gfl?=
 =?us-ascii?Q?K84TsHAabFRi3qxYtUBjnwvcSpwWRHP8bLRiD5aGUfr5JA7WtVacj5vsMe9H?=
 =?us-ascii?Q?yGn02nwJ/JUPBerR2T0PAdJQyTk+qrmGllvEySDCkfSj8edgWqUMy6roDd8j?=
 =?us-ascii?Q?v0Xjp6AvbhGbpgjFwBCauToIo3AIPly1roLwUSiOZtSGOyZk0oDuHslNaf8l?=
 =?us-ascii?Q?4GecQ8e0r1znT+bbiHVuXtDwvvorNUD2vsSNoY44CDqpfssgba8s7ZsNnYME?=
 =?us-ascii?Q?ej4WGxFlwUnvvWAOYxk7TwWsPKeJ9NpVb2rOXK5Z/XhqTFkqWqN+yDbjLx0D?=
 =?us-ascii?Q?V+VySTEZNHT3kbWRxvee4ylDr+L+mvp/Pl70FvsB/juZNj/Ke0RCtR4nf7BU?=
 =?us-ascii?Q?znX5bKgr45BbRdzuTZUjrj3H2WYep/OofL2J+aH9JdOC0JuisRL6+bVokNSB?=
 =?us-ascii?Q?ug/h0PZKP8PaiaO0YwDqZO91szzogvHCuQhpCp+2XETjMyhzae9P02y/ac6v?=
 =?us-ascii?Q?zEHi2qKMtjsMZifJS56fIiEMMsTG3yglfT3TQqvHdXnL8AZaxollh+BNwFmF?=
 =?us-ascii?Q?MqP6cdNvDeBhYb1di4JVQRtaLi2HRn0c1G7E7I5aOM7mtP6Moj3EwvQHKgbs?=
 =?us-ascii?Q?1e3BcYko/p2punZG82oGZ7R6RpEEhsWtFK1fha2cAFiYnMaQJRLK9QOUbppO?=
 =?us-ascii?Q?5x2cTfZl1p6Qg1ELakfe+F81Cl8fGfxavVZRseyhVI5TwZdTYamEGs4LLsRv?=
 =?us-ascii?Q?ZB9e2ENwvLDOHTVm+fnGhNktsv1lDukLasN5x1+07dOz8wTTKXZknyaRVpkM?=
 =?us-ascii?Q?eODt/n52HuFW2QWe5JolmBJAC87xNzctlZZ/3sfTKXr0X8OZjGqsMiP20CvN?=
 =?us-ascii?Q?Di8MJ1ezX5Zo1EjyH5Lyi5BzizDg6L99opE582jdmtwbHM/mVPmBwH9NuL1O?=
 =?us-ascii?Q?TEBtE4e1EmvCo9kHxpLla6ylDQkeXIy63gRRLSu6sJEeI9POw+IGdg46XaoU?=
 =?us-ascii?Q?E9JfKQxH+gJfvJW14wbmm9EqGw3lD+1/uJ6rjZiQDxL4r+8mDRTyWBPyxAxa?=
 =?us-ascii?Q?Cg8AsqLD4yhYln1dS+d3352IpTLbBFayqs7wNydT0cK4FkPYQoWW5xf6KVTa?=
 =?us-ascii?Q?qDg8ZNusu6AUbSycincc2Rsk+AkPC7KGS6K7+FlKCY+pfhS2tJ31XLtYaN5Z?=
 =?us-ascii?Q?RmlBQiFippQz+Eqkc8uKbArXYHqo//5X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:16.8678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 737b4544-2a80-42fc-40ca-08dca118202f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
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

From: Fudongwang <fudong.wang@amd.com>

[Why & How]
For DCN harvest case, if there is no dmcub support, we should return false
to avoid bugcheck later.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Fudongwang <fudong.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9897e322e2d5..f07b13ad4ead 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5574,6 +5574,9 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
  */
 bool dc_is_dmub_outbox_supported(struct dc *dc)
 {
+	if (!dc->caps.dmcub_support)
+		return false;
+
 	switch (dc->ctx->asic_id.chip_family) {
 
 	case FAMILY_YELLOW_CARP:
-- 
2.34.1

