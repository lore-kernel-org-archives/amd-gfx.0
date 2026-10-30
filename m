Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8614606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BEhK1GxJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA93210E84B;
	Fri, 30 Oct 2026 06:31:21 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DEF10E847
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ut4YNbgVUrSHDBvXrNgizjfxU7JDW2289F+OORZqYgQc384jrscR0vdFPV16IqxoHMjcvoOKjmzPVnLzjqKXk9nRvfUIb0IXtM2vVysVYNZ6SWX3x4YxoLD/FoCIDaxijB8+seoJV7oloJyXdtKa+gBbBHpz1xNbSTTLUX33AcGYp3LdxTJ/lWzNtqtTHu2PoPoEeK+ucy/BpR9/sPBLWisPN46U33U3Y7X2ZiFAdDVQqxW5SuXIcgnCYq+L+2UElXbH0AQrMX7bL1VT0aeYfYhsJ8Unpjm70rWfT9X1zomB3+HcLazT+idDfX1uD3oBA3x3qCo2E7bFQw/Osk31DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKBhLmHRHeCcF0XXJpYQv/qdNzkucfmrK3s2oaMVMjk=;
 b=n1WNdhPvyTUTdz7oARFnEZUzgnWBNbZ5ai4V0zeOBhQBhYQ8d9fJHjQXdyoe+51BEw4W4UZLrdSnmKpf4/e8rdEcaahmZd8Q/rmfKlwlfiSIVlqqiHrp/MfTaDxdVZb0CuOpLz5tLTBYarbwazc/GVMWGTrSyqIwaP0Ay8jCG23KGm4E+PfAah2SCJGbNtPr5fgu8IUmXOi/CgPXQwgGAsn/FsOtezMp+XodZ2HjQcBWsLRd7ii81+AqPVC7kTJG0+BrdlPzBeIK8zwUvC8BKQWGSxgIBvM5/fvumfhQ+7tzkaGh4slRdxiaT91ezfdqn+vQ6FlqW4I/VBwYBUkRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKBhLmHRHeCcF0XXJpYQv/qdNzkucfmrK3s2oaMVMjk=;
 b=BEhK1GxJDCIuY39Mo+YQ9ZvaIHct+/pgUsxwnEdXFwSHx8CVQJ4f5ykqNwg3v9NvZZuQXLsWfcodbDFf333eekP4bc/Io2guWuKPtPjroMgLDS9X9d/m0nOb7/P6/7V+GO5474PQpCAba49ZFPg6dj2B6KY6xQTh6T2eWqkV6vM=
Received: from CYZPR17CA0016.namprd17.prod.outlook.com (2603:10b6:930:8c::25)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 06:31:10 +0000
Received: from MWH0EPF000D8952.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::8b) by CYZPR17CA0016.outlook.office365.com
 (2603:10b6:930:8c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 06:31:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8952.mail.protection.outlook.com (10.167.249.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:09 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:06 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 04/13] drm/amdgpu: implement reservation mechanism
 for PMC
Date: Fri, 30 Oct 2026 14:31:32 +0800
Message-ID: <20261030063141.2773032-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8952:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 812ac061-6176-4120-499b-08df364f6294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|5023799004|261026121527099003|10067099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: p0IqLd5U1duPD0hfrGb8i4JKNcuXy1swsvXw8fZ1d6F9fsbhI7kWZufxJmwqzABLRqnZyNXwENCM3Ol+5i/LqTSNsrvXpdiboi7B5PtiwEYVmxo45wGLG+VGshvhF+Ej9kGtcbHNOVtzvHU5wB0T2Rz8X0SCeVy5W+wpkVuR/Kz+kXBA9kJZFobApkpAxiHAxrExnrsRHUw3rvskUD3kJ+dFfQxtJLC7yEvEHD08IIzJmnGC28E+Baeg5wWHG+0l6KZftJEwJDm6J6MtHjCfLLbW7r1Hz45lj5PUyJW4G41KYrLCLUAxUSv3e/DNNvi1FnmS2kmxkSXqFbLSb5TUOXy8JitaeAy3gfcJoPdCbHKH3hwbpna7VcPH3wt3SnvVXSVG2ee8rP4kaeRPNd161CbknBp3laGmdSxOLMBDxvczkxT8ohwey3NgFiZHiIyi4rNSNbLGxGPsQqpFbEPPE/LrZJxAmVWDfKU00N9oPGqB6XD86jBnjZdr1oQuj2ZrWNYLyoLs0U6spSLUrwRGoEWZ1qCimYarpoHJg3thRWlOgIc289O0TGecYtRyMLs+/jzcyP18PwG4PmQAluWHGJfM5ttiuO+WPW2+3jl5/cGMgTqNd5gfrqEJGDZ9bXGKcO9YKmDDHlTpdXm4+VgrD/+tF4oRFihmnk8lXUHZQY8mafMfLA/HA/3/oBYEwsa9yTIV4vdpJG7xGAgbGu/dIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: alpZQyMfXa/89nbab44Etu3otK2Mb5/E7WGhYBiafo/RXRguWs86+hkyoS0PRv6juVHNojdgmbw7vP43Qf1UhSSYg9a+VVL0QN5Krk+qU9RKETnwnD8/lA1RmtAOPl/ksdv1BwuzRpIQf3c4AQgkxJpXzYxylxpOz/NcEs4rBDApThEcWhrhK9JRXQFMtBNKx7sL3cRtMiFLzVmKlOcfzkh6Fh5K0OAGYgy94xrJwDgWu9znzbuj5swssEuRgX5gAPJXQiQa0ixtHZvq/2XGNaDZPES+iSQTlwDUA5xRURm0dHM80sgr8puGdD/p9De9q6HZHTgBcBcP8JVAp17iTcthCRDJzPok3NBG7tfv/+lpF277zWDG2KtE9oMIQavvF4m/1kgFwgegtV4w07/bUZIJgS9mkNcQSf1xqIZ/HzZbdCZydMVzxyijVhtscXhu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:09.2705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812ac061-6176-4120-499b-08df364f6294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8952.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit implements reserving (take the profiling ownership)
and releasing (release the profiling ownership) of PMC.

A reservation can also be cleared by AMDGPU_PROFILER_CLEAR_RESERVATION
in case the owner can no longer release it, e.g., it crashes.

Releasing is separated from reserving path by design,
because the ownership needs to be kept during set_perfcount
to avoid racings.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 75 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  3 +
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 61ce43dcad68..e441eb171c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2988,6 +2988,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
+		amdgpu_profiler_release_device(drm_to_adev(dev), file_priv);
 		drm_dev_exit(idx);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 134660a4a4d3..a15149720d52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -29,6 +29,56 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_profiler.h"
 
+static int amdgpu_profiler_reserve_device(struct amdgpu_device *adev,
+					  struct drm_file *filp)
+{
+	int ret;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (!adev->pmc_profiler.owner) {
+		adev->pmc_profiler.owner = filp;
+		ret = 0;
+	} else if (adev->pmc_profiler.owner == filp) {
+		ret = -EALREADY;
+	} else {
+		ret = -EPERM;
+	}
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
+int amdgpu_profiler_release_device(struct amdgpu_device *adev,
+				   struct drm_file *filp)
+{
+	int ret;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (adev->pmc_profiler.owner == filp) {
+		adev->pmc_profiler.owner = NULL;
+		ret = 0;
+	} else {
+		ret = -EPERM;
+	}
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
+/* Clear the reservation in case the owner that can no longer release
+ * the device, this function does not take the reservation, nor touch the PMC state.
+ */
+static void amdgpu_profiler_clear_reservation(struct amdgpu_device *adev)
+{
+	mutex_lock(&adev->pmc_profiler.lock);
+	adev->pmc_profiler.owner = NULL;
+	mutex_unlock(&adev->pmc_profiler.lock);
+}
+
 static int amdgpu_profiler_check_access(struct drm_device *dev)
 {
 	if (!perfmon_capable())
@@ -40,6 +90,29 @@ static int amdgpu_profiler_check_access(struct drm_device *dev)
 	return 0;
 }
 
+static int amdgpu_profiler_reserve(struct drm_device *dev, struct drm_file *filp,
+				   u8 reserve)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int ret;
+
+	ret = amdgpu_profiler_check_access(dev);
+	if (ret)
+		return ret;
+
+	switch (reserve) {
+	case AMDGPU_PROFILER_RELEASE:
+		return amdgpu_profiler_release_device(adev, filp);
+	case AMDGPU_PROFILER_RESERVE:
+		return amdgpu_profiler_reserve_device(adev, filp);
+	case AMDGPU_PROFILER_CLEAR_RESERVATION:
+		amdgpu_profiler_clear_reservation(adev);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int amdgpu_profiler_pmc(struct drm_device *dev, struct drm_file *filp,
 			       bool enable)
 {
@@ -66,7 +139,7 @@ int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *f
 		args->version = AMDGPU_PROFILER_VERSION_NUM;
 		return 0;
 	case AMDGPU_PROFILER_OP_RESERVE:
-		return -EOPNOTSUPP;
+		return amdgpu_profiler_reserve(dev, filp, args->reserve);
 	case AMDGPU_PROFILER_OP_PMC:
 		if (args->perfcount_enable > 1)
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index c27b5f9b3ff0..048ce84f0ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -28,6 +28,9 @@
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
 
+struct amdgpu_device;
+
+int amdgpu_profiler_release_device(struct amdgpu_device *adev, struct drm_file *filp);
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
 #endif /* __AMDGPU_PROFILER_H__ */
-- 
2.53.0

