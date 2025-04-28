Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2D8C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4169D10E52A;
	Mon, 28 Apr 2025 13:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A3Ud0sB5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99D310E52A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfqafiwfZAP4nv9REJXAIBy/EfNinswjvn3+9hNWkdandIk1PbTcp+EfYv9HqtqzCzTSlvQ+YKJRR29NnHutRnSbkRoMJ2MhyRbvkcvGDakEiKOGpCv/pvvKajAWvBbYwh+ltk3Hc70xPTF1gBtFXG2M7YbJZ46F5nZ+uj0fmoD8BJ5JKhF10pyeLHIPamTStGCyGY1MiwC9NrvKuUH8uzqXmcBIB/1mVrC9cWIDf4ezziBBl8cvtKCiL34gVb8uDgnEEkTz+mjuuJWZmKn22b7HDYNZy7EwU0qbPhM6Wkw14qzfBhPXnsOZrMN7SBQh9RFJINDQ6nZANJayOm89BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWO6AKRPzlzkaRSO1NZOlAYcNloUCSySyrsqnBrTAww=;
 b=ZD0r03QxK6fGrzsZ9WB0iduCO/491pOVgeJveo11ykBbOF0MNMgYBAl5AiHldcysQEIX/YmXuUKsS3IA9tUZBJFSwrCuPPbxe7inFfRQ4vPdg2K9aDXEy0ks4q5v/pdy6oyiNUnCD4B2eqlYxU1onIx+Axahoi7QwQC82Xf2TZgSiyLWhza1lzgyCinXyP0WvD/kJDbmsvwoi9RPQYabemW8jw3cDpphE9w9/9fWesLfte3wjnHSjcfgzwfHVAw9lL2VmlF/trOM8ite0IM28Fp5T2yvuBItnNidX4z1NSUebxxXBrLHcHei/YZQdfEZVvIboZhkxfmsAoOKxzuHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWO6AKRPzlzkaRSO1NZOlAYcNloUCSySyrsqnBrTAww=;
 b=A3Ud0sB5ihQo6ow+k2rEW93rooQcWnwmIb8RwK+tN6J/Mj2hqMM+WZl3ZrS0Uxjft3Fseqfduu7KeiYTlXOrSTpIVGiUXYxZXKOXHl6DkRbbGjmtbmlejUcQzrPb+xKZbU9Ln9n4IZcTyZdGPlzSdhSKLrS4F22JLx6QYGpZpUY=
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 13:55:55 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::d4) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 13:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:55:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:55:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:55:53 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:55:50 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 03/28] drm/amd/display: Promote DAL to 3.2.330
Date: Mon, 28 Apr 2025 21:50:33 +0800
Message-ID: <20250428135514.20775-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d51d4c2-380c-4a26-a8d0-08dd865c64f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y8J5bUT1/qMJWPeHkCHBe0c2sm3ocMuSkkJq/ead/ZKTREOBoyANhZusWOJK?=
 =?us-ascii?Q?gmibsDdMZx/8eN4qIUgoTLzMDQhjHmisrXoT5RiVL4xHcqPHOlR8PCSrEIgQ?=
 =?us-ascii?Q?Dix/gGaQfyQl9aAbSmKlTzba+dc1hg3bVwmHBBgdFzROZP2x/Ji0DINwDFdu?=
 =?us-ascii?Q?y9z597b+YPoEI2ABw8QYkq16SYmcL/lMLLl2N6nJgOYxDrYsi/vsjJAQw6jq?=
 =?us-ascii?Q?N5BJ6MbiMXDgfHuj9xTuX+e/Y7/k5q9W/MgMJgg7neQ713KBZWhD4hrPfPsS?=
 =?us-ascii?Q?WpJomAXiYsCJinewwSw89MqcroS5tKWaPPPJXrzVibvElGlI9RPAk8oresD4?=
 =?us-ascii?Q?7+UFaCXMnrwTME4lRm/y22A6OPw5bP3Jw4HS7BwswoM1qarquRBzmlzD8Ovt?=
 =?us-ascii?Q?JrhSGpobpPvyBIPZVtcrdXEgEYqp4ctAt4/0J1zwQjUpLHhM2p0HuZH9p+jL?=
 =?us-ascii?Q?wxVuvwkHL9bBE1fnhhS0qRARvLzNZ6xzVxKve8BDUhyI45WBQkyup5s0Dj96?=
 =?us-ascii?Q?bYuM7KbM9WgflS97uRyjXngyATONOpXAiRTqBjG04Hbsn5exYj8K00F7K6KS?=
 =?us-ascii?Q?t55bjpKOZbcMjBIGjamELqEF7OhXA0rLk6MyY71SxpyizzNVHNhKp/rWTHiu?=
 =?us-ascii?Q?YMWXkwiNVlw0DdiiE63Q2ftmzQrqqYAhFvo54xtwYjR31VCEMhneRsgpArCq?=
 =?us-ascii?Q?7gDkvDQooSwPDyFJZyDS8EwouvW+XuG3LWCMjCIosEqgujlMeZmyxLBi+aO+?=
 =?us-ascii?Q?3YrJqjrZ2aUYfqvzS5lBIWfdTZL+L+pB5OaUtiO3/0xPJPhkm8eF4oACZSzA?=
 =?us-ascii?Q?rbpOQ8Cw10g4iOXjoVUcM67op9yJR7JRlciw2kUlJblURbWOMazg2mpq5qIh?=
 =?us-ascii?Q?xIow5ycMO4Ddfu6oW3ceAHQgforTUwro8Bvc4/CEeq2wQhY7iVbxwy8hUGT4?=
 =?us-ascii?Q?QyAiWo2Pzyv53wvZ9kmXMp4U8z73Kj864KatX89/jtU42isRd+k3QxByoab0?=
 =?us-ascii?Q?9exZ+ccUuinTrEq5k3zUkcIjdYAcXlWiw4CzupVuJsX+68tZCdbFTDl97K1N?=
 =?us-ascii?Q?5aep8lji/mjzs8Te1yhlIH7zf6nU+YLcWBgVqT4Fz2TpvlscOHMXqmvePRhi?=
 =?us-ascii?Q?fKK9AiKaQu5b2YreDm+mDnjokvUSjaGyNtq2z5TeY1nL3SdgBMm3+6bhH1Ow?=
 =?us-ascii?Q?kiUv9s62y4TUp/LXFb0BkP00D2tW0ah1zvqVmDb4lJN7ilF57gBOP21fpsEn?=
 =?us-ascii?Q?TgVOuw7f4aFhPP+7RIUUyf2QFFFh24a/2Jiz5f+calDv1TgJryiS2V/hXwjd?=
 =?us-ascii?Q?PthDBNhFqNyxAo4zmRgVBpcAEkrsgZsVNCAn9Qm2QouL0cM4TTkQU+rWCc2U?=
 =?us-ascii?Q?HSQmpO6z0GMdLeBeK2rLjuwD2YWQstApjhzhTIXv0qThiIDmNMCA4swBHPAE?=
 =?us-ascii?Q?DqDlcvA2R9qO0eDoZR9kceArjRBSVgBtexeZu2M939F0+IM+2MQDe8+Z31cC?=
 =?us-ascii?Q?JNkTXh5B9x6spzk606p9o8WCYApcV2S6O364?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:55:54.3799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d51d4c2-380c-4a26-a8d0-08dd865c64f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary

* Update IPS checks to properly include all ASICs.
* Refactoring DSC enum dsc_bits_per_comp
* Fix ACPI edid parsing issue
* Update AUX read interval for LTTPR with old sinks
* Correct prefetch calculation

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Acked-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4e7423cfe799..a9bd84469821 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.329"
+#define DC_VER "3.2.330"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

