Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5392BF34C65
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 16:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65E710E4D1;
	Mon, 13 Apr 2026 16:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x0KqX9Ez";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012009.outbound.protection.outlook.com
 [40.107.200.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFA910E4D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 16:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOUD/cTh4t9exoCRzyJ7gKLyCF36fqb4PxtoDcM7GRPOO2IXJfe9FQKj1o+KByOd9NmcyDhRFC1yD/4fSzlXGhEKS9PcTZ3A7DTsHGteDOagWi23CKjVp9n9X4yrSg6+wPJ+eZaiRu4PF1fOS9B01CzGdNfpX3PTbSzq0QATdPGjf+g7l4Tcg/48kyivDucCBPQ+r0QsLZ46zOAspnv11vwXh8qr1ypVGEaP/9htEA5F6rg+ekRdZ+58K0W8WeJLWL8sEesZE9sM4L5L2vXB6P6KcHBUtOALvC7/mYAopdS/X7K9eMWLbv/kUG1GQHGxAQtDeA+QiPlF0EJJuNHFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XypjLfh3HiLT8NcUj6KH5/rkxyOzbNGfNwippZtB938=;
 b=RrxSPQ0euEZsVF/xcnp6B3p8V+eIjdCgmdc4IzvOwoVcvCdAeGW/F2gmXqYIYST1LUzlbQaUxCq8ej2aRJON8UGbiokGVsSRrJz3Z9hgtcFrDqayhnkP6/2sVMGNW4O+rDkdHqdGHYiMCcmhSQGK4eYL8kTb83f+5cfmzt9FRIerGTBdcJ2K9hGV9OwVDAbKLGl6spgy3p0jqmPh0dIhOcm1OiQ2cuK0TWwblMudtwGQnx66rNOlovBhBcJvuLpX6pL2IcwrLVkIuOzl+exy2ZDj7nzRJQ5iJ/ugBkREDXRi+AiKBFl2PEi1UejJfsvkrNJBAWJw3nuq6N7yHiSzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XypjLfh3HiLT8NcUj6KH5/rkxyOzbNGfNwippZtB938=;
 b=x0KqX9EzR72y7d96Y44JZN/Z7iyj+nTzLePFeJJgv8kyXoven5nXiCXWyXm0LRoQ+gWLNeGmuC0x6IGT5JVO91N4GbQ8T6UV8lj8+yy+0Zy+2zDMDHdIV+VmJwPy8H4EwsZej02IbFAtdt78Gw+w1VcxtMnjY2Hz9aMG1sbpu50=
Received: from BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 16:16:26 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::f7) by BLAPR03CA0053.outlook.office365.com
 (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Mon,
 13 Apr 2026 16:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 16:16:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 11:16:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 11:16:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 11:16:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable gpu recovery on SI dGPUs
Date: Mon, 13 Apr 2026 12:16:12 -0400
Message-ID: <20260413161612.455669-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413161612.455669-1-alexander.deucher@amd.com>
References: <20260413161612.455669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cb86e5-756e-4318-a6f9-08de9978033e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: NxDuJtlmOVhSZill113h8OtFzR/cctOEyGSbyzO9Kycp15mdFXnit1WgH5CvPfKxvGGRQ2k+wL1Hsk9+nXSf4oOrUf0nqYg4mJXeY9SyPXLT1js1R/B3/TAzLWgXOCpjOMiO1vkI8grferjUpcL8Bfq6qwvtU2PsQpTrMn3MJs6d+e9fbKbvcCYWI1vgXumglf7Zx2Z/i4aZK+U5ewKM7Yam0QwmOj3LHdtRMKmzsdFZHmVmkhEtEKqOjnqxrHNQhsohwm4bM+OdTh8yXsB1egZ7IT5PE0Oj3OXtugC9xLplOqu7Nx/hIKwvh2OVwAo910vsFufXmgo/QkoTdKT3NNqORKZaQSNhb3PHpx9Fr0Ac/7Uq+3tEscMpGyhHnb6YVTxwFYdwkCSV5sLsA4pov75JHQsks5geBE7oJdswndKqP38nhUOFpDiVX+mxQc69nIvzOUbek9WNOt//kwaCAc4mk1q0sT9Mc+GyQwZZorJFUtFe2uxX3gn31bHzGrzPt7X4W23IUUXMOBuTmYSz5Bs2WMlwmEWhan9JNoqJ7oDg3OwRABVl5Vr6ifQmJStr7tuguQXfBzmuadtakz4vr1lALNIkOR/0RtSSBQ1vvgmU688N7jY/+XrmZabGsc7QGEtmI5CdxhSKuBTDhbg3Qkql+GA/kseEwZtPRBLSqMl+tXo7GKL1O0wnpA/T7BJHauF96y76CpJAu249Fr2CAV5n1I32Yg3pEQgxe7PShyccWLCW1GMI1aCFKIBfb4boCu+AYQhtl27HnIduYEs/iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3epUzyw63y9KnB8rqIJi69uAEGUb4nWuknd01HlXXEM4PX9eW/aSf4iHkdO7ETPOhmHPMnaciwFEABECKmVO9gNccRRBOzbhMZAv0mp3Gd8mJH0x4DvpvWD5PFM0oPRwPWW3SCvKKU0kk5ZePzHVLtmh+9z7E7dAe6xmPdM+ma5F7pN7LkpIejlNt5L3YJhHj0hH9JoFmY5YPzSxh9XRHlkGwnEZOGsHqzTmNBUS7DYYOk7UyzdAcp4Zsd7E2DHdrd2Fh9/lIoYCVlevXbPEOz/lUtD257rpIm7hCKZKV6Mz1kCUiP+sxD44vkQJLnGFxpYXmBVq6B8vact9PFLEbqYrCgvbCisbQ8JuClZCFH8TG+GO/LvMMsg09N7qOxkZzKjD8FckmCrOZ8ijUaL5UkLle20lPKyrlpoLPzSjKlOBccszhhc6fp+qe8rPn6Mh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 16:16:26.2298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cb86e5-756e-4318-a6f9-08de9978033e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

Uses PCI config reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c7b8fbbfba366..7364e8760d093 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4972,13 +4972,6 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 
 	if (amdgpu_gpu_recovery == -1) {
 		switch (adev->asic_type) {
-#ifdef CONFIG_DRM_AMDGPU_SI
-		case CHIP_VERDE:
-		case CHIP_TAHITI:
-		case CHIP_PITCAIRN:
-		case CHIP_OLAND:
-		case CHIP_HAINAN:
-#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 		case CHIP_KAVERI:
 		case CHIP_KABINI:
-- 
2.53.0

