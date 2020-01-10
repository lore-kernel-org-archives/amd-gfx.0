Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362DAC33CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06ED62075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uysWza/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06ED62075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA936E986;
	Fri, 10 Jan 2020 00:04:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618EE6E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL7TwP4Qj4Rc/gHKyOeNeVOO+eZaNGXXLgZ7QO3N3DHsX3f7/KdpOVEkz0SLcRAy7HzDql5Ur853dz/dfhi22I7A+1c9BEFO2YiqWOtBjvzs7qpf3Bwu8bg4VOrrECD4iDyEHnlcUVAYUI0SZNHmexCe3i2PCFJ3peImCWhrDwUebQa3X8Wal38eCOpliCRWvdGkQrAuSDQXUdpayidqbdlvVIGACG014gMkkSzwzgL1IOsFiy+WyHAkur1/t+9fplgnx2mQpSiv83JVAhnx3UY7G9yRjZfjawDazsfhUUibW8nL7kTfvT83xqSyven5bhzCRVcQ7KcM8s8MM+DX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8kODPIQYPeOEscEHcvMaP05xaBqP8rX4nG8Og6vUcY=;
 b=aiQjdMUlLCQLYX4I2qukOBylH7uJdQ8epncdtyzvYm2TxV1FjUb3Ayj4Ue+c65Ng9XOKCW4M3n5Dry85xPFvSboRR8CX5cXv+PgMnjzK5hnSELZ2bEpTjopGlzdwdRqn9PlFf0mS0neIoLsuUaZvt0yvSGjet7Aw80YFqjev95nvXgUbQdAABI/DeXG3wj1WRlMM6sAsADdu8qh2kmC6uRnC4oONuD9kWoX0+6J8KSSCBdnqlHHXaZGweE/PF5L53AUCMv/lIo7N2RQc0ArLmNnxRCuaJVp6z9q4cBedes/DlWlDsf6iAyvOqRJS6RdivYOXc8yQ9ZYymwVgAT/Sqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8kODPIQYPeOEscEHcvMaP05xaBqP8rX4nG8Og6vUcY=;
 b=uysWza/LhTx9JDK5wAvWRs8KMGgg026j3mFFs4YcHnl8kyBA7uhboPNxIr+asZ9Ws5QZgDpHpZuQQfyYQX0ovNYAjAImCM9sxXDTYpfAhvWDsoDayzX51QPzfQqCf5LyL5kikBR24E6xk+yM84ScnZsHydo/N8n0HA1aQAdxAGg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2720.namprd12.prod.outlook.com (52.135.103.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:04:29 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:04:29 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amdgpu: tlbs invalidate replaced by kiq_pm4_funcs
Date: Thu,  9 Jan 2020 18:04:12 -0600
Message-Id: <20200110000412.66930-7-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110000412.66930-1-alex.sierra@amd.com>
References: <20200110000412.66930-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15)
 To SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 00:04:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2694840-24eb-45f3-be79-08d79560a968
X-MS-TrafficTypeDiagnostic: SN6PR12MB2720:|SN6PR12MB2720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2720FD68B1F7E8303652C40EFD380@SN6PR12MB2720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(376002)(39850400004)(189003)(199004)(26005)(316002)(36756003)(52116002)(16526019)(186003)(956004)(86362001)(1076003)(44832011)(5660300002)(6666004)(7696005)(6916009)(2616005)(81166006)(66476007)(66946007)(6486002)(8936002)(66556008)(4326008)(2906002)(81156014)(8676002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2720;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbI5UX6NnsQqqDojs6c0zAJB3GsBZ7KLW13RA1opJViL1Ze8WTQmu2R+zo9yhIj/yz1JI9mPzSniAkIcZmkv5NVIJOgMAXxGvNf6/F4O+eM9yijwkYJfepkOJM/dyFFQbBgT7PWaHh/XuWRo7a6u6GYTaQ2sZfz/AHL114NjG0TgjUwGPeRR7e5L91pAFWsiVCONHkSc6zn803NcyN1bLppjOJ9hGDtIU7ZH05bGviVh0rxX3dghCVjxjXYTLN96Lo0LLo9cNY3BhxUirtZelvw/Y4kegfT2z5skJTTUv4LZ/5wtpRuwDba3MZlFUj4vkBCmWWvFW0hJ4mVDlo9RiqLpluhYPVM77KitAKkjrdFsGr1SLXw+I+A8Bn7NHEmALQdN56u/Gg3cGJAa5P7QnfbthHnaOLzvXg5mWKgpE6Bn3pa0mhmAbhgEv+GugaQs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2694840-24eb-45f3-be79-08d79560a968
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:04:28.9856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbY0PZTphdL7gJZ+2bXEMVHw10YK7vr7VLl3VAdyXyw2v2p+ratqBeOVpBu+uB2WIKXdoYshzMvcvnXeAx155g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2720
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TLBs invalidation was removed from gmc_v9 and gmc_v10 files.
This implementation has been moved to kiq_pm4_funcs calls.

Change-Id: I66463e2e5fdf7611ef4a802eb517ae0d269987c3
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 32 ++------------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 32 ++------------------------
 2 files changed, 4 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8cf34c7bd416..09408b8b390f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -250,35 +250,6 @@ static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
 	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
 }
 
-static int gmc_v10_0_invalidate_tlbs_with_kiq(struct amdgpu_device *adev,
-					uint16_t pasid, uint32_t flush_type,
-					bool all_hub)
-{
-	signed long r;
-	uint32_t seq;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-
-	spin_lock(&adev->gfx.kiq.ring_lock);
-	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
-	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
-	amdgpu_ring_write(ring,
-			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
-			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
-			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
-			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq.ring_lock);
-
-	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
-	if (r < 1) {
-		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
-		return -ETIME;
-	}
-
-	return 0;
-}
-
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -441,9 +412,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried_pasid;
 	bool ret;
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	if (amdgpu_emu_mode == 0 && ring->sched.ready)
-		return gmc_v10_0_invalidate_tlbs_with_kiq(adev,
+		return kiq->pmf->kiq_invalidate_tlbs(ring,
 						pasid, flush_type, all_hub);
 
 	for (vmid = 1; vmid < 16; vmid++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7cc6f305bfa8..670b2b62789b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -455,35 +455,6 @@ static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
 }
 
-static int gmc_v9_0_invalidate_tlbs_with_kiq(struct amdgpu_device *adev,
-				uint16_t pasid, uint32_t flush_type,
-				bool all_hub)
-{
-	signed long r;
-	uint32_t seq;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-
-	spin_lock(&adev->gfx.kiq.ring_lock);
-	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
-	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
-	amdgpu_ring_write(ring,
-			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
-			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
-			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
-			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq.ring_lock);
-
-	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
-	if (r < 1) {
-		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
-		return -ETIME;
-	}
-
-	return 0;
-}
-
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -598,12 +569,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried_pasid;
 	bool ret;
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	if (adev->in_gpu_reset)
 		return -EIO;
 
 	if (ring->sched.ready)
-		return gmc_v9_0_invalidate_tlbs_with_kiq(adev,
+		return kiq->pmf->kiq_invalidate_tlbs(ring,
 						pasid, flush_type, all_hub);
 
 	for (vmid = 1; vmid < 16; vmid++) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
