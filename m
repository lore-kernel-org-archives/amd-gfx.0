Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAFBC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 10:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0485161996
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 10:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0485161996
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F596E898;
	Tue, 30 Mar 2021 10:03:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538186E898
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 10:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcrGVTPzaYyVc08FJqzfuMs+EuGpqIQIqpKEqkUmVJbXjB+MOHHcTh/WYnBxDMEeJYNuZori+8UdTJyTE5awysZSGLqEoTY+M4BBi4UcjyObNobrvKzn/ePJctjz8E9OC6rk77vC12lWuIEsNpxl8pX6ZHZWOvl2SWNvK90Zg2CVS+5PYqR53zz8IBs10AoeIKXuny6ULVudU/SEm+8yoL+ftYIASGKk/FtuogT4wCADTQcKoZOyUUO9NwEAv1PfeRO+AtFXm7+m12w13F5Z127guxbG3W93OOYdyqvgUoK49rP7v2Q0Sxd9aTEopLVel/YGiHGemOVcLriWZKrvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGIORDDF9pG6v3uHNYqpDEWBsla7w9qogHbVO6A4BdE=;
 b=JYvrZyf7xQ+wnLbr/aaLNQi+As+9zGNsxD3NsEaVKfKO8TErzHroO403LXvS6HO3QFCUenTa7grbX/hTUqGBfhcLmbbhRZGkp7p2cbSX0xF0fv/RKbhjGl3IbIuBlXOrBADnipPAeSox8nLjXzy7aXqYVaHqzvOyXs9yzwZBSjAU+y9ovacCYAisHHEC/DFyTjb/r2/AJFgq/Xqa2zrD4tAPWTVpBx8DTPHPocLqSpo+W+KxsAj7BOwSJ1fPTC5QQwfp9bCfG6Ig+KOYo89x6VaE9cKkrF0etEn/aPsYoNQ8RM6AF6cSNOn7BZwBLRmkVPdeKQiUGqyx9EcuZOhCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGIORDDF9pG6v3uHNYqpDEWBsla7w9qogHbVO6A4BdE=;
 b=43pTKUiyFUAAnRVmFi3iNW8ISrpSAF/rMP8Uyp3o7MyX3bXcLlwUe0EPQHaIHBMM7SaeQTohxizqOVuEYkuD3XbWTgQUQR6zpQVtA8dKzM2t64WFO6pz3euwhLvkOyM7ZKOz3ytHHV4v13cNIJGhw4LJ86ouhR8Z2d4DuPIm8H0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 10:03:02 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.032; Tue, 30 Mar 2021
 10:03:02 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Subject: [PATCH 2/2] drm/amdgpu: fix compiler warning
Date: Tue, 30 Mar 2021 18:02:29 +0800
Message-Id: <20210330100229.26435-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330100229.26435-1-guchun.chen@amd.com>
References: <20210330100229.26435-1-guchun.chen@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0155.apcprd02.prod.outlook.com (2603:1096:201:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 10:03:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8bce74ad-175e-4b28-f55d-08d8f3630149
X-MS-TrafficTypeDiagnostic: CY4PR12MB1159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB11593DDE5FFF3842429C7B30F17D9@CY4PR12MB1159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEB6bhoV4ypYik4rwnMPWV5YkF4PDOX4vzv5VR6C3dDM2p1a5/yc7ovubGWxR0lc5QAO3gR5xqJQCPMbrBky7w0W8LVzueHaR2aoiYzTfOiZ7nQBQU+E5P7Pd4WkyJM9TwYjXVHNchr6gWJ3YNfDAYAvfJWmZnGPKBGDWcG9keig/ZLP65x6JlKb4N2R/hxDT4R71GxOTn3PI2NLtRbCm+lz7vlSS873TnSbNpBs63iipm/+GXhSgBJdvc0a4XhATiduQbeGlhkIG7W3IKS6OX4LlA5/PlCL2MswoNRwuHTdpzvY8dgYBYoD1P0zpu76YfldICqgzBwwQo3LemMigr3RJtldiKMB1bivBfCC++q6jPQ2qrGHBwpXJNO3kze2rQX7i8DIpArX235Wqdquu9H2es2+xM6AviRFrjeT4qlieZAG3eHDGjnC668dA4JBtNeHJGgC+eqCNTXdiKnRED9UNFzA4UyDSos/QC5RNaUaphqIlCx4+C1692olQT6HUQSWXLqi/OCuC/WoZergIYbbE8d0ybnkEU/h7b3kXuoevLQStZMqO1eJK717I0+lQkoJOJ+zQz+3pBDos4LaZrpygAYA3MxYhjnEy2gFegtLKYr87a3SbMxrz/Y6zELDcFCR6Q8bC/o540lPna4ZIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(16526019)(186003)(8676002)(2906002)(83380400001)(36756003)(1076003)(26005)(7696005)(52116002)(2616005)(478600001)(86362001)(6486002)(316002)(8936002)(44832011)(66946007)(66556008)(66476007)(5660300002)(38100700001)(956004)(6636002)(6666004)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YRWDEj2+BTaDFbcofe52N18uyGpA/c32A5nOcUOSYaX+BFvaTSwws9+7qVp+?=
 =?us-ascii?Q?CvC84hTNyuwB5vI2bzV09xWdFAABJGcgHFKjbWN3RxkyKEgYbLslul5IXDdj?=
 =?us-ascii?Q?cGee2Y8pZSAYjxw7wTeCKslXtoUPW7Y+l8QiRErk+bJS4ZRMRA5JC6f8d1iK?=
 =?us-ascii?Q?5+arkD4MuMHjKJzyyTQHLmudiMb4HA1SlfubjDma3adaR6crvHQOQah6DrhF?=
 =?us-ascii?Q?lNwGTZLzk2UE5cEsROFZDnKqfSFl/hF/a9DHv2+8+sq0ICGUobEh0xex0CJM?=
 =?us-ascii?Q?aQ/yx7HWCE19WN4rfkY2dFWuP4/IoWIfAMS3q6NxSWSc0yrSP5Z8IOLvZBxW?=
 =?us-ascii?Q?SsXgshYHYipSeUKbImkZpBQ1yjTJI8eLGkoLZnLqA0H3jtDGBOdxq1+0ybYF?=
 =?us-ascii?Q?oCJsvCARDWv/Qf/42U0AgF9YpLsJR3LZaoKy32VRT3B0inpOM/Mu9gmOhjvx?=
 =?us-ascii?Q?y9tmF0hqbkZzWEO4/Tl9DXy6VOlPd3vKybQNQuVBdhRJSZe4HIEAeT6bjIJ4?=
 =?us-ascii?Q?DHXgl2TBOICnv+b0mTYD3JD6YIzj8718zm/QaUYNZeMn+BKIghJ7K9LrnwiY?=
 =?us-ascii?Q?Xrxii6x/sRUjfZGiLwanCVXS+BdDQPwWYSJrtfh4lH/9HHUbDpolIUxXvjG9?=
 =?us-ascii?Q?wN1Du4Ri3YkO1jOLC5RPJoXpSBUxOZegWf6e9zFfMzq8YuOTeY13T390I7H9?=
 =?us-ascii?Q?DbmhQEwYXrhuqRjM0x+CYwjoMRxyNoFGoHdvTL3GARNAML36InzffiryW2yr?=
 =?us-ascii?Q?6o5XD70KkvnyaQCfRs3FwwNEn0bQmjVcyXrAGR839lEqcZs8lohO2M4PY2vk?=
 =?us-ascii?Q?k6wwjkImfoP6oeIhnxe7pIhgNmlUHQFFtw+3yHAVV1I2UaxAxwCdQYTKelmS?=
 =?us-ascii?Q?Ha1uGDtCLV9KwIzTiLlHw9sVosqtekDquQzFQ6IFixEjV9LkjLGOz9Cuo7pi?=
 =?us-ascii?Q?vnu5jR55kk1+XuwKv0+KW+W5dU9PVSf05IL6KMfxbrqPZ8eW9LOq9puMe1uf?=
 =?us-ascii?Q?+A+NhuJiM62pk7VGF5y0vYfRXrLJzEiCL8v4JDCqUZZjofHkFhHIETcxwgNG?=
 =?us-ascii?Q?CkOt7pdEUh3PQ7LiPWSJC7DSIVbEQvzSqZzo2ETIYE22qbZ4tjxAx0Cy1aE6?=
 =?us-ascii?Q?Bq2Z0+XmC3PBmebGeIRo0m6xwbU57JCDUFdR3f+Xjm1Y6fCTL6e+KKB+ngLJ?=
 =?us-ascii?Q?ZKxyXiCJLGLPutJNLOKjUT/YiVL8CXzHxSOmgwCUe2qqsT54J2m/V6h8dQWu?=
 =?us-ascii?Q?BsvuZBQOHw+aRaZXK2kO/OX8T0Tf3a55tHnJjAh+ySf7AsJV36sY2/y1QA88?=
 =?us-ascii?Q?GG02XF6C7JDBGWfEeXr5LYhV+SbDKEMAVwEaJOXr7aOnVA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bce74ad-175e-4b28-f55d-08d8f3630149
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 10:03:02.5459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Egt+O9qB/CMY15DrmyoRYaUIWOzQ4tI3Y8ZDzWFWQUc59AP9RgXgXz3MAOl3Akpo8Z87G9YpOVxe8E6Mq87t0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
  int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 722efd86718e..2a6fc0556386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -824,7 +824,6 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	int r;
-
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
 	enum dma_data_direction direction = write ?
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
@@ -861,7 +860,6 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
 	enum dma_data_direction direction = write ?
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
