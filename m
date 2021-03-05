Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0BDC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4990565013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4990565013
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765936EB9B;
	Fri,  5 Mar 2021 15:06:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B1F6EB93
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNiVCXIKKiexOH4ksue2KKXDguXZzEc3HY0wxHmyYTuXpKj5ss+uV7rcyUlP8vcJwW8MNDMQeOBVQjpUZiSQIj/bcbX0EhC2PbHSAOLL/UgLZc/2bTmghChEB9XuAqzOhecRF8m63sFJiI0YxVuwO6fxazdxYUPsdhPOGhfTpM2TyxzO8Yj86DaH+fbZL3k0jxSAt5yOxYyPGbDk9XK7rj/Bs9H53gwmTk0MXRVxcEBO/0fO22yZRrapt/0mCGZXdRRqnUSWFh4YE2DB9Tp6CHSay79ZuTASXFUxjxrS3opNfm5mC1IrAM27gwpZKi0iafzkUBVp7P31C9VQV9cZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv4LQCcE3oIJf5+rcjJpgDMNYPixyNOuhXLi4fJovnE=;
 b=a0UsLHAbPYdxPZf2kx8iOtLlg+58Q8kXNQiC9ONBMPESIPVKmjwsTmUVRpz1DX7Gf4+XithCQzn3jCo7QKuUX4uiGkYWrFrFzBDdEQmBQjIFS+Pd79ITzisFyJppCbj9CEOHWN3h2PV4RxUFLg2v5wQiRgQzpJXeBAdLSbLMP2OUXAcnnFmeBDGdZhGze+5nqpHHnQStDRbm4zljdE7NvC0YXcybHk3XNw4OWhYfAI/CN+CUW+L12e3eWti2LKShyZKvT51mmoWtaZNTRmb6bm6Tfu4chP9r2PSLQJZlrwg69Y9/xn4uRnU0RGzXztZAgDrQwy81D91KVtmfskVK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv4LQCcE3oIJf5+rcjJpgDMNYPixyNOuhXLi4fJovnE=;
 b=J/dYCv+DWPG4ffudS3GKHuRaxGAae5L/tXUg4CVoa0h0txRLim+hPP1B6whTeFGy2Sd9sCWHfY+6yA8TSKsg4+10q4n8y13wPMCNkjSmIQKReNfYq3kLmmo4BK2PfKyEaaKHA+itNd/7yR1G8MWgiNM/k1zko4/lKRru428OkCA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1208.namprd12.prod.outlook.com (2603:10b6:903:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 15:06:31 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 15:06:31 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/5] drm/amdgpu: introduce struct amdgpu_bo_user
Date: Fri,  5 Mar 2021 16:06:14 +0100
Message-Id: <20210305150617.20144-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305150617.20144-1-nirmoy.das@amd.com>
References: <20210305150617.20144-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.77) by
 FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.14 via Frontend Transport; Fri, 5 Mar 2021 15:06:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19fa7a68-b19b-4380-be35-08d8dfe84255
X-MS-TrafficTypeDiagnostic: CY4PR12MB1208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB120838C70E17CADDA20C23108B969@CY4PR12MB1208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjHKO9k4oXXuFGRBUYAzrVp+T566XD77baOERSUIX8YsY6Qae2aMY2qA/SSCD7BywmPexF2qYMeIS8b/mo60msUEhUW5czhuXiSUnoZFmrZqpCs8Us625DMulmDPQx1DbgJeov5P0QQZRCijTccoE/7zow7thgPEHg2Zi1mNfoH3qix/ei8RjVMSGiabL9nd+NmrOTf5RssTGp/cMoludscrztwpokdhcz5ijYa9QQ1SkrHEEFI0Y9mMBmaUJfiC8KLgCDrmQdcCyPvvYCcar+/yRWlCUmaW3ZP1F4sy4dkuEc8l1Ux7LBpqYvEjVxBf3i3/c+h8ENqI6xsBoyB51rq3MUZO6wK662YGzOGIREJk6GHtOZPrw1heSS/y2ZIiKO41HbjO6oUeugbuqPjIBd68WaBysyqkssRxggVYIcITLBBcPQS9kbWP87lUBl4fhBOWipTZcolJuz3b2HZXtqkuwdzhPm94dg5rQ36amGF8tpU2uiLR9UOaMqsDuayUVIRgbiD81haV25bj6x+XBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(6486002)(5660300002)(6512007)(52116002)(6666004)(8676002)(1076003)(6636002)(37006003)(66946007)(316002)(66556008)(66476007)(478600001)(956004)(2616005)(186003)(36756003)(26005)(4326008)(83380400001)(44832011)(86362001)(2906002)(8936002)(6506007)(34206002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?//+I73rxpmubY/KaM318D0hd1R8q0SynNS/FyAB99CKWGES3gcmLhybfNZCu?=
 =?us-ascii?Q?7u2IXK9EmhsFEr+Kcyag+LTzusAxoBDr66EYguHw1bBWJcyMlNJAHOnDt+IC?=
 =?us-ascii?Q?przfbHt3RTnVuc7dieN4v7zBe5+l4Hd61q1yoVpi8yff4hnfhQ1qTVxi/rSE?=
 =?us-ascii?Q?zdJ5u6nByUkL+xQN4qzATjNT6sWCi28LSzXvoZi1G4vzusjQVTKvSvMlX9bL?=
 =?us-ascii?Q?DwcDW+o30mLWY0oS6sRs06iGOEMdvEja8+nD2uTdumnZ+y4/nsxi5rLCc4FF?=
 =?us-ascii?Q?JTt/E3Nux7nKlTbwBRMW0S+YwmcIbIiJtDpRwFEAI7lVlMEfkiYmW8Y66b6i?=
 =?us-ascii?Q?Rsu5makxwZhMq75naq7eP5N3h8f8A5ty7prZ6Bmo1Jz4F2yrS5Jiye4gKFYT?=
 =?us-ascii?Q?93o8WLIH1ILIZ48fUGXEKOTI22bxyRAkojMMDNIs7FL8HF+5AH1VaWE2FfFq?=
 =?us-ascii?Q?6xlfStBjZtf+knD7UAeOFMY55HDeXTl4KRjCd9J0KguyRglSaaX+rdM2qq6E?=
 =?us-ascii?Q?F/VgnQpb9pKk5QQhwc3PMMat83EsU6s+0kIpWkkkYwlJ2V++86wsjLmZCBMy?=
 =?us-ascii?Q?vhwuZUhG5f5/okn2MhpTDNPZLkvGohbeClzE2WN/NNz657H9rAMm7TH5oD+2?=
 =?us-ascii?Q?f8kSLOZU4mKGDBq/nkuR38DXLD7mCJ/fmUI3YS4JhplHOXex/NjS9/izCDYh?=
 =?us-ascii?Q?4guV5RtEs4dfMWHtaexnSGoWUjq5zPBmbgC2m8traK7jIAMum5qhsy9tcy5W?=
 =?us-ascii?Q?F9KT7bYIGhlD1jpN551rqz9G4XWNE1/qBVgjDY+8QHEEoIVEdyXCsJ0wJeAa?=
 =?us-ascii?Q?trZTKVtdP2mFcZs1lDwrzc/vQxXhWeDtpvfh6JIfytzPuvpI++spBlBLUKYO?=
 =?us-ascii?Q?dg6ZG7n3rygXErWdaDDTUravFs2yOhRw1nH5mcxIN2nZeMIupJnBVdXJUEN6?=
 =?us-ascii?Q?P3C2/EZIGAYl9UeNofpL+dKJb9dq1mcobfLZRfBDm9JLb69AupjJAnvulue5?=
 =?us-ascii?Q?PSzNjbhGUhMLLxd87EKObdN6gCeNTjLpWmI/MeBN/OCco5fJ+ry0li0w02Mf?=
 =?us-ascii?Q?cAPbmgcimqiIxdidgAnPgQygS5e4dGRVipPwvUXR8v6ABWZPREBr1rck7EgP?=
 =?us-ascii?Q?+6LnKTm2eY1s0kHt/BWR6ACkrGLdVh2Mx14yoexEAsJAgkCDa3uWh71IpkxG?=
 =?us-ascii?Q?gaXPGA+Pk9/xh/pqv0Ppo0DOWg0b12DufqzEOqjxWAQqVXYApTSli3NNotJM?=
 =?us-ascii?Q?lBZN0xAL/Syb2dAAffZDmRWrsgrvuhN7WyaDLiBOtDuPbRl5qp+nwXbLlvaU?=
 =?us-ascii?Q?mS0GCkjYormo1HAOEYsMk5f3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fa7a68-b19b-4380-be35-08d8dfe84255
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 15:06:31.2586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lLpIR3nm2jeVjDB47CBHzYtx1fMlwoU6vguz3JC0GhVHgsgt0PcEq4UEeZMPR5cO9sa60c1y1MUDfefrtczyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1208
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 12 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1ff8c3570c82..09d3394350a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -705,6 +705,34 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
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
+	*ubo_ptr = (struct amdgpu_bo_user *)bo_ptr;
+	return r;
+}
 /**
  * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
  * @bo: pointer to the buffer object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 848dc0a017dd..177ae825006c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -114,6 +114,15 @@ struct amdgpu_bo {
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
@@ -257,6 +266,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
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
