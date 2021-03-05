Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B065C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0464A64F4C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0464A64F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7864E6EB98;
	Fri,  5 Mar 2021 14:35:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B25B6EB9F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 14:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFtQDotcfr5nTXwvIK20rSnmCfImfK23HJmtfMxoJ1i5dqkA4wXEYzHLRVaHWEq6Axd1fnoSOr78sjJVXteRwbRhoCJCXefHLztemwck6SLzY2wE1tZJ2Td9TauBPSR3eaCJVmzFXKAnUMkie9F0TPQ4tg+AbjdGzjIIty7yCen9KsTLG2TcOMbwsEUX5oRu3aQPffTp50wFdsruZWj7oxf7IhlLmyN1GgRARiB7I1F1IZWlzdzgwWmhN8d8kW7il6Wuy69LaowMnxQ2qtkHKUuthGB5HKrv0BOVELTgW5gMLHgHk3OFsRt1yHchWWYPAr+9R5WiOgBCQLBqWQPZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCkh2JoK3osSkSctN3Nm5eRZz3DA3A+sBnPzIeqKIfw=;
 b=K6ZpYGd49+hvWz3QOp3HWymY1nXuvcf9Hg/Ur3ZWXGtZrov74lVPmHexaPXvLzsmzaiy9EXPwz9ZcOElKxD58rJ20dkcysSeoVN6VzHwCvLUMsY8n4bxSUlaDbG1zmrd9UauhCgAnsD8r7b5VmwR2jTLkqCvqKVQ0EopRqc/3wLXIptP+CGwqbFwu6YsZx73VWGkEz5bqM/5ARb6NgPsg5FifHECrj9Bab/QIkFiknYVU4BmUgDK0sNmS0OPTHEdxE7S30C43stgfetJ7YhXOvl0dhNS8HAPa5CIhhorjd9SqxNdtYoCSH5r3pBf1hLLIwBCXX742tMwv9/85p9pYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCkh2JoK3osSkSctN3Nm5eRZz3DA3A+sBnPzIeqKIfw=;
 b=rS15SrN16DVuFhRxQhfhpT056RQdt/pJkqK1S5Jt9E3Zqh1xDhFttbgkpNfqjbuWkVAD87WsznQlIr3NrheSzRr9vQpdC2SogfWulLguZ/N/JUiXNWtJaonPehQP3Y8EpvtvGWnKK7Za0bv+yZoA28Er/XKkEGQi7EGD4wlig7w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1544.namprd12.prod.outlook.com (2603:10b6:910:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 14:35:53 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 14:35:53 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 5/5] drm/amdgpu: use metadata members of struct amdgpu_bo_user
Date: Fri,  5 Mar 2021 15:35:32 +0100
Message-Id: <20210305143532.5936-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305143532.5936-1-nirmoy.das@amd.com>
References: <20210305143532.5936-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: AM0PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:208:1::15) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.77) by
 AM0PR04CA0038.eurprd04.prod.outlook.com (2603:10a6:208:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 14:35:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91a206b4-d007-496f-a4db-08d8dfe3faa2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1544EE7BB18012B51B9D13488B969@CY4PR12MB1544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWd3JgDKBg5ELYprVVFimZQ1h6v1utT4aiRbyqTBF9tkADtFi9UjUSp60SnzjNKSYaSaNbxzUkvgFHnfLwXxM67/XAeRPAKc8KLcjMzpUPCIIevZaQXeX7mEyJtWLtYm49QNOfsiFUKHvwolmx+YNdBoOKLsFR2S/yx6upPcC+7IEvQeaL+cVcbODtq3ASpwNnTklosSy0Ws4kG9QLpF+QuxkPN2WyKqWjXi6JW3zCQiFyvvQZdV5r9G2EFh19bJkbPbWOZa9hT7Ae4Hrurpknl02UefxpSro1vWXiNQdo7mV26uO97jJiPBRCXnMSQUPO1q4Wknrc2NAAlGVHpP6sPjgCQYM2AZmvBDt1TBdoHIcvAaNtHOcaPzonvd3kzSMOPznhnARBmsFO9/xvMt2zl6jbyXNoCIIBXXIXPnfUbVGJASzWxO6bYiZWG1mMEJGKKXQcc73MLk6MEaUzpWSXoxc8g88LaKZaUltJThE9QV8wuRi0fYJ+7yXNnrJriOXVvOUFAdcg0vIkNyqrZyig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(956004)(316002)(6506007)(5660300002)(52116002)(2616005)(83380400001)(8676002)(66556008)(2906002)(6636002)(4326008)(34206002)(44832011)(37006003)(66946007)(66476007)(36756003)(6512007)(1076003)(6486002)(26005)(478600001)(16526019)(86362001)(6666004)(8936002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?289ChdUZfeY4DINosFyvLl8U0xXW3jej6TnFX6T/jo36WRYH1rONOPoY0WTo?=
 =?us-ascii?Q?9DRQGCLZ09fpNfrduJOwWONqA3Iw366li59UET4Hq/re1aL+VofvMe+tll6P?=
 =?us-ascii?Q?UqVbbez2WpDQYlpzU+mrf+py9wIhVvFkeWXSKVflD3YGwHQWjc4R5IxvvdG3?=
 =?us-ascii?Q?v05CQJQ/nfyH3afMuuYpGlv7jKaL6fSP7fmJQszYP8c5ipzq6GyWh6VsAs1t?=
 =?us-ascii?Q?ZqG4aD2YJCl63UDpLvFUV+4a9xjIJ7WAqp2nfFx3REcYkzxm8Wvd/zkd6CHX?=
 =?us-ascii?Q?GGzEmUW8YKZQoqjDKpZT6lo7USovqfMgLwLYRb2Un2iyC+gqdZS+OOLBYIyB?=
 =?us-ascii?Q?MCENYo2JP/1lh9LGhaZ5E7HH9o75cUwl8NutyHulW8oOYhUj9TUzTWYGtmjU?=
 =?us-ascii?Q?vGCTU+a6SBhAiJ/a8TAX/NgNzmvBfslpT/FIXPCV3xnSGH3ypo6MFcFTF2zC?=
 =?us-ascii?Q?zizSpJoQnaOsIf4nvTYB/abQYIuPBpaoX/s0bpiLLl1NjGSjZwztqyNzMzDQ?=
 =?us-ascii?Q?Ek1cgzHac6LILalbM1mcJzd48dy1u3wSo9H+zt5mB/pTRgUGstaINZG6Jd/t?=
 =?us-ascii?Q?I6Ti4cCqGrJ2IAsotXVHpATWWbmjP/tFvm2j/UlSPuhePyvpvGBRUbZzALAu?=
 =?us-ascii?Q?+7mie30050PR/14JmWBWV/H9fhe5gxeX1Ru44AmOdZTgjRBXLz+K+FI2iweZ?=
 =?us-ascii?Q?oc4/Gz6q4WbQk1aTjGlNeyxz2R98aZsFy54p7uqhYwZMJMOaXyYUwf2z5wdc?=
 =?us-ascii?Q?Abwd+yV9GkhK1tyIuydOEz+jZCih32kgb7n9Q+wNGuZGijQGZqMf5XsMGle+?=
 =?us-ascii?Q?f1Aq16GBqQmSIm8ZEEToT9X0o3LlWGwwcmZKFrdEs7sLLwUbLzgRrWt+Zwtb?=
 =?us-ascii?Q?b135j67OphtGbBIQrtPmZvcKMVePCpLYJcQiEAaPHvu37q9aAL9UdRnlcZOb?=
 =?us-ascii?Q?h1Pb6Qt77VjkQ4a3btI2YzY9D43yE9UUwDfCaeF74eMP8GwnMcFvyU8eGVF2?=
 =?us-ascii?Q?51h2fUJXqyTCRU2Hu7MDo6ra0u6sW7SAv22SvJ86l/Q+9hjl0k7Y46TIkRn0?=
 =?us-ascii?Q?y6F59vbHrqNpsBithA+b2AyrfC7skMEPg1QSXWzFiO4bYo4bq7jyumed4m9Y?=
 =?us-ascii?Q?7X/LSL3KgSOYzjU7u+s0QF6g7NhgFmBAmg296AYSqzmH1ClvccURgPHm+8Rq?=
 =?us-ascii?Q?YFgJBijmMBYZ0S3FZ9CYs2UBeCsot5ukbQZ2rOBgXaYv4PtvICCjwu7YzG+s?=
 =?us-ascii?Q?m2fmIQRidLaVx3+w/zE6UeAdhT/XksJBOV40YQ8V8oSXzSDAWnoF7lE2/XcE?=
 =?us-ascii?Q?E31dKuoR5LxQhZQvyh/qrFbb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a206b4-d007-496f-a4db-08d8dfe3faa2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 14:35:53.0027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGJauWzS95MqeBvpuOhJJ2M67Dy5akh/7+a4w2G9CKGMSifsNl2sR4y2o8OHJdDFWRbGbBm9qMFbLBvV/89Tyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1544
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These memebers are only needed for BOs created by amdgpu_gem_object_create(),
so we can remove these from the base class.

CC:felix.kuehling@amd.com
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 48 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 --
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c5343a5eecbe..f8c8cbd8ab59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -494,8 +494,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 		*dma_buf_kgd = (struct kgd_dev *)adev;
 	if (bo_size)
 		*bo_size = amdgpu_bo_size(bo);
-	if (metadata_size)
-		*metadata_size = bo->metadata_size;
 	if (metadata_buffer)
 		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
 					   metadata_size, &metadata_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2e5cf46251af..81b2cff42481 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -77,6 +77,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_user *ubo;
 
 	if (bo->pin_count > 0)
 		amdgpu_bo_subtract_pin_size(bo);
@@ -94,7 +95,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	}
 	amdgpu_bo_unref(&bo->parent);
 
-	kfree(bo->metadata);
+	if (bo->tbo.type == ttm_bo_type_device) {
+		ubo = container_of((bo), struct amdgpu_bo_user, bo);
+		kfree(ubo->metadata);
+	}
+
 	kfree(bo);
 }
 
@@ -1230,13 +1235,20 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 			    uint32_t metadata_size, uint64_t flags)
 {
+	struct amdgpu_bo_user *ubo;
 	void *buffer;
 
+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not set metadata for a non-amdgpu_bo_user type BO\n");
+		return -EINVAL;
+	}
+
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
 	if (!metadata_size) {
-		if (bo->metadata_size) {
-			kfree(bo->metadata);
-			bo->metadata = NULL;
-			bo->metadata_size = 0;
+		if (ubo->metadata_size) {
+			kfree(ubo->metadata);
+			ubo->metadata = NULL;
+			ubo->metadata_size = 0;
 		}
 		return 0;
 	}
@@ -1248,10 +1260,10 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 	if (buffer == NULL)
 		return -ENOMEM;
 
-	kfree(bo->metadata);
-	bo->metadata_flags = flags;
-	bo->metadata = buffer;
-	bo->metadata_size = metadata_size;
+	kfree(ubo->metadata);
+	ubo->metadata_flags = flags;
+	ubo->metadata = buffer;
+	ubo->metadata_size = metadata_size;
 
 	return 0;
 }
@@ -1275,21 +1287,29 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			   size_t buffer_size, uint32_t *metadata_size,
 			   uint64_t *flags)
 {
+	struct amdgpu_bo_user *ubo;
+
 	if (!buffer && !metadata_size)
 		return -EINVAL;
 
+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not get metadata for a non-amdgpu_bo_user type BO\n");
+		return -EINVAL;
+	}
+
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
 	if (buffer) {
-		if (buffer_size < bo->metadata_size)
+		if (buffer_size < ubo->metadata_size)
 			return -EINVAL;
 
-		if (bo->metadata_size)
-			memcpy(buffer, bo->metadata, bo->metadata_size);
+		if (ubo->metadata_size)
+			memcpy(buffer, ubo->metadata, ubo->metadata_size);
 	}
 
 	if (metadata_size)
-		*metadata_size = bo->metadata_size;
+		*metadata_size = ubo->metadata_size;
 	if (flags)
-		*flags = bo->metadata_flags;
+		*flags = ubo->metadata_flags;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 6cc38b71f7ca..466081fa2083 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -91,9 +91,6 @@ struct amdgpu_bo {
 	struct ttm_bo_kmap_obj		kmap;
 	u64				flags;
 	unsigned			pin_count;
-	u64				metadata_flags;
-	void				*metadata;
-	u32				metadata_size;
 	unsigned			prime_shared_count;
 	/* per VM structure for page tables and with virtual addresses */
 	struct amdgpu_vm_bo_base	*vm_bo;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
