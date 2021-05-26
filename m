Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F55C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B8661355
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B8661355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F716EC48;
	Wed, 26 May 2021 10:11:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD976E4C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIMxbh7lN8YG0lCw9/Ls8SopG+Tp4g3XgX+WxnDlLiaVUItrBzTEcRTVvSfVKfCSWH+Oideq9fheeQ6aoRqKrVrPy9pvlf6g8kMrtZtpt9g3ddFaJBiIn4nr25sD+A46F1CvoZrA/0q5TBkwlGAobmZWSWXRH4+2RytZNk8IlDZEYZy5pr7ElkNLfm/Wi8R3we7ujgrxrZ3M0SCbcz2h1uf6uzMu/5sUkgdVTCqOR8IoB269dcVkKRRstPH4jI5LqbmUyATkZ5pIXLZ4v1eORRSVM2Lzmab8r4pyIEfyfJ9Pke6zNYi9HUW8F66tPz4CFHRAVNQtoR7qzL5bWlCTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIAYrYU3VRKloo5Sji3ypu53g4A5JqKDP1C8y82lUCs=;
 b=hyF9vAPOoimBssY5i25vRfL5w1s22XTaauB6Ysi5P58xwTEZYGFqzyfU814T9h0XgaO3CHlR+odK2vuKi/0PZuxslRUY83ljgiix26a/g7rMCX0XOVJg1/tHCwhq0gj4qe+U6ojyczWuGAx61FsjVnKMUaGmg9+QfpK4KPezlHX23e8XDL7WmfCIGiiVZDXHURhcjJMwZ4JeELO/3eyjgPQm0UHBAuAb+OnNfCnNynJB1zFk3ZSUZtI7C8fFLcEBG5WJvWnAwhFB0zeB7jGgQiJB10fd/OUPxzzlVR3mDg8pZTk0pmxN2pDm4vLO4sA3aLECz6CarGRmCxrC4kpu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIAYrYU3VRKloo5Sji3ypu53g4A5JqKDP1C8y82lUCs=;
 b=d2Q6UvVbJGj6ORfycvKadbFtffvSbgep2vMPJYiPLbtLiTPJunOrdNAYFjiETLopYeJwYcG9dIcz2cUbMXts8RA4hiQ7Dxc2swsMTnnSdJErRLsC5tSmWYIPVjXpw0Uz032nwxNL61V/wFovzdMq4i5yJ9aQMhqPrlhQX5jwVF4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 10:10:55 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 10:10:55 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu: remove unused code
Date: Wed, 26 May 2021 12:10:26 +0200
Message-Id: <20210526101027.14936-6-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101027.14936-1-nirmoy.das@amd.com>
References: <20210526101027.14936-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 10:10:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46c1430c-ddda-4815-0a40-08d9202e8c8e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52329A545FDA89FFE42594218B249@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkDS/ZGDJSlenUWczYsLwDusH4RkTjsRb36JckovKdLh4UPihjwwvL5i5A2L3UTcg1/AAg9MYlW2Xamun17bCWVRSKPWu2QIhG+GQxvh+JIMOWV4uIqRubETsN+pyVNqWCAW4d/MGqzie2VEQtfelxEJ+h9VoSxN5NyRadqX78lWaBd4hQGkXKlHhSV3qHruSqcp4AY49xA4EdpBSfd0HLThTxfG9KLpoY1JVYpvFWf6gqUmkEI9YNcVZbI6NprdpFnf51br5ITqTzkNeW22D9dxGnZbtuKwJMbv0SXX9JPGGdVbsYH8eFHIunq4k0bSy5fqlndh23BItRczC48Plh3FXeEg9+8YMuYGwghsZOe6smQuW/6GZwVmF38ern2d+m4uOemb96xrylriM5oAdLRiRzQ9fyt2YwpeFKU+jcWS7CkzMbQv3DLlUKJlyjnIfHQeF6H+n+CMFOMQfJt/QUWQ8ykgtReFFLg38J04J856hW+sVgM80ZDIaUTBf1MTPVUTyVEGXteF5OeqNcTNKfUm4WrZmsvvv13uLaHBtv9xHgc+DwZ9B3k/Ep2OuurKDsw5u/nryIRnTEQTef8tW35G/Sz03fFlE6Os4+mXFlni6rBTehzI1x9xcS4DCh3pZ5kKmnj1TAPEDrKjdnBb6011zOXadMAIHXIKLeh42MI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(5660300002)(66946007)(66556008)(6486002)(66476007)(6666004)(86362001)(2906002)(1076003)(6512007)(83380400001)(16526019)(44832011)(36756003)(186003)(6916009)(26005)(956004)(2616005)(4326008)(478600001)(6506007)(8936002)(38350700002)(316002)(38100700002)(52116002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tq7d8KjkuSsrK3iFlXPL8Gh5MgubE9e/voDKeSgTMA3NODQvFBJMzt/dER1b?=
 =?us-ascii?Q?EPxwxQksj1qfwLeVgngEbNAqWmw0U3pY0UPtJsUX5PpPs5EWVn2e546vanhB?=
 =?us-ascii?Q?NBRVkxAptNKi58VFH9wv0nAfygYk/dJY6TeAYS1mQiZG6Yu2MDmBq4BYubr3?=
 =?us-ascii?Q?8IPa9POogoY8oxFulD9F86LDAFVuFiIt1Xp9gogeQOUr4R735tIyd092V1cx?=
 =?us-ascii?Q?jRuN6uE4ANIh3KijcjXlqicasarkUo2NXNQNBcwnJInzOdJkwZj+Qkl/dndl?=
 =?us-ascii?Q?WDJSYdb8jZNqiTLjr5pi/ZtaWgzb+7V2dtKhX4u0vlRqbB4UYfLPPreeIktW?=
 =?us-ascii?Q?+JSG7uuZFZJ/Na1n5xiP9/1LRDUeyPMKlCPXDpshzQ+Hacq8bQ17dMakz3Gj?=
 =?us-ascii?Q?irZSpKvUzOuz1HHUYTH8GSLQcVM66HYZZ/DSo3frrYXc03KfDu0KUMoYR1ye?=
 =?us-ascii?Q?fBPjPM8O9jZjt82DEYAAfQp9R+PaLMC2pabUEt/7VMvOtiVCacr0FzfJ9hx2?=
 =?us-ascii?Q?KgbD3lo5rVcJpsTRNH/A6BaJDnQjP12ivSkSgQKyz4uTBTpr8sacPd9s8Suz?=
 =?us-ascii?Q?Kic3GI/ADFJq+yJ9KfardCVo+ImXwYOSZhRFtfGE4VX50/xGpNrOuTjzfhOx?=
 =?us-ascii?Q?zxcSooW/Z//2vAKG+6A+6Y/hMqGhM1wIsHIzUOyawV9rx7TuEwHn2dOJ7Rei?=
 =?us-ascii?Q?ds0Hwg1qb90gjlfb+uy35iRHCZ2dvte1QTj7RHXvD4MhldVrFFD5b0FPdw80?=
 =?us-ascii?Q?KROb4CLI0Rs5z8gw+mFXQZ5lF8dI5EnKdNJtQ+SrFP7yBz+cxnuunhF6TZlq?=
 =?us-ascii?Q?blEwP/I0NUg5zkMMT7nDYctcIoWx1ia4gSD8lbkrP6WEg6iaUmK7ZHKni1Ik?=
 =?us-ascii?Q?j4vg+Cy6WScHaEqiZRW+4LB4Sq/8nKbWWqqWRo433d7mV3ogPkubvQJ/XQwB?=
 =?us-ascii?Q?HYcFrpsHGDU7jn9fIJFNYilHFL+71Ny+3J0OhFjMoj/PrxA1itypbYwk2E0l?=
 =?us-ascii?Q?bfrVBDnBLH3JX1QQBVBTZCuxDf+8JMoKF7KhX6RK6+BgGIYUkqmjlJJ6M3Dj?=
 =?us-ascii?Q?Fh74v8CSH2JCAW6HaYe84os1AU5QIYoOQgC5fVWdi0DYI6qvuCzlJZBbp5zV?=
 =?us-ascii?Q?UTWYDiFBRzhjpkxU0TYzJaayIlfZL4pma/yWDmb17O+UF7ks+hDSC0fSASqV?=
 =?us-ascii?Q?5RhkcCL/+j3n1qhA07rjs/K3frmrzV0dHEGoYDwmBXI/ZM69n3XdQc7TsOci?=
 =?us-ascii?Q?W30wKBPQdE+Cahhjqq/jGe7yWO/KWyqFDp+8ZiKNh1kAeSPtvuqgwDS1shGr?=
 =?us-ascii?Q?kbwJ9aPDsUve9ysc7gnLyCKI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c1430c-ddda-4815-0a40-08d9202e8c8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 10:10:54.9295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1XF43/2J7vWSBhp8Qe2MfUfXXOXUsPe66jjbLzszK3Nos5iXbd0u2/EozUNnBSJ/CnG6xpArlZCF5Le6ZO5yA==
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

Remove unused code related to shadow BO.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 29 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ---
 2 files changed, 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6870cc297ae6..7930b7d9a3b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -638,35 +638,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	return r;
 }
 
-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-			    unsigned long size,
-			    struct amdgpu_bo *bo)
-{
-	struct amdgpu_bo_param bp;
-	int r;
-
-	if (bo->shadow)
-		return 0;
-
-	memset(&bp, 0, sizeof(bp));
-	bp.size = size;
-	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.type = ttm_bo_type_kernel;
-	bp.resv = bo->tbo.base.resv;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
-	r = amdgpu_bo_create(adev, &bp, &bo->shadow);
-	if (!r) {
-		bo->shadow->parent = amdgpu_bo_ref(bo);
-		mutex_lock(&adev->shadow_list_lock);
-		list_add_tail(&bo->shadow->shadow_list, &adev->shadow_list);
-		mutex_unlock(&adev->shadow_list_lock);
-	}
-
-	return r;
-}
-
 /**
  * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
  * @adev: amdgpu device object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index a7fbf5f7051e..b8555c527613 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -284,9 +284,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 			struct amdgpu_bo_vm **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-			    unsigned long size,
-			    struct amdgpu_bo *bo);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
 void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
 void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
