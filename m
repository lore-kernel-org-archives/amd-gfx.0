Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81962CD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 11:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D5810F0B5;
	Mon,  1 Apr 2024 11:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MzNAtV2E";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E24D10F0B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 11:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0t+5ldlmXvSds1G2+MoL0u5xvDfOtVG+klYypojlF/armKeWfANMwRe6PUEH8zUeG1nU3RH91LgXz+HmdpHvTbxKiIJq7OOkwBT7bsp9JjHUzvl8Oggvlx30mSitiLg/BsmyFoPe1GIPS3NqgJUxpr/ymZPRkjAFwRSYLdEJ0wi7IwaYQqlC+XON8jPhdlHU8/FWjGsQ3y0dksn9xp8YwXxq3xrzAKWxa20KoPmX22PFvSYCV2ptoaY6JHXesTD7HOU54baKX64ou+FekI2AeOxGj9ozQgrDSeEXiQkFA6q1VT3U13+vOzI4nJx1kVQR3mKCVdupTbPcm/h6njM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdLXv9/LSAVdmr8ygnNjZcJmZPGL07Yu3cWcBvi4y88=;
 b=TwAm+qQCPFG7Wy3+I9i8vWxLU6xnGZD45SSurWrH+ahV1QcFW5QeTaJXt2g0nH5wHdN0PUaKC2BoK+OJMfJi629B4bFZaO4OrjYLixw34wlbxJQS8dYAZkG0W3m7FptsG6G3HT4fw8AxrFEg17gabilTpKxlhrT1Kg8+FoaZytw99boTrso+PI/BPquukmnC9oJOPk9kHDicLMzs8W998QpMa6PV452O8zh6j7odKY+WZynummeDu3f7gnSrhXgmJEI37ocBh3nXvFCMlQfJeJ6UKBo54C1tvrgQCs4Hrvq4LT65sVKV5TTbXj5dJv+SyrFxforGsMxRS8fbOGB7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdLXv9/LSAVdmr8ygnNjZcJmZPGL07Yu3cWcBvi4y88=;
 b=MzNAtV2EmumXLpax7siPXbtWhqXOc23n+1HmcgBivYb1B4AlOEahxY6c5FYu3ZOoavnHgu3b9rcjN9k1MAL6bC1mfQt6WunreItM/IOgY9QljDodwVOP3kREKZJUn7FhDISDwIRla8VW6Gh2xceyEt0Rb1JpYxW6nWAUr0PJoN4=
Received: from MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49) by
 DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Mon, 1 Apr 2024 11:16:03 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::a6) by MW2PR16CA0036.outlook.office365.com
 (2603:10b6:907::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 11:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 11:16:02 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 06:15:24 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Kenneth Feng <Kenneth.Feng@amd.com>, Jack Xiao <Jack.Xiao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Process bif doorbell event
Date: Mon, 1 Apr 2024 19:15:10 +0800
Message-ID: <20240401111510.14573-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0ba747-ec35-4980-f59d-08dc523d1e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvJ9g8O7HO7UvCql4k4IaI9X6JoSYL0EtrajiIAb+CwSBQlh3nfvcjoFpyrtcl9ZQTgcqBKqeU5vmEa3U+7P52XM1fm4E7wM8K+8LL8Q2JJSR5Dgl6sJsFGCW4lOxsAqd3nIc8N3qJd4UreepCheMjCD/k0oRQhchv6shH2HanlStsQbElmaMWUeeflVk37f/yEHxsWuqt/0LggfGCDR6UvYyIJgXckr86maPN+sRLsK4r9aRa+MVSsPowDz8l0q7mdurTpRZ3QzpnHQh6F+19gritp1wN11eHcfdMsNXvusQiqdVOO4xYbka0QtmPRonFSEqgEdYPnYaGge/R/7wf7Hf0O6cvde+G+/o2lQ+Zm4i2Kwy6JoqZHwHgiY2SWKToiwSS7eBH6wDWrdk9r9Wyh0agIBQBMDQs13qVz0W5BpEeDM1AKC39d/BxyFMq6iQvQNem3ahT/RHtjRgmiy/fxvU/XDslqMz+v2El7J2e527VW27tp0on2p216Y8gkaoYbBHxTaTi01k3RnTs9Mza2MfQle2WMKZJgMYLwKx1xTj4PU2mFDqE9EF0IDwMzY3Fx8o1Qx44iLeDZQVthqD9t/KhyJptr4GYpY5YPMDuSYvCmz69Y09U2y8m9n2QtdryQ8jFKjqpv6P3GsZveCwJ6eBjR83OdaZjgklUj5b0Y64ZsGDH8xxrCb+GmADNElEUjJqnM51RwVeRlwwKSb+rI/UGWbigTRCUSAe5nmC54F5MXE94BLFt2inFA4Q2j5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 11:16:02.8697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0ba747-ec35-4980-f59d-08dc523d1e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216
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

When BACO exit is triggered by doorbell transaction,
firmware will config bif to issue msi interrupt to
indicate doorbell transaction. If bif ring is not
enabled in such case, driver needs to ack the interrupt
by clearing the interrupt status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 +
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c   | 56 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc21.c       | 14 +++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 7b8c03be1d9e..db341921cfc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -102,6 +102,7 @@ struct amdgpu_nbio_funcs {
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
 	u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
+	u32 (*init_bif_doorbell_event)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio {
@@ -111,6 +112,7 @@ struct amdgpu_nbio {
 	struct ras_common_if *ras_if;
 	const struct amdgpu_nbio_funcs *funcs;
 	struct amdgpu_nbio_ras  *ras;
+	struct amdgpu_irq_src bif_doorbell_irq;
 };
 
 int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 7f88a298ac5f..e5a331b6eee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -477,6 +477,61 @@ static void nbio_v4_3_program_aspm(struct amdgpu_device *adev)
 #endif
 }
 
+static int nbio_v4_3_set_bif_doorbell_irq_state(struct amdgpu_device *adev,
+						struct amdgpu_irq_src *src,
+						unsigned type,
+						enum amdgpu_interrupt_state state)
+{
+        /*let firmware to config bif doorbell irq state */
+        return 0;
+}
+
+static int nbio_v4_3_process_bif_doorbell_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	/* pmfw will config bif doorbell irq to host if baco exit
+	 * is triggered by doorbell transaction. In such case, driver
+	 * needs to clear the interrupt status */
+
+	uint32_t reg_data;
+
+	reg_data = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_RB_CNTL);
+
+	/* if bif ring is enabled, do nothing */
+	if (REG_GET_FIELD(reg_data, BIF_BX0_BIF_RB_CNTL, RB_ENABLE))
+		return 0;
+
+	/* write 1 to clear doorbell interrupt */
+	reg_data = RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+	if (REG_GET_FIELD(reg_data, BIF_BX0_BIF_DOORBELL_INT_CNTL, DOORBELL_INTERRUPT_STATUS)) {
+		reg_data = REG_SET_FIELD(reg_data,
+					 BIF_BX0_BIF_DOORBELL_INT_CNTL,
+					 DOORBELL_INTERRUPT_CLEAR, 1);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, reg_data);
+	}
+
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs nbio_v4_3_bif_doorbell_irq_funcs = {
+	.set = nbio_v4_3_set_bif_doorbell_irq_state,
+	.process = nbio_v4_3_process_bif_doorbell_irq,
+};
+
+static u32 nbio_v4_3_init_bif_doorbell_event(struct amdgpu_device *adev)
+{
+	u32 r;
+
+	adev->nbio.bif_doorbell_irq.funcs = &nbio_v4_3_bif_doorbell_irq_funcs;
+	adev->nbio.bif_doorbell_irq.num_types = 1;
+
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_BIF,
+			      NBIF_7_4__SRCID__DOORBELL_INTERRUPT,
+			      &adev->nbio.bif_doorbell_irq);
+	return r;
+}
+
 const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v4_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v4_3_get_hdp_flush_done_offset,
@@ -499,6 +554,7 @@ const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
 	.remap_hdp_registers = nbio_v4_3_remap_hdp_registers,
 	.get_rom_offset = nbio_v4_3_get_rom_offset,
 	.program_aspm = nbio_v4_3_program_aspm,
+	.init_bif_doorbell_event = nbio_v4_3_init_bif_doorbell_event,
 };
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index abe319b0f063..ee6d810589c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -792,6 +792,9 @@ static int soc21_common_late_init(void *handle)
 			 * nbio v4_3 only support fatal error hanlding
 			 * just enable the interrupt directly */
 			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+		if (adev->nbio.bif_doorbell_irq.funcs &&
+		    adev->nbio.funcs && adev->nbio.funcs->init_bif_doorbell_event)
+			amdgpu_irq_get(adev, &adev->nbio.bif_doorbell_irq, 0);
 	}
 
 	/* Enable selfring doorbell aperture late because doorbell BAR
@@ -806,8 +809,12 @@ static int soc21_common_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_add_irq_id(adev);
+	} else if (adev->nbio.funcs &&
+		   adev->nbio.funcs->init_bif_doorbell_event) {
+		adev->nbio.funcs->init_bif_doorbell_event(adev);
+	}
 
 	return 0;
 }
@@ -855,6 +862,11 @@ static int soc21_common_hw_fini(void *handle)
 		if (adev->nbio.ras &&
 		    adev->nbio.ras_err_event_athub_irq.funcs)
 			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+
+		if (adev->nbio.funcs &&
+		    adev->nbio.funcs->init_bif_doorbell_event &&
+		    adev->nbio.bif_doorbell_irq.funcs)
+			amdgpu_irq_put(adev, &adev->nbio.bif_doorbell_irq, 0);
 	}
 
 	return 0;
-- 
2.17.1

