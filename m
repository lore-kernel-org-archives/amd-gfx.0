Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BE4C624D5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C48F10EAA9;
	Mon, 31 Aug 2026 18:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gudCcVBF";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3258510EA7A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnwzo38dwFKOa+ArzSgpmRyLWhN7zG/O4/Pa0OR5RaAUIDxiEtt0FRPMwxT4o+VuBtRCJ9r2dHNQATaJZw0qWto9wfrPO6YfPALrmNXhX/VhQvDdb1WrcJH6md2vTVP/dLaNa5+1zrhktUp73UZf+GAX7wy7xBuiXJh+dTpRo3fazD357uk+XFXnGYLp/0OQP4Bc3SH3IPiZQWHRs9rVm8Bf+iyGLdzjRuk1eTkptGwo4MeAg8QVxPoU5iajoH4rHLyKk15FWp3nMH50pBjtFI+/fonwNos6vfj4sn4kz+DxuaEvP4/leIM97CCvMcJEidogJki3nd22qYDXcrGq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn7RmuqNSjJeEwg+S1epqZe0psG8RngbgQEO2+s1BIM=;
 b=BwNdxFxpmBCuXCw7tRiaMWuw1GpJUm1oeHQP+64+Qq2lJBQ3UgI+bLzfjOF6kK6j5zF5Ns5JA4jzOQrWxfgdJTU3qT8ix9Qa9/b4NBvykuLQU9iBcg/5qVfiVBiDs/ttG4/T1H4HiJQ8A0fzOzc48QAQH0c7hvvLj+SUp+hHbqesia3EpnG7dXvtCF6cV/NuDT2ULynwOqbd2ZfSGXr6X6egeX78n9gNwMfI6dzdqTfNtD9sFTKxmdvHucgRiLE2OsEWoBg8GSEoehg+8/1BgIKXucK+v+HEWofQJ/7oC3cLuov3BuCZNj33Fz+jdb1XNrS695gpvzlK7fA5rpDpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn7RmuqNSjJeEwg+S1epqZe0psG8RngbgQEO2+s1BIM=;
 b=gudCcVBFip5VEhJwldYX9AGYc+lppg/rfertV8POoRdM0V+PWvAqxWbolVjF5NsMGOw682aTF7fpf63jXLvqgm6oFjYGFs38J2C6773+ERpAsKcejUl08DEpqk8a5bIQXKXdWUdqFN3dzAtJEJRi7hM74y88N/ywuF6uomrtvrc=
Received: from BL1PR13CA0090.namprd13.prod.outlook.com (2603:10b6:208:2b8::35)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:28 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::7) by BL1PR13CA0090.outlook.office365.com
 (2603:10b6:208:2b8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 18:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <philip.yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 84/95] drm/amdgpu: Fix GART and SDMA entity leak on vPod
 reconfiguration
Date: Mon, 31 Aug 2026 14:27:43 -0400
Message-ID: <20260831182754.1089811-85-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: df4998d8-ad6c-4a92-aae2-08df078dc5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1yxLbDSKm+2TDOUzx3f7KuIIVPkyl3opu1hwfifGv04jzeUurTQs7WU8GAAoYsdoP3cbebQQFGDR4mLNSEbL4g9ZxNhczJQXj0rxSnY73oArx/XTV4qzSKTT6WC4MTUlKSfJOAKZaFBo37MTQJIiulLHTvYQ79K8CyFIoCcxJRImPBbCvL7RvLX01BtbWcvBgURyDtk/leZxX6Nydlh22gdlFzJFIJrRKLrTpF5Um7oqiOSnWVc5rv1h9smc+AJCCKFqI1BPbhczWmSF2D+MOweQgjLQDCdFPVoFhtzMl6Gf18nTKXAUVML2xqp9hP450IpuDkNy5k8ejHz4wbTDmEGSQAZvBGbhP5YIToG19KeM7nmgR6IMMShtEe4DiLESYvROyYv6qlPDjdr5gWFVrLUqEs49xNbM5AJO+SCA0grv1mCaEOP9X2SX2tMarqDbExR3EvR0jDogwT0ckwqrnbCoSBI6py+kqJC1Ig4GLNZzB/VfIc3LKsWDB7pLVN+wFOkUD+e2OARNCewbmqwja2ZlWwmp6JWx8bFdU2bti0zsAblot5W8ZMzgS1kPKeCbZo7C7zMnA+osZOiSi/JyCFD7WA/EIY5I5BEVe8l/H6kwLqNbee3a5RVxscEdJaER/IRpK6xo4+jY3GUCNjAyzGE3iCEEg3voo4MBnFsjK8zvEem3G6z/DS9JmjesejWEsDu2Xzbec0viwwb0s8FZzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LrXcKTnPLk535903hMc9Mt7R5odMibJXZjhh2kI3V1l1RGKIMClQP4OWatD2HPJeaVwqcSIg34A1CRLhlX7mivOgv5uDZw2AcqVtcYy+yx0Mj6R209oZ1c39nCmwzVMKaGGmEoahNAy0z2+A3QT6m6ddpC/g16PrEkYHZA7ifopKKT3BLnPMtD1z4wE+/z4fnjI+ovhZflawuTFMnISKQyWpFzCFHNpmBL4sTM0MVtl7RbLAvr5N3XtmT7X8eIW+Ry5AuPftrXbwmm8VI3hcUfYIxOIWKNKagnv57jXcSR5T3nojc3Wx0Te5Fj+dvIpSjsd7YsopVVNfeHJqpzPyy4NuqHlYJfCAYECNCBIrPAWdOEramTagvANFkyUOfZYNBTR27ZcMlvOVlb56X7SPJ022HDXnfwDIxb7iHZ7xbsYA30UH58TfElq/En3gKe+r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:20.1401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4998d8-ad6c-4a92-aae2-08df078dc5e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

From: Mukul Joshi <mukul.joshi@amd.com>

remote->active_accel_bits aliased info->vpod.active_accel_bits, which
psp_ual_query_info() refreshes on every commit. Teardown
(peer_remote_fini / gart unmap) then iterated the new set instead of the
one sw_init mapped, orphaning drm_mm nodes in the shared GTT manager.
Make active_accel_bits an owned snapshot copied at sw_init time. Drop the
now-redundant not-initialised guard in metadata_npa_unmapping(), since the
earlier remote->ring_bo NULL-check already covers that case.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 73aa9e98202b5..2d9317db32027 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3887,8 +3887,14 @@ struct amdgpu_ualink_remote {
 	/* address alias mode alloc npa address for shared wb */
 	struct drm_mm_node		rptr_mm_node;
 
-	/* active accelator id bitmap of the pod */
-	unsigned long			*active_accel_bits;
+	/*
+	 * Owned snapshot of the vPod's active accelerator bitmap, taken at
+	 * sw_init time. Must NOT alias info->vpod.active_accel_bits, which
+	 * psp_ual_query_info() refreshes on every commit: aliasing it would let
+	 * teardown unmap a different set than setup mapped, leaking drm_mm nodes
+	 * in the shared GTT manager.
+	 */
+	DECLARE_BITMAP(active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
 	u32				num_accel;
 
 	/* remote GPUs ring buffer, read, write pointer local copy and gart mapping */
@@ -4266,8 +4272,6 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 
 	if (!remote->ring_bo)
 		return;
-	if (!remote->active_accel_bits)
-		return;
 
 	rb_size = AMDGPU_UALINK_RB_SIZE;
 	rb_size_in_pages = rb_size >> AMDGPU_GPU_PAGE_SHIFT;
@@ -4686,7 +4690,9 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	u32 status, accel_id;
 	int r;
 
-	remote->active_accel_bits = adev->ualink.info->vpod.active_accel_bits;
+	bitmap_copy(remote->active_accel_bits,
+		    adev->ualink.info->vpod.active_accel_bits,
+		    AMDGPU_UALINK_ACCEL_MAX);
 	dev_dbg(adev->dev, "%d active accelerators config in vpod\n",
 		bitmap_weight(remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX));
 
-- 
2.55.0

