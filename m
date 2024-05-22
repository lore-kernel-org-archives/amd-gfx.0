Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015E4C25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 17:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF7B10E1D9;
	Wed, 22 May 2024 17:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tcjewKEu";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7A310E1C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 17:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF74C7l1T4voIzoUJFwAzvf5swttmYDpJWtzxJFXufjy38ThsVjJrdadRFInpQtd3hEoqWsRW9REd7cGV/NvusHC2HV3xmjWuBMqiyUXWRjg6VRqy58Mw4eIodOl0EmosQKxj8jLEWWAXx59ENfB5X7ELYFaivbIYZx9ElC3RMVncuh4zzPbI8ELliIiA2w83Q83+b4GJSwwupCxweHuraSKYQTXJoZLh66tQTHkyFXA+jjR91Km+v2fsHu21iMPa0jwUSi/5m1ekk0K3aznxs5SBH3/yOOo/Udxg7L5owdKqBsuG5ezS+bmfSJ1rJG3fp8iahyOkn/JrFd9ObcgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjgKf+iriSgiXJ+Bmm7OPqA/keVItqPykBRBah2zWa0=;
 b=VvUGe5pIMzQtI+zO5hpS6GVJqZCB/FbSJev8DP8BjThm5DjtUKJDVsCXmf2hs2heffHIYT2oWxhs+UVrBq69rb31aewuGO0+lRJ8JSvybhKKT2elFNU5eEXCz2Mz7Qo7i7eFBylu1ZTfIGxhVwyoW/IUuez9PmtFcBvyTf4O5LMxNYfX1gg89IMVpP587zH19WHm2+ffGUPYuY6M1S48as/R2pkAfroUaF62RCDdO3skoWsSM5xAjcouaJDNsdJUXGU9GKwVINc3l4GhJXfWBhnIgjChUNzK+sipfNcct6/jbX1Tbs71DZJKJeKjji4DCO+50mKfFB3kuJOSAI7iyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjgKf+iriSgiXJ+Bmm7OPqA/keVItqPykBRBah2zWa0=;
 b=tcjewKEua1k/C30dGByh8cxKKtXSAT+ryp3J2JXSCM4T2nvJDF3AEreppMYFl9bvOWPpoIGgrw4ZAzpy63nfo+gANkebwXuXU4hsDa6DgTwYQUe1swVyaDOXNfqOJIKwB+nGt3q4YTRGqTYg8qSP3t6meEUliEDv3vT3cZ8ujTE=
Received: from CH0PR03CA0258.namprd03.prod.outlook.com (2603:10b6:610:e5::23)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 17:28:00 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::57) by CH0PR03CA0258.outlook.office365.com
 (2603:10b6:610:e5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 17:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 17:28:00 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 12:27:59 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
Date: Wed, 22 May 2024 13:27:21 -0400
Message-ID: <20240522172721.14085-4-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522172721.14085-1-Yunxiang.Li@amd.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5f0082-da48-46cc-cb07-08dc7a848764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UWq6253RQhOb9FYvA/NCILC/n396nAF5pGkMpDbfs6XsBwF9X0Hmk+GrH+sa?=
 =?us-ascii?Q?4tEuIw2Fz/jOxC+FsDdRGs4LJZPNhXWwkgfwBt+445drJ9kUBwpecBtpUMDF?=
 =?us-ascii?Q?8bIqSZMdmBoIHEkxjiwP8ZtDtQnqkhH9r6K32BXRFb5kxrbfb1KeqBBOpR1L?=
 =?us-ascii?Q?nkuasDQ3cEhFNXQW93dF3pqMfBofRE8nEpKIv+25bmzSVsWGTTX8N067IV8J?=
 =?us-ascii?Q?6StvlRuQc2BpbmWtivOGXiR9guAOZpD2J7u47Y2Q29W/pUd2SYyNwLBFZHKT?=
 =?us-ascii?Q?PIrhOAjJIMSSzZTWL4AAAi0wkhrMvH8B/wPt4W784HTjWlpzebtTmiV0vIBE?=
 =?us-ascii?Q?936tXuIGvLUhdFgRKM9IseOHECAmxhpjjQgRe43J3ZAzCsdCH0z+GtJX5Ctg?=
 =?us-ascii?Q?8e4q9PXL7MoCQ+/YlPhOW6YA1SNT2z+KKMJGusYH9HiSbFbbYV/waAppiurg?=
 =?us-ascii?Q?1odvfzUkpz8daU5ZRH5aavpzMEiA3XhyAUhyfUHrylfyAWMMuDwl6NRoIsoD?=
 =?us-ascii?Q?q7YWKmGY+By+AOKpqC2unIXvFsZ9GyOdSVjB7LgEaLEqiMTydbUkOsHNd2YC?=
 =?us-ascii?Q?BhDkAvzPawlsEf0FuCgNP7bYsVLv+4jqz/ZFxqVJCRIm4+b0ieZ4iV0dT1ax?=
 =?us-ascii?Q?BfdSbM9h+V/oH/jPWuHr/4tlhFecsIi7Slr3tADFb4BmpIurpdM0peh8Oocq?=
 =?us-ascii?Q?XXi0AnRHGExswmngf8Q6cWNiHlo+B5KH1GZlbAR0IG8xAl6dv04azJg7Uch3?=
 =?us-ascii?Q?F05fttk2gpQUHOnrspDAE22tVUdlInSOnK5DMkmToRZ35cjc6/yN+Ctsq0YX?=
 =?us-ascii?Q?LcIirdiVXj6SAryB290E1tQrevHB9e+mgzsfvezKi+zNiIs9tPkUNinT0B78?=
 =?us-ascii?Q?yTz8Sr4k8hG0a54mH62CCKn5Fa3O90TBrpXrH93L0rubx6ZeoG6UpwwA6EsO?=
 =?us-ascii?Q?19y52n61JH9+fXISNm76Yr1CjEse2x8xXB3qtlRISoMC6R75MQ7SB4j2GMQj?=
 =?us-ascii?Q?L8eHRRN4ttOYpNeZFLlSjeqh+u21mVhMjlU3Ayfmfa5WXwVwVrqbTHz08e42?=
 =?us-ascii?Q?VgQwn2sLSs4u4ElOoTOdCridPW1qu1gZR1l5KlhpjAoPtfrf9b0+yLJhLcvk?=
 =?us-ascii?Q?XYeGzEqjJ9nBUqOQSKlPF8fffYU1As/VajAAiBI/kCKNic2flJdlwd3/ogCG?=
 =?us-ascii?Q?EUwgcODhqpt5633WeITPpTIDlwIH2RkqzaIU3gNo4OXrjcDKO1HQBPx6gdS+?=
 =?us-ascii?Q?eP04hPlPmUjzy5MWvrUk/OgpIyHDlactWNi7XOb0wN8Zc5Jusv1YuFqnCTKn?=
 =?us-ascii?Q?UMm0MAnpxTNIOEwFrceX/KSUe+4pvR8FSQGILexr8p7cyAu1i38LTGpVRMCg?=
 =?us-ascii?Q?f7YwofA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 17:28:00.5100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5f0082-da48-46cc-cb07-08dc7a848764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
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

Random accesses to the GPU while it is not re-initialized can lead to a
bad time. So add a rwsem to prevent such accesses. Normal accesses will
now take the read lock for shared GPU access, reset takes the write lock
for exclusive GPU access.

Care need to be taken so that the recovery thread does not take the read
lock and deadlock itself, and normal access should avoid waiting on the
reset to finish and should instead treat the hardware access as failed.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 74 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |  7 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  7 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  8 +-
 9 files changed, 79 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f71c7b98d77..5a089e2dec2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1632,6 +1632,11 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
 
 int amdgpu_in_reset(struct amdgpu_device *adev);
 
+void amdgpu_lock_hw_access(struct amdgpu_device *adev);
+void amdgpu_unlock_hw_access(struct amdgpu_device *adev);
+int amdgpu_begin_hw_access(struct amdgpu_device *adev);
+void amdgpu_end_hw_access(struct amdgpu_device *adev);
+
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
 extern const struct attribute_group amdgpu_flash_attr_group;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e74789691070..057d735c7cae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5816,6 +5816,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		goto skip_hw_reset;
 	}
 
+	amdgpu_lock_hw_access(adev);
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
@@ -5852,6 +5853,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 */
 		amdgpu_device_stop_pending_resets(tmp_adev);
 	}
+	amdgpu_unlock_hw_access(adev);
 
 skip_hw_reset:
 
@@ -6449,6 +6451,26 @@ int amdgpu_in_reset(struct amdgpu_device *adev)
 	return atomic_read(&adev->reset_domain->in_gpu_reset);
 }
 
+void amdgpu_lock_hw_access(struct amdgpu_device *adev)
+{
+	down_write(&adev->reset_domain->gpu_sem);
+}
+
+void amdgpu_unlock_hw_access(struct amdgpu_device *adev)
+{
+	up_write(&adev->reset_domain->gpu_sem);
+}
+
+int amdgpu_begin_hw_access(struct amdgpu_device *adev)
+{
+	return down_read_trylock(&adev->reset_domain->gpu_sem);
+}
+
+void amdgpu_end_hw_access(struct amdgpu_device *adev)
+{
+	up_read(&adev->reset_domain->gpu_sem);
+}
+
 /**
  * amdgpu_device_halt() - bring hardware to some kind of halt state
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 603c0738fd03..098755db9d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -623,12 +623,11 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	    !adev->mman.buffer_funcs_enabled ||
 	    !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
 	    !ring->sched.ready) {
-
 		/*
 		 * A GPU reset should flush all TLBs anyway, so no need to do
 		 * this while one is ongoing.
 		 */
-		if (!down_read_trylock(&adev->reset_domain->sem))
+		if (!amdgpu_begin_hw_access(adev))
 			return;
 
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
@@ -641,7 +640,8 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
 						   flush_type);
-		up_read(&adev->reset_domain->sem);
+
+		amdgpu_end_hw_access(adev);
 		return;
 	}
 
@@ -684,12 +684,18 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	signed long r;
+	signed long r = 0;
 	uint32_t seq;
 
-	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
-	    !down_read_trylock(&adev->reset_domain->sem)) {
+	/*
+	* A GPU reset should flush all TLBs anyway, so no need to do
+	* this while one is ongoing.
+	*/
+	if (!amdgpu_begin_hw_access(adev))
+		return 0;
 
+	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
+	    amdgpu_in_reset(adev)) {
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 								 2, all_hub,
@@ -703,46 +709,42 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 							 flush_type, all_hub,
 							 inst);
-		return 0;
-	}
+	} else {
+		/* 2 dwords flush + 8 dwords fence */
+		ndw = kiq->pmf->invalidate_tlbs_size + 8;
 
-	/* 2 dwords flush + 8 dwords fence */
-	ndw = kiq->pmf->invalidate_tlbs_size + 8;
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			ndw += kiq->pmf->invalidate_tlbs_size;
 
-	if (adev->gmc.flush_tlb_needs_extra_type_2)
-		ndw += kiq->pmf->invalidate_tlbs_size;
+		if (adev->gmc.flush_tlb_needs_extra_type_0)
+			ndw += kiq->pmf->invalidate_tlbs_size;
 
-	if (adev->gmc.flush_tlb_needs_extra_type_0)
-		ndw += kiq->pmf->invalidate_tlbs_size;
+		spin_lock(&adev->gfx.kiq[inst].ring_lock);
+		amdgpu_ring_alloc(ring, ndw);
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
 
-	spin_lock(&adev->gfx.kiq[inst].ring_lock);
-	amdgpu_ring_alloc(ring, ndw);
-	if (adev->gmc.flush_tlb_needs_extra_type_2)
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
+		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
+			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
 
-	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
+		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+		if (r) {
+			amdgpu_ring_undo(ring);
+			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+			goto error_unlock_reset;
+		}
 
-	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
-	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-	if (r) {
-		amdgpu_ring_undo(ring);
+		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		goto error_unlock_reset;
-	}
-
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-	r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
-	if (r < 1) {
-		dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
-		r = -ETIME;
-		goto error_unlock_reset;
+		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
+			dev_err(adev->dev, "timeout waiting for kiq fence\n");
+			r = -ETIME;
+		}
 	}
-	r = 0;
 
 error_unlock_reset:
-	up_read(&adev->reset_domain->sem);
+	amdgpu_end_hw_access(adev);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index bfdde772b7ee..01b109ec705b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -144,6 +144,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
 	atomic_set(&reset_domain->in_gpu_reset, 0);
 	atomic_set(&reset_domain->reset_res, 0);
 	init_rwsem(&reset_domain->sem);
+	init_rwsem(&reset_domain->gpu_sem);
 
 	return reset_domain;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 5a9cc043b858..a8ea493ef0e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -86,6 +86,7 @@ struct amdgpu_reset_domain {
 	struct workqueue_struct *wq;
 	enum amdgpu_reset_domain_type type;
 	struct rw_semaphore sem;
+	struct rw_semaphore gpu_sem;
 	atomic_t in_gpu_reset;
 	atomic_t reset_res;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f4c47492e0cd..38bfd1bb1192 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -259,11 +259,9 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
+	if (!amdgpu_begin_hw_access(adev))
 		return;
 
-	down_write(&adev->reset_domain->sem);
-
 	amdgpu_virt_fini_data_exchange(adev);
 
 	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
@@ -279,8 +277,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
 
 flr_done:
-	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
-	up_write(&adev->reset_domain->sem);
+	amdgpu_end_hw_access(adev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 37b49a5ed2a1..522198b511d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -292,11 +292,9 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
+	if (!amdgpu_begin_hw_access(adev))
 		return;
 
-	down_write(&adev->reset_domain->sem);
-
 	amdgpu_virt_fini_data_exchange(adev);
 
 	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
@@ -312,8 +310,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
 
 flr_done:
-	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
-	up_write(&adev->reset_domain->sem);
+	amdgpu_end_hw_access(adev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4721b2fccd06..ed96ed46d912 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -262,7 +262,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	int r;
 	struct mes_remove_queue_input queue_input;
 
-	if (dqm->is_hws_hang)
+	if (dqm->is_hws_hang || !amdgpu_begin_hw_access(adev))
 		return -EIO;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
@@ -272,6 +272,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
+	amdgpu_end_hw_access(adev);
 
 	if (r) {
 		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6bf79c435f2e..c2bccc78525c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -87,8 +87,12 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 		return;
 
 	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
-	if (dev->kfd->shared_resources.enable_mes)
-		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
+	if (dev->kfd->shared_resources.enable_mes &&
+	    amdgpu_begin_hw_access(dev->adev)) {
+		amdgpu_mes_flush_shader_debugger(dev->adev,
+						 pdd->proc_ctx_gpu_addr);
+		amdgpu_end_hw_access(dev->adev);
+	}
 	pdd->already_dequeued = true;
 }
 
-- 
2.34.1

