Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96CAC2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A947061355
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A947061355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D45B6E4C4;
	Wed, 26 May 2021 10:10:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE1E6E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+DtLFI0Hp5uf2SRfT3CD/hSaUGmDnMsC6Mv7OopLklh5EZVzEe59dhcht3W4cRmotxqW5RJU2D/7sbC/XAqkDMSfESOq22J7ivuCrx4UJ6h8EgEi8Vi8DxbokynVvKseYoF7mVsSUE7REUE/IGI9gPZcwnk/L9wNjyF0136yU/jb+I+5BRYAWvPKyGZaBtFSNO4NCavhBRRt4jjQlY/Bsd59JIvLl0jb6eII8ubBmFc6AogDt1SnIgadDsOCH8QnCeOApQ+4WVM8kJHsb4cDFAwq1nsZ2ov6iwqzzQJAY6KdKcAQ7lWzxh/G3gqpAqbamNgvJ0jGNsT6RnRcJX8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6EgOY0vi+1jbyLOG+S4PiXtNB47+zX3r96HlH+CB1Y=;
 b=bQn69qpNgfwfM7owh82rCSUnE5lNZnPoaFJHlUm5FLUfWyIgiy7lrfCi1i4ak4gmX2c9+NysYz8lC1VtZO91sSuF+gyHdPxaTL5jgsLoC74MGtHcCufRJ1ji+6BmwG/Ojwl2LB1t4l1Zq/WG4V5EeWunpiatAcui9y3+GXXahFbkkpEgcLwBhZUuvCaiBV+zjWGiyz76Gr5nOVMO5NfrvVY39dorTZTv9B1b+3iV7G6ihHKFBooOsuejenr5DjrREwWnqktbvVL/UId9FAR7JL1LdB0nyGkkm4NjzCAJdCmMPOvXJcy8SkNbGKt6duOc3X10ZYaPCzLDC0uLjj7BqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6EgOY0vi+1jbyLOG+S4PiXtNB47+zX3r96HlH+CB1Y=;
 b=CywfIV8x/ZVyqzAy0mkj6gihqpcEo6fjnmpElHVh1IBXStVawl59jWgrWpFBIzjHH5omU99fUX0wp2c5eGP1qGCvriVVlCIDyS28LDFobfaMNZMjoEKeBK8k3Axw7JxYF0hIBTJfcKPfz8+k5BziK1r5ToNUCwRq/mTFkblNZgA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 10:10:49 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 10:10:49 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu: add amdgpu_bo_vm bo type
Date: Wed, 26 May 2021 12:10:21 +0200
Message-Id: <20210526101027.14936-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 10:10:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ac7dcd6-8d38-4a97-48bb-08d9202e88ff
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB523274B5AD822C8B865FB5038B249@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcVmFGkaeDr34H5+FplyEay4bR0lUGpQyUDx4QP5Xz9U4AbQ12Lt/4XqXyVARXeT6sG2ibwwVCpkKeg5HlWk9v5SMdfT8lp4NmKnRXV95yrPW1gAcJcgNfBmLWrxhM3TOdRUxTSPwhhlLrc2U+kp/XZVBuqjbWgBLeNMTnbv9xw6Bg8BVGILExs6qyB4iTh836JnkkAusKIYrEYGHvK0G3kW1r844qdd0FOfYibbv8rVQ5lz6XedQUQnS4p7ZSuDUYWb/8qgc+tCTc1sPyIeOjCCXCBlrqvvSbSmXZWrBnQZwhLugNPKt7Qqw1QTTMfdnBxZ1P7q0QxG9Cka1fILwpcPvilp6PMqPRtAnOnDWsGJRS/KHqd+cdU+bPeGgRoo+uAYIc4sA9ae3GMjOAbrmsVrw2Wr/nLhnGJC5O8zWydQMYvKl3qKi7OqtAcgDUKMGcoG9hAEYjTwThPQecKnrnEvKvnvQ0OSOkXxwXFt8vQROrp2u0GIsDMJCu4VUR67XfEr60SgUXq7hppThSqyEsE//aqkll2LK9Dixc2Ez2KPe0LN623N9lIHYJyPwBMjPWpBWcymxOjDXWoiu/bpIBki6/lK1l6hlea2BpA+wZLfIk7xkjtA2qBx1qEU4GdD2UYKxFZgYIfdK17qnBZ3uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(5660300002)(66946007)(66556008)(6486002)(66476007)(6666004)(86362001)(2906002)(1076003)(6512007)(83380400001)(16526019)(44832011)(36756003)(186003)(6916009)(26005)(956004)(2616005)(4326008)(478600001)(6506007)(8936002)(38350700002)(316002)(38100700002)(52116002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zte5+tIa/RHeSX7t1ZbmX6PYnWyhRbx8CTzI3eArkZxVgIlCgHAntTjQvvD9?=
 =?us-ascii?Q?IhVOb47ec+p7ZBmQWy7UQqLQBAIQ690S9hqAmhrGglbuTRmoDcFMV2FewaYM?=
 =?us-ascii?Q?9OG5Sk7Zpuk+geOQ+JwcrM+XyWkRR5Yehe99bJbSjSVdQhFTe4TtVZhtLvcw?=
 =?us-ascii?Q?Q6xTgqeVPLwwYm2KrI7OhxIdi22jRnr6bF0DIg9dBnsp1LO5tCOkczhSiDvl?=
 =?us-ascii?Q?LGXwzeGJmKTEDJLkPPZel8ejf+0F1EX3o96pl73/VRgigWWHOqgoPYpCRnmq?=
 =?us-ascii?Q?bIXI+h+eXDyqP3Ss9HYaQWieNXEF+gdRziMupOYaBENt9UuTZgYq/MnPafAy?=
 =?us-ascii?Q?F+jcq532h2HpFqENvFKmcWYHkGUCMl2lD3fu/aEuD3xzfbgLCGNa3Q2RSNxX?=
 =?us-ascii?Q?kGjBk3eqCeTmpNyv+nQlNWaE1i9DWNyPxT8lObOaCVYO79sDAQCZbh+0HOFC?=
 =?us-ascii?Q?fy07kv6IB7PGUrhcAoq0a21UWV4G8IyN5MTwh7Rd0/9TvMJf+QNJvF2FYJfy?=
 =?us-ascii?Q?/1ZetpoAfO1VtE0QYkbAqzSAdmKyJhMgdESAy0WPS4YBS5FLaVFwYjF7k0bF?=
 =?us-ascii?Q?ol1oBS2YcjfQliosNejI9LHGt6VJzmzDYkmNWAquOkqQtZelYU+Lg1hGdBhk?=
 =?us-ascii?Q?HqAp1CBwboFy+LGl9DLlqLoOHHw/Ds4dM2E+ykWNoLdsARb1AsyfFF+ZnOqP?=
 =?us-ascii?Q?Lno06UKkmEBWAn1lE/eHIR7X2o29G3AntXA4nOn3HaI/7h7hT3vfPoZROuhx?=
 =?us-ascii?Q?yNMKCCcAjwkNlwGhmdf6RFKR4Y+AtWlaNCUTAl17/5MUxLQI9mUJl6jx2cbQ?=
 =?us-ascii?Q?b7bCAqB2W7sUInSPlhp84VSm4YGnJUJQiYzojDpgyH9VIVbtNB2WoBniEzNZ?=
 =?us-ascii?Q?Dyf8KulLQD+kk/Aw5X/nwI23cVL0sdCqHmOo2LDfVABADTb2leX+Tk83hwtH?=
 =?us-ascii?Q?YzCMMIAA4Hhkoe4GeCS+BFlna7Zi9k5p0TDJivsEpWNdQHhg8/RJK4A1mjD8?=
 =?us-ascii?Q?FLQ0sqU420jF7v6jZOoKDO0nNeBMpohMvCbknAq4eCPTHUsHsC/B8rcpyYyH?=
 =?us-ascii?Q?WPy80/afVIYi89kvynvENFcb1xcgTK04KaGi7Cx6y79apEFzFWJSV1ESvZY3?=
 =?us-ascii?Q?Jm5x84rd+Y9Pd2f7d30urJVcEkf4DJqmqdtNMonfsc3bQASO9/nJh2DQU6f2?=
 =?us-ascii?Q?Ux+iHADo5uVAUhD/JaTtaiVEUDRcVFcXBX8WnEcdO30STGjRLcsITyCZ6L3X?=
 =?us-ascii?Q?n38pF40pfYuyhIXraL3u6aFdTHF1zz+D4Un8S4iNWnvsjEbx1xrEiVylnV6V?=
 =?us-ascii?Q?MA4gD2CVeSEsK1YOjeI61/xi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac7dcd6-8d38-4a97-48bb-08d9202e88ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 10:10:49.0085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmH1ed3yZKqX8vclcETxuir82g+ZFLRtPV1wiA53lfVMJFEvWHIGnaWUt70Q0ssyd836eJnKtlt/i5/6hqt0SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new BO subclass that will be used by amdgpu vm code.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 32 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 10 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3f85ba8222ef..6870cc297ae6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -694,6 +694,38 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	*ubo_ptr = to_amdgpu_bo_user(bo_ptr);
 	return r;
 }
+
+/**
+ * amdgpu_bo_create_vm - create an &amdgpu_bo_vm buffer object
+ * @adev: amdgpu device object
+ * @bp: parameters to be used for the buffer object
+ * @vmbo_ptr: pointer to the buffer object pointer
+ *
+ * Create a BO to be for GPUVM.
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+
+int amdgpu_bo_create_vm(struct amdgpu_device *adev,
+			struct amdgpu_bo_param *bp,
+			struct amdgpu_bo_vm **vmbo_ptr)
+{
+	struct amdgpu_bo *bo_ptr;
+	int r;
+
+	/* bo_ptr_size will be determined by the caller and it depends on
+	 * num of amdgpu_vm_pt entries.
+	 */
+	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
+	r = amdgpu_bo_create(adev, bp, &bo_ptr);
+	if (r)
+		return r;
+
+	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
+	return r;
+}
+
 /**
  * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
  * @bo: pointer to the buffer object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 11480c5a2716..a7fbf5f7051e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -44,6 +44,7 @@
 #define AMDGPU_AMDKFD_CREATE_SVM_BO	(1ULL << 62)
 
 #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
+#define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
 
 struct amdgpu_bo_param {
 	unsigned long			size;
@@ -125,6 +126,12 @@ struct amdgpu_bo_user {
 
 };
 
+struct amdgpu_bo_vm {
+	struct amdgpu_bo		bo;
+	struct amdgpu_bo		*shadow;
+	struct amdgpu_vm_pt             entries[];
+};
+
 static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
 {
 	return container_of(tbo, struct amdgpu_bo, tbo);
@@ -272,6 +279,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_param *bp,
 			  struct amdgpu_bo_user **ubo_ptr);
+int amdgpu_bo_create_vm(struct amdgpu_device *adev,
+			struct amdgpu_bo_param *bp,
+			struct amdgpu_bo_vm **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
 int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
