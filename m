Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C656C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 09:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEF564EDC
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 09:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEF564EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB52789FAC;
	Wed,  3 Mar 2021 09:26:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C0589F6F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 09:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk+EzgbPTZQoXOVWJa0/6gOVG3BbBwfZBovQO8l0yUxy2745HgU8uS2yBhvGX8eabx3csMcckfPDVp+MxlztkKF22QEG+bFXfnEoCc03KrWOtKGyz9uC62sq5ZPvgv8J9KZ5FdtJCSggsqaG90cc9pNPLOnjmNg0j6dp1NAjCVO8kYyxwJr5kvuABMW35k98LQPYIgptTNCvudGyG4eV5QX9mUk/viXVqQ/D+tCSsoxVgAdw+BUYXufTUPZ1Fvg+fYA3RjyIEUImhN0ddZijFjSLMfvOogNPMBthgAEs66WrhWjfKgLcj0cQoKs33O0evkvGkpy2f3BVueNgVKoGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzl42L/ia/TrqnjaADJE/0fRm97rCaqaIXOWnvCxAQg=;
 b=l2LK9rUFJN2CgimvvLPFpXlLIYDbLCXhgKZ+xqaj5bzNftOFlX8tH6+kAdyMwrW/jAYEITNLA+wgcKwNZyt1NRmRF8CwGsSF5sz7f7Nol5+5PruqiKCDqWClwvLXGXHY6vv/CZzln57T2ThbThg/6AI0Rtq2nH1VE4E08AQ05t4n+yFlBjigTk6H8mbQ66pjBfSQz3IGJ7ZYDIIIj5F758NTpUw8l8XkAkmt8MyklohRL7fI7ZqjRqhsxdB2ExzrjcdyqITpZUBJM1lU2UNOQry0dVBHu8YO49KUbyXBChYu/XSQgHymYNDogpv4NbPH8vUzxA4kQ3wEz4IJCncQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzl42L/ia/TrqnjaADJE/0fRm97rCaqaIXOWnvCxAQg=;
 b=p6VEEotd+ddV5oJq4hD1SMdCVl1y/uwMG2ygWTVfj9BfJnpMZc0bH1QDZy1Th0Okt61kpDukRCCYTstvd0G4/7KXkw79WV7OWmXbHedAR77ieCyy9XZhPIDlyCE+Pe5WSSv2WwEERY93q/uSnvBd7T4WosjfzVP8H0DqdmRZRfs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2468.namprd12.prod.outlook.com (2603:10b6:903:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 3 Mar
 2021 09:26:05 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 09:26:05 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com,
	Felix.Kuehling@amd.com
Subject: [PATCH v2 2/3] drm/amdgpu: introduce kfd user flag for amdgpu_bo
Date: Wed,  3 Mar 2021 10:25:49 +0100
Message-Id: <20210303092550.110816-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303092550.110816-1-nirmoy.das@amd.com>
References: <20210303092550.110816-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.59.224]
X-ClientProxiedBy: AM0PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:208:be::46) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.59.224) by
 AM0PR04CA0105.eurprd04.prod.outlook.com (2603:10a6:208:be::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 09:26:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae713272-ec7c-45ca-2982-08d8de265e7a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2468B3C5FDD9F1C6BAE192998B989@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhjBfnQQHRImP+TVtSi8NW7rhJvigMKA4nz2WLzFXy1Fsp4EtwpaacgPV/h6glv0RVxRDXLzHvdySdQBUB2Uh8/AHSRXZRTl/f2H61kNXsPrgc0kxSI1n6UYt/NXuuv82JSSF7jAjI7VJ/SmNlWtwKBT6nOL65iF/9Udtr+h9fNdFWVHz/TsLvvxIf4sPL0ZHstwAKOlYIwIaxQQDxh7TNwW/7vCMGnUoe4bfzWLpiL6vHDiG/ocE6P8Lne8zHQNK5yx+1h2M4FRG+OfQB97QN9VRZPWwnYFWM3/nTnGHIqHofNQySuiNuVcPddltYVjba9/1mYM3g5idH3PNtumuiPrJlUQizpzexixNntOgDOzXviO6TTm17lmedqq6Lf7ZH4/k173MFBodeACQqKVeeAZh3msLB4goxiP4qASIfp9ch+gonMlg6oVjHC/wEHMoW8UxC3AShXbhgpvNs9sAzE/6LKkhPj67Bmog8j1jJZKeR2nLp4p+E9UgClHAWIl5uCR34/JxyYlS0H6nCP+tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(376002)(136003)(52116002)(478600001)(5660300002)(66946007)(6666004)(36756003)(956004)(66476007)(316002)(8676002)(1076003)(6506007)(44832011)(66556008)(16526019)(86362001)(2906002)(26005)(186003)(6636002)(4326008)(6486002)(6512007)(83380400001)(8936002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L7ASsuJco2IpO0yXYnK6XFX4BdItgc5/QOYf2W1N5uUSwIT8CxAPsaxvpec5?=
 =?us-ascii?Q?VPL0+yVyP1OI7sIThL56+W3gPjm0WJF6j1jPPibg2V1BYVDsKOelpx3I5wsH?=
 =?us-ascii?Q?OLApOwAExjwaA5QXEeQOB6sm5LePYehTRLvBswkBY3CcNyIE4LN0XVDO8CE6?=
 =?us-ascii?Q?jXhSbfWeO/hjwMm++ZiOZ08Dtf0NQ7rtcv+fo4sGoLkbFqMKL4lgahW4GzdY?=
 =?us-ascii?Q?svojNamy7BzIzx/uf3iRiAU/B/T1rUfTGdOt4FsTSXwXi4kEw3BgbEXn9li9?=
 =?us-ascii?Q?P39YIsdl/OPE2+96pbh2sR8CxCkwvWRdGjNyB67Y4whrJiT1qXO79z9liSPH?=
 =?us-ascii?Q?kgwhkAiqfio9h64gi8MNoPmPaKD0PO2gR8zCEseVy/X9khHL7M1ErdT7raDO?=
 =?us-ascii?Q?hLwnWcuy/7up1mK13pYRTwKCr+lrMmoyK8snfkQhaQZ9monhOaXIkx17KVKZ?=
 =?us-ascii?Q?WS+N1wVeVej3y1vsAd1GSvYNNAEloWgeLfXBU/IVbtwwuGf/zKG+RKS9bG5Y?=
 =?us-ascii?Q?52l5x2977QybX1kLv2TEn6nxnrDEDg6za5OZLAcVo9G9pTMFyiCvXEtzMb2m?=
 =?us-ascii?Q?zlxRDq3ZWEaTzzOkZ7RXbihv+iWnNfYrVWXLoTAjN1+LZI4CcaLcKuGKSRjS?=
 =?us-ascii?Q?AxTdvzq1uMbS+SP8EYR4A3/ynaotAuYB9y7OLsqMq9n81t6XOgwGE96EXSGg?=
 =?us-ascii?Q?rH2mbndZjq0+KgwDjwHy5uiCMQRjeS3pge57vecH3JJfud+xd+MTNfGoXL4A?=
 =?us-ascii?Q?K7NzX6byaTF34ww4WuzcGT/WH5RQLByZ0AX2LustHyjsfN0Rr27B79bfHKsw?=
 =?us-ascii?Q?I2EOosGPV9grwT9tVuI8UH197rujtFkuAmrHwNVqn6VX7dTc+G+BJFJZJzgh?=
 =?us-ascii?Q?PmXTSaXnbJPqYdcvIm8Ka94T0TaNQRhYlyFuwJrPRTVPrYF4mvQEZoYvkNwj?=
 =?us-ascii?Q?jKI14W84QDuewuiE8L6jRtdCiPjRz5islOZPfF71MviNH8zeSsURMVlIXQKY?=
 =?us-ascii?Q?BssY0pcGtLcrobVeQwg7kLZ3IiA0IzyB77rUx0gC7P07VaBSVfeXjG6Nm3xr?=
 =?us-ascii?Q?EwPblf2rbsSkwLB1U2ex4JHJfJB1oyGew3M2j46X/NnLGeQmo1sNHbUfFmZ9?=
 =?us-ascii?Q?BlkzyLWNxAjWX17WGQpZL3T5pBvhKxDhxFHtJ5KVtiTGGLXkLodmZOx3NTK/?=
 =?us-ascii?Q?YRaXsdGQ9wqYDfv1DHGQMPUJ+qHUzVtDkCkRxQYF6IUUXOPXLMojdD9PNDEz?=
 =?us-ascii?Q?Wo0PYY9chZ896JRqmifHk8TSC8NOX9yc/V8Gne7ZggbuYhxhmJosr2w05rWW?=
 =?us-ascii?Q?h2mCsZPKBI5uU1jkaUlIrUmD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae713272-ec7c-45ca-2982-08d8de265e7a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 09:26:04.9992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gk3VEcQzIv/iifSyAiqSbZOkI8bMXYlOeZB1q35cZ3i935LG4rfeginjEVKxnT3F4kzJ502rum2lvkszkKlBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
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

v2: rename AMDGPU_GEM_USER_KFD -> AMDGPU_GEM_CREATE_KFD

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
index 8e9b8a6e6ef0..e0ceeb32642c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -234,7 +234,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
 		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
 		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
-		      AMDGPU_GEM_CREATE_ENCRYPTED))
+		      AMDGPU_GEM_CREATE_ENCRYPTED |
+		      AMDGPU_GEM_CREATE_KFD))

 		return -EINVAL;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 0bd22ed1dacf..1b41b4870c99 100644
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
+	bp->flags = bp->flags | AMDGPU_GEM_CREATE_KFD;
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
+	if (abo->flags & AMDGPU_GEM_CREATE_KFD)
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
index 7b2db779f313..030bec382f54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -164,7 +164,7 @@ static int amdgpu_verify_access(struct ttm_buffer_object *bo, struct file *filp)
 	 * Don't verify access for KFD BOs. They don't have a GEM
 	 * object associated with them.
 	 */
-	if (abo->kfd_bo)
+	if (abo->flags & AMDGPU_GEM_CREATE_KFD)
 		return 0;

 	if (amdgpu_ttm_tt_get_usermm(bo->ttm))
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8b832f7458f2..f510e8302228 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -142,6 +142,11 @@ extern "C" {
  */
 #define AMDGPU_GEM_CREATE_ENCRYPTED		(1 << 10)

+/* Flag that the allocating BO's user is KFD. It should never be used by
+ * user space applications
+ */
+#define AMDGPU_GEM_CREATE_KFD			(1 << 20)
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
