Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F3C6369E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11342463B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kUgqy+kF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11342463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969D26E454;
	Wed, 18 Nov 2020 16:24:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744486E43C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 16:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhF1KmrksdTKznDv55O1R9UQwMJDz2RkA5f4QymLGdy3PEZJDEo796xFbq/PbLmZBDplYWaIoejByLxdYu8xDvJ4ulUZhdAFqyB2HcG/ANHKq5dVO+MA91bgQsCtn+W2Gpeaii8XHtGGaMCYZ/yMIADf/250FlCSJtQz1sCUZEY36r3xKvao8MbCWNVtBr5JYAMnztbUqcsrnwSY9nMw3qqc1yAdGKdGgu1cqQ2n5udOLfeL1tTfbtZqxNB0rLgyVv2GCpRoPv1kL+5fTZh+x0ajnCIA+e5BIgR3gRfN81E+uAbHIGRu1ch3UVecgBh97DbhEmtxQWZgshN9xfp5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tilOJQp40Wk+6x3W7oHYugG04zMA6oJQeOlr5pEDIZI=;
 b=Fn22JpbZEqgD0sZK1/OJo5IZMzchl+cJEl8TxdAlKLzynNvn7sXXVU357fY/CLcYFIhMECZ9U7oQwso4GRN1IcqY6OHle7E/iQo0BODQIHp8Ewdi/2fbYcX07FFRzae7jZaRiGDA6+FdvzAn+gcTybRTdIklkMD/Rsj1Ud9BcvQjiv4DHAtjRAQah0uE/z9cuKhNaui7DJw+SEkZeSPD4i4fJJxK6fRreifD2un/pw6ijReyCqzTtIrj6UHqINNvA50VtaHYIecepOS/zbisN6kF0PgUuzak2tcEo9IQaWl93r76w4jeC10MwsrylQ0lmQVptwxRd/hoZ4A6fdSH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tilOJQp40Wk+6x3W7oHYugG04zMA6oJQeOlr5pEDIZI=;
 b=kUgqy+kF4HEXymoLw1LCmo7qPNxFA/l8C0ZeNpAcAyiRt4jzjoOyJP8+EtXhIPyqy/PyzN0oK8vq3ICJtTZUbaVUhdJvvStq/YpQ3xrdTpTjqznvJ8HzWXs12T1TVOKrJ/2R3qDIdyQ+YRpW1TeuyVI9WE0DKyg0SoLaKbdRkaM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 18 Nov 2020 16:24:09 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3564.026; Wed, 18 Nov 2020
 16:24:09 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/5] drm/amdgpu/vcn: refactor dec message functions
Date: Wed, 18 Nov 2020 11:23:57 -0500
Message-Id: <1605716641-22176-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
References: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:610:4c::38) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 CH2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:610:4c::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 16:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41b90270-7e7b-4ecd-463f-08d88bde6087
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4314372D9037D80B1E8EDA43E4E10@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCcZ0YgSAP9ATOGLvbBmAjj6SZmAPCxqTRR7X7pk8iyT/D7PSJJ54vm7dwmAeB2i4XVLNk99agMa7KS9ygCcybnJrK3pIWf17DCKRT9qtsLJaPgmV1pB3Uyfdrmb8kKmTfy7f23KiZ/j6Pz2q8kqiqgEdeX122Y+m2lQ51rAF51OrcLAIMXLGh3a5O/p1OZkRlT+Zvu6I0SLDl9Y8DK+vXZdUk3wPxMZzuc3fJk4sOHFqWUQdktiZEpgpmxN+/NZ+9gv1XQPfIAyOfPA2aNGdMBh1HRmqso0OJV1ilGstV4i6kUByDbB5RzkjQOaYpA4LwC9a+d9GmXiNigoOt7hCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(6666004)(478600001)(36756003)(6486002)(26005)(16526019)(52116002)(83380400001)(86362001)(186003)(316002)(7696005)(2906002)(15650500001)(2616005)(4326008)(956004)(8676002)(66476007)(66946007)(66556008)(8936002)(5660300002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /u5ttFUQKjYyc2F9Dv35di9/iZfjMNDJCnOfOuO6t0MJpaM5AiSQOKfgu6Q1JqIUz4u/tVJCQHFGQaFORzR34vy4+qx3kbAHQj+CjWjAcwcBfkrb/sXROiePQ5B4lcjD/36988sN3xHLSNrU9a/KmROgetmdPa3KdsXy5AQb6zP/gr83MrBvEyIIvguvM2OFv7s20dtEukMu8/YQoETOpHZ/RabU0ERTlv0vDdxB//oNiasSBagXrp/UOt5eooWy3kJgqrw0APqRO3E3KCHUG0ikbYbuYLQumJHPQeIDx8kbijYaPN7+j2RTHuO3M8zCAXEFVBclM8euWIWNyB5wD5VGBq4DIKqnYQ/OPXJCNrJvu2MEqeyoUQdyf8TwpY8kspgUfu90PerZI7/kyfpdd1gqT7bAayHDn6oNn25PyZ5GZoogE0Ic+kcpMmmIpNaUDzj66cCFLCUW546gGEuNh4rNtEZoSzaX6QR7LJeoBfnWYlz0I+Ars/bMyc4pfbHZhwHRg5rQq58V625o+MjY8WsNwl0qp9gBnT54P4ypDa8CKZvxWq5UrFGlGLAGw7OrtEDtMRVRNC72hp5XLVTKTsKsCLdh5TKix+6jGwAUzBHitdAEFVqVvQVgUh2cmRQfogr2AZPJfcGeTgvLIDZGLOG9aNjTd6DZK6JLbikKHcB0BYDKbTegRTotlYWKjrSFQy8W+1N14iv7j0xuzY3esoDeNAW0iUuAqYG5s4L2MCj2a9SLd9ETcAut1sWF1d/U2f5AiFqQUz4Vn4gN77dFj4HdyyZ9AR8zYFrVLA0Hjs+gkJBCzxKOBVAAeMYWyVq9RrCrhkG25R535N6nxdChrdVxETlN+RMZW9y7+AwFylrvAGRwAeBSjPl+Rjzat8Se9UGZCqmvm0WhPhLwS7uX6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b90270-7e7b-4ecd-463f-08d88bde6087
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 16:24:09.6001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwGBzLphFYcX2fV+hZgyXzQ32GckWedLWaDTel19AFGiBPrsl+0uY2lIPkmGPPkj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

refactor dec message functions to add dec software ring support.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 7e19a66..32251db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -510,16 +510,16 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 }
 
 static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-			      struct dma_fence **fence)
+					 struct amdgpu_bo **bo)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
 	uint32_t *msg;
 	int r, i;
 
+	*bo = NULL;
 	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
 				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, (void **)&msg);
+				      bo, NULL, (void **)&msg);
 	if (r)
 		return r;
 
@@ -540,20 +540,20 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = 14; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	return 0;
 }
 
 static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
-			       struct dma_fence **fence)
+					  struct amdgpu_bo **bo)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
 	uint32_t *msg;
 	int r, i;
 
+	*bo = NULL;
 	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
 				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, (void **)&msg);
+				      bo, NULL, (void **)&msg);
 	if (r)
 		return r;
 
@@ -566,19 +566,27 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = 6; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	return 0;
 }
 
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
-	struct dma_fence *fence;
+	struct dma_fence *fence = NULL;
+	struct amdgpu_bo *bo;
 	long r;
 
-	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL);
+	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
+	if (r)
+		goto error;
+
+	r = amdgpu_vcn_dec_send_msg(ring, bo, NULL);
+	if (r)
+		goto error;
+	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &fence);
+	r = amdgpu_vcn_dec_send_msg(ring, bo, &fence);
 	if (r)
 		goto error;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
