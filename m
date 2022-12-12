Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F993C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 17:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC28310E214;
	Mon, 12 Dec 2022 17:11:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B2D10E214
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 17:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDkB5dLqukmViO0yWmYyvIKEP2j9dm6k6aJmN9K7X5abvSvTZQnLb2jfSlYE7ipKzEsrrfSqNAtOQbKJ75MLk08cqc+5/04QWrj/qP6L3+yhXZqTecFM1O71RpTYh0FlrCynDsmQGTYo5o3t/QmuLcKDj4VKZAhiZMwlDf4EfVDPAyAsxD0DQnvUIvQuCpj22f0uvCU/FNQxL1qJ0RrwhlpH7c10lxH+Og8JKGLjw/QE+NS8dZq4U6BJkSHo1Q7FIvioMcUAWZ+oNqK3pmjuM+X/eqtHFJvcQkYl5/2q78fXxm9K5zvWtm9gVPfsNaXya2GRofi5ZGpIigt3BWlfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4gbwWxTKqR5CcIaKGx9maBMk8jGjGDHs9Dli0iBQA8=;
 b=kwoKna2Ht1G5yZGtDQYMCt1DSIUu0vl+EvsfcOeUEd8xM+fHk3lX7h+uw2mduKkEtb2bUuE8cs2OPb9d7gsBfypmmqV9ymuYctDYaMoKh9WyNpBJcuToHLa/GepLh9z1w+JMQ+lz3COJLcHwlh4SGTqR0pSdIfkhbdt6h14AH8v43pvPxfmFis8L6cOkyekHeV/VO0kSF1klmhAAwanrq5EIvroWwgTSkxA9qRq7fI7wUWKJKrVfgOTUqeL5/2C9ab9FtexzFiklxKIGBKQ3ATlVM63F+8MnnmwazbpoxNzsGvjKav3ySlz7eTMwJ4fBX+MsYpwwP6eIGCpYfhLcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4gbwWxTKqR5CcIaKGx9maBMk8jGjGDHs9Dli0iBQA8=;
 b=qUzd6DXD5eJ2FoWoLKIF4BibPpSTvTgfEpoXHrWHBvexP3ZcCNesP4CyJUBQQ1PqgFsag0GsKOv9L4rSe41621EVhu3QojQu90rhAJajz0PMzRd9vJfkArV2BtjEMU4lEHKRBnEFyNhoNBfttoMhRtAR5N1h+F351i/ku24esLo=
Received: from DM6PR08CA0046.namprd08.prod.outlook.com (2603:10b6:5:1e0::20)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 17:11:21 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::6e) by DM6PR08CA0046.outlook.office365.com
 (2603:10b6:5:1e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 17:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 17:11:21 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 11:11:20 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Enable IH retry CAM on GFX9
Date: Mon, 12 Dec 2022 12:10:54 -0500
Message-ID: <20221212171055.999548-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ae1bac-1609-41b2-fd06-08dadc63e425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRh7aI7bo71VJZbXV07XJ0eCwpyXka0X2cQ5dPWmM1hIAF8h5iqD6SIo1qKxYcD4xl7JJIsfhonllO9m1/tV5Hw8AwINtMml8JdsuGKsNml7UP7yfvAsEHJK/m7bmwbfnL8BlXJRHdRGu+A5+643I2F+90smyIGgq/DkqtXzfhAmgTOofjo+MZ6i8uQaLdtV71ehYL7gqgnKbFlP2G03HLhFjAoDmuyEdrrnHziYqZbIxOL6d1pxV+Gu0uVy2NC4f8PR2Vd0pzzR8p6bclIJ/N+m/O7l689EjEzlQ9LwhANdkwxkjcI/DJGqn/N02Kp8g0kzE71oNmxfsBCbjffV3VQFadP5c2ItqT6WQFuTIyx7EhKOd1pEOvlRmxV+e5oOVjjLxaPdsiE2m5FDmHq4pnytNsQXBBQkClaMrmUiZQgGlluUThhQW2bbz3mjMYxQK1I5mfOplR3RoqMYpHkXYj7tTntdD5Iyjk838gDaohVDWcwZcDq146JuS81NSMFEbni4T+8bVAq0VfAbgzETFbFB7QlYHm64xE8tjvfI0aEx1qQ1JZHJm0BeMd4qTeCqm5+Qp69Z2gupongelBf3sa/YX9fcpOvZONe/Y96l6OiVpNrK9kGyd8My15OrVDlkeE7/UmK24kGPhQ1CxqFs/HM7LSIf6dsyymYTKUn4kB2uuhJbGa/1Zh90EWw8QVGFSMda0X9WfjEBl7AZZQ4Z+MCYUgQo/APjDGkuIV8lYTw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(478600001)(6666004)(186003)(26005)(82310400005)(7696005)(6916009)(316002)(40480700001)(5660300002)(1076003)(2906002)(54906003)(36756003)(70206006)(70586007)(36860700001)(4326008)(336012)(16526019)(2616005)(47076005)(8676002)(426003)(81166007)(8936002)(356005)(83380400001)(86362001)(44832011)(41300700001)(40460700003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 17:11:21.3133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ae1bac-1609-41b2-fd06-08dadc63e425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch enables the IH retry CAM on GFX9 series cards. This
retry filter is used to prevent sending lots of retry interrupts
in a short span of time and overflowing the IH ring buffer. This
will also help reduce CPU interrupt workload.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 51 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        | 46 ++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
 .../asic_reg/oss/osssys_4_2_0_offset.h        |  6 +++
 .../asic_reg/oss/osssys_4_2_0_sh_mask.h       | 13 +++++
 7 files changed, 75 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index e9f2c11ea416..be243adf3e65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -98,6 +98,8 @@ struct amdgpu_irq {
 	struct irq_domain		*domain; /* GPU irq controller domain */
 	unsigned			virq[AMDGPU_MAX_IRQ_SRC_ID];
 	uint32_t                        srbm_soft_reset;
+	u32                             retry_cam_doorbell_index;
+	bool                            retry_cam_enabled;
 };
 
 void amdgpu_irq_disable_all(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 08d6cf79fb15..e5ab84f3e072 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -537,32 +537,49 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	const char *mmhub_cid;
 	const char *hub_name;
 	u64 addr;
+	uint32_t cam_index = 0;
+	int ret;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
 	if (retry_fault) {
-		/* Returning 1 here also prevents sending the IV to the KFD */
+		if (adev->irq.retry_cam_enabled) {
+			/* Delegate it to a different ring if the hardware hasn't
+			 * already done it.
+			 */
+			if (entry->ih == &adev->irq.ih) {
+				amdgpu_irq_delegate(adev, entry, 8);
+				return 1;
+			}
+
+			cam_index = entry->src_data[2] & 0x3ff;
 
-		/* Process it onyl if it's the first fault for this address */
-		if (entry->ih != &adev->irq.ih_soft &&
-		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
+			ret = amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault);
+			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
+			if (ret)
+				return 1;
+		} else {
+			/* Process it onyl if it's the first fault for this address */
+			if (entry->ih != &adev->irq.ih_soft &&
+			    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
 					     entry->timestamp))
-			return 1;
+				return 1;
 
-		/* Delegate it to a different ring if the hardware hasn't
-		 * already done it.
-		 */
-		if (entry->ih == &adev->irq.ih) {
-			amdgpu_irq_delegate(adev, entry, 8);
-			return 1;
-		}
+			/* Delegate it to a different ring if the hardware hasn't
+			 * already done it.
+			 */
+			if (entry->ih == &adev->irq.ih) {
+				amdgpu_irq_delegate(adev, entry, 8);
+				return 1;
+			}
 
-		/* Try to handle the recoverable page faults by filling page
-		 * tables
-		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
-			return 1;
+			/* Try to handle the recoverable page faults by filling page
+			 * tables
+			 */
+			if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
+				return 1;
+		}
 	}
 
 	if (!printk_ratelimit())
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 19455a725939..685abf57ffdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -238,7 +238,7 @@ static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
 
 	if (use_doorbell) {
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 4);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 8);
 	} else
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 1706081d054d..ed41f96b251f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -251,36 +251,14 @@ static int vega20_ih_enable_ring(struct amdgpu_device *adev,
 	return 0;
 }
 
-/**
- * vega20_ih_reroute_ih - reroute VMC/UTCL2 ih to an ih ring
- *
- * @adev: amdgpu_device pointer
- *
- * Reroute VMC and UMC interrupts on primary ih ring to
- * ih ring 1 so they won't lose when bunches of page faults
- * interrupts overwhelms the interrupt handler(VEGA20)
- */
-static void vega20_ih_reroute_ih(struct amdgpu_device *adev)
+static uint32_t vega20_setup_retry_doorbell(u32 doorbell_index)
 {
-	uint32_t tmp;
+	u32 val = 0;
 
-	/* vega20 ih reroute will go through psp this
-	 * function is used for newer asics starting arcturus
-	 */
-	if (adev->ip_versions[OSSSYS_HWIP][0] >= IP_VERSION(4, 2, 1)) {
-		/* Reroute to IH ring 1 for VMC */
-		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x12);
-		tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
-		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
-		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
-		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
-
-		/* Reroute IH ring 1 for UTCL2 */
-		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x1B);
-		tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
-		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
-		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
-	}
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET, doorbell_index);
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
+
+	return val;
 }
 
 /**
@@ -332,8 +310,6 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < ARRAY_SIZE(ih); i++) {
 		if (ih[i]->ring_size) {
-			if (i == 1)
-				vega20_ih_reroute_ih(adev);
 			ret = vega20_ih_enable_ring(adev, ih[i]);
 			if (ret)
 				return ret;
@@ -346,6 +322,16 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
+	/* Enable IH Retry CAM */
+	WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
+
+	/* Allocate the doorbell for IH Retry CAM */
+	adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 3) << 1;
+	WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RETRY_CAM,
+		vega20_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
+
+	adev->irq.retry_cam_enabled = true;
+
 	/* enable interrupts */
 	ret = vega20_ih_toggle_interrupts(adev, true);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2dc3b04064bd..747adad7e0d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2162,7 +2162,9 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
 
 		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
-						     &pdd->dev->adev->irq.ih1);
+				pdd->dev->adev->irq.retry_cam_enabled ?
+				&pdd->dev->adev->irq.ih_soft :
+				&pdd->dev->adev->irq.ih1);
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
 	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
index bd129266ebfd..a84a7cfaf71e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
@@ -135,6 +135,8 @@
 #define mmIH_RB_WPTR_ADDR_LO_BASE_IDX                                                                  0
 #define mmIH_DOORBELL_RPTR                                                                             0x0087
 #define mmIH_DOORBELL_RPTR_BASE_IDX                                                                    0
+#define mmIH_DOORBELL_RETRY_CAM                                                                        0x0088
+#define mmIH_DOORBELL_RETRY_CAM_BASE_IDX                                                               0
 #define mmIH_RB_CNTL_RING1                                                                             0x008c
 #define mmIH_RB_CNTL_RING1_BASE_IDX                                                                    0
 #define mmIH_RB_BASE_RING1                                                                             0x008d
@@ -159,6 +161,8 @@
 #define mmIH_RB_WPTR_RING2_BASE_IDX                                                                    0
 #define mmIH_DOORBELL_RPTR_RING2                                                                       0x009f
 #define mmIH_DOORBELL_RPTR_RING2_BASE_IDX                                                              0
+#define mmIH_RETRY_CAM_ACK                                                                             0x00a4
+#define mmIH_RETRY_CAM_ACK_BASE_IDX                                                                    0
 #define mmIH_VERSION                                                                                   0x00a5
 #define mmIH_VERSION_BASE_IDX                                                                          0
 #define mmIH_CNTL                                                                                      0x00c0
@@ -235,6 +239,8 @@
 #define mmIH_MMHUB_ERROR_BASE_IDX                                                                      0
 #define mmIH_MEM_POWER_CTRL                                                                            0x00e8
 #define mmIH_MEM_POWER_CTRL_BASE_IDX                                                                   0
+#define mmIH_RETRY_INT_CAM_CNTL                                                                        0x00e9
+#define mmIH_RETRY_INT_CAM_CNTL_BASE_IDX                                                               0
 #define mmIH_REGISTER_LAST_PART2                                                                       0x00ff
 #define mmIH_REGISTER_LAST_PART2_BASE_IDX                                                              0
 #define mmSEM_CLK_CTRL                                                                                 0x0100
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
index 3ea83ea9ce3a..a0cc5ecfa161 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
@@ -349,6 +349,19 @@
 #define IH_DOORBELL_RPTR_RING2__ENABLE__SHIFT                                                                 0x1c
 #define IH_DOORBELL_RPTR_RING2__OFFSET_MASK                                                                   0x03FFFFFFL
 #define IH_DOORBELL_RPTR_RING2__ENABLE_MASK                                                                   0x10000000L
+//IH_RETRY_INT_CAM_CNTL
+#define IH_RETRY_INT_CAM_CNTL__CAM_SIZE__SHIFT                                                                0x0
+#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_SKID_VALUE__SHIFT                                                0x8
+#define IH_RETRY_INT_CAM_CNTL__ENABLE__SHIFT                                                                  0x10
+#define IH_RETRY_INT_CAM_CNTL__MM_BACK_PRESSURE_ENABLE__SHIFT                                                 0x11
+#define IH_RETRY_INT_CAM_CNTL__GC_BACK_PRESSURE_ENABLE__SHIFT                                                 0x12
+#define IH_RETRY_INT_CAM_CNTL__PER_VF_ENTRY_SIZE__SHIFT                                                       0x14
+#define IH_RETRY_INT_CAM_CNTL__CAM_SIZE_MASK                                                                  0x0000001FL
+#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_SKID_VALUE_MASK                                                  0x00003F00L
+#define IH_RETRY_INT_CAM_CNTL__ENABLE_MASK                                                                    0x00010000L
+#define IH_RETRY_INT_CAM_CNTL__MM_BACK_PRESSURE_ENABLE_MASK                                                   0x00020000L
+#define IH_RETRY_INT_CAM_CNTL__GC_BACK_PRESSURE_ENABLE_MASK                                                   0x00040000L
+#define IH_RETRY_INT_CAM_CNTL__PER_VF_ENTRY_SIZE_MASK                                                         0x00300000L
 //IH_VERSION
 #define IH_VERSION__MINVER__SHIFT                                                                             0x0
 #define IH_VERSION__MAJVER__SHIFT                                                                             0x8
-- 
2.35.1

