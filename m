Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEB8C982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 19:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F0D10E16A;
	Mon, 21 Sep 2026 19:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eOnmBMoA";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8EE10E16A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 19:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw7Kl/SduRXtsv+5EhLqoLwUNHERXeqMu/Vxraj3u+cp2qZqDQr++LrYq8mRIWZCgLSZ9FJkkrum05gbsC0cT77JO8bSlEkTgVXJlygBOI6r6/oIdKucdMeeIsz/I0qaGjSJbofGZ8Y38ctxIt7/ubIclYQQMEdoC8edGbq+tPdt1qBUvQv1mZd5S9oopXDQUM07elH62WYe+ENSwqyXK+/odLU+C1723yRXbLzKbK57y5rb9n0djSE8eZCK6qHNYh7FxRjtKSz3KiooZls5FUPRl3ys4PIoU7tlO1bSc5f6FBDxcl9tN3EWUPx0Zh3+fNklpSBpNZafnB5Q3x9UEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgHQVCQSB+Wiqme9yZ4Fx8YUIJ8cOuSdS5e44oqeFsE=;
 b=wZcfAmAha/QxEJNZOnJcK9nK6SPGlbRpsuHcceZruSF5cwDqMyQoEMwrFWtQz3bIw4WAelV1PFOGAPCY0gO/8QfrjtjyOL4FMoMVBYKyY5cmWelJgU9ZUbBGx0YBXlxhEh5jgzm7OuePwrAJU0t5Fo6L7VLKUHbwM5iwkm3xMa3Ym2mlfHI3RD031W4isBOgb1sCQXrJ48kBUHkd6dV3JNV7M3jrvG93cWKffrQKIDrei/nHbmS7TqoMHHbOczU+m+pbubOGBL8F8bO/2Ii43MqKqR6u3BtXvIj+7oSXDJnpjYXxTgVVDC4c0uNuxvnvSB+NtdE2qdpv2i31JEj39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgHQVCQSB+Wiqme9yZ4Fx8YUIJ8cOuSdS5e44oqeFsE=;
 b=eOnmBMoAyJ2ibC6CIPxBMuGRZa8sHkeNvpACK6fgAs5p7u6rvDVkChzubUbqxbE1nEK0v+FLXA81J8Cm6v/DhL6f+DO6f+yy/Xf3QtFQYK9XCPjIOA6mbls1TbSxmdBSiwM4zc8nPeiYCDR2N07OgsCcvivrNrk839hNODu2VlA=
Received: from PH8P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::8)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:26:30 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::85) by PH8P220CA0013.outlook.office365.com
 (2603:10b6:510:345::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 19:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 19:26:30 +0000
Received: from devkfd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 14:26:28 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jay.Cornwall@amd.com>, <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdkfd: Fix TCP XNACK scoreboard reset race on MI300
Date: Mon, 21 Sep 2026 15:26:23 -0400
Message-ID: <20260921192623.437256-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 1212e351-a31b-49c0-f475-08df18163d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: f4nHMMRAi/g+gPGzqAvrUFr2hOlyChMdEJ4IaWXlZ31+MnfDNqGHzyHLJnyp0pky5WEt0Vtewb74JOw1ucNyCYF+0QvFiY/gUvmTl0sj/IS/zfbVmGCki4D0WKuN3vNzFaBvgb6lCltQ3utjCsYzf1EfP+eJpAus5c4jPAETP602bONM02dzoU/AFg1FELnyWLAD5nN5b/miNWJAMIDes3g0cQ3WjdeICUxVZ63NIkDROI/9rXQX5mdc1XVOh3xOmPLnkWMK1m7fbyjDdgBwxTdAQwOeKHiS9M4RytGSoQeieOE5lpEwbTvfM6dRShunZ47XHPKfKe3meBBtDJeZlUZU9OEFoSCgYBYoTcmmmnkeT5UHCNwiyRdrLjF6OTZYFg0hzZuBDkngVzm7AMNd6s/JqIax6UH8YModoy5GHbObFgq0Iv0lzabAULrOfg4eMF9SMnVUHvk71N7Zf0YaEMAyAhtSx3G6PJASKyBSqZTxcXcqFLFsmZ1CMIg/OBbMl5v0EPoKfXjM0piAcivpNUpyx/zRUxvf3hH7OkksVB2itaUlrEBBbhPSRFnsAzKmfkbofVgUJit+xs/3WIutTYz9tXcGGzA/O0/oDKX+pgtCEsMIhpXpMdUxXOeN3FMqaa6wCdkT0VGScYf2bS9dPM17KPWtFnsEUb26WJ0FKkCRqtCw9sO4rlcUMxi3ydEqGAMiC/i6ROYW0W1zaM7A5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Be+E9lXrEBW2NOVPewu6lVlUhcxeOxiuMBJnrrtKg/AJnlW9jX7kfVOrpT+TXGybYUy2JJrI6s+b9rasIjLhcbhoE/sepNwqE+AsTTfm0opYZ4M+DFvLj2NlJiK+aoZnrJrdZvsmkghXaYy8lATurgs22EB0CAVTGamU+Gz/ZRSwUZWnHKlYwycdF9rHVbaBxmmuy1vQ83q+3AuC7oDzzpFLueB2iGEopwZNOvikBwsBT1kcZs6nw9UraX+agOCYkccZlI5TgrpGoLWg25TCOhywcqQtnVvxZMHXn7mxQHteCPZRo1uuUWmNhSADge3cvDQBzPyIlrMHy/52/wAz2sB0w2OA4OuTjR89xsU+e3ZTGzSiBrjxXVAkhx8+yCenWsJx5Z4ell0d6wwrRN8I+YJWLGlwNZR9Jrniap8mzpPTzoc0cMmtBKj1LA8OP6st
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:26:30.1434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1212e351-a31b-49c0-f475-08df18163d0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

Fix a hardware RTL bug in the TCP XNACK scoreboard reset path on MI300,
where a wave receiving a no-retry FAULT from UTC and subsequently
terminating may leave its scoreboard entry uncleared when reset events
arrive back-to-back.

This can cause a later, unrelated wave using the same scoreboard slot
to incorrectly inherit the XNACK error state, resulting in its VMEM
operations being dropped even though the wave never faulted.

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c             | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h             |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c     | 12 +++++++-----
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 4626e0b13909..ec291377302a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -628,5 +628,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
 	.hqd_sdma_get_doorbell = kgd_gfx_v9_4_3_hqd_sdma_get_doorbell,
 	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl,
-	.hqd_sdma_get_counter = kgd_gfx_v9_4_3_hqd_sdma_get_counter
+	.hqd_sdma_get_counter = kgd_gfx_v9_4_3_hqd_sdma_get_counter,
+	.hqd_gfx_clean_fault = kgd_gfx_v9_clean_fault
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 0d62cf475f40..0bc8d31081e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1234,7 +1234,7 @@ uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 
 void kgd_gfx_v9_clean_fault(struct amdgpu_device *adev)
 {
-	gfx_v9_4_2_clean_fault(adev);
+	gfx_v9_fault_cleaner(adev);
 }
 
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 344156bf20ca..54bcb5fdca24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -714,7 +714,7 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	return r;
 }
 
-static int gfx_v9_4_2_clean_shaders(struct amdgpu_device *adev)
+static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
 {
 	int r;
 	/* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
@@ -763,16 +763,17 @@ static int gfx_v9_4_2_clean_shaders(struct amdgpu_device *adev)
 	amdgpu_ib_free(&wb_ib, NULL);
 
 	if (r)
-		dev_dbg(adev->dev, "Clean MI200 Failed\n");
+		dev_dbg(adev->dev, "Clean GPR Failed\n");
 	else
-		dev_dbg(adev->dev, "Clean MI200 Successfully\n");
+		dev_dbg(adev->dev, "Clean GPR Successfully\n");
 
 	return r;
 }
 
-void gfx_v9_4_2_clean_fault(struct amdgpu_device *adev)
+void gfx_v9_fault_cleaner(struct amdgpu_device *adev)
 {
-	gfx_v9_4_2_clean_shaders(adev);
+	/* to clean MI2XX and MI3XX */
+	gfx_v9_clean_shaders(adev);
 }
 
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index 1cbade5ed657..c8757de669ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -30,8 +30,8 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
-void gfx_v9_4_2_clean_fault(struct amdgpu_device *adev);
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
+void gfx_v9_fault_cleaner(struct amdgpu_device *adev);
 
 extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 9b48fe598597..2ae1129fea55 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -359,7 +359,7 @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
 		!amdgpu_no_queue_eviction_on_vm_fault);
 }
 
-static void gfx942_clean_fault(uint16_t pasid)
+static void gfx_9_clean_fault(uint16_t pasid)
 {
 	struct kfd_process *p;
 	struct kfd_process_device *pdd = NULL;
@@ -565,10 +565,12 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 			return;
 		}
 
-			/* GPR cleaner shader for MI2XX */
-			if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
-				gfx942_clean_fault(pasid);
-
+		/* GPR cleaner for GFX9 MI-series GPUs */
+		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0))
+			gfx_9_clean_fault(pasid);
 
 		info.vmid = vmid;
 		info.mc_id = client_id;
-- 
2.55.0

