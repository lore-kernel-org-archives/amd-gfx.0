Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3813C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCE765011
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCE765011
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EB76EB93;
	Fri,  5 Mar 2021 15:06:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FBE6EB93
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DusP8uoHeKkhn1L8m09G9fPgNg/fUts3suUQUhFHLVFtlTVbzgu4I1QQXSEA0Yb6NLPHe5SC5yVRFDuS7eIL660PP4jcKpPDck3L0F6AHlcLlGIrlSq1yLK/sAPFV66BqRwTLubKXcA9UM/JyMN1oe29FVM6xTqglVChJEwSBgHuXEVuY8oL8O9HysBZDm1r0rMkRjUmClfEhTraVp59yikglzt0FjmKLxemr4ZNEjPSLgmo0kBZKRyWwDLZwFL8lZLzfE6uBbsPJYESyEF1dMmaVNBXP/4gFoMWpqdrc4G2AzgDG08/YwAuaKWqLY4D+3Nkd/I/nLUgH0AOVb6OTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/atjwUxIwm7UGLpS2vIWIh7rStH2BeGtMsGVX395fAg=;
 b=PQ2+5AEsDxi9PCSi1AhfjoAdBLn1bOpUORpuA6M8hMvA11kmqwCdCzcn1EwcHc5vz0dF6MMceToXRG20Rc9MOuQDJgQVbSYxJDPvDAjv8E7DZdBQXMun8nEhWGFRFkcFeYq6yMD6pPUFQmQvTuRwfnlB7u8f6oGjBAMxn4OoeAF/zr+lLy461fROA4PvoWMORAjrCnN6MXY+dvk3+rybNoA51vnxoTvQENSLkOqd/VJTJpbipXIjji9WbxWvNssJxKGg0Qx59bm/XcNOKPQGyw255NEY7cYC6mFYTjdAalR2TXsPW2pf1xRJs6nG+dDcYbnH6dVngVfYYaqJuSHTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/atjwUxIwm7UGLpS2vIWIh7rStH2BeGtMsGVX395fAg=;
 b=jp71vM3CqRK/7yZPoF8ZDLDMIR1skys8OY53ybT5iXMHX4/zX0LzOWmI3sgSixoOx8pSbhvv0y/qIKSA00i9ccQpGaCMs0A6x3UbsDsLxBcUhiOx1PMoO+PezzitcX4oEhYm1Au0DH0NAdUP1tHjxWRaw7lC6+ZTQcjEKNg/ftk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1208.namprd12.prod.outlook.com (2603:10b6:903:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 15:06:30 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 15:06:30 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/5] drm/amdgpu: allow variable BO struct creation
Date: Fri,  5 Mar 2021 16:06:13 +0100
Message-Id: <20210305150617.20144-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.77) by
 FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.14 via Frontend Transport; Fri, 5 Mar 2021 15:06:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d10f5781-8334-4193-da8e-08d8dfe84185
X-MS-TrafficTypeDiagnostic: CY4PR12MB1208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1208FEA6195E84977A9789E18B969@CY4PR12MB1208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igCRIyd272FW2DQF9RGX+u0mNRmjpwptd7bAmlYI4xbJC4cEkxdJ7dc9SkcLrg3QXN4MWKXQkHGUa6gx5oerL1rebGqZgamMkCFJ+F8v4pVQLAcfygXhgBAaf62qIYUqwJCLb6fcqhIQG9kC2nMWoy3y5g48rHZvfvPKAEBifwp54LyVOY2BNDj0u5OymXhpzWjBv8cXfBVPXGM5J/+b9eqwvmAUrvBjf2hl3eAPT7wBXqKbdYU6F8Gn+aGPABMYMFbeVGkGqV3Es6sepuySbWpxwOJ7nASzZZKgsCxoCRE3LRR7Q3b6o+mfa2Uu5qfwiq54LnKLLaQJ5Jz4PxfLJEZvRy100jcKqKTwwc/CUSeZHzVOj7sPLyW+XU5RC0cju3gqNt/gy4kjMB2Cnyu6vTGxfBdEOwsEl6JBHw+t2/z+zBcgosuoZ4teVc84qIHPqfsLV85eGbcGnzz3zd+SpafGjPxU0fJVBRyYTALGhXiDWRoN0LWxxxdoJwHDVIP1712SVNsRIV/pWj07R3tgww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(6486002)(5660300002)(6512007)(52116002)(6666004)(8676002)(1076003)(6636002)(37006003)(66946007)(316002)(66556008)(66476007)(478600001)(956004)(2616005)(186003)(36756003)(26005)(4326008)(83380400001)(44832011)(86362001)(2906002)(8936002)(6506007)(34206002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2XAefLgsqTs7kw65NlA+TUWVXFObc/7h3TLNKkh9zEjLJhzlWYDcgiEc+9S6?=
 =?us-ascii?Q?JSwGPaNhpCR6fTLtnKPPSDVddr1ghvH3du0I21pHoSUR+1ZN30nNtf7IKkmO?=
 =?us-ascii?Q?kYTucQ9GBYyuXhDrkjY29VGUBeCZhb4YmtDdAQ7mBo63yaGcXRv+AufVZdsg?=
 =?us-ascii?Q?BH3+udEqDXF2j/3EHuphrcj/1z/k0Urw2Nr2IQ5VtblpJXsVDnM+i90fUl9F?=
 =?us-ascii?Q?1t0cRGqfznZf5KuRSHWJmUrQ+qDJgh4vxQp3HjCgCeFEyhKJLlIDRvNOMW+8?=
 =?us-ascii?Q?lzO6BVUJD3PPDS9N/NVWSicpaKgNXuNEvPkbXeDxnN8/coi5hH3u/tzWbRdI?=
 =?us-ascii?Q?YAMEIgrgWyziiK+YGfw5Ig23ZWdMoeb9vLW01dDYiWdepmsl+3csESH/SyTl?=
 =?us-ascii?Q?LEUmDq5+68KLv7j1nOLDNarS+t28k3CGVWN8gDvnbNf6gVlyvkWblOIVS3c8?=
 =?us-ascii?Q?BUaUudxFuAElwSc4hBOFUUBj0VASm7C3nmDj2VkhQuDNacsQdynMP1evsyRY?=
 =?us-ascii?Q?5mR2S9T/VkHpRPyjnjjOsqyqddT1HPEfmsw1QV1bq3A3RPbaMqRQZ9+J3Y7s?=
 =?us-ascii?Q?Zbw6JrDGias7X0oqQNRzYFDjWWGpwu4MnamYJ4XYzQEhRIMweF6l8Q8Pa5Vt?=
 =?us-ascii?Q?JkptGbPx78ajmTiZZw6u3vy5AVppmneW7+lyBWNsqOLgljuql2ZKULl4NS7n?=
 =?us-ascii?Q?iXDOPH13afYpC6sAlLUS45zEwxWXIrGU6UJwhdNgqYCxMlzZLn7poMbHOOHc?=
 =?us-ascii?Q?ysVQdeBb7xKBaSAYn5D9dknt9sEU/4jVWmVOP0O4iJXeo3rqJzb3MNxmyuKg?=
 =?us-ascii?Q?ki9/2ar1F7fOykhbbR7RJcn/lZSbxoLkrK2yOEdo1SXLT9emi+zomZayYx1j?=
 =?us-ascii?Q?7icfanXpSIFqm9bmdf5E/Srg+cIEMjTUCqhrlveqVmIW6liCF0kTcphMcvTQ?=
 =?us-ascii?Q?3jG0w/6SWXVcDttnTBSJMlxXUc4SsSw+joKNHzXh2H9I+kpy9bs4hfBGSigA?=
 =?us-ascii?Q?CpuszcBBmKRrA8IYw+z/RDvNSf+6+rZoENoyW031sBbfHKuC1oHJC/VIhIHX?=
 =?us-ascii?Q?bc2q8DR1n4dij3Jp2pHcRNfhUUpfehh1i5u7Nf77SZdlW49zbLJLdsrzrDs4?=
 =?us-ascii?Q?BSTuqyD5eqkfB9d5NeELqQmJuR7hEscX9LN259s6jJU2cDuS0/33bDgxqiv+?=
 =?us-ascii?Q?TsrnuEl1egValgDHnRlnGlUy/w2ep5iCsuS08iTJZcGBONkZKMnB3GnIivzD?=
 =?us-ascii?Q?2mE2juJj22EDT5UwIiq2SnzAogjw/5oY8ATTUdnqkqEfOGXyDEeZQDCpIYXR?=
 =?us-ascii?Q?v2f9bf/gJ6fDsU6TXYLZ7LJi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10f5781-8334-4193-da8e-08d8dfe84185
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 15:06:29.9212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkpD3X2BJ6vUDSkqbMkLwHR5Qmx+3P2HgMtpRBA0524zYxSk9zfaVy5KCqO86qRJ0rxkNZ9oKBl6z7KxfAIk3w==
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

Allow allocating BO structures with different structure size
than struct amdgpu_bo.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 0bd22ed1dacf..1ff8c3570c82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -551,8 +551,12 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 
 	acc_size = ttm_bo_dma_acc_size(&adev->mman.bdev, size,
 				       sizeof(struct amdgpu_bo));
+	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo)) {
+		DRM_ERROR("can't create BO with size < struct amdgpu_bo\n");
+		return -EINVAL;
+	}
 
-	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
+	bo = kzalloc(bp->bo_ptr_size, GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
@@ -642,6 +646,7 @@ static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 		AMDGPU_GEM_CREATE_SHADOW;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 
 	r = amdgpu_bo_do_create(adev, &bp, &bo->shadow);
 	if (!r) {
@@ -676,6 +681,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	int r;
 
 	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
+	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo))
+		bp->bo_ptr_size = sizeof(struct amdgpu_bo);
+
 	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8cd96c9330dd..848dc0a017dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -40,6 +40,7 @@
 struct amdgpu_bo_param {
 	unsigned long			size;
 	int				byte_align;
+	u32				bo_ptr_size;
 	u32				domain;
 	u32				preferred_domain;
 	u64				flags;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
