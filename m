Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96E6C49EA1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C2010E8B2;
	Thu, 25 Jul 2024 18:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rECZUMSd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D4C10E8B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxExBKG4R5Kn05BJ3MVmCERRgrAOLnyYJcw1zY09z23mJbdmuOjUu5pPSLsz/QH3QwzAlU2Ev4nw5rwvOF5wNyOvIvqfEszvJQa22+218bwvDWrgGJO3FcWeT/RHodTrCOLHfheA60MwruA16ivFm1zdZR4JovfKwPgx1Ya4w4ID94NYylM3JcoMGYBBkSD3SsG8/56Qa8egYFqd2cOw0uo43LRPfOyUIe57h1pPmP51+4y+8BDeybRFkwjncwin/gxM+Vew3sPL7a6sUULPEh1TK5n59nxWdpg58uT85tUss2jqNb0xc7Q5UkxQMJRAz9dki0VSQ00bNnbK2UUunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VS5HFlXP3A65KaQc4G7WSCm9XjUpWgsRxXhKLmomuI=;
 b=WKkzUrTHgrmv443pcnJ+8B30qvo4M8MiV2jXh5QgDDOxAR535ZCuJrBzYT336bmvMRNPQJxA4ZvKS946rzemRVLVCUFTqp8uQxGT28Z9G4pARNGOQ9s/WisrohGlP9BIKVKcGvuwbQq9iaDF+uovGFVrPUQv6//pOigfqNOTKmqK/XN66e3cWwauY3/qCFR1YuYo53ErMpiFjFwpPx441zx0fiKtYRRDWBx4UcTBiFMPUZeZ7BOu37j5eooWyDzR/B6Nj56N7/iQtj+eqmfXm+3Qaqd8gc5qXzUA0ctt4qDcaL/njkooDHgPICGDU6ofk8wMT00lh9VpjSz1mZHhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VS5HFlXP3A65KaQc4G7WSCm9XjUpWgsRxXhKLmomuI=;
 b=rECZUMSdEJ5IEjKfp023cTLmKHdTkhGoS3Q1P/akaqD45MYCwkHu1ARlEkvAUx0AgFesnrxL+FFQe5hRryhRrW0Ws+B1qPLBYZf5ipwCKT9JOGlcyp5fjXU0T8LvVW9SgG3PiefLNGjfeM1dv8O0bBiISi0/CzNWJP8qqtzM3q4=
Received: from CH0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:610:119::12)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Thu, 25 Jul
 2024 18:04:24 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::4e) by CH0PR03CA0366.outlook.office365.com
 (2603:10b6:610:119::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:24 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Cruise <Cruise.Hung@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 27/39] drm/amd/display: Get link index for AUX reply
 notification
Date: Thu, 25 Jul 2024 12:01:11 -0600
Message-ID: <20240725180309.105968-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: f0919183-53e7-45f8-099a-08dcacd43770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QY5jNvOddTd3TEwVaXk/HthbaTk4AMCBWGXe6ff3UlQ08ee7xEnndTSxHKic?=
 =?us-ascii?Q?hLo5gj4ESS7Id/Y3HebjW/r1t++WCuIe+WdgQCYOAig1r21KyT3PPrNwQKYJ?=
 =?us-ascii?Q?DvdtL0h3KMaUq+662QTyZuMjPOmf0+p0iFkZflK+nicxQ9a6iQGq9lj/yRsx?=
 =?us-ascii?Q?vmuz5+uz0jSWz7Ujml52J5CVuy4eKaJwZchk566vVEfCmLWkelTpZvK818iD?=
 =?us-ascii?Q?GJC2rprxhRpuS8zpfHtmCumU7BQRO6BQ4uNHzkCYuDgHu9D9C/8JuVuWCC32?=
 =?us-ascii?Q?1kSY2FALkSdPhWRZ15pedclJhWbabFlWtoizrcIyqJ9iK7jYKA+AUDxrLbdy?=
 =?us-ascii?Q?LevIGM+udmJCTMQra7gcZw7tBMzcdJ0YurlBPzkLJbKR8xkQDDpsqlSewU4Z?=
 =?us-ascii?Q?wEfA0oRDx/69vLNEnU+bcuhotOQfo7QFnDo4feDZYEaPM6lM4sXKtXlGJl2K?=
 =?us-ascii?Q?yyYIffnVSgrvWhixOUIKX5CMWa6v/+8wrY6ZabGGenI372al4zDiFLS293yi?=
 =?us-ascii?Q?5U4utudIH1HSHj2vNwx9eIOVxv0jyPhcKnjoIgakh1Ahp0AvYqwgu1etieC4?=
 =?us-ascii?Q?gvl+BqQoopXGl9vYmItmVHI7oddaMi5JivmhgpT8FQggsHNC5X7KaRYPIbBt?=
 =?us-ascii?Q?H+12YtcjnA7aYTNN+lIFV+m7eqR8lnzMzeNznDASiBYwLPLwSk4I/qYqdGPB?=
 =?us-ascii?Q?8qxEuk0AUmcjrY0drs8VGZC6d6kvd26KRmihuem/y+yIcJXMsiLXJ6OURUd0?=
 =?us-ascii?Q?Qc1lMSK/MUfavRHPheUlBMB8sTWmtCELUF089bwo6Hv3rTLnmX83bpsoAulx?=
 =?us-ascii?Q?JrTxJ/sraVRF3Msf91dJHyRN4/6AWAryXDngMUFt90K0WO6/oIUZOLfCxqxv?=
 =?us-ascii?Q?ao4+Klt1S575oDLDMnbhe/rp4zvnDWwoFWN3xRwfeUZIzGGtDsxURSYjz+w/?=
 =?us-ascii?Q?TWaLNg8tUaOIGnHdhJxdvtuM3PWva+r703WdWnGHoboo3EBRhxfWIroY+Lky?=
 =?us-ascii?Q?GnkMn3kWrZ78hqix2okzYXCRRQ76zCMnxQ/XqmgAwitxcadHn3dP+zpbOkxQ?=
 =?us-ascii?Q?2wqwB01SA+0A5DyVr3l3Bg5ibsBqNrNdcUS4p+fQriEPYXwyybj1y7mp4n8G?=
 =?us-ascii?Q?jZgtcOzhS+Vp1RRLT6euTDRtNwveHAAXEuyGRG9vpPDNMQL7i6kNApQZ6MgZ?=
 =?us-ascii?Q?dh2ovzTqlQkCIagLmbf0FA9t8+CRuytihT7eCuCogPWMdJ7h8c6gQfYnDWk1?=
 =?us-ascii?Q?OvPs/wixfqipJ3cRiIYdsj7ylAafW5moqJaJN/BxnJJ2wsgo2YzTYfiGqWJc?=
 =?us-ascii?Q?HXoKgyCkgGuc++SSMCjUpLcf0qTtF6KlkJ0iNnBIhyivEsXWz5m+dLklul+c?=
 =?us-ascii?Q?gO5uSL5lg9LG7TaPMlURmj4JrTcn+U+a9Mhj834VT8HAFlBYxZFXnPQalGs+?=
 =?us-ascii?Q?z765KYNew4KU/gZmFNa7DnfUW/BAOQvj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:24.0713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0919183-53e7-45f8-099a-08dcacd43770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
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

From: Cruise <Cruise.Hung@amd.com>

The link index wasn't updated for the AUX reply notification. Get link
index based on DPIA instance for AUX reply notification.

Signed-off-by: Cruise <Cruise.Hung@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
index cd6570a1e20e..fe9f99f1bdf9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
@@ -61,6 +61,7 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
 	/* For HPD/HPD RX, convert dpia port index into link index */
 	if (notify->type == DMUB_NOTIFICATION_HPD ||
 	    notify->type == DMUB_NOTIFICATION_HPD_IRQ ||
+	    notify->type == DMUB_NOTIFICATION_AUX_REPLY ||
 	    notify->type == DMUB_NOTIFICATION_DPIA_NOTIFICATION ||
 	    notify->type == DMUB_NOTIFICATION_SET_CONFIG_REPLY) {
 		notify->link_index =
-- 
2.43.0

