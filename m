Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A4606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yuLm0pJb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E01510E791;
	Thu, 29 Oct 2026 04:09:49 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4476510E791
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 04:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnQ/qlmyYj7B40mcXAH0ydEGlrChNlr1cPIbvcrFKu0mvDsoT8scqAEyA8Km0ttohLKGXXZSc55UjZBCjCcSpF+xCYagBr9whPSe5VhQ3UhsoxAom4XTOBFBbCfJQ7Ayyn8s0lzD2H4XzsL/ek11GRwim8ySZU3BVFgEwAOq7LJIvrLtPaY47RuF7OmedQrWXwHee/u29OV0KQ7V2FHgYYGT5RidX1Pjoh8U3YDnahxJP1rwnwy6e13RxLk5U9kPsmFoCr2b4ZfIfAMYmnDD556+kjBzHdWg0v/kLyfriZsdTH+1JdoSMLrZ44K4ZJrSXL40lxbHDyXbii2RFhUeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6Onw4FQOYsT8C73kUaUm3/ZtSIpa32bnkp1pXP801U=;
 b=JYXoKpGAPtiLVvmjZ2k9zq7pcHHX58TVD6O13kOQ1EnAi02Bf5cIzz1C0nmkyRFaG/5GSvZyt6SlW2u380lvDXqOkAjnFdGkgBXcLel0TZPo6EtRL6B5B2ItyKaLwQ11pDVeZYsWnkIBPzwMUfI8Ic1dpAKx0/4P+X4C8tu3bb+BldbEKDgv5OmNCQgkl4x2Y5BFHpSFHYDNrVEA1H6perhlPO/p5wgXLrIn7yFcAnRdb3p3zS30+hoE8/hXbYpcTqzFngtnExzGAiVxt9iMeaqDHUfPJjH0CxeS+QioDdmGdTYgod7ZPkjN6Fy3Pb0QBInsgq9mC+HrQKgEohYrRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6Onw4FQOYsT8C73kUaUm3/ZtSIpa32bnkp1pXP801U=;
 b=yuLm0pJbT8rTdrHrLaLl6c04jHt2wLB598+I0PxBRxxzj39qBLcKZ8bY6x7ahZt+UqS/87glTqsU+sAjKnSk2lpw/ALA8QFBVgCdLsCgZd4jALePyX6qwTF5eQdX0NKG8XBvIsOECJq0o5xQal4kT0/ZkbMgE3bcE5MKT1hdILg=
Received: from MW4PR04CA0236.namprd04.prod.outlook.com (2603:10b6:303:87::31)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 04:09:37 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::5a) by MW4PR04CA0236.outlook.office365.com
 (2603:10b6:303:87::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 04:09:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 04:09:37 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 23:09:35 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: remove pm_runtime from open/close kms paths
Date: Thu, 29 Oct 2026 00:09:22 -0400
Message-ID: <20261029040922.3911530-3-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029040922.3911530-1-shahyan.soltani@amd.com>
References: <20261029040922.3911530-1-shahyan.soltani@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b920b00-e606-4bc3-5e66-08df35727276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|261009223027099003|11063799006|261021121427099003|261021123027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: KjhuvlHR9yArnuWcstHMYlnclnliFac95Ngnt3Zhnnj1a2I9wfzYItjPpDIUnl4NQrVFKXvcWrTyL9iU3ihTRezPg+WNHNgiaBAMddZaZu1Q4ZLUZbQ17Jqtx0bECBsgkuA05HpfxO2V9TpyFVVzFiV7a+aR9aaX+7TZZHZ4NWdXs4WFYVbbX5sgG1gVTYZwxdCGGfdtfbIWll4LsRnoi6OHg5TOc3J8eslwFmqC5n1Is+x2bgu1DQnn/koKs3LZIjAT2mkxDwkmHZIbSD6WzhmXz7HhLW/cWw6NiaQlucEItNV+N8uJqM/PF0Yd7pEV89MjPkE9L+Ntiu4PLsepTCd77O1JVDSApee+R0NEGg9flQzoBMafFO+zPu4xHtrvTqC8bh+WwuokONGlme6mNBN2yOv+7TvA9RDsxljoXC6s8mFQya/SP1pmqLgpeQbyAiIFw/TZQQ3aE08Go37aO6JQaxJVgYjiIxbuHAspItWa0TqYOoG7tXISrb3gAzDFSLZ3RZd4MS23DmXW/Xf3tShe8c4WE0pLLGZrYcipsArqyEKmjGOW6RSAlR7uRECCIeYj+0I9Fep4Wnst2Wg03oUpMfy8FAdmz1FNwvSz9JFq3OeJ+YpNKDvLODfFkoej51uZMxHLYO6EEYJ2iSWe/OizEFFXYspVR0gfQqS3b+MpDT83Tml/rRMpdlfy6yd0NlMJUKfRdQaXMBkSu0Jmgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(261009223027099003)(11063799006)(261021121427099003)(261021123027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3ogiTsMEdTugb5oVBsPU45cNuG4de/BZ6rPD2dxexSDSBFeugnFCscyKvojygbMmUrP3mEJVtMCpW2FuITNXHZagtD65dWVG0b0oJfKEe/sdxArvBJoku2ZnG/1QSyF+JmoiUij0zbYw1EdvM+8JrFNvxbpXAv+UU1NB7HZ22O4dmazo4S75/WipJRIVHWnKoUKHKjkGNpPMtRAPR6inJA/In3s4Hp4/CVRfGDLk9rIgJK2lGoA9b+/bXTkppL6El6wfZ39MR1XHIp6c5BO3i2CRGtzAQx9vPSW8R40g8LX4ikASa2+SMmASd3P6fmgAjjpDLoVVV8Q1V2/yYmk4OSew4XAf3dGeEN9rwEe/Ko0se08gRjpoSquKdsWL4J9SC5eNQOkZKk55ybLLOnmn8YFaNEZZcerWcE/xA3E7WoxE6z3UHEDyfVdfsbRIWmgx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:09:37.1448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b920b00-e606-4bc3-5e66-08df35727276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
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

Every open system call for an amdgpu device holds a runtime reference
and resumes the device from a BACO/BOCO sleep state even if direct
hardware access is not required.

Drop pm_runtime_get_sync() and pm_runtime_put_autosuspend() from
open/close KMS to prevent unnecessary resumes.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..05406c9ff370 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1506,7 +1506,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	/* Ensure IB tests are run on ring */
 	flush_delayed_work(&adev->delayed_init_work);
 
-
 	if (amdgpu_ras_intr_triggered()) {
 		DRM_ERROR("RAS Intr triggered, device disabled!!");
 		return -EHWPOISON;
@@ -1514,14 +1513,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	file_priv->driver_priv = NULL;
 
-	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
-		goto pm_put;
-
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 	if (unlikely(!fpriv)) {
 		r = -ENOMEM;
-		goto out_suspend;
+		goto out;
 	}
 
 	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
@@ -1583,7 +1578,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
-	goto out_suspend;
+	goto out;
 
 error_vm:
 	if (pasid) {
@@ -1596,10 +1591,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 error_pasid:
 	kfree(fpriv);
 
-out_suspend:
-pm_put:
-	pm_runtime_put_autosuspend(dev->dev);
-
+out:
 	return r;
 }
 
@@ -1624,8 +1616,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
-	pm_runtime_get_sync(dev->dev);
-
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
 		amdgpu_uvd_free_handles(adev, file_priv);
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
@@ -1662,8 +1652,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	kfree(fpriv);
 	file_priv->driver_priv = NULL;
-
-	pm_runtime_put_autosuspend(dev->dev);
 }
 
 
-- 
2.56.0

