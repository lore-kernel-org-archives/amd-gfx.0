Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A11BC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC2361163
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC2361163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBADF6EB78;
	Fri, 23 Apr 2021 11:18:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CB96EB76
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 11:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEjfAFpPTfitqU98iW9GFW8e8H1OdqviktjP/qxl4UpKoa3SdbXgj8kE+YQt/XyhOILEHDj4Pp7HMaq0vj/3ueYh+DKTNXaPjWRXtVwka6mfvbVFN+JdcA+IdPvUe9Kbb+6/9LdgN1z0ybPodVVKJP+1F94RoCQJ30bAlXJj3c8uk4A157IJu2BuUkNXQ28oYERBF62TaXRUXKnY86Xs/Vw+bxju7IJbNsqG14bhZPetZ09yVQT6PPPDExOKNh0LlsUz/YgHpGTj7CQ7cHlhg10xMENbG/nyXkA3Tnjy8Y6mfumADVUAtbBz21fKCpEi83y2J2zYv6YGLOuOa6qntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q67wBTdE3f0ExvImAQV6I++CBskvuxVqGyhaJjKJyXs=;
 b=CoeHrlVpGfEHYMt8I5rwXSGzVOBk5F/NVBhXVD6bCyruudqmzADGC1z7ptGD3sZyxzQEMa2Fd2wPRnlTGuF1oyeGmhSxn7qvLDhTR8Ll/NOuk3XyFgwIhE+UBb12N9MEVMeoceUe5Eu5zraZzOtvTN9Oc9oIDJ4TUDMU/OehB2NjXnKt3456ymtkPBAvxhmtP3Z0kRXzvMBOgehT2FlWQC/WvO85XX1sOgkgT7gxQZgtmXA/MzmKefH11YnUE3N7PvisEj62T84OcwcGHj0ZK+5jiVnlt/3GAoNqLEE6nNftL6ORNiPLtsrqorviA+W3qGwAacuwlGix1Y7ArRJbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q67wBTdE3f0ExvImAQV6I++CBskvuxVqGyhaJjKJyXs=;
 b=ZhQpOkJu3nfMnDgtsPZGcKtKPP3ohs422ncCS+E2UsSXDFBxjMObeZr1xSzHaMY7aoLZC3nCUErQXqtZhsEiEpT/sO2j/d/ssR4cAlj0OOkifeENnHgvWhlV3yaibOk9etr9gJf20M64deOvZrdzVWtfDAPlTjbU20QJntFqMhc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 11:18:05 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 11:18:05 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 5/6] drm/amdgpu: cleanup amdgpu_bo_create()
Date: Fri, 23 Apr 2021 13:17:29 +0200
Message-Id: <20210423111730.2345-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423111730.2345-1-nirmoy.das@amd.com>
References: <20210423111730.2345-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.34.71]
X-ClientProxiedBy: PR3P189CA0049.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (93.229.34.71) by
 PR3P189CA0049.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 11:18:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56df2837-729a-4887-35c6-08d90649776e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1462835E9D7DB61FD7C1952D8B459@CY4PR12MB1462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 745IkORjIffG3Bo1K8at9Gtn5gV1dPeSiuUYeWNVWWOWfBYoCBjUSHD0jak/zmom12KfLPsbok4kdKYEfTzFNg/gDXgyeYoTBkqaWyMl4Q7xVkU5ilPA6yJ6W6V30c6PzE8LZRJesutCdxb6vTb1X2otbgHhSBcvcnhyQCxFU1ofx1Pscd3asOjtaCcLKNxThd9cF3AbVPDc250mU5UvHmJAEmtIrwLxKJspUiDZWXdF2LPdbf1iLBUmGKzsJST/F2zsi+YhOfIGN9/x/tPjuYrnvnW75uyW89mLRKWg2GwUdaT60hgHh/DMbOJTZmp+8/gEMEY0LWwB4UXlZ3tvWjM9N50oa0Us/YN8Mgg36V+OUYnMPiUp87ne8X9uNRULoGVLbUZJVA3jfKS469RtK+WA9BNJTUHUUlRriAba1+mxx0k07rTQmr60IERFWHJD3Gut3tdJZyYsV5/T+DSf5t19kJzZFI6/cZjGPFw/BM17AesVixkO2vISwooMkt6srpPlXHAWbr0BUPbZfNzvPYivW7netvLG2Tha2cssnbdSNkEx0CDkZFUcMecbYouf+QIuzS1trtUbvhre8XjqKicYdYawY/tsMG+gxXpGBgRf+VZv1EzYJfkmHpbyQqN2OLLa44TXT8WHYOqMwe9zk4SFe3T0msFnKZcG/ZBcAlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(478600001)(52116002)(38100700002)(16526019)(316002)(37006003)(38350700002)(186003)(6512007)(26005)(6486002)(86362001)(8936002)(6506007)(6666004)(1076003)(8676002)(4326008)(2906002)(6636002)(5660300002)(956004)(66946007)(2616005)(36756003)(83380400001)(44832011)(34206002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8pOf+LxZFWJBT4l+GCwRntQapc6X/tVkaWbxvDv3AAtt2lLFPdEzw8muBmm8?=
 =?us-ascii?Q?X3LwOVlTwhmSCkCoBqn9UaLVv9fE5J+0H3GVhktNYCMd4Z4zAt1rj3r/f316?=
 =?us-ascii?Q?lPKT2f9BuDROaNiMWGwcltBcCZmgmTg40LF4GUHU/5upLrN3rf/aVSPY9WxN?=
 =?us-ascii?Q?+lEzF03l0dxRazIb/7aTAz7pnflU+tZbhcdispijIGkBb2bzsIouDXeqblQF?=
 =?us-ascii?Q?xH9SDgEdS8VDq74k7vyVXPMnZ9u7zjtHpMapnMrs5dxhn/Gw1Emg4SLkt0uJ?=
 =?us-ascii?Q?XCgG1aix+LAyqWBVmUS5fZ2ntVWNmm9rtSh7jZ3+Hp7CfgXKkRH2l/mSlix4?=
 =?us-ascii?Q?gG4U/xiAsn53PkDAq0nwI56Efa6NXtm7M+rO5kGKfqcnfWAG+t2EnszWq2FR?=
 =?us-ascii?Q?G/2jY+0q8AnQzgB+yF9khSSL3ulNqHn5p2tHlxrlLZt8Rs/8eWvkUIGPc3va?=
 =?us-ascii?Q?pUp7VftK1l83j2H8xN3KkPyil5eKEieEMXkomfM3FsP12CigrY7lQpc5oPbA?=
 =?us-ascii?Q?EaQ+XF+Kl0s37/Md/vKmpsSlx3NAptCEY0wbd36dnz/X9xYrid3gYe7ZVNfQ?=
 =?us-ascii?Q?F3b2tUezZOQ6Zf+mp0FrvzqKe/dqxpNQWHxXoZZd9n2SF3NQcXDEGzw/AfAb?=
 =?us-ascii?Q?Tb0cTGgb1iqM3JK2QbNnNgj/tGAk3Ncu+6HTA0mivyC368nTF7yw/LsWXtmI?=
 =?us-ascii?Q?6jDjqjF1YVePwOwy0o8tfem8kPRpBZGnY/x9iRI2w7D18MujmzgVt6pOHZ+o?=
 =?us-ascii?Q?pHy3O4uT9WWUN3HQoariF8WFaoQbkXeVV6QmIoiVTSewUojK+XLtX3ZPo1uJ?=
 =?us-ascii?Q?Z6D3tROrhOA3E384OWUo1w0bnLKXgi2hScRE3ex+dFsLO6i+5K9K4PRfzRSG?=
 =?us-ascii?Q?mm0y8QTcIzr+nisSVRn6s46MHc1Y3hSzymGIDaF835sYmTjfcNQcHK5ToYoV?=
 =?us-ascii?Q?J56eGMNOlGn9YVtJ7b5DAVHBoxEYDjgSIoEsMaYUL1o7QvSKnxeCkLvzfoFG?=
 =?us-ascii?Q?zGWj4JnanMns4OESO+01ztNVzs8Ln/4QwbSuS1EAOO79CCtz7qCzg0DwMbi7?=
 =?us-ascii?Q?C5gyGgKkFxUyEtSJu/XZzP1GY/MhkTWP6Th+s5wdBptpFzWcC5WEMRDJ4lwb?=
 =?us-ascii?Q?em/jvUjik55LbTIf1BihHuHKlitC4kR6odBKgpGMMw0jifoWsBXvSeraFasV?=
 =?us-ascii?Q?VzwqXdhTp7IsOAfX4SoeLo39TdHNVSwnERcQRYhTJbwgD1DjYSEv/Pxz7O24?=
 =?us-ascii?Q?PtHD7JrWQjKdcjGT9LyIwGgaWsLPM+YYnnV5dO7m8mqGJ2adRoXOTLAVO18h?=
 =?us-ascii?Q?iZrg5B30lI1Gp1wPeqM0pDyT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56df2837-729a-4887-35c6-08d90649776e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:18:05.7195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXg/xUsQ8vETlZ6f8CzXYqZaSM+onch7Yp6TYH8zsnlG2UxekafUNPhaTiiazJ9EMfh5MaACRV9tAqzmzXU+0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove shadow bo related code as vm code is creating shadow bo
using proper API. Without shadow bo code, amdgpu_bo_create() is basically
a wrapper around amdgpu_bo_do_create(). So rename amdgpu_bo_do_create()
to amdgpu_bo_create().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 61 +++++-----------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9cdeb20fb6cd..39f88e4a8eb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -515,7 +515,18 @@ bool amdgpu_bo_support_uswc(u64 bo_flags)
 #endif
 }
 
-static int amdgpu_bo_do_create(struct amdgpu_device *adev,
+/**
+ * amdgpu_bo_create - create an &amdgpu_bo buffer object
+ * @adev: amdgpu device object
+ * @bp: parameters to be used for the buffer object
+ * @bo_ptr: pointer to the buffer object pointer
+ *
+ * Creates an &amdgpu_bo buffer object.
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+int amdgpu_bo_create(struct amdgpu_device *adev,
 			       struct amdgpu_bo_param *bp,
 			       struct amdgpu_bo **bo_ptr)
 {
@@ -644,7 +655,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 	bp.resv = bo->tbo.base.resv;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 
-	r = amdgpu_bo_do_create(adev, &bp, &bo->shadow);
+	r = amdgpu_bo_create(adev, &bp, &bo->shadow);
 	if (!r) {
 		bo->shadow->parent = amdgpu_bo_ref(bo);
 		mutex_lock(&adev->shadow_list_lock);
@@ -655,50 +666,6 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 	return r;
 }
 
-/**
- * amdgpu_bo_create - create an &amdgpu_bo buffer object
- * @adev: amdgpu device object
- * @bp: parameters to be used for the buffer object
- * @bo_ptr: pointer to the buffer object pointer
- *
- * Creates an &amdgpu_bo buffer object; and if requested, also creates a
- * shadow object.
- * Shadow object is used to backup the original buffer object, and is always
- * in GTT.
- *
- * Returns:
- * 0 for success or a negative error code on failure.
- */
-int amdgpu_bo_create(struct amdgpu_device *adev,
-		     struct amdgpu_bo_param *bp,
-		     struct amdgpu_bo **bo_ptr)
-{
-	u64 flags = bp->flags;
-	int r;
-
-	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
-
-	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
-	if (r)
-		return r;
-
-	if ((flags & AMDGPU_GEM_CREATE_SHADOW) && !(adev->flags & AMD_IS_APU)) {
-		if (!bp->resv)
-			WARN_ON(dma_resv_lock((*bo_ptr)->tbo.base.resv,
-							NULL));
-
-		r = amdgpu_bo_create_shadow(adev, bp->size, *bo_ptr);
-
-		if (!bp->resv)
-			dma_resv_unlock((*bo_ptr)->tbo.base.resv);
-
-		if (r)
-			amdgpu_bo_unref(bo_ptr);
-	}
-
-	return r;
-}
-
 /**
  * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
  * @adev: amdgpu device object
@@ -720,7 +687,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 
 	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
 	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
-	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
+	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
 		return r;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
