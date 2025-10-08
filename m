Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59A0CCD184
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6325610E894;
	Wed,  8 Oct 2025 18:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eLILuuWI";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81FC810E8C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFMrChXXqe+s54COhvTr2pkJpla1UZ6Ll1civRvPTumWhgjb8Me/iZCcETk88DEtOYJs3Gf2xIzJMaHURi+/uj2bCgKgvInCB3SgDvktciAvghbqPzDsB4YWxds7bcYNuIJMUEtkMD/Cg8Se9gvjgHBBA8m1WQeG6sJ8bIEhxB7hW+bhWRezyljIjB/W4V4DgbUSnPlBqfNWf9r1P5x0klvomO9WHFB2tAfjDpnXvSu/xYFSkitBJJtmZDrIiYoly9AQiZ/1rAJKFH7uXR/jWjitAgOX2Y7NS0wQZAjEgdL62FK7PTLCfdXrNdnKgqbMO546YS5+Xw4J2R1/OWLj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5BCtq4DQWV+QBq5di/3j0q02io7SmPhsOlI1A8l3Rw=;
 b=XMK9hCeaClj5jQorjUQ0w7jhs9wT80TA9sllusREkJjYg/riC82ytEZNMKhECMsWYq0raGwDYKp/vbvj1CW57c/mMUaxHmLcTrqRYwk1fWh4YajXVWoKjZNRiYj8JrYq81XorRrBr9DjfRAtpfTvMmTeupLh+JdIaNPOeq6ufZRnCvJpKCWQ9uRpi79nLpesOL/4VSmTUkr61ZsMNGnLuvbdqhk8m0A4raZkW9j4KegDyedLIA2rhn87xRRcd/53FiDz8TG5AVQK14MAHK9X9kz/t9J6fmo7+ieSd1cfpy4tuMA5GF1ZkXFPoeK/VJAI6nsGEFWeKIDc77RaeAduOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5BCtq4DQWV+QBq5di/3j0q02io7SmPhsOlI1A8l3Rw=;
 b=eLILuuWImmLijtOJX/RdB58mLfpLtX7ycDJYdnr0CPsquD45JrLd7FFHCzci35ZRvD/BIppE77Di659pUnsm7rK3mvah1cs4XSbtbTBxp0746iqHuaefBETo8aSu/B2j5VqXgMQDyegf5KeJ/gn4Qrr0jYKMCu3wEPTr5DVFfD0=
Received: from BY5PR17CA0015.namprd17.prod.outlook.com (2603:10b6:a03:1b8::28)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:49:09 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::ec) by BY5PR17CA0015.outlook.office365.com
 (2603:10b6:a03:1b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 18:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:48 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:48 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:48 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Cruise Hung
 <cruise.hung@amd.com>
Subject: [PATCH 12/22] drm/amd/display: not skip hpd irq for bw alloc mode
Date: Wed, 8 Oct 2025 14:47:06 -0400
Message-ID: <20251008184839.78916-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ab549c-3da0-4006-3bc4-08de069b5da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7wCGdEwfqO3rpKTZ+ryS48OJ5OkYw6/vAkdUxLM1umCng4du0f8NZToX1198?=
 =?us-ascii?Q?paoMFbdYGls1HJTxPS8SbCx9lmJso/OD1dgg8u/SpOA+FnLVsYsUIdBWV7Ge?=
 =?us-ascii?Q?O/wIHdpOGIRrQOamynZOWEQugRs9jhc6tVdwwtOScZSAJD2WxfeGmA9+zzXK?=
 =?us-ascii?Q?HFwRjtVnRnp6tGKU720HasxuOnCIvZpOrj/iqEevzDmES1LC4SV7rGvhdW1g?=
 =?us-ascii?Q?UoAjkzXeupNbpKp9XuPBAJX21UK/GDYg3VqbeSgcHaAdEtQnFQdZ3OICecKG?=
 =?us-ascii?Q?m3S1+ISbPM3KWOUJ4kEEdEZ69uvVsUYOUOMjTAVbUkV1cncsnZlpB6PBs4Vo?=
 =?us-ascii?Q?jeoQ2DD/HKZmg/WRwH1CFjFt8dghdMjFQhutn60HoOEv6bVU8XgUNOP7Ghui?=
 =?us-ascii?Q?JrpOJBccYXJcLmG35UrGuHsxvmtj1lIOgw3RWrR+x7T816iKRc4N3nYVJx33?=
 =?us-ascii?Q?6vir4xgC/VksxVW2xoPq5KrEswDw2a+t58xIicn8T/FWb2btgJ7RDvrghYik?=
 =?us-ascii?Q?xfinqdPUNzv7F7UIBOabLZqHLnqg8hMSIWKeIwXzy6+tVBqvF/fX2e8LzRdq?=
 =?us-ascii?Q?6b9+CqGGuFePy2w221LSB9N4NWGYOy7mHG9PRFh7D4hMOPcX1BXYnfitmTrB?=
 =?us-ascii?Q?4GXMsdpvr1W6jgy6GC1ieXOZVY5wBy0x3vSYwiLPSM0xpt1j1zrc41cuIEFS?=
 =?us-ascii?Q?8asGLTlA+FuCJLojYnyWaHZ8zf54vwVXk4YPqjmEngkKJnqfEZ7AQPt7/lje?=
 =?us-ascii?Q?/VHp0Z8pB3dvOIycleMXLon5FD2jNGarzJ5LwYwoA/7+BH92Dt1gFgGYGGbg?=
 =?us-ascii?Q?JFSgYWa0c1EzpJIyME6XTw0PjFqhK8rFaBdaDXR+8MEUVmZjKaPoVwNrbw6M?=
 =?us-ascii?Q?xFgMKvDTE6mfqO6HoMzc1xfDcRHubrXbqFhCMIyOinXE6avKZbsu4m7FVUi6?=
 =?us-ascii?Q?UKcUr++IgJ3hpJLjcJa8Fw9V0KuO+qg7sM3NoZzn4R+LsyoAqVmuZFVkPEyZ?=
 =?us-ascii?Q?QPnQXhjLhxLYq6jW0/WswFsXYbRhbEzN8P03PniiRuXVUGp11KR6q8bcdOit?=
 =?us-ascii?Q?/DAsWw4YWT3WsYGfZjC39ME+Id15u+ogBRIeNDBFoY95JWLuJBT3ZjOOgQlU?=
 =?us-ascii?Q?0xExduaPYSa+REttp8QgO4+m3dsLW8QaDwsZoNfa4GcGpEYzREjSPUpAIRMs?=
 =?us-ascii?Q?uisgF/Q9jOKxV2ZAF6G2MWRUbLlVTgyAlhBvBevKfc3c7e/A9plCwhb4jdq8?=
 =?us-ascii?Q?w9Em5lng03cZwZH9nPOHB7KXOnFZRE4nqGVaJRn7mgSn/1mSQb05o5Ju4cc2?=
 =?us-ascii?Q?AzQUyxdxakTKv5zwJqUz8TzytTqd7XhlyL/soAY/ceRdRO/s/BY/dMtEI0nS?=
 =?us-ascii?Q?YZTpKelHrV9q1yFbjFrX9oN/0XGuVZ5rHn2obV3/e4F3mAVAeZUtnczvQVpR?=
 =?us-ascii?Q?ZmYuIafPdTPHL9KXZFPxGg56R3zOcbWFkGGkKGLetvT0jgmtHwkaOTtAvMOI?=
 =?us-ascii?Q?dqur2VKxGZviR1va/VUdIYdSoX87i2wScOWh4oF4uZddTPOmo1J6xLporymo?=
 =?us-ascii?Q?VO3c4KRhH27zgAI90S4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:09.2475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ab549c-3da0-4006-3bc4-08de069b5da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
Driver only process hpd irq when a branch device or when
the link is established. It would cause some irq for bw_alloc
mode of dp tunneling are ignored.

[HOW]
Driver should process hpd irq if bw_alloc and dp tunneling
are enabled.

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../dc/link/protocols/link_dp_dpia_bw.c       | 19 +++++++++++++++----
 .../dc/link/protocols/link_dp_irq_handler.c   |  4 +++-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 8a3c18ae97a7..b16eb97ae11c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -273,17 +273,28 @@ bool link_dpia_enable_usb4_dp_bw_alloc_mode(struct dc_link *link)
  */
 void link_dp_dpia_handle_bw_alloc_status(struct dc_link *link, uint8_t status)
 {
-	link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
-
 	if (status & DP_TUNNELING_BW_REQUEST_SUCCEEDED) {
 		DC_LOG_DEBUG("%s: BW Allocation request succeeded on link(%d)",
 				__func__, link->link_index);
-	} else if (status & DP_TUNNELING_BW_REQUEST_FAILED) {
+	}
+
+	if (status & DP_TUNNELING_BW_REQUEST_FAILED) {
 		DC_LOG_DEBUG("%s: BW Allocation request failed on link(%d)  allocated/estimated BW=%d",
 				__func__, link->link_index, link->dpia_bw_alloc_config.estimated_bw);
 
 		link_dpia_send_bw_alloc_request(link, link->dpia_bw_alloc_config.estimated_bw);
-	} else if (status & DP_TUNNELING_ESTIMATED_BW_CHANGED) {
+	}
+
+	if (status & DP_TUNNELING_BW_ALLOC_CAP_CHANGED) {
+		link->dpia_bw_alloc_config.bw_granularity = get_bw_granularity(link);
+
+		DC_LOG_DEBUG("%s: Granularity changed on link(%d)  new granularity=%d",
+				__func__, link->link_index, link->dpia_bw_alloc_config.bw_granularity);
+	}
+
+	if (status & DP_TUNNELING_ESTIMATED_BW_CHANGED) {
+		link->dpia_bw_alloc_config.estimated_bw = get_estimated_bw(link);
+
 		DC_LOG_DEBUG("%s: Estimated BW changed on link(%d)  new estimated BW=%d",
 				__func__, link->link_index, link->dpia_bw_alloc_config.estimated_bw);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 693477413347..4b01ab0a5a7f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -398,10 +398,12 @@ bool dp_should_allow_hpd_rx_irq(const struct dc_link *link)
 	 * Don't handle RX IRQ unless one of following is met:
 	 * 1) The link is established (cur_link_settings != unknown)
 	 * 2) We know we're dealing with a branch device, SST or MST
+	 * 3) The link is bw_alloc enabled.
 	 */
 
 	if ((link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN) ||
-		is_dp_branch_device(link))
+		is_dp_branch_device(link) ||
+		link->dpia_bw_alloc_config.bw_alloc_enabled)
 		return true;
 
 	return false;
-- 
2.51.0

