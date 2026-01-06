Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4950CD043E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 06:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547BA10E241;
	Tue,  6 Jan 2026 06:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tg2mzoNb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B99010E241
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 06:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE9Mu9rWke/YjWehb+UTR9zRASLeP9HdzAkbY0nu5JaQo0UYTaEGVu6Yp3vLHZ2dheItyz7G/4uKHPTqaB/ZzoU/vNdh0iGrWQNSSRK30mbEukzaYVfVFtawvIRdXuTbi6WnuptcFJ3pRo83ose8DDWnflLx5aA3qSkq2CDENRzJnow7OcKWIu3mcad7pu1TBEtAVMvbFNhNXfsbaEPQ/QTCICdigxeI/EOCipf+z6w7iU5x9AH0U597QIbtlB80k9xDu7MWc4tCIKGKJW4N21aMV5aPNkl8uVmE2S/QVen7Q+6s5EItTHbMgp+QS9XQqbnkvoOefBDxv/wmeDUigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SzN/DWyRjlW0Spi+phJ6wdDXtJnmV/7IrKTajssPwQ=;
 b=PpzXYCOZPDYb+1jqZa+C6UM37leBuvV3k9oXz+77uY9pllEp4tqT1iZqHXBvQDHU7zPeKfBv4e/vrTL0LhjLY8GhvwkuKLueo+RY6ZthUs3JfNhRzlpiWMeDJAFpFz1AefGihb8lnoeHzT9Nff9CROaniwLh9it7s0oHgsdh1xKUyzUnJF3bWYEUr0HiKz6In5/V2RiyTtz/6cqx9XNxdN7vxizo5XZidDRXHzysUu0nUM6TGOk+ZYB+ZU+3TgOpXeQKC5WAPFjkUj/Of568w0x/8qYAD6eJGSUqryaOFAw0LPTD4pA1KQClYCiCLJESxnEwrSdi2MaHf6ECWyJhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SzN/DWyRjlW0Spi+phJ6wdDXtJnmV/7IrKTajssPwQ=;
 b=tg2mzoNbq4jKXPWXZmcXEOkH4G1q54H9oBiYjyJl+Rz31oSEFhNIA0d5Kzt2kvGZ4M0sMnuoVzClpJ6XTiGo9NmUHKHAGiJBK6qTpzL/iAlKuQ5hHUQsKkbP8ExNz/NI8VLCQWZ6SyNe+wuOK18MpSgVnkRjJuMi4JKSbo8vYTM=
Received: from CH0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:610:77::28)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 06:49:31 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::a2) by CH0PR04CA0053.outlook.office365.com
 (2603:10b6:610:77::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 06:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 06:49:30 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 00:49:28 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu overdrive data type wrong issue on smu
 14.0.2
Date: Tue, 6 Jan 2026 14:49:11 +0800
Message-ID: <20260106064911.1653986-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b1716c-f364-4bd8-c2b4-08de4cefbe3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jFsAj+GR4YsKsYHetTW2eeuqecPH9cd32Nh338JtF6WA4zpvZNiwBIH2FW1O?=
 =?us-ascii?Q?qC2EAc/JWJMbwXf+pPysTd8IC4ytsR/v4ogauNS6Qhf8qyVlPedy8Dq6QFin?=
 =?us-ascii?Q?2jyVsyoojIcfa6WWHuRQHZlrz9DGOfj7l1qqqnvd8NH5qeQGHBstj9ewq20Y?=
 =?us-ascii?Q?TpjPWRrisdg5FWDmkm5OIB5Fhq6mE54QeL2nk7uEMZCJN+8XHN6VLvp0SFj5?=
 =?us-ascii?Q?esKchTF3HI7P6RWQhFVvu0sAtDZmobAlq1WH9o7c31AszMMXPGw/gBGxxVzv?=
 =?us-ascii?Q?+Rz4/eg4Oltg+Byiad8YX0jWY/7tmNXND70gjoSof6g/dsZg+qO93zf+uuc6?=
 =?us-ascii?Q?Ev8gXjZ4aFxf9fO3YLna9PTgvSoYXB9h4DIfi/o+dy5faba9eQdnY5Ls8qoR?=
 =?us-ascii?Q?aIdPFogS8gLhEpiwvTE9qjQojxcCt+/sCbfZrxU9Vbm7e4FfByeGPltlzfvP?=
 =?us-ascii?Q?jmuWMb1d3DaPjGn3nYnWy35CsUYomdqrpQelx2XLd3tDHitFSCT7EnoYR5tH?=
 =?us-ascii?Q?AQcPzmh5sB6Vzp1cmcz+9ulAtNHlspoz6tZnnGDv5ZOA23b5CnZvIuV0eS1t?=
 =?us-ascii?Q?VXIvUzzYK0AFiQT3M2ryVAOsYhygvdV94SCVYju2WIwFLcwnGkWXlz4+xrhM?=
 =?us-ascii?Q?wnfrdVyQHAEW9XNQVSiBD4MbW0FJ1rGHR4JY+qtIwRyGyPCf5JyulCi6tvRx?=
 =?us-ascii?Q?dk5s2VnL314ybxSRd/4r1BbpgfaPahBng7cQRHhTwBsDexV9ep+SxUg3TeXL?=
 =?us-ascii?Q?8U71L2FiBlHy/bzde1I5tMqNUAUpCury1TXjjWLr/2Ifvm0SE++lSd5G3iEM?=
 =?us-ascii?Q?Ow0owqkcX6dr/Zk0zXgYtg/CjhDjihFxbOx9/gy9NYTCzd7Ts5vvCRAm73BA?=
 =?us-ascii?Q?oyWWPqAyS5jWDzwHmuMtZ1lxEarp0fwzg63TlwSyyg7AsGBvmT9+MzhJtORV?=
 =?us-ascii?Q?rGdpS4wFwzej+KhoSIziX7bky0ramF/HCsK2b+QIkt/jraELBja72T+Csxyj?=
 =?us-ascii?Q?tsgQ01zUKalxHboqaUwKpq3kOFkqYkZsR2pCP7iwp+nIVnec41pBnp5xUOWf?=
 =?us-ascii?Q?Gj+Y7PdipvpGb4bHRIuhT32MrS3axnrHLhso6Zxh7fbUkhz3MXbcVjeI7NTI?=
 =?us-ascii?Q?6wCPDQgJgJ12IxdCMbKusJTDIDH208ICEkwYyFZjrIOvYLVoJCJuzeB4a05+?=
 =?us-ascii?Q?D/H8DANEVeshOX+2j/uvzClABtG/OIsyu1UafUGrsBCOaHaz07avY7bY16oI?=
 =?us-ascii?Q?niSxO0a6oUXn9OWB/l5vQG8ZbjkIH9QmaPUVe39KVflR0ApYTCIPvVW1EOr+?=
 =?us-ascii?Q?wJssFIYieOR17SWqqbkQJn5xJN6CQ5CABgsfu/MXHIfWLg+0HKMyCyvzi6Bj?=
 =?us-ascii?Q?HGGQCbhtM81xxZfFoP0OXhBE01LT5LMf4JTXsWwOD9e/bpDJJXhkokpO4u9k?=
 =?us-ascii?Q?ATwKd1WNBlqXNmclIeiA/PZ7huWinOl4xKaRO5u4vqWBb0PgS9Vvg2y2tWnw?=
 =?us-ascii?Q?FKbhtEDooC+Lx82TG/GzgZD8EPsMGkw49mwMAtLvOiOkVXQoRes5fqY1FoZm?=
 =?us-ascii?Q?VCRRh1G4lME9Qwxj1N8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 06:49:30.5334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b1716c-f364-4bd8-c2b4-08de4cefbe3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

resolving the issue of incorrect type definitions potentially causing calculation errors.

Fixes: eaa4293e87aa ("drm/amdgpu/swm14: Update power limit logic")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 4c6f62665b7a..5fad09e25136 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1633,8 +1633,9 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 		table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	CustomSkuTable_t *skutable = &pptable->CustomSkuTable;
-	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
+	int16_t od_percent_upper = 0, od_percent_lower = 0;
 	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	uint32_t power_limit;
 
 	if (smu_v14_0_get_current_power_limit(smu, &power_limit))
 		power_limit = smu->adev->pm.ac_power ?
-- 
2.34.1

