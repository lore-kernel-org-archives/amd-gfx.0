Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E620AD58B08
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Mar 2026 06:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A9B10E038;
	Sun, 15 Mar 2026 06:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LAKfqIUJ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1074110E038
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 06:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+9Z8AC2iQUFO9ZU0gM3KpS8twWBJrS6wNUK08FmrXtxJ4ae4dHqqcR3SfaNfNEAkRJ1mj4be7FDL1wm0L1fD0LX0e2FOUoFIoirkojx6jnzJc2mzqfo/s6wCdkV7SjBxpRHsd+hypmTQ3cnBPPdU0Fr0Y2dfYSbDPGbC0l+aKVakMKShx+CVtV5YMDD6lxbFtlm4zVHeFZOMhWU6V0lVoaaPp9pDEgT0bn5H9OZx++lEkDU4UTF8BRIxiRatAOnejLTwoHs61Hlw1PB/fTwSZmEaLuXVJfluDgTcxTFwbEwsYNrO9fEEqZTSV0p6EdSI8xqSYunqy/d2htYYUiQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVYN7eR6yM6Pul8EvacDapibOVhHl5QOslx4ho2Dp5I=;
 b=Izc69qfHoRUHezbBUuGKEaV4mlhkA5K45aEJvF+lUEQ+zp5TqqiC+xTfbrM/TKqvMkSsuAXyB+xEpAblU6QZsgyuXNSEGU++sjCZNOHTZNw7l6UzQ5v0H5mt/Y8TPfaqeM/u01WmTdbqxHIQBVPUmnRF/U40v1jkdiO9rWH79a5i5WEjjpR6A2OEE3kb3odL3+hwDTofXTlY1C++xI5TsV1uH/aL/f+MZV6HooTRzWg8rCi2EjzNghbZ3qwEF1NhCC6USvrCH3fkFmdTqaycSQVSkKm7e9nNZ7fyNM9aHKH83kUNGuohoeD+Qfb9veZMiBloPeDKL9nIgTEU526mUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVYN7eR6yM6Pul8EvacDapibOVhHl5QOslx4ho2Dp5I=;
 b=LAKfqIUJI9yIQqqp+BBOusA0IDPknTiOyj1iCxjlVcdDpPTuwoNIiwmf62efqMD5BW3kAKnOHjrI2guYbiIGpMWKlGF/fMjaDtWIfdjIR6RmmHrdUoFfDhJolzCfuwV7GhniTHFPRxBESKKA497m/a+PCCo3OZRQhLrkaNB2Tl8=
Received: from DM6PR10CA0004.namprd10.prod.outlook.com (2603:10b6:5:60::17) by
 DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.13; Sun, 15 Mar 2026 06:25:31 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::21) by DM6PR10CA0004.outlook.office365.com
 (2603:10b6:5:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.21 via Frontend Transport; Sun,
 15 Mar 2026 06:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sun, 15 Mar 2026 06:25:31 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 15 Mar 2026 01:25:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/ras: Remove redundant NULL check in pending bad-bank
 list iteration
Date: Sun, 15 Mar 2026 11:55:09 +0530
Message-ID: <20260315062509.1931432-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 916f469b-3e59-4ba3-f053-08de825ba86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qwMo+yLVtDCY0noy5BAbIyc8Jorn9T2Bi4gNONkyLHr8poeJaqYs2Wq1LYD/+7ZAp4iUJsp3x8lgFoxRL/rDvuAPoPUfrAXoHhRrS2jeiF3b2UJEWvQKzmKp1UrxNTLzdG20GRuDtApq2UDH6DQKHMmkiVB6vK/IzcZg3PwKl33GHPc5PHxOZ/R0WQHyZvo8QPNcpbEVwkd8fz+rhB56OKpCZYaw8TzDzbvuW4XN07wG2OV65Y4iZmKrsW9ybd6rM0uDijYl4xAQq8oPwD83G+IgOTFcwcuxZOBEOKAnOXxtZVtU38sr8zuKJYuY1Kmp7osztoJ+SVmyFRs5AJuYZSmpm57MumMEgOTwzTCbdrlRUcnutkmpuHcBfnVaKCzA9FBaPIMnOWKuHCQg1SyyN3GWSCYswLL3mvomNFZQaWQM0Hq16VEaEvhw3kWUdLwaCCow1hVXXwNCRmBchaZTOR0OJlwUs22ai+T3MdLNq+PJRVodcyojhrVNG73P2NVHFi7urMzSt+cJO+tv8XY+xx/1BdgZx5/+KKA4LGTgd1slXBfiG/LWO7qLDqx2eRWNZEgK4Xvh39YRk5Gl3AsvHsXZusLUwYovjwAbOe6ZS0qX1EbHrmJUq8q+ygx69w1BfuFXLcAQejhWAhMgtuoaesPkDToiKQp7csbJRg+Nz3qxC6Ny1iJXHDa7Fz+PybpJUuJwlqRaqE10vwrypxRcNpCtzjw/swhCqVKU4qVAww5yzOgGtZ2+eYdRztkvP7TDkABmAFBXGtogu6udWmYQqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TOIVU5nn+jLyQzhwzvDT37VbCMLQb0lUyf2NWkDOEmElFNoDfwoviiJugwfUM6JcjIp+g3GaZKL81ypkt+d16WqQGT/cn2LuEI4MQe68NWjdp9WItiFhfFNbef6hDFC/CnSFFV0qAt74qUlakR74ALC6DQJECAcQYwdpMzI2xgyCmLVNvzA7uixxLVNx3B7aR6mUb0Nbs9NaualfCLc/zh0vvCZ2/wPh5Ops2H2gJC++HV+qkxOAGMWTOTJgu3UZBY2u1FVDeTsR1eZ/OlGihpnoKo9t53HMpBUrfZtfCC1DmZKfr9A3asag/fPkr7a2JdNizee005mdD/K/wd+IeWdectMbe8AijVK6xA+O1LMV4GQr/YwWR/88EE8ZThn7rCdkKtCLDJGpm5JLzWbxBKUKkGjIbObxNi/HDTUFx4mUg6RXF/Ee4Aa9yxcxdJGU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 06:25:31.1702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916f469b-3e59-4ba3-f053-08de825ba86d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
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

ras_umc_log_pending_bad_bank() walks through a list of pending ECC
bad-bank entries. These entries are saved when a bad-bank error cannot
be processed immediately, for example during a GPU reset.

Later, this function iterates over the pending list and retries logging
each bad-bank error. If logging succeeds, the entry is removed from the
list and the memory for that node is freed.

The loop uses list_for_each_entry_safe(), which already guarantees that
ecc_node points to a valid list entry while the loop body is executing.

Checking "ecc_node &&" inside the loop is therefore unnecessary and
redundant.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_umc.c:225 ras_umc_log_pending_bad_bank() warn: variable dereferenced before check 'ecc_node' (see line 223)

Fixes: 7a3f9c0992c4 ("drm/amd/ras: Add umc common ras functions")
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index 6074807ef6b7..d4072350f48f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -222,7 +222,7 @@ int ras_umc_log_pending_bad_bank(struct ras_core_context *ras_core)
 	mutex_lock(&ras_umc->pending_ecc_lock);
 	list_for_each_entry_safe(ecc_node,
 		tmp, &ras_umc->pending_ecc_list, node){
-		if (ecc_node && !ras_umc_log_bad_bank(ras_core, &ecc_node->ecc)) {
+		if (!ras_umc_log_bad_bank(ras_core, &ecc_node->ecc)) {
 			list_del(&ecc_node->node);
 			kfree(ecc_node);
 		}
-- 
2.34.1

