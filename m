Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A69C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0842C2075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mFf5dPaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0842C2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8CF6E913;
	Fri, 10 Jan 2020 00:43:53 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690079.outbound.protection.outlook.com [40.107.69.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6636E987
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTRB+v0KDzl3tx+5EziPc/GHJqXaik65R7fyh2YJ45W4ankhK8uZfKYzqGTAYccmGOw2xv1yRbqM4JbLek3lLNP6DvBrYgtEh8RjErzb8O/PbTLTyrr+56BkPplkbpHKoxDiEUoARgfbIyHV45fXpoPjxFtZNOBc3lVaI27Jm05mtE81bsquQXrUOKuok7FGvsXeyOcoEyxZnWrduTofbYmbiogaDViFwQbet58uvZcc48QXyYWGGw+Nj0PPoGseY6+9EzEe9LDOMZey00rDea5dua3E9j5B6X8jti+rosB6TDudrRscS0lUcxJiVW6MM/w7ZjYL2VHOdJdFJbNNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8kODPIQYPeOEscEHcvMaP05xaBqP8rX4nG8Og6vUcY=;
 b=DaVHIFvO40ApE5s2X2cyH64hxxabL9zrdOu/SLsc+IGhrloJLDVeqwMJm/30nxwfEyJPco1yNKW9HTqSj53/OPmM+F2jP/CRb2rdR+jJ8jolBstT/uXCoKGzJBmEarJkMlZyMGQcK4XCH8pQuG+fWJkZVV3ciTfdZI6CBRhP3wYgnUuEDY3tbFhinM6MSdECJvdB0WIz9aXeWPQXXyh/RabUzzNzUh0lMgEpakXvFuOU1VsqEKW88y5aWu4Zo/N/tv3kINmzurNusl21g5F+ZLEvQJ7J+9zpG3veYFGzD2ILn3xbNRJ6YIRd4QxAZqkKjmpgzB99fImq2Wf23YJR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8kODPIQYPeOEscEHcvMaP05xaBqP8rX4nG8Og6vUcY=;
 b=mFf5dPaZgh3BGI4glpqx0Vf1SRiOPa81M3iNbUEOId4YtwlXQQS9QV2vr3V24Bj9holsHhtv0wQpbNJhqcdG5xfp5KACWzYOcl+8Kj9KDwegjBHNFvFi5r2Ez1MOdnbMXJwagl3IHRJr0hQ4HLR7I3KHF2WOlXE1lyNNZrKYdSo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2672.namprd12.prod.outlook.com (52.135.103.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:43:51 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:43:51 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu: tlbs invalidate replaced by kiq_pm4_funcs
Date: Thu,  9 Jan 2020 18:43:34 -0600
Message-Id: <20200110004335.113095-7-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110004335.113095-1-alex.sierra@amd.com>
References: <20200110004335.113095-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:805:106::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.4 via Frontend
 Transport; Fri, 10 Jan 2020 00:43:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3b46d2a-37d4-4c2f-a209-08d79566293c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:|SN6PR12MB2672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2672A2E055AD88EF29071406FD380@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(8936002)(26005)(5660300002)(7696005)(316002)(86362001)(1076003)(186003)(2616005)(16526019)(956004)(44832011)(2906002)(36756003)(52116002)(66556008)(478600001)(66476007)(6916009)(6666004)(6486002)(66946007)(4326008)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2672;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Hsne2qMpWj8wEvDql1+2w8Ql96pKw1yRoQ/o0qtbFqMfrFnusY5Wkf1ggLezGzIKSHUOynEr4fqPUxBqxyFkWlxUaGOHw1Q6UT7cGgy3W/+Uy/YGrZ8aElZSwktegg56PJ6vQidtsGbA3nUIAbqxyYENN4fQ+lE017C8UvKemW6zvlx+9vR1U/cyG+UEnqSAq2LouVY+8Hchba36KdOEZYaesPsLq3ELtm4sldv3K+yFNSwCnwpTguGJoDxUY/lJEuGjLRyAYX826UTyxTm6nAkEZNF0y1OcI+rDu9Hbe/D3q/u94UWnyKjptNhoImDtLJcEi6h5U2KoiOVU6y+XFiRc+ip9dgNLBIOUoY48p4MTgvH+PYezPPPms4eFvDYKST+BMC+KcPe6cLBBLRkUoxuGuoa+CE4/JFDoKNqx+gvzCs0mdNg8fSC+UKj3w0o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b46d2a-37d4-4c2f-a209-08d79566293c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:43:50.9675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxuN8xqS9vEjOtwe5kFC7xKqbPvbje8nePzm1qyYWTwI1MTIxI0YUmb88q+bl+Mbx1dv6OUnD6pwpnEmwlwhgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
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
