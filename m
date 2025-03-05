Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54589C28B25
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0343110E345;
	Wed,  5 Mar 2025 20:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CdmUUD/V";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED14810E331
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z01doMZfuN7NCMRLPl9jLJ1cVIk+OINIr7Wtbj8YooJMsu0cr2BztWxSAI0VNXWwpjKQCiHKpbGjlk/2GI9CoreqKpbHvv0UiQ8mqZrBCRPZhFKXdpI2t8zfVrY8Ig4B9gbYbLDNTHLi966+0hArLtq9xSsMzZW6nrWIBLqKRrU9mpAaVa5Fjw2b4AHpP+gNBsPCEUos+TUcM/81cCh72H6nIgvr7X1uxlKFsx9lNSyaYB806c4DGHp8HmH/GYqPd+1ATwyPPwV249j88qNzhxi6EA52wUcfv111jVbdgWvzwYCvJo5tXYEb6mi07BeQhu05cXmUFCuUmzldOWo/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRSBY4Y6Q5CT+kX2uSx1yUzKaz83cvOXX6OhKGe2TW4=;
 b=crAqt+c5ejrs8BQTBBEw5vf/23vze+wh3bQcUHAcTrMbU4TL8InHsXTEkld9MVqbpmArI24O22WeM1jt+DODUiIZ3NUvn5X3Yw+Vi4ycsJdpTTip7lhUb6O2ZRElM2qtOyHTGDt41yVzaAEmrHC/Qn1UAiY+tr/JVC6OwVbnMT/jel85AV4DjIpYvNNQ7fDZqOK7znoQDGZNQLW1y5WaufE3IJCIVWwM5EccC2YwROBqt5Sksw2JYv2mclWfxLG/la2QYCvFFMN0/zCwVUYCr2eGxrUv29qzNbp0oPopKPyBC449Dw7CV69di5FS26WYp5VJhlRbmbRScZE66HvA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRSBY4Y6Q5CT+kX2uSx1yUzKaz83cvOXX6OhKGe2TW4=;
 b=CdmUUD/V5j9umvoWqpiMa7ynOOiV6WsHy8lePFKMePs5uQrUdLA1I1RVB/FCSfYINJY6OTPFm8lvJUUuVStdX6JflztU29UZhNpsmG3MI27ZFHBbxEhUOUERekBWIz5VOgIqbRoJOBlUD+H1VwZVaaiDRGYsgAD4gd3CW5oIGrg=
Received: from BY3PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:217::19)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 20:47:40 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::23) by BY3PR04CA0014.outlook.office365.com
 (2603:10b6:a03:217::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 20:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
Date: Wed, 5 Mar 2025 15:47:14 -0500
Message-ID: <20250305204721.1213836-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 45826655-6281-4306-2773-08dd5c26f7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KZrRDxH40ea+KcYE/tD/112ohzvYDYFRdn1FW1a/BqYzftZDDRdmyamA1CTb?=
 =?us-ascii?Q?k6HZgKfzgpoiK9omH/SQbUqvedERu72KDlAAn+hstYjH4AsZO63U5jNWZV2b?=
 =?us-ascii?Q?/HTFrBw9IW1NEcs9xDaTKu4x/fOn7s4pWgiRCW/zvv3aSf1tTFs+rWdIFpds?=
 =?us-ascii?Q?KbPfRtptlzoLX3x6bMhuT7FihSaFluL23mz25ldwX/RJEYFKweyfkia27Gld?=
 =?us-ascii?Q?xVzRrkUksu49svYal3yXzNBdFJMw0JLe5YV0+lTX1NP3xQUj2kINC7094587?=
 =?us-ascii?Q?VGz8Yq92PR7ciznna9zW5N4joufHbOKon5BDrZh6pY1YUKqD+DBxiZXSA7Uz?=
 =?us-ascii?Q?AQsmhhKSmZzGIs6h5OrQTWjGVzE+F60ZIlFOxDVCY9X66pXYe5220rO+h7sR?=
 =?us-ascii?Q?RYd+tvPugrScFZPmtzW26IgwpqiluaIpAgqpVzkY8tVyY1Uk+LA2H4b0PX+G?=
 =?us-ascii?Q?X9MMFm2yMkxY3gNmLEvik1hu0wmBnZa5ih0G/l9PIkZzjVltI06jKlmqr98U?=
 =?us-ascii?Q?BjK4QgVJOREMa7JNrZGLfgj5/0Ab/OT81KeR1JXdKg07I3DbwDsuNbT3npUk?=
 =?us-ascii?Q?MSlfKVQ8sFb2ATzyj77TprFRVwYKQSMY3Mr2CxPGO0yPpxkBpqpzZKgNumBF?=
 =?us-ascii?Q?vSZcGe4mQ717tuV9kLzDdRT7cQF8I2D/NTwkvPni4BqaTLYxawPNgcAr+t6b?=
 =?us-ascii?Q?1eHDTKemQelR9jQAexI0ILtZnDHq9bKlJEUZgHFgmA/4rUIieNFVh/t/Ri+1?=
 =?us-ascii?Q?d4XOqtOyMuD+rXR2+LBBODc2KZSZEKyLW1dKyA6sUozrNxp5O95Layax2I+l?=
 =?us-ascii?Q?g2Ne66hQEgKrckc0hYmCtRbe61U10Qph1dBlfnxgRZUARnlu0rhP1XHtwRb4?=
 =?us-ascii?Q?cQWX5GB8qqFueVBsH1G25DW6BEASogcOejOXaVTcP41Yi6ZneqWeDwrK4V4e?=
 =?us-ascii?Q?Bacx8KNHfGTwNxCpIX+Gf6NweKYGFPf1sMyUwJxnKVYzca3n0VnhNziXQBtH?=
 =?us-ascii?Q?Dow1by/KkMYae+odGP5aHFvJVFmcdEwRk919c/FCFVCmBRE0L/NiabcnnB36?=
 =?us-ascii?Q?Gwq8jD+p07w0/Aepl6vvGTDcD6xNrkVVr1Voy9cttOHeNyl4pCus69NK63eY?=
 =?us-ascii?Q?vwd9DwVHCKHfNb9R4Lyvq9qA2/UeqADfXhXggtjQvkTIKzxzquafJsSkXkuP?=
 =?us-ascii?Q?yC+GZOltOD0p+4dtMED9Fb+ghrcVq5jkTb1iG2sMYX52VZ4OYJohQMs29ms9?=
 =?us-ascii?Q?iHkMblBk0SJlcFYI0kFX4jwH1oopNZjRJmRrZ9NSOieUPFQCGnXYVulEJIxV?=
 =?us-ascii?Q?Rpsw3BAAwNZ18fwaW6R0zvvMi4fiNBojlCVua33T2ikhcP9L6t7GB5iCG3aF?=
 =?us-ascii?Q?bRV6aSpb3bajMUeY7Wb5E7iSTVm1IrbnoN1iOabc6TPzUixQEJt1vYaqR6FB?=
 =?us-ascii?Q?7LfCgDOx3W7caeUJAiZIsuNOWbCPPAhYwaTAjLvTo9WGi9nf0ry0cH2NfWpq?=
 =?us-ascii?Q?s+1GCR1XSg0/iOw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:39.2040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45826655-6281-4306-2773-08dd5c26f7e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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

Move it to amdgpu_mes to align with the compute and
sdma hqd masks. No functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 +++------------
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ca076306adba4..afc2ce344df52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -144,6 +144,30 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
 	adev->mes.vmid_mask_gfxhub = 0xffffff00;
 
+	if (adev->gfx.num_gfx_rings) {
+		for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
+			/* use only 1st ME pipe */
+			if (i >= adev->gfx.me.num_pipe_per_me)
+				continue;
+			if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
+			    IP_VERSION(12, 0, 0))
+				/*
+				 * GFX V12 has only one GFX pipe, but 8 queues in it.
+				 * GFX pipe 0 queue 0 is being used by Kernel queue.
+				 * Set GFX pipe 0 queue 1-7 for MES scheduling
+				 * mask = 1111 1110b
+				 */
+				adev->mes.gfx_hqd_mask[i] = 0xFE;
+			else
+				/*
+				 * GFX pipe 0 queue 0 is being used by Kernel queue.
+				 * Set GFX pipe 0 queue 1 for MES scheduling
+				 * mask = 10b
+				 */
+				adev->mes.gfx_hqd_mask[i] = 0x2;
+		}
+	}
+
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a569d09a1a748..39b45d8b5f049 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -669,18 +669,6 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__MISC, api_status));
 }
 
-static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1 for MES scheduling
-	 * mask = 10b
-	 * GFX pipe 1 can't be used for MES due to HW limitation.
-	 */
-	pkt->gfx_hqd_mask[0] = 0x2;
-	pkt->gfx_hqd_mask[1] = 0;
-}
-
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -705,7 +693,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+	for (i = 0; i < MAX_GFX_PIPES; i++)
+		mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+			mes->gfx_hqd_mask[i];
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 96336652d14c5..519f054bec60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -694,17 +694,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX V12 has only one GFX pipe, but 8 queues in it.
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1-7 for MES scheduling
-	 * mask = 1111 1110b
-	 */
-	pkt->gfx_hqd_mask[0] = 0xFE;
-}
-
 static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 {
 	int i;
@@ -727,7 +716,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.48.1

