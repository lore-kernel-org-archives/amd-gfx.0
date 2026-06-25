Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEAACDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 02:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA7410E149;
	Thu, 25 Jun 2026 02:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5WDvxZ9j";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF4A10E149
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 02:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDSOc+ZDjdfVjCG1huSwcEKQOzZ0lnfErrOrewdOYfBx03QSyUD2d+oSD/d46KHL3CJHz70CmEcQtCys/MlbAY2Kr3x2Vx4yzpP9kNCpvuwfOSnuZ18/66BCvmhqW0J/7Tm8FKynwHWahx45OpH/QRj2WPQJcRizejSBn2kuAKKLaI7rWCXE4LiuD5hURupK8bjYhm5Yt99gCClOTtQKXTAHYjnEgHMq2bKCFZpvYSPaTb1xIzMn544x+f76I+j8c8Mwl0YKGtc7GrvV01HPJwnehOoKrmDYWVGgvpHZT3xV/N8/n34luKk8GaWDH6x+zTITgX71YUeukYcpXTkoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5YAGQPtYyBTgCj5pgksgPmuYYdSBbk6JKIGkNx1U3k=;
 b=giMWRhmVk0LR9rmhSVqT0lPqAwsBfEA4vvUu44RTSDc7ATaBDJaJoZ5479dnyOKEzjQNjQSTI52d4eh0u5U+i+S+WCYtcIn4W3Pex9fQE7lhZLgEJoywc0lMCKuh+gDFZzGSpVb7wRGWedfGGEllshntMbDLNySmPOYXLWSidfTP2RoUoy2Y4eyLKmCwEka2Z+VIFpP7OcM+MKtN6zgTGBCx4bK4Rvy0TpOrFRKfcjf75YDaeMc2X0Aoe9wRhGhpUdFFUT5VFWM1Qp/uzdnsMq12aWaHNKsleVGzi78MiN/ohtpwLCIunHjJ0k/0WZbj9CqTCxib6C51p19iT7RtiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5YAGQPtYyBTgCj5pgksgPmuYYdSBbk6JKIGkNx1U3k=;
 b=5WDvxZ9jwYRsp5Kn9J1DorGmKeogGFTL2gjewwEHq0qy9DzDHv+QOaNKw4u9hhc18z40EkKME8wWASK2zbRkMV8YXQZma6rM7aSm1f3EnfhyVAfIC0TSQWrSicuT6jfv8/6kmobMkfSVeK7DCevWxBMD5Y6vNleadnX6e59Cyw8=
Received: from SA0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:806:130::17)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 02:59:46 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::55) by SA0PR13CA0012.outlook.office365.com
 (2603:10b6:806:130::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via Frontend Transport; Thu, 25
 Jun 2026 02:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 02:59:45 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 21:59:43 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: Fix SMU v13.0.0 current power limit reporting
Date: Thu, 25 Jun 2026 10:59:33 +0800
Message-ID: <20260625025933.1558864-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efb3ff0-8938-4f77-ffb7-08ded265cff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|13003099007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: n08nzQhpjhBNbe8kN90w4/0nKPYUbaeU84ALEaeYWjLV1ID7P6DhKW9NY6JFU+tIKnGumILyeqRcYn2k2lpeo3cJMR/NFc8X5YMfRIeglEZFtp55A7RWt9IFnocVYNIs6QbFI8VONiVT9zTVYPwaauVG/ckCEW+VwCjPi3DfnVgbiwsPIFos9SIjIhLIBffKZKTs+0PecoZq00jSFiKHmoCGYl77voI0BqhgzyWwCz2lr0s4RO+gaOuxLKkRTbxVKIb1BjWRATvsag3mmnkoxcOJfVUqjngGrq6Kxx8af+Z1r4A+Ok3qVUt+yrHY4rElETVhuWqcuUJkUAshI56cr7Cb6eFNKLpVMIM2Ffj4T7k8VVY4mQV9nC1qx6JXl0LVxop0luKUwhE21CKDSfh8vTlnRZdEalieVgbYrcm01eImjCvcAGPLpt7Q93doZAhRoC4MQhwE59fDk4Ny4lFVHUN+gUrLH/CBblUWN3Uya8/vIk02Eejai6mpCgHpffLK3uDgCZYS74psKqcI8CgEIr645f4eF5do0dEdYd2x0/hcvNcz7pF9oda5LWzzQ4V9luJGN3T5ApBVnnYsA2g8dP9ElAzYOFGP+CO3I0HZ+CSJ4Odr6w4TTaRZtD3ooUEz0E2jF055s07IBoi6jqwVOKGg5tcnoxUphJtV7I5gZ8Yi8OkOq+uXE2dMTA9k3vf9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(13003099007)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vHrbCX7x7hJpwmfbQUgTFFT1iwddLzRou3Umj97vV4HgGCO21xgIV4pVotz5JGR2C7OYPssFLzhaxFKVl6IVlyf+VC/3uzcXuy616zWZz8JZVpmhC2Vw/mpe9m74EjdNAHLRyPyWQJKmPG1eKOnuj4vBgznaVT0iUjVUd7VvaXATRTEfEWtxh8D67Z9vcefmZhs8DQTn486SHoRbNMmsloIfgt7ICPAHBEChQiRQCFW3RWxwsCQhkVLeZOlZSiiFEH5mlmPvP8sR1QoMl64sqJs05wd6zY7N7AMgw10lXiTy2L8NFf0EYp6vtmcIk3YR9Sx0bPOj9eFi89Qy1kmyI+gu9BYEOqyNOTnNywatnMak8/X1Tm6bmsm33gGg3kW8x0QEXW1GmgX0zQjDmDy8tOe0n/JeUEDQDTU4cQ9NQ/t07kFrstLwjUj02ufm+p8g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 02:59:45.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efb3ff0-8938-4f77-ffb7-08ded265cff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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

smu_v13_0_0_get_power_limit() queried the current PPT limit into a local
power_limit variable, but never copied that value back to the caller on
the successful path. As a result, callers requesting current_power_limit
did not receive the value returned by the SMU.

Fixes: 8c658297a4db ("drm/amd/pm: fix smu13 power limit default/cap calculation")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5416

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index c984dce48310..19ff9b14e772 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2404,11 +2404,11 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	uint32_t pp_limit = smu->adev->pm.ac_power ?
 			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
 			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
-	uint32_t power_limit = 0, od_percent_upper = 0, od_percent_lower = 0;
+	uint32_t od_percent_upper = 0, od_percent_lower = 0;
 	int ret;
 
 	if (current_power_limit) {
-		ret = smu_v13_0_get_current_power_limit(smu, &power_limit);
+		ret = smu_v13_0_get_current_power_limit(smu, current_power_limit);
 		if (ret)
 			*current_power_limit = pp_limit;
 	}
-- 
2.47.3

