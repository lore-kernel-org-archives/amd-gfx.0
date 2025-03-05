Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AE7C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246C810E6E1;
	Wed,  5 Mar 2025 05:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MsfGwnfA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2816310E6D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3Y8ttJe1XtUMjtkC1yBt8nS5SFxRJvFt3ZuwGW6ayT5+OAQYb3hKsx+TsipU48rwQVJeeM4MNiZsZbTpz70dmp24aufkoSlyDmYr7Ud8n3z+z7sdv/e7+qE6pL8nMzUgUNueomWNkic4Zwf8IguithswqJh4ZziOrXU6hbJoT5d2xk4WFT+B06OxvzwFU/LH+nqBMYoJu7h4+9ytQ67SPgQIQHkeem/4TrjjTEi54BpC3RjhOHwmr4jysdBMu0OlMlcR/nPRV0DtF6nUbQayfCvaGbVJ7cqOUyQqTcAuDQuvKKDpJVO6JgGxMa5uN7/UwLuwNgpE3PgFHXErgcg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MhbUa8mjeFHwJTEQFcQXfvMZmb4G/mTP+e/laMtXJo=;
 b=vY2p1EmvpvgXZ65nitSf2xn/jQtzvQTScaT6OBABI37WxlN+DbWoARjlTd0hWXRo3emgFcDDb9dx2bD1Hq5XdzYdv3SXI6PaIHxRbIW5SMpDqPJYYsN+2bMquWY3Zq2VCriyhB+dXKZLyujwH9RN/byLgp8NEDnBq64L1TUV4odEO/ZbrJJv87bMETL8R5pMCA5dlbeuY6GZKdVtdIDhi6GTZhK5a+ViVLHmYA46xWzI6vQ2F3OGfAToOR0L3+2XKv1q5+pqE7snqzq7XgyJZb6eQf2wmj0YDUFZQgq9Arp7ajp8uIVpwTM3mSDQHy0vitDrgF83f72TKWRZpkprQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MhbUa8mjeFHwJTEQFcQXfvMZmb4G/mTP+e/laMtXJo=;
 b=MsfGwnfAIp8sRbhRrEgXBqftF+RWL4y1NxqABJUGZx3s38CJMqpeqfgdyC3Okp+nua4M6goCwIjOJolYbZgaRJ5pStfltS0b+zZQk78YXoXrzP3m3eVFbmLqWC3vTzM6ZZD8vleEVJxHvyHsU6yuAw5VTq0HZUq6tIsq95Cd16M=
Received: from BN9PR03CA0601.namprd03.prod.outlook.com (2603:10b6:408:106::6)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:16:05 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::60) by BN9PR03CA0601.outlook.office365.com
 (2603:10b6:408:106::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 05:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:16:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:16:00 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:15:56 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 10/22] drm/amd/display: assume VBIOS supports DSC as default
Date: Wed, 5 Mar 2025 13:13:50 +0800
Message-ID: <20250305051402.1550046-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 001701f1-ab4d-4e04-a115-08dd5ba4d460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pvWgzMjcW1ZFdxZGNPT4p/NSwqJmT0H+feOdY31kjZPHS0j3tqMFbXeOdK7b?=
 =?us-ascii?Q?lv/Cb7hmXghiQ8ZeQTyr35Nz0LH69ZwbszdAn1oqy1LOhS18xi8trZIg8fo0?=
 =?us-ascii?Q?6KQPK80CJeDf8gCPu8ka04g1jNMU8XpcuMm4KFwQu8iqo8Lw2GI/SSgLrAhy?=
 =?us-ascii?Q?GnwUehWbvE9acIvNsGeCcEtQEwbYrTW0NTVF9rQ+N87ggT7BkUP6l6wF0k2B?=
 =?us-ascii?Q?hfFl8eu+HPtDvFzQLaGSzpWiWgoEyieYbRk/SEKECVtzdF2gGY6fYouZnbdg?=
 =?us-ascii?Q?zCh80VO47I39ItWvswpGG2bVaET7qE3fufyFtHwaF8uqLk87djaZbZMfAtDC?=
 =?us-ascii?Q?Sc/5L3YvymLYRUtxylGIJx0wRLr45RkLtP/Vw/sAHPwwdS1SvXHMgdXYS9JR?=
 =?us-ascii?Q?wKg9f4taqhi4VVKiLw4wF7gkIpP6A83418nc+jHE3Ny1jrXg4NIu7LPs5te2?=
 =?us-ascii?Q?tOT8lr54VKvbUffJOzGBkqK/cUoK2rUm3bEwcTDmMS883Vk7LEo7xDiHPwf+?=
 =?us-ascii?Q?r9GqZMUG0J3WkvQlsNKOYD9d/JOqZMAKEfmJEV4fIq/b7tAfRYm6Odg9bM4t?=
 =?us-ascii?Q?6YJ1UTB4dsMI/QgNi3DpvGxaRRsMpD8Oj4xkcAX4kn+pRJvqdm7P34oYZ+mZ?=
 =?us-ascii?Q?3FEjpofWhU0pwZNCa9GpTVlg/Q3QdzmEqU+8CHGwSxvgcsQuUUmsy8yEODtV?=
 =?us-ascii?Q?XxFqZe0Ho+VDqeQfLw5+nvMC2bv5+aSDEKMBt1ziJrwcKIB2mk5xTUluFI4u?=
 =?us-ascii?Q?ecCRA8NojtbEKajlFrn8VsiGL+S8/r9cHlXy/p8MomOC3n1Mgsb36ZTHfzz4?=
 =?us-ascii?Q?zBEr5oxlBX535D7AN2sj9q5Vnhd6QfB62JaSW2iT3u288EYHsXNpGUyb5xJO?=
 =?us-ascii?Q?vYNnl8e71M+I1RErpxxmmvoDI1W6UjEf4zM0EUgB7pfhx4Uvju1GJ91u2OIO?=
 =?us-ascii?Q?ryQ4oko4wDhwvhy3yApvvCn0V4hvEyir5VwHq+oUIXeQgoY4/VqVDzfQLfLR?=
 =?us-ascii?Q?OtJuZN7Hf5TnK+YVKk1BUqk8hrRDKcxYRL2t5U3puzdrR7C3R0b7c9z/I0Dw?=
 =?us-ascii?Q?cBDDnd36EAiLTD1DArbT80N39/TMxrwBNrm83BVAaRdl9M/w7yDFCUFuLLph?=
 =?us-ascii?Q?8P1uqxHq3zNMRU/HoV9Kt5vzYZ3lQTLSXNRU+I40kW8pXqg1TpAWDLzgQt6j?=
 =?us-ascii?Q?wD9ddkO7pNxZnV3OHYW4v33cw1BT1+XkquXoP96Ly7Td9HIqAmAzUkygy6X+?=
 =?us-ascii?Q?cgtCkuTVTczBkxGtSCP9HdCUPRdFVgVMbD4PZG9nOYIfjUWET3JWJ7k+C0CQ?=
 =?us-ascii?Q?2qtzMHbjYmdhq0sevcQUTg6wmBP3evPDkTdx5K4QUg1Dt2W88Gp6IqUFZ/m5?=
 =?us-ascii?Q?51q0eQi1TyxibfqgxkCHljAlR2iyNyfaBPTDGVD1RDZfy02d+q8lIvaHF5Xa?=
 =?us-ascii?Q?5aij57yFyI5OK0GSfcFIUrME0rJc6zGRLIQe9GE/01ges+7SEKlFeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:16:05.2032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001701f1-ab4d-4e04-a115-08dd5ba4d460
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
The clear_dsc_setting at boot logic was based on dcn version
check.
As such new ASIC lost this DSC clear up logic, change the
assumption to BIOS support eDP DSC for new ASIC.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index bfd734e15731..dbc6e533dcac 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1836,11 +1836,10 @@ static void clean_up_dsc_blocks(struct dc *dc)
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 	int i;
 
-	if (dc->ctx->dce_version != DCN_VERSION_3_5 &&
-		dc->ctx->dce_version != DCN_VERSION_3_6 &&
-		dc->ctx->dce_version != DCN_VERSION_3_51)
+	if (!dc->caps.is_apu ||
+		dc->ctx->dce_version < DCN_VERSION_3_15)
 		return;
-
+	/*VBIOS supports dsc starts from dcn315*/
 	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		struct dcn_dsc_state s  = {0};
 
-- 
2.34.1

