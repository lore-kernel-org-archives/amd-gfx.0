Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F16C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7145B10E57E;
	Tue, 25 Feb 2025 06:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Jrc+mqt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69C110E57E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk2AGC2JOGK+Qlzr/uTGNPyj6Tb5UgASPhPqXRuZAIgmDDo/Kq5p4RE0fw29uTxe8XK7qU70GcbTedCMe5F4Pu1BLfwr2M/MW4PKzsCaa++BKYgXDjsH0NFBhwPLDcKMXaz9tGPB1pEL3QVsk8yPxJDXxuZH9dfAWNP0basXbt2tPsKcfaT3zW8nYTM3cSSUmiaGhkgzegQpcg0VChWmzjSx2djF2Nt+aiz0PeAyFj5YS0tJMiprRNtPvpr2Ig+PTM6fKt2Uc0G5MQggxMBDL0TFiyyXRYmegcnBRuMVrpEk+5xIYhzFzLH/wT4vEzkpHQHB8+twGNjSHvll+LhKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iixajblMv4EPOLl2fTR5kYguZ0t6OyUNeen41MbTo6I=;
 b=ajGIxypk2lAlGEBS7jNSN7HLN1jtnC+c6XAanPSopJyNJ6WNsR5IkxuKN9IN6l9a9KB2h4NYDqS5P4pckH3xH79P/Mq27g4gzUctvoMxyGA2WqgPVWxvHbMyG1xsJD8HhTnHjXtPeapEDMNb1q5C1KL9Dy4ulaxbQhpWTeG45tpw7HsmoJuYPEe8AzoOUhxZ+3kBwD8S/0vPGr7/5gsRJs6RslmCbxXoycodY93uWUqudlo9EsOYVDNVlVqTJ9OJNFjUgm5v/Ufr4gEsU/bt4jd/n2BkRRYu7Z33BqyVWf7xso7wZhUeF/94JqWe9fcKHgJLrLIv0tgzH6udeoW4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iixajblMv4EPOLl2fTR5kYguZ0t6OyUNeen41MbTo6I=;
 b=2Jrc+mqtxoE33jWT2C7yqCatDmJ4lNFb+BLRzOGQPdtqEHxchd+eeDFoYutSntF5dK37iM7uh9n2qx1GlBR/EKLv4lUUEXQNSEzYS9BqjRPof4p4X6Zj69aS8pDEFokw49LgV2V0MVJtjgmi1ok5CMiNWh/fUWEJL4CTDFnQKLQ=
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:38:47 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::8e) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 06:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:46 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:38:41 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 27/27] drm/amd/display: Promote DAL to 3.2.323
Date: Tue, 25 Feb 2025 14:36:10 +0800
Message-ID: <20250225063610.631461-28-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f506ee-3286-47c7-6766-08dd55670eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZZRmOWw/xRepTDTnC+s+CTFBl+qk71fw9KQSjXo3RJY860Pcp2DmBQlJ0Ofa?=
 =?us-ascii?Q?pDEb4iVYFXHXa5W5nEFSF8pPPJ5G3y1n+J8ra2KNafw2HrpmWCZE0mW9R3X5?=
 =?us-ascii?Q?JIISxGpSb/31N4STEsQLO45UEN0Ex2vdNQDjN3cPYM6lr9kcXdZ6TEtKvvf2?=
 =?us-ascii?Q?w1Set85+ZqlAhssnU5rGRmPrfJQYkhwAxKCbuuG6PzILZdmpGuqeWoWf+l0X?=
 =?us-ascii?Q?751OnxaNDBJsjY6SY24H9I0eIC72Yp/JceoI2eCixnVV8PAXkipmR7wjzar+?=
 =?us-ascii?Q?uL5BBnzukE+4hpqXQVhr8BvOCF077qG4ObULnSdHOpfcH0HFbG7CGXTVjMMV?=
 =?us-ascii?Q?zTi0iJuvsoLaRUu3/k/TR1L2868hUUznP/vpAHWvfcNt6HO4xCN4DnMSI0fS?=
 =?us-ascii?Q?b/ZMcAWvNaPxYKW+46l99e78mLnOyHg3UkBQYoWwUB6nen4MF/H+4m5DNh/j?=
 =?us-ascii?Q?7ZLb2UtDrAH3Bx2jZMSR/3UlhAXAqnYLbs31B8KtFHFGFB6TtjQ8vwPN9snk?=
 =?us-ascii?Q?c1kJ1bcv7n+0eEqIyKhq+EOI170SEDIeIDE3LIsXeXxcbpEZO0t6yTRygQ+H?=
 =?us-ascii?Q?84kNO2qqd/OVMMUX4wQRlpmwRGEehxIAnkF42c573IYpolg+WtqH76jcfpz2?=
 =?us-ascii?Q?kSoPV2eSMJeF+uE6ZbCsMECTxaIFwT0F31Xj8BWdnhffmL7FEF1QW8bZv9Mw?=
 =?us-ascii?Q?YmKwN9KVxsdV8lONJEwzlJJVsymd43i+tWxiNVgM53tGpRGJMcOLmP9pbY6j?=
 =?us-ascii?Q?xw+PcnnhDpZgD+AOjv1/D4bn+Zu/FQ1vWx7KIwCrw2ZZtFGZlfJ+fCbMpSL4?=
 =?us-ascii?Q?0aRYyQFi6kKfHrpWUdVeatBcsZ9ZAPacjrsfxlNb/UPtcp7zC3zd8L2Qicu7?=
 =?us-ascii?Q?2G40nPu2v+7k2eacX1VL+/kH9OdR2Nv1QsGuKtUIimUut27+Qyu7rtcTlTTK?=
 =?us-ascii?Q?P0HkeBRskF+rHaggZfOzCZXYfNCRYVLyDNGuI3OeDc/+OXERIjXZnf0bx5Je?=
 =?us-ascii?Q?A9Om3wxy+0uUr3NI0MoJQeI0Q2qHDB1uvrPFH+3J+i2sLP+XVYVAZZqrmCPD?=
 =?us-ascii?Q?Q0sNf2CLn9M72bryvtT2SXoOToznHDwTiBfcnCEgXgo36z/4OHp0O1S/b8I4?=
 =?us-ascii?Q?s6fKpj76SXPSzolsVFpFvxhGvrEtTH4I/g0pSDuc9w8TVILaNfWvU219hC7V?=
 =?us-ascii?Q?KTRw1S7CDMD1h6HyYi3qE2T11QULxuyuCTCFVrUOxRerJ5mSo94laeGPxoyA?=
 =?us-ascii?Q?hCMK75DdObo+S1bFokurssP1htrAwI0K1dVFaYd3doiFVscE3gCLnlPJDCRB?=
 =?us-ascii?Q?lEFJL5m8pHzvSbv7RCRKt0UjbqxzR8XSsWtq+lSyfIVfDdoM/VQrEpOi+rNk?=
 =?us-ascii?Q?D+4po7XVeyss7I0JeIZSCHUpI58rQNda2iBgLFjcWMVzoBymZ+mc3sejI/sC?=
 =?us-ascii?Q?cxL9zdTp9Yy4Aoow2kLRBe6FF4FvHLkt8A0yxiQHLHO8uK5z1Dji3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:47.1193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f506ee-3286-47c7-6766-08dd55670eb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
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

This version brings along following fixes:
- Various cleanups to amdgpu dm
- Add DP tunneling IRQ handler
- Fix display corruption for dcn35
- Fix dmcub reset problem
- Adjust BW determination for PCON
- DIO encoder refactor
- Fix performance with SubVP under gaming

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 02bf6fe51a0d..a62c4893e5ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.322"
+#define DC_VER "3.2.323"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.37.3

