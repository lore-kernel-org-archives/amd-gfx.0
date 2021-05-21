Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C23C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BE8613CC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BE8613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A796E4CD;
	Fri, 21 May 2021 12:46:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1F16E4C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 12:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IO/cJll96oLdQpWeboEx7MRVrHCRNrLbJIXQeT+7r2gIL0Em5PyPIyRJD2nlW5S1xJSRvA9UGm5S/RAoMfXO/awTGyFmlHRRrClsaMAChbGikHGRTp48Z36iE0ofSZkTGCTwmhL6+a32ppQ+s6cU6PiM5PHVxU1klzlHBYkdi9M+UxHqpG8hkQVwkoruGnf0hQ3oQWMKEcPHTuYNic8Myvivw7NJ0GHvDKqTqlh/NzLZnH0pkdZ/I/8Up/Cr+AhV1bdEQvbNnB+tlRHNKRd2iyHQcgwHmqIuV/79y/oyadW2xfdgFASEwXJLLsu0M91YoXJ9ja0J5mySYY9O8N/lqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcFrXlIV68nCGUsK0+1hXV6QwAKN1Df23wOj7YB15xg=;
 b=ct1q8YxCkc9XXEafFjOM2B2CVxpFVxgl+tBhp8xuXKVGsoBtb71GSxh1vfcWeHsOEQtSKXpLXQb24oIvtIea8Gdj0AGcgVj8R4yxbjETmqPvPT5vtTXmeNttkCGUX23EwytZ3kErCwRehMS06HEz1X5zXiI1qDel1axbfTKrstvmtA0/JOzbD+U7gJssm71wSqCdTA2FFRVcRULyEtu356LXODW7/RFB9VBiIFZARntLwVwL5GrLAbQw19SAba5Zt48leAOL/4C+JydPLBq312IxcMjlLHY6VbJmj6p3Wi3YgYN3zgSyz+SXjdxG/Cov9JmZKNqNoViESsLjZTHCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcFrXlIV68nCGUsK0+1hXV6QwAKN1Df23wOj7YB15xg=;
 b=NBz2IXN/eDzWxJO1AUUvwp7GXk9bS7mGUU0yrBoyqvTnRplM/s0Buw1K5xHt4hxFiBeAIe/ml+mTeczfWxst9uUqi6SG2olUF3FpPC5K5+7v/J9FFOLqqGI/Q1+QML/bNYgJJSvinKgycJint3QycuCgk9M69czuad5zr+l3f88=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 12:45:53 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 12:45:53 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu: add amdgpu_bo_vm bo type
Date: Fri, 21 May 2021 14:45:27 +0200
Message-Id: <20210521124533.4380-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.105.51]
X-ClientProxiedBy: PR3P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::12) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.105.51) by
 PR3P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 12:45:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16c5ea54-61f8-4843-649e-08d91c565ebb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5133A1316BEE0300F8B89F698B299@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeoP1Qe1EAfhGx+9EjJpd8shOydci5MSSNMTJ/9XmRPu/FVf92j4Uc56knu7gVDr8W922kqxFODJMkDw1AAO2VDDX/nRN4iui35jgz5e3HGTcQPus12UQEyelO5U8N5i3wwE7Af4BgJyfc3T6g81qLhwib+JEB9Us8k2PCmTG56LGyFXng9MEqTmUjXSw1f+vorz/IhGFH6ACIP3qc91hEHLApyo0tsGl59NjofR17d7OVW/Q9K75Wbe+nYRZF93Yop7Bdr4j0F2pXEpssk4LCX6QMrxRJncYjZwvig3x5o0FxZk6euQr38XmznIWZaxB1e5n8tXa1dfsMSefUYg4crM2V1Eh3bO+aih6V1dLxlc0COGI2C135tLmGPQoNhlRAFezZbBBg7AgMMKjOKaPZFcMcXm+KF36OAaKat7XeLGD95/+7TjvxMJSrhJxOTngu9Se2Z5gmjDXajuUJTN8qdvNtk2JaGwr2EFUNRwPMXD45y8pqbGxlx3PbuOS/TjrU77r3l4Hj0dYSJliobLKgNZf6QBy0DCGpHTB9BfiqDHyEuxbP3AwlsKr/wI7t8D73HmsP8cni+wlQh6f/wNoQQSLBAORyEE3xPUDg2x/gn2jiPnGyp1R89ubC6g3OUT14S98cDPO1F7ct8Fj1h6/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6506007)(66946007)(66556008)(316002)(38100700002)(8936002)(26005)(6486002)(83380400001)(66476007)(2906002)(6512007)(52116002)(8676002)(86362001)(478600001)(38350700002)(36756003)(5660300002)(4326008)(6666004)(956004)(44832011)(1076003)(2616005)(186003)(16526019)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VhTBmTAfM/LOru5wLhn4GF/PqQ8LOcNWKcw2bEmQS9NMmUwkuNlvCkxAKgEU?=
 =?us-ascii?Q?5504GQlOP47S2wGe0LFhiYPqM5y2U3e3JX2fyiMow2qMx0qz4eijKw+saJNL?=
 =?us-ascii?Q?uLlVVaQH9txrsyazjF2mKEgoUHEQzEUI8olOzk2BrZgPDbsAP+6GmUFA7dQt?=
 =?us-ascii?Q?lDQReboLF8eE5z542wCrRN74jmowY91P9jHrQjEifWybicwpQ1nrXyV8BH6T?=
 =?us-ascii?Q?fV/fDkG5qyY0J8JxahmQePYfxII61UF6xNCkIeGICCj0w9QmI6UQx6SXem1b?=
 =?us-ascii?Q?H+UtAE99qvHdkuajGeob0H2lMh6+RdXujnfwe0tdtVdo+rh4hY3W10PtYGpZ?=
 =?us-ascii?Q?UDUW13egt1AIHjwAdVhsNo2gPYB2/QZY4eb4amHyg5SQIdN0NQzQicVblg+3?=
 =?us-ascii?Q?WBC2xvo1eEX7V16YLaCrnU1h1w1/h+z6VSVVyVhk4iWhXRWhqnF7NUQNDXs8?=
 =?us-ascii?Q?y/3epAwby6R2po+KjKH/cC47hA+AoU1Wd0z1TR7XQyqyspcZ7RK/OPFtvCD+?=
 =?us-ascii?Q?ZfVhDJRyyPW0OATXvyby2A9H8UZ5kGinKHFLt4v2N3BilMh0Jl0XyBd9D/gO?=
 =?us-ascii?Q?TqSY9aTEt4LN6KdHod0oMNVZezhw/C5bG6T0sX6WA3QFxmsXxRGFnqQghUmI?=
 =?us-ascii?Q?xutgvdK2cfW+Uux90cQgQ5Q3N2EtUVW8FB2rqzqpi6VaQT+W/rzhdBqMIz0P?=
 =?us-ascii?Q?4Qs2pgBi2RXR1Kwo/hqT9KEQWywQk4Xu5x87ku+Eyerf1UKtc4ytYatTBPd/?=
 =?us-ascii?Q?9R2UMr3GrBxUv86/xlzulGLAYNciB7pqMmkOvXZ6peBYzWXMXZ8OEfzRIcqq?=
 =?us-ascii?Q?3mdwAlm+r9P/HJJwkT8sIWOZl3rMaAGG0/CnXB/wqcniJ9zZJlnKqjqGfHYK?=
 =?us-ascii?Q?0maphakJQbYWP1Cbzo3bu22Zjo0EBuz/uu7RX/0uv20tYBp3yYIiXaf57aEc?=
 =?us-ascii?Q?Q5jpE+qscsla9uiPOiVdl9xQjl6zMrc2wMI4XlzcaUfgb2I3eSh6jolPK4pL?=
 =?us-ascii?Q?Iv2ReVwS3QCcBJnwfmeYR5a/d1CPO0z0F4hCYFO2+iKvd/6Oj0KxtycIfoh7?=
 =?us-ascii?Q?xcHOKpFmonkbgE4mizCVYEvpN9IOb7xDPHECUWqGZ56r6yl/Z1tl7RHyAaqs?=
 =?us-ascii?Q?flF32VpVXQoAtgsc01qnzU6t6mcJYMAV6srQDEjujjlCiWaAxyMTBXeKrlr8?=
 =?us-ascii?Q?xN4uonXBY+XktqL7StyXRQYWUYrw8Dp2r+ftiHcLsNZXn6GlZAIbUnvzp8F3?=
 =?us-ascii?Q?JAfgkbjJtoNe0gV9NWkBIZQsIES9hWA+mG227jvoTkwCqACyyZTGvhYOrn+u?=
 =?us-ascii?Q?evz7XEqmTKdpkurRM/9/l5vw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c5ea54-61f8-4843-649e-08d91c565ebb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 12:45:53.3622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAKUaVyQq57K/3HJPAk5DiKzWJkci3wRlhYhiXZlR/qc3gXDQLImab6DcwJH3FvtsEENkBvhcPGemp9WPIOPcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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

Add new BO subcalss that will be used by amdgpu vm code.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 32 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 10 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 745fcf3ea450..61b1edcb490a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -692,6 +692,38 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
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
