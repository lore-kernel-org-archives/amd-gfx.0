Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259B4C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 09:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F8410F4AA;
	Thu,  3 Sep 2026 09:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zV811d13";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FBA10F4AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 09:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqmMzcPyHmbHKIfSXkeO+TcYVbRhDVmN6vHfLQm3XIgDhQcehgOn8owpQRaXLNebkB5vTTJLUVRoKCjsHtsIV2bmheLR3j2qi/EOtNF822uWvHHPRrMhZ9g1/ApxmaeFOd0BrZfAJUF1qAy13s8IJnue6bTSIimxfYdbi88hQSQShCou5DvidN/8XXOgfwWNSEXOnLWDCq9eAvFyO1FLHOHRwgdDLHAKlnHFOu9qI+WkE1sTVYDF/D+2DKQp/GCQJhe8JidYTnr95z3jjoqCI6glVuC0+Ctf3a4IO6JuujfeUmKsomsA2CRcpvNRXWQBq86uc+9lZhtdGa0RE0p1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1F6w7Jc3ybE9/ntrRgSrzhXeBpfAPRrRmaftmcO2JI=;
 b=IxYgbt4yTEHNUNlusYXVXX4H+H1IPz8T+cMyoqCIUtOAGUlc01qahYV019KHoGn6TkyQYaxTi0nqWeC7oMm2umZqBTgoaCS+yGkkdVTYwVvReZSvZtpXGePE6IIi7Xu09svj6f4qLqsc5ScYMcdX4huVFXAcKLqom8DMF6Fxlom097YwGe7MIKCR11Ol9xWecjtW1zc+W2MCVe1KdoRQLY6K4u1TYmrTM6jTqJGPymZqlA9msqVazTkbmGswDAkbM/yW3laTYfpy4albzivbdMxIhBbOMOyjY9YOQZ12rBvCwKpeJA0UGyYMR18y683uDpqbVnBusq9q0AkAlgVGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1F6w7Jc3ybE9/ntrRgSrzhXeBpfAPRrRmaftmcO2JI=;
 b=zV811d13fPwVgKvCS85BMGOCX+16DjqOJ6AHkY/MuOCL6SYp4ldjh4rJ52JSMiQWo6HN47QLFL8wTlN8Z6geZEsT1+njgmwq+mBgbwuZuY3L5uXXotHVxgziHx81Kx4F4QffnfgG/kUSOqHCbWwKYsA7GTlhkpUCZsHnev2Tknw=
Received: from BN9PR03CA0936.namprd03.prod.outlook.com (2603:10b6:408:108::11)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:44:46 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::9b) by BN9PR03CA0936.outlook.office365.com
 (2603:10b6:408:108::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu, 3
 Sep 2026 09:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 09:44:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 04:44:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 04:44:45 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 04:44:44 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/userq: reset a hung SDMA user queue over MMIO
Date: Thu, 3 Sep 2026 17:42:06 +0800
Message-ID: <20260903094438.3880682-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260903094438.3880682-1-Jesse.Zhang@amd.com>
References: <20260903094438.3880682-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0178a8f7-9473-4059-9481-08df099ffd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: i+2zgPMndWLxE17tsOJlRYTEDeI8VF3Pxcx5XB11YpQrU34r0uDov26NZM2U1pMpWWkXynN+5wJr0PB/hv8U81rzW95mAX5v3592QM4Lw5pDqvRIcsU10OsWHjydAJL2LkNkPh0uKXKPgp+FUbPF2clZbG4Z2izyc3CxM/vw1xPQ/8okSnmEhdziHxY5kdiinas6lO62tZsssXpgOniTUwPNWsmlilLG3C5VC6pEp28tru9UFBiEAfRFJp5PufTyaF1pbBVJrfLCb5vbt5IRTk05WvEDa7mkLvqQqaDbQwmSOjUlWRmWaEK9PTFsx80TvY9Er2QNcUGZRF4jsL39+2xXPpjVwSd9ZbqZn21P6tM+c+U5p5SiHQGRjcGm72rosYfl3FRbanxwSVRd2lcFiW/FwbsAV4dYsqTHtKDJz873gMuETH3neJuFX8Na/FWh9xCaRWagpxghTpfvQ9RgLkWU3Q0H9A1unB7xXbSwvjI/B0w8qpLw7iSoi436y+mrScd8F64teWsdzeMmfOGljmSgw6yrXTnr6Hn5qhV4dmng0aDhncn1uxm/cUIhf6dOxDC5491AYwzbipGcfY5zQHa02RlnQ5g3pMEqXEfbCoJWtlR0xx56CKlBob6N9cSB7wSl5c+S91h4ZWjwzqvRjjf+6IXkWSltBiSb5aBkWiFwhb9+28IwBEIJgmioepXWb65xrSOMZ4QrZifAntrhEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: whcGz1YGxk44HKXGVeN5WA6cmF2ay/POwSn/4qRZoDl1Tl4iCXr/ZQkR5G5+LxHOq9kxkIeMsbN23EDU3SnkGJqFMuI3jqtQe25goDKmCuJLPNJPzkQaR3ix0cXRSnIZ3b9vXzsEY+LLijIijQS9XQOtZ5ebpxYzo/4ODkTyRtGSToDAss/XY4aFTe9NwWp965mx8HJjsxCq0/M6y04sKw9qRfqtIuzCJkpRasrWZFJ7XAJCz+kHkLf0ULccEzhQpM1qRWUtWYPvLL+nb+0xy1SFL4J0MqckCLRvQMgL4CBeI9ROYOeeaYXk+p8b8+S8Dx6MAfDpuOiPflg8pS/jY0ndb1hoBuAiEMgqmVPU9nNgGYlTdIejd0x4LQV+tVvedv0MSR6WIRIKyA4VMhPD10jaq0fQj2k2z0G3p0Rxxo9qkHsPsmEX9l3NZn0edcto
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:44:46.1680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0178a8f7-9473-4059-9481-08df099ffd2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
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

A hung SDMA user queue wedges MES, so the MES packet reset times out and
falls back to a full MODE1 reset - once per in-flight job, a reset storm.

The queue is still on its HW slot at the first hang-detect, so use
detect_hung_queue to recover its slot from the doorbell and reset it over
MMIO, which does not need MES. Mark it HUNG (not UNMAPPED) so the restore
worker does not re-map and re-run the guilty job, and short-circuit the
per-fence hang-detect re-entry once the queue is already reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 48 ++++++++++++++++++----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 46ebc002548d..2ce94cd04fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -213,26 +213,56 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	struct mes_reset_queue_input queue_input;
 	int r;
 
-	/* XXX: add a FW version check for SDMA per queue reset */
+	/* already reset by an earlier job's hang-detect; just signal and bail */
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG) {
+		amdgpu_userq_fence_driver_force_completion(queue);
+		return 0;
+	}
+
 	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
 	queue_input.queue_type = queue->queue_type;
 
+	/*
+	 * The MES packet reset fails once the hung queue wedges MES. For SDMA the
+	 * queue is still on its HW slot, so reset it over MMIO instead: recover
+	 * the (instance, queue_id) slot from the doorbell.
+	 */
+	if (queue->queue_type == AMDGPU_HW_IP_DMA &&
+	    adev->sdma.instance[0].funcs &&
+	    adev->sdma.instance[0].funcs->detect_hung_queue) {
+		u32 instance, hw_queue_id;
+
+		if (adev->sdma.instance[0].funcs->detect_hung_queue(adev,
+				queue->doorbell_index, &instance, &hw_queue_id)) {
+			queue_input.use_mmio = true;
+			queue_input.me_id = instance;
+			queue_input.queue_id = hw_queue_id;
+		} else {
+			dev_warn(adev->dev,
+				 "SDMA userq (doorbell %llu) not on any HW slot; falling back to MES reset\n",
+				 queue->doorbell_index);
+		}
+	}
+
+	/* HUNG, not UNMAPPED: the guilty job is still in the ring, so the
+	 * restore worker must not re-map and re-run it.
+	 */
+	queue->state = AMDGPU_USERQ_STATE_HUNG;
+
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		return r;
 
-	/* mes_userq_unmap() does not update queue->state; mark it UNMAPPED so the
-	 * destroy path does not issue a second REMOVE_QUEUE for the removed queue.
-	 */
+	/* drop the queue from MES and force-complete its fences */
 	r = mes_userq_unmap(queue);
-	if (!r) {
-		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
-		queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
-	}
-	return r;
+	if (r)
+		return r;
+
+	amdgpu_userq_fence_driver_force_completion(queue);
+	return 0;
 }
 
 int mes_userq_reset_queue(struct amdgpu_device *adev,
-- 
2.49.0

