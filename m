Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81CEC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43806142B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43806142B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC786E0FC;
	Wed, 21 Apr 2021 07:13:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C9D6E0FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 07:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfvIj+39uLIQI4413GAnSN9tvsyfzZJG5QnamHxUAiZSqa4x9CVDKrZYH9mEi/1x/4zseClgSR4RiBv9kuhoGuJoiqcz1YZnYmjZtiA1RlmipJX1HIWOz6AGTgaNU+tQQMN+ZN4JIbKXULv5c651SaZsoaBkjYukUGmFnDmSM/UUxOTjNQjvB6Hn8O0rZQsAQPaoQi4XMWuarbEgSzbcdlndqg+yAPra4vD6AYhWm5zSwXZXjECEXmieMwJYeqwRC0CyGnCgmyEGjZUBbMA1Zq9vc+4FYyj4dh5SXsBxhvwM3yjINgUh3Ts2S+a9Ag90mZz+t2GdXDoh4S54TSEiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I/3SYc2GWizAkwhFfsPyPAIEg0RO3yRXUPYfxExEEo=;
 b=kcEVWgijY7HGzY/SR/a5fsH/8+YgziA+c+Y07VfulNHJ+RZBsu1+3KdJCkrJLpikpezQWSlus/KPcgQ5kLsLNt2Gg/3UpeVrxuIGXH4vU4Cu7Y4W+nDyiGFUDzZeYl0jcFSdGojcdGMuHS8uWb/KZDkUGEdlFXTvk8WmYy58UN70dHKVPPMr9o+5ZoT0nlOGYAy2UiyrLHjdLOQmoN24uQdPrjgDwkULlJGc1axHt67r4mA+nYDZuyFluMswIcKGdzZ7BFrs0wr+Wujd/Hxg7j1xb3fKwl2oNOmcRntIKW6RUf7XgmJztx5uNNwY76OtUnFw05ZAWJsegFL5sw/3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I/3SYc2GWizAkwhFfsPyPAIEg0RO3yRXUPYfxExEEo=;
 b=VbSNzrDN3G71cpBHDtW7GjZdF7iQhPjW3UwA1gwjzZvoO+fSZLae0ITlexMIWBTAv9L41LSGdsBeUc/O65sYbN47sVuLbfCI797dyB/qd1a24YUeOCVpHSMtxZuGoDxyN25q5W+Tf/C7QYNGqv0YntHvygnkqwU/zKGSpwzdEd4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Wed, 21 Apr 2021 07:13:10 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 07:13:10 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Enable SDMA MGCG for Vangogh
Date: Wed, 21 Apr 2021 15:12:50 +0800
Message-Id: <20210421071250.795910-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:203:b0::28) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR03CA0112.apcprd03.prod.outlook.com (2603:1096:203:b0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 07:13:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1070a35-3d82-4120-7b14-08d90494eb28
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107F758C55004824699EF2990479@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DftQqg/o+G06Zc5A62STbjx3Ws3ewqimFSp4XxNf5WcLBdeq0g4Rq4gx9c8UIcgph/68LIKMu3SrLQKapWx5Q77H8JWTpZkR7yPYAhDrWLfMO/BMSQ/v7NbH9eakD9DRDgPdmGLFj+T3xOdoK0ZqS+QOs4Xk1tGdr+/andlh5q19dxC+V92hNgkDs2Ah5Bog5smxSb3gNwu4laDMQznUoUJT2RN9T/zzS+D2pexc7FBpeWxmcp3vfJgeJQqraSVJfytBA+8t9Ae5m2ZmZ1qBPXAsGxw1oUUWOqm9ZDqdHKMo8VS1Khos12cL0PmeIZNug8ZfjXCX0egpDelPPI2EMsfDXsb/QkmQ+dL+5/F/rXpDXoHG2Bv+vPdHrFXuH0PoKA+HSjciv+SGldiPrGfwfx/yKh7TICQXPL42pgwhUbc8DvDU0QhsdopgWPRkKzmb/DxVE+KUy3qHAhVzsT8ZQvtDPBcupIDsS7HiTU8mthLat7X3P/Y331VrbrHmMk06/HRCyiYZ5yImhc+pHfM32Wpe1MHuKGbfYQoEjuQH+cBAsU8vPtRK7tMiW2Oy+g9m2sxRVQQUJw66ytXFT8kYWvJ3Pc7AqoRQFX1g5SzLMM2qb/1xgzvdPMwZ5ujQaIiGiykY2rK70tf7kZ7ipWS+Eb8sKVs/Do6e569QEu7yRxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(38100700002)(38350700002)(66556008)(66476007)(66946007)(5660300002)(956004)(186003)(26005)(86362001)(2906002)(316002)(8676002)(16526019)(6916009)(1076003)(52116002)(2616005)(83380400001)(6486002)(6666004)(4326008)(36756003)(478600001)(7696005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DRmD3YzARbCfPH1jBFjZXWFfwUeNEFJ11/Pp/wT5bCRaeL//OGz8BuZmQm1F?=
 =?us-ascii?Q?77GUikjKSo3LvHDd6ZdsToblbKntTkEWBucx5lP7RY1D5CzNpz7ilTThsojf?=
 =?us-ascii?Q?IPLVdarRiyXtZRCSmKLwWv65ifg4jD0gAK6YCtLkUZQpkbsHq8Ei3oI2j5ZA?=
 =?us-ascii?Q?rZGpWGzzfqTry8FANP+KoeOBqu+tOlUAvC0cLjiJKN1ASFUCu0sXBOhrYqBj?=
 =?us-ascii?Q?QxlJ+ERl2hJtIO0RojsgqjW0NXF/VbPKzUuPPmnl/22lBTEzq6QE5jingpQz?=
 =?us-ascii?Q?GdR/HQxFl/+4QUNmSjXUpYrnpH9pJy1z4nkB2FD167MRWTdCXEXZPygx9WVM?=
 =?us-ascii?Q?nRE3rqSxVntYY1YIBNTB7v6I7sVkMCvUzoMvY3aqhOcBe3CHxGqkuke+n43W?=
 =?us-ascii?Q?asyELd9cMNesIUI5KZTf/hUkKAik/pdvKp4uzCu6fEXjnrDUVwTM6S/fJWCS?=
 =?us-ascii?Q?GhUO2glPckYxHx+YothYcMZEpW/XI6xyKNbfDJ7xjhK+ES1lZfLZdY4LPO3N?=
 =?us-ascii?Q?jIyEqtZef71cPuvM679C9cknmITIU1tVfRvfLqzHOlwJfat+NUAEmkMjFCEC?=
 =?us-ascii?Q?MsXIdiDFuWRw0v2PwYOhf/5KkBI6KtxXNoICjkw3+M5GIqEy2IOVOn1sxuRD?=
 =?us-ascii?Q?348wuFtV3jadNuoLTFQQzW3U/rQOoR6jdoDq6c5oIvmdlQ7Nevyc25UQT9Xc?=
 =?us-ascii?Q?nidqi8Em3wB9uWe0ZXsr9dnxR4pKwyYP2NRQcuC3wbPgO3pQyUz2DvOFrRai?=
 =?us-ascii?Q?C58uhFg43RuKvycqQtGEyk8+snbNcw/8VH69V/tfIElIsLDrGRHTI3yEJaS1?=
 =?us-ascii?Q?Gyjx7seFps9Z33KtF17b1ikIfMnb2NfKNngrfL8NuSsByY8IrPg0+cdynfnF?=
 =?us-ascii?Q?/M7KjRb8rWA2jfs3HroqY6dLD3wL7PqhG4vGtTlzl1js4S/5IgyIIoJqxYQe?=
 =?us-ascii?Q?md941lPXRF1k5ldA3xl+cE3cEERPfeELoRUEAeKDzJf+t9A5UEfzDcxdpUr3?=
 =?us-ascii?Q?yvVHNbqMECnuRbt/30cw/kHCUpEobyETAA/lTKE7tJcSEswUkJfs7RAtQNrg?=
 =?us-ascii?Q?GPXBaQfGDps8XZPyjLKYGJMi0W4Xny6tbtViAwzb297bfVqpyTLozSa16sqA?=
 =?us-ascii?Q?II2d1OZjYXKtlU2zIZ2XdnpgSlMOLCmDtbdzVqY/xS82fn7hSTYimOfTJfdj?=
 =?us-ascii?Q?E+N4GqVmXBKGP00dwH/xbYgEvV/E7t/7LJFvs6JhgzFpazlFiHUz1NgAMQXA?=
 =?us-ascii?Q?Sph1CVgRyoFV/vvg+jyv9iX3Rf3er55vP3nAfr+N2CyZRUZRIVxnxP7teyan?=
 =?us-ascii?Q?bW1layix909wS3IHXhdWeN0I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1070a35-3d82-4120-7b14-08d90494eb28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:13:09.8524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcvPbIUEidQxVrnT2jrSBnmX6PdXIRnFoIQ2Gs9hDooEqOwcLDnBYMlHNlVDRu1LJVGj0A6qT6PWTQHRkrmPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add flags AMD_CG_SUPPORT_SDMA_MGCG for Vangogh.
Start to open sdma mgcg from firmware version 70.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d54af7f8801b..0142f6760ad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1118,6 +1118,7 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_VCN |
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b1ad9e52b234..4ba7fce4c0b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1556,6 +1556,10 @@ static void sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *ade
 	int i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+
+		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
+			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_MGCG;
+
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
 			/* Enable sdma clock gating */
 			def = data = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CLK_CTRL));
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
