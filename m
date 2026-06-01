Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3113CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50977112DD7;
	Mon,  1 Jun 2026 05:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rJu4zYj/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883E7112DD6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixQd2pAmDGb0n/z/hslTePigAU/BZ+thKAs9VXhoIysesIrfl5suYuhG6ZSnxToO3m9T40THXZ6R30hEaeazvp6FP1gOX2y1adCEaCUXv6yAH6ugZMqEJzTnUBAYKnSrSoxgKcbKqjkODgSkjjen8EEtH/IYDRh9o/BAY6E9wMJB/Os2/uUQJrz+KpE5pZDye8v7gdzg9xn9AZ565ijSN0jT5xgDfc0vpm7ThK6GUtix/LMaRUHx/iuqyQ8/s4fR7A4DBf6IZd4mXUbUDDeCsYmhXDUREuYDZ/W9mganCdz3cEn/oOpDLY5qMIlnsYrC9PhRB5oaGLhu3cRsIwFx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCH8KEiQrmYtWT+QuY2qAzHsZlBg3Rc7/jDVIgt9zOQ=;
 b=FEYW/Lx6ThrmyYAqEL5oEkeUHDfTHIh1vAxEGRa8xv5WZlSM6M2UndpultNRKi6pYdNCoOo5MvwLXMMr25Y3nvRnwupIEE+SwfZaOX19b7dkPVTSHBpdEI6UINL8s3hSsgP2GnKYe5oCabmbMNGWJcPTph3RiKqJb9IQhi3e8Rn59w67uh1+1emp9MJm+6BpUHlWF6LaxFI9TQWVAV1mzROd8uJKItemx5LoYkxR/SaxbwwRAaA1uCSAFh++dfEGV3rxufGl58iBeN5lybfyII6SpEwomMADCODHaVQ1mjTDFMZoxOAoWbKGWRKGnvg96oaarnDp+bOjTd9sAAJzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCH8KEiQrmYtWT+QuY2qAzHsZlBg3Rc7/jDVIgt9zOQ=;
 b=rJu4zYj/YosPIVde2AAZY2zr+ejrYd9/IjvCws46IfHhLH2ggqWslFMnGgRu6OWeVyXzg9Yk4640bKhCX8fh01dGRwNUZVxKra5478YgtiO5CS2ksuFLkgt/UvoNosMg63BQWK3EKjAohCJV1hXg1GPkmI4o8Wac2kulr7wM8Is=
Received: from CH2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:610:58::22)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:54:00 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::97) by CH2PR20CA0012.outlook.office365.com
 (2603:10b6:610:58::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:54:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:53:53 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 27/42] drm/amdgpu/gfx: add a helper for MQD restore
Date: Mon, 1 Jun 2026 13:49:13 +0800
Message-ID: <20260601055034.3700921-27-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: c8203c8e-e3f6-488d-a174-08debfa22dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XY5BqQ4ezhGVw0ihlb3iyVpyEfcMFFINOkiAWDpk1en1qACWJsvP3KUz9k4TNUzaKCzZH18KfCuKcIg7dli6TpLHnFfizRx/nHMM2lR5Lopgd64gQy2MfzMMdtRokd3WLx6H0Dsi9TBCEjyp/nNHAPnrr7FhtYsiNw0TLwEULZNa/ii1fCPyC5zjmF2/e8UopmDYQi8iise2iEMWiTkrplFIIPul3kCqs6WBrVrir7Xgbt1E1RaHjC3ZRPqqhe74ORUKvzs0I4sGaBXgcIBp8qmGnqNimolxbAdntdbapv3BHzFTeS7tJQdFIURHts2YTHkLBFsC9bp5XmkyhE6Q68ko8HLa7v8Q+7PzipKZ6HCUVAWPOb9dPEe9uLq/mp24UQBXMK0We6t3QACgr9JFPNouk3KsbsIDGemyucN+wpJWLhJeMPRURizDU9/ET/8FopqJWu2YjkHDp66MTeylSUzsjZnR47SumcKqjuND7onCHancOa8ufDSzdotVlywK0eC5HGA5YrHhnf6KGx97fob5Ap66EN8QZG946eKETOUxZkfh10ULhKpiOBBz1n7fqrug9UFzaxTRPY3OZ6obAW36f3sobH56H+4S4VAIy2i7cos4GEvynw3xfmYCLJDTvIidwLlQprExxjHwWvAOjjtuB2D/JM9Ha2Krb0YdQqvaQWCg9q5InHh+ZmtPZht1iC1Jq0y8rTT6ZXpBPNVepYcESQQHwULHVX/tmsG9tDg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D2hFd4QQrrPFveAj/uyUTStGp+3Q5cgdpviBUIfULZ+Wz7VYBgUJpAPQS2F/OYeXik7htXVF+5R4odxLZ8sNM5rWkOAuCOlPcYB3oWEW0Y94ai4X7828mjpoGsrqwlsfqywR8NVmCKfr+O2jbNuraTezCW9w6jTVs5ZZNXkrQkQ9Sb8WBD6ygK/4kZdCFpW9wMNrTTfymUR3yRqOY9qcDm8rPHDsIu5PG4F59/gPaD5EiHjFEOgbyt9Jb65CmKv43VDOK4kZKEXKk9yIPeCZKx7S33jS1DLnjwxIrJeLJ9BnFLg8N8iGgLc1Rh9nCjOmBxni6qzI0hUCK6yI35rG3DjkmLY+DGzht7xomwBc4dMqz1cf2Yw+p/bwEMUJfQVFzWuK1v9ZcH4Xmr+r4dpWYBDzphjrExOyTux/PEJpIgnhP40985V+cKVhCRSuMltX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:54:00.5912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8203c8e-e3f6-488d-a174-08debfa22dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799
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

From: Alex Deucher <alexander.deucher@amd.com>

The handling is common so extract it to a helper.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 515cc4a2aeb4..aba21afd2b32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -377,6 +377,30 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 	return 0;
 }
 
+void amdgpu_gfx_mqd_reset_restore(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int mqd_idx, mqd_size;
+
+	/* restore mqd with the backup copy */
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+		mqd_idx = ring - &adev->gfx.compute_ring[0];
+		mqd_size = adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size;
+		if (adev->gfx.mec.mqd_backup[mqd_idx])
+			memcpy_toio(ring->mqd_ptr, adev->gfx.mec.mqd_backup[mqd_idx], mqd_size);
+	} else if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		mqd_size = adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
+		mqd_idx = ring - &adev->gfx.gfx_ring[0];
+
+		if (adev->gfx.me.mqd_backup[mqd_idx])
+			memcpy_toio(ring->mqd_ptr, adev->gfx.me.mqd_backup[mqd_idx], mqd_size);
+	}
+	/* reset the ring */
+	ring->wptr = 0;
+	atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+	amdgpu_ring_clear_ring(ring);
+}
+
 /* create MQD for each compute/gfx queue */
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			   unsigned int mqd_size, int xcc_id)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 77050f9884f2..2a548b22725f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -586,6 +586,7 @@ void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 			unsigned hpd_size, int xcc_id);
 
+void amdgpu_gfx_mqd_reset_restore(struct amdgpu_ring *ring);
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			   unsigned mqd_size, int xcc_id);
 void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id);
-- 
2.49.0

