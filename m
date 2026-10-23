Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23055606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A+OqKN79
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B289E10E5CF;
	Fri, 23 Oct 2026 09:08:57 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E84010E5CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxfrQ1DI2N4WgubIppemKA2hMBkQXcPvXYPvLUtA+PKsYuZ/YQG234sLvBxdAKBFPVGYo8IsqrzX0ZepuhSjWcSArGykKh7lJrV1ceRY6ECcTI8AqpVSUkKdxoOLWv/y4uhu7v6VEM3yJifyiva9Og1oMsMwMz5YJVficFw6baLnLobeRfOmDiYdH/a/7Ax2Gr1QUMjAem49NrDZLUUBIfMM/dnyrV+O9q6a2VjkeCb1/Peaygv7YOsbH1h+0hdRa1LZxs6cSELpyuK1mveiQ9yaWszBQ/gb2+ABdGxup+3q9pD4XXPjLscZZvAM7K02G/ggU8j1BvjUuUVNXIOoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50qrigGVBazrFBtTzdrMh3x6hGNrs4RMN6vmIriAv0I=;
 b=aUfKFOqfMJr7JJ0C8Q56S/hbDCJxntYt1cHAHE6+MUy1GtmbMyXE3mCn7/jX2HtkEXrJoCqhN7xbfZkxpZ0g3rR5MUGcPYQmnP/2GM1NcaoTgaS5joKTBcQHOM0NmgOrPG3vP4luEF/U68w3NmU4jE074irgFhFwL5ZNsG/3zGUVTRpjUO7NfeJtC0c3IwnhLGjJ1LJikeUH5603Tcc7PHRynqRWAvoPGUNMxHcTdXe3zBIDrythOyv+Rp1vAYBoTpXb2qiWwnKrX7ok/2dd4aHROQmMAqJIXrR1FFqjSt2DXAg+xe77BqlvHaKgcEqO4bgqzHvlZ7QaONEjAYvyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50qrigGVBazrFBtTzdrMh3x6hGNrs4RMN6vmIriAv0I=;
 b=A+OqKN79ZlKfZwK1Fd06VTheM4+AaOz5/PaIkt+P9AnDSMD5JpZCQAW5q57D3rIizSrKhKdYH/bXNSRIJYcxabJqC44cxwAxo4HmZtT/vjtj5c5QLc8KWTnzRJzhhKk/eYdj3yrldb6J2sofq8YDd/2a1Pqr/Wlwswwc5HulQcE=
Received: from MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::34)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 09:08:47 +0000
Received: from IA0PEPF00000040.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::74) by MN0P223CA0019.outlook.office365.com
 (2603:10b6:208:52b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 09:08:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000040.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:47 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:40 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 02/13] drm/amdgpu: add device-wide PMC config
Date: Fri, 23 Oct 2026 17:08:34 +0800
Message-ID: <20261023090845.670581-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000040:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f269442-226e-4265-ad5a-08df30e53f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: mzoeABlDaJElRxV6XXzKPM+6zFMTSe+bQdBR87bRAyNxxe1g9K3w1hLbG9BSHAz0EHTSu7pZw94wrLdeZ0ESPx5kaFQQsEOAOIGLVMuER19C+n78HcC5WteXQJzkEWanAs15Fzs2iUpdnivCAAMimYpbNFidjRwgJRAb0FwY4DY+c9RxsByd7C/L1RINKhQvLFcNf4KUGI8B0+qwefcfbRc401L/h+dqPKpEn0Nl2w2qbbqSgnSErRH4rLJ92/dSYUks56Y11ux5TDpxQH+LE9BDp4GlKrwuyxHsVF3Qx9HajiOcdjClxBupapptxFzCM9VVrun4JLCFlwYAnGeXHwqandtNzD/TxvJLDZ/LpnDVRZ6K+laTP60opbXlm7NBrX86QCnVFtkt3tTmnvVS6wKuTK1DkSuVtO2xjBwuUWMkNveYkU/JD9p3EM4AxpRj8GTc/RW5zFwyUDqKh8zXZakMa1TVbmXTBcDCoI00dwFF0rDdYiKtmkzqMLXhwh8DEm+h93t+c0ytk2ovUJkILXzNrLwF11JU7t42Ie6lBGGxT4oQHsFNiRPt5WuT6yQVPC3G8K084WF7qV6RJQ/FEh+vJP9jBfwnk5FFJW9hQJryfEi38ai+8s9irt1mIGLi9AxOBnpUADeTmPSWrPeYrct339rrk/14lMmgPD2Wq9et38VojQWVnlzuTFhcNlJTK7Cmxfd6914G+u3UezQLRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R7/yTuTEjpGP16wrFS4Sj2uvPccbHH0GO5RyXGKFelrJfY78fu5SckGkG7MmhM8vrEVcw/0M/qDb7fPtPz6AbHNIs5phrXHk7B/J9LarCr2XI52bguvgix1wgNaugfH9Th8asfqEC/GMLy3M0CqLjGyZurk57xGU/nw1Kr+znSjEEMw+Fapzuvft1commjbA7dQZnWrAkYEktZtA6T8Jn3N7ic3MfL+614siOiiN8l2yDkgioFVdAIhLIbVPmGiDlWHJmixHCs4VOU3aSetdPwzPqCh9g43Tm+rOXyfnqAMWPLa62cZdHkguH4/TkvHk4GdSfzX30Hk3gRo5N0ib6tEbzFfXLZY/u0MuQy1zTFNGLmnq+0XHcAJJSCLSQlIdl1vekh6EHXUnxcCQoNYB+0PDo8xMz5fpEIAOhRpVOIjbnZ7NH9qwJ0KEUzk2hJx1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:47.3235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f269442-226e-4265-ad5a-08df30e53f11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit implements a device-wide PMC config
for amdgpu, which including the profiling owner,
and the profiling enablement indicator.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3763c197138..f1db089921a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -620,6 +620,13 @@ enum amdgpu_enforce_isolation_mode {
 	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
 };
 
+struct amdgpu_pmc_profiler {
+	struct mutex		lock;
+	struct drm_file		*owner;
+	bool			supported;
+	bool			enable;
+};
+
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
@@ -818,6 +825,8 @@ struct amdgpu_device {
 	 */
 	struct xarray userq_doorbell_xa;
 
+	struct amdgpu_pmc_profiler	pmc_profiler;
+
 	/* df */
 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 380989f4c965..c466f67c6556 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
 	mutex_init(&adev->gfx.reset_sem_mutex);
+	mutex_init(&adev->pmc_profiler.lock);
 
 	/* Associate locks with lockdep classes for ordering validation */
 	amdgpu_lockdep_set_class(adev);
@@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	kfree(adev->pci_state);
 	kfree(adev->pcie_reset_ctx.swds_pcistate);
 	kfree(adev->pcie_reset_ctx.swus_pcistate);
+
+	mutex_destroy(&adev->pmc_profiler.lock);
 }
 
 /**
-- 
2.53.0

