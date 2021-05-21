Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24AC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 05:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D38C613AC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 05:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D38C613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56D96E48D;
	Fri, 21 May 2021 05:26:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB7D6E48D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 05:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZVfdF8HUTJckIJ69IcAni6yaUKE5OkiqBhQ+8hB1wp58wC12UKlcsvcVV3Ek21jG6ShdunUTv33FK0DWyj6+EDboahaDYDQ2NYgimmOuWfxqTjWcrF8bEFSmWZu6fnaZcKqSGfPDJMIAbE1pq7xB8Ki+7E7iutfUpoxLTPBD/CT4fed/MtxEnwBuhrKi0Ru7m+2JWKePqa1AdTFHniNA+ZCRO5SkR7EPy32sb0/kH8VDeGf0y31c5SnxZurK2um9s1d5jT9pT/6P6W1EVHoDfbmUIVFpNFDOZJBPI+zMxIN9Wslo7PGYowY8mx3P+LSyBJocxqfKt39wxAhYjxmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOYtRUE6ovqgeInLKs+bgLuXgWXiVPoJpEASslOsBUU=;
 b=mRgM1NMkYFnprsVBWsLHeRayV9Z9bu0aOM8gVnKhg0I/LCylkdNutns3jrej+5bc2ErmDq/Rg/+Ywpb4reukZ5Ouvc1A8hICMluJuBke4S6YHnc+GC66mOTkkmiSFyybqOPFLfOieahNCAZ2rwlybsYRtAu1MKJ2i7mRN+ODe338K+Vg60eeTqTfxP0idybqP3qNhHfFXXGn5ZKRgN3zo3epLQ0fT9tY8NCjtn/roBEa869OBxH/jDKBEw6FETfiz0HhjmvprJuRjYsYe0Cbq2SHf328cwinneKa+rlbKvKyyTK3DVViwSrfH3x5I2tzir1tVBplo53kCeyRL8C4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOYtRUE6ovqgeInLKs+bgLuXgWXiVPoJpEASslOsBUU=;
 b=gzXusdN+dnHglHirA/f0AgNfGMtBCiuiQmw1SzCzxfqN81CZo/CaX9mgLfLiaiwiIrP02+RxDLYYA1DTgBOlLvqsRilhucn8zCxojdzo90FIaHhWkURdDbSe5P4Kc8noHrC6BZqiUbaDqTMd5zK3CjgniXacWM5b3kMs8I6UfPA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 21 May 2021 05:26:33 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d%5]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 05:26:33 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use dma_resv_lock instead in BO release_notify
Date: Fri, 21 May 2021 13:26:06 +0800
Message-Id: <20210521052606.20323-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.2 via Frontend Transport; Fri, 21 May 2021 05:26:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5778fef8-13de-45ef-5ac7-08d91c18ff0a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB539066B5165854441DDF654087299@DM4PR12MB5390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzyndCxsaJAevgGDKSZMa2he7cQ4BeCmODg4C/HxH2ryEUm3aCB1Ihc/WZ84ely8OZ7jKVft6hXw8cXvX/33glal6TdQ4A7CX22wPItkDbfncBP+fREYTmN0SqN65YebZeSCSOhc1guzBl+qJuDCH+ydyrgZqb+fni7gT3RKg2dqG5Zb5y3bC+tz59O4w3TRQyyoImt+eQmoURCiJmLEmV5B0X6QmT4GL6rxcdpPMe0Jmk+kPjYLWFeUpTuf7I4/aR6sh1fMzRJfjPyVa4rgJRJGCRsgQiJkeoGAimhwuSvbiDDMdYzU6lfqbtdpGH7wfZPS2MTWMl9Xg+vBqpDXkIYKANLBily9qujOHfZ4AAWKJHYs7WByQGyP0fDdCgffYgf8HCEY6uo0/gMa5s6OeNMAr/+B3NIAX5/4KlY90Z8Ac0GR0I2hRoCChLyUEzOPApjDbJNpqk7OwhSOaqW1BxAyNcX/uoDDwBsluro6g+AaC8WWxs1pP8vTvhbCKKT5ORG0bjWrOKCI4fOzL05re2FVADs+GvZIuPu8cL8MjVFV12PsQJ6MELycfnCThwTI8V6r5CG1aioyGPIx82oyCpfsLi3Au3+lSdGLro1iZNz3744SEEFA27H/KJRd38Yn+6j8ZlJjADSsoGmxa4+z8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(8676002)(66946007)(86362001)(66476007)(66556008)(83380400001)(956004)(2616005)(26005)(6666004)(186003)(4326008)(316002)(1076003)(7696005)(52116002)(38350700002)(38100700002)(5660300002)(2906002)(6916009)(6486002)(478600001)(36756003)(16526019)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BUEwDFvaDoXRlz51O4wApVJJtpCM3xSh8ncRSwemVdkK4RdvyU9hFC+ocwHG?=
 =?us-ascii?Q?XJLwc8GcG0+I2ZnY6KN9j+7kQLCIEo1kOUoYuCqYnoA4rmLrEHBeE5PPSVKJ?=
 =?us-ascii?Q?6NRc2yb9IrBBwChdmfrsRmtIQPk4d3vtZ9vd60yNWYouN6zNOLQF11WCpLVN?=
 =?us-ascii?Q?8abt1POf+oXmgZzJZgDzACgUrMFG4dqwsPVvxDjQiLfda513znCK4mfCag2k?=
 =?us-ascii?Q?dluoI5xL/fp5Bfx11cc5vykw0ZndzKt0v3G9Xe+SmSzNCOMwTbDiSlkHiIFW?=
 =?us-ascii?Q?Cp7qTcKfI6l30tFk0+2TffjexY/vcwGerpM5weE+wPMIDQ3p1HlfthSC3Hob?=
 =?us-ascii?Q?ZDsqlTXREEI5WVxuribVTrRdPtuqFMg8um+b/ZSOOYq8r8AnmKpLpA6sXLEX?=
 =?us-ascii?Q?NWjjmHY82XMIVjlJMnyc0AMd02h/q4X5PmKQ4LVAN5orSpgg2yUYEbd3gako?=
 =?us-ascii?Q?DIppv12/oCe9wh2qAMQ0fvRfiUdzUyR/yPlITigYsPgGa/jyUR/5heOjXGnd?=
 =?us-ascii?Q?EilteTiP06GQ4BPtJl+Z2Le46/rB/1JbbeFJypv0li7OT6pjbVOAI4lHDjzf?=
 =?us-ascii?Q?390c8pgRd46sgnXhPlkxAfnn/Kmbk+dqPuXR8vHvsBCkz5py9sr8Wms9guws?=
 =?us-ascii?Q?iZy/R7oozuIZfFJuPQ4GjR3VfgfsZQ1eYfNQNHThkNCymi0owNBNGr1hmN08?=
 =?us-ascii?Q?coPzvwHh3wHoKwMTBZgaFszF7ScKWWTUOIQoBnrjg2dVXrktJnr0n8OoZI/8?=
 =?us-ascii?Q?SE1gvzyXmNq6C+zMdO2hgpHgGL4xBMlv+AZnfwNHW2EQomw+l0wcdLYg74FY?=
 =?us-ascii?Q?w1yg0gzWwid6ZGtygTHbZNiO51sPi4lykJx9s5sKBqxKPzLxgwktYcpmwgni?=
 =?us-ascii?Q?KGv9g+XorecWH48BEc0phOPlHxYbHwM5UUNgwQ4rjwh+/VSG8LevD2mj5dnw?=
 =?us-ascii?Q?EsTOaPueOal3Uy7/MnR/ERhygM/MYB7GgNJfpi+URvrzGFuNsVBnkusr3o+s?=
 =?us-ascii?Q?jCFPaUHkz1IvC7pKBfinOckj5kioyIlLqdIQK67t4tWNwVC5tEEeAIAb05qp?=
 =?us-ascii?Q?EXlym2Lk1nxRC5bj2b7OAsakAp+/wKObTIjZ83v9mzjFZiKclf9T35VnK/Vm?=
 =?us-ascii?Q?RPCPMC539IvXbL4OntBACc5S8EXkM3sOuXTODTziqF7hmwfQJk3M7tJLWk9b?=
 =?us-ascii?Q?vrCzqdpixhq0pvCQCQ2iUrvAyQn2bZx8AglxXKMF6MGuLxN7J6hkMwJd5rNP?=
 =?us-ascii?Q?4lyScfHJV0MSr8JxMsdWNU5kLs9+vi5M7Z+Dtl7qKmlFspnT2Xv8QMfAbt8V?=
 =?us-ascii?Q?BjDI56slnwm1rFYLHxpFUhat?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5778fef8-13de-45ef-5ac7-08d91c18ff0a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 05:26:33.4890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NFaHGpatgwYUiI0ygYu1fzfSgolj9XC6WcZgxu7/jZxnJj9Eu41Sb5mvt3a+6Q2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The reservation object might be locked again by evict/swap after
individualized. The race is like below.
cpu 0					cpu 1
BO release				BO evict or swap
ttm_bo_individualize_resv {resv = &_resv}
					ttm_bo_evict_swapout_allowable
						dma_resv_trylock(resv)
->release_notify() {BUG_ON(!trylock(resv))}
					if (!ttm_bo_get_unless_zero))
						dma_resv_unlock(resv)
Actually this is not a bug if trylock fails. So use dma_resv_lock
instead.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 928e8d57cd08..beacb46265f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -318,7 +318,7 @@ int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
 	ef = container_of(dma_fence_get(&info->eviction_fence->base),
 			struct amdgpu_amdkfd_fence, base);
 
-	BUG_ON(!dma_resv_trylock(bo->tbo.base.resv));
+	dma_resv_lock(bo->tbo.base.resv, NULL);
 	ret = amdgpu_amdkfd_remove_eviction_fence(bo, ef);
 	dma_resv_unlock(bo->tbo.base.resv);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
