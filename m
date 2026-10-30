Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC03606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oXsN+SQt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B616010E847;
	Fri, 30 Oct 2026 06:31:21 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8E510E84B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/Ze6bGTpT2Ty8M9qzcVGojmS2QRbDxMnTNH+ddxWp/NLieOldo7isZSlmbFuINz6IwtHBtvP4QbTCrIp90eXIlTMjXtx7qiaP+FarEzrolkBn8c16VgVxxGYZGvoZ7rPeuCzWbl/2fopaVhnOvUHN/CBphG3zQ1eT9Zed7HqB9EFXff4DastyF+GKNNlUdDwYCKFxI5qWlmcsho/yyP/aZK64MbxEp81D/LZD6fg+iqmfcCNHjP79i7WKrrtis6MHdzM9/HQumgvLscfth5SLIBIXBXgWg+i1jUnBsUzzfwkcYVjeg3IuCFt8acOEjQSErgYbtnzkrUEUglOB5Arg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmbpmG4mCvSxolKMY71h6xciqiwuXBoWWCbgdNAHnHo=;
 b=vccezyerMHZofERf8ljlOM11bodvHOi9pXY3PdoM8O/yXhQU2nufE1kZOIBm+3jg1RubXn5Km6fbwTyIZ2UIysiY/I0CjzjxiMcEqCiQy+ZvC+SrfKDwvBTU46oNKYEgmHsJgSd0BhCaTIGGiuiXrFQvqBkv9gxMo6l1Lj2AGF3X0ILqCjWXIFPMGPQmPxlYMFbOi8k8RzI+CjTL2xw5UAqsnvbf0VlDjlhD+CkUUg/bUtODtHFCIt5cEcYDL7qf/WaBNjtie30hn2+vwdIefvGbb/VPGC9Gx+SDl6MrZy/zq9cJLqrSHwBJWL6wLbPOQRGjq/e6hUq7VuNzFg/jcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmbpmG4mCvSxolKMY71h6xciqiwuXBoWWCbgdNAHnHo=;
 b=oXsN+SQt6yTkqon+6wr21riJOpiqNpcQ9piiOYaJi+ZmeYOU6S74rrfzN9MSNRSm7T960qrQdjbD/Z8IiIBhc7SKomdMfTm716iwy/omQc6cz+1qa0oRP0oTkOgU22+81btCBfzH97lxOvDABZ2d3Ji0hzjw3fXfx+ad9vnrsmY=
Received: from CYZPR17CA0021.namprd17.prod.outlook.com (2603:10b6:930:8c::26)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Fri, 30 Oct
 2026 06:31:11 +0000
Received: from MWH0EPF000D8952.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::10) by CYZPR17CA0021.outlook.office365.com
 (2603:10b6:930:8c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 06:31:11 +0000
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
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:11 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:09 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 05/13] drm/amdgpu: set device-wide PMC enablement
 indicator
Date: Fri, 30 Oct 2026 14:31:33 +0800
Message-ID: <20261030063141.2773032-6-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8952:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb21f56-c3d1-48c9-b1bf-08df364f63d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261028144727099003|261022105027099003|11063799006|56012099006|261022075727099003|261009223027099003|261021121427099003|10067099003|261021123027099003|261026140227099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RNroVkbhKh75nVgpbwoLW9dLz+jxJjYYbtDN0K04P/t+4R3JVfy4DTx4eRTEtaI6ryrZwMiCKL4y92lZiKwoOKvM+mW8j/XwIWX695gySrC4b5VJkosIomT4OHJ1oMWAHfxfTQsKm31Ithp/PzTNSoHHwGbMo/C6gs8k6fQioRMmgCC7HiDOXlcOscTjMQDSfQJVDgjADIr/ciVmFM55RjTTsWvQEZ52ZS6RnAx5zbGYClYs65Tf42zQMSyr8HoZoLdtvOAWNPqKAlpt1khnnmHUOd4KaytjTiHRW7oZdYd1pVwYv4nNqZSXCJLepa2NfpTe7YmMVjNqZuqINrF/YQOzbFmIhTqXqVv+YprTYgpPv7iZy6+0M3OuqIBbEJN1ZHGaYuNnDr3Ms3NeeqyC6j92RlCkmjtDPTBSxGt3NjKBEvJ5gsHITbYmOfIZeKd3wzUlLihqrBElZ1Vb69cbZDD9Qw7iSsElkjOoH2k8WA01Xm95P9473/0y7gxkHnb9rHdEgc6GWa7z82U6TU4ZV02L8Yvh4ZdPVcBxTbbnTLFhOGHNJB1WYE1KNwpYXDK1mOIh1m46hzB3tPnlEksiNbzkxVSkph+UtfrGbcc4hcGErAe/nz/m3Rvse0kKT7zEdrxyWrjX00nuy4HqX+Z0b/8m7Q3LH3ErLvYPZ09vhq5EXDORuBqD9uFDv2476mABMo3muvs6ozY6RQgxWFLsXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261028144727099003)(261022105027099003)(11063799006)(56012099006)(261022075727099003)(261009223027099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cVZMi2OHIefecteA0cXSoXsHkQdqwkMTzeukCBDPCYA94/eHCsWFnit+w+TqIvZrcF3RZ2YRHd//NdhjDS6BUnosZ+IAMZK8agy1btfqXOQgCylgVk+kgzVKEapdDKec/w2rmvKEHI1ap3uTblIB3WPWA54SYDQNbVP8tKe3LkEOJUUY9nwfhzJwRjiqcmoAwt/P/g72zFMGmmCnV8Um7Srjwn2F6PvKkJOKz0Q0J6NoicoqkokEolPSsmuVuXGUX9PynAL5PoMWC1+pFxJFWakhLksf42rvvpSpGqFNZojiDCKcYSk0oBM+dH9iXEDmtb18A6JP59u/S3POjpJDxdHKBfdpI9aS1fOfz5PxWnwkoRjyrBIfqZaqh2yMvCpZqBHeMaG1iPdb21Sna/501OiEDSqJ7NlR1Lo8sZD3Vz3LJHZxg2D8o5Tu5fE2Hz+s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:11.4161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb21f56-c3d1-48c9-b1bf-08df364f63d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8952.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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

This commit introduces a new function amdgpu_profiler_set_perfcount
which sets the device-wide PMC enablement indicator.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 32 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  2 ++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e441eb171c1b..f10d6ac49bd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2988,6 +2988,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
+		amdgpu_profiler_set_perfcount(drm_to_adev(dev), file_priv, false);
 		amdgpu_profiler_release_device(drm_to_adev(dev), file_priv);
 		drm_dev_exit(idx);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index a15149720d52..276dc75f0e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -79,6 +79,36 @@ static void amdgpu_profiler_clear_reservation(struct amdgpu_device *adev)
 	mutex_unlock(&adev->pmc_profiler.lock);
 }
 
+int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev,
+				  struct drm_file *filp, bool enable)
+{
+	int ret = 0;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (adev->pmc_profiler.owner != filp) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (amdgpu_in_reset(adev)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (adev->userq_halt_for_enforce_isolation) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	adev->pmc_profiler.enable = enable;
+
+out:
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
 static int amdgpu_profiler_check_access(struct drm_device *dev)
 {
 	if (!perfmon_capable())
@@ -127,7 +157,7 @@ static int amdgpu_profiler_pmc(struct drm_device *dev, struct drm_file *filp,
 	if (ret)
 		return ret;
 
-	return -EOPNOTSUPP;
+	return amdgpu_profiler_set_perfcount(adev, filp, enable);
 }
 
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index 048ce84f0ef2..532aa7881191 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -30,6 +30,8 @@
 
 struct amdgpu_device;
 
+int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev, struct drm_file *filp,
+				  bool enable);
 int amdgpu_profiler_release_device(struct amdgpu_device *adev, struct drm_file *filp);
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
-- 
2.53.0

