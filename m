Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631A9C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 04:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0267A10E008;
	Thu,  9 Jul 2026 04:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GxTjHDgI";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBD410E008
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 04:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naki+1yGKmXTYr0AgmHTzgGoWhBKbjQMCj6hGdWkIloz7638+hixiy6b6rNUkzx7xaeaDtoon7TIfvHKHxTYfnlXHlO8++ii/izx4Qlyd5s+ocFlHtIzZjZq1scYoqhX4Zl9VtIlZ2x0Fmg7GLvehBrkFAADv32AYvhRsM0snG+ht77JEF+XSl004wH3lVhVJEntbVFK6Qt0XUcdWL4oXXF2aMu4vAh4+x66oySTN8IF9SltagospoHZs3zwDfyafZte0BnCKRAO3l9h/hkonIXrCl0+wJTyUImvr7DZRsQf6+QGMJprQheVFHs1kSc5l2K1gsU9AIv1ofD6GMwNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4bUuu/6PVIdIBdlF/mhdsOcLEDaREaPscufyABpCXM=;
 b=cIrJZwPtByxHc3hpP9CF/7CCea/gm8qPrIq4jaMzhifsHGVobwV08KfE8exkSgn88dixHoKXggWDLRukw3yBjnZwW+nbzbzSmykTsqhYm00SrAZIn9nQouPtK3kyDq4MnFeN3Q/IolPJ3Yd3hXMeTrmYmYpg2ety3iKVv9xQicKjapuuC0HOswFg4Ai3RX4lJZhMq2yMtshWF8705RubcLXCNFg22n+T1p5X69/5+aDrDCycFYdV/leZpMklK7xme8zUIjuuVIOajtscmVeJIvDvytM8zxP3ySCkugEfO7Ql9yA+i41Z3kxylnCa0XYmFrlHr0Bt8ojTOcD3fUTIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4bUuu/6PVIdIBdlF/mhdsOcLEDaREaPscufyABpCXM=;
 b=GxTjHDgIqeJlEOWC/gtNGLnwuSf1AtS9IA3MZMHFLUQW0S5xoCzS2jM3Z26euyA28leiUe3+cQQpBxJTq5cz5J5Ek7lXYdTZsQTqWW3oKbGF2DTLjD0wyUJmA3Hn9cWlpaeIq6AJKL0OKkl9rchvl6N1E6PqGVNnE7BEKPNyJvo=
Received: from SA9PR13CA0097.namprd13.prod.outlook.com (2603:10b6:806:24::12)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 04:53:08 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::38) by SA9PR13CA0097.outlook.office365.com
 (2603:10b6:806:24::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Thu, 9
 Jul 2026 04:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 04:53:06 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 23:53:01 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix sysfs duplicate errors and incomplete
 unwind in ip_init
Date: Thu, 9 Jul 2026 14:52:38 +1000
Message-ID: <20260709045238.3405709-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADnq5_NDZqV4ihd70PBgXOrfRfzfYrgz948-FnNh+8tpvn7kxQ@mail.gmail.com>
References: <CADnq5_NDZqV4ihd70PBgXOrfRfzfYrgz948-FnNh+8tpvn7kxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f90d1e-eb7d-4e5a-1d75-08dedd75f79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Sft8DwYKZRmGkCsq26wvKZmm+vUiVxS6VFtsMW9mrj1RhcW4svEc3+b/1nDVZl4MA+68349yI7e4oXzZRL9PIICEV9QM6Hd+ub6B+YH+gCGcZBlJ4QZfps747H0kBR9FgeOn6FZSD1NM6PGijIdODbJg32mw8yeaxk4GB6LDDLNGz2ntJvNSZdqDh3Il1TUc29st8nc2YgKEMFep0WL1+jJm16x6QeMLMmG+LiFNJ6ZbBuA4tWvFd0NP7por1ioib1PoQhqHxQeHGs5R6JHVJieauonWOhDiaJ7p/EIB0qK5mVWjF2NtW75mhmNUBsTet321brXhrjbmq6cFsWTf/IyqF7j94iMAD6+QRdM27ACcGknYRvILGcvpjRvw8z0TkUGTKuQGZxDz9f4vq8c2/W4MTi5lE9ad0qbUr/ZcZBf/ivWffH4ryteF36xvcF1FvSFPYjzE1RiAn9qZEwNmB2+zNrJSmk0HWNW8LideTJF0Dk/BkR2eRiLk/uFVUTDSeOv+d8EOW2CR9S7TlhpNp2tyVbXKr47qgT4aswxlDkpytQ1Vt3OZmS+wmHzE9xbXqO9R/cz5SoFedICxeBXY32gGJ+aDDRor++8kzFb6HJYDMfSkmzMOLa11pn/4SkX0goG0iJyAHHj6alarGzJOLyz7ycQZOumjn68PBTxl0KXFXr3nQTnuIHapPFtRwrgm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dU+rv3bwe+fAJk6Vj3g+n9vF4iCkjyGYmPQlQJDkDYD6ShmphOpsjyEftlizP+GoWZCxllD6TDLs/DLPg5x2MEWBGksZjfsDnXjzLdrK53vwxhJ6i5o2CMlj16IgOIJXU8kSmrGTLSGHiX6RBhMZgNt8/ltIwCY4RBuKpZ762S6wC7dUsvfq5X8GQBPdz/6a47CR42pZIIVP9STup1azUFN8eYO2wOq8K/1CTA7HvJg52VWd4H/7W269LTMmb/RzLUcPvqBXHj7dvt6HWr+ZVgqTxvkru8bXGTMIsfIEmhZkEWgMJaTdLChyfhNuGOTINoNABE2Nh/cTTZyfx7BadziTLp7n+hsJw6ZjAhzmJNoR0OtF8Ra2xlf+JqSlzg7EuJYXZGrEk57HmPR1PbtHQWS7aXqkQS14AipKvi9V1a+sGHDc8oEm3b1C8upUMqkR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 04:53:06.7564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f90d1e-eb7d-4e5a-1d75-08dedd75f79b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827
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

When amdgpu_device_ip_init() fails partway through, IP blocks that had
completed sw_init() were never unwound, leaving sysfs files registered.
On the next device init attempt this produced duplicate filename errors:

  sysfs: cannot create duplicate filename '.../enforce_isolation'
  sysfs: cannot create duplicate filename '.../sdma_reset_mask'
  sysfs: cannot create duplicate filename '.../vcn_reset_mask'
  sysfs: cannot create duplicate filename '.../jpeg_reset_mask'
  sysfs: cannot create duplicate filename '.../vpe_reset_mask'
  sysfs: cannot create duplicate filename '.../current_memory_partition'
  sysfs: cannot create duplicate filename '.../available_memory_partition'

Fix the init_failed unwind path in amdgpu_device_ip_init() to properly
reverse all initialisation performed by the function:

- Call sw_fini() in reverse order for all IP blocks where status.sw is
  true, mirroring amdgpu_device_ip_fini().

- For the GMC block, free the resources allocated during its early
  hw_init phase in the correct reverse order: seq64, static CSA,
  writeback buffer, and mem scratch page.

- Free resources initialised after the IP block loop: ucode BO, IB
  pool, KFD device, TTM buffer funcs, and the SRIOV vf2pf data
  exchange work item.

Additionally, fix amdgpu_gfx_sysfs_init() to properly unwind partially
registered gfx sysfs files on registration failure, and drop the
now-unnecessary kobj.sd liveness guard from amdgpu_gfx_sysfs_fini()
since device_remove_file() is safe to call during sysfs teardown.

Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 23 +++++++++++++++-------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 70d07ca187a3..9630ad5f3048 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2491,6 +2491,27 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	r = amdgpu_cper_init(adev);
 
 init_failed:
+	if (r) {
+		amdgpu_amdkfd_device_fini_sw(adev);
+		amdgpu_ttm_disable_buffer_funcs(adev);
+		if (amdgpu_sriov_vf(adev))
+			amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_ucode_free_bo(adev);
+		amdgpu_ib_pool_fini(adev);
+		for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
+			if (!adev->ip_blocks[i].status.sw)
+				continue;
+			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
+				amdgpu_seq64_fini(adev);
+				amdgpu_free_static_csa(&adev->virt.csa_obj);
+				amdgpu_device_wb_fini(adev);
+				amdgpu_device_mem_scratch_fini(adev);
+			}
+			if (adev->ip_blocks[i].version->funcs->sw_fini)
+				adev->ip_blocks[i].version->funcs->sw_fini(&adev->ip_blocks[i]);
+			adev->ip_blocks[i].status.sw = false;
+		}
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 982b41606d48..0ab4c73c102a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2182,23 +2182,32 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 	}
 
 	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
-	if (r)
+	if (r) {
 		dev_err(adev->dev, "failed to create isolation sysfs files");
+		goto err_isolation_shader;
+	}
 
 	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
-	if (r)
+	if (r) {
 		dev_err(adev->dev, "failed to create reset mask sysfs files");
+		goto err_reset_mask;
+	}
+
+	return 0;
 
+err_reset_mask:
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+err_isolation_shader:
+	amdgpu_gfx_sysfs_xcp_fini(adev);
 	return r;
 }
 
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (adev->dev->kobj.sd) {
-		amdgpu_gfx_sysfs_xcp_fini(adev);
-		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
-		amdgpu_gfx_sysfs_reset_mask_fini(adev);
-	}
+	amdgpu_gfx_sysfs_xcp_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 }
 
 static void amdgpu_gfx_reset_start_compute_scheds(struct amdgpu_device *adev,
-- 
2.43.0

