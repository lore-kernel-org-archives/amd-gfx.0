Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3737C0218C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87AED10E62F;
	Tue, 21 Jan 2025 19:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SPqM3VhQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE9910E629
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRr9hjWRWEcNSCI5or0ZM8FlNtetH3LR2Py0+CkKqjE05Teqgn3zYM7w8kIrnWa/8aaD6EI55StINu6QhM7oqHNvwscEDINK2T21hcJkSwuOz011v+gGY7Q9oCyzgzJICQsgbVU172vuO1QfDAZCcVSBUd40pl1UrTHByL8O22PVqyKx+mfKIzAqAmzBWVdQUuVxr2TDy3XtX5a58Uea6ADzt2V5YuOAL6Hi5RzVqfzL9i6onBY9ZNd//cBrELUj+46CZFtnxnVOR9xWvHwVc9EWs/6dTG5Sq932V5dJhOCrX9j+r+QzkKHN63A5+PlI1ORDA6nHnPGj5/y526ExPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1h6bGhfP9DmSk26lowl4XQoFoTa6t35qZBQ3g79g/c=;
 b=P/FQQrxKQb0ExWzdJUM37dHmS0sh4AOeE2mU1nfu+G8/CvcMUdPc44CkhDKtOQNYH0mUyv4gEcMzwuWEoLEQd9J2EuN8645L32bxUybq9SWSujhPTJQEXlBkx+mS/p4VKYF/OcvVoCUg4EaaX3cqgN4jmlEgcyM+ig9N06uCw9i4xvsGl6FkdLplSbV7C5FxsDBiXlLEIlqh7ogJdooeByxWIaFWDtVhNPXEL6KTT7T75+bvzfq2Wqj++FoaUnSa0t09N55SU9dk/6egtLD6NmPphYejocHnrS8TEH/atDMODhFZmOMIPVz1ApktWTPqJIRd3PrFrGRIUUUkbdoW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1h6bGhfP9DmSk26lowl4XQoFoTa6t35qZBQ3g79g/c=;
 b=SPqM3VhQQjOA2Ym1gW/eQ2ChZkfV5ani6oTjWfG+yxDUtUwH02Zu3de7keAe2LuI61kve4YABfKnKsod0JDiBIuhYe9rfU+wwz7+DedCt4jbMOR03JG7B1XoikQmGUR3Qb08gtPrTxgwZ6ETo2691hrBNsbXPy4EWON7MkM/hF8=
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 19:40:05 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::8) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 19:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:05 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:02 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 06/14] drm/amd/display: Disable PSR-SU on some OLED panel
Date: Tue, 21 Jan 2025 14:39:11 -0500
Message-ID: <20250121193919.3342348-7-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: c944c3be-a863-4eb3-b507-08dd3a5367c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80XoL20BAlztYNhQfbNSiSp7MQ8GRVPO3agj7N3l2JezZKMwJ1M9P1fcrMC0?=
 =?us-ascii?Q?5wWLVWOpm+MUi5yULGO4IGUepuj2kPdx4XAVFiE5wcOeqFN/t7l1MI3EQ1dV?=
 =?us-ascii?Q?yHK/+TiweIMfLdTKq76hMb7trlwy9aXAiWn0i6jl47cP1EsMnpB57HQkdorJ?=
 =?us-ascii?Q?A7pjOrMYWybmEVN04EqpDulEP/dddJ+HIGEzLkn55T4UwS/LYwXOkwUC9DOW?=
 =?us-ascii?Q?xtGDjnBklHDnNJ7w+SSfdwRNfld/QWxQkZdI/5waq40o1pAA4M2i6w1oaSE9?=
 =?us-ascii?Q?L56FwL0KH8IeUpI9+MgyVpmTOUrXSbXF+ywl5Te2ebV7BK1dRHrXC2hftWJm?=
 =?us-ascii?Q?5f69ovCzMzHIIRz1qdDAvwUaCucpv74oXCgATlCRFuYnNzyRVainGsOq5G6d?=
 =?us-ascii?Q?JqUGD6GmmQDksPTcwhVqbwyRAYSnjlhLj6B2REf9PI0dziOoYZgEpJYBO4w+?=
 =?us-ascii?Q?q0JEVxeaKfyhvZSg+CQrKgqr2E55a9HBWD/sbBD7UbsOKR4sx/j7LotTZNdC?=
 =?us-ascii?Q?57znSzqULamL7pQ9p+CZI+Ne2GrQzTCjStDR9ZVQu8h0mD8bHLr7bgB/zLwx?=
 =?us-ascii?Q?zsGTAe1ZG8T2rbpDf/F57X2q/Ia0RzJc4QwVET8C2bpLB3oyXJNXnDABoEnc?=
 =?us-ascii?Q?1QuEw2u1Y2+dub+R9CAYWyyGqC2tBuIuj+Oasqi3LAYSF9Ykdq4Nhr54lg6X?=
 =?us-ascii?Q?J2GqH1gHHmwj+xgDH8ArndJ7IHQGSIDeJvLDJt9GCEa6rgGfPMjrD4zEFiYW?=
 =?us-ascii?Q?kiCZIK4dqCJPGVOdbP1FXqjK7B9ynpoJAN6hz2KKaBqJ48hY4pm6lGf//+cE?=
 =?us-ascii?Q?n9EttchApA1u/0HJFspJNB2mwZXfY/O3JOjpX6pnQ2XPSAqxfULYpRpfIo/5?=
 =?us-ascii?Q?5HD3XP4txc4zJ7AJZiFFa2gR7Xe5AlLvbbpHHmq0800Uyetw4y3v0dZaMbdR?=
 =?us-ascii?Q?LWVf2cGhk0NAcMHJYphHxeEQYmXivUDn556Garhjjc5bqPTKk/ocGFAkMDb4?=
 =?us-ascii?Q?uMSDbD6MOA4P+f1nxheKFvFtn2kOLke4QYiq+PssHiVfLH4qxF7pXPxZSbFs?=
 =?us-ascii?Q?veqMFgI4LP42BDt81Hrseo3p0aL5015V+1FVxsGH55RDj/wE1n9Ip4HdBBxD?=
 =?us-ascii?Q?02h3od/wtRsAcSXIipU8Qn2iTvgNWGwz9U5XyV0fD0OdLg35f/m112PRiXcr?=
 =?us-ascii?Q?+9IVCgYPh/fWTFok0F11ulTcLDLXw1+mg/Q5hVQjWfofM8yv+GCzVTJiJ6wU?=
 =?us-ascii?Q?ub/xv/t0K0syPyfYBuWb6HV1LlMSulPGsaQLQVCDzTIdPB35kkkMqxdG5oO5?=
 =?us-ascii?Q?ASQLUHc2CSS4AkXCjS/00hOolMhaChJhs0aIriACrxV8HuayeLFje8acLqT2?=
 =?us-ascii?Q?q3EQzJl87+LV6gt4qs1czGr8wVn2wfJ8waqgpxQENjGtLnKzVpIZO2cTS89E?=
 =?us-ascii?Q?HbBFBtw83xTVnc/AoLDsAo5zggJHSn3zOlXjh2cjl4xx29DNEZkC8xUkQzIH?=
 =?us-ascii?Q?C78jtfPd7K5N6g8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:05.3403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c944c3be-a863-4eb3-b507-08dd3a5367c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
PSR-SU may cause some glitching randomly on some OLED panel.

[How]
Disable the PSR-SU for certain PSR-SU OLED panel.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 45858bf1523d..104f03868266 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -30,6 +30,23 @@
 #include "amdgpu_dm.h"
 #include "modules/power/power_helpers.h"
 
+static bool is_specific_oled_panel(struct dc_link *link)
+{
+	if (!link->dpcd_sink_ext_caps.bits.oled)
+		return false;
+
+	/* Disable PSR-SU for some OLED panels to avoid glitches */
+	if (link->dpcd_caps.sink_dev_id == 0xBA4159) {
+		uint8_t sink_dev_id_str1[] = {'4', '0', 'C', 'U', '1'};
+
+		if (!memcmp(link->dpcd_caps.sink_dev_id_str, sink_dev_id_str1,
+		    sizeof(sink_dev_id_str1)))
+			return true;
+	}
+
+	return false;
+}
+
 static bool link_supports_psrsu(struct dc_link *link)
 {
 	struct dc *dc = link->ctx->dc;
@@ -40,6 +57,9 @@ static bool link_supports_psrsu(struct dc_link *link)
 	if (dc->ctx->dce_version < DCN_VERSION_3_1)
 		return false;
 
+	if (is_specific_oled_panel(link))
+		return false;
+
 	if (!is_psr_su_specific_panel(link))
 		return false;
 
-- 
2.34.1

