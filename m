Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C83C43460
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 16:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741256140F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 16:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741256140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1FC6E9DD;
	Wed, 21 Apr 2021 16:36:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D6B6E9DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 16:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDyTzPPxaPtcC8WZHE8UCYEHeMtcL20QDN+rTW4xPJY8r3U1X9sYCMToVF26veVvRj8uXRkMouZJD7dc/opPrk28iuTThmDn9eeNYJkCPeQSDUy3jeuJvXQ/6l82mlHJfHEuDM2j4yeca8Rsr0izsp2Cjcok2F8mmxoi3p0XWnBYfjmGqe2oGZiAFAEYARxgVI5/xdLwq+udilYspAmo7S40xz9PoPhsmWnZAgC6vWTi9jbA1qj83vLbwuy/aspxcoR5D+y6iR1G49QhZdU3YiSmettVmgL3qkYyIWQmv25F+f9253QDECcCLpfwGT9aqIPGBEP1O81HjMxTmCeslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT4RnS/j5fw9LL0BHYB//ggeIJJFP3ncGQUPZRUryHM=;
 b=C9rqqJWjctNcCgC57I3MCnsmEabpPByK55Tc8FdMnOcyEwkgZw9iLjw0y2fSbQygB2vU/gywIkACtn2Bg8FVcKKnvCg/EfHL9nONAjMjJqQzlTbAzpBFR4G9HAeBFwD6lv2SgLzC75yVLiZThM2l5DLHVRFLX+XNSqN3ClAyEHmqllsZUZ5gBcENZsBCI/LPVjDcMuIBYryaFpcV8EmiQ5B6oq73Pw/7Je7zFc7skyBbygL6/PuSmVIBdLyw3IWZb8TZakxCGOCQ+Ni1OOGhI+c/gW1v6H+1uTLl+nUmPUVvpmtGQTRgTJNB7elWr9K3WLTIzKDmBIMV5DATHynktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT4RnS/j5fw9LL0BHYB//ggeIJJFP3ncGQUPZRUryHM=;
 b=5hRH6Kx3oPD4IZ/gDM4VzCQV45Xch2f7R8RMb4gp9tyEAdYwzgWgXh4mSqhCYX/a3fDjWiIeVB8TLbcPL/CcadJNIhulr6G2EcZMOUofDcFWHgiPjGhlJYVkmN0vDcWcFtcmmafChULtq5kg4L1MaKUdkvWITKqKkj6QMt9fAPU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 16:36:05 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 16:36:05 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 3/4] drm/amdgpu: cleanup amdgpu_bo_create()
Date: Wed, 21 Apr 2021 18:35:22 +0200
Message-Id: <20210421163523.14493-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421163523.14493-1-nirmoy.das@amd.com>
References: <20210421163523.14493-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.111.123]
X-ClientProxiedBy: AM3PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:207:5::29) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.111.123) by
 AM3PR03CA0071.eurprd03.prod.outlook.com (2603:10a6:207:5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 16:36:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c71f6e-c2ec-497a-a14b-08d904e38ecf
X-MS-TrafficTypeDiagnostic: CY4PR12MB1576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1576251146D1A488BF27D7488B479@CY4PR12MB1576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3haOMrUipBvZGuWck1gSu5SLUiJ5yYUFVY/luYgbxUSZrfrWpV4JruseLy8QHYc2aX3mKh88AX3fRNgSNzHScwIoZEWbZeYSV0pcl6j3WeLJaEGK5UJ6wTWmT5ZuNlbDQOFuQ8CHgbgczbiGD1RZv5FX34RDTMaSoc7GDpA8xED8IKMaT42ovfut/Nazuw1UubBKrxDQ1flxYlWXZJ9gteAboGrtSoCOPaU/hrFSC1BBM3OxOCSG+UyLmd4nsakx/WNs6PLpxNDI1FWheOBYdoXfYzt1m6durPMli3ZlBnxyl3urJZBhMoBbEke1oOPXXAUog71Kx5smTAnKi0iScYYupz1kcMYKykmIcSbHML/zYe/OABRAkgwhYFtlM+zbzjU8GWtsw7TveP3u3BWFmn5qhalkbje1ZI71QFk+nO4zjYfQ2lSXoTaTpNl83WLPgGrD0y8LEatI2PJQtofhlK/TM93SCwbHp+/N1BtobDa1BsCcniADgtZNiaSJrHRYROQlNn8vuu7/eEB1KTlKwt05q8+OTQTyYfcWQqxoZn8on3tcuN4y/1di8hN5+QamRs60jeRfa8fn7THOewjjW8KzxVhNRix0CVIXqagaV5DTTpvoubOfLB9BDmTLxHg12AHs79qNNcJ9u5XN02Y7mrWuYDtmTdgz8AAcBSbIN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(26005)(44832011)(83380400001)(66946007)(6666004)(6506007)(4326008)(186003)(8936002)(5660300002)(52116002)(478600001)(6486002)(6512007)(6636002)(36756003)(316002)(66556008)(34206002)(956004)(86362001)(38100700002)(8676002)(16526019)(38350700002)(1076003)(2616005)(66476007)(37006003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gXQUt1dNLum53hKIuv5iupSX+VVy4ZXpspBSuKLeko08jp6I4A7DOEo/JZ0C?=
 =?us-ascii?Q?S7xO7W48GrZ72VuIZcXbRIz0QgL0iWK4imkuxao4lI2gueK41LCWTUDZaSjI?=
 =?us-ascii?Q?ekPp2sEUNdr8ypItqoifYC2jwRajQCKRw94jEbKEAoFtFpfQaEpXGg8xsUKe?=
 =?us-ascii?Q?OPx3ilf+1P6Zrn3DEsl8G26jpdDpGnP1yDPUmr6oVXkyvHqfxeM80gwTAFah?=
 =?us-ascii?Q?fDHAOO+sEugRqwLpYdvEsmozk5pmJsPLsx8I5PHrKKNXOb0lH1lVJoMKcPe9?=
 =?us-ascii?Q?9jntI1dBPn5u19Bg5NdHF/ida1FDgb5B6/toiZJ9ND/TTWNVxMptGTJyf6iq?=
 =?us-ascii?Q?+HaRojAd+OaZTWIrnfIBkubBJedaN1GSABJ0jkOMBMnMFjRI8rmnTPEaU5M7?=
 =?us-ascii?Q?R5iDSNAc06YdBjWCvSY1rwhcBRlj5mf7nK+BZG9SPyHASaWfEctsVeCrCk+M?=
 =?us-ascii?Q?+03LkXNiacI3VbJB1/OBEBCuxCdNoman7UqqX8o96dWzaN5iKuiQcvTEMO4C?=
 =?us-ascii?Q?K4na4+70uyut9xSqrR6mss1PpiAJyCZRtxCKXNncltONk7A3Z1TZVP0LAWiS?=
 =?us-ascii?Q?LUpQ0laLamTlM0p1iqXrKWZi5ORH16l8sRLCUaVR7skr9duIl1jRfpu+LK6w?=
 =?us-ascii?Q?PAfCov7QLXnmVPjvCjvkpbnlE9Omfem3sA2VKBZlW3fLPksRrwTQu0WVxe7m?=
 =?us-ascii?Q?aozu+86C4JN+yrhvq2j4GHOCNb2E4gjH3iSKuxTjeoWsJ1iT/XBAbprke13j?=
 =?us-ascii?Q?6WcsIaeRgPFuFBZOYeF6DTGxuagkV60SSPazjIkw6OCDpybmvZ45atChBFEV?=
 =?us-ascii?Q?bzE6yjg3YIrH9QOSu6t+VIsseHCS91nXbdr342NeVtbfzGS0okctyOF9EJMS?=
 =?us-ascii?Q?B0YYbnEdj7cq5eqZ0m7HDHtAWsgISQ/1cjivkYNzmSmSIT/zz4W+22bubHp7?=
 =?us-ascii?Q?6objDkpijOgzI2Yun02oxPZLAFym22I1w60xrGpYBzlAYEc/83TteSB1mmPA?=
 =?us-ascii?Q?oYNBcj7rm8X3ryA0VoKGjjm6pH0QtHg56/1QXzur+v0sD+Mkm1T+Hiv8e+Ht?=
 =?us-ascii?Q?DzDKNsi3BO/2G9NmEfkJ2s1A/P3rSZVdGv8g/x4QRGIi3FqXilBB3DfpZ7vy?=
 =?us-ascii?Q?zSBNSK2TZOGA00CkEH5RBTwV9jUZNSP/vU9zAwz0ENikL3aD0fxiL7/DT4Wi?=
 =?us-ascii?Q?qMS41SfZiy4u6HNEefC6XNrg7HS3R7fFFkbLfc2yG7GzlZc/odfs32yAkRwy?=
 =?us-ascii?Q?EqT3IOVqJQtIsWw9B7SEh8nu+e6VDL1dqsa3sunNn5ExZgTY335CcbF1MkHM?=
 =?us-ascii?Q?5hQ8jEcKgdGhKy/jvmjm1T09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c71f6e-c2ec-497a-a14b-08d904e38ecf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 16:36:05.1074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZRA94X0zzlETBJIkiB0XJRItSjptQJgUrRTBh29gSyIm5HDWLdEC7aC29OCtSsNmpRYme/xqI4P61fzTAABxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1576
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

Remove shadow bo related code as vm code is creating shadow bo
using proper API.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++--------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9cdeb20fb6cd..4256cbfec5eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -661,10 +661,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
  * @bp: parameters to be used for the buffer object
  * @bo_ptr: pointer to the buffer object pointer
  *
- * Creates an &amdgpu_bo buffer object; and if requested, also creates a
- * shadow object.
- * Shadow object is used to backup the original buffer object, and is always
- * in GTT.
+ * Creates an &amdgpu_bo buffer object.
  *
  * Returns:
  * 0 for success or a negative error code on failure.
@@ -673,30 +670,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		     struct amdgpu_bo_param *bp,
 		     struct amdgpu_bo **bo_ptr)
 {
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
+	return  amdgpu_bo_do_create(adev, bp, bo_ptr);
 }

 /**
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
