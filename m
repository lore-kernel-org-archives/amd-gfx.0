Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87900C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 06:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2251E10E403;
	Thu,  9 May 2024 06:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GKkTqwbi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E516A10E403
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 06:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwipl1SivyFpV76s5bc0vUI2XAdaM7cC7iiHqMZR+Jr+LDOsw785b3ePI6SrYBVDb+W3ejhhU8fqwYlvbOfHLRDbjvvEtrmwKCgO/pyVBOsgrIxCwTjGTOWgIf722NBkRJrxFPocjECtRnJbelIm3piDmRPHuqJlYiDhWDQ0mH3pw6a/8box00AVQxMzmrQyD/0UdRjl/livN4pcdqWA34wo5KWSPWFAJkUJTZ7fj2BUIebrEL8SEezbF1SkrgskzSQwLGlmsVcgBtkSj1ZE0xFrYsqyZBYZjEwnLvDrIfgtgNh9qp+U5QotKbXaj8D6mo3yC2/0bvqcTd/t7OOWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfsNHzNCAaYTur98KqdVuIZoXPy7g+ArJFfROBAkiNw=;
 b=TYOMMCA9YEoCHdMyLORyxwEaOGguEGXqXSg0xBx2DEZkCxXJCUrXUFB/iamTA1Rk3KFnjbHtvm4wHLUFFGppWD7t6+PIVs7Vt067TDOY7URm5lIqyBdgzpv+7U6sGQiFZYMDNIe2mhpY7kQS4COo74HS+ghF8izhPw+zy2Zwl2j5CdMBASYWcMeMv4c4CNQ1+MA5qXNg1Y51gnIlAsR+Tl4UZ5I6BdFo8LGXc5Bi2yAEY1LaqzQN4XoCMn97aAPkg8Pn+D8sQP0HqYNvqSMK6vYPnheiVz72Kz0v8hzi9U+4iTLtsVCwfxSJ242lQh0tNNsPH5RGC27NEyAl5l3ufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfsNHzNCAaYTur98KqdVuIZoXPy7g+ArJFfROBAkiNw=;
 b=GKkTqwbiVAUah2Dcy8Mzo/3rRrxh7uyPVVB+jad3AFwFIbq8ardzjMw5BJat808GqBv+HBIOSTOPlqg8T07EN/NpcAE+8rclAil2McrPnJ1srd+rmTR277MKnyHmleIxXCEelCW7i0J77uwaQMvuZCqVMTLNoj0C0OeAFZriEDQ=
Received: from BN9PR03CA0202.namprd03.prod.outlook.com (2603:10b6:408:f9::27)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 06:47:55 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::76) by BN9PR03CA0202.outlook.office365.com
 (2603:10b6:408:f9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Thu, 9 May 2024 06:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 06:47:55 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 01:47:53 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <frank.min@amd.com>, <likun.gao@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes: fix mes12 to map legacy queue
Date: Thu, 9 May 2024 14:47:01 +0800
Message-ID: <20240509064701.965399-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: a5955970-742b-470c-28c9-08dc6ff3f494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WbbWUP2LfsPj/vaBxkLP1txC5r1NQrdKvoE5bgIzSDncqAqIL3C0/5exKsuk?=
 =?us-ascii?Q?wHiIFyo0N+dWO1T5C3k0FZ0nQSHaXjwzXasgiFfSpku+5f5WodK1bSuWLpNT?=
 =?us-ascii?Q?x1lyWpmFKdf3Z/egKN0CL2z8VuhsYUuCeWU29D9ILPUnSlsPkgNCTAWMwGls?=
 =?us-ascii?Q?4m8chGZ9Lve17zLXilkuWJiOD47vxpP0WNI0ZQQ9TpzNz2r9xmZvToiHSLU3?=
 =?us-ascii?Q?+cA80IRR4rRsf+heMBtg7SqJP7CelwT3zuNom5i6ZuL3MGyFWKH3ZSsybbW6?=
 =?us-ascii?Q?tUaLWJWjwj5ySEGfdetjlI1b7Ur7LyR12AM3qiLh0KlleGut2DQEc1vlzT42?=
 =?us-ascii?Q?PVlzBVFFdBJPdBK5akB/o4Ql8d4kndjAZvgyv9LV3VJBxHNIw1GrJPYG9dFh?=
 =?us-ascii?Q?ymccoDkrBFbaTN24h72MCcgKo3133Tbh1+jRzXP5tlO+08mjpFaL7004ChT1?=
 =?us-ascii?Q?zY/wPgrKmzCoHqfBcjKy9PbkY5cLs9BPd4VHNz3imjuxK7z9YTSY+sYsl+DD?=
 =?us-ascii?Q?/ndguGkecDzySE18zDbzDERl9j/HWWEmMkCI0653CYQtjitMWM1fopLZvSYv?=
 =?us-ascii?Q?xqUn2TJ1NRSLGl6+IIRdC/fJjQVeFtBGykPVPgKlpDlX71p1PAHgrCHT66SC?=
 =?us-ascii?Q?deQc8We+T02hcxQeX8hmcu6BC/2rmtyt1F3/zCUBomZ+tnvR05VXWktf5vD6?=
 =?us-ascii?Q?teMGIEfMD+3BMi6las1cHe5Jep3h2576k2+vv34ktq5ZDuOrLaWGInXy+ymy?=
 =?us-ascii?Q?nwGtk/dtUADrTlP41k+kcYShrSXAqc5GPzi6NTm6xepMsth5kYNTWxrDfRxo?=
 =?us-ascii?Q?vrd5Z+nDtYi6+38jfvlHQHmuo8VS3BbBJi+BiSqOBOkDgY+3Yd5QNQnS8rLQ?=
 =?us-ascii?Q?0CmGAYqCJ78BlIhVSqwhNWg2kb2MD/GcSSg5P1W/Yrazx9Nk+PC/c81k9vtu?=
 =?us-ascii?Q?m/oGu8OhpaLlKXm/uLz5bhy2Ew5751+h4fAwGTBbtU2TOIY/EuGTY4PZHBeU?=
 =?us-ascii?Q?YLGlNWQ8ve4DQ19c5nsK2HYxZt7eshpSqQ1siGH2MK1HvE2KW2kHomMFa39c?=
 =?us-ascii?Q?CQqDpURBJOodr+dnmTJlYPf4WctSYL+DFpOg4a0lz2r+WNQpl7HfjVZ7AYla?=
 =?us-ascii?Q?pA4riNNoVCtrF0OBW/phPZpzfA6q2iBn/UnSUyMDP9KElQeF3aekF1DnP+ID?=
 =?us-ascii?Q?/fPWiZ/biTEXLvR7ML6FRehTlG//5gqd8bTLL2bZMc+13Scvvqi2cw846XTJ?=
 =?us-ascii?Q?5COh4vtxzA+uCyUiC8YrHg4cj9jafSqAHZoLvjnT2eyF0/X0+A3o2XX6Fp4n?=
 =?us-ascii?Q?BFADlaCne+ye+ZawB7yTtGoYHisVCsv4n2hGjMMSUNms2/HoeWbkZ0nioGs6?=
 =?us-ascii?Q?wAdETDJKyIAnv/mN+VsfEAVnQ8SJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 06:47:55.0385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5955970-742b-470c-28c9-08dc6ff3f494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844
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

Adjust mes12 initialization sequence to fix mapping
legacy queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 71 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 10 ++--
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ca90d6b577c8..a2696c215899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -599,6 +599,44 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 	return set_resource_bit;
 }
 
+static int amdgpu_gfx_mes_enable_kcq(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	uint64_t queue_mask = ~0ULL;
+	int r, i, j;
+
+	amdgpu_device_flush_hdp(adev, NULL);
+
+	if (!adev->enable_uni_mes) {
+		spin_lock(&kiq->ring_lock);
+		r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->set_resources_size);
+		if (r) {
+			DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+			spin_unlock(&kiq->ring_lock);
+			return r;
+		}
+
+		kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
+		r = amdgpu_ring_test_helper(kiq_ring);
+		spin_unlock(&kiq->ring_lock);
+		if (r)
+			DRM_ERROR("KIQ failed to set resources\n");
+	}
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		j = i + xcc_id * adev->gfx.num_compute_rings;
+		r = amdgpu_mes_map_legacy_queue(adev,
+						&adev->gfx.compute_ring[j]);
+		if (r) {
+			DRM_ERROR("failed to map compute queue\n");
+			return r;
+		}
+	}
+
+	return 0;
+}
+
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
@@ -606,6 +644,9 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	uint64_t queue_mask = 0;
 	int r, i, j;
 
+	if (adev->enable_mes)
+		return amdgpu_gfx_mes_enable_kcq(adev, xcc_id);
+
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues || !kiq->pmf->kiq_set_resources)
 		return -EINVAL;
 
@@ -626,9 +667,6 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 
 	amdgpu_device_flush_hdp(adev, NULL);
 
-	if (adev->enable_mes)
-		queue_mask = ~0ULL;
-
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
 		 kiq_ring->queue);
 
@@ -643,13 +681,10 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	}
 
 	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
-
-	if (!adev->enable_mes) {
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			j = i + xcc_id * adev->gfx.num_compute_rings;
-			kiq->pmf->kiq_map_queues(kiq_ring,
-						 &adev->gfx.compute_ring[j]);
-		}
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		j = i + xcc_id * adev->gfx.num_compute_rings;
+		kiq->pmf->kiq_map_queues(kiq_ring,
+					 &adev->gfx.compute_ring[j]);
 	}
 
 	r = amdgpu_ring_test_helper(kiq_ring);
@@ -657,20 +692,6 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	if (r)
 		DRM_ERROR("KCQ enable failed\n");
 
-	if (adev->enable_mes || adev->enable_uni_mes) {
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			j = i + xcc_id * adev->gfx.num_compute_rings;
-			r = amdgpu_mes_map_legacy_queue(adev,
-					       &adev->gfx.compute_ring[j]);
-			if (r) {
-				DRM_ERROR("failed to map compute queue\n");
-				return r;
-			}
-		}
-
-		return 0;
-	}
-
 	return r;
 }
 
@@ -685,7 +706,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 
 	amdgpu_device_flush_hdp(adev, NULL);
 
-	if (adev->enable_mes || adev->enable_uni_mes) {
+	if (adev->enable_mes) {
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			j = i + xcc_id * adev->gfx.num_gfx_rings;
 			r = amdgpu_mes_map_legacy_queue(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 76db85157bf9..5519655fd70a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1357,6 +1357,10 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 	if (r)
 		goto failure;
 
+	r = mes_v12_0_hw_init(adev);
+	if (r)
+		goto failure;
+
 	return r;
 
 failure:
@@ -1381,7 +1385,7 @@ static int mes_v12_0_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->mes.ring.sched.ready)
-		return 0;
+		goto out;
 
 	if (!adev->enable_mes_kiq || adev->enable_uni_mes) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
@@ -1425,6 +1429,7 @@ static int mes_v12_0_hw_init(void *handle)
 		goto failure;
 	}
 
+out:
 	/*
 	 * Disable KIQ ring usage from the driver once MES is enabled.
 	 * MES uses KIQ ring exclusively so driver cannot access KIQ ring
@@ -1498,8 +1503,7 @@ static int mes_v12_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
-	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
-	    !adev->enable_uni_mes)
+	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend)
 		amdgpu_mes_self_test(adev);
 
 	return 0;
-- 
2.41.0

