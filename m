Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818C2C5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A6110F377;
	Fri, 21 Aug 2026 16:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xb7cS+sU";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB9A10F373
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbTc5JDGRyRYSwYxYTX5vecirxJod7SXWVeVxauqBgMoDM+V90gDH64stUJC24ViAysrzVsYwxZoLjJHKyi72Q+p1VJNCyxxdiDvZmpO154seaxHO6LVgs3TiTFydn/ttdNK+IPZlGfoAGSlH00+pWMl5EA3suiG1rbSPbaojt8lab6KWKL0qA4tg9os+a+zZgyYBiBD4x1h9t0Pdfxno4RPRnTcic27RoSR89KMDrqy0JUvAnXG7KN3dZel/FJqi/3qLo2mjvPWOSAxSBUEuw/MfAEbGMIS+S4uvG5XCQI9nPxVA4gKqKxRqFswIb14ePk0gLzdPT5Vsan5yEYytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSkGu2S0AFnFz3g7leuJVrXbGZFICt4PxfDbwYcnFm0=;
 b=j8Oeqxzlr3TrzuNcOKrQzvegbA34j+O7j1oTJ0IL96Ie/eQaDlgOB7DpX3yHvMkSNKQb3DpZFn8kOVFddnMdFIiWtH+iJhIqTVBC1a85B0oxtcJpQ7ozIrA9d85IosSNIwuAUU0IXk480cJBdH0nIigGlBzIXM/LvW1Y0TMEhb1CMWWLWOoTmd2ro4C9Hd7R6Be3Kf8j6RE1b7Ov5BSHxkr8/oRQpFYKSw7F3u6LBhkRIdAAcVzPC3BFv6cc77FmkKRb6USYG9wWhPqcWXtQG62kcFhLMBfwA+GMFiS7w5XbESGCPma+ji5G/2bdT2ud89pIWuwg05+/A+mCHccRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSkGu2S0AFnFz3g7leuJVrXbGZFICt4PxfDbwYcnFm0=;
 b=xb7cS+sUaz7J/kWFlH9wb6Jyc3JCQlpyUs2wZttN8RnJ0L4LMeG9orpRdpG830J8yXBbCkSycUvj4iYRzodY9UMZatOSdabFL4zRtIpN/PZS7+Ai+m8SAbI5n/rcUOn67zeMuu2GqyeLptYDpf7SYy/Obs9BpGFjGetbZHWffsw=
Received: from SA1P222CA0102.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::10)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:12:57 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::75) by SA1P222CA0102.outlook.office365.com
 (2603:10b6:806:35e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:12:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:12:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:12:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:12:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add PSP v15.0.8 interrupt handler
Date: Fri, 21 Aug 2026 12:12:31 -0400
Message-ID: <20260821161232.753638-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161232.753638-1-alexander.deucher@amd.com>
References: <20260821161232.753638-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: c72f79e8-4626-478a-3b38-08deff9f10af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j8vhWLoZuWyLd2jZGHuPl9ppUlR7UD0ptWj7W4S/4tRsqAWqBmRdDcTOMrOFPzP3dG302yOGU4G3wqajkdJ8Oopxlvd09zcYVAoplb5HgdNBdY4rJzpUJwkECmkT0x3vxlyNfPtS3Kzs7fIIlof1dwhW+B5CZouFDka8ZhdYcKdOLM2f1bn5QjX1lqK1svQaE1Z72gtoBETJz4xdFbdCxTBvLR4LKLv8XzGiFQHyzPNcPbPpGunlIYwAWTaQzUBST1J84m3DqP45CG5T/io3enJPVk6oX3hGo7Eg+KvzMExWD/3SBJ+/sPB24h3U0GiCsVO9kstQDKUbvcF6SSqEXoRAMHCvhXdYOGkjaE0bi5H6H9zovndzDPk6bo5jIVxrWA9KQ7bV27QPI6JFU1MEZwYV3eGENQTJ1WirJ8V253++9PGfiavalD28lFA/PZMe0CmrquvtCstbuiQ/QJ1gueZv179AQNdFXv48tUP8vCu9zFvCxmBxjw+um8tCU7cK4OZoieG4D/GAAlRrOyQM7aL3binp46ejccOdQ7vOqZj+Icwt2ce0viY/aHHNpEzSZlqsiKDc0a9jvVsiSDGt0s2XPX6da9CyevdKd6h2WoK99q5oMc/vCJeKeuCa8dLbCQxY2KcGDlc6zPL2hisP0G1tnhRDuU16/+uilzfogXzR9rUOYfbg4f2loGl5ezertNYMD6w6gGotokdh42NaQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hfiWNjtK6GLKOzr97w7oY3iUbcRcVi1OoF616GwpOXSCS2uv5KRWt3gqK4Ou+KW3458g6tYH1TpdHbHBosfpD8S+AmF1tYZh6EsWtqdTyKc3PkccfxMbT7BSNzC3cdWewcxtjJ70AL0tn0b8yL+NVKG5wrPFBRmi461XGNRBf9lTiBugG3f9CrVoX5NebvEECRWop1oTnE0DfW0Xg0dXWPFeF7Sj7xKWpcFdUqVr3NGeQZ60lghf4gmcPURYIvIk+Dx4jiI2KiTDMInOtSgRuFftYdxOzMd8yQ96xjLfHc5AFfsr1yTS3wseVjva7qLs3rxN+xglJbng54Moa+7OJeSX8LDv53q6WaOsq8yd91MbMvftiUxlWfVJTIIUhXYSo69fYXGK98KDs/tOCyio7zs5JrNcELJ4wkj9ZrMgGd/TGHOzbP7q1CVGvMxMVi6e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:12:57.2132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72f79e8-4626-478a-3b38-08deff9f10af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116
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

Register and add interrupt handler in PSP v15.0.8.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c     | 13 +++-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c | 90 ++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index b51dacf9e1266..6265ee4b0ff1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -420,6 +420,9 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 	if (adev->irq.ih_soft.ring_size)
 		adev->irq.ih_soft.enabled = true;
 
+	if (adev->irq.ih_psp.ring_size)
+		adev->irq.ih_psp.enabled = true;
+
 	return 0;
 }
 
@@ -627,6 +630,10 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_psp, IH_PSP_RING_SIZE, true);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_init(adev);
 
 	return r;
@@ -655,7 +662,11 @@ static int ih_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int ih_v7_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
-	ih_v7_0_irq_disable(ip_block->adev);
+	struct amdgpu_device *adev = ip_block->adev;
+
+	ih_v7_0_irq_disable(adev);
+
+	cancel_work_sync(&adev->irq.ih_psp_work);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
index f159efd585c32..85857b747bd46 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -357,6 +357,95 @@ static int psp_v15_0_8_get_fw_type(struct amdgpu_firmware_info *ucode,
 	return 0;
 }
 
+/* TBD: These should be in psp_gfx_if.h */
+#define IH_INTERRUPT_ID_TO_DRIVER 0xFF
+
+static int psp_v15_0_8_irq_process(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *source,
+				   struct amdgpu_iv_entry *entry)
+{
+	struct psp_context *psp = &adev->psp;
+	uint32_t data;
+
+	/* Replayed from the PSP soft ring: run the registered handler. */
+	if (entry->ih == &adev->irq.ih_psp) {
+		amdgpu_psp_irq_mgr_dispatch(&psp->irq_mgr, entry);
+		return 1;
+	}
+
+	/* ACK ASP interrupt */
+	if (!amdgpu_sriov_vf(adev)) {
+		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_IH_SW_INT_CTRL);
+		data = REG_SET_FIELD(data, MPASP_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_IH_SW_INT_CTRL, data);
+	}
+
+	dev_dbg(adev->dev,
+		"psp_v15_0_8_irq_process: ctxid[0] = %d, ctxid[1] = %d\n",
+		entry->src_data[0], entry->src_data[1]);
+
+	/* Delegate to the PSP soft ring for process-context handling. */
+	amdgpu_irq_psp_delegate(adev, entry, 8);
+
+	return 1;
+}
+
+static int psp_v15_0_8_set_irq_state(struct amdgpu_device *adev,
+				     struct amdgpu_irq_src *source,
+				     unsigned int type,
+				     enum amdgpu_interrupt_state state)
+{
+	uint32_t val = 0;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		val = RREG32_SOC15(MP0, 0, regMPASP_SMN_IH_SW_INT_CTRL);
+		val = REG_SET_FIELD(val, MPASP_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_IH_SW_INT_CTRL, val);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		val = RREG32_SOC15(MP0, 0, regMPASP_SMN_IH_SW_INT);
+		val = REG_SET_FIELD(val, MPASP_SMN_IH_SW_INT, ID, 0xFE);
+		val = REG_SET_FIELD(val, MPASP_SMN_IH_SW_INT, VALID, 0);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_IH_SW_INT, val);
+
+		val = RREG32_SOC15(MP0, 0, regMPASP_SMN_IH_SW_INT_CTRL);
+		val = REG_SET_FIELD(val, MPASP_SMN_IH_SW_INT_CTRL, INT_MASK, 0);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_IH_SW_INT_CTRL, val);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs psp_v15_0_8_irq_funcs = {
+	.set = psp_v15_0_8_set_irq_state,
+	.process = psp_v15_0_8_irq_process,
+};
+
+static int psp_v15_0_8_register_irq_handler(struct amdgpu_psp_irq_mgr *mgr,
+					    struct amdgpu_irq_src *irq_src)
+{
+	struct psp_context *psp = mgr->psp;
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	irq_src->num_types = 1;
+	irq_src->funcs = &psp_v15_0_8_irq_funcs;
+
+	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP0,
+				IH_INTERRUPT_ID_TO_DRIVER, irq_src);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct psp_funcs psp_v15_0_8_funcs = {
 	.init_microcode = psp_v15_0_8_init_microcode,
 	.ring_create = psp_v15_0_8_ring_create,
@@ -366,6 +455,7 @@ static const struct psp_funcs psp_v15_0_8_funcs = {
 	.ring_set_wptr = psp_v15_0_8_ring_set_wptr,
 	.get_fw_type = psp_v15_0_8_get_fw_type,
 	.get_ras_capability = psp_v15_0_8_get_ras_capability,
+	.register_irq_handler = psp_v15_0_8_register_irq_handler,
 };
 
 void psp_v15_0_8_set_psp_funcs(struct psp_context *psp)
-- 
2.55.0

