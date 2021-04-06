Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E2C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 16:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9CD613C4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 16:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9CD613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B086E03A;
	Tue,  6 Apr 2021 16:05:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643CD6E03A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 16:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIJvd9Mwo7W3frsBMF35C0oluwQfz9A+NxRHSQ6dq/HiDd5TrzksqLZYlKgwk7FkLdM+QH5SC6apGtfGIAlZXPJhUnsNuyJxhgNLV6PuZA/7C0AytL1gB4qXo3M/bxXMtLkoIeIcJDNm2IbXCAk+De7FAPp2/SVFAUK5cByF0suEqHtKx+Buh8bNbLNNDJShHjNtK1Q2duXWjxGYIOV5Iior08dYi4q0Zx7JQ5xZpst/6QuOIQiDCbzlFAxtPPNDQ1GJzwOqSd9uVgeHoS6UPsddh0+xFqn5a2bYzKUaE4gcwjArIGjX8fyxXVp74z0FA45SHpQTLznxhmWwcn6/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX791mPygXiN8fn3JvXJGwxgi79TwFla1rgLalVkw4E=;
 b=flsIHPwvvZnfQJ+2o1JAwP7YH7aUrEozZA1iwINxanfQb5L/aXokVydMxxmCQ98eNTsI3rklkhrk1BaPIERevXq0hYEzkZT93CsU5GysZVQ7buwS78PznnTf5aPXj1u2mftRAJ0DD35mkd2nPaxKguDM/91UyN26Rd25vmnI1Sg6xwUqMTfTOcAPIkKEGx3AUAAtKk4PJ44MuK2Pzhjc3Ivok5+e3IAQFoK7DPmXFKO8ovniRh84rlaxfp1HvPPi0KADQvk3kkdyPajRuvJYrQ93UJAX7/RzeY6EP1XKJiJOVYDy03tw+SlMbDzS53h82lrh/359NKweVdxunGOy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX791mPygXiN8fn3JvXJGwxgi79TwFla1rgLalVkw4E=;
 b=xV9LahL8lai0V1ein3XCxPXeK8Tl7J3fpd1X1KvFJTDhx9veuLiViKOjooMZQQTCld3owi31vziYIyDQeMR5hQNMZXf+E1TciDJ3yYg6czv9g5+DfxSG5JRXVfA44iK6w6PKZN1LTj8emMW5hj777to/qBDpoZcwkbsYbMLd9D0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Tue, 6 Apr 2021 16:05:48 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 16:05:48 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>
Subject: [PATCH] drm/amdgpu: move mmhub ras_func init to ip specific file
Date: Wed,  7 Apr 2021 00:05:28 +0800
Message-Id: <20210406160528.21192-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (180.167.199.189) by
 HKAPR04CA0015.apcprd04.prod.outlook.com (2603:1096:203:d0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 16:05:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aff990a7-bf94-4494-e6b5-08d8f915d78c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502B8CAEF5E6F9C464B93FEFC769@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RH4Rbw4sC2MAbnFv89cgm8aHYQBzFyEM9m5XRhaY4P84yX38eem3OooJzoC9WuHh4jrNc7PfJjp0pc1OimsUu50xwH4lwM1Lr1pDtmYtV1YKduyelwigcNS+bPHRNozz64TwHaL2YA0JiDe6Y51Kdhc6HBQag9y28dvcq6kIoVrkXZ2vdz/PL8O3/mxa5ux3ABEdIJTTxEdPJ+ZicokHc1cwhWTpbBCZWIekTVzT5WTvsW3xJcjdukwW3c8rwKuOm2dfm6xKtjR6nka8jY4zQlskz+UNQovGBI/QOXi7MfOJcx7hsal8hW4D+k2ccz6E2PucSEyGeay7Sb1fZwX/XeOov+gfYXqMfzqozcMVj1a+SoGpfi9NuaPxh8+czNk0eYMf+3SJ2KkdputNIFxeZFyG4hMBdmCkDndsqNnbF+8duyWZF6WAciXLA6g2Vw5uNWLto1Pb1LrhXGSSm2bax4ifMjZVgfojEl40wrLfnpJ5o6X+SCDXrxtsChPHEnRqdBTjs8uXOAmN/YeLGzLoWWTOmIYYMPeOYHdd3OsMkhlWWsigQ3n++DwiHOypHjvRUxYEry6t/GZfH9F/rixZcRn5yJ389RSoqM8Sv8HFnX3SadmJ4VORDsXBVqZ2cYKssDRTPa8OmliXF69NuFVTeN8tHudCGLgIdHxbHT9u/Qn0yXFawhHJybs74BXnGHQW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(346002)(396003)(376002)(136003)(36756003)(5660300002)(956004)(2616005)(66946007)(38100700001)(83380400001)(86362001)(2906002)(7696005)(52116002)(38350700001)(66476007)(66556008)(478600001)(6666004)(4326008)(110136005)(316002)(1076003)(8676002)(186003)(6486002)(6636002)(26005)(16526019)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MHzKnAmFLyDxRcmJSXzpaRtrfHOjsZ6AKDBEdjm6U9GpvKHeaUWhQ+UtQriJ?=
 =?us-ascii?Q?8aplvIDNBHiNhhQMEsQgdn7wy2RY8tfRajJUUUBnA7yqzmtXGZcSjc5OgaEW?=
 =?us-ascii?Q?wrBsqytjv47dXoTA45Wr5we3xEzkJ7DKVI514WveQOJRS5ljPcA4LDbgmqhj?=
 =?us-ascii?Q?FuLyBFmGjpW3BMxyeAVBRtev/RG+j2Jc7D9pVtQv1ko3i/aNkEsPhR40aicE?=
 =?us-ascii?Q?hWoe91UwkCb0f92ODpwkJ/REvpfXWIudqisAlrdOA/+954Dy9hU4rqkW+EC+?=
 =?us-ascii?Q?XozT7giWQFwYBZ7fvQu1ZuJNiCCkiHqXY8SuiQk3t0+Tyl/WE5hIyeevGkUZ?=
 =?us-ascii?Q?LFHKbI6VnZxFO274jA2mHMxKcZaYjPJPBIC7TEm9X8Dxb57aKRc1rT9wjcPW?=
 =?us-ascii?Q?xRlzlPRr7E5/EVI6bI+5UwG3gEnGDlcp8mJvMXqENJGTyubT3YeeA/gQJ7fk?=
 =?us-ascii?Q?JKB2wBmtE36rnVk1lqblUaDcRZmGaIoiUB6bfPrW8hmxzL0JjV+ECxzTS+Sz?=
 =?us-ascii?Q?ZWrWtXdK54CM/f7b9rpzRG8xCybgl+e1IrNk4Uy6Owdxsa3AHbIdzi1pjqmu?=
 =?us-ascii?Q?+G/7BgloQYu1BaiLgBuIzOCBNDq1z1OEVl3axF636kKCt3lM0JuledS651Ak?=
 =?us-ascii?Q?lIqjJoMQdfuVkw8gOac6xcfsnB7o2DPzBnpZRu51pfoJ70E1AWxnlYeWnel9?=
 =?us-ascii?Q?dfqtOFLPrlJ8/4TQdE9qmSndNJli97C9lKNNF+9LnoA6bSLBUFQmuxtv+3t1?=
 =?us-ascii?Q?8dcfEgW6n2WJqvKcOvHUc1n82sJ5zw89VQWSgbnBtgrhGWWZHlYqk3iba73W?=
 =?us-ascii?Q?fuZ8AbKH5N60qY6bfema8tUNBnbBtYUIaryAN1mLOvJiROn7kIykdh78jSv0?=
 =?us-ascii?Q?JNhmf4gkY0MgaPWZ+iBrJ9SNTQzCKmHQya7t0Y07fnMquSarpAeNXkCU1Y4Q?=
 =?us-ascii?Q?JjrcQgy/tcB4ltnBvJkdgk2ZxLGmgTvhxJ8lNyFdTImXWu4FmPDEkMfs1b88?=
 =?us-ascii?Q?Mo5siXIvnNbvjyZVwbpw9Qx2ZdY4kKAmlhvo5HWTklBB6msZ/mHOxtNA9uvE?=
 =?us-ascii?Q?oEsEj7a/NwebxmdxlJl1E5HxmBUeRt714iK2N0hNbNh5KBtIYOM+4zhEIHx6?=
 =?us-ascii?Q?SJrHO3rgshHoF2tziKvewV05Imkg1WVDSjMcq36MILjaZj7trNK6/ctlKymq?=
 =?us-ascii?Q?Sv+icEEIl2GNqEW5uUPVkb6jPhNvVDGOqsO1uhFyFRnXMOxll6J4gVj+Ikl9?=
 =?us-ascii?Q?ykhFJH26nxqgtHYljoHgMVRcQzu5gbD1xJT/zIUzRvB26GX5DtTj0pYtLiRF?=
 =?us-ascii?Q?lG1+VuO+9jan7Moj8MkGvlBN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff990a7-bf94-4494-e6b5-08d8f915d78c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 16:05:48.0164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucjU9qf2k23EAnrig1gZpzxrkqMsmw54/4TLyksOXFqfLbpoiSyVjxBK4rU3oHSREQLRqbM/AF4TR7LRbZotDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

mmhub ras is always owned by gpu driver. ras_funcs
initialization shall be done at ip level, instead of
putting it in common gmc interface file

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 -------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 013efc746821..4d32233cde92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -30,9 +30,6 @@
 #include "amdgpu_gmc.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
-#include "mmhub_v1_0.h"
-#include "mmhub_v9_4.h"
-#include "mmhub_v1_7.h"
 
 /**
  * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
@@ -401,22 +398,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	/* initialize mmhub ras funcs */
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-		adev->mmhub.ras_funcs = &mmhub_v1_0_ras_funcs;
-		break;
-	case CHIP_ARCTURUS:
-		adev->mmhub.ras_funcs = &mmhub_v9_4_ras_funcs;
-		break;
-	case CHIP_ALDEBARAN:
-		adev->mmhub.ras_funcs = &mmhub_v1_7_ras_funcs;
-		break;
-	default:
-		/* mmhub ras is not available */
-		break;
-	}
-
 	if (adev->mmhub.ras_funcs &&
 	    adev->mmhub.ras_funcs->ras_late_init) {
 		r = adev->mmhub.ras_funcs->ras_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 64cd08ee8290..321caf77b0a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1186,6 +1186,24 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		adev->mmhub.ras_funcs = &mmhub_v1_0_ras_funcs;
+		break;
+	case CHIP_ARCTURUS:
+		adev->mmhub.ras_funcs = &mmhub_v9_4_ras_funcs;
+		break;
+	case CHIP_ALDEBARAN:
+		adev->mmhub.ras_funcs = &mmhub_v1_7_ras_funcs;
+		break;
+	default:
+		/* mmhub ras is not available */
+		break;
+	}
+}
+
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
@@ -1209,6 +1227,7 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_irq_funcs(adev);
 	gmc_v9_0_set_umc_funcs(adev);
 	gmc_v9_0_set_mmhub_funcs(adev);
+	gmc_v9_0_set_mmhub_ras_funcs(adev);
 	gmc_v9_0_set_gfxhub_funcs(adev);
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
