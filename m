Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038F9CDB470
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B17110E9F2;
	Tue, 23 Jun 2026 08:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TsQlktVk";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E5210E9F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 08:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjKQW5h2IDX6v3LPhaD9JgbE7KMDrb35Yz14mOYtM7SOwPWw714EWR2gF2rQxGsh0+eZYG9lkdqyqa5YIC/TqpTnLH52Jv57lMGD1BN1oPwdXDhBRjzQDESM4QFNo4/hoKMwjSrvdABuHWxUMPMjCZvXtWOmcPmFPYhyfBQKQBob9C8sGfoncfpcEd672yNZiOnMm8lihH/FSU6V9/4OWs4I9OUfsXV+lYxpTom5mZaqW9sOnyo7BA2m2WY43NROpWWqxHDYFWOlkxreICfWDwalG7nyjZgYhefPQaJntdiOAuu6PQYPIgtrAYJ7W1R1hpWk8gVl0DaPAEKLDORpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45lLux5ZJPRb5B/9STrrerhivqQ745n+xzDYfYyB8yg=;
 b=ojBkjJLWLcN86OyqMD73H0+kn78HrSBOIvqhOZKieTrxqp8ZIceL6oSpAoEY8gjnPde4O0n3+zRE4PHe4jUKBFCBoIN1BMRX98KQphs7pzIVNiBpIdXdfis5o+2ZwUSi26ozuZUTxDQVHAHktJJg3wvm6xnAU9U4Dr/gVr71TCtPCxSb4DL98EqY/i/FIeL2s/gms2jxiKZXIH/NkBCECXpjbNe49Tcp4SITdPnOXMjvkZl74ItiqqKluCXjKp/8lNexLG/It0ltTqfI2SejKtywsGZhP8L6o4TvPq4eiZrrSjO60R1I01L8x14om8FGITHmdh9dGzzz0df143SMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45lLux5ZJPRb5B/9STrrerhivqQ745n+xzDYfYyB8yg=;
 b=TsQlktVkmugiY/LLse9wfKu+4X7qZOXBYGzYVdoyaDw4U2v2EZ5cnRh6buLxzoXB+KJ9Qi+7e60lAQ35tPTbZegwi75iRDSWGr4zqKE6bITl28vtB/zoIzGxJB/NP1acB40Xb5z6zFLkIlGF/tcGRAouC/daeuGaeN2QaQOGJXg=
Received: from BN0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:408:ec::6)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:13:22 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::80) by BN0PR04CA0091.outlook.office365.com
 (2603:10b6:408:ec::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 08:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 08:13:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 23 Jun 2026 03:13:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 2/3] drm/amdgpu: Register DRM fpriv PASID ownership
Date: Tue, 23 Jun 2026 13:43:00 +0530
Message-ID: <20260623081301.3046023-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
References: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: c108b26a-176d-4295-9cdb-08ded0ff4ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: n4VKx0LkhIyel4Cml1N3JBpLat2UHz0yioJTzL1pZOdLIM8IPW281rmszyUc+A4elo8sbFsXlkb0wnr4U+ZUNS05K3M4/opMylAhS/CzCry+66+Q+08hl9We5uoHJFimJpbxujWEBcxJb586USJ0NWeenCcY5aMtsiiCSeZoNvNPmZINVo1vSEtKjxLbFXYc7Air2/VJSZQt/9VnIecNnZs021uhAqp4YanP9z/C22/6CEu0a7N6m2THC01qED4ubR0jCYFxQVvw5mZ/3DiQfrIN0H0Q4fdcnrirKIh6/WJi0aUzN3SZEX+WCCM43wnvDyVdH3xKBXR4rXxIJ7oWCtVkDd7zgMu7Qe39EljxdS+t2kya64ICPl98FDdCJmIO1cuJW3usnKaxW1y4/rcdHEkHOPfV5rnCsZ1yNyk6wNh7nOGOPFuMJECCyWK0NQ9ppa3mGzQIrWSC6GQF2mnJFpNg3MlkcQ9t637N5M+vfEJMSx3CUz0X3aDfxmrx6/OXiOR/pwrkdNpWs1nA6apeVIM0Y6pWqHhVogERKIFNTpxZER7oAEGv9ct4XY+YLT+89PW6XSj0Rz6z3w8AYDLkj+zVawf4WzMwkKZFOueAHhqZb3VEZpCBEpziJnmENCxmd9dafpiK1fXlx8SnHi4n/I8gTPZelXMVq2mBoV3A7OWCy6OriVhirmc2qhmB4CelPhStHvNRPCXBBYxck8N/Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 15zzIprkfQYBgB6uJJqPTmnq+6x3mH7y8dcO7hq+8K3QWqYmYZV0PX4Vo1/ooyik33lFeOmfsLhPiCOvsMOMPvV6H8EGILzKV6x46bWp8JcdVBo+JJFjm8rTUtygdAwiTD+GE4OMRimd/cnE4r7W3fe9K9gT/+XsxGSG2ZJluoKNiBY/imrRA0KcdDBV/A5pEqf7yR0FO7RmCPV9dUZn6/0yzhaHU8jYo6Q6+pWx9uJhivTzT+AIapv0Hmc1ZJs6LP/tFsaqzl0uTc1zGXLS7RqcvJr8NkCHeC7B/W4Ucuyh1n8jvPczR5F/nv3hJNNdR/VLxHc2vOwrQ90/C0FqHQCdd1eD/k1cqrk25qgmAHilLGd6RT5QnqjkX3oTpzJRTQBmJi/Vc2AU/P7dDJTnwf5p+aKT4h21DObF4v9XoeXjgi9z+1yUQT7NN1uhPw1H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:13:22.4532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c108b26a-176d-4295-9cdb-08ded0ff4ae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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

Register DRM file-private owned PASIDs in the RFC PASID fpriv lookup
table.

This establishes:

	PASID -> amdgpu_fpriv

for DRM file-private PASIDs.

Registration is done after the eventfd and context managers are
initialized because future process-scoped event delivery is expected to
route through:

	PASID -> fpriv -> eventfd_mgr

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 12 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 41 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  6 ++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cacdc99b3ad6..333d6b5239bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1542,6 +1542,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
+	/*
+	 * Publish PASID ownership only after fpriv-owned
+	 * event state exists.
+	 */
+	r = amdgpu_pasid_fpriv_register(adev,
+					fpriv->vm.pasid,
+					fpriv);
+	if (r)
+		goto error_vm;
+
 	file_priv->driver_priv = fpriv;
 	goto out_suspend;
 
@@ -1584,6 +1594,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	pm_runtime_get_sync(dev->dev);
 
+	amdgpu_pasid_fpriv_unregister(adev, fpriv->vm.pasid);
+
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
 		amdgpu_uvd_free_handles(adev, file_priv);
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3141ae1383b0..5f1b285b8445 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2892,6 +2892,47 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 	amdgpu_pasid_mgr_cleanup();
 }
 
+/**
+ * amdgpu_pasid_fpriv_register - register PASID ownership
+ * @adev: amdgpu device
+ * @pasid: PASID to register
+ * @fpriv: DRM file-private owner
+ *
+ * Register the DRM file-private owner associated with @pasid.
+ *
+ * This RFC mapping is intended for process-scoped event delivery
+ * paths such as EVENTFD and WAIT_EVENT.
+ *
+ * Returns:
+ * 0 on success, negative error code on failure.
+ */
+int amdgpu_pasid_fpriv_register(struct amdgpu_device *adev,
+				u32 pasid,
+				struct amdgpu_fpriv *fpriv)
+{
+	if (!pasid || !fpriv)
+		return -EINVAL;
+
+	return xa_insert(&adev->vm_manager.pasid_fprivs,
+			 pasid, fpriv, GFP_KERNEL);
+}
+
+/**
+ * amdgpu_pasid_fpriv_unregister - unregister PASID ownership
+ * @adev: amdgpu device
+ * @pasid: PASID to unregister
+ *
+ * Remove the DRM file-private owner associated with @pasid.
+ */
+void amdgpu_pasid_fpriv_unregister(struct amdgpu_device *adev,
+				   u32 pasid)
+{
+	if (!pasid)
+		return;
+
+	xa_erase(&adev->vm_manager.pasid_fprivs, pasid);
+}
+
 /**
  * amdgpu_vm_ioctl - Manages VMID reservation for vm hubs.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 5318e833bd97..333bf14cce6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -513,6 +513,12 @@ extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
 void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
+int amdgpu_pasid_fpriv_register(struct amdgpu_device *adev,
+				u32 pasid,
+				struct amdgpu_fpriv *fpriv);
+void amdgpu_pasid_fpriv_unregister(struct amdgpu_device *adev,
+				   u32 pasid);
+
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id, uint32_t pasid);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-- 
2.34.1

