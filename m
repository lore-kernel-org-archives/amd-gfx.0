Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB39DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487A461208
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487A461208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06DE6E2F2;
	Thu, 22 Apr 2021 15:40:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F846E342
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8yOuiFSXkbvB8UhdOMwjPRXS7pHTtqnmyNhWZ5TLbokBeTL9IAH0t/U/EqSHLg6tmpmn+amRni/wEZJhEvnSJnZx4dYEB7qD9XNYX5+lJy9u8nZIoAx05ahvPEoFngWVOnrug2Rvpfr+y20Hy07HUrcwx9GmtEqyLvApT0CwZXOi2/fSjVehO3g7Sj4uHn0oLebxi+Chp7Dwp2DC0KluKppmvVer743YaMi7NFQLDjTN/NQ1++OYVSoDwk87/4SA5aRCWskN0xAbojmu/N4H0CFFT9vSwfNP73cstRwWadysFB/arGF1cO8WHME90lyuS5e/jQtykcF44Bd5sLZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q67wBTdE3f0ExvImAQV6I++CBskvuxVqGyhaJjKJyXs=;
 b=j7wru6oLEmhZRFqBvlH3h0yjy1JJT7AnfGK0cjjtDjVCwdaJtdoHqENLHl3V6N3kG0ZE7v2yadYHoCMtRiWKENmj8uzkDKJop/RR+nqDuQtt7CnYSXEgkCibQhHhTvcgzijxFthWU/am8jGCochbc27PsxpAX9Mhm0+UlYgLhMZNkaXrucuKIWNOzCIIoEVoI7CecCy8H/nmmnyoAXvWXUrdsL+kWZgcvpkFVbAAMiM5SONnu4HgIZ1aruWQsLZjIO6EBEoYPtcGvMAMexTVDk4Q1ZzBz1ahn9E1nmKPucL8LNgfbM9nIZB1Bsk+xzLMXjvKpj9Ex4wvkN+O8zFqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q67wBTdE3f0ExvImAQV6I++CBskvuxVqGyhaJjKJyXs=;
 b=Gr4wf6LwdMll2VFYH5ohezm3Z/NoisYVPob+IO9HPWOIArVpJrkBErIImRATEAHOvziQWiUMSdXsu3AzWLm+xUu7uwbDeApw6CqtkWK2B1C7rXXZS/+b23z3KiNSUusmWbCEqCgDNRdhd5q9YvlXTDPKc/iFBv0lG4oKwU8xlAM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1173.namprd12.prod.outlook.com (2603:10b6:903:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 15:40:40 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 15:40:40 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 5/6] drm/amdgpu: cleanup amdgpu_bo_create()
Date: Thu, 22 Apr 2021 17:40:02 +0200
Message-Id: <20210422154003.4048-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422154003.4048-1-nirmoy.das@amd.com>
References: <20210422154003.4048-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: PR3P189CA0083.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::28) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 PR3P189CA0083.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Thu, 22 Apr 2021 15:40:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95511e28-81e8-4c5f-f886-08d905a4fb90
X-MS-TrafficTypeDiagnostic: CY4PR12MB1173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1173F81CB539D170AC6C7E9D8B469@CY4PR12MB1173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XX+aIdr9O0J7ucG3IlC3azMjiIRl2qBahBJz3DMUgW0Tvtx2s7hE4NdhG8Tu7+RbB0epeqZrzqOqAIAL6zTB8Ve74Kz8lPVlPpOxBNycVXGiPvo8XWGsOkyZmdE7KhvjBfPadk+/g4W4LjzmC2xofdJ8LafzfFkIal3piG8xjOupOtGVJAZ3lQAo/w0GMNKFnG/aso/FfeZdaeZtNuYQg4mGow2K8OwslcautejwcrXxQBk01T69k+46c3sppGi+x61urYRRaLNj8niUsti2Y9x0FY8uci6ouf68Qrd9KUMXGVt4zygN9JY4t+NXoPIaih8Xk1Zjx3ZsmwnSd401ffJ/Ekmae6MXkJjbhAzSmfQbCwkOoxAI5PbYpm6sO15LJr3W+5imc2wyEYXmaojMt1CGNUy3kYZ4WeGq8TWOeNbppOK/GTdFYZp92bH3x5HlNeRUl7Q5mbwfjAliQNxhOAJ2pR/JpT8EBjupn/PeLMSivr10qWVZjyqH+K6K17hgcCzG3YUGzx6s3W9N3WRGuvd1G6kEynuTax2xumcYgTfqX8vweCkG024qsPVTx1LcllIat+gbDPKm9x3L/8LYTSe8jTUrF0NsZDI6viO4kfTuwbICwDS/+DLuRtamEy6UD6YzP1sYOMmoMN+driLIv2nIb1BMtJ4hVJz0a6dzKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(83380400001)(38350700002)(2906002)(38100700002)(8936002)(34206002)(6636002)(66946007)(86362001)(66476007)(66556008)(6512007)(316002)(26005)(44832011)(4326008)(6486002)(1076003)(37006003)(186003)(478600001)(52116002)(6666004)(8676002)(956004)(16526019)(2616005)(36756003)(6506007)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1V1ogutBeHpW/tiOBkOsTh87h194Ms3KjFZ9nVjAowBWqbz9xaZJl0/Y7rUt?=
 =?us-ascii?Q?aJ9wjrjJyKfjM8eJu/+8+b4RFWHBKw61OPSRYUFvxMVbtAEGNC14OvrrJ9iO?=
 =?us-ascii?Q?w2AGfjmn+Qu/V/1wo9MvEeHB+IQwzZYlPMAvNTWlN08VTOMFciD1L6gCQJS9?=
 =?us-ascii?Q?gtaLdI+6uP8lh9210bZUN2iqEzQiGJDhIdEDFumr/3M692t5pF4HDejDqfJC?=
 =?us-ascii?Q?4Oi/FpDHDEls5S+gGUUgzIITAMTRtxnEFK/nJGYezKW9e6a5dGQuhMMCe7+l?=
 =?us-ascii?Q?jrc1GIdsTshsc1w/vSJSPn5/qvN7hDI1URDx919t9GalhQt9pKS3SrfxDLbZ?=
 =?us-ascii?Q?/VRyqdrFTg1arhHKha43t8/Gfaazu32t5TnA/MSDYcJDAPLXInYkEcSZ7OuX?=
 =?us-ascii?Q?FKBpKQ+eW/bPHyXC9L0fQkmHPBx/Vu6HcMiHaeej41bskDqEjvNyT/r7g2+E?=
 =?us-ascii?Q?kMr+JypYI/dEizeipTZk6Pl0qGY+1ZGUxGGPbyZ8SxP+HMtJGsxMXTCVn1t3?=
 =?us-ascii?Q?wOdZw0OOq/+aQMhIfJ5VzdLet1u8fUa7hkb0xGvy8qtMU7nE9S6wfb4nshXp?=
 =?us-ascii?Q?mb/whZGvlBpPUCYGL4QD7Mp6HV1p1At93JE6thBEXA3ZXDZciDzbveaJgKpm?=
 =?us-ascii?Q?ebXqcN0RKtRDDKvjTYfh7FGLk5ady/AxgQYz0aZ9I4thAWiSfo7ItoWF9WPY?=
 =?us-ascii?Q?IfVcHoDngDZQbs4Ff3sgmmOGDY/qS5NSUjIkEt6wnjtDcEyDMQfHd7OfB08j?=
 =?us-ascii?Q?tJ8RWnAuU/e65+F5FqUh1nw0BcyuNwOZiwdo+v5dzDcUa8oIH38nQfChqUWg?=
 =?us-ascii?Q?Z018P9a5DWdFVrry4srf2igRdD6VNq/JernY6GuBEyniFGBrXtp5U9VXqq2J?=
 =?us-ascii?Q?NFcZOsTM1ZWt2rmyMQp4gnBvoZe/O6FXmh6kqCj7RVoODVMomsla4YZJmf6m?=
 =?us-ascii?Q?F60WLIwz6eD/xo0poLUtZzEFErLyu5v/4zXjfEg43Eq/TgjRnD+bJwjT1ba3?=
 =?us-ascii?Q?lRTYmVhsyRTz4VGLEPPbgrkifCnBFs2oSH9fasAmD3pOngBfz9BTML1wRDAH?=
 =?us-ascii?Q?PlhPJf/qdt35SUfuEdkflUHO+iTlcTwTr3upQ1sTeca7PQHKD7cBFd4hLnwk?=
 =?us-ascii?Q?MnNh0ZD3YbLb+ZfhcVEoDXZWCaowLWBS515eQU5o1sReqYdj9rIJ8YbQNNCV?=
 =?us-ascii?Q?5kiFZIe1kpdBWq2IZJkbSzOiIy0XkIEaLzssdqEFwbgHwq69OtAg5z2D9TzL?=
 =?us-ascii?Q?d8unNoDbOZRIBsn+siWkU7DJYQdbHrviBa44qS7K2lNTM1hdejwoUyllKvNA?=
 =?us-ascii?Q?Otj0ecYAxWfLuMyr/PCf/nX5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95511e28-81e8-4c5f-f886-08d905a4fb90
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:40:40.5762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzH3A9R8vptYmappje0bktbbWW5w3U2hYBDkQ5UJMPmOmY/VDjPGgsIxyJPT5WARKSVD6ggHBp67Ejbb8qEAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1173
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
