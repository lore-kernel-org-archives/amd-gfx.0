Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8673FC33CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D80A2075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FPgB+t42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D80A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5EE86E985;
	Fri, 10 Jan 2020 00:43:52 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690079.outbound.protection.outlook.com [40.107.69.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95EE26E95A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAw8eseHSoAvcsqUONB1OblmDouHwK9v+2HOZBAzML9W9khwaI7N+GtgIrCPhi9q54s7aTFTN5Ue2063c+/CiK6PWD03UjL/gbuxk5Z1lyYLkhYcn51ONrGiPGiGjEd2m5EgkPa0mH7xpzXqM0Azjl+srOXPmQ+W1ykSEy71PbArewPEuUyzfk8hso6e+H+NrbiyJBU9MF+yFZkk0aRyaaiabs7r8Qdc7j/sTXPRP9w9Fw/FKj2DflDWVWyvrW6OZ3aUqK2bAv3Ee9mp7nNiSXYPq7E8+C7IsYdN2xIOZ46578Q8p1x5vLNh6IHUDX709FC0Kk57Hxttph9UBzU+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33eQl4wi/zTsVeEhQeWK0lIvCIkvvFoT6vT/3UgR5LE=;
 b=W8TWcXMiQivvRHc5cmZFg9jyxLVzHj0cqfJfuBOQ6Q2v6yBMl9ImGybJSP0cvk3mYoOGkK59BF14/h/ON+IWVattIVXryaI/7Akz1e3CfLKWvBkVQCNipMnVeOAgElntV/RPSPF5fvBuMfRAbFNTf6zok+SsbNVBdKgBozVpk/QDsRiQzie9HRHKUi8+I9Jomwg3inPqzdpsvE5zxtI+SVZ70O/Tt1LioQaawvLN8qefDARVsMGq1oraJ5aVvD5u26qV8R0pskP67egS1t6cPLBAK/Njwl+NzFw02Hk33g8Obt9Dl0vBfu2pE3dxjWePT4P3EbHGWRJpjHfuiUHBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33eQl4wi/zTsVeEhQeWK0lIvCIkvvFoT6vT/3UgR5LE=;
 b=FPgB+t4282ZchJ4dxuPuO1CiX5klG5mt2va9Ykla3Zb6LZHRbrvbv6qHcf/yPrxQnediwHWYZpZRrxV3lJ1KuDdzmoL8clmL+E0UX+ad+rN0uwzmsnIkz0zlpvUf+RcXpWeNjNxRyYY+DtplaGqMuDae43/uCzWvPCNjRgAtEvQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2672.namprd12.prod.outlook.com (52.135.103.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:43:50 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:43:50 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: implement tlbs invalidate on gfx9 gfx10
Date: Thu,  9 Jan 2020 18:43:33 -0600
Message-Id: <20200110004335.113095-6-alex.sierra@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f1caf295-699d-4cd4-8d7a-08d7956628ee
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:|SN6PR12MB2672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2672BCE04B9D7669045E4AEAFD380@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
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
X-Microsoft-Antispam-Message-Info: FBrDUE3137EwVz589RRJ1HeQJ9FpPb6IZhCIsixHpE3VKm2KHhxKmniSkzEaJ3Y1myizhIEod3jQoq0w9qls92LqzwkmEK3ss+xGk1/72ImcRoJYx8ZGLVAixqN/AOD1MtqTXp7g1J6cq3sAoSUQafpAancJrWcIMGqCEQ6W3NtkjZuDSuXtmhO/XISVfGpDVwbZvC0L9LDWh48FjRvlgzqo0LD21k09zTUS1aEFj4pysc53CWgScTG1JgdwFcpxwGHcWKqudw/rRXntHws7FGTuMzQ7O5t0JMLam/WQHrinhziH4SEYxRGxXr74KfdnRFAiiUnJL6/DGa+LsQXeP3pqSjg/DagpFpY6JyHbivYbCdJyC+6bOyNMxFyyID9LikRBa/03rVSXS+LOVdjGLBXbOc5m6lgA3fY4EcOK+PclyezBNcrjzDAQ4z94MAw2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1caf295-699d-4cd4-8d7a-08d7956628ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:43:50.3958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROw9mPFAdSMW4Rj5Cf92gb0BVIatu2cHlLdy23YTmIu9VLAe660TscW2tHlw3weGagPGmNIVpZj8ttGokojVyQ==
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

tlbs invalidate pointer function added to kiq_pm4_funcs struct.
This way, tlb flush can be done through kiq member.
TLBs invalidatation implemented for gfx9 and gfx10.

Change-Id: I1b77b364f3ae0038ff3e70e869be5f2ef6e6d293
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 32 ++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 8e88e0411662..2927837bd401 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -76,11 +76,15 @@ struct kiq_pm4_funcs {
 					struct amdgpu_ring *ring,
 					u64 addr,
 					u64 seq);
+	int (*kiq_invalidate_tlbs)(struct amdgpu_ring *kiq_ring,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub);
 	/* Packet sizes */
 	int set_resources_size;
 	int map_queues_size;
 	int unmap_queues_size;
 	int query_status_size;
+	int invalidate_tlbs_size;
 };
 
 struct amdgpu_kiq {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 379e46c1b7f6..2e82213f57eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -40,6 +40,7 @@
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
 
 #include "soc15.h"
+#include "soc15d.h"
 #include "soc15_common.h"
 #include "clearstate_gfx10.h"
 #include "v10_structs.h"
@@ -346,15 +347,47 @@ static void gfx10_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
 }
 
+static int gfx10_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub)
+{
+	signed long r;
+	uint32_t seq;
+	struct amdgpu_device *adev = kiq_ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+
+	spin_lock(&adev->gfx.kiq.ring_lock);
+	amdgpu_ring_alloc(kiq_ring, kiq->pmf->invalidate_tlbs_size);
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(kiq_ring,
+			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
+			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+	amdgpu_fence_emit_polling(kiq_ring, &seq);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+	r = amdgpu_fence_wait_polling(kiq_ring, seq, adev->usec_timeout);
+	if (r < 1) {
+		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx10_kiq_set_resources,
 	.kiq_map_queues = gfx10_kiq_map_queues,
 	.kiq_unmap_queues = gfx10_kiq_unmap_queues,
 	.kiq_query_status = gfx10_kiq_query_status,
+	.kiq_invalidate_tlbs = gfx10_kiq_invalidate_tlbs,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
 	.query_status_size = 7,
+	.invalidate_tlbs_size = 12,
 };
 
 static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d48bfae3e083..c726aa454bca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -837,15 +837,47 @@ static void gfx_v9_0_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
 }
 
+static int gfx_v9_0_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub)
+{
+	signed long r;
+	uint32_t seq;
+	struct amdgpu_device *adev = kiq_ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+
+	spin_lock(&adev->gfx.kiq.ring_lock);
+	amdgpu_ring_alloc(kiq_ring, kiq->pmf->invalidate_tlbs_size);
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(kiq_ring,
+			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
+			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+	amdgpu_fence_emit_polling(kiq_ring, &seq);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+	r = amdgpu_fence_wait_polling(kiq_ring, seq, adev->usec_timeout);
+	if (r < 1) {
+		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx_v9_0_kiq_set_resources,
 	.kiq_map_queues = gfx_v9_0_kiq_map_queues,
 	.kiq_unmap_queues = gfx_v9_0_kiq_unmap_queues,
 	.kiq_query_status = gfx_v9_0_kiq_query_status,
+	.kiq_invalidate_tlbs = gfx_v9_0_kiq_invalidate_tlbs,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
 	.query_status_size = 7,
+	.invalidate_tlbs_size = 12,
 };
 
 static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
