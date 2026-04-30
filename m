Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D2ECD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413D410F3A5;
	Thu, 30 Apr 2026 16:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eZ7biX2o";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A8010F3A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ7M1CS70i+y+FB/DjXiJLczOhsCs8UZltN5ojlOqzI6QH4yV/MluiH4TIh+oJyTKsw3tBIJBWU+K2EYhbEOCLxdzOHTXeXJvKqv5vXIoySgOCWyA4LtuyFN5//GrlTsvzL07NW059BU9zskh0tE3yLIxU8JMixbEYzZHS/eysOcILXIZdLWMVx0EUFkdUlY8K9Sb4Sp7FB764x2LMmdmwCPNdYyDyr66J/v6Xsb4iiqQrTEnzvpJmVBQmv99O4d5sUampaZ8rqETaT5lvZ3XuH8EPGcfDAgTR+gkUeiawZmMkbEacFg9b2th6jJ0aRZ1IAYDo9cA8tt/mWIbS9juw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFDod5MiKf2jGmnfQrj2YyOlT6qOcUvEowDEgddaaIM=;
 b=SRSpFCY70OdMQmNgyvirh3nHAuwlso/rz1VFLf82jCjAFVmScZ3KSU45C6R1sxZbXWBOhs3n2o0/bibcpq3I74NbGZdPZ5ma272Yp5hirROIcvAKWBuQBByATzztMw+l8D6dnMGIX6vpP37oT5CbZvWiQwT0wUJnNFo6s9bueX6TYSRUQSVAnvF6qsdQv2HAOLjQs3I4fjTW+W2ScB/+GuIauWj0dHQbzenpBM/K3orYwSzeDNZ2u8xiQBvRjeT8HGntnwqcA9nalRerthHDTZ6Tacy3Z5kmp1BKSRINteCLJk1S2oJ9f9NNpp1rbAr8Gq2cmK0yjZ3reiOO9otFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFDod5MiKf2jGmnfQrj2YyOlT6qOcUvEowDEgddaaIM=;
 b=eZ7biX2oJ+7j8Y0sIy7xgzt3uGPRlxRl2QYlhObdJdNGnaWKtNsa5zNZuXVivtF9tohUnRH3qZbtl/lGZ6qbuZWctV4IF6xSUcnbSw+gwC7PUXNEwyOSJam1rLKOKJaczocwCzT3HHUCwwK9lpSasg9w9mnhqJ21BVNeSINfync=
Received: from CH5P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::20)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 16:12:21 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::5) by CH5P220CA0023.outlook.office365.com
 (2603:10b6:610:1ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 16:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 16:12:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:20 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:12:14 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v4 05/10] amdgpu: add global aggregated doorbell bo
Date: Fri, 1 May 2026 00:03:33 +0800
Message-ID: <20260430161146.2851078-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cc0735-edf2-4da5-defb-08dea6d34256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CygJii7wJb+jvqiBZgtvzwgy4h8In1s1cdwPlh+aEWyLP7yXtcNfl9P/YRxMSkFGNFiQMnZPMQaLh6f+/pQF5dX4MTFzBx5yonbMEZcIIjOTj1ObMEXObFfvevp/jeW1zeJlCGZ5HRAvyIcivqPZMtmich09rNUvyYKwpzWIb+lqoNB1LkZrbRe1xppEUvSfFaR8esJqdDe0P+Fth3fNLC21CMconlOz4Tkn398/E1b3QNf2cykQb9itvFLmSvE0+iYdfuqxswd2u8fnDPsJvmA2VdNugSIWR9IiN57cuwcGsMQTd9zbirpr8/L/Cq2alXouIGWA76dMqCUwDvHinyuH+Qx8I3q9TiMNFhu9StT3CHer+VECrKKWso8obdRiGVbG+4Qmgm0AtFljCBF/l8a4IdxqXJIoCWYBFP+d7+sxqMSOHsg0ZLbYaTGhuGrb80pRpJGjXuv6RkreZ0nx7r9DhTy3UNHS1pXHLrr9tPKqApjCiHWSQf7Kxb74ENiWpeh6Zc7VSCyEMG5lzbCYvPxrs0wYcJo6PGZ2URlycD9vFVQ397/YYX39ZIJv2zfLJflvwK5mwd73r5UtFIcPP7xb/kRFkogtPlyBkeQFZMUn4gCTrrtEfjDK6snVJC58gw+CJmCARuQpuQZOOQaZjUMIDfPJRAiPOJS64uR7P8o4NMD4ZnymO8LO8rDW1SrSXjpHY9QujmDKzwggkbj2N54lFVSdqnbXksdB6FyCRzKj9h96UCnId8dM8UpPun8NbvqPSDf4hScC8vIU53EfRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jxc8OjK8LafCzW/A+leks5MhBrBbWST2Khk3gRJO1Ls7KOhUKqOhWkTKcscqd9GhFN9zVrS+ai0TjSZOfElEj8Ate2e4Cn7qDTaL7LV1Wo2zJUJseGs4H3B/6WfzFgJ98S25+aqdQf5B5ai1JcBzQKo+gU5aZYwHjDyqC67YFxnF2XLFtQEBDKMKXB1Ssu61g+1VXkC5gUmDNZy/X3EhalLSo/DwLmlCTiJO+caUdTJfaJrpmRomlreFgdNd3Cagpt4xDld6DXbzLDVTU43JZ9vklHkGiUkoRgILP7pUa6YaLAxRn+bUijqV1jVKmRrauzDSK/yrzxCoesKimoqZPm4LepyqMyLytJIXAXw33F0FAVH2rXx8hvfJJ3+lXx4pmvBiXR4qlxJMszLfl8yAHd6Eb4jJoMw/633nfsHMWdoGw2WYpMFhmmSnGdzwE/yC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:12:21.3736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cc0735-edf2-4da5-defb-08dea6d34256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
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

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

Allocate aggregated doorbell bo at device level so it can be used for
multiple IPs.  Also add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL so
userspace can obtain a handle to this BO via AMDGPU_GEM_OP_OPEN_GLOBAL
and mmap it for direct doorbell rings.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c | 14 ++++++++++++++
 include/uapi/drm/amdgpu_drm.h                    |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39894e38fee4..047d6bb6f2a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1196,6 +1196,9 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+	/* aggregated doorbell */
+	struct amdgpu_bo		*agdb_bo;
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index bc7858567321..5a63a501d48e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -148,6 +148,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
  */
 int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
 {
+	struct amdgpu_bo_param bp;
 	int r;
 	int size;
 
@@ -176,6 +177,19 @@ int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
 	}
 
 	adev->doorbell.num_kernel_doorbells = size / sizeof(u32);
+
+	/* allocate aggregated doorbell bo at device level */
+	if (!adev->agdb_bo) {
+		memset(&bp, 0, sizeof(bp));
+		bp.type        = ttm_bo_type_device;
+		bp.size        = AMDGPU_GPU_PAGE_SIZE;
+		bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
+		bp.domain      = AMDGPU_GEM_DOMAIN_DOORBELL;
+		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+		return amdgpu_bo_create(adev, &bp, &adev->agdb_bo);
+	}
+
 	return 0;
 }
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f16..062ae4741fd6 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -806,6 +806,10 @@ union drm_amdgpu_wait_fences {
 #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
 #define AMDGPU_GEM_OP_SET_PLACEMENT		1
 #define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
+#define AMDGPU_GEM_OP_OPEN_GLOBAL		3
+
+#define AMDGPU_GEM_GLOBAL_MMIO_REMAP		0
+#define AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL	1
 
 struct drm_amdgpu_gem_vm_entry {
 	/* Start of mapping (in bytes) */
-- 
2.49.0

