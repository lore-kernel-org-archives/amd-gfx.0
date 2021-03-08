Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C76C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EEA65208
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EEA65208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30F289B96;
	Mon,  8 Mar 2021 15:37:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED51089B96
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 15:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TElseafhPV5/rhg9H+fuMs8FL1bB+/HAM3G0w++FPsLpJFQ7z2Jn6WNX45mh4hk89YOlXFJ9fF2zb5cnJ+9Vq9ejX3rQjakbT8RoutD6FD6coWFxTrUkE3cCTBuZnwnvs+HgOd9tRkHs4SziU7r/k5wYdwA4Ig/cjPrAaeUbT/S8qiskfMqVUj+4sXaUxfknwCq8UL2igfQOp4RvdX7wxbLEEtfVXQu3+75+Wu6Rc8jFc4YqF0LM5ZJWAbEpyGgOkUlURvmq27SxaOWgHJFBlTYAPHdrfFuGMBS0DTUEDQ/4z/QwC3ZzukRxpVwmEIf8p1Ja5WksoIx30Kvdy7eHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQxK6xEkRHX0/qQcXQu6bWvcPUL0XBZVvEQJbtp/VKs=;
 b=EHHwOQ7aPR6GR9GK6AklacoCT8lSDSzRGJDugHShk04EadaYcS5soCnP0m+jZtMSXh28sD7wjVVJAT+21kNSwSOmAP24kueXDkYmYZwlL0KxgFnBCpnAXUeDw8BXj1fn8criLzdX8WTmarJMm8Wn6kZKHfJl1KkBNlw8iXKc1KxUV23piRgzy3+gcc+svWRz4XehLW6RagVKTqjJ4DWGMM70j6wbOG8UHbJab/JiKxE158avzCBt87Ozf+NN+7VWakuQdO6RW88s24E9DhzKG+YNmoYGpRhDmSHC1rGs6Sp+QC9kHCXxqFm5SBaLjK58odK+0AExI/uFeRj+jx4Qig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQxK6xEkRHX0/qQcXQu6bWvcPUL0XBZVvEQJbtp/VKs=;
 b=zGly2I7bH1KrC6m3s8/kxBijxAO+yJFP0VPvV4naTDgRBV4xyoh7o1KtywtwozZMQzt4C829kH6QCZfRyJ2zZwCkHRJnyNnikAcDZa7RgJnSq5In6pn8xNLGf0u4XcGGEEyb8nFzuTvbd5uJtufqY10/Gbq4jEtr7YJiKyvljtM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1237.namprd12.prod.outlook.com (2603:10b6:903:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 15:37:21 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 15:37:21 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/5] drm/amdgpu: introduce struct amdgpu_bo_user
Date: Mon,  8 Mar 2021 16:37:02 +0100
Message-Id: <20210308153705.37414-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308153705.37414-1-nirmoy.das@amd.com>
References: <20210308153705.37414-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.42.112]
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.42.112) by
 AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 15:37:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 861b938b-1b1e-4683-0240-08d8e2481025
X-MS-TrafficTypeDiagnostic: CY4PR12MB1237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12378C773829B6530115B9DE8B939@CY4PR12MB1237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PI8XEBW/uCp8mfF0wRbHZlCHZnCdDUUJwYBb/YEltT3jjsTtVvyAdK3zvJp3/OaVDsovKu8GD/1/pVFYqnKvDTNisgCPeVq0NGrnVK/D5Jy3OrDHz7/90weBSJLT0fD6GaBpOkt5lOwJT8Q5CYC/eWvak3t9K6RfKkZtLvCJFEDlCK+sN6/DL3wYFB4P7TjScbtutQEOcd0aWVgc6mWwV+q7wMUjZw5se5f/wTCVckM2b4kGo788C9g4kDduXklabpzKtirMgHA7E9dZ1WkZ9hDcIj6O1brkf7IhuNYjN+HQhd4m9RlEobpkoKY1y+OJoEjWUkWNGlTI9vtUpFhnxrg7yhIws3BEJurcpxPnrGu7Whh3GEENy65r3mUD/ByqsYcbeWNOj1JKzbiY91gmx21AQBbfJqNrzzml45N5RDluFKRBQ7lEl/JTxFXjpkuB4P2rmXmkhiVwmq15NIAezuv6iOF7Z31VLL34+b5Z/QP7ZuXDRXL+CHGBbLPTDR1P4XUuHvfoEWV39+JJm8cJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(186003)(86362001)(44832011)(2906002)(6506007)(16526019)(66476007)(6636002)(26005)(478600001)(36756003)(6666004)(34206002)(37006003)(4326008)(66556008)(5660300002)(6512007)(956004)(316002)(2616005)(83380400001)(1076003)(66946007)(8676002)(52116002)(6486002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yRcuI5rZoPD7ekGW4y9QNZIdTWR52IWkQ2qfhbypI5blxrAz4p3U36g85K61?=
 =?us-ascii?Q?pfIs01j6UYnAMgHpWFR++4vPlzc+FZQaFxUa33L6me0tHTWjD8ZioAG264cm?=
 =?us-ascii?Q?rBd8p6gz8mal/9gaZcA9yvVon9oV2vnEm4FvJQUmRPtwygpY082UPy29Dhln?=
 =?us-ascii?Q?kH42KfzefLtpRmip0WurPaWlEOkM6mGk9biKFgS0q/0AimhBXlcPdAX0kWQ4?=
 =?us-ascii?Q?pWCEnV0Fx4OV/H5HZ/Rz2lwhHn0/fsxayl2dLn9mupUka+QyHra607n6DuXV?=
 =?us-ascii?Q?MWAegtAw1yt5+u/YhG+qqgUpDfWIRlGArICsb9rOVJVawNKGv3ot40o6JfiW?=
 =?us-ascii?Q?/cK7v5+4mMJRu5foWer6nQ+QHDoa2GUkdm+y3zr7EMzSFD+vG01Y1WPJRbaN?=
 =?us-ascii?Q?dbwCm1bB85Pv6BQzSwJHMAP6N6aw0Oyr2NGgRfdE4tWC7IUNwqd1NTNc6+7B?=
 =?us-ascii?Q?j9jYWTGgqG7DZrg5J31u76oe+uuj0NmIEJCkpCxGs5azg0PQ2ZD1RKMPaQWm?=
 =?us-ascii?Q?ZNs8hbZmUtmhunRvCV0oC24k/acxDR8geH4kv7MOHRQGcvadzq4dfg7TjY9t?=
 =?us-ascii?Q?AjG9D6xFe0gcFlQP6YGMfRjkvDkb48CyXdEYqHivvEnEm2bl0zfj29v+BaXL?=
 =?us-ascii?Q?lp9NZR55GREogDetQeWYmKj06ICU/A14ifIeKYjt9/oNXVjnTjjKoSNe4JTL?=
 =?us-ascii?Q?ZCZ+1U7JlqDUya86NxsE9KbhiuQiBUZ6McbKRMQCREw04Noq9IuCj6bFUJOT?=
 =?us-ascii?Q?uYHg32fB+CtxygbkwFf9VJPmFapG7bdkTqpeo5fRhDKCWuAS60+EBkz+D1Wz?=
 =?us-ascii?Q?BhX7LaVI8bWC3zW2BKTFwwWRiLJH3pFVH/iOKA/pbPap6c1NiMgUBuqjvr33?=
 =?us-ascii?Q?de/cNNTBUEStnWuIlGiw1p8do+Z5WlfJ41XTsF7oEieI7cr/6n17x2JHDf0K?=
 =?us-ascii?Q?M5bcElhskl3OCEmOB2cwC2Rb1C8J6nUeSBKSgI+ZPLScs+wu/njsaME2/QpC?=
 =?us-ascii?Q?8eKHsTo5WhKHZ2m6sVdPBTckJS1uif54xumbxLdsK1UIFPeK7cigcuP69e31?=
 =?us-ascii?Q?dCMtN3Jm2E5BDnda+jYApgSyRojJiFB0tvt6k2eCMqNW7mNnbiqVO2+zETRq?=
 =?us-ascii?Q?/Y2UBaCc4GIG+sQjM9+s8xDoqgfsh0NPVU/CQT6TFSG39clG28MN2mzECxqU?=
 =?us-ascii?Q?zfRKxpkTtZT9J2dFVlvds5n6OEJJhedIOaQ2cL4Wzu/dgxNfzdHdHKGXo5Vo?=
 =?us-ascii?Q?uvXuAMrgRKdsFBLw0/tPQJviAr/xNDLrLtp0TG4XiVVEsXni/uGuykQo0HIP?=
 =?us-ascii?Q?3G7pFMcF6YMp1u3rYQaw98+K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861b938b-1b1e-4683-0240-08d8e2481025
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 15:37:21.2137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra+5lK4OsKR1yUZojhEl431lA0W6jqyIGrkbO0o0OZ+0obobwD/t2b4cGp85vbo+GEvYapyecgB+CWqJLXujvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1237
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

Implement a new struct amdgpu_bo_user as subclass of
struct amdgpu_bo and a function to created amdgpu_bo_user
bo with a flag to identify the owner.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 14 +++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d32379cbad89..abfeb8304894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -695,6 +695,34 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
+ * @adev: amdgpu device object
+ * @bp: parameters to be used for the buffer object
+ * @ubo_ptr: pointer to the buffer object pointer
+ *
+ * Create a BO to be used by user application;
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+
+int amdgpu_bo_create_user(struct amdgpu_device *adev,
+			  struct amdgpu_bo_param *bp,
+			  struct amdgpu_bo_user **ubo_ptr)
+{
+	struct amdgpu_bo *bo_ptr;
+	int r;
+
+	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
+	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
+	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
+	if (r)
+		return r;
+
+	*ubo_ptr = amdgpu_bo_to_amdgpu_bo_user(bo_ptr);
+	return r;
+}
 /**
  * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
  * @bo: pointer to the buffer object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8e2b556f0b7b..fd30221266c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -37,6 +37,8 @@
 #define AMDGPU_BO_INVALID_OFFSET	LONG_MAX
 #define AMDGPU_BO_MAX_PLACEMENTS	3
 
+#define amdgpu_bo_to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
+
 struct amdgpu_bo_param {
 	unsigned long			size;
 	int				byte_align;
@@ -112,6 +114,15 @@ struct amdgpu_bo {
 	struct kgd_mem                  *kfd_bo;
 };
 
+struct amdgpu_bo_user {
+	struct amdgpu_bo		bo;
+	u64				tiling_flags;
+	u64				metadata_flags;
+	void				*metadata;
+	u32				metadata_size;
+
+};
+
 static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
 {
 	return container_of(tbo, struct amdgpu_bo, tbo);
@@ -255,6 +266,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 			       uint64_t offset, uint64_t size, uint32_t domain,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
+int amdgpu_bo_create_user(struct amdgpu_device *adev,
+			  struct amdgpu_bo_param *bp,
+			  struct amdgpu_bo_user **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
