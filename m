Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B01E77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 21:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7580E10E27C;
	Thu, 12 Dec 2024 21:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4fRnEV2L";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329BB10E214
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 21:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/gcmhHEEqJma2wKEWfQX+XwtKOAM9oW2RGOyzzBNz8s9J0lfQz80Lb6OIC2E/OGH+p3DisrW3RuTGkx9v8I763bDI93vSNlTTL6KWUQT0TVc3em0ZhI4psbj3rB8ALPB0DWKmGcrfuxd0bytEzV7i76Fcu8N+fJSwsxgwChThHy/8a1+CS4LkRdw28/LI6W9iPvPBiwLrIpHYegRlM2oq3uPonSfdyp9BiQQjuAX75XjhS7w4ypYg6cCkihM1RCD2bHu8k+ODceAP40ba9rIUMRBS2Ow3XcLvfaU0LHqu2g0QxNwTvmI6AQ59TWQZ5xK6iTDLcmtrCXOEIm5npUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy+5EPf3SUrKe7ZU311Oo8yXJe5Ry8iNJqn80pLdSOQ=;
 b=fvZ7bCluXuZk4Mm0meDhkY8/tii23EhGvPxRcqlBGV73rdKrIlt5hSNO57L6ofJTxev5Bwpim9Fchyfqjw19ljiEWFaVtem4/wXxQCym9dgZrEVylfJSaG3UFW+sbiccDRjuum5QOQFh/VSViPxXfqnraDKgBQN2P/dgUTe5y1LYVvsnvQ0VhSV4McRyGNxiGu2t+Q3/tAjRy3MfCsblkC6GqA5G58WiFQbLCQ5lOoXWaFdlCNEffp6bFnjlyekR/yg0P+6IUJvNz/RmbrFLrnW5lJpjT7yJCgtK0nUsYo2kv7mC7VLP1hJQyqNeA8oTfVyGIrj35m6jm963aTnckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy+5EPf3SUrKe7ZU311Oo8yXJe5Ry8iNJqn80pLdSOQ=;
 b=4fRnEV2LzMC77/gS0RrqyWKNnO/qbi38F8xU/jNHTXKZS0RsFqIULfxge9dwL5Wt6CaLOlitBXpc0kvR0ITH4qdR25eu6tE6EqBLlxWpnZvAnDTF3Z6EoOwy214syCGGFQjaWB4yqaqTMlRm6IPL0QRQgQfFbO25t3cvexKA8Go=
Received: from MN0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:52c::21)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 21:54:10 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::87) by MN0PR05CA0017.outlook.office365.com
 (2603:10b6:208:52c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Thu,
 12 Dec 2024 21:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:54:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 15:54:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/nbio7.7: fix IP version check
Date: Thu, 12 Dec 2024 16:53:51 -0500
Message-ID: <20241212215352.770069-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 231101ad-4078-473b-30ae-08dd1af78243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n0Ne5aLX8vq2TU78BUCAnyGTQoBuEghUT8F9FHo9CzLrOPLGICLzzcILXeOr?=
 =?us-ascii?Q?T20f+ou2TtyV/obsESWWVDyHYj9/fvR4B2G/0Pd6wT1gTyZkmIFEvnNRx27c?=
 =?us-ascii?Q?24MOK0u6iP0TDVa2I25lls+S3W2eoYrn2RDa3S0qsAFxVXiddeqopQeddhhR?=
 =?us-ascii?Q?ZQPx8Hvnsi3uVxfPfc8dj7PdfcKaZwZXV+BN5PRNh/jueZ8cAkdFKyM3ztWT?=
 =?us-ascii?Q?zdCaw5HBvNwZC+GzCqX+G/zdnXwR7W5HSsocXhGbo/YHAdYX+g+pPn8OSJuK?=
 =?us-ascii?Q?ryQEk6Hn6SQL1OROI/eR6YiysH5bUov2KJ85Q6aA0+AwCKarbaV4SrUBNaOG?=
 =?us-ascii?Q?ZDkte6r2TFH1AF6aToJ1yJ2ZVMT/eq18BNeDUjuJrkuQMtRjwUYgn69dPnfd?=
 =?us-ascii?Q?hcnFc6HNalIilK4EyAYkPGzfit5z7mWHgTDLj5+E8pE+30TPPagTk8hZZu3a?=
 =?us-ascii?Q?neALWaLMd4JVjo/ltQ3ekY66fXcVI3TTwTMrz29nI+rNRbQ0td5HSOxld88e?=
 =?us-ascii?Q?R/JVq2qXpn+X8WZYoYM6M72WOYdcleE+dFW7qgsJxlrrxP+dtI3Xvckbadbb?=
 =?us-ascii?Q?FTPw53d593Ry3fxh4pCoJe/COdmkw2NHvbwXGvBfmzXj32WqPVzH2tLissnL?=
 =?us-ascii?Q?adxOQLZ2SOeBWik6J4cHQKk+GRpG6s0J9HJmYgmgav5AQkEBktilMmg3SO6x?=
 =?us-ascii?Q?2oO/zvl2fgKzTCZbUCtJEoYZKkMxszFgkA4wA972XXPj2CgRciIXOErJ243Q?=
 =?us-ascii?Q?wNowZ5HlozRMxkZBd+vhaeGcHKeFmwPrppwioi8HhmsYm572VMaXiVR0rooU?=
 =?us-ascii?Q?Q5zYZeSV8c/9eldcUC8hMFxl1G9DJ2LnBXjGi7MsJUGUPTrqDUuRJ5R5E3Jr?=
 =?us-ascii?Q?rgmDRBjTp/9U9DkQmyk123unX8HgYftBXTPpiO0s1Ek5YhG00v+faATIbO0z?=
 =?us-ascii?Q?bAeX5IhDcsau5a3kGplAhv49wXTP3tqmzOg3XAeRMrVeiIlv442KjMQzF+dB?=
 =?us-ascii?Q?06DiD82SS4zNIGjEOd9Dqffs5HgRC6VAO/BffQoPZJQUsbmAb0sBcdm7FQFP?=
 =?us-ascii?Q?INp1LeY/INfS1c8Zsdm+f7YkumurVkt9WcoEIYg85F7KwnC0Yml/MMPDXVMM?=
 =?us-ascii?Q?vUgRW+cYoumCcJGDddqvBxRMEcEQ4CgENelH5deAowsrIJoCKJ7Sq6XWtwaX?=
 =?us-ascii?Q?bqlbW2avNRQjjrT7jY2UyE6FI7KDOm53FMl8aTGeDkrHPRfa5kq9EzAj9Eww?=
 =?us-ascii?Q?NDfRgh5d800cJj9QWwpfiuKDrGXlYbgPGndZVcZHd1ZfoNVz5pxe8EkiQrVO?=
 =?us-ascii?Q?8DJDvDuq3CxurjLiZ1y6i+QaNGMn79YJXAY1xhOvcH4CW+Gw2/hsDtAgkP9q?=
 =?us-ascii?Q?0Hnh8PLFi7k8nh+9nB55Hvx5XTIj2DzsTRwS+mzyLD9n9D92pLGTjjQErwIl?=
 =?us-ascii?Q?/BULwHoCAh1HgzB4tmdFYPgb57aIfpIx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:54:10.0539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 231101ad-4078-473b-30ae-08dd1af78243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index 1ac730328516f..3fb6d2aa7e3b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -247,7 +247,7 @@ static void nbio_v7_7_init_registers(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
 
-	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(7, 7, 0):
 		data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4) & ~BIT(23);
 		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4, data);
-- 
2.47.1

