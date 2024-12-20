Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72F2E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9685010F089;
	Fri, 20 Dec 2024 21:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OLPLXzjY";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9693810F08C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEm+hnZ2lvAmk5hSqBiqZV3LaT2kOVabjXcANFwitJdun9/5RICENHKc+rNaBEEyxYC64YGldh309XAtUwGmBR52X0q7uedkyBvDEGbmDNn9mtK06mZ07kVcZnZhCbs9YumWS70zaAtNZz0Z4jOOiKHiIIlV25TB8Ozktwh6xVXEE+bwk2ixJ57OvkAMFzBoRkew2iMmW6uXYMFin/uEToRolcumq2fU+oAVm+5feDI44ziXuC+gvCJVB439yzBKw3rCHnuuBm2apgfmZLjdQGZkkjkNAWtvwW+NbCf/QDw88S4wMYSOoQVcvrInMKboT+3DW/5hATveA4gA0xgKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwgv+OVFhEbCp9uexFtXep/C4mNTeCpKCZT+b+vduEI=;
 b=PglcouS6TcHGL+cC4Hfd78qIoO0bD7lDYNwePDEmXWzv5Z1kZQ9xfeRlC9//EJZLo2hKtkt7Oy3SPkQj/HqNVeo81h9V+vPazUjzJ3WFZ6JlIlDxtC77RY2b9Qoeima2qP7Y/wtaRwkIhx3onPO+mG/vtD/kVCguGVyZw2o7RMNEeXtiaRBSELfL8HI+k2Dwv28nD1CO0BIcCNCOGu0CwMwXPJUlgtvhhU0lYxfcSp60h6HY7pXASDLovW8JIQoMsn6/ZVM7lSJEnSlN9V4rt39lvb0ro6HNTtlDkFYXYzOc/Kcl0nDrKUO1aB+RGqsVTFPAnGiOhbaaj/4KO3Ex6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwgv+OVFhEbCp9uexFtXep/C4mNTeCpKCZT+b+vduEI=;
 b=OLPLXzjYl9WmQCkwYnnIOEB75RhV0eEaVkmB2zG4Za8o7TSSxmiqSICUC/gwQZEiLCnyYwawETrjoUO4S+HxsOMa2eE+rqaXqpMilhCp6UFBekLuS+ZzAnhzaBsBiXjtfbTZnqFc9W+5xvuB476rDK2baG36+A4yySPYNKUChFQ=
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 21:51:39 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::62) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 21:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:35 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:35 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:34 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Martin Leung
 <Martin.Leung@amd.com>
Subject: [PATCH 28/28] drm/amd/display: Promote DC to 3.2.315
Date: Fri, 20 Dec 2024 16:48:55 -0500
Message-ID: <20241220214855.2608618-29-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: c515f6f1-1fe9-413e-82ec-08dd21407b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DyM5Z44lGR0RxKlplGqaKY6xUtEHfar1am+RgJekCUyfoD2Qx4X3Wz9B+jKq?=
 =?us-ascii?Q?soD7kHTWmHMbACAfOJXq7N4QkdHyFyVgK8b69yFPvMSP4rVcUqC89Yb/l1hl?=
 =?us-ascii?Q?pL6COjfzPNMULAjablWY4AuJ97e1vV99Mi4qx9EP6vX4U6KIGyVWoTa2UW9J?=
 =?us-ascii?Q?xLylRZP8rQ+UdeTqVJXkzwyA45ENWC9d7FqQWqn8m7u1EWmjZQtfqtbeZuOx?=
 =?us-ascii?Q?jFphwFITtoxoHkR9VWTdqq+14E0B81Fh6XMgX+bpbE1/LxN0WX+YSOuouKKF?=
 =?us-ascii?Q?/z/BgdAuWu4oFthYPjilNY2ryre238y8QVJvEf6UHiKkN38fP/fIQ7m2Xwgn?=
 =?us-ascii?Q?wtIYr89GQRzwIoRZDLIpspuWU1wkrZzp8QIgsym9BgWMg3QHbf20ug4q5FRl?=
 =?us-ascii?Q?dy60FRjrOCEkzv7TNoOPa7ncSBTw/vGNglzpAiUFpFDy/+IE2knT8K9cmMeQ?=
 =?us-ascii?Q?uJ0ewCUFsv2vY1ghPTUBzF61wm1yNCQim3Pch2+RVEoQO03KWANsN0EyoeUK?=
 =?us-ascii?Q?PMmt0AMeyRNyLIvx38l1/0gh9Dw2uvDU/kOaWeElFQddhRi4Lr/Lr9fSAhuQ?=
 =?us-ascii?Q?ENawanTyJOynIuUUM8FSjPYm3NZJ9fcFmWXQPIVtGHjokfRDWSWXu5kqq7xv?=
 =?us-ascii?Q?OeVhaYSjGcnbFALzJZPHeP8PoBa99Z/WyjU69A/gxeUI85Bv3m+Jlh4gXy+s?=
 =?us-ascii?Q?gYGwwu8vBGtgpazkFsqMao+TAYW29R/tBQtAvYeFWHkDQA4cKkq8lWjHoFAN?=
 =?us-ascii?Q?2SsQexyj8739OlpNRRXJJo0bPIEWni4gmwbJ2ZnwSrqFSO+xiSXYmOLGA5im?=
 =?us-ascii?Q?bQsedvgwiyzRPlCBvIyjhqAXckX55KJ4M5lPRsE9ns7a0kR6814JBLFmaEK+?=
 =?us-ascii?Q?GuOTmNZrouwjMA6mxzJvfWUcjsoLR/7Wl/mgzk1gBMjeisvAcUNf7vfVhFJS?=
 =?us-ascii?Q?DyEjZFOe/01GGDyW4RgV7VPqZRrNAzbnRaT1H+AvhM8qsY7vIfR7zLuGd6oH?=
 =?us-ascii?Q?oONWaP+Y8UsOeGU3/XilUXZxu3Y4cd0VAeqrkRV9quzaooDnA3C+QwEW4VHC?=
 =?us-ascii?Q?F7c99Oz6TkCb8v9GAlf1YtXS2lRKARdwiZTXONhCI6eapjhaDBxvAbgaHId1?=
 =?us-ascii?Q?g7HtRKJAdoi9IeoyXaz6g6jQHu3WYhxqag3vLWMsvCf7tZ5KBqC2sNIhYD8U?=
 =?us-ascii?Q?Qgxgco9fRmWv5zQEv8Ehnbuo8YyXexvrkPwwjgoWew0pfoLNi1+d0R4nghNG?=
 =?us-ascii?Q?8y7JF5plnfSFDpAhVpkqJ5+e0HYTuE++LjIpnLFDVRNDA2v/nOPTvbIXQ3RO?=
 =?us-ascii?Q?v8ht63OJkvyKzZvjwhNChv6G7w3dvKl40DcOZ61Icbpy8sPTQooYm4vFSzEW?=
 =?us-ascii?Q?isI8zX16rAVHW9eWYnbb7aCB9KX/4WhMzHeiqCIS7RtB0QDH2gR5kVUyaExp?=
 =?us-ascii?Q?PCLo2Wk5s+3wCmnmhFEASgz48tYFhhloGf23FSel1k4unXkM4DHC/sQoAEh+?=
 =?us-ascii?Q?Aqj6lD95cgjxEQM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:38.4995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c515f6f1-1fe9-413e-82ec-08dd21407b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387
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

From: Martin Leung <Martin.Leung@amd.com>

This version brings along the following:
- Add Interface to Dump DSC Caps from dm
- Add DP required HBlank size calc to link interface
- Add 6bpc RGB case for dcn32 output bpp calculations
- Add VC for VESA Aux Backlight Control
- Add support for setting multiple CRC windows in dc
- Clean up SPL code and outdated interfaces in dcn401_clk_mgr
- Disable replay and psr while VRR is enabled
- Fix PSR-SU not support but still call the  amdgpu_dm_psr_enable
- Implement Replay Low Hz Visual Confirm
- Extend dc_stream_get_crc to support 2nd crc engine
- Update power gating logic for DCN35 hw

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 23a6d56d0798..74f6878a3692 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.314"
+#define DC_VER "3.2.315"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

