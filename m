Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0932C531C9
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 04:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3295510F2AE;
	Fri, 24 Jul 2026 04:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3DzpOCoV";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DD2910F2AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 04:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eISG2P8rZTVKRspv+azQyMDBLuzOgHqllRgi4QYB/AiaN4W+ByRiZ37QVinJ+cM7bIboc+vtQf8gLfyX/pxwsPb+qBuitSDTBmk2k97iQmV0aBH0x3tzUy5MBFmpCDohJEsbe4+sAEXfXTdZY5JLQypKw9ISGDgqPrSXHvEbkLG6x4gWh+etlN89hw8BQ0n65INmUaUZDG8NmTmHoiqSB7j/q2EMkVUVj+Z0+VKouCLTVcu3PVKQWXS9ZUYn1IUfz9Qo7TzH5o40EETezHhr3HmVY0nP2biFqgZwNQQh0lJcUWkFipi/75Lgrwi7Dz96r9czZ5qkEmvoVZu3pbcIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpUh7hYPCYSkMSxWmCtX0eB2TqZXz4iy+JHoBvQckTM=;
 b=C2lsH6aqOWBMeAiR2UiBRF2MJAbAFUMit9c5TjvnS8Bz1OyYZ6WO60qQOC3ZByXNBpBMBw8TDV2Kk7KjmEOU/RzDLS+2OJIWrGGPUSZHqFinK8DlTN2gZbs1ofWaOB9WWruzBtFPjs3wcbOsOpLDUtMThoARxF6jxmxtKwqXNBo7rEgLBB2RyxzNc4P7s3ij6nOZQEX8/3/V2G+trd4cupHhsgilMjFYeE5nft4DqGd7C/AFSVezEoMhOf63n2ak9XKq1TbaVx3mL0Cjc4/m6RriydcDq6UCZKok0GYWpz758xmthgUqY8vXJOPrmXZjlBPnAYp0yFaY2PM3XCozIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpUh7hYPCYSkMSxWmCtX0eB2TqZXz4iy+JHoBvQckTM=;
 b=3DzpOCoVsYMrfIpsmC5qkPbmmOiGz8XqELcLAqi4W7atTZndX0N2u4UeYbuDY2Kz368HiZ0uS1KvSZPPrEfiPJsyjC1FXNBk3dcV115kkrUaIsMVSoJwmYsMaidGky8pXoBCYKKf1FWp44JQ4xWgCphKhnDf0BWD1IHhSNBExp0=
Received: from SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::17)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 04:43:37 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::22) by SJ0P220CA0008.outlook.office365.com
 (2603:10b6:a03:41b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 04:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 04:43:36 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 23:43:34 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, <Lijo.Lazar@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amd/ras: add device lost check to early exit psp cmd wait
 loop
Date: Fri, 24 Jul 2026 12:43:25 +0800
Message-ID: <20260724044325.1092820-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d5a9f4-0b35-4410-3b4b-08dee93e2021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: EnXASWO+8+IASdAn68OSZtLHFCfEoqBTUzFl4/eNmYBhyPja+6zXa1aHbZ6wVCC+HPJC82wt2i16gAdriN2L0EiNlTovEZLGWaLVjCWARuPyh9yknBuKVmjYDhq1ptwOAFxk9G6lHtwKfzhMIbPmjkY0Bkx1cR2lC5NsdQQ6KHZ7q8AUCc0QQo6XBuetpJx5vKuhMHomMgf2jUaTTiUnR7byDjShCrNDQz1+1ms4IHk7WdA6xusSxP+m2hVAFwTSLK3Rn+jefjX4Tu0tGa9Uq9sK8UrNxfCcShde780MiVP2mxmKnH5JanrT2MNE+itxCRZmoQYrCWWvBU1rM0QJT+n/iH7sHKL8ZZtk84g4HNf6natWzfYzorQy5YrxcSoSGOhRPhb1hZpNAgpNz61y+6DyZoacWJOaRyEfAC/O2gG5IhlzS3vceRJft3cV8pu9YN3G6ea0f+CBcb8rZSX63+ac0L3/yWL3gU06ls0RzF980VA/0k5nKvkyg6mfnZTI6nFN7Ujt9BYyU3grItpIzT+VkoIV+141ICz08kcY/Jm4hi/93wQaUInmJlfsuXFxIpPeRGdHyoHUip41jJJWxHyEX9m+xDVGsd4dQnibg0iSMYX7NDqTMPE15zs7C/1HBILA/x32GrgjwmO9wnvlZ5lPFC4Qqggo4cQOpyeFtEK3r17eTNtX8aodI6BEbU3tzk7POPu7Lmi1Qex5oIlEXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ga8RhRlbHRJiRCy7JF9fvnVs4cbgxrPYESwJrN8V2JRlhYEtxOLs26PM4bu6k8Rd36ZTz+CpeHszls6sjzyBMr4r2MpRS6wI8NuTaMp+HQzKNwcBJrg4x5s+TqI394n6rhQy4L7goBu/ASKTJkbX+ILFwZejOe8vw3tO739L8BEO+EIg+SarxPMcohO+S90J/6P/VDzkal2qlPAW2G6EnWM72Oq8SJBnMycGl4gcv4P1Hyo05HDvkygomge2cgr1a3f7VbuHofwGwaiurLOAWG2zRDlxNwGyryC6u/0HkFXHHetx3bPkzU6RqLNt5g4Y4qIcGrK2bmhGuBa5+bjtD0oLaB7kEXnwknzf24puAQbxXOPRo/7YyfF8a7Doi1cpqMMcESxooQIqRTV9k0P5+gdDPYHCot2/Gtw3rW/2LWQrXahAuipZEqxBVxpstN5Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 04:43:36.8127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d5a9f4-0b35-4410-3b4b-08dee93e2021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
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

Add device lost status check in PSP fence wait loop to exit
polling early when GPU device lost

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras.h            |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 14 ++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c        |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index e4444798bc73..0b36b689fcfc 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -171,6 +171,9 @@ static int amdgpu_ras_sys_check_gpu_status(struct ras_core_context *ras_core,
 	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
 		gpu_status |= RAS_GPU_STATUS__IN_RESET;
 
+	if (amdgpu_device_bus_status_check(adev))
+		gpu_status |= RAS_GPU_STATUS__DEVICE_LOST;
+
 	if (amdgpu_sriov_vf(adev))
 		gpu_status |= RAS_GPU_STATUS__IS_VF;
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 5869bad978b0..76a215ed0945 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -137,6 +137,7 @@ enum ras_gpu_status {
 	RAS_GPU_STATUS__IN_RESET = 0x2,
 	RAS_GPU_STATUS__IS_RMA = 0x4,
 	RAS_GPU_STATUS__IS_VF = 0x8,
+	RAS_GPU_STATUS__DEVICE_LOST = 0x10,
 };
 
 enum ras_fw_eeprom_cmd {
@@ -371,6 +372,7 @@ int ras_core_query_block_ecc_data(struct ras_core_context *ras_core,
 bool ras_core_gpu_in_reset(struct ras_core_context *ras_core);
 bool ras_core_gpu_is_rma(struct ras_core_context *ras_core);
 bool ras_core_gpu_is_vf(struct ras_core_context *ras_core);
+bool ras_core_gpu_device_lost(struct ras_core_context *ras_core);
 bool ras_core_handle_nbio_irq(struct ras_core_context *ras_core, void *data);
 int ras_core_handle_fatal_error(struct ras_core_context *ras_core);
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 61d100b074b9..56539e47d50f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -143,6 +143,20 @@ bool ras_core_gpu_is_vf(struct ras_core_context *ras_core)
 	return (status & RAS_GPU_STATUS__IS_VF) ? true : false;
 }
 
+bool ras_core_gpu_device_lost(struct ras_core_context *ras_core)
+{
+	uint32_t status = 0;
+
+	if (!ras_core)
+		return false;
+
+	if (ras_core->sys_fn &&
+		ras_core->sys_fn->check_gpu_status)
+		ras_core->sys_fn->check_gpu_status(ras_core, &status);
+
+	return (status & RAS_GPU_STATUS__DEVICE_LOST) ? true : false;
+}
+
 bool ras_core_gpu_is_rma(struct ras_core_context *ras_core)
 {
 	if (!ras_core)
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
index 358f602b167d..35264c119bbb 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -294,6 +294,9 @@ static int send_psp_cmd(struct ras_core_context *ras_core,
 		   psp_ctx->in_fence_value) {
 		if (--timeout == 0)
 			break;
+
+		if (ras_core_gpu_device_lost(ras_core))
+			break;
 		/*
 		 * Shouldn't wait for timeout when err_event_athub occurs,
 		 * because gpu reset thread triggered and lock resource should
-- 
2.34.1

