Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCA3C61DBD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BCA10E87E;
	Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I+GzHvqx";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6357C10E5A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjjtH5JKEwYnCYNbGRdKp4gXVw+g0aqFIuX1PHW2JYvpAGre9m+boqDcHtSlrN03cdaL2nrE5hi1TwOCaCId+/NQSXTty5MPxOUOgwCxsLT/QwBsC/HMtBBuO7F3PIcAxRLsBgU/S39gGAb+l6vd+Tym6o3LUFPn2Odz0CeZzfjrh5MzJDEjIf5XK5nOd7RDpmAXE2BF27aNq6LxHMF5XVoIbeNPjeaj3esWuKn6J06887zVTcsfKAdOsfLkBYYq8F9y2O3t0XdzSIfkMOUPE6/fW6Ov+FdzntOQ3uAUJhsH4+PBxdtFtTu1ZIGu9PyAs5W5W4Yc/JZBPqCZ0hTFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1jDpVzs3+nh8raMoJYcVslHwK+aAwOwz3IOhW02mzA=;
 b=RKLs84zM4D9e+ahWraKZ8s8UQ2dnfAqHCqTB4R8bgvQIgeP4jVOR3n94kAOJvjrK7CfEgQw8QFKsDF0M7KFmFaTHCEjKqOpwx+fQvxqkfyzVe7W1L9i9U+2Zo8W5lKFX1zZQGjsQzG+Xg0BA+1RCjlhXFAnjl9UMsWniEj7oIwUBVLvTRmaywEB/3P5uTumztCCbaNjbHpTp9nHKpoMcIrwpOmaQdP2WxLtsj1JmAR63ekmdMpbaVcc3hFEp/+KbB7r/BwWoJ3GoChg6zvMsSQR8vpojX9dxyJfJ9/ideOFTDRqLXSP3BpLDoIQ6BNNEMUDDUzdeby1h6Gafz1Xf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1jDpVzs3+nh8raMoJYcVslHwK+aAwOwz3IOhW02mzA=;
 b=I+GzHvqxl+7pS9MnTXGtTfSzz6NptaSiTsexaciLBK6uLRZAPA/73s06ZwGMI+hOrR5zgloW16KFdnSf7CmRGc3Uosi9LBCKbaKUMlB0gO9+osP4oq+ZxVdNyou8szxkZQrbNkAJKjsH8LJWEwHJV0nex+9uF9DcI7ANKpWKLjw=
Received: from PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::15)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:17 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::3b) by PH0P220CA0006.outlook.office365.com
 (2603:10b6:510:d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/30] drm/amdgpu: plumb tlb inv method in
 amdgpu_gmc_flush_gpu_tlb_gart()
Date: Mon, 24 Aug 2026 18:13:39 -0400
Message-ID: <20260824221352.1793542-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a2b04b-6e1a-49d8-d5fa-08df022d08bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dxrm6PxhyNSylBOXdVCESoOxUdEw1UpMaG0meivhe9TaO2THf3ErKCKsN8b2RoaUgRj/J/GruCujdsh7b+ewyvQhhUFoZ6rYqKUkQzaXHIDlkHBDHGPAquSxukQy1fue3UpPYoUxVoqNcNuFIKujs62pC9LeT2cRPUDh91cyzPZZYvmHOK6848sYRSubuh97zZg7gZ6dsy44MG9fssoqjWUe4GdEnh8FRD0QHqS6JPgOE//CPm18EzPvjgg3sMwdUcWsn+WR8aPi4X3HOiXegosgyRO5u+V6MDS9bYn8q/4feep/5RPzfa+JnCgWGXF84ZRGZb3314RAt/5DC4H/6tFx8RYJGnBBifcCukIxY6z1SacsuzBSnH584eOJi1GwWGBNkb43Ycml7AwoIu2CcT/pquTaBPGUmCymmuwlmUxEQd2l59RuYSVVARdQ3tYt1ZTmyFBROku2X9bzj9NZWOzbJG+dVCefmWhUnWEI+nZp21xNBxXfnr1Pw9KjxN4Vo9cey/X65fLHC83hFRzIzn7CS3omBU7Zcl+st1YzffYK7yjfwLteKCdMRXQ7dgNKO0FAvbw+O22jLSt6bLX1EkXNOKRAICZsfbV5cChi0SHXdwf2MUzJvuvpowrhMLGbT6nWFS6bj9gUraRoI0xx2hPi2R+xIe56W92z+mnSCTEEOzTjiyvy+285TNAYehEwWn6+xMo+nEDdTdZR+6K0XA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rgeDOBNRqjFtpH8MUlvsedIEST3SGTSHfw7Ywd2+nWqWRpttBFovEYVtwsyA0BXJRXS4GX2mRQIKkoLulJ+pPc5Oh3hi7/C3cx+ncFKaDZgOHdfiJeLUWy3XztcWx8t3fWjh4UyxNGedNhl/eNm4sriTedo1LyEH5kAspwSHevIJ2Se8u6Rav+lsB06gaOjcBT4ayZPk8rNPGOYXvWINYi/rXEHIglfBvfLi3zmbCQYNMPAH+MJdvpdEq68xQB4RER4W9QT03XEvzD+GkwOowktKF6OJX/Qy5joVaJOvCEigekQi6D+j4+uAThCAYX611WvQFYCOf4GrNF1OgRxdWtiHvCzgshIWtr3kmhaImVNrjmGWbyoMedcH+W0rQgOugp243rifCDII65KY1l332hD8hc/ZeLDxJhNrRbEwVwMwJP2Nb67yLArCpqCY9KJY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:15.2669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a2b04b-6e1a-49d8-d5fa-08df022d08bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
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

Plumb the invalidation method into amdgpu_gmc_flush_gpu_tlb_gart().
Keep the current behavior.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 6af4ed2170b06..779f9b0974d2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -719,15 +719,25 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 {
 	struct amdgpu_ring *ring;
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	bool use_mmio;
 	struct dma_fence *fence;
 	struct amdgpu_job *job;
 	int r;
 
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
-	if (!hub->sdma_invalidation_workaround ||
-	    !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
-	    !ring->sched.ready) {
+	switch (adev->gmc.gart_inv_method) {
+	case AMDGPU_TLB_INV_METHOD_MMIO:
+	default:
+		use_mmio = !hub->sdma_invalidation_workaround;
+		break;
+	case AMDGPU_TLB_INV_METHOD_SDMA:
+		use_mmio = false;
+		break;
+	}
+
+	if (!adev->mman.buffer_funcs_enabled ||
+	    !adev->ib_pool_ready || !ring->sched.ready || use_mmio) {
 		/*
 		 * A GPU reset should flush all TLBs anyway, so no need to do
 		 * this while one is ongoing.
-- 
2.55.0

