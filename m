Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B541C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 18:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B163523A59
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 18:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B163523A59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6543B6E4E8;
	Fri, 15 Jan 2021 18:24:49 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690058.outbound.protection.outlook.com [40.107.69.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043866E4E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 18:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1lj1dTpFr+pdm5rbFOfuI0QKHmKjKnHWUH6/V5xecsdknU2tp3x/mNckRNMMcFgBtYQEpt+nhkVwRVntqmYNe+pfDvrEAbrLBL/k1S3y+GkI/pZSYfJtTT5tXDCcKfQNEmajWVXhdBy1V5mk3F15y6kJu1v1Mv0hiUI9CQe/Uu4eKpeaEQeAL+n/WDJHyQ9Po9hxbLcCs7kCCGLLQOI5Pytzv7rJ/dIB3tRkt0Z7WInbB/d6+xIoCgzcZkGRKexKBWa0oewMXDz+HS6aDwutiy0JwytFGwmPtsDCmPrVBFgRGUvt9gqDyi/Qjd+Y71bHW3WYTW0l0Gn4qfKSiLnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INiZYX3nK4IOa/TFI3Ldg95Cod+XThTTo0oAqo2xt0s=;
 b=OkmExDyVwpeJ7Ck+85JoMKrp/fbrrHEswLZBV0y+mS2iefcOc+0xuegpG3VDCDxzZaVl8plg5Cr3Zj4g9X8Sp6DNX8jdixF/O88HnYmhp4RuShUoz+W06soQFAWHiM5hZnA+P7iJ4FXiYD18zw66ans/jIolitIbvocLU1v7zxiytsrSDODDuwvBDo+OM6k2dmUj58+VFtMXJy0trBUA7Izm/ht6pi2k/SiivaknpEUjVdDdR1NCn7YFm0CKkOSZDBgKWGCpeMpsWWa55DMNTMr+VkYsYQ7zzzhWmb05yPN3rsF1j+cMriNrbMLvEymTZHhTkcy8XWw32ue9ohhSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INiZYX3nK4IOa/TFI3Ldg95Cod+XThTTo0oAqo2xt0s=;
 b=tMq7/BjcV58pRibwDNQEU+B6hTaGZKypszOniFXaPPCrOCIYlkBUw/l4BpL6benJz5AVFr1tqdOzhVn9vx2k3/SkJ+Loci0YwiWYMMKCGrG8tawfutVEnPvvm9NP7NNJ1AlvLdzJHkB5ecARGAHzDCK79Ar+SpSTAYrSfqWXOlg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4814.namprd12.prod.outlook.com (2603:10b6:208:1b6::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 18:24:46 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::9425:559:83c0:991b]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::9425:559:83c0:991b%9]) with mapi id 15.20.3742.013; Fri, 15 Jan 2021
 18:24:45 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Enable userptr support when KFD is enabled
Date: Fri, 15 Jan 2021 13:24:23 -0500
Message-Id: <20210115182423.32368-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.54.211) by
 YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Fri, 15 Jan 2021 18:24:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88a4cc08-12c6-482b-8a46-08d8b982d5cd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4814:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4814086E5DD0D541AD30DBEC92A70@MN2PR12MB4814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krXwzNRIzUd5aF8ZdjFruZ8xmM5BonIfk8RKApCzmljmeuFNv83h3w+kA8MMXvh0ZPhdJ5pPi7BpMjMT4VptUQbWVmGQT6gE6mCYYqdjQg4w8xRzEIVwnWTpow2soSaOxi74yS5UcL8g3sxaDHaXmwAQ0aT8Lj6eO+CqB/S2RamquoYq2Tp/abze45VkwHkIAZHC9z4QHgOk3Kn13Dch90Wtie5EHI4tv7KtWIb15vI3cKGIaJpMWEHhs3DlQ+CP6+Cc2LwObMoaPoc1uRmt+2m5ZopklPIzqWev+R+KGTWBV7b7yrpUIP/wFfOfZEbHBSNjBGX8j0Rj6QPgSeZfuZid/l30SYoTcE1+ZIRH7m46vzhR7ddaPgatxWD51REEhuQQYkwyUDLzmqaNDa1ReHxcLqY/pdmfUBNnmIb4QyvKz+4BA8t0mazgUdkOTa3RPTZytPH9CXyMrtyHF20MWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(478600001)(6506007)(4744005)(52116002)(8676002)(66556008)(6486002)(66476007)(6512007)(5660300002)(2616005)(2906002)(86362001)(8936002)(956004)(1076003)(316002)(6666004)(66946007)(69590400011)(16526019)(6916009)(26005)(36756003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/REYDTx5YhhxwgU0wRcXiiXS2+4hH9mPnhgk+rK5czxGFHS/QobsxI4i5p4K?=
 =?us-ascii?Q?q4kYGgLqgWfBI5eEDN6cAL1cGuzp7u3thVS+TYfU/XNeqG3GsxuDVzSfANKe?=
 =?us-ascii?Q?q7MTllUnD3/K3nWha60ZAzSYhgIYhcVxjdl7H3xXgiasoj2ljl4l3hcIcFiu?=
 =?us-ascii?Q?UHrdSSYYvrk6VyCn7W4DN3OP0mjUVeB4p2M3usOLt+lo3NWPdoo+kH2UcKnF?=
 =?us-ascii?Q?YZ19gasCrpu4TI2N2pDC5dIdwMgQoXJ/3FyhlGF5/iTKxrOd5zX6Ro/abTqN?=
 =?us-ascii?Q?1JpUpIDEFu+IF7CZEKW0I7sEHXy3ftCstGPTQUakNPs0g0LXj5naooAUSsKz?=
 =?us-ascii?Q?5PD4NO5rbQKSObkDO+M2cGQJaWWWRi3xkGQgViGRn8p3+m+vO4ZhE1rAvUTt?=
 =?us-ascii?Q?49AcBUv3U6RKqgJRHKiMb9Wh+Y7mzlblNzRajG6FKZxVDEu3rFmmc8giZpXM?=
 =?us-ascii?Q?DAC998aTyrNyy+qQaoLrSIbKeZtgv1TVbD7iDWMyYifqDUcT5AtWY6g7Ow2X?=
 =?us-ascii?Q?6/C0A2n6La4q7OJA2mNga1JKquecOFNre2S2JRHapfW8XQH/fQvu9e7tHlTv?=
 =?us-ascii?Q?jeh8dameB6l7kLU/HzhODOgU8XwKxI4TYI3C4FLIet6h+KxJNfk3vHSAK6Dg?=
 =?us-ascii?Q?K4FlPceswz6hii6ObMaXbRUDfNr7fK4gYla6D2lk9IbN3nzCxYYlIQ5usOpx?=
 =?us-ascii?Q?u7cOSyfp/KlWguJHaXtMd+eZA19Kl2gHy8ZKNcMC9J+LILOKpYjni8fY8/d3?=
 =?us-ascii?Q?cUEZq6DSuU6tSzcvr8pDka9+CWhilcATo/lZ1yFlfAy6d2eARDgrcUKn5KzD?=
 =?us-ascii?Q?OxvMxIJIKj6Cpt+L50EroHHxzF6Ttn+Hya7A4c/eLP/wLGxdLvJDY/B+5qT2?=
 =?us-ascii?Q?l4u+dDUAu9WBsT3cBKd5yTiX2EhmAIy36QlVdIIA0hDtOYJfdCJLbW2yPrNn?=
 =?us-ascii?Q?JbKWKxYZzwUFHHYgFNhgwHII3gEKMUfkLDLPpYd1CZHM2hsOe3lk3E7KOXrv?=
 =?us-ascii?Q?V55d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a4cc08-12c6-482b-8a46-08d8b982d5cd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 18:24:45.8611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5U3jX1Eq0HB5h/2DKT1PP+Mxsvjz8I+3+h7u4A8WGDuJr4RQQ1QwHTfWxX1v78OT6Gi80KUyDREMA44D6n6/hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4814
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ROCm user mode depends on userptr support. Without it, KFD is basically
useless.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index e8fb10c41f16..2800b2bb2522 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -8,5 +8,6 @@ config HSA_AMD
 	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
 	imply AMD_IOMMU_V2 if X86_64
 	select MMU_NOTIFIER
+	select DRM_AMDGPU_USERPTR
 	help
 	  Enable this if you want to use HSA features on AMD GPU devices.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
