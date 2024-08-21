Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A4C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA76510E6FD;
	Wed, 21 Aug 2024 22:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PHOSWL3z";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D9B10E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXOrlITKdU8x+j9nBtVjyPAQjbqa6/SJkhf6xiWVjY6Chtf+DcBlGIWlSkqaUNUIqjL4Ik9iP+ArQrs+0VfFYuiCy3Lnw2K5vQ2uUo/vSNhUbqhLX630MHEh5d557qaJ3wmQIqL9ESpNPDapAb5wkSLPZX8OLnvqiB6RZLtIGWAn5Uocn5HC+SHIzAbk3D/LTnQSmxRVpJ9oNauXw5zArLe5J/b/kon2dPTgEH9HKcthB61tl4Pmf8u2zfBSYYCdTi/IwkBZmJQM86zglRPrK43Bpl/S8hFSQC2WyklP0wit0uu/HqPsehDseHjsVE9OqNoosI9m1uJyvt6UGv0N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRtv30N8W/fspeyL71jNpGBEKY3Ie3wEBB1IQVv2vjM=;
 b=qSNXZrJdCgxl0AyW+F6wKrW2s5hh0a0cFbF50ZBFQuGOaRb30u3hwbK8rbkXyeC9G/OEIHISpoLiObyvvOb1c0t1JEV4GA2g2DlnlFnIlt2RJ+JxWBv1glJ2Dy5GmZkSlzVKKrML5VN9YKY+zuo2Ja3GnZF2rJmIv5a4mmoVYqXs38Rs03UxxNdJDxl1YpLlyFb3ZR7Irvq86l8FKi3fkm0dME4gvwPlcAv3s0kCuTBK1fZT4iKiBv9/6hTMTb0/kLQhOZAGn4p5mvUJEft3bk6n8E8k3zWv+MqlIacl/1LX6wgjkN1d0y9dKC9KN+dlLzuokmDyZFG40+TGtIxR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRtv30N8W/fspeyL71jNpGBEKY3Ie3wEBB1IQVv2vjM=;
 b=PHOSWL3zu+J9u0K0GiJoi8o95AlkAX1R5UOofFJnaZATtePmn///X/AYmUqtUI2wxpo6FkchNFP+zSTVCbLHyhpLbFeT9R4RZ9/XhcAMUFPz8ltpXmCr5l8PxJ/Z14s28ss0/BKzdxEzTwGpVeTZ5PM/1Pf/Bog5U5+oswT99GU=
Received: from BLAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:32b::12)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 22:04:22 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::4c) by BLAPR03CA0007.outlook.office365.com
 (2603:10b6:208:32b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:22 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:19 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Ahmed Muhammad
 <Ahmed.Ahmed@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 02/16] drm/amd/display: guard write a 0 post_divider value to
 HW
Date: Wed, 21 Aug 2024 18:01:44 -0400
Message-ID: <20240821220156.1498549-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: a438db66-90a7-450c-ded5-08dcc22d3657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8/DlHr82aS+8PaoUQf67e2dmbR8it3k4ThPdRwRpr4lrRKNk6ZzMyAZSwqg6?=
 =?us-ascii?Q?ZuZMMcsbTWcRoBADTG4g4U0ZiWA/cfn75hRf4pQHKw3TeyaUL7EGxx/XbL5a?=
 =?us-ascii?Q?8+61hdL2yj5G7pPvTXLkI7pOyfFBpfUxoBNZyrbTEKjixHWR8tz7vNbXJray?=
 =?us-ascii?Q?lpU5aRbxq88ayyPpjdO23hqm6iFqi+BHOzlAXpI0X2rOj+AZy6m3k/lB6pgU?=
 =?us-ascii?Q?f99De3fCo5kO/+NW0vxkRPrExoi2grgyz4GQty/WaFBa/dKvOCQMzGOn3NxN?=
 =?us-ascii?Q?U7hzpFCE9iD09ulqyT/E79pRceRdALDJmuwclqXgH/U8JdqAoZFAa0FDMh+k?=
 =?us-ascii?Q?/P/8XGYTUDMttQNQnW83zF51NUOu7sBKugEYhvw0QqkLoQZR7ZJZBaSEX2t0?=
 =?us-ascii?Q?S0ILmyE8gm2utX4fd1/F0Gg0b5IEvKMl9iPNdP201KTF8rSqhgEZYTO9wElR?=
 =?us-ascii?Q?vwcKkakgXLb92VdtuzZRG3j1xnS3hUVmMy/66L2z4/vZvJ8/vVRZOwubEyLl?=
 =?us-ascii?Q?EvR9X65JK/OW80LD7djR00IUXhLSHxCzB2CNxkWLMdPhJAC7RAbTHzfZchff?=
 =?us-ascii?Q?A0yuK9b0uLWe+ouXM5xJ9HyB6eyqMtHn5kryWVvAP0CEH815cGE8C8hEfjLv?=
 =?us-ascii?Q?rGZJuPQ0hZTeEm7NbRYpkhSFLE7fR1HXvoCE7xGIOl5HUE9NG+WrmA3AK3Oa?=
 =?us-ascii?Q?3QWcfAtmdDbAOaA0I83bvb8HeaEMiXjwl+X1cBqBINQcv+MijRD+n5QBjc3b?=
 =?us-ascii?Q?aQsdt6Fc9o3VZfYl61MQekP9jQAQcsHKbU7BuNqNZ1EWhaIgDfsj1FwEzJ9/?=
 =?us-ascii?Q?e8NfrNMMErI3cqSnbSpvxpdDL/AVyo7LvS+NsOerPwIpf4QQn+qFFacAfXD0?=
 =?us-ascii?Q?2H3gcaz10c1qgraGlYz9wUh/uYYsGxIOWNWxthFHKzpZxO1NKcfqL1N4Klp5?=
 =?us-ascii?Q?wU2U1UFCSUYykWlb77ptrItMkkRcSe83VkhfcdZhB/+k0X5GaD8lPx5Z8iX9?=
 =?us-ascii?Q?+OeYJeD32JM+iVqqKDxeD/gEoZFXwFIox0xwhnZ2z8jEMiT71IRovwrOU9Q/?=
 =?us-ascii?Q?xznpku49KQO4dyWb1sR7sYwoBXP/hmACTaT2ZG6gpF568tRtfnB/WNbWMcSb?=
 =?us-ascii?Q?YtWGpXz+Pwepbn7MoZOUAgqWw5WzmRmdOg3dTibOKHrTKT47V+jM75qAAgVq?=
 =?us-ascii?Q?XpStBW3sRtALvx4I80iWYloFSOvitvBZFfp8j/+vGpnS/JgAj2ez2O8Cp5cf?=
 =?us-ascii?Q?xu3hL623i9MQnkIFIvEgfB91upQkCVrtTbZji5cq/X0WfRdknnF3c3CsPgD+?=
 =?us-ascii?Q?iBBXugcibjQSW0Pa85ICZB8IVEwNgcCHi9CtsTUGTUgKLSQuMO+BtqJ7rLJh?=
 =?us-ascii?Q?DXG+KFEmXim+A8OHi6R8MiFpk9bV3RjJOGYwH5NgpAfeLchFe6j57azF+LkR?=
 =?us-ascii?Q?Qko1xq+H8qFhbQEtNlNXPKej6gz4OzEG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:22.0031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a438db66-90a7-450c-ded5-08dcc22d3657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
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

From: Ahmed Muhammad <Ahmed.Ahmed@amd.com>

[why]
post_divider_value should not be 0

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ahmed Muhammad <Ahmed.Ahmed@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 7f91e48902e2..60a84de4c5d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1082,7 +1082,8 @@ static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 	uint32_t dispclk_rdivider_value = 0;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_RDIVIDER, &dispclk_rdivider_value);
-	REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
+	if (dispclk_rdivider_value != 0)
+		REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
 }
 
 static void dcn35_set_dppclk_enable(struct dccg *dccg,
-- 
2.34.1

