Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC07C98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E433B10F338;
	Thu, 24 Sep 2026 07:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VhGPcG5d";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE2610F33C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9yHu3T4fp2kMaWvpuvt1uYfp+NnkOgQlkDt7nHvz+4TNw/JVqNq5St5EHpH4qwnlW5sSX+F4d27FNENQSaW0siZkE27+2f7B2rn14qdO4UDQ470bAyfUkMptlfZiqhHq0EMfJRDRfFdL+1Q0iI0Cwm+2zaeHdu9EdEI/SBtsoWx22FZcD4azmqIMukdllod9CT02x/iqtqnX7IrFjBgJckay8fmsSWOClYBzVsbTeYBIcKTUx34aRCiB4pgjnxuo147ysgeJEVmM8m+OZoKBk8rc5+P1OvjblXwddvZZL7KqY3bx3sJn33XTCE9q09WlYKCooia9ExwkADtISeFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAcJlBbXLcjfdeX5TQLOz4XiUxPDYLvWFl6j/8e7QNE=;
 b=Pk+lO6ztCe3EXZOogzwFBCqeOaxDYj62Ukj9UnykHssQmEZvFy/srdctKXLOEhb+57ZPvtK7CbkJlbTEWd/VGEh+spukIPQIV6AfbPtm0TpCI2CywkEYbcKQlQd3Khm23qchrcvush6wUu/8Sdg44f5jVMwIzFL+bxHTMnM4FxB/kd1d2h5yPWhf7eZn/L+NowmrPPOlNm65MUqqMLxRZiMczMjg6adAeKlVHvmetWPd31X4oHx9gIzi5bVoFKPYxoOZB5P2hwk1OiRIxzWzWwXR2juwQ2If12pnnr7DTFjZ6jp/OZJGZlnVqs3Lz54fJi37TBQ4zG15VFRj/qPANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAcJlBbXLcjfdeX5TQLOz4XiUxPDYLvWFl6j/8e7QNE=;
 b=VhGPcG5dkhRz3H/fq5LHOxwOo6NLxosgHxSg0wMBw64CJEPCnjOC+LeSOFRhALR/WZa6SSdjflDjo0CfhbCVDi/lksLYlnPaWGe/3AyVTHbfMn0SW1yCKYI+JJ0PseG2gZhScGjlI17Dc21y7rIecrn7b9rPS8/vRiawc20fCmA=
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by LVUPR12MB999136.namprd12.prod.outlook.com (2603:10b6:408:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:01:43 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::2e) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Thu,
 24 Sep 2026 07:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 07:01:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 02:01:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 02:01:40 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 24 Sep 2026 02:01:39 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>,
 <Lijo.Lazar@amd.com>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: fix VFI XCC addressing for gmc v12_1 VM
 invalidation
Date: Thu, 24 Sep 2026 15:01:39 +0800
Message-ID: <20260924070139.2150654-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|LVUPR12MB999136:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae2e433-0898-4f10-098e-08df1a09afea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 1IAWwYWIbmlfXDrA4midAVNHbF/1BOOyJizkxpZbZNi39OHLnkvUc7cdXLjHl61ZVXACKKlIeAoACIOdqXA4vzpJ+8TLO41ydswHORI+JKr8q8tEwbojcZiiF2Ld/Bqf8zar5AMIn0GBmLMeLpX3yuL0vJ8uRvVhFlfpwAcFcY+JWzDXKI9NE+yoTEK4LjbAioCrleyWFcwsHSgMoHaFLpeB3sAr1qXmTcZAGBvMeEeXarZlrz4MMPnl1i+2OAfm3yRxi/WhisEelFdOgyQML4n6wOkDXWGTQX/Ts/YwJu0e6lYj+jChiECZI/RJlljfp41IhQJ9tpF7QmDdg77Pz4AnkOxr2dfYTq5IXp1HhYZeZYWN5Ak6iknJAih43eYWK0xyJjvkG2H8K1+rVBA2se+0TDtWmK7cljdTUSKPRSZLjefUQRVM+E53TCR98ct98U3ga6X2QeDyig560q6sCzU4rVGW1PaQN81LxnyyWXoh4zr47MzcX9rI54g01MHQDjjPoWvvUiA7aqJ87Sulnz0OffvpgGsTdvAt0kowFy9xUSTFWo/ZD5HQBoUolpQ59uKCpze7STcSWp8KWQd0ZNczilkK4Ej49K84cPRl4DErkck1UT97eMngruQLAy1eeDUTDd0LOzzyusicv6+yOMgwBM7/xe7iQUESr/QwPdWRis+VG//QpnZKrRNJpELJTRJ8se6n67IJqSqq+P0NrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MVdzWLAOmffK12bcISH2uhZ1b4/Xfz13oJXER45noM12Ijy0+NIOvyVlm5pxQFnx4CB3bDqHFLrvKUhBMrX3rw6XnxLt8O9dElraNqDusugwvr4sNXGzmosBu5GeirjE2sYGgnY2WK1YWMSZLBslu5uUk6zAhXFaVamj8kJb2KSyGLhPWPpKY3FjdkzoAP+vF/V49izxgQkhN7r9ndORfpD8v0GUzkxLce2dc/MI9aKF0Y8Bzauo5wP3Ebg52z0BJLn4ZQnaJJZu5Rzy13/8TmYTA3vId6M4BqCir9fKc1BK4Riahdb/yeTJA5tkbOV4Q1wKtDlltIdmA6lPZxgNdovcZXY83uO7ERWWFaq5uPm45WGCSi5sDq2osmy/SI7YAXabeYynyHlnqR7TVg6PJTBERx0hWplu4hCyfEduU/pxXQQ60Mh6AlKmlKqmiKN/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:01:41.7210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae2e433-0898-4f10-098e-08df1a09afea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999136
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

The VM invalidation engine registers are always accessed with instance 0.
Under SR-IOV the instance is forwarded to RLCG-VFI as the target XCC, so
invalidating any GFXHUB other than the first one hits the registers of
XCC 0.

Pass the GFXHUB index as the register instance, and print the XCC ID in
the VFI access messages.

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  8 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 49 +++++++++++++++++++-----
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 73d9072f0c6c..faf544ed4171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1561,12 +1561,12 @@ static u32 amdgpu_virt_rlcg_vfi_reg_rw(struct amdgpu_device *adev, u32 offset, u
 	spin_unlock_irqrestore(&adev->virt.rlcg_reg_lock, flags);
 
 	if (is_err)
-		dev_err(adev->dev, "VFi: [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
-			grbm_cntl_data, grbm_idx_data,
+		dev_err(adev->dev, "VFi: xcc%u [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
+			xcc_id, grbm_cntl_data, grbm_idx_data,
 			addr, addr * 4, data, cmd);
 	else
-		dev_dbg(adev->dev, "VFi: [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
-			grbm_cntl_data, grbm_idx_data,
+		dev_dbg(adev->dev, "VFi: xcc%u [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
+			xcc_id, grbm_cntl_data, grbm_idx_data,
 			addr, addr * 4, data, cmd);
 
 	return data;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index cfc46f912d47..d12cdf23c836 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -292,17 +292,25 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	/* Use register 17 for GART */
 	const unsigned eng = 17;
 	unsigned int i;
-	unsigned char hub_ip = 0;
+	u32 inst;
 
-	hub_ip = (AMDGPU_IS_GFXHUB(vmhub)) ?
-		   GC_HWIP : MMHUB_HWIP;
+	inst = AMDGPU_IS_GFXHUB(vmhub) ? vmhub - AMDGPU_GFXHUB_START : 0;
 
 	spin_lock(&adev->gmc.invalidate_lock);
 
 	if (use_semaphore) {
 		for (i = 0; i < adev->usec_timeout; i++) {
 			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, hub_ip);
+			if (AMDGPU_IS_GFXHUB(vmhub))
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC,
+							     hub->vm_inv_eng0_sem +
+							     hub->eng_distance * eng,
+							     inst);
+			else
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB,
+							     hub->vm_inv_eng0_sem +
+							     hub->eng_distance * eng,
+							     inst);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -312,12 +320,27 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
+	if (AMDGPU_IS_GFXHUB(vmhub))
+		WREG32_SOC15_IP_NO_KIQ(GC,
+				       hub->vm_inv_eng0_req + hub->eng_distance * eng,
+				       inv_req, inst);
+	else
+		WREG32_SOC15_IP_NO_KIQ(MMHUB,
+				       hub->vm_inv_eng0_req + hub->eng_distance * eng,
+				       inv_req, inst);
 
 	/* Wait for ACK with a delay.*/
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
-				    hub->eng_distance * eng, hub_ip);
+		if (AMDGPU_IS_GFXHUB(vmhub))
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC,
+						     hub->vm_inv_eng0_ack +
+						     hub->eng_distance * eng,
+						     inst);
+		else
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB,
+						     hub->vm_inv_eng0_ack +
+						     hub->eng_distance * eng,
+						     inst);
 		tmp &= 1 << vmid;
 		if (tmp)
 			break;
@@ -325,8 +348,16 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 		udelay(1);
 	}
 
-	if (use_semaphore)
-		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0, hub_ip);
+	if (use_semaphore) {
+		if (AMDGPU_IS_GFXHUB(vmhub))
+			WREG32_SOC15_IP_NO_KIQ(GC,
+					       hub->vm_inv_eng0_sem + hub->eng_distance * eng,
+					       0, inst);
+		else
+			WREG32_SOC15_IP_NO_KIQ(MMHUB,
+					       hub->vm_inv_eng0_sem + hub->eng_distance * eng,
+					       0, inst);
+	}
 
 	/* Issue additional private vm invalidation to MMHUB */
 	if (!AMDGPU_IS_GFXHUB(vmhub) &&
-- 
2.34.1

