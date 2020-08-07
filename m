Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF25C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 08:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C3620866
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 08:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jJK4+w9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C3620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2F66E073;
	Fri,  7 Aug 2020 08:26:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EF16E073
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 08:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vbhz6Lbsh8zVLCD7KKanstFLk6gEGxhHGIKm1AfMHC+rtp6b0hEyjRyYYs5Vwcxv1iO59vNXMP8ketWnEFi9cWx7hyYWtjQFI72FLJk0BBg7z/saLxQi0lNGt5Ove0RquZlNkXeNj+qFvxIMTfUzXoQf03t3pmVSbFj1aJDzhdQHDwp+Vb7CBGk//hAiXauBLc6K6Ar+XcxYCKuHWEMnxF0UQ3tsyrtPuWIEvWsFXUiFkBB121/viEFaQOz/cj3KtiPHz65Uu64MCXoua4mP0h2UrD6AZalU6yC9uInb5DDYLZfxf5OZPNw5zzIl8kX7k7odqLnHjs2726aGOM1d5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=326vOCkSb5+sOcblPhqKslDd6nCXYoUOAmYge9A7ilk=;
 b=T2c3Ail+Q8nH4vq5GruV6u3Iz2VFaBlF59/THO9sc4ddkvHS/6/IvpijCEAvJag5al6kpKWRP/RZm103m3MA2btUEpUJU0Urb+VkmQCSpgU6hXJq5vCg1jx7QRi36Dp+YtSjDEONPpvFuKTubLfYCm1DsMGSmdxHcE7m+Wwp4OPkWv2op7+HQ9axflkx9KUUeTvHYMW0QoCleDRW7az36dyWSBNKkx6DU6pMZ61SJ2f6Oeq7eIarwCLVY0MhUuKlT26mlOYX+mc0/tXq/L2azSOpC7nKjp2xuCax3+wvSjvBAJhRxk/7IV4nHC4e9d6RgBkcK2q1HiQHYwHGrgduxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=326vOCkSb5+sOcblPhqKslDd6nCXYoUOAmYge9A7ilk=;
 b=jJK4+w9GRToetR1aVpMO+Zm/lP0jC6KuNI1GCpewo6u4qdi1TURR7kKULQADWcum2s/Mj3oSrA+pbnV21dffw9eUp58ChLYwuXytHsCGQNHhtEP3g3Q8ehwhOhGnNwwuNrPFZFpLBzSaM61TiJ+CQimfgyIXuJPlUf6yvotF72I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB3838.namprd12.prod.outlook.com (2603:10b6:208:16c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Fri, 7 Aug
 2020 08:26:09 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3239.023; Fri, 7 Aug 2020
 08:26:09 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: force raven as "dgpu" path
Date: Fri,  7 Aug 2020 16:25:45 +0800
Message-Id: <20200807082545.2382890-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HKAPR04CA0001.apcprd04.prod.outlook.com (2603:1096:203:d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Fri, 7 Aug 2020 08:26:07 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d302bbe-86b7-4f71-a62b-08d83aab890e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3838:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38387A65583BA04879CF0634EC490@MN2PR12MB3838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOtBqOApvGGtYmpCyoI/QjPh4G03fKFsM0tURutkPvbYvgRIREPs28dsPJsjSjcu1ycApne5ahio2Jr20U3Igp91nWr9K1maFQKPzi5nYtQjanlKa3e4nTeE46zgIBJ/EHbccHRXqpQX1O2aKgYiJSPiU5xNIqu2R5RwKWcv7o+ny7O3Xgma4JNLHmxO2RE6gEDFcN/0RHzOlyGqnlfgVEIpZ4VFG1hdgi/IthP5/0GmzpFsTZ0/QWvJHmgU5Buipe/AhDbAGJx3MeYWL7xqFOBOi/oK4zJwWFl5/B6np2F4A6x7/quAfcJP1Q4D6AA6aR20jSnJ86ndrF1yYR7KOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(54906003)(16526019)(316002)(186003)(478600001)(26005)(8676002)(86362001)(2906002)(956004)(36756003)(2616005)(6916009)(66476007)(66556008)(66946007)(6486002)(8936002)(1076003)(7696005)(5660300002)(52116002)(6666004)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CvmPcraDuDTprWJ2NMw/B7RQwiGwdmokstP3vjgPovuh5/9+7OkJXrkFEznmayP01HFmvIRS1eUDLryX7PI0/nBq01neSmpwXTlZ1VaWraDQa4YF9NhnY90kVbdtiKNyRad6D/VnhzJTZca3oy9qABhDuhW1LKI6jUtRMtJgLl4UbjMxjg6bqH46y36hVZ6iO70pEWBKIyO6qFfo7Y5Sn/BNYncha0uzlN0gER61qJtSGgbTh0OMDlgAaMXtsAwiEr/dPIgAM3pcapCxPGA1Hth/gIGI9rPZ548+Xs+vqBjCVf2JcM+0+2KhXQak2GfPjHxBEoCoj+wDpotLdY+EapkPIecKdc9nAJ6ueQ/hVuOTkP3cx4Os/RjjJdzQmjR0TI8b18aPn6TUy9PSJkygDjMFIzhGQyBGsG1gfu3bVIbz4DJvXCWoZp1EtFEPG7xTePGpEMzqE8X2IUpf3gk4RJr1+0HJGXXnxHI06hHUjv55vtGbLRARzZ+hOZx0W0aEo6QgOajawgwwTjSZDC4Vd19Nck0ENsBUwP8mTF2otBHnTSQbZPl52YA4ONazKN6G0RyxHUThYamnwXaD4dWJkyVn1d25gjL36EhxTfAFW49XtC45Ptv6Mpv3Ho39nRvAz3M6rCukOpQx1/1R7fEwBw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d302bbe-86b7-4f71-a62b-08d83aab890e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 08:26:08.9180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLFa4M08wzfV33z4Rum5XCNQNU1262zFXk1bLH0RlhleWfhQUqkhU4LvguxRzv43Nlp/6PQtK5dB+hyCPo6TUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3838
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We still have a few iommu issues which need to address, so force raven
as "dgpu" path for the moment.

Will enable IOMMUv2 since the issues are fixed.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 6a250f8fcfb8..66d9f7280fe8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -22,6 +22,7 @@
 
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <asm/processor.h>
 #include "kfd_crat.h"
 #include "kfd_priv.h"
 #include "kfd_topology.h"
@@ -781,6 +782,11 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 		return -ENODATA;
 	}
 
+	/* Raven series will go with the fallback path to use virtual CRAT */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    boot_cpu_data.x86 == 0x17)
+		return -ENODATA;
+
 	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
 	if (!pcrat_image)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index d5e790f046b4..93179c928371 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -116,6 +116,7 @@ static const struct kfd_device_info carrizo_device_info = {
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
+#endif
 
 static const struct kfd_device_info raven_device_info = {
 	.asic_family = CHIP_RAVEN,
@@ -128,13 +129,12 @@ static const struct kfd_device_info raven_device_info = {
 	.num_of_watch_points = 4,
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.supports_cwsr = true,
-	.needs_iommu_device = true,
+	.needs_iommu_device = false,
 	.needs_pci_atomics = true,
 	.num_sdma_engines = 1,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
-#endif
 
 static const struct kfd_device_info hawaii_device_info = {
 	.asic_family = CHIP_HAWAII,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
