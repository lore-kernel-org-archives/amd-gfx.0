Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D1CC33CA3
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F7F20866
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rdcy6D9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F7F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3186E23D;
	Sat, 11 Jan 2020 18:39:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F39D89FF6
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 18:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoMm0y+CaygAH9u9sXpmHW5Y44+h5upubTpqBjaR+U6tfTzYagy+ucf0vFsdzPI/Zx10+1dEfNkVHjZobztg0XULY+XwBF8OKMrQxYNmGCvaVm0mXMYipyvSriOv099rwXIbvhbbquuIBR8rOMQr6c+5c2qzuzw0AeyeUDSjkLvNN45a0gydGDA8sppf8dbGmE+T/DB2dr8FWQAmp1sJKHhdII04Dnjd2ntPChUDy1hZxbgDIrLGFttNjTAg8/e+BCrfDHtr42Lp/WdI/DbK6i2n564joKrpRGHQUF4qyjG0ZZly8OCzBeFszgpEMbvMwE+XRXehJWnQ6BjYQ7LrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5DIkpcunDlHW4UOvEJskIrnX83cqqnQfJVXtjiiLHY=;
 b=Ctx6GT4zA6Ur/SR+3ULT5EkyehJTf915PRFKOTMLoFmY7KpX1fFwW/6pQCJfMq/6AmHhB7tenW7DRXa7uhA3axBjnr3RfLTWyGlHHOe1qBrUnV7+DHKTkEbgSLsZT4QifbWENr6pdsYQlDaXUzBvOrjMKRtmPqEj2gjJjHTfRm348HlTh4X67FqPkm12cgwqrjPNaPgpp/HZNcT9lzaIw+hHEmaqw7NP7U7MFO39yPtnc7uv2LKbeF4GNEqTpkX1CjP9Q36Rfkee3ydIyqmrKh7+QianARwI5SDuXSZjc8MG3U///EsjwDZq8NxdG2zvxKjUnt9BtoGt0QknaOqMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5DIkpcunDlHW4UOvEJskIrnX83cqqnQfJVXtjiiLHY=;
 b=Rdcy6D9qoqfZ6p9El3znQKC56Cwk14ZvJ6RdcFLN8HZXKOQQWK7s4pl8D3fuLjvcx7w8L6VBPxq314aXDBbKocr51e+qHY76Ld1zk+LF5rbwM7W9BOYoc1kgdKH0RLKiSzKGceMzcBNDWk0oF6yKLKXMHBqXMLEGQmcWcONIYDU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.104.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Sat, 11 Jan 2020 18:39:54 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.014; Sat, 11 Jan 2020
 18:39:54 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: implement tlbs invalidate on gfx9 gfx10
Date: Sat, 11 Jan 2020 12:39:34 -0600
Message-Id: <20200111183938.126310-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200111183938.126310-1-alex.sierra@amd.com>
References: <20200111183938.126310-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR16CA0054.namprd16.prod.outlook.com (2603:10b6:805:ca::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13 via Frontend Transport; Sat, 11 Jan 2020 18:39:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2468b3f1-3662-466a-3425-08d796c5a5dc
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:|SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814DE3B74593E8DD6409FE4FD3B0@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 0279B3DD0D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(66476007)(26005)(66556008)(66946007)(16526019)(186003)(7696005)(52116002)(6916009)(86362001)(478600001)(4326008)(36756003)(5660300002)(6486002)(8676002)(316002)(6666004)(956004)(8936002)(2906002)(81166006)(81156014)(1076003)(44832011)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2814;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ISWmk8m1I6bc4bxm2tzmXEkzvG21Z7OiCWGtetvtq21dM3Nb5irhn08jnFaIZM2acBnA4dghPxUACetjSZGEiicbojiIFH2+fT0/ErwaPR2NeIfHINhMqG+ZgOI9rA2ed08Op4lIkGQQhaH/mfg0jb9I3e8i++P8ukqRciHmHDLmpEuM00jgxV4HKfwQ4iu21uulS0ikq/bmyt8ctcHQ7lbWoBwDpH/1yTVEdnBcXJ5iXg0S3jxyazGeFPoJSn1hD3JK44L5AU4XtkBtg0iNjKsRx2fUB4nhoVXA79M2Z1q/zsqttxHO/TpIgPSdB+yYgn1Q2DwX6Iev1A3RL4ckcY9TnTvziOAxn+kUG9XKH68PGIduNjx3zVr9wR2+few74XwcaTUMFzjFMXe6fhn9SClkeJLPuy7BlsLegttqo9l/M2TyQ/UUU3s2qKCLVbb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2468b3f1-3662-466a-3425-08d796c5a5dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2020 18:39:53.3369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lio2gxy06AcmNeu28oRcOj52CUerFuEgs8s7b6EzmNiJiZUtUWipAQ/BhJTxQVFJ+k4coemx9dS5nJmHOuZx8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
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
index ad0179ea2cc5..5be6fab55b73 100644
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
