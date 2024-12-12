Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747E1E77182
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2565D10EDFC;
	Thu, 12 Dec 2024 14:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jO9NCkiV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B848F10EDF9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 14:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvmPlJyNPzYxLXdxjTORdL89Is2gN2tRQdGT9L32ol6R6ZsLDy/aE2QUmiUQbRTSS2mFJ2B2cHGUdBjVcQCVO1AxXVsTbrJMpsu2fQBQv+JDfdmUAL60bW/P0glolrIgrsnBOghwLRryrH3bghdWchbiyPl4N+oWemxhBXYtyLDYgPzD9OrMa55DhLKL7CDy0VqPd7oSaiHinDVcr2AWq7J3LLasiUUB2mAiKIZm0llzOJRY3lYxQzGbThGox3lnn8DlDPEFFIM87yquNNwUpIzInVl6fQ6VkWIY2p1NnRLLWEH6pf71cma1+v0+2pClCjnkYXtL5L6mqNjIYGf/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dam774+C2Wm6bDdKNmfyTUWz+G/g9t7Ijy48YW90Xec=;
 b=vYlTG7kDmjRCPb28ma3o9cB/E+UQMesd3S2WqSi23no8N6rm5qn+3vIQvH6AbhFYX8l7qh7L0+xCHSGvgKAQPvZHVOIP7ztiTsoc8oyTdrvuGEUp4in6jsH5FKCmlRFIe4ApyGcoa1qv8tgSGC+0tuxvQi1QXdYFU0D7UeuodZb43OHTTIvlD9Xy3K7+N5eNLYv4xTZtKhQFHfeZ/wyUOFw6mdJ8K+K+BxyauZCJ+q4zb1qtjG274h09BjciwFG6+2JpCUB6t7DX90Irkk3bR/8bqmq6qVJqabwkvkUacsjxvpnbrwucztEZ0SSKRt9zqVx8DbsfCm6flydFy8u1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dam774+C2Wm6bDdKNmfyTUWz+G/g9t7Ijy48YW90Xec=;
 b=jO9NCkiVPdzVhqd3JAEwiY+0WlcADxtBnWQjE/TGjm1xGjxvkPQHR43G/fNLmyAZ2GeAPtiJKWhhQf+m1/cnJr2PnmHi/4EdvDiz1czObUeHa+85bbhCFOVmw7xoQsVO7UL3GyKb45aG7u6BX5WDoFMhJjqlCzgxC/m1lr66ItY=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 14:26:00 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::73) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 14:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 14:25:59 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Dec 2024 08:25:57 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 5/7] drm/amdgpu: Modify the MES process va end limit
Date: Thu, 12 Dec 2024 19:55:31 +0530
Message-ID: <20241212142533.2164946-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c7341a-bbb3-4614-22b4-08dd1ab8e636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0UzOWxmQ2ZBc09QL1lQU2FTS1ZhUWRFS1A0ZmFmOEorbzMzcFBTRTdSQnVR?=
 =?utf-8?B?Rk5OWFpXaE1Pb1VVZlNEWFFDSXQ1TnRuTk1FYXF6NWZUNlNuZk1WSjMxT25j?=
 =?utf-8?B?RkEyUXpDOTZ0cjBFTFdDUTFIelVENjEydXFGS0VHSjlDYWZ6RHA0ZFY5RlNG?=
 =?utf-8?B?R3NIRFJkTUQ1MkN3RTVkaDY5TUV5a2RLSjJGMXpBK0dPbXIvQUlQYlBIcTVv?=
 =?utf-8?B?eXJYUU1PSlRaTGNKMFR2NzZWZTdQUHkweVA3WHdXdk5jdDVlalM4dHB6OXNw?=
 =?utf-8?B?enB5aGhsZ011YVZHUnh5NDJSTmwzNE1sUGYvU1EyUjhYU1hzQWg0MmhPYVNv?=
 =?utf-8?B?VllLbVhaV1dxaXFtdmlYaC9xdkU4LzdpSFdvaTE0bGlmZW45Mi9lOEhHVEhr?=
 =?utf-8?B?WDFMRGM2RXVLYjBhcExTMTBzVTFBdU01aWNJKzYzVWg3RnVOWHNEU0ZEQzEw?=
 =?utf-8?B?T2dENlg3ZTYxS2xzeTdmUEhBMzVNdkZESTl0U09OL1pyMnRzcVRtbmRVUWpx?=
 =?utf-8?B?ajJobSt1RW4zdWhaOTV0LzNYbkxkYU5QMkJtcmxTaitZeGRpaGpVVmxZK0lB?=
 =?utf-8?B?djJKOGx2UXNlcVZKL2dNdU1UWXIxd0ZGdWloTTNkWXdpQ1Q5TFBFRTh6YTc3?=
 =?utf-8?B?Skk4L0ZvTFVCdm5Id2o4V3VTOEplT2xLTnQwNkNmelQrUk9qVlF5OHFLTXNP?=
 =?utf-8?B?TTR5a0JoajJrTlk4dGtlUGc4akVsOWErYU5LT0NvY2JZUkY4SHM2d3JreVpJ?=
 =?utf-8?B?YVNRR2M3S1ZRaWNzWjV1aVFWak82WitxWnNqSVVVT2g2ZFYwdlZ4SFdYMWZt?=
 =?utf-8?B?SThrRUJpZnQ3Q1M3ekdhaFJOM1ZzQnVYUEQ4dlI1MW9zMnoyNVpyNHB5Qk5K?=
 =?utf-8?B?cm1jNWx6SWk2THJ0eGpJakt4OGN0R0xQbnZtd25xTzdpY04xbjF1WlBiRzc2?=
 =?utf-8?B?VFh2SnZXRVJFd3czZStjQk12bDRtT1hHRE9UdmNKQkxURzdSOFpxdXVjTUN5?=
 =?utf-8?B?Ujc1aUIxdVRXR2dxbUFtOE9KSVJSS3M4MWdua25HaXBscXovWW96K0hjVWox?=
 =?utf-8?B?RVAvRzUwbXQ5Q1RFeXdDL2N3S2UrRjJmRnZxZmxaODNyN2FRUnhVWnQxMkdG?=
 =?utf-8?B?NTdRMWNLQitsVndVVDBKajV4cjU1cjNYRU9JTWk2ckx0VE9uNDloWFdTdDFM?=
 =?utf-8?B?SXFCK3B5eGFjYWNOMmNmUGpFWkVOVEZQS3dQRXlENm81OHBiK21BNmlRZzFh?=
 =?utf-8?B?MXpWeXNRcE9rSVpQMk9ENDJuVmtsZFZXRWE0NHhlK0FIL2g1aVRpaXJiM3Y2?=
 =?utf-8?B?em1pNVdYZHRrOFhkMG5vSzFPS29oSzJsaTVIelRoTWlnTC9iMmpmcnJqZUIy?=
 =?utf-8?B?VWptVEYxS3ZsR2h2VGZZNkw0bXlxb0VEcW1QR2VvNndxWTdZK2dUYWIrekQ3?=
 =?utf-8?B?ZG9QYi9ZbTA0dmN4WHdXY29LSzZySm5SdXh4dThDWngxZXNXSlhySDViMmp4?=
 =?utf-8?B?d3J1L3V0aU45UlQra0EyaHd4Qk1MeGVvaG94R0N3RUFEL2hWMnJSbnZFOEZ4?=
 =?utf-8?B?bHowbVJ2V2VROEhxcjczWTZ3MFRqZEtRdnRaQlZjbHpGQUxmOFI1MzAxdWxp?=
 =?utf-8?B?aFNXU3MwRXJnREg4VlowQ3BMWjlYNmpCaFdkOGR6MmdGTThqeVhzekVzZ2VU?=
 =?utf-8?B?WWNBQ3hHcXZWLzFTTU9LOUcveW5hY01yOTNIZE80MkRIZzlxUWQ5ZTNKeW1Z?=
 =?utf-8?B?aGxnQkZ0dDlnbkZEa2lYWEs5RHd2YUFMZ1dlUVNnTDUrbkd6K3RlQmljMjBa?=
 =?utf-8?B?dm8ycTU3Y3ExMUhzek92YzRCRldtZWdoUmxEN2g5YWNGaGp1cEhqMFZMYlE1?=
 =?utf-8?B?MTEyeE5LQlBWWEErenh1aGtxVmkvK3pyRVNJcWNDZ01Tem1TREw2eE1sNlkz?=
 =?utf-8?Q?/AR1kLKVsNCBuA6UpY1M9GuWPDdrSRxG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:25:59.4153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c7341a-bbb3-4614-22b4-08dd1ab8e636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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

From: Christian König <christian.koenig@amd.com>

Modify the MES process va end limit to max pfn.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index bb946fa1e912..cee38bb6cfaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -662,8 +662,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 		adev->gmc.vram_start;
 
 	queue_input.process_va_start = 0;
-	queue_input.process_va_end =
-		(adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
 	queue_input.process_quantum = gang->process->process_quantum;
 	queue_input.process_context_addr = gang->process->proc_ctx_gpu_addr;
 	queue_input.gang_quantum = gang->gang_quantum;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index dde15c6a96e1..ba550c7e2118 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -219,7 +219,7 @@ static int add_test_queue(struct amdgpu_device *adev,
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(test->vm->root.bo);
 
 	queue_input.process_va_start = 0;
-	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
 
 	queue_input.process_quantum = 100000; /* 10ms */
 	queue_input.process_csa_addr = test->ctx_data_gpu_addr +
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1dde099382ea..9a6a5553bbc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -109,7 +109,7 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
 
 	queue_input.process_va_start = 0;
-	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
 
 	/* set process quantum to 10 ms and gang quantum to 1 ms as default */
 	queue_input.process_quantum = 100000;
-- 
2.25.1

