Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B894BC43458
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Jun 2026 05:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A75810E45F;
	Sat, 27 Jun 2026 05:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZwCm3Rwo";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375FA10E45F
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Jun 2026 05:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTe+xHknIBSwv2R0uo80uXBN+533WSWwK5eULfM8zQHdDqiOtwn2TbLClQQAXGdyjOvRWQ8aABIHDLKRw3HYZJaqx+BAX0Eu0wbA2yLREFYr+exOleA93/Z6bKS5PdeOzGMEQHZrWWSS6Ml4uf1TGzWhIRT/jP6/7i7FFSGsTXXIPDWO+6dGJokMdkgzEN9/49Q56RQglNfztUXlsvLOE6V2i2cD584zIUZUT49Bh/SXr40Qf634DAXEQvKYapAomY3CGwAIJvPUGtiMx5fdD6zMbdHj3yhmX2i3NCnrdqFM9gnLmtyhm7F7g+D+cIO19iOk2AojOCYGDbNraIXCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdLKZUcURqmpyt0QIWkrBTfT46fITQp+b8MhxEGb2Vg=;
 b=WWPHGerdMCPJkAagIRcBjKzXhk3jLkW8gyFOYYJp+PCBiCUbFXlXNG5CuSZ698kcZH634+YhgHxBQCWfQ+ZHk3X+Te/nOeQjqwTDkMVRzx1GBovD9aCbilGkPuCkg367EB8zAxGsoxUCCvCVS5NC5wX23plMnZtXyEcgF60r0TiR7Yf3/Pr9lYy9Z92umGdegPE5ozldpFt2dFnXuC0Z8s/NLg21mmf4+Lczayah1E/x3RzyA+O+cE4QKwAk8nqClA8zjnskMMroG6dCXsQN3OLp/qnA1v6y6ZIF+cMQ6A42DdL/GBrf2zoBmAwSVB1ZRTF/24GNRzNdRIQyEjb1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdLKZUcURqmpyt0QIWkrBTfT46fITQp+b8MhxEGb2Vg=;
 b=ZwCm3RwoEeaugKP/jTgRX1qBsHzMXaHbyVKQkW+MerZmWqF2XOngUgyEeDcV5T0AUwAmFSQTy3SlY9qPF+aDuhAXJYdQwhX1NnjFGUb+ZLwu4c3u6eW1DcpZj13dcs9JjBXNW/3SQbeYuKY9qmzMlZ5eWPXaIUj51UNUa9rAPrU=
Received: from MN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:52f::26)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 05:57:37 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::3b) by MN0PR03CA0006.outlook.office365.com
 (2603:10b6:208:52f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 05:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 05:57:36 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 27 Jun
 2026 00:57:34 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH v2] drm/amdgpu: remove gfx sysfs files on device unbind
Date: Sat, 27 Jun 2026 15:57:20 +1000
Message-ID: <20260627055720.1543432-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260627043801.1025055-1-geoffrey.mcrae@amd.com>
References: <20260627043801.1025055-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cfd5b5-4ea9-4fb6-dc37-08ded410fd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dM9sgLWtziTZDXXFnnLQmafYw74NGKbjg7gIPahTWbY9adWBQsP3PRoJvH10JkY7bZGlsQh7ifxIB7fbbgZDK7syvIjka+hWPgKtjKBIOHlu+bworG/JRvzOXIWaiJKoLI6RDrvI7e1CtRXOIjfOzIUM4zM164wC4ZVCETgXfY9CkF573w293+AmyKE/hRv9CqBy0ZSoKj/upA/PBjO7syF1rgphXKCjZSb6h86/FEdUevHECrWX4bcRkS9hTft/Hvlx7ha9AMpVUckDRELkCd9dp4D+QPjFH0V8qgnqMaHBmlFkzAzLoHX6P3euTaA/LUqRMZyLveYlVLNFfsym5ptIGxQp30ip/fceChMAGz1M508XC6t82qYCAvi2ZS0tYsSbRtU+eMC0KKQqhM99jlb7ElBfWmS40bJoSPl7bO1KgIECQ31MmRE7PFH8xH9nmYc4uzP3xXU+KiKcphPLpLJ0Z2/GxY8tM/k4/z17oki3cJp1PzeTZEXW/J1vgBNuSqSCPqJjZ09fBKUr2dKBPq6CRAEFczP337OSptq2RhzTP2r9CRTWlRo7KwfGcsAovsfH1srao+nodGxnrBxlbcuVNFYVY553Otf1qHwlGEPxVpHeIYNz/ExN9Y/Kqj1EhoGHqBvNnATF0vfzPGPmulWgZAFnfCIDoep4y5GRFojybd9frQeD/y6izZu18/db3IZodzsLS9CqnCxW+iOa4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6AoCAQ0SX7b0MpauXZlrLzutt5tr5NfjGQMBZBV01EyZchdWGmwPQ1NtBypvvdH1zjJ8umZYRzO7+cp6puNHra9lpvL8pZM+36w3UnLxdcXGOIzr4+MFq5nJl+H9wIWf2mipp5PuI1rfNkcHwEqU9ypBQqtqD/3NCv7OA1HYBJifI33cEJJQJ77sjcKrqGDj8ilz8FgVqysBkuWKLBT+L/8Q00qinc/tHsZaNnENWkuRzovJjsX7eVC8FKtk9jdhtcYdp0LZO1Vn43Mf8wRhk4+1XadCi7HGb5RHbpARlumcDc0KJy30xS5RdaoFh8Z7nSlASZplEI5Ls8dPKwI6YNiljOtsyMcHRPc9eSip+74geK0yDXBU0UUfE4NSB656+xuh+YBTectphSHss9NtFem1rlq2WpaREWPjo48bsFord0nfycwlqYEw1uxtBC8a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 05:57:36.9086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cfd5b5-4ea9-4fb6-dc37-08ded410fd6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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

Fix more sysfs file duplication errors when reinitializing the device:

  sysfs: cannot create duplicate filename '.../enforce_isolation'
  sysfs: cannot create duplicate filename '.../sdma_reset_mask'
  sysfs: cannot create duplicate filename '.../vcn_reset_mask'
  sysfs: cannot create duplicate filename '.../jpeg_reset_mask'
  sysfs: cannot create duplicate filename '.../vpe_reset_mask'
  sysfs: cannot create duplicate filename '.../current_memory_partition'
  sysfs: cannot create duplicate filename '.../available_memory_partition'

Fix this by:
  - improve amdgpu_gfx_sysfs_init error unwinding so partially-created
    gfx sysfs files are removed on registration failure.
  - added adev->gfx.sysfs_registered tracking so gfx sysfs cleanup is
    idempotent when harware teardown runs before the existing software
    teardown cleanup path.
  - calling amdgpu_gfx_sysfs_fini, amdgpu_sdma_sysfs_reset_mask_fini,
    amdgpu_vcn_sysfs_reset_mask_fini, amdgpu_jpeg_sysfs_reset_mask_fini,
    amdgpu_vpe_sysfs_reset_mask_fini and amdgpu_gmc_sysfs_fini from
    amdgpu_device_sys_interface_fini

Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 32 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  2 ++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 70d07ca187a3..c0a22d2411f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3674,6 +3674,14 @@ static int amdgpu_device_sys_interface_init(struct amdgpu_device *adev)
 
 static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
 {
+	amdgpu_gfx_sysfs_fini(adev);
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+	amdgpu_vpe_sysfs_reset_mask_fini(adev);
+	if (amdgpu_is_multi_aid(adev))
+		amdgpu_gmc_sysfs_fini(adev);
+
 	if (adev->pm.sysfs_initialized)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 982b41606d48..ab37c4a9f415 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2175,6 +2175,8 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	adev->gfx.sysfs_registered = false;
+
 	r = amdgpu_gfx_sysfs_xcp_init(adev);
 	if (r) {
 		dev_err(adev->dev, "failed to create xcp sysfs files");
@@ -2182,23 +2184,39 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
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
 
+	adev->gfx.sysfs_registered = true;
+
+	return 0;
+
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
+	if (!adev->gfx.sysfs_registered)
+		return;
+
+	amdgpu_gfx_sysfs_xcp_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
+
+	adev->gfx.sysfs_registered = false;
 }
 
 static void amdgpu_gfx_reset_start_compute_scheds(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index aefd4f03b443..df7ce026bfa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -477,6 +477,8 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		rlc_poison_irq;
 	struct sq_work			sq_work;
 
+	bool				sysfs_registered;
+
 	/* gfx status */
 	uint32_t			gfx_current_status;
 	/* ce ram size*/
-- 
2.43.0

