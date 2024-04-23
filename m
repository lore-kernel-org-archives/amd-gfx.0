Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EB7C41513
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 14:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D128113420;
	Tue, 23 Apr 2024 14:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1iSgdx/B";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A864A113420
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 14:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqmqFFg06FsIf3GfEICKVr/67FORRn8+6CYsSFjba3EjDfKDTe/Vl0R1i0tfyOMC0/2tQ4BC3LR7Pd4BNSScK88VibyDUXHAvPGEaK0M4gfbeS6tJEKhtz5qKZHr6/GIOdCBknCL1dpVCTKB5ycv877i9N1AB2WL3sGpc/PxoNsePPe0ndFKL8RdfzVGEvD4sQt9RbefiB4Ljh8J0QCILy4E7OcV1Mrz8z7g5YKhR+8bB4px0Mvfy2Tbo4709LI6Yt7M04aDx3P+QTz9ikbqDFk7A/GR3oDSoQ1dzCgZmVZLDXco7swGCqauOgb4xz2W6CvVAPRTVOemQpILo/7CBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnUrQsMPG28gxFA+MsiM1xMk6ODP4gMKLbPewMI+vNU=;
 b=SiiHEOFVC63eLYL6n0F+gpNF6PJVUVAZuegOD1WFM1iao3a2dT5sLQO4gIFgbFe0txgj+ip5lRi8JbxkhHDfP1wqrLzLoOeEJ5upG7wq2xYAhbiE1fki0zOdO31NIX3nEDfW8spDpoGWtoCaUBaiUpC4d/Aer1JQcDCwR711De7vaYyPRFYHpBOs0y/0QFcHbvpgesxcd4m85264eHueXsY6iY44UPg0IPjaEBo+uP9PVoXR+rPV0lLyijXEazl22WqwOOdrbeycGAVS3c7N/C4fKCTAP9hVtUjVl5tOqgJCxHytQcDpIDKFI/vAoDUqQvp1tLMc3hwAaQpKXVnRfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnUrQsMPG28gxFA+MsiM1xMk6ODP4gMKLbPewMI+vNU=;
 b=1iSgdx/BnKBRLb8bsLZ6dd8SE+8n+7UpJA0ealBgPna2si8CEMrhlRwN3iKxi13XLkkQ4U1xEC09DCxE2NFGgnm2QJBQsksWUNoTgRR4zkYK8WpyvXKoOfISOpISDuvL2JsHE6awkz9iTm8Sp1mbGxz4r1+U+zGfyNEOeqv6NrM=
Received: from PH7PR17CA0027.namprd17.prod.outlook.com (2603:10b6:510:323::13)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 14:45:16 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::c4) by PH7PR17CA0027.outlook.office365.com
 (2603:10b6:510:323::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Tue, 23 Apr 2024 14:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 14:45:15 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 09:45:14 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix two reset triggered in a row
Date: Tue, 23 Apr 2024 10:44:56 -0400
Message-ID: <20240423144456.45941-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422194550.26148-1-Yunxiang.Li@amd.com>
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b9e57b-1787-4d2c-aeb4-08dc63a3fce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dCscqL6y7HUSiS16VdUWReIJqsk7hQiTAs6xvN4Mz/oZcvsWXCbFLkQM/f+h?=
 =?us-ascii?Q?jEnEXGMzEQcf/j0g+hr7S51iPRqpdCVByHbYUK488CzmzbbWRLnQZpeBvWWO?=
 =?us-ascii?Q?c4pR8cZFmEgeUyn85I+WgJx6PCtKAO+c9pGQzqh1TE1iRY3ceaCV5orq/nQp?=
 =?us-ascii?Q?zm7IeW96X9cJCkk+2VOqdiKtsxNNSMp51v/EuF64RqQAzR0SCb310Y9yVcYe?=
 =?us-ascii?Q?X91BIZyDeadRz03464NrbUl+bfaBvdml1jvuG7Cqu5vtvtl8f7zlPyVCIFHL?=
 =?us-ascii?Q?sMRdI0/SOOaiHfmR0x7yazt84WIltrY5+eXdcEMgwydUWij8qSw6g3Ea9JGs?=
 =?us-ascii?Q?l+nNprjZXAor6h+j9ZGBhJKplkoK2mvrY76t7aY6Qd2fwtrdQ+bBQUNtOS3D?=
 =?us-ascii?Q?1mX3FBXkZFyU4LSqfRrWzrgID9WpmO8SbTRyTCLpOu9NHSkzelRQY93gmdW0?=
 =?us-ascii?Q?70fIjyJfWbua9juzrklAVi0+zvP5ZIzj9gNP3EhqwZM3/RfTQq6pkrfA4YpJ?=
 =?us-ascii?Q?lXVd4/s7Uy+7m7AnaBzuMBTsMVGDsANDkiH3/kpwnqgomh7XfUqkNnugOTPg?=
 =?us-ascii?Q?5n+gOjQImp7+I5c+tAne3askwFkXXURJObDoSR9r4X8eO3hSJvs34yuhvW+5?=
 =?us-ascii?Q?mTaQ/eHhi+HY5Z6pHTe+PVBJyt6Vu2wsB4KiFQn7DT8CrE/29Y0679tnd5cA?=
 =?us-ascii?Q?G7h5KYZcPxhuX1Xh9NeC4dHgGPOx7LlUylRalKHawH0pSE1j7ncvGQIPIIzx?=
 =?us-ascii?Q?PdxcMqIFPhpY5ITa/M6EiPaSJEcHxSfFt07FNo/7mz32cu3X79ckxP7TdPfI?=
 =?us-ascii?Q?4lxJzTZAL+bbXt1Q9Vhj2xw3B6peZtgi1uMtEJlHVRqr83u78QjmRA9DJyfm?=
 =?us-ascii?Q?V6LZ4MI84Mnu+EZvPxu3Ud0TEls1RHIAIXf7V1L3yooRpg8mXhaCoNPeGm35?=
 =?us-ascii?Q?LhSoJS19KxgcajD05lLIn1KMEEKqhmEnVjZrQPlKnoUVjuiX9ftlBQO5lzy0?=
 =?us-ascii?Q?tM2xo6es4tyRdX+5Tsi6vlXNAyUkCn7ACxT+aGL41yTTWmxVIIZv3z0XB8wu?=
 =?us-ascii?Q?z/DKuw5iQGfCN9vR9VUqMP/U4cR3DfIg81mn88QPUnbt2FS7bz42l+7AZVwG?=
 =?us-ascii?Q?Az1WGRk0WCGLvlBXniYgTvYT2oGftfGLEgb9LrXx5+gNuq7dGJkAtZ/8wZ2m?=
 =?us-ascii?Q?CspIY+aEYnRtMTd4ySwvxgi8czHmGkUSR9uc29r2ugdeXKn17LN9ZZe1pY4K?=
 =?us-ascii?Q?ER3AcNw9PIoSxstjTlhyLFlKt0NX7ZOAbA2pqNoIuDPnCeAw5hLed3Glaw72?=
 =?us-ascii?Q?8Hv4JNaeSO/olAG+k5fu98k1cr83nDC1MG6qjOcYp882Smv4NZVW9qKOu32w?=
 =?us-ascii?Q?fbpm9ZyLzwypEQe7IAr7ahu69FdN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:45:15.2782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b9e57b-1787-4d2c-aeb4-08dc63a3fce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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

Some times a hang GPU causes multiple reset source to schedule resets,
if the second source schedule after we call
amdgpu_device_stop_pending_resets they will be able to trigger an
unnecessary reset.

Move amdgpu_device_stop_pending_resets to after the reset is already
done, since any reset scheduled after that point would be legitimate.
Remove unnecessary and incorrect checks for amdgpu_in_reset that was
kinda serving this purpose.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: instead of adding amdgpu_in_reset check, move when we cancel pending
resets

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  2 +-
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f8a34db5d9e3..28f6a1c38b17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5061,8 +5061,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
-	amdgpu_device_stop_pending_resets(adev);
-
 	if (from_hypervisor)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
@@ -5813,13 +5811,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 				  r, adev_to_drm(tmp_adev)->unique);
 			tmp_adev->asic_reset_res = r;
 		}
-
-		if (!amdgpu_sriov_vf(tmp_adev))
-			/*
-			* Drop all pending non scheduler resets. Scheduler resets
-			* were already dropped during drm_sched_stop
-			*/
-			amdgpu_device_stop_pending_resets(tmp_adev);
 	}
 
 	/* Actual ASIC resets if needed.*/
@@ -5841,6 +5832,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			goto retry;
 	}
 
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+		/*
+		 * Drop all pending non scheduler resets. Scheduler resets
+		 * were already dropped during drm_sched_stop
+		 */
+		amdgpu_device_stop_pending_resets(tmp_adev);
+	}
+
 skip_hw_reset:
 
 	/* Post ASIC reset for all devs .*/
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 54ab51a4ada7..c2385178d6b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -597,7 +597,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	if (ret) {
 		adev->virt.vf2pf_update_retry_cnt++;
 		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
-		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
+		    amdgpu_sriov_runtime(adev)) {
 			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
 							  &adev->virt.flr_work))
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 0c7275bca8f7..c5ba9c4757a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -319,7 +319,7 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
 
 	switch (event) {
 		case IDH_FLR_NOTIFICATION:
-		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
+		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
 								&adev->virt.flr_work),
 				  "Failed to queue work! at %s",
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index aba00d961627..fa9d1b02f391 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -358,7 +358,7 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
 
 	switch (event) {
 	case IDH_FLR_NOTIFICATION:
-		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
+		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
 				   &adev->virt.flr_work),
 				  "Failed to queue work! at %s",
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 59f53c743362..14a065516ae4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -560,7 +560,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
 		r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
 
 		/* only handle FLR_NOTIFY now */
-		if (!r && !amdgpu_in_reset(adev))
+		if (!r)
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
 								&adev->virt.flr_work),
 				  "Failed to queue work! at %s",
-- 
2.34.1

