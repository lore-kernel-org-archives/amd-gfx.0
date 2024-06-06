Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B4DC27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A1410EAE9;
	Thu,  6 Jun 2024 21:57:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N6ffqmND";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B031110EAE8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqboDfUEFu1SMCq9bxg+oslF4r2NXVo2C1DEB0sny5SL5lHwAwsgnd31xPeBOz7LKRGD1/f5Oex5ycszwfg9i4+LhsBpC4xxyN35X9rMqCzuchp7+AaIe3oMa5u1ZzK+8d6TD8i4bipOfnqaAXkOLhXv66JQd5GxY8Rn8WZcR6taLrMmtAjePmooBvxwuqPMgsYYkXw1RUvITU6sXQNaSpaLCXq49IwzgQJ0mPXl39IlMtQi2zSsUAHwEg1lSnkTImuzKE1RnbN6bflVHzDo4GzI+DBHgqS9gsjaOjkL5qtLpEbUJx74ClYU6O6v60p1cCJULcBwvLtrer9PF1bL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y43kUN8mrwWbY6Y5i4lMf1v08NjxJjhpfXqQHwZ5eYM=;
 b=HiTy8QiYiKlSD8RXiwwZZKC1Oo6cGeFeqLns0BzZpHKor2cy3HPM8Rq7V0cwYNrsFVjAE40qfoj7chxM8l2S7w4Y+KH0vPOYh8ZrHhsY5uThr4PpvPjy0906r5rS0xI0U/CgDgwG04fJTijTT9aEW/rKXasKM/pIX5EZQ+ByxjsyS7T7ozl6fMWqKItBy5DGZsYbfcu2WTbwfWkQ1tEfMyFITOvKCmKhYwX7nrKi2ot+lDgcc82kyBuEW4ozVoQW/gQsRRx8n+RdH2Wv82g1uYy6rdNI9ha/sWiXKwlHsrJixy+PyzGMhJ0TU6F5YxBTJ1zIPDJrw3EEtD6MyYv9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y43kUN8mrwWbY6Y5i4lMf1v08NjxJjhpfXqQHwZ5eYM=;
 b=N6ffqmNDS99y30Xq2w5EOGGJPn8ElV7uO0UTY513w4N9jVaPYWOl6p3AL6TzXksNniXEMg5zxWjAYI8BhicqOW2Wp8T2nC/xO6mQ6HsfOeW144+GJ6smEa3hjE5CyXks2BSiJsMK4vsrDdkUEOuszDvu5b52TchilnaFjqc/lLQ=
Received: from MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Thu, 6 Jun
 2024 21:57:46 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::1d) by MN2PR15CA0049.outlook.office365.com
 (2603:10b6:208:237::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:46 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:41 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 29/67] drm/amd/display: Disable boot optimization for DCN401
Date: Thu, 6 Jun 2024 17:55:54 -0400
Message-ID: <20240606215632.4061204-30-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 8965e9fa-7aa3-4f3d-a2d2-08dc8673b2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jQntraBuTeE9/aFwH3NGtlNogs1pRdajcyIDz3WnzXmWw7ni4rNjHteEsL5c?=
 =?us-ascii?Q?sKFKj3aEvKHbj+8+eUOtQiUcbe37IXqukC6qX8Aljr19omVUNW11qELDSZlp?=
 =?us-ascii?Q?MtD+bLV56xYy0Nit1/UHpHKwLlpIa9ByElyNf7tNu6nqbcunoX650t60TvLJ?=
 =?us-ascii?Q?vFb3ktkC/1MQzGGaQLDct1l85gbdcNUg2kdXzsfY3L0RRjRPR+Z88jpLo3GQ?=
 =?us-ascii?Q?hKqd6YWGMpaf+ZA/J+6I138IP20Yjvcwq/K61dv5oK9fvagE8w44a/fiDc6H?=
 =?us-ascii?Q?IgYQC2x8NdJIqej4oJbsUNp5jR9kYlQRXzsthy8K7oQxX/ZHHGNITEpOV4AZ?=
 =?us-ascii?Q?IwhBnlut/yOeJ4fn7mETln37fPM9Zy1d9TMyZhtBic84xmOyBAtgF5v3nfyi?=
 =?us-ascii?Q?lS0bsasdLGgQdEJwKlyerh3x3LY+FLjtajdDjrE8L/IT114RmoDo7xQAXU2H?=
 =?us-ascii?Q?2QxDEoKMvqgGJErl0QkZ0Oc2DXs+uvShKGR4hiF96t336LT2wmWHydwSOK7B?=
 =?us-ascii?Q?pUb4IaRja0s6gnGyaBQ6MX4zwQYm+aFa5C5ZcwgiBLZ42f8mrkWRgtaRoN0x?=
 =?us-ascii?Q?uD0RhV6QNtEtARlJrWRV5YH0WrdJZyYUmOZF6lqPUDRgh9KhyybX3F0oNsmO?=
 =?us-ascii?Q?q20Xfv2ksbdU8bKUSuRXBQo/hUHbRQOglLLQ4njd8jdtGmBIkICID8CbjYOl?=
 =?us-ascii?Q?oywd19hac6vWBpfzFKrmj/QObGb10pxpr+MNwVMsQf36V1fjbPDW2B211UUl?=
 =?us-ascii?Q?eVusQ9a3QfdMJIHoiPk+6HLVc6PSkEEDel29qVv15XKKMpxYKlKBigoqe4Oe?=
 =?us-ascii?Q?H/lBhKSU1v3ndZt0kAOlMqDSaZrsduj8A7EvdzazPmniNhGj/wWqbXWCwNEi?=
 =?us-ascii?Q?NLgPvV9F2+c29KBWgnbjcOkEYo51/RMVBj3tGdqrHAApVmqrXx8jmLfcfVon?=
 =?us-ascii?Q?/QfNEINxDnzS603Tcz5BfEsoPNsyGS2bzwJXVPHlCUk+tqxSTQGYoOboVnob?=
 =?us-ascii?Q?TPCTGYTuH6qKmS24I/AdhY1mzt6Y9n/jQu+HmlE17MLmLrWO6x5rNFcowGhh?=
 =?us-ascii?Q?+o59s+F9S4bw+eNTp4xb0llrXuPWj2HQ/YgfDedgWIsM5LXirDVqizT/g9rb?=
 =?us-ascii?Q?sBuBUXSE5aPncu2hMcy/36QmHL0JN1WqcBQXSD4PSAYso6aoDLe3rYvy788N?=
 =?us-ascii?Q?Wpxxx+TMV5w2m1asLWIehzZV1CiMzf1Ka3iF55swR2z5DoIp45lrH3eaoGBD?=
 =?us-ascii?Q?S00OoqNFeN8cvX6e5ECrvykOIc+zG1oIm4CdwMjnoAw+v7n/Fvvlh3i3ixX3?=
 =?us-ascii?Q?4NUb/QwgJ9AEA7lXLlUpy1Ksv7m7v9qgISxqnBZK4881dvV5+vepHadvqR8q?=
 =?us-ascii?Q?rynhUwf+1YAbruttMOsCBmYQlRdRrKFS6cXiYYKXEzLMQAHaFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:46.1470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8965e9fa-7aa3-4f3d-a2d2-08dc8673b2fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
DCN401 currently has an issue re-enabling when pipe splitting is enabled,
while the root cause is being investigated we can make sure everything is
being reset as a workaround, by disabling boot optimization.

[How]
 - use enable_accelerated_mode instead of init_pipes to fully reset asic

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c    | 9 ++++++++-
 .../drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0b00fdf1297a..776ec8963cab 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -304,7 +304,14 @@ void dcn401_init_hw(struct dc *dc)
 	 * everything down.
 	 */
 	if (dcb->funcs->is_accelerated_mode(dcb) || !dc->config.seamless_boot_edp_requested) {
-		hws->funcs.init_pipes(dc, dc->current_state);
+		/* Disable boot optimizations means power down everything including PHY, DIG,
+		 * and OTG (i.e. the boot is not optimized because we do a full power down).
+		 */
+		if (dc->hwss.enable_accelerated_mode && dc->debug.disable_boot_optimizations)
+			dc->hwss.enable_accelerated_mode(dc, dc->current_state);
+		else
+			hws->funcs.init_pipes(dc, dc->current_state);
+
 		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
 					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 7781a0342d67..ea803df8645e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -733,6 +733,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_cositing = CHROMA_COSITING_TOPLEFT + 1,
 	.disable_idle_power_optimizations = true,
 	.edp_oled_no_backlight_enable = true,
+	.disable_boot_optimizations = true,
 };
 
 static struct dce_aux *dcn401_aux_engine_create(
-- 
2.34.1

