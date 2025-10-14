Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8795BCCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 21:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B3D10E20D;
	Tue, 14 Oct 2025 21:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hMIjaVLN";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D2E10E20D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 21:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JajjXYbADht+UdEkxdEfDSGj/cDUOc8fVzIkUYnkMSbxiMMH+aMHpXfMKIRJ1AmB3WpoMzhi5/OLgP9UChNwefaZkaeBYOBdPhW+F8/KoVihsLPN7A42ECDSZl9y6LCoERWIHtbnyt+P7OeHLzGcF7VbIXrzLzjEKaeKpY4Ahf5IuMivZDQXBc94VqKKwM9g9b7fxQ0JNs7fWgsk2taCCGASXGOu/CiUxTjXXC4tLUNtvtaiErkReRcSDOjptMRtJN0/GYOEPDPJmgoDFQ4xiquD0qf3Egj6Q9ib1t6L+QFLXkHXpDhVi2QEnI2+mfIonAPHMtrxj/rIVD8N/2FvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGS1JoW1LGmx/v9bN9sNx+V3RmQCR9EHA01EHKogENo=;
 b=QC5T9Q4aPGYS9OicazsR65lLu6O000qol4mF7kY327nuOCQdp2mJnYECRwMzPcZl+34fE5R6vFOLHihOp6loHOk7ohq8SsyciMlqhoWoUQP619U0hbUvAdfm7XfChnL5IDH1D+/BAmCJKqALP1uCGhkFrpGi4On7IDOo1z/9tveIHuZkDvesD5B9tcnWveXdqwaHkAdi0/M89mgoWAlABk15eJWxfZ89P3y4bWpRb+DO/X1bu468B+UYazndZhw1HbcYiegvtxJ75FWLBQj5x4WyIQYXRHvxtG/7DRZwNza5ejK0TkAxvtEmK3xBihgNswmMuceoO6K7NK3eCeRfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGS1JoW1LGmx/v9bN9sNx+V3RmQCR9EHA01EHKogENo=;
 b=hMIjaVLN9S9OeZPOenNxPN6fY58bexuc1s941Jdy2v54welV4EMGuIrKz9i+8kTQ923hQeLSAgKoVQFedcXDMQgUT+w0R5qopyC9shsY+yiEa5Xo6j9/l0VG9ZGvzhVBAb3RElzpFauZOC3jkLUl+JuufpEh553f/ZA5sfxJiy0=
Received: from PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::20)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 21:17:34 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::d2) by PH7P221CA0057.outlook.office365.com
 (2603:10b6:510:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 21:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 21:17:34 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 14:17:30 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: move reset debug disable handling
Date: Tue, 14 Oct 2025 17:17:12 -0400
Message-ID: <20251014211712.2524052-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014211712.2524052-1-alexander.deucher@amd.com>
References: <20251014211712.2524052-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f24ac47-d936-4801-38da-08de0b6717cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L8DhhxGB8snQZHflHYQeXdd3JRITr9vs1CTwZ7T+Es07IDZJvJ1pixo+fZL2?=
 =?us-ascii?Q?mg1mYus1sBLVdJPS4IZqy5PFei/NsslQdUEB62lg8E4eGRIe3Elnj1woVEet?=
 =?us-ascii?Q?SsYbMUWMlLC4Kysdps/zU8E1D0KfsfLjmG7UDKXkeXThxpVrg6EmnI9znn3c?=
 =?us-ascii?Q?L4HWMeWsza19MYcS3+ObqrHY85YLCVxoQz6q2iKZ48/qQoP9dP6J7/z4qA4y?=
 =?us-ascii?Q?YAAzFM92tKdhjfLlZBIqCfFPUwFx8117Xn+5PKvW/SFLRDo4d3S1VSBuOHqf?=
 =?us-ascii?Q?T3sThlTy8lDJNJyBrJgRsL3R5mFASyLCffjMHrxTM0IcmyNhr9FP0tsvfFMt?=
 =?us-ascii?Q?TDcIea9V5Vxke6/ewmgvAR2/YnSDpemroyC5fPZPMhBRrYP2bFFH9OOEVy93?=
 =?us-ascii?Q?NjhFxHTiXI6TGGn3OW5FDzB6dfaIuWkV71i2XXegJGfFV8pfAX1wHPbywogz?=
 =?us-ascii?Q?Ck5Hn9ETOOszrMC/Gi2HGUpYoMUAendx0AcMaCLV6HbWEHhb+LFvjUjr6hm2?=
 =?us-ascii?Q?THqCmqIoLBAhlY7aIHmTh4l38W4Pilj1AgzOKlVZ9B4zDGn9GrlvCznHiQX3?=
 =?us-ascii?Q?twhNTn//py7EKX/wJ7dgDx2sRPYLDuGrC/8VBuBVQghMoKCP0S9J8FAbK2v5?=
 =?us-ascii?Q?6f4v5Ewcq+4aE82idM3V0M2QvOyz9Wrnq+gXQH9becELxhT4pnmCI5cel7OQ?=
 =?us-ascii?Q?H98yiumqtxvh+CQhxs1oJPhDosMyMyCQQyzDUh94g0BfNaI6qqSEtUArE4oI?=
 =?us-ascii?Q?WIOTotxmScD+LFcUl6T9eX4sRqHl9s1fGSH9PtHt16nIRMx4sNaYSM2jeHGs?=
 =?us-ascii?Q?UTyWtLJUCqRzjPuyXAzCYsAf3Q5JMa96tGO9b5HxiThtLAR5d0VKLSNamDWN?=
 =?us-ascii?Q?ioo1pdGEJc8fDp5Zk5Hw31vg3lJXK9ms2m9jEha2Up+KQSpHSbDLi6ktSZou?=
 =?us-ascii?Q?+nD2N8PPWrr5ollIpLZVvMTjJ0I3M7KCMDd/FKMBghTl22acTEO/axhzDJi+?=
 =?us-ascii?Q?tUIRmITVJQHfESYaG3uExPAjG/sCLTfcXWbyBtDupWP8BXBY3iqRHT6PFLzr?=
 =?us-ascii?Q?27hprCCjY0ehb4/hUbFCFENMeDbh3zjYWI6cFGsoMwr+m4DVaxJYLlIstzJb?=
 =?us-ascii?Q?ow+JbKBAImUaX66n6fin1/mcuK8LNsNtsdQbsj08xH2Brbx1LbxU0EMPIbhT?=
 =?us-ascii?Q?WkMSZfxlhQNQhrDFGuImv9dnxwu8sFww4Z2KvJxKgCuPkuSGgfdFUomgxnSR?=
 =?us-ascii?Q?X4O9iX/R045LrVyQUicgZ4NiNIEyYvNMaWU60JpWPhYImVTL234GXUHBEt5p?=
 =?us-ascii?Q?wDIa+Ca3kFcUW49+b02baLokA8682kHoOIhdzAE90AI2VYil3520FaGemcRi?=
 =?us-ascii?Q?2h4qEfnNgC4twVxj6leWViipSa33U0ZRcdhR0qs8IpfpH8XH7DmEt2DL2wXd?=
 =?us-ascii?Q?tKjWSYW5HW/a0ZAjSvfSlAqKzzm7fCVnoSUb3LlNHBMvxUuAmeCtO4+cSnSa?=
 =?us-ascii?Q?xEwCpaz1vrnKCo5vZpusApVLbm7wyPENVLKI26tE02cYIhs3jioHK5kBxPjW?=
 =?us-ascii?Q?K7qELs1pTKmlIJL/6aM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:17:34.1535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f24ac47-d936-4801-38da-08de0b6717cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
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

Move everything to the supported resets masks rather than
having an explicit misc checks for this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 3 ++-
 12 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3842a15e2df8a..3d396ab625f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -130,11 +130,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 	/* attempt a per ring reset */
-	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
-		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
-	} else if (amdgpu_gpu_recovery &&
-		   amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
-		   ring->funcs->reset) {
+	if (amdgpu_gpu_recovery &&
+	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
+	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
 		ring->in_ring_reset = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 43f769fed810e..bf1b90a341d8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -468,9 +468,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	ktime_t deadline;
 	bool ret;
 
-	if (unlikely(ring->adev->debug_disable_soft_recovery))
-		return false;
-
 	deadline = ktime_add_us(ktime_get(), 10000);
 
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d670cb48c0319..f7357673f13e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4959,7 +4959,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
-	if (!amdgpu_sriov_vf(adev)) {
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->debug_disable_gpu_ring_reset) {
 		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a1ce8f9e04ecb..60250503c633d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1821,13 +1821,15 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 3):
 		if ((adev->gfx.me_fw_version >= 2280) &&
 		    (adev->gfx.mec_fw_version >= 2410) &&
-		    !amdgpu_sriov_vf(adev)) {
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
 		break;
 	default:
-		if (!amdgpu_sriov_vf(adev)) {
+		if (!amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a923f1946fc23..d405ca3c01b66 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1548,7 +1548,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 0, 1):
 		if ((adev->gfx.me_fw_version >= 2660) &&
 		    (adev->gfx.mec_fw_version >= 2920) &&
-		    !amdgpu_sriov_vf(adev)) {
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index dd19a97436db9..7d0a2d239b78d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2409,7 +2409,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)
 		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fb5585ab52beb..b6e42189eae2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1149,14 +1149,16 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
 		if ((adev->gfx.mec_fw_version >= 155) &&
-		    !amdgpu_sriov_vf(adev)) {
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	case IP_VERSION(9, 5, 0):
 		if ((adev->gfx.mec_fw_version >= 21) &&
-		    !amdgpu_sriov_vf(adev)) {
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 50abf4dd5ef91..6746b0108932e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2383,11 +2383,15 @@ static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
-		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
+		if ((adev->gfx.mec_fw_version >= 0xb0) &&
+		    amdgpu_dpm_reset_sdma_is_supported(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	case IP_VERSION(9, 5, 0):
-		if ((adev->gfx.mec_fw_version >= 0xf) && amdgpu_dpm_reset_sdma_is_supported(adev))
+		if ((adev->gfx.mec_fw_version >= 0xf) &&
+		    amdgpu_dpm_reset_sdma_is_supported(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index ab012592a276a..9d99211721953 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1443,7 +1443,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(5, 0, 2):
 	case IP_VERSION(5, 0, 5):
 		if ((adev->sdma.instance[0].fw_version >= 35) &&
-		    !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index fdc9cc13396a2..dcdb7dbb952c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1362,12 +1362,14 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(5, 2, 3):
 	case IP_VERSION(5, 2, 4):
 		if ((adev->sdma.instance[0].fw_version >= 76) &&
-		    !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	case IP_VERSION(5, 2, 5):
 		if ((adev->sdma.instance[0].fw_version >= 34) &&
-		    !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index aa89d915d3f98..7c5da95de92e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1370,7 +1370,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
 		if ((adev->sdma.instance[0].fw_version >= 21) &&
-		    !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 84d0e1aa4d501..5ba323259f2a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1351,7 +1351,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->debug_disable_gpu_ring_reset)
 		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-- 
2.51.0

