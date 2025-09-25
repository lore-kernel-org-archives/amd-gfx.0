Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9610CAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 06:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B6C10E84D;
	Thu, 25 Sep 2025 06:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+Q/YKGm";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013018.outbound.protection.outlook.com
 [40.93.196.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC5110E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 06:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dp9bGr/dTbiCkw8OMHzJmE87JvVDfJQxInryATu1fxObp6U2J9hwa1n2XaJZetV3wl3xrXrUSE1OBsPiARMkY0MDAMzAUZLBjpgoSDfdVCPS4cVJ21TlwxfEI4vyOoIz8BHAyiCkp2DJ6XSZzxtQjAiIZu5nF3z6IV1J7KgZ9kyMXaMsT2ncQGzA28/MkbDvyfhoLBIyzpYYoVDir2PUL20Bw7V9nxMAEyDYcULCxJ4Zispp9Rr3RMCLMFBW6G823UynYzoCEcvKguvGwUpbAd2PXbAXUVec+vn4YKLYVoJ1B5OhqlScecw5iQ2R8PYw29eSK2bI8g3oaJ2ljcwSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsBh/+mQpSFl3t56naI7gocT7TYOY4Nhcq8nVWjdtHM=;
 b=nzACO2P/Xg4dM0yrB4pzmWD5HFY9mIOV00FhfPkwTIRb60L7GL8uFckvhgF+qRn9SfRkZSrimJ+V3KWTObSTt2r5EPURHcn2kimnUI7CGk2Yq+8OLmgXgXpOBb8SH1x3VeybFWe0WbQvbRHZel/XGkk9uZ6wXSy62mSYQF5NxtlAKfBWJrnyzXMsbsYFyRmxTwAHo6ctl66T+sohvwjKOgBJPd2Y+UKp6i3dsUVp25kOEEcUE5f9bBSa2jOGcedAeSBYBK6TcK/8oFNcOvTAQP081H2k4QgzhAsBseKKbRmuIggzyyPT+EAY8uCXCosSn92eoDWIJ8RhOb1aQ4Ip6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsBh/+mQpSFl3t56naI7gocT7TYOY4Nhcq8nVWjdtHM=;
 b=e+Q/YKGmmh+FJO5jqk8yd+Y4xvhz0fI0f3x9el0JntW9aOwPJcusskB4JHJdJUW0mF8/PmPX9/usQmGV06TKQklgXlvCJnf3aCYpyQNjyXbPLdbU/Mm8NCxYVSmdp7spuFNj1LSrhgUncBcXLAcej5A2F09SHJ91OftCDlB2LaA=
Received: from PH8PR05CA0007.namprd05.prod.outlook.com (2603:10b6:510:2cc::18)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 06:28:13 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::50) by PH8PR05CA0007.outlook.office365.com
 (2603:10b6:510:2cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 06:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 06:28:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 23:28:08 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Sep
 2025 01:28:07 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 24 Sep 2025 23:28:06 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix locking around amdgpu_vm_set_pasid in driver
 open path
Date: Thu, 25 Sep 2025 14:27:27 +0800
Message-ID: <20250925062800.2817390-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ca5e8e-1963-4a3e-d94b-08ddfbfcb420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z7+A3UiLYliYa0GTL8G0afE5NvSu/iKYVURJUQeaHm6YtTxH3XaKIbR50nU2?=
 =?us-ascii?Q?n84M4l7XpTFwCWL51Epjy4ibpPpmcw0WO8RnExhQDyqbT42AbuvIpV12lO6t?=
 =?us-ascii?Q?C8AOuZnnrbvhgaRf2cG2Ycje4FGq+d01L5sS9V4Ex9UodyowieEDz2xglUqG?=
 =?us-ascii?Q?j7LkvWzDPcZTj8zQHYn2zdpXpQ4VEZDyLIsubXFjWD2MX95LcCpiya9HYyi0?=
 =?us-ascii?Q?W+9m9xw7APzJJerO87WEd174828fS8xD5EkyKfS3kneBxOxYeHEZetZSvST8?=
 =?us-ascii?Q?AjQydDZDOeSeuctVdlZcEHmrRjapm7V4539/oPTXOI+XUqSE7RvU8aRj9RBC?=
 =?us-ascii?Q?VLDohnEJcsYDNGxtsaUiKBsa455W+HQY18fA4LYD6RJKR/61tRwjxmHEnlOl?=
 =?us-ascii?Q?BA0GcaGERJa2qfka7F/kL7HyOxNYnj6usBO/c7Bwa5VXk5qCfN3sO3tTFMaS?=
 =?us-ascii?Q?bwDtdojGAxw8bYzHI0F6fA7y/OFzB83lstln5gY+3ui4uRGNGhupBhVfM9C6?=
 =?us-ascii?Q?iGYZlwvWYBo9gvfExp0RQljpVqSZ9SpgLVltgCat6LimLl00ESe4zvew3BVc?=
 =?us-ascii?Q?vts7RfNjeeOMVI5olcK1uHG+dYyvSbKsvsNi8lqodN3a6HAndk79CIZTJwgn?=
 =?us-ascii?Q?enrQzw/s2YRO8Bc7vSFblILq7v0qjcvEu8E0K/CFxP+ZzAfM6ZZ7URX7SVQd?=
 =?us-ascii?Q?nu4M7tbiKJ4n89Cyl3+yLTuq86v1yj3HU53w4ResSmrcVTokbhINPT/M7r0I?=
 =?us-ascii?Q?D+gfqp32DaGl3qjG5u40A72WMoWiN+YZMeAXx2Q8ZnZWFkyb/2Cf/vFjBpRH?=
 =?us-ascii?Q?N+3cZ+H3sIgfligOJsOUshiL5P+ZxlWQVEqLcIiG7YY+G/EdBzJYZcUPMWBC?=
 =?us-ascii?Q?MvtxLBRPUWn8V3QXHDnma8eEs1b6yatiGy/flLDh4QbxlJOU5uBvYZZgmdV3?=
 =?us-ascii?Q?Yuod/il0LSQwAAC2LV/XIPIfYt/309327JMwSOOsWv2WciUN8f8PYNe64RMb?=
 =?us-ascii?Q?e/fPXwuvg0teSd/EqYdIa87dXvOJwFMaqoqan4+Bgt845oPCbFOQzplLxVzu?=
 =?us-ascii?Q?ktFyZq1lf2F5eeKR6C4zRiBIQ5gLEjQEwoZtOqnsoPVfra+3iSi6kTQgvg5k?=
 =?us-ascii?Q?WsDLKteApR5roR6ydDc3tbcLLifbQimW92FVRqVi9Rmk4WXPuhxNmq/2O3b5?=
 =?us-ascii?Q?CnoSB3ZGH9F7c3H5GGQxjeQPDPppfZryPOSoGFKAUMai1+gKn/S7Fpez40Bi?=
 =?us-ascii?Q?RWAOUY0eKozNd/Oim2ojPFFxYVYNQy2Mt52514z1N4jCZvoTWpcpSMIp6vX1?=
 =?us-ascii?Q?pY1CvqcUOkmoCwMmcW70FR7ri0QW1pUd58yQdUEvEcMzk7zPAz795s9JHu+R?=
 =?us-ascii?Q?T7sPQRJ4uu0o1PnWIRcTNe5ezLB5zo80GfBwUpswDLpB+ZG7WX+rxpOtneQ7?=
 =?us-ascii?Q?yO/qYVkn2zaxt3j8Z8V+C0k5MIPnJAyEOG4QJqMNbtHYKrB/PeFlXjQBf+/D?=
 =?us-ascii?Q?36bnIaJRckeuurWkLWTcz96gZPlqnRtRJ0tZVGzZtQmfx9/UociFIe5TUD/K?=
 =?us-ascii?Q?vyjVcqkWJra07+Wsl4o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 06:28:12.7996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ca5e8e-1963-4a3e-d94b-08ddfbfcb420
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
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

The amdgpu_vm_set_pasid function now requires the VM root PD's dma_resv lock
to be held, as enforced by the amdgpu_vm_assert_locked check added in the
lock refactoring.

This patch adds the necessary dma_resv_lock/dma_resv_unlock calls around
both the initial amdgpu_vm_set_pasid call and the cleanup path in the error
handler to properly satisfy the lock assertion.

Without these locks, we hit lockdep warnings or potential race conditions
when modifying the VM's PASID mapping, as the underlying VM state changes
must be protected by the root PD's reservation lock.

Fixes: ebe038089be("drm/amdgpu: revert to old status lock handling v3")

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8676400834fc..e411dccbe612 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1386,6 +1386,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv;
+	struct dma_resv *resv;
 	int r, pasid;
 
 	/* Ensure IB tests are run on ring */
@@ -1425,9 +1426,14 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (r)
 		goto error_pasid;
 
+	resv = fpriv->vm.root.bo->tbo.base.resv;
+	dma_resv_lock(resv, NULL);
 	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
-	if (r)
+	if (r) {
+		dma_resv_unlock(resv);
 		goto error_vm;
+	}
+	dma_resv_unlock(resv);
 
 	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
 	if (!fpriv->prt_va) {
@@ -1470,7 +1476,9 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 error_pasid:
 	if (pasid) {
 		amdgpu_pasid_free(pasid);
+		dma_resv_lock(resv, NULL);
 		amdgpu_vm_set_pasid(adev, &fpriv->vm, 0);
+		dma_resv_unlock(resv);
 	}
 
 	kfree(fpriv);
-- 
2.49.0

