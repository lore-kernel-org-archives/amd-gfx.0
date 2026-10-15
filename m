Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4162DCC6B39
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 17:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA1E810E23B;
	Thu, 15 Oct 2026 17:41:12 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAED10E23B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 17:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/7WUeN/Q7tsDuOke4uTTa/S40cfRnql6XLdXEFtuMFGWIs3YQA8BKVFnSZZSkOM5+Rl//xzp8Pm4rd3yFTrXEmxBxau/vOBDkuRMmgXNSl0sSu5TD/EA8XVMEC0Hw3IihPC2VfXqefjG7RafWzwMq2NrxK8XuYWHpiZG1CcWQ16hD13VuhEp4uf3Pb9YiBxrY0FXZKFdHBeC5YcmA6XZ9R7hrWOoviyTTohyChvu+CEFCbEcJE8wEfPlquxDR0OlPvA9O5KKF5ZnXNLec9bRJgW0l+BrZRH1207oZIpIxntY9VZMoqetkKbS0p83y1UJgBSIxehjgOlIMZ8l5kxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ/Jxzg9JeXV0KhDZV/pDflGaFQ3JfhFVZmczt4F0qs=;
 b=quzdW2eWujCOGiOuzkiP3lsr8MqrZJSvmQLmh64aiAb3bTxxSgL8SloxqiBGAx2lflEenb+nnkjEORoJCm1YuZFCvNBnvmJ8QmF+JxoHGQZhZ+uSASoTIf8tgiQyCzTRgHx6jujSOnNDTCNu252kEfIMhMr0LBRr8ygdB2G+weJnJ789Mj1ofXUdfTjqWDpJbbC3KspyQfZJjtF/xia51k/uOwwlgQjfjItUJxaTpcUatIw53nFt+tY+Gc72quGzPEUUitpKcenh0QnuT1fT7K3dXsEovY3cRJHt/2CW154QcDQ81UmyPyNTUg4nPcy/gj6wzVqMMfQGnRYv4IihdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ/Jxzg9JeXV0KhDZV/pDflGaFQ3JfhFVZmczt4F0qs=;
 b=TjnXFyabfq1cr1W8M1z9WtYVZCubK8xF6RgOtAEobiXF2Il3HPziPzix6tK4qLofPA1g4mXXzpS0nYT7xFMctUrcATbeO3L5/40bfNC/KwCOPoM/6cMCRNCbBMxTSxsmoj2Lg0ZCW60O0IYc7+ndstNmde551G57g4Lv6YG59n4=
Received: from BN9PR03CA0219.namprd03.prod.outlook.com (2603:10b6:408:f8::14)
 by FT1PR12MB180078.namprd12.prod.outlook.com (2603:10b6:170:1f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 17:41:02 +0000
Received: from BN2PEPF0000A991.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::63) by BN9PR03CA0219.outlook.office365.com
 (2603:10b6:408:f8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 17:41:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A991.mail.protection.outlook.com (10.167.248.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 17:41:02 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 12:40:55 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Michael Chen
 <michael.chen@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: add watch_addresses to set_shader_debugger
 interface
Date: Thu, 15 Oct 2026 13:40:38 -0400
Message-ID: <20261015174040.65493-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A991:EE_|FT1PR12MB180078:EE_
X-MS-Office365-Filtering-Correlation-Id: 95469bcf-3627-4ce5-65d2-08df2ae37b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|3023799007|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: vPNqDvnt7vgqqolqgGG43JaZBEJAXk9tf8bsbgChPwnRQAcV5pDf46Sf9wcOokge6XjhoH62LPlAOoBngEwbaik34a0I0cIpZZ13F4Jv47gVDXN5QgQXxuBKbRW84eRwQFfBkixbeolkSpHVHX0bHlNfxjzcZ6mKtdoXzY0YnjruGHnE+S9hwoVqjWd/r0TJHQLhXJljPQnlh5hh9iG/gPgbT0xF5Xcq5NNpKmCk1W6xsB4WEqIG3CMEa5+plqjuEl+ZGzBXziTUgwZ8Y83w5d8oV7YHfEPlfy5ekyMrUQpVmsWHx1W/l1wx7gI5W8Uw9isA4ayvw7OhoQz73Pqf3PvuJFApGv6zghAW4GZeZVA+RA9QDswonIzmORz6OA8qFBkYeSrQJeREkLLt9KpASqg0F6Qt0XGGYMJ385BJPu1p6dniPSu0MEXvFjQt3iwS1olIYkX7sNAx2ivnouihHiWkkFLq3PqUOTYIPygdMw8G6gw9STcAByw4G5LRWNeOOXl6IjXYuJbbmkO9EnwLbdwsyuyWls/QZi94SBN3tJ28FM5mb608rsLPse6SwgINCdfaFZ54HyCuFYb9pMw0t57VMGoJ8WgkykfC20rPd4TUWkhA2eDhXvKZqMFQO/Hrgd8f91sscjSxfYozPeuf9bldurtwdHqTz6Erqkiezu3/DNPWUtmFHX5bZ3wSyMVsvO82Rfp0qmq2wMOSTIhaJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(3023799007)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2zV5+Vu6ewUslnoKL+kmr6PLcSQW3wUVHMkIJGaVVDkrqWOuSbnu9bhru4tQtHpo/818kQJa4wEkBocQvfFjvQSy32GSwJ92W2NGPweyEfoGgVLUl93Y96WU72Jspr0rMHo2aqwvXr7UcWtXr33uE2cwmLBokufeI7R0CJnswipL8MnWM6x4zZkKLSRFbD2M0Tjl+h1Y/vEOnyviH3CmSFQuheWtyrL9lhTY4KobfPLRPBTHXncGatXSBMYR+knKOimxu8ehNokt3mHYEO98kYmlp3LGfmZkh6gVD/Cy3kI5jdVQVfWjQB2nEctr23Xws9woUH6sEoihekkFJEOUF9Ff6pYqWE12qNWpRQlY+tKsTBPobwWf2Z2dfbIHPrZvyRQ41xBwQ2uG4uyJTwfb5/QhR1pKQNjeVkjQgtIWUMO+OkVdcdYfrouHl9skdHkJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:41:02.3160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95469bcf-3627-4ce5-65d2-08df2ae37b3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A991.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB180078
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

Pass watchpoint addresses through amdgpu_mes_set_shader_debugger() so
MES programs TCP_WATCH registers at dispatch time.

Assisted-by: claude-code:claude-sonnet-4
Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c  | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 05bbbd1afb630..53d7cb1402d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -695,6 +695,7 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
 				uint32_t spi_gdbg_per_vmid_cntl,
 				const uint32_t *tcp_watch_cntl,
+				const uint64_t *watch_addresses,
 				uint32_t flags,
 				bool trap_en,
 				uint32_t xcc_id)
@@ -720,6 +721,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 	op_input.set_shader_debugger.spi_gdbg_per_vmid_cntl = spi_gdbg_per_vmid_cntl;
 	memcpy(op_input.set_shader_debugger.tcp_watch_cntl, tcp_watch_cntl,
 			sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
+	memcpy(op_input.set_shader_debugger.watch_addresses, watch_addresses,
+			sizeof(op_input.set_shader_debugger.watch_addresses));
 
 	if (((adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK) >>
 			AMDGPU_MES_API_VERSION_SHIFT) >= 14)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index b967b6c0b4c75..0c4cd663de9ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -435,6 +435,7 @@ struct mes_misc_op_input {
 			} flags;
 			uint32_t spi_gdbg_per_vmid_cntl;
 			uint32_t tcp_watch_cntl[4];
+			uint64_t watch_addresses[4];
 			uint32_t trap_en;
 		} set_shader_debugger;
 
@@ -623,6 +624,7 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
 				uint32_t spi_gdbg_per_vmid_cntl,
 				const uint32_t *tcp_watch_cntl,
+				const uint64_t *watch_addresses,
 				uint32_t flags,
 				bool trap_en,
 				uint32_t xcc_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 8bed0d0f9bd26..71b34a57c2cc2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -374,7 +374,9 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 
 	return amdgpu_mes_set_shader_debugger(pdd->dev->adev,
 					pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
-					pdd->watch_points, flags, sq_trap_en,
+					pdd->watch_points,
+					pdd->watch_addresses,
+					flags, sq_trap_en,
 					ffs(pdd->dev->xcc_mask) - 1);
 }
 
@@ -449,6 +451,7 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 	pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
 							pdd->dev->adev,
 							watch_id);
+	pdd->watch_addresses[watch_id] = 0;
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
@@ -485,6 +488,7 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 	}
 
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+	pdd->watch_addresses[*watch_id] = watch_address;
 	for_each_inst(xcc_id, xcc_mask)
 		pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
 				pdd->dev->adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7a365fca68e4f..c0207f44493cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -870,6 +870,7 @@ struct kfd_process_device {
 	uint32_t spi_dbg_override;
 	uint32_t spi_dbg_launch_mode;
 	uint32_t watch_points[4];
+	uint64_t watch_addresses[4];
 	uint32_t alloc_watch_ids;
 
 	/*
-- 
2.55.0

