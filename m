Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1430C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2671810F42C;
	Fri, 21 Aug 2026 19:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aKqftJY6";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B7910F423
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m16s7S8M746lD4DEECv2gm/lBxDroOlasKJqb1scGJRrylOkjqd0ooxSkX1ysQjWEe5kVXv3+ttI9Hc5bAc1Hc9fDHGpYN/zD3oi6DVWK9C2tlunbWMlgYJ0f6rgz5UyO0rFL5ZkAHy6Pfs9HxRnJAQe8SUEPA3Zvj2AW4k5SDH/ahFyNJvXmRAeDq+R3wlj4uU8ZhKTbDcatSn57WfOZdw1e/dyAPxZnIhgsIkLIQeWJpx8bdVWq8vtcyRK0lG5o7seqq3VXjHFHu06nUAV0GkyzNNtg/zb2RX/vh3MR8LVH4W4sFaXJZnG5uLZu/ttTKV46y3fDVDwFWf/KmYoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LBFaRWKlHAANbg8/6hkltL4zdEeDdnqKwivP9l948w=;
 b=cYGpURJWW68HmPexbZmvu5+ZsDGwNJxKBt8GbVLm8nC+pXzYrho9oEcFlUtv4qwcUNvv9Y6HOQZRcKhe0/QleNCoCzYm5Dq6QBhtBRa9rcd9kjuErZKY5zY84KeEoW0V/Glby1OWl5d3Wk4M9UqPvTYgBcAKoVfZCMEMJmSPp2Uozaq5mZbfzurHh1OaQppOa+C7oXhLkpXsanX+R0Yac1ivPJlODnSPmI7saHQEEQdBs+GJuG6MVxJWL8fdbFwnjRBQHuKWtU40gSKwD6lbQml2NTsm5cXvEKgpp5lFMr2tBQ0RaC9721oL1aAiqe8lm7ffQeHSidn/fjeTEml3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LBFaRWKlHAANbg8/6hkltL4zdEeDdnqKwivP9l948w=;
 b=aKqftJY6Tc+xyypv6hJDQXgR9itYwPf2xaHdijs/PrjMrxKEW9fhXzaxUqyhrg5jci7S3PHOQk5RJiQd8eQLhBF+4sh7gIDy+iuzhRnYNc6E9ubzMzXJM80wfklOMLIkcxAQQCfa6EJY6867yVZRZRQ/M8owImvMhxyOHxf0FsA=
Received: from CH0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:76::32)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 21 Aug
 2026 19:35:44 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::11) by CH0PR04CA0027.outlook.office365.com
 (2603:10b6:610:76::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/95] drm/amdgpu: Add UALink IH ring and enable interrupt
Date: Fri, 21 Aug 2026 15:34:05 -0400
Message-ID: <20260821193458.808626-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 193aed07-7978-46a8-680d-08deffbb6425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: +A2e/kAnal0/MM/+Xg5o3lnC8IdSIhWHD8sTgAFepEMCPTaaLkFvLErJgDspyF5ZAbaFtl7Ak1y74vNq0tXj6W99RfYjKyoBl3dlOq1sSzdfRTZs+BvYFUroaFWtgTBLFUQ436UzPcx72Malkscl4eo1I1UApYZsFCzFaoPGSBKP5BH9Vz3fVN8pnoU1+UxYCK729mvsIzFoY6BcG9zvxoOqKyBiKLZR6R6o7LWHZTl4NqupN2+xRl06FpE1aujk+qaeDWdRppibQMHZ8BmTlgfQeRGGYmGZNt3IajH/t74p3gxF74efKBOQwu1B87FL8Lwy1Y7NYRx/LtVjyXJO+LWKUlyeqAfcCP5+0OYO69fWYst3O7dOSMMycU4PzZLbp9I+lyCX4mL9pbsFMoI/H5L5CspagH1EmiKWQhOdu6pJ4EfL/8JJGTGtlIUaCVQZleDCu9HJQl1i6FKBsV7zt5aqF9ETRP9OihqxJUd7Z2Scg/5JJ9r2jTKFddfkwXBP8SGBReuQP//DoMBYgH83tcJOBHXxRMYtqRWy3g9Sk7/SbfpkTZOe+OoFQ5U6BJwVFlcJrxa5gK0Jx6c/REaF5gZygk7MiSq0D4ab8hJuNJ6apx2O28UWCAe8pvrWPtS2iKgeoJNnUueJltOWnYQ9cKrEbEmhRmxqtcca2gnQAILaAWrADFAvJySjYODfDXN57Sg00Jn+hdc8QvjHbd3Yrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ImlVIjiGd3kjkub/yHKakRZ/VVm+bScROU0RGV1fYKeLqyViInSW5DlQXpFhI6qB2zeOEXAUSSCEsWbNd3MU5acSjikJ8RHKdxHikjj5eL0yhjDIuN+zxStBSp0gFL252SsROgMoM3x7bJRZCeTgOJY19JOV4YEGlRLh5ObLNanGCtLVmyWKWa9yskIrv1OVQpXoVllwmH9YScXcmVPollXYmrKx70DylvKfPxiw/tH6LK0U59BVlvXSQxYPNZvcakH4BWntGMCEl4UVvfbAzJfj0ajg1rTPDmXiNWenxz+rr5LxsjjEEo6m1WUewxiiwZozc/VoI4HkVjL9Q6K8aKvWY+j9VOlhNuF/NDDx29U/qQXZXo5e+CgMfYulomQ5wx6MnMGTXn1xqjYBFSwstnYfLeb0pOcdEMCFWSfxWhB70fXIw1uO9TA3+c5mIoNj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:43.7047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 193aed07-7978-46a8-680d-08deffbb6425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
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

From: Philip Yang <Philip.Yang@amd.com>

Register the UALink IRQ source with the IH subsystem. Hardware IH
entries are re-queued onto a dedicated soft ring and drained by a work
queue handler. Add the soft ring, worker, and delegate helper to the
IRQ layer.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 17 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c       |  8 +++
 4 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 91f1ca95ea543..dcf90a974326d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -264,6 +264,14 @@ static void amdgpu_irq_handle_ih_psp(struct work_struct *work)
 
 	amdgpu_ih_process(adev, &adev->irq.ih_psp);
 }
+	
+static void amdgpu_irq_handle_ih_ualink(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  irq.ih_ualink_work);
+
+	amdgpu_ih_process(adev, &adev->irq.ih_ualink);
+}
 
 /**
  * amdgpu_msi_ok - check whether MSI functionality is enabled
@@ -341,6 +349,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	INIT_WORK(&adev->irq.ih2_work, amdgpu_irq_handle_ih2);
 	INIT_WORK(&adev->irq.ih_soft_work, amdgpu_irq_handle_ih_soft);
 	INIT_WORK(&adev->irq.ih_psp_work, amdgpu_irq_handle_ih_psp);
+	INIT_WORK(&adev->irq.ih_ualink_work, amdgpu_irq_handle_ih_ualink);
 
 	/* Use vector 0 for MSI-X. */
 	r = pci_irq_vector(adev->pdev, 0);
@@ -566,6 +575,14 @@ void amdgpu_irq_psp_delegate(struct amdgpu_device *adev,
 	schedule_work(&adev->irq.ih_psp_work);
 }
 
+void amdgpu_irq_ualink_delegate(struct amdgpu_device *adev,
+				struct amdgpu_iv_entry *entry,
+				unsigned int num_dw)
+{
+	amdgpu_ih_ring_write(adev, &adev->irq.ih_ualink, entry->iv_entry, num_dw);
+	schedule_work(&adev->irq.ih_ualink_work);
+}
+
 /**
  * amdgpu_irq_update - update hardware interrupt state
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index deee64b69885d..c88431471c303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -90,10 +90,10 @@ struct amdgpu_irq {
 	bool				msi_enabled; /* msi enabled */
 
 	/* interrupt rings */
-	struct amdgpu_ih_ring		ih, ih1, ih2, ih_soft, ih_psp;
+	struct amdgpu_ih_ring		ih, ih1, ih2, ih_soft, ih_psp, ih_ualink;
 	const struct amdgpu_ih_funcs    *ih_funcs;
 	struct work_struct		ih1_work, ih2_work, ih_soft_work,
-					ih_psp_work;
+					ih_psp_work, ih_ualink_work;
 	struct amdgpu_irq_src		self_irq;
 
 	/* gen irq stuff */
@@ -138,6 +138,9 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 void amdgpu_irq_psp_delegate(struct amdgpu_device *adev,
 			     struct amdgpu_iv_entry *entry,
 			     unsigned int num_dw);
+void amdgpu_irq_ualink_delegate(struct amdgpu_device *adev,
+				 struct amdgpu_iv_entry *entry,
+				 unsigned int num_dw);
 int amdgpu_irq_update(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
 		      unsigned type);
 int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 3fc11b49d9863..8ea34411f4227 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -63,6 +63,13 @@ int amdgpu_ualink_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = amdgpu_ualink_init_interrupt(adev);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed to enable UALink irq: %d\n", r);
+		return r;
+	}
+
 	return 0;
 }
 
@@ -3061,3 +3068,78 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 	adev->ualink.remote = NULL;
 }
 
+static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
+				     struct amdgpu_irq_src *source,
+				     struct amdgpu_iv_entry *entry)
+{
+	int handled = 1;
+
+	dev_dbg(adev->dev, "%s client_id 0x%x src_id 0x%x ih\n",
+		entry->ih == &adev->irq.ih ? "ring" : "ualink soft ring",
+		entry->client_id, entry->src_id);
+
+	/* Copy IH entry into ualink soft ring. */
+	if (entry->ih == &adev->irq.ih) {
+		dev_dbg(adev->dev, "delegate to ualink irq soft ring\n");
+		amdgpu_irq_ualink_delegate(adev, entry, 8);
+		return handled;
+	}
+
+	/*
+	 * Call amdgpu_ualink_interrupt handler
+	 * amdgpu_ualink_interrupt(adev, entry);
+	 */
+
+	return handled;
+}
+
+static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					u32 type,
+					enum amdgpu_interrupt_state state)
+{
+	/*
+	 * Don't set register to enable/disable nHT controller interrupt.
+	 *
+	 * F/W running on MP2, which can always send cookie to IH block to
+	 * interrupt driver.
+	 */
+	dev_dbg(adev->dev, "ualink interrupt %s\n",
+		state == AMDGPU_IRQ_STATE_ENABLE ? "enable" : "disable");
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs ualink_irq_funcs = {
+	.set = amdgpu_ualink_set_irq_state,
+	.process = amdgpu_ualink_process_irq,
+};
+
+/* TODO: if move to header file soc21_enum.h */
+#define UALINK_IH_CLIENT_ID 0x1C
+#define UALINK_IH_SOURCE_ID 0x0
+
+/**
+ * amdgpu_ualink_init_interrupt - initialization of UALink IRQ
+ * @adev: amdgpu device pointer
+ *
+ * Registers the UALink interrupt source with the IH (Interrupt Handler)
+ * subsystem during early device initialization. This sets up the IRQ
+ * callback functions for handling remote interrupts from peer GPUs.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
+{
+	int r;
+
+	dev_dbg(adev->dev, "init ualink irq client_id 0x%x src_id 0x%x\n",
+		UALINK_IH_CLIENT_ID, UALINK_IH_SOURCE_ID);
+
+	adev->ualink.irq.num_types = 1;
+	adev->ualink.irq.funcs = &ualink_irq_funcs;
+
+	r = amdgpu_irq_add_id(adev, UALINK_IH_CLIENT_ID,
+			      UALINK_IH_SOURCE_ID, &adev->ualink.irq);
+	return r;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 6265ee4b0ff1e..7f4ef50195f6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -423,6 +423,9 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 	if (adev->irq.ih_psp.ring_size)
 		adev->irq.ih_psp.enabled = true;
 
+	if (adev->irq.ih_ualink.ring_size)
+		adev->irq.ih_ualink.enabled = true;
+
 	return 0;
 }
 
@@ -634,6 +637,11 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	dev_dbg(adev->dev, "ualink init ih_ualink\n");
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_ualink, sw_ring_size, true);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_init(adev);
 
 	return r;
-- 
2.55.0

