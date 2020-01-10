Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD6DC33CA1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A347C2075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jRoZtCxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A347C2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3D46E987;
	Fri, 10 Jan 2020 00:43:56 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690061.outbound.protection.outlook.com [40.107.69.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F4B6E982
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC5WYgaG5f9qLrK2ygOd5LENyAYZUoanx9XEs+h+ZzEG8cb+TsNeJN4gL6cVty06uVL/5ug9iw88RyvGjBSAnZRb7+9cdGJn1tfNR6z+tAmnBtwzvdeb7C7rKl0ykWfG7KpM083cpyPxWpS/UbgNs9958Dw+myb1LbykmCQrQ6C46x1hnzr8PZbBqiCDELrLTSEXzHQWI17ewdmlOEWHPEct2DCHCBdPApmu17HNBPLnOWJjEP7efLfk9DReq0JYAD8N56q0e0zBMuaWCi0cbzI8FLcfjRfRR9dh11rxIgFuwTpcUdyiM2BtQZ45TmiQLfZngieX8TQoFgaIuh7fDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWht1/tfQfTsr35ZCMRpewaVYptdyEmxHiv8427bNa4=;
 b=VPXr96nCt1bxvsLW5E5s/snwrlPpSO/6GiqEJVn/yGld50h+avsvQ1lBcrsQaSotXVMAyIgi6paOYhDn5W0D7sO48QAlmvqcDg8Ld9wpC6ayFWZ65D4V9plmn256X6H8IKF8ifeJ3l2Y5m5gOrUSKCFd4ciKpzMzOOAByZJaNeXfyHBaONAHp7bOJIl4VgFDOeKGsUGoTRN7XCoWHf1WhjArrbV0dcn+4/bPL6WHYzFhUUOziiXYZWEj8ICp/F14UEYOAWOSgwnMyhiVx9X73bo5xrrjNqAaVl16GNmy4H/syPmdJwWA9Bly+GK9PtvBtQn+fbYquF1s0/gJRK5kOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWht1/tfQfTsr35ZCMRpewaVYptdyEmxHiv8427bNa4=;
 b=jRoZtCxveH68N8cdDojiDckcVW/Wq6lxKyE5nl+2TQS3jQvIQA10+SsviCfIHh/yYXa2fHU47oVTbfz/FPcKscc8JrxLONzeNJm4GKCQDP8vga6/6zhCY0qTlTZqrg6zoKUQnq6iDcgDkzO/0laeI3x34XXDJwT8FAaBOFsN69M=
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
Subject: [PATCH 8/8] drm/amdgpu: replace kcq enable function on gfx_v9
Date: Thu,  9 Jan 2020 18:43:35 -0600
Message-Id: <20200110004335.113095-8-alex.sierra@amd.com>
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
 Transport; Fri, 10 Jan 2020 00:43:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf1b0a6d-bf8a-49b0-5f93-08d79566298e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:|SN6PR12MB2672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2672FC755D6E1BC81D3D1A61FD380@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
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
X-Microsoft-Antispam-Message-Info: wXbXH1LRLAXvUMhLb8obq9bUBLCfCO+3+F8JiRAzWYefemHA2+6Nvz73aH+sCpKPXelSRGb9HNwfLwJSiFTP1J6bAZv3s9P9nizzp5Pd/BtEoowCDqnq82Z8G4bI0hs9BN58xaZGYxAnBhNjQVKlONjvw9yIN3ctsrDsUHWlgtom70Ivj42fkdJdmPikwvMqJhq5FJcfaViSgjR+xHHAB+j0fiVzOOEwlCL21f5Yvg59eoz4iTR0UWpt32UPIah1+jVuNO0ScB31MO3/sEmcfOLR9S7NwNPTgW1LhL+SZXtYB7ngcsRgUQt3MReiCayEEQ0uKXslvrszUDD0vzKYel0HLQCn+3xPzRLNdIdL0mLSO4vZhCfCnJZ+4flY+Yz/SwG+djb9LwpDCOquoWE0/5gqREfSE01qEhLM/LlyGS8ljussX+lzxAatitF5OoK7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1b0a6d-bf8a-49b0-5f93-08d79566298e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:43:51.4612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmuE9xIi2RzQ0WhV+F4+x7d4R143XhIoYFZhvGlvp1xAGeMH955iU3I41nydWJB/U68X2qaAGgupJxD4b7E/Vg==
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

[Why]
There's a HW-indpendent function that enables kcq. This function uses
the kiq_pm4_funcs implementation.

[How]
Local kcq enable function removed and replace it by the generic kcq
enable under amdgpu_gfx

Change-Id: I7709bdba93742c234941a5936c82eb67e346077c
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 70 +--------------------------
 1 file changed, 1 insertion(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c726aa454bca..ecf291bf7f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3252,74 +3252,6 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)
 	WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 }
 
-static int gfx_v9_0_kiq_kcq_enable(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
-	uint64_t queue_mask = 0;
-	int r, i;
-
-	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
-		if (!test_bit(i, adev->gfx.mec.queue_bitmap))
-			continue;
-
-		/* This situation may be hit in the future if a new HW
-		 * generation exposes more than 64 queues. If so, the
-		 * definition of queue_mask needs updating */
-		if (WARN_ON(i >= (sizeof(queue_mask)*8))) {
-			DRM_ERROR("Invalid KCQ enabled: %d\n", i);
-			break;
-		}
-
-		queue_mask |= (1ull << i);
-	}
-
-	r = amdgpu_ring_alloc(kiq_ring, (7 * adev->gfx.num_compute_rings) + 8);
-	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-		return r;
-	}
-
-	/* set resources */
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
-	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
-			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
-	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
-	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
-		uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
-		uint64_t wptr_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
-
-		amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
-		/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
-		amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
-				  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
-				  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
-				  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
-				  PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
-				  PACKET3_MAP_QUEUES_ME((ring->me == 1 ? 0 : 1)) |
-				  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
-				  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
-				  PACKET3_MAP_QUEUES_ENGINE_SEL(0) | /* engine_sel: compute */
-				  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
-		amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
-		amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
-		amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
-	}
-
-	r = amdgpu_ring_test_helper(kiq_ring);
-	if (r)
-		DRM_ERROR("KCQ enable failed\n");
-
-	return r;
-}
-
 static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -3726,7 +3658,7 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 	}
 
-	r = gfx_v9_0_kiq_kcq_enable(adev);
+	r = amdgpu_gfx_enable_kcq(adev);
 done:
 	return r;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
