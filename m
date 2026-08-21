Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3A4C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE7A10F373;
	Fri, 21 Aug 2026 16:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IaVFSbN4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA3710F373
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSmAP7Qh3aptKC8Qo4FW0LFItswgZh33c+xwyWfjDuoXDEd06LuLT8ntFrsPr2qojd/+CHkD7VlcnjQb+IPy1scec5ZSA3sfPP44nYylSnOalsz1xMYBIwyyDw2Ks8sTdJt2/t5KGkaRjI0WgwQMdzEAw3uySGeyxbmxr42Z6CiXdSPBT+Yrsbh62ggCU0TJgFi4ihrpmJLlbhkml9zAufa2m994mrxbXogfhI+EOsJfyeJ2dXQ+KP3zD25C63GMsrf+3j3pfXyNyek3dRpXd6/MKPFlHkcFz6e/afV7Fmged9lMSUUXiin0uPTU8Vg2R7CIogOoS2Mh4t2WUCTS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/riIewQdo6LY7VCYN7sJiFkbFELMGKgEyS3J1l9tRSU=;
 b=Z/kWr4yNr/9xOlA/V20wI1M/Gw5FOjN3QU8GHDk0H8qUkVlnrYQeJruCQO2/LjYms7GM6ZsHSqGJNzhDhEUqRiA7BfP5Ne0YI10OT0jSmjnvKSwmBmpYpMcj9ekx0lOKjPH+UtMR3ywdxbk8yY1VwyMVPqhwkfuRTIyUUzJBZaTJNX/NPxkvvfN1/P0qoa7Inmc1R/RDiTRHVYGtyyzW5z8G47eIQBj7Ja7Q0dgqaaHMeJeoagXW2q60eOWdxtE0fObq/q2bcYnNx4vQhiRCgbRAHzDtb3F4Shq2vHZQKgrioraz4vq3E1wCBZZUiLf5YGL2ZHSS2Jkizag+N9c2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/riIewQdo6LY7VCYN7sJiFkbFELMGKgEyS3J1l9tRSU=;
 b=IaVFSbN4S/R0AVY9BAiEjtpJQIQZEv/SFtA92z7HMP7Ec+QVFl5JB+PQnjPjFaY2BxpEaMx5IzIOOJmUPdg2rlPxzMQK6t/uh08YF24vOemwZacTpI+Vmx8rXNbsgd04yY6MXkWqP2vXwwVrUanxq3yDkhk6lfQzjh5X4MlxBOE=
Received: from SA1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::31)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:12:56 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::c) by SA1P222CA0003.outlook.office365.com
 (2603:10b6:806:22c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:12:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:12:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:12:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add psp interrupt handling
Date: Fri, 21 Aug 2026 12:12:30 -0400
Message-ID: <20260821161232.753638-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161232.753638-1-alexander.deucher@amd.com>
References: <20260821161232.753638-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: d7903ff5-d79d-42d6-0458-08deff9f0fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8LWvaaCEgyTck9wgiLtvX/ygwEaKdIsnQnAYqY7hCFuIRSxm6dBOvz2X/dGXzo+BsFdJSzt07CWD+8sise6HDvdlPFyU/ICcAwoykseluDypC5IjGnFxT7ClKcCH4EIkNUeXASETF5Z8ohdqzasUhzUGRWicTm3CABuS/PoPlG6vho+uXLi+s55pm1amFtgzRe0cusZrPCvwYvw1vjWzhUpk953DKHC1+UIJ81DFYFHgcIvn5HHb3VSovuc6EliX2ze0TlSQIKhitiMlsAG/jDXXXFaTQHUS5gZG4SczcS33VQAvNbBDfol6iZ7ty5Nyf5wG1rhB+8Nz/YXssiHB9h5ien51RnrhSiZhkBzSvM6aYexQJJz2HwYtgab2Fs6qPYZXPdRdqUcNvmEjzIVVp3TXtglgVPOy/y2BeIfD2PkftNcuEbvhBMVZ3LYmAqXZyYYTBzJu8xMhoMqoKKxX5qqJ89tOxoo+jjHOyluFBGT4XGfZcL7GkHUYLMA+bZjEcYRpEEMrOvf7rZw4ELJnXJdmYmBH0UYicnZQGdtcLKm7FSCZGbGajYhP5oxOwjhRYVtjoMs92/GDzjs5qj+uX81It3q/KMgjmW2YBAUbrmwtmGQVX/8tTCN3O2a6jMAc4TR9iU09taCQ8FGPSziqVF9Y2D/Q+m42/JbXx9EFzPMsIC28eAPBZBTrSdlXebvkhtKrQXAA7day9MYMS1AMRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cbRE5+5STlnss2A1STQ/vEzYx9Mw5jCfP/BnWgTlVULax+FFrQYATVnhmBG6jc8Z4mlWBXOV5MS41T91INm7SDR2gxeN110g6/KmRqNKSCJgUZKRC7fPXfnvIQ56cBm9n5K1aUmBGftkVCiOK3YmzqJYHZR3w3aBvs25DUhsxwHulQrEMtBzY6HUlGMH7sRy5Bxj4j50aTf3iU5Ukh/SufoyVRo38OgMurWLuhel6JIY0g/8Sat4rmRdQVBbJ2+qWkr/dwwSpdSbLZmKXhYH40BxwKmLJo0DOg6/aW6pKs2/lkdj+h6KDEkXHRtig60wkEuu1Ao5/o1GCxDYgigC8oifJamCCc9cOwSzplKmZu5/js3w2N+vjSBB8Qyx4ZQUO5+t5Q7Urnw/ni3hDuIxmFO3w1836iNGViTkM3UeB/aITqE+oZ9qCEP519PrJ49j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:12:54.4720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7903ff5-d79d-42d6-0458-08deff9f0fca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add interrupt manager for handling psp interrupts and callbacks to
enable/disable psp interrupts.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  18 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 132 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  43 ++++++++
 5 files changed, 198 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 444437c300886..11f834c97d937 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -29,6 +29,7 @@
 
 #define IH_RING_SIZE	(256 * 1024)
 #define IH_SW_RING_SIZE	(16 * 1024)	/* enough for 512 CAM entries */
+#define IH_PSP_RING_SIZE (SZ_4K)
 
 struct amdgpu_device;
 struct amdgpu_iv_entry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 95cceed4e971a..91f1ca95ea543 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -257,6 +257,14 @@ static void amdgpu_irq_handle_ih_soft(struct work_struct *work)
 	amdgpu_ih_process(adev, &adev->irq.ih_soft);
 }
 
+static void amdgpu_irq_handle_ih_psp(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  irq.ih_psp_work);
+
+	amdgpu_ih_process(adev, &adev->irq.ih_psp);
+}
+
 /**
  * amdgpu_msi_ok - check whether MSI functionality is enabled
  *
@@ -332,6 +340,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
 	INIT_WORK(&adev->irq.ih2_work, amdgpu_irq_handle_ih2);
 	INIT_WORK(&adev->irq.ih_soft_work, amdgpu_irq_handle_ih_soft);
+	INIT_WORK(&adev->irq.ih_psp_work, amdgpu_irq_handle_ih_psp);
 
 	/* Use vector 0 for MSI-X. */
 	r = pci_irq_vector(adev->pdev, 0);
@@ -370,6 +379,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
 	}
 
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
+	amdgpu_ih_ring_fini(adev, &adev->irq.ih_psp);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
@@ -548,6 +558,14 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 	queue_work(system_dfl_wq, &adev->irq.ih_soft_work);
 }
 
+void amdgpu_irq_psp_delegate(struct amdgpu_device *adev,
+			     struct amdgpu_iv_entry *entry,
+			     unsigned int num_dw)
+{
+	amdgpu_ih_ring_write(adev, &adev->irq.ih_psp, entry->iv_entry, num_dw);
+	schedule_work(&adev->irq.ih_psp_work);
+}
+
 /**
  * amdgpu_irq_update - update hardware interrupt state
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index af72405a72262..deee64b69885d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -90,9 +90,10 @@ struct amdgpu_irq {
 	bool				msi_enabled; /* msi enabled */
 
 	/* interrupt rings */
-	struct amdgpu_ih_ring		ih, ih1, ih2, ih_soft;
+	struct amdgpu_ih_ring		ih, ih1, ih2, ih_soft, ih_psp;
 	const struct amdgpu_ih_funcs    *ih_funcs;
-	struct work_struct		ih1_work, ih2_work, ih_soft_work;
+	struct work_struct		ih1_work, ih2_work, ih_soft_work,
+					ih_psp_work;
 	struct amdgpu_irq_src		self_irq;
 
 	/* gen irq stuff */
@@ -134,6 +135,9 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 void amdgpu_irq_delegate(struct amdgpu_device *adev,
 			 struct amdgpu_iv_entry *entry,
 			 unsigned int num_dw);
+void amdgpu_irq_psp_delegate(struct amdgpu_device *adev,
+			     struct amdgpu_iv_entry *entry,
+			     unsigned int num_dw);
 int amdgpu_irq_update(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
 		      unsigned type);
 int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55d293a2ee381..a0f6df5067e6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -48,6 +48,8 @@
 
 #define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*16)
 
+#define PSP_IRQ_DEFAULT_HANDLER_ID 0xFFFFFFFF
+
 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
@@ -461,6 +463,128 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int psp_register_irq_handler(struct amdgpu_psp_irq_mgr *mgr)
+{
+	struct psp_context *psp = mgr->psp;
+
+	if (!psp->funcs->register_irq_handler)
+		return 0;
+	return psp->funcs->register_irq_handler(mgr, &mgr->irq_src);
+}
+
+static int psp_irq_enable(struct psp_context *psp)
+{
+	if (!psp->irq_mgr.irq_src.funcs)
+		return 0;
+	dev_info(psp->adev->dev, "psp interrupt enabled");
+	return amdgpu_irq_get(psp->adev, &psp->irq_mgr.irq_src, 0);
+}
+
+static int psp_irq_disable(struct psp_context *psp)
+{
+	if (!psp->irq_mgr.irq_src.funcs)
+		return 0;
+	return amdgpu_irq_put(psp->adev, &psp->irq_mgr.irq_src, 0);
+}
+
+/**
+ * amdgpu_psp_irq_mgr_dispatch() - run the registered handler for a PSP event
+ * @mgr: IRQ manager
+ * @entry: IH entry from the PSP soft ring
+ *
+ * Invokes the handler for the entry's event id (or the default handler) in
+ * process context. Call from the .process callback for PSP soft ring entries.
+ */
+void amdgpu_psp_irq_mgr_dispatch(struct amdgpu_psp_irq_mgr *mgr,
+				 struct amdgpu_iv_entry *entry)
+{
+	struct amdgpu_psp_irq_handler *h;
+	amdgpu_psp_irq_handler_fn cb;
+	u32 event_id = entry->src_data[0];
+
+	cb = NULL;
+	xa_lock(&mgr->irq_bh_handlers);
+	h = xa_load(&mgr->irq_bh_handlers, (unsigned long)event_id);
+	if (h) {
+		cb = h->callback;
+	} else {
+		h = xa_load(&mgr->irq_bh_handlers, PSP_IRQ_DEFAULT_HANDLER_ID);
+		if (h) {
+			cb = h->callback;
+		} else {
+			dev_dbg(mgr->psp->adev->dev,
+				"PSP event: no handler for event_id:%x\n",
+				event_id);
+			xa_unlock(&mgr->irq_bh_handlers);
+			return;
+		}
+	}
+	xa_unlock(&mgr->irq_bh_handlers);
+
+	if (cb)
+		cb(mgr, event_id, entry);
+}
+
+static void psp_irq_mgr_init(struct psp_context *psp)
+{
+	struct amdgpu_psp_irq_mgr *mgr = &psp->irq_mgr;
+	int ret;
+
+	mgr->psp = psp;
+	xa_init(&mgr->irq_bh_handlers);
+
+	ret = psp_register_irq_handler(mgr);
+	if (ret)
+		dev_dbg(psp->adev->dev, "Failed to register IRQ handler!\n");
+}
+
+static void psp_irq_mgr_fini(struct amdgpu_psp_irq_mgr *mgr)
+{
+	xa_destroy(&mgr->irq_bh_handlers);
+}
+
+/**
+ * amdgpu_psp_irq_mgr_register() - register PSP interrupt handlers by event id
+ * @mgr: PSP interrupt manager
+ * @handlers: per-event handlers, or NULL
+ * @count: number of @handlers
+ * @default_handler: fallback for unregistered event ids, or NULL
+ *
+ * Handlers must be statically allocated and stay valid until psp_irq_mgr_fini().
+ *
+ * Return: 0 on success, negative error from xa_insert (e.g. duplicate event_id).
+ */
+int amdgpu_psp_irq_mgr_register(
+	struct amdgpu_psp_irq_mgr *mgr,
+	const struct amdgpu_psp_irq_handler *handlers, int count,
+	const struct amdgpu_psp_irq_handler *default_handler)
+{
+	int ret, i;
+
+	if (handlers) {
+		for (i = 0; i < count; i++) {
+			ret = xa_insert(&mgr->irq_bh_handlers,
+					(unsigned long)handlers[i].event_id,
+					(void *)&handlers[i], GFP_KERNEL);
+			if (ret)
+				dev_dbg(mgr->psp->adev->dev,
+					"PSP IRQ: handler already registered for event_id:%x\n",
+					handlers[i].event_id);
+		}
+	}
+
+	if (default_handler) {
+		ret = xa_insert(&mgr->irq_bh_handlers,
+				PSP_IRQ_DEFAULT_HANDLER_ID,
+				(void *)default_handler, GFP_KERNEL);
+		if (ret)
+			dev_dbg(mgr->psp->adev->dev,
+				"PSP IRQ: handler already registered for default handler");
+	}
+
+	return ret;
+}
+
 static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -559,7 +683,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Space for extended data in the tail of the cmd_buf allocation */
 	psp->cmd_ext_resp_mc_addr = psp->cmd_resp_buf_mc_addr + sizeof(struct psp_gfx_cmd_resp);
 	psp->cmd_ext_resp_mem = psp->cmd_resp_buf_mem + 1;
-
+	psp_irq_mgr_init(psp);
 	return 0;
 
 failed2:
@@ -576,6 +700,8 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct psp_context *psp = &adev->psp;
 
+	psp_irq_mgr_fini(&psp->irq_mgr);
+
 	psp_memory_training_fini(psp);
 
 	amdgpu_ucode_release(&psp->sos_fw);
@@ -3063,6 +3189,7 @@ static int psp_hw_start(struct psp_context *psp)
 		}
 	}
 
+	psp_irq_enable(psp);
 	ret = psp_ring_create(psp, PSP_RING_TYPE__KM);
 	if (ret) {
 		dev_err(adev->dev, "PSP create ring failed!\n");
@@ -3742,6 +3869,7 @@ static int psp_hw_fini(struct amdgpu_ip_block *ip_block)
 	psp_asd_terminate(psp);
 	psp_tmr_terminate(psp);
 
+	psp_irq_disable(psp);
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
 
 	return 0;
@@ -3801,7 +3929,7 @@ static int psp_suspend(struct amdgpu_ip_block *ip_block)
 		dev_err(adev->dev, "Failed to terminate tmr\n");
 		goto out;
 	}
-
+	psp_irq_disable(psp);
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
 	if (ret)
 		dev_err(adev->dev, "PSP ring stop failed\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e0ebce792021b..0aef9ee83bd0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -139,6 +139,8 @@ enum psp_reg_prog_id {
 #define PSP_WAITREG_CHANGED BIT(0) /* check if the value has changed */
 #define PSP_WAITREG_NOVERBOSE BIT(1) /* No error verbose */
 
+struct amdgpu_psp_irq_mgr;
+
 struct psp_funcs {
 	int (*init_microcode)(struct psp_context *psp);
 	int (*wait_for_bootloader)(struct psp_context *psp);
@@ -176,6 +178,8 @@ struct psp_funcs {
 				   enum psp_reg_prog_id id);
 	int (*get_fw_type)(struct amdgpu_firmware_info *ucode,
 			enum psp_gfx_fw_type *type);
+	int (*register_irq_handler)(struct amdgpu_psp_irq_mgr *mgr,
+				    struct amdgpu_irq_src *irq_src);
 };
 
 struct ta_funcs {
@@ -384,6 +388,37 @@ struct psp_ptl_perf_req {
 	uint32_t pref_format2;
 };
 
+/**
+ * typedef amdgpu_psp_irq_handler_fn - callback for a registered PSP event id
+ * @mgr: IRQ manager
+ * @entry: copy of the IH entry that triggered this event
+ */
+typedef void (*amdgpu_psp_irq_handler_fn)(struct amdgpu_psp_irq_mgr *mgr,
+					  u32 event_id,
+					  struct amdgpu_iv_entry *entry);
+
+/**
+ * struct amdgpu_psp_irq_handler - statically allocated handler node
+ *
+ * Callers define these statically; a single instance can be shared across
+ * multiple devices.  Indexed in &amdgpu_psp_irq_mgr.irq_bh_handlers by @event_id.
+ */
+struct amdgpu_psp_irq_handler {
+	u32				event_id;
+	amdgpu_psp_irq_handler_fn	callback;
+};
+
+/**
+ * struct amdgpu_psp_irq_mgr - deferred dispatch for PSP-driven IH events
+ *
+ * The xarray's own lock serializes handler lookup against registration.
+ */
+struct amdgpu_psp_irq_mgr {
+	struct psp_context		*psp;
+	struct amdgpu_irq_src		irq_src;
+	struct xarray			irq_bh_handlers;
+};
+
 struct psp_context {
 	struct amdgpu_device		*adev;
 	struct psp_ring			km_ring;
@@ -474,6 +509,7 @@ struct psp_context {
 	char				*vbflash_tmp_buf;
 	size_t				vbflash_image_size;
 	bool				vbflash_done;
+	struct amdgpu_psp_irq_mgr	irq_mgr;
 #if defined(CONFIG_DEBUG_FS)
 	struct spirom_bo *spirom_dump_trip;
 #endif
@@ -663,4 +699,11 @@ int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 int psp_set_mmhub_eco_sec_level(struct amdgpu_device *adev);
 int psp_init_rl_microcode(struct psp_context *psp, const char *chip_name);
 
+void amdgpu_psp_irq_mgr_dispatch(struct amdgpu_psp_irq_mgr *mgr,
+				 struct amdgpu_iv_entry *entry);
+int amdgpu_psp_irq_mgr_register(
+	struct amdgpu_psp_irq_mgr *mgr,
+	const struct amdgpu_psp_irq_handler *handlers, int count,
+	const struct amdgpu_psp_irq_handler *default_handler);
+
 #endif
-- 
2.55.0

