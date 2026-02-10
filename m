Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6455EA3F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF8610E600;
	Tue, 10 Feb 2026 21:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="leuOkYZ0";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593E810E607
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaHokNLmouwIFRjUnyzfcZJYXBRepqMTh1dmzsEmep+NfHY31yXRX/FK8XaxP3z/lcBaPO6EUAZgIn4Zx7q62ZiBSPPl1P9RPapIDf+5ohnHtDZdvl3QZizQKa2dccxeZWJW8HGeot4eCzZHgRBdnq7F9InabW5Gan5fPzYMSd79Oe9JuVqrLvq2zImbgB6ibBgg37LsJHfzgR+BtTJipkpKIefgfgyPeRQs8E3Vn6bSFoW00jNw0iUlQdQFROcaMQuud3GsJByGIE+WLGBJ/MVLeV2FUj0vKnTXIzyIyLSp4m8Mx3pRm7eLLL/+p5YewT4SOMB01CaRfAq/mvVSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EaKkoQFQIUNApxNJwa7icTSCgAef2b63OZP/ZoaWus=;
 b=iCcEE2HXP75SW3ndLFad451AQZ9igFk/qfFoF7a02ceN6TGqScalSN9whRKqCVdouhgL5hG6An6Ctd98hUy7i2OTSB1c352ecLQn5DAULlg1d7Ck7nZ/34FpOWFJzgpyAjBz6SLztaC/mtZ8ifteWv88+n8KFjYY6WfVIphbRtM/EIqubSz/pe8AZq6mHiNfPPLiMHrFLjuY8qcmv+U4UFhsjY1ROrbWP2Dvm9EpycrCHfl/ducZ1IGdsV/uEF6mnxDB0k0/SoYLSA7sBetakRJ4dReJDHGLjc5cIYUWUAqDHDX1STC+U8OkR8gSPmlwAkVoRS11fMseJiqBpIHcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EaKkoQFQIUNApxNJwa7icTSCgAef2b63OZP/ZoaWus=;
 b=leuOkYZ0lEfjOKJb5x81FIfMBm/G4LvwJEX4u0Y1k1JQAas2ow8sI8yHq3s7VwI/50kAm5byJqDutfM5+EUErOmFk0fpB/FdvXy87Ahb0ErMxj4clyQj628F0YPdBJc3rTV1DDxl6/KI7mlgOtgEl4TlQFUa17PxKEh3bM85TbU=
Received: from SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:48:12 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::4f) by SJ0PR05CA0098.outlook.office365.com
 (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.6 via Frontend Transport; Tue,
 10 Feb 2026 21:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:11 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:48:02 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 "Saleemkhan Jamadar" <saleemkhan.jamadar@amd.com>
Subject: [PATCH 14/14] drm/amdgpu/vcn: handle the suspend context interrupt
Date: Tue, 10 Feb 2026 16:47:29 -0500
Message-ID: <20260210214729.80964-15-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa20c7e-af44-45c7-bad5-08de68ee1661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2pbHr4tkhr9rsmWcHZas9LZLrN9HFYsCRWDuyfCjLnRmgVqiNpQ0lNXlJtUY?=
 =?us-ascii?Q?g40iymXAAX/DNWJSUwQgfdTNaOj569MZz3a3z3dBdODRgZm2JzTJ7uyQqG1a?=
 =?us-ascii?Q?wwjm7DhVklAmQn/jYCjnGKRylehrPim5mupp4NghaYdR+em5kir8+J6sS6js?=
 =?us-ascii?Q?vE95wZLfer2TtzK0l9C7QVL/n9lK9XZaPGPOO6OmvHnQudW9WT/e0ST2ljI9?=
 =?us-ascii?Q?1n8QUasfiVlMdaAd2A7Xg9S2sNRYofs/H6mWQLexMA7SQEIrqJizJzbwuEUL?=
 =?us-ascii?Q?kOlJO8hs1rFpK6UO7oSN2w0IzecsjHF2BIKYP70yfrLLnXKy0UHJhhHeg6zy?=
 =?us-ascii?Q?G4fb3/2DF5Kuk23BiqznRXO/dSDTSSaVoyTMYWf5nhE0LIYubHv4VVbl69FW?=
 =?us-ascii?Q?pGY3XlZxu1DfRjGBZDvqwpJQNpS3YUv9bKrbq4D0jjAIPkHVuKLFFmSmsIBN?=
 =?us-ascii?Q?dhg7ympFsqdTP00RIOIPXy/dWge7TDJOgjzetLbu4ob6O7J/PXH1PJaiaZmv?=
 =?us-ascii?Q?fkfRBMOkKuFselcMDrEPx0HGMqp4I3PuUHJhijHOBQuvWs9GCj3Q9segqwu1?=
 =?us-ascii?Q?/kqF1jSKcJ6HP2kDGKs4Cm0zGQBYowOBw0AJqisd1/iPnyz25WoXbK4asBGy?=
 =?us-ascii?Q?2KnRYeOxw//hZgoz3/8abBtdBDAfIk5WXrTv5hgx8GfSKYvhC/dYouKE8Tz7?=
 =?us-ascii?Q?lHBxB9JCtAn9Fwniw2yMxIIRftgzzQ2EHQJs7vBnNdStAcjQ1ii6qJUb+ds0?=
 =?us-ascii?Q?YbHUejWSmAbfzIhHSxm4NPEsiCIxY5Pbn8yWucE0kPpGS54vA/v1yLEgQraM?=
 =?us-ascii?Q?PBSHGIfWvM9JxaCVCiZA4v2fTQIAU2xMeBiyP4zwEST5l6DI/qZPaieIrdSc?=
 =?us-ascii?Q?69REhj/4u21Hv2B2pp9HwPrslqdG7vY3Iv+2fLVWGPvO/9OAsVoVaLPhP4zl?=
 =?us-ascii?Q?o232JCWbwCnqP1b3M8r5siiEz8fu9dAVJGqgYNvpIsm4qRydYq63u5qeOJYi?=
 =?us-ascii?Q?kTNy1mLiyex7z1k0FP97A6rop7n75MgLEDDmze0kDxCSH4vYAR0L/tfWbH5w?=
 =?us-ascii?Q?Rt/nQRqkNUiff7iek+jPU5iptGNezFPHMH36owlYADR4cvNkMtFwZ5OchmJo?=
 =?us-ascii?Q?HNVAPUe93hOpxCoRFT7fQ89NE/7nekEcX0tXOR3JIa+PA6xNHNQ0gWQupfBh?=
 =?us-ascii?Q?/sOxk95UQl2ZcmBcSmstflryH8t7vKZUi9OlNy7KVMxRibej/AfXn4IlO/Ym?=
 =?us-ascii?Q?8ggPkGU4wELbJ6RUaL6M6PQZTFWu8tVVKQyXoGje0xWFgRAgn4NqkclqYtpW?=
 =?us-ascii?Q?66jBT4oezHc7Fx926K+MGVOt2mJ4pU1uD4IJrabmhOgMD3MN8R8sF2RU00Xz?=
 =?us-ascii?Q?DLLKsDbx9RzKaA9UXdiIhIg+pEkffAN8LGF6TjYCL7g65mF+I973M4SOMomp?=
 =?us-ascii?Q?PeSZfn4e5a5FTTIP77FY4JE8Fj7+/0tAaEE2YUDZcvHDOSMyLH8Zle9XAX59?=
 =?us-ascii?Q?kx8JPetu2RNMd/3ZjAXBMn5Xoquz3kxywgBuoqxyH+M2WNdjPcFdtbCk4IfS?=
 =?us-ascii?Q?/LoLwyR0AuvCB1Pxq3kitsb40FX/OWUW7EZW4HZpEsZzzWBWc1Hg2GTUP5aL?=
 =?us-ascii?Q?v6Kv5pTg3KFeTBkzH/6Zs2PeTRgauTsMnw8UnZ141fjUW8Wmk03fFDU0+Tp2?=
 =?us-ascii?Q?5qokiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wGWFY6vjK0C85O1Hq1f7D2K1Pv6R+fWHdqPEsbG6l73L9hPYezshqC8aRLvDmy0VpRAaxt6AHIJtwi6sBioeqINnWsMGHHuzZ/IdnjQVOiC58IDUx6ufZtI3GWGZkosuzFhAWry+ozzuUuyLCfumBFiOZHm1qVzJn+R6PTj04tH0va2sHPDwLDKVPXObJHDIkvImTtxABk4WCpKy6dbO8IHKdWAzlgXW9JvFGK/5n3cY3wH126jX1bmd2kb3HPHsvXh+tFxJs9nBSDfb9pHqbvZcXqE3dSBb8khUyB5kyPxxWTW51aEMwDoGv715GIwg+QfSzRDisLlSXYDahdAHjJdYavcsulyf63GAovDoPAZzCTW7LpEsaiIrukFcptZ8XgC1z9q2Nle0+Tq4/pTn0gBP0WMpcBoM32fiKzpmw7qNFZk7uOL7qwTj/jWZbeCg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:11.9103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa20c7e-af44-45c7-bad5-08de68ee1661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

For suspend context UMSCH expects the ack from host(vcn).
Queue is suspended then interrupt is sent to driver which
acks back with register update.

note there isn't any resume context interrupt.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 50 ++++++++++++++++---
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h | 10 ++++
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index c246a932a4e6..541d8c694a65 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -197,6 +197,18 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
+		/* UMSCH SUSPEND  */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
+				VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT0, &adev->vcn.inst[i].irq);
+		if (r)
+			return r;
+
+		/* UMSCH RESUME */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
+				VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT1, &adev->vcn.inst[i].irq);
+		if (r)
+			return r;
+
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
 		if (amdgpu_sriov_vf(adev))
@@ -1668,6 +1680,7 @@ static int vcn_v4_0_5_process_interrupt(struct amdgpu_device *adev, struct amdgp
 		struct amdgpu_iv_entry *entry)
 {
 	u32 doorbell_offset = entry->src_data[0];
+	uint32_t reg_data = 0;
 	uint32_t ip_instance;
 
 	switch (entry->client_id) {
@@ -1685,16 +1698,37 @@ static int vcn_v4_0_5_process_interrupt(struct amdgpu_device *adev, struct amdgp
 	DRM_DEBUG("IH: VCN TRAP\n");
 
 	if (doorbell_offset) {
-		struct xarray *xa = &adev->userq_xa;
-		struct amdgpu_userq_fence_driver *fence_drv;
-		unsigned long flags;
+		switch (entry->src_id) {
+		case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
+			struct xarray *xa = &adev->userq_xa;
+			u32 doorbell_offset = entry->src_data[0];
+			struct amdgpu_userq_fence_driver *fence_drv;
+			unsigned long flags;
 
-		xa_lock_irqsave(xa, flags);
-		fence_drv = xa_load(xa, doorbell_offset);
-		if (fence_drv)
-			amdgpu_userq_fence_driver_process(fence_drv);
+			xa_lock_irqsave(xa, flags);
+			fence_drv = xa_load(xa, doorbell_offset);
+			if (fence_drv)
+				amdgpu_userq_fence_driver_process(fence_drv);
 
-		xa_unlock_irqrestore(xa, flags);
+			xa_unlock_irqrestore(xa, flags);
+			break;
+		case VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT0:
+			reg_data = RREG32_SOC15(VCN, ip_instance, regVCN_UMSCH_SYS_INT_ACK);
+			reg_data |= (VCN_UMSCH_SYS_INT_ACK__INT0_MASK <<
+						 VCN_UMSCH_SYS_INT_ACK__INT0__SHIFT); //INT0
+			WREG32_SOC15(VCN, ip_instance, regVCN_UMSCH_SYS_INT_ACK, reg_data);
+			break;
+		case VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT1:
+			reg_data = RREG32_SOC15(VCN, ip_instance, regVCN_UMSCH_SYS_INT_ACK);
+			reg_data |= (VCN_UMSCH_SYS_INT_ACK__INT1_MASK <<
+						 VCN_UMSCH_SYS_INT_ACK__INT1__SHIFT); //INT1
+			WREG32_SOC15(VCN, ip_instance, regVCN_UMSCH_SYS_INT_ACK, reg_data);
+			break;
+		default:
+			DRM_ERROR("Unhandled interrupt: %d %d\n", entry->src_id,
+				      entry->src_data[0]);
+			break;
+		}
 	} else {
 		switch (entry->src_id) {
 		case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h
index 03cfa0517df2..994bc39e8810 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h
@@ -41,4 +41,14 @@
 #define VCN_4_0__SRCID_UVD_POISON					160
 #define VCN_4_0__SRCID_DJPEG0_POISON					161
 #define VCN_4_0__SRCID_EJPEG0_POISON					162
+
+/* 0xa3  UMSCH FW to Host interrupt also Debug interrupt for MES register read illegal response*/
+#define VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT0		163
+#define VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT1		164  // 0xa4 UMSCH FW to Host interrupt
+#define VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT2		165  // 0xa5 UMSCH FW to Host interrupt
+#define VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT3		166  // 0xa6 UMSCH FW to Host interrupt
+#define VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT4		167  // 0xa7 UMSCH FW to Host interrupt
+#define VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT5		168  // 0xa8 UMSCH FW to Host interrupt
+#define VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT6		169  // 0xa9 UMSCH FW to Host interrupt
+#define VCN_4_0_0__SRCID__UVD_MESFW2DRV_INT7		170  // 0xaa UMSCH FW to Host interrupt
 #endif
-- 
2.43.0

