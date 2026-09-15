Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F3BC88E77
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 21:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C3710E83D;
	Tue, 15 Sep 2026 21:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q2mo+JDW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B5710E83D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 21:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXOqtIoxGoIVdmXz5RgBswyuSOc5xuye9mHU+G7Cq3YTRuvqDDa7upAOA+/YI3hY/dsTvGjDYvGkgM8DjZbmas0498QCqlI3udJ1KdzdZIRNmAZbvaS27A3xqnQmJ9qY9eC15/kFKUTw71a3qzlTuQiVGLJ6UhfFy87wLAPVcoKX+DHzaxBjiX4vgLThLylucMK59cB6tCw9nVkOfe8g4Xs34FhOlaq6KTET5bq+wyJg4kqBvd5qor8MqU33X3rHAPvc+ONHwleavnpOO0bsdAqK3tx/6kP/+U9lk4BR4PGzWedARbvE2O8Jwe4QKae4ibnJxt0fWhpbSe3j2lWaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uulZonz9dK2icha26lOhCf4EDXmxe7//6oAmbTxFG4g=;
 b=ugzn5LvwjIJzJybc/PXAK5biNV8h4pj39XJHqJ1jCBPy3F+7ovXwSzuqYWjSHZ3Y7+513fwvFpZaFuPI7Wcxvo80EsBsfoAZRYiaM3XEHsc/xlIN+m12iClD710Z0G9EcY+VFmGTVoxIY0GmNnOMjeDdMhjFJ+seXbwARMiS0Tm2gZddkpO6U73IW5+Z2eY0loVBa+NyBgd5g6W/qKEMbv1tyjRKVQceqN0eg7mrgxDFwscW5rXv8/4lA7ApCqGZluKSUWqdGGDH9vVlEqxsUwcY0WThi8Hy9sygXTRAAD/bBhryAXQ3S81UZnLy3XfONF94xXmHXIMRJ2FuTLUIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uulZonz9dK2icha26lOhCf4EDXmxe7//6oAmbTxFG4g=;
 b=Q2mo+JDW169py0Qo3YnWyF++gzvxpiyPB/qR/Vl/T7K3aVLAyBWAyZEiYcHYy5of2kF5rgfQatelJ7DlSb2X+BSZoPDzs0q/larB+N5LEr6ritXFjk/aIhgbXKp9w2UQhdPntz1BU5pchhci+j12M4KULbum7Nbhk4Q77srt1jc=
Received: from BY1P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::12)
 by CH1PPF4CBE7339A.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 21:25:51 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:59e:cafe::62) by BY1P220CA0050.outlook.office365.com
 (2603:10b6:a03:59e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 21:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 21:25:49 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 16:25:49 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Drop csb for gfx12.1
Date: Tue, 15 Sep 2026 17:25:38 -0400
Message-ID: <20260915212539.2197287-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|CH1PPF4CBE7339A:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f74596-fd2c-4850-3ff8-08df136fea1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: naMJXuLg9TwVPVacerH2SYnXk386VAofKeuHt3GzeogBoB/WafdauhTIcHpMIN6+ys84jl6gLPmstjeQ12POj4QHfMnozvNPcCdTA8+/SqDuI7vVjoEf8/KbHdirQOCuVd1bXinJpmk262HjD5hDNQJAnazVRbgGlV5vTAM4zZUM7KgcE6BNFCAIfhQ4Qyd3TKjdDRQfZnmfArPE/v4JcoGR70DwMbhtXKFlp/pmpQk6nga+H/mueOfinJF3mQWqFtHF2o2Z0+/qqNbOjw7J+kUFlavw9yAjqAdWeq/Zu5mtjpFsEkg4N7eZaZKYSd/Jobv75I9fKVe/YOog2/SmaSN1huEfSC7XcUlOXn6LQaQ0mUcRc6K6bRxTzNjzOp33/U6Tqg8Wt0TLDXuppH9J5Rw9uczSSJs2fRaXmO6hKPdTf9Ybsh3RZSxCtHk9f3L9KVByu1fJWIpzZWtNu4dr19o2p6lplcW0MqSFfPK1LOSMpcUerES1EEIrpowt5xw4grvzA5/MV+xnr1Ckgdlk3bBPbES45WEGOVLPSahup7psu/C5FSRx50c51216JLARP4vF7vWHYOcdTa0uBllvIpQTnE8i7Pt01iigq5mdr7rBA1hqPMFdUbRYPqB7XhEwLYQWHkRi2c+wIKeDhIaBWBFaqRMqvpxQbfkK8KAQbZmNCSI314siQ53fcqJqDWrOtqo+xJpOegJG6sgmc1hNUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8ohI/ZtFFJeqFDSHBedXvczTGAHsqS/gq02xwiB8lZUjFVoLztLL7Si5B/s/3t7biIAu+ORnWEVlAavt1oqjqjBm2yWPuP2TWngD1N74lE+oxvVGvSbdaqeiIluOKGUMWBHbtxEnnRW37ZOA8EYsagTp+aTUVXtjW81rVxF1kGrd3CBo/eqxLEgCxpukwvRGTWFwR62E08uFICbctfcEmIAWQh1D53GsGe6QTwlHsSto8gi53xuYsOzIzfu19tY4ssS8p8wL0ZYHibGuLUPDIZ5U2rOV+f32Nff6OdTlpZrPohoAWJrsyBPZfPFTFKbaK4RRupfnEhncZOZsIah709uFg1pEpf7edMe21yulGhzvdAzINrtvuEZA9ZDPHXDr1n69VCrAikuxZTsBxKsN92jUhEQyK62Yk+aJ0p3YNjMRc+2OxQLuv4mEmZEsrsc+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:25:49.9012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f74596-fd2c-4850-3ff8-08df136fea1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4CBE7339A
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

It's not required for compute only part

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 94 +-------------------------
 1 file changed, 2 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d7effa43c0fa..9677f91ef20c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -41,7 +41,6 @@
 #include "ivsrcid/gfx/irqsrcs_gfx_12_1_0.h"
 
 #include "soc15.h"
-#include "clearstate_gfx12.h"
 #include "v12_structs.h"
 #include "gfx_v12_1.h"
 #include "mes_v12_1.h"
@@ -447,62 +446,8 @@ static int gfx_v12_1_init_microcode(struct amdgpu_device *adev)
 	return err;
 }
 
-static u32 gfx_v12_1_get_csb_size(struct amdgpu_device *adev)
-{
-	u32 count = 0;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-
-	count += 1;
-
-	for (sect = gfx12_cs_data; sect->section != NULL; ++sect) {
-		if (sect->id == SECT_CONTEXT) {
-			for (ext = sect->section; ext->extent != NULL; ++ext)
-				count += 2 + ext->reg_count;
-		} else
-			return 0;
-	}
-
-	return count;
-}
-
-static void gfx_v12_1_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer)
-{
-	u32 count = 0, clustercount = 0, i;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-
-	if (adev->gfx.rlc.cs_data == NULL)
-		return;
-	if (buffer == NULL)
-		return;
-
-	count += 1;
-
-	for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
-		if (sect->id == SECT_CONTEXT) {
-			for (ext = sect->section; ext->extent != NULL; ++ext) {
-				clustercount++;
-				buffer[count++] = ext->reg_count;
-				buffer[count++] = ext->reg_index;
-
-				for (i = 0; i < ext->reg_count; i++)
-					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			}
-		} else
-			return;
-	}
-
-	buffer[0] = clustercount;
-}
-
 static void gfx_v12_1_rlc_fini(struct amdgpu_device *adev)
 {
-	/* clear state block */
-	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
-			&adev->gfx.rlc.clear_state_gpu_addr,
-			(void **)&adev->gfx.rlc.cs_ptr);
-
 	/* jump table block */
 	amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
 			&adev->gfx.rlc.cp_table_gpu_addr,
@@ -543,19 +488,7 @@ static void gfx_v12_1_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 
 static int gfx_v12_1_rlc_init(struct amdgpu_device *adev)
 {
-	const struct cs_section_def *cs_data;
-	int r, i, num_xcc;
-
-	adev->gfx.rlc.cs_data = gfx12_cs_data;
-
-	cs_data = adev->gfx.rlc.cs_data;
-
-	if (cs_data) {
-		/* init clear state block */
-		r = amdgpu_gfx_rlc_init_csb(adev);
-		if (r)
-			return r;
-	}
+	int i, num_xcc;
 
 	/* init spm vmid with 0xf */
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
@@ -1618,21 +1551,6 @@ static void gfx_v12_1_xcc_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_INT_CNTL_RING0, tmp);
 }
 
-static int gfx_v12_1_xcc_init_csb(struct amdgpu_device *adev,
-				  int xcc_id)
-{
-	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
-
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CSIB_ADDR_HI,
-			adev->gfx.rlc.clear_state_gpu_addr >> 32);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CSIB_ADDR_LO,
-			adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id),
-		     regRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
-
-	return 0;
-}
-
 static void gfx_v12_1_xcc_rlc_stop(struct amdgpu_device *adev,
 				   int xcc_id)
 {
@@ -1837,15 +1755,11 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
 	int r;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		gfx_v12_1_xcc_init_csb(adev, xcc_id);
-
 		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
 			gfx_v12_1_xcc_rlc_enable_srm(adev, xcc_id);
 	} else {
-		if (amdgpu_sriov_vf(adev)) {
-			gfx_v12_1_xcc_init_csb(adev, xcc_id);
+		if (amdgpu_sriov_vf(adev))
 			return 0;
-		}
 
 		gfx_v12_1_xcc_rlc_stop(adev, xcc_id);
 
@@ -1862,8 +1776,6 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
 				return r;
 		}
 
-		gfx_v12_1_xcc_init_csb(adev, xcc_id);
-
 		gfx_v12_1_xcc_rlc_start(adev, xcc_id);
 	}
 
@@ -2919,8 +2831,6 @@ static const struct amdgpu_rlc_funcs gfx_v12_1_rlc_funcs = {
 	.set_safe_mode = gfx_v12_1_xcc_set_safe_mode,
 	.unset_safe_mode = gfx_v12_1_xcc_unset_safe_mode,
 	.init = gfx_v12_1_rlc_init,
-	.get_csb_size = gfx_v12_1_get_csb_size,
-	.get_csb_buffer = gfx_v12_1_get_csb_buffer,
 	.resume = gfx_v12_1_rlc_resume,
 	.stop = gfx_v12_1_rlc_stop,
 	.reset = gfx_v12_1_rlc_reset,
-- 
2.43.0

