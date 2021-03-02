Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BD4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 11:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA72601FA
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 11:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA72601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5026E095;
	Tue,  2 Mar 2021 11:34:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A064A6E095
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 11:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHRYVZbD2Pn3GOuXPFSRGEx5JVbxbWcH/98m0ZAYP9Yxyst2RNN7BjJv5+LtB7RCyQbXKubsKueSKvcfwkWJozdnF8FmT1igIy/JavL76Og1gkykvBWPf826gXylysJwSUEaqsrkspMYztwPO7RJb+tvWWs9WZuSWBwMTvLpRtb89GPPZPlmi42uqYqKD80scYdF+cKvBprydj50toIdEmf3YyWjk1Xtj3nwWSGR9MdppB2+S1YU08jsU9mqybyvLaOgzqEHAIXuFMg9G+Qq+d3eekaqjnKmbETUFbVEKVP9IV5LC5Z4/VCI0Ax2r/ssBm7EdrdsJWBgo8x2IW/q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQzs2nCXojkFzqSEa5Jn5YigQVTD+Squu+3RnNRwJqk=;
 b=QAW0Q2ZwY/mQPoHsxOxq5x3YB1Lr0EF3z7vyhZKf6UqcnkAJ7vt6mjtDY70pvdl7iUYI/DwyhaRASXBFeX4ub8FgbJnCGtZlWLl7dOHhSsKVsQS5bHJj64w4E1wYhdPojYEXnl2+JcsUjxpJoQCyJ8zGg3+LgvxqvQGkzdnHmphIbbRQ1+tVITpeVxcay8aLs2BSmI1/3QCSw7aegwSX8IKljE69JnWzGeRPXaugrmZgZ0dmhhzWbbsJVXGW46UiwnnkDWXkGRj7Mo4bkHx5+kRIzJt2EUnUR/cCwcpQOG6i32K5SgBt+TMtQYF9bDkLQGFvNq+ksdNL/eYSN8KEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQzs2nCXojkFzqSEa5Jn5YigQVTD+Squu+3RnNRwJqk=;
 b=ocoXo3wMGhRgOi/Zm6EqFJh8OO0rJ1bVaCmVMuj/QVll1jzRXr0v7UccnFYkysuYzjmjH6C9dVQwP/azbbVm1V/V3+o+v2NvGbJfoUnqygbFlugjtuOgkWJa3ZB3H1JtxKamqTqu6/rZky1NXIrqet6iVdKhYWaNiFlo+kASpiM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 11:34:03 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 11:34:03 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com,
	Felix.Kuehling@amd.com
Subject: [PATCH 2/3] drm/amdgpu: introduce kfd user flag for amdgpu_bo
Date: Tue,  2 Mar 2021 12:33:40 +0100
Message-Id: <20210302113341.74813-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302113341.74813-1-nirmoy.das@amd.com>
References: <20210302113341.74813-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.44.238]
X-ClientProxiedBy: AM0PR04CA0118.eurprd04.prod.outlook.com
 (2603:10a6:208:55::23) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.44.238) by
 AM0PR04CA0118.eurprd04.prod.outlook.com (2603:10a6:208:55::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 2 Mar 2021 11:34:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bdec691-65b7-4bae-c328-08d8dd6f1474
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB138103BCF24E47FED6C361B78B999@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7aVHWklkLTPlbmdh+oqImIo55FBDv8XRbAGjbdYWQVlC0bHc3PIEU8N/JZlNuBEFrqrySBMeKj9cpCEDgHvZK3oGvFf9jZOionfigH02cdZsbkaDIcGrCp41QRk407PAd6wXyHXLFjM+KgMe7BLHoHEOtr3r76eBD0/2b9Wnd6Mpk5aOB3Td3zPKuBTOkw3XjVoMvFZBTOk0+4U3R9Bjz+U73Cnau5Ram2FHsQp39fOoO/Ho2S0m34bYGpNez6Ujw1hO+3De4GO1i6ZGVbQRggyKXtNMZGHwikDhOKDrn2I9u2fgS3t7pOWHMTb/BgfK9s8rhziHN1WHd9aKN1b06qx6RF9HP1Nh3H2S8SuiZ32VafiZIUjIpGyuJ32kFUUzIjAKyxeOpc5+O5bW+SxJwkUYcyF/czfjGUA/W/+31kU3/9SSw5gKUtzedk6NQ6anBfRyrWYiOHWi/V1owGGCj6Nzj5DiUE6moZ5QKwVMxpBpyA6d/5MntODPeFJVCz2xItb3VUQ9dNbJQZgtpu3YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(478600001)(8676002)(8936002)(1076003)(44832011)(5660300002)(36756003)(66556008)(316002)(6512007)(86362001)(66476007)(66946007)(83380400001)(4326008)(6506007)(52116002)(186003)(16526019)(26005)(2906002)(6666004)(6636002)(956004)(6486002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xYxtLMRqT/1j++K0B/2avFMBAdsO3G0ZKahfiGrBm4Hw8IM58FiJU9ev53cW?=
 =?us-ascii?Q?dfUe9mTuKRAIFpH0sSpKOEnEXgxz1UQBMBq5AErEkShYCsbzxpmj9rjr1V/P?=
 =?us-ascii?Q?Vyjo6F/af0LVErEfdsPH3n/s9fBqYwmNjg6tD9FgYv+2oj83R/vF6jBlzWe8?=
 =?us-ascii?Q?clV1JGTQBnxjq5ADrqWGwMszoFRYgBjZ1Nd9yBpEALpyl6BH32YBBhlLJQT0?=
 =?us-ascii?Q?AcophoeOk4hvVr2CC+8tlz7cY99zu7qiB4YOqdgPB68D2kP91LA6Tc1pfJW7?=
 =?us-ascii?Q?hoKi6qDj+oOhhLxj77MBZDYbCrQxTLU1rvzK1GHV+NutPyvr99kXuoXrLtAU?=
 =?us-ascii?Q?7Iv5Qz1uHYf0wIVfZjU7mu4m1/HNpwHy+aJ+ZlrYPQtRYjWvgZy1p9PqSSCQ?=
 =?us-ascii?Q?osm6s3TVmCO+D1IP1/A7TPmngn7h3y1GwqGGW6fF5Y3p6ZQt8pVynP/GEOFQ?=
 =?us-ascii?Q?zDRdEHzOlNERiornE6wUAebHitq7dTwsGEXjgpbaoC4XbI+n/vvIiuzApW2U?=
 =?us-ascii?Q?o1a8njy2Pww61I63p0mxRT8EMg86mxXg15fgLnFxZ9KAJJqjhO95rf6VYu+c?=
 =?us-ascii?Q?423aELppZYhNKzEhMLQQs5LGeISLPoLse7K7PDLz1Cne5Ewb9vKPYZ0vNh6R?=
 =?us-ascii?Q?lfcMnBHDzDWbk6BkypV9Eqi+uxOdK6jfDLCbIua+0+FUIYwgZKFKbPY003zU?=
 =?us-ascii?Q?Pc5yfn4O7WMAR7LcGRNfV6foSUhmnQbQZ2Y4B9kicNhE2wI3iFLyZj3e1wOL?=
 =?us-ascii?Q?Eiw66FBMTUErwylrxxhf5wo+MX7sTgU/rz7uw51fa3Lr0W/y9S8om46Y0b+I?=
 =?us-ascii?Q?UE6zld7nNW1xxT64ztwbNBpK9bqmwL8FBzJ1Nu3U98lWRBuglQCi7SWeOsg3?=
 =?us-ascii?Q?vqlEZyUtLWgSuwyf8DjlAi/B8bO7GrDi+mX/jyf7X0yd+zmuIs4eAbUNetA1?=
 =?us-ascii?Q?NS1+MRmPReiyqdMBf8tpDRW5ThFX1xFnCMNHlMBxqmJER2AkhuUqEMDxjQKf?=
 =?us-ascii?Q?sw9aiZz0xK9kXIz6M4q7KeV06G4Qhiw0Fc7xjADBUQn7MhBMRvd4dcwSQbr+?=
 =?us-ascii?Q?0N8pSPmi9ARvfFASn7NIf3eFfz4oqJVbxI00kzZqclP2ALoWK4IqIWEo3DdC?=
 =?us-ascii?Q?qxPXDJy5GmnxezqruDs80M/qNlOriuI6XwVc+eN+yYu7kVcfljIwH4cCot/t?=
 =?us-ascii?Q?ET/Gha4n55w+Y2XK2GZPwz2GLpwLFYwjOMQm5/i+lC5Jh0VVcGaAVDTv4EC7?=
 =?us-ascii?Q?B7pUP9+wW/yXjmpmAkDXFzRYElNyJ9jWiIxyEv+ymdHySTT5oqUjyLlbrtme?=
 =?us-ascii?Q?u7cj/S8LV3cHmCb/a/l1BaEY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdec691-65b7-4bae-c328-08d8dd6f1474
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 11:34:03.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+S+DdsPC9zyQMae7ReGbapWzWjK43TzwTJiR0DG4XdGT/b7buxSk4NpmPfro6iGuZSPe0SSCSde1DF7zesgag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
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

Introduce a new flag for amdgpu_bo->flags to identify if
a BO is created by KFD.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 48 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  2 +-
 include/uapi/drm/amdgpu_drm.h                 |  5 ++
 6 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 89d0e4f7c6a8..57798707cd5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1227,7 +1227,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	bp.flags = alloc_flags;
 	bp.type = bo_type;
 	bp.resv = NULL;
-	ret = amdgpu_bo_create(adev, &bp, &bo);
+	ret = amdgpu_kfd_bo_create(adev, &bp, &bo);
 	if (ret) {
 		pr_debug("Failed to create BO on domain %s. ret %d\n",
 				domain_string(alloc_domain), ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8e9b8a6e6ef0..97d19f6b572d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -234,7 +234,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
 		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
 		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
-		      AMDGPU_GEM_CREATE_ENCRYPTED))
+		      AMDGPU_GEM_CREATE_ENCRYPTED |
+		      AMDGPU_GEM_USER_KFD))
 
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 0bd22ed1dacf..5ebce6d6784a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -697,6 +697,52 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_kfd_bo_create - create an &amdgpu_bo buffer object with kfd user flag
+ * @adev: amdgpu device object
+ * @bp: parameters to be used for the buffer object
+ * @bo_ptr: pointer to the buffer object pointer
+ *
+ * Creates an &amdgpu_bo buffer object; and if requested, also creates a
+ * shadow object.
+ * Shadow object is used to backup the original buffer object, and is always
+ * in GTT.
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+
+int amdgpu_kfd_bo_create(struct amdgpu_device *adev,
+			 struct amdgpu_bo_param *bp,
+			 struct amdgpu_bo **bo_ptr)
+{
+	u64 flags = bp->flags;
+	int r;
+
+	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
+	bp->flags = bp->flags | AMDGPU_GEM_USER_KFD;
+	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
+	if (r)
+		return r;
+
+	if ((flags & AMDGPU_GEM_CREATE_SHADOW) && !(adev->flags & AMD_IS_APU)) {
+		if (!bp->resv)
+			WARN_ON(dma_resv_lock((*bo_ptr)->tbo.base.resv,
+							NULL));
+
+		r = amdgpu_bo_create_shadow(adev, bp->size, *bo_ptr);
+
+		if (!bp->resv)
+			dma_resv_unlock((*bo_ptr)->tbo.base.resv);
+
+		if (r)
+			amdgpu_bo_unref(bo_ptr);
+	}
+
+	return r;
+}
+
+
 /**
  * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
  * @bo: pointer to the buffer object
@@ -1309,7 +1355,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 
 	abo = ttm_to_amdgpu_bo(bo);
 
-	if (abo->kfd_bo)
+	if (abo->flags & AMDGPU_GEM_USER_KFD)
 		amdgpu_amdkfd_unreserve_memory_limit(abo);
 
 	/* We only remove the fence if the resv has individualized. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8cd96c9330dd..665ee0015f06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -245,6 +245,9 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
 int amdgpu_bo_create(struct amdgpu_device *adev,
 		     struct amdgpu_bo_param *bp,
 		     struct amdgpu_bo **bo_ptr);
+int amdgpu_kfd_bo_create(struct amdgpu_device *adev,
+			 struct amdgpu_bo_param *bp,
+			 struct amdgpu_bo **bo_ptr);
 int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 			      unsigned long size, int align,
 			      u32 domain, struct amdgpu_bo **bo_ptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7b2db779f313..d36b1932db78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -164,7 +164,7 @@ static int amdgpu_verify_access(struct ttm_buffer_object *bo, struct file *filp)
 	 * Don't verify access for KFD BOs. They don't have a GEM
 	 * object associated with them.
 	 */
-	if (abo->kfd_bo)
+	if (abo->flags & AMDGPU_GEM_USER_KFD)
 		return 0;
 
 	if (amdgpu_ttm_tt_get_usermm(bo->ttm))
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8b832f7458f2..f7157bd8a1f0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -142,6 +142,11 @@ extern "C" {
  */
 #define AMDGPU_GEM_CREATE_ENCRYPTED		(1 << 10)
 
+/* Flag that the allocating BO's user is KFD. It should never be used by
+ * user space applications
+ */
+#define AMDGPU_GEM_USER_KFD			(1 << 20)
+
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
 	__u64 bo_size;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
