Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D53C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC3264F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC3264F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C9E6EB84;
	Wed, 24 Feb 2021 22:22:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057FC6EB84
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ2SprVTlY2AfRpak3ORG6sD1JaA6g0khWj7kIsQG5u+xsRlDcynq25FZIyQmb0OLwoS2yD2jLFxHugiWJo+Dq8DevjSMU/ZCLlbzJmD17ek6ec5e97PxsDsAOQomgBzYd/bifbzgsTc5T0CwaOcDrnE9DAJFWuHgW0277jBa7ePCM0IqbUh14mMe5fBgizmfX3ul+dx/cpxbyPevaJPYoiIAMFRAe2Po64MMu1Z9vqNbE/mw5TVTHPZW4G+gq5ea5VzQnOekQNLCDPLfjQBB76GKmT4eIt/ykDeoFhL08M6+bun66CwlohVnx6/jDJbKHWW1TnsBAAEjEiLHl6Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+xFwlwUvcAaKwv/h/tjiu+sxIQoMlKIUZrlRjVwX/M=;
 b=cgV1RWUkZNseE7tYGUas4hsEGAtai50ZQku+koojpZznF6Zi6/5gG3E55E519dkNnL5eMAdf8bqzMi5OtOvEKfyjMAV7GZ0a6a92IfB0omL9ONhmk6IIf3QOFkWMHLvSF8a0EFh2tYI5ueYk6GRpqbNKt0mEngL02IKfydas7wPmnAnScU5r/O9fK3cRn6imWupmp9HXGwFMYujUdY2g478ZVCi7I8DAQS0g8OmypNGU5Pq7fmhvh2wXYXRNVkC4TM1idMAb7P3P/CGgTj74ydNub4jaVN5s7flsw/8rI8ebe4g80CK31Ua8URojF6U5KfgrB5tYfRxUZL2oxTBf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+xFwlwUvcAaKwv/h/tjiu+sxIQoMlKIUZrlRjVwX/M=;
 b=XKV/134iRssxjUJ5WD0iF/2XEYaxsUL3kdKfoBSnA6TojNcDgR9vOEeJ5kDcRnEPctIeM8zibazkBJfTmhiuPaR2a+q6RCj6X3qy9KKyzZtW6YnIT0GokSEHDfKW8247nX+eKwM2FuDsvlT/d2RNpguFtoRibmNk18ggiaizJHk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:22:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 128/159] drm/amdgpu: Moved gart_size calculation to mc_init
 functions
Date: Wed, 24 Feb 2021 17:18:28 -0500
Message-Id: <20210224221859.3068810-121-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22e3f6a9-6e18-46e9-898a-08d8d91270ef
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503C37903D4FB1E89238ADAF79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3FPVau7wtt4cojZq9ledkFALsYrl1nRFYe51eXzKE4ZxoVNIxFKd97zNPcsanADropLUS8Ws1sM/sPyx0KRP4ZaLYnSz4IcAnKF13iD3xG/F4lgs860EnrYzVIYqmTPpiwTMXAPIjPWiF1R6EwycZwI7zIQOt6o+VssvYiVxReT1zpumBW6jPR8A93L5/ioM5AaDO0nV4Qb33ZR7e0TNUTD8v5L63u51LGcuqII6uoUXVfH6SXjY/MOTwexOINSxS5FxB0yJJayVl6YeDoIwhgII8iC2bbmQlCtMMEzXJlr5S05gf/z/wsrkQEJVhs+4AUJSl0hB0k0hudxcwmKJ1fQwrNNcmy4Bev94HQ3gfl5QQe6yk4fG1cqo8+lN8r9IUkdoSHgBFTOh6RXu9xWKtXMdf+b2SgeDIfW3OteG7p1RLr+4TQ8WTIRBW+JamYpw4KVfQ4w1+BvFHP0yyfRL9HGBi7Irkb7O1Alwnr5/T+jrbjklUVXu+hcwwlrZSKqubnbE1L7kZjBAGbNhgNk5zRDFzwFfa/BQav4KSXNN0F3XwcMRy3cuydYXxybMMp8N4CeTvrMZVhwHoiAiBugCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BrGvsFTBcVg2p54/GOUGrqqeqoNcBad/tEXvCf6PZtWvzIe7IaGbVL4OYz+a?=
 =?us-ascii?Q?rv6dpDN0R+qX385u48o3iItN2745x2zbUTdvtkWfkE2shSZEc7HjQWmh3xc6?=
 =?us-ascii?Q?6qZxxj+TIyIQhnV5k8MfU1cLvVrGwnpUbE5mI4wEip/81cSCgjzqmgYrSW/o?=
 =?us-ascii?Q?jNYhIQIlSl8Sk6MR8B+Aa4ag+k5BilhI+eviXvtzCMZtwKrXLlfomZQEaILv?=
 =?us-ascii?Q?SFcg71OuNKYwgNKtraWUZpVr+fBFkLdsNOCcgXO9lM+5xw+/9lMz5uFcYiFy?=
 =?us-ascii?Q?lAr1SswaJqhSWgZ1ssukyS0b3B1HkDx27URC1V2CHkNOAgwOiqRIuPw3rJbZ?=
 =?us-ascii?Q?NjY1h1kIZr0JJRTb7vUBAX/4uwupIAgga87lnWL1dY3rZxEDYpN6OFIvHn04?=
 =?us-ascii?Q?RrrvS0iecyOZV5Mb1l9GwX3XHcwjOhv6zd1uug44qgo1xPrhBJxWIgQUQQhi?=
 =?us-ascii?Q?s8y+5A4+afFa9eryI0FB5OSFulk+eEP8TyfyKpCstuR9xoPewNVJjLbwXHDk?=
 =?us-ascii?Q?Ij1hkqSk8GJM7Sb9EM7CO8LpI5q+wLkLzvqEd8esPvg21VFxSXXsBZ0Yd9Vu?=
 =?us-ascii?Q?XX8qraFwDvuRsmsbSeGr7LT5O2ymms1TAOVXDNqtp2rZTl+AtDfB4I+8Nwa+?=
 =?us-ascii?Q?6ya+5fiGA5hzufKzsAlYWbPa2Ib88rQK9JGAwP6QZ2rVzwpyFQnAC/WosWCa?=
 =?us-ascii?Q?XqOqIrJUVskPEtw/Qp6NIeZeoYLC5+Hd2IQrppv0ET1hdY0J0pQEE+tCW+/6?=
 =?us-ascii?Q?xPDrcIICxQqpmlHsPpZ1UQ81bsl4do1zIBZc+vdrB4YhrXmGXbLe0jw304zC?=
 =?us-ascii?Q?eOCoe3yTB7dHMXLA7CzJFFUba6SexWLCpdhW1eBwJMvS/yhOmeXEhlEMkcst?=
 =?us-ascii?Q?YyVq9hqa3YH2thPa+HGANzmRgKzB03D275bM/qhfRStSAK1nzYEca+8dsq0S?=
 =?us-ascii?Q?FJCg4SiJ64ZjucPrtcbQhoAjzYH24evwlFnUQlEJ5xGxigSjSOpvuxaRQlmc?=
 =?us-ascii?Q?7URTFez9hLemAU2BPn5XeHwmga/vbFfud4ILp/PwDgI/LkoeTwQL2Uk1lqSl?=
 =?us-ascii?Q?gWr6pATixWwq+k1ferA2SC1btwJ8JWsawErBq+fFvOoCQNWml2todofrAXNB?=
 =?us-ascii?Q?i2kmXEogxb7iAigMwHzl0Xyi2yW4T0xWNqGauKX1GD5O9ZDvAuS0/8ys3re9?=
 =?us-ascii?Q?8IOKYky56vQWuzUrtGO0LCNCbna5h/WaCNj+8dtZGxpSLsc68bhUSVLrr5h2?=
 =?us-ascii?Q?Ag4p6lBbdMnI/bQBEueZ7BiTs/jHrXAeqH3ACwsJQXfSJKaYl7702nOXZ5rh?=
 =?us-ascii?Q?kH0bbd2HGOcOcs0LWpzDBo+h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e3f6a9-6e18-46e9-898a-08d8d91270ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:50.2072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNeDEz8limqmD9aUv9mmBC26aCreCfa1U8kccfuNYyQAHFNv6J27Fz4aFmc9qbuY+h4UL2ll+RFwrJs23iLbUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Christian Konig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

In amdgpu_gmc_gart_location function, gart_size is adjusted
by a smu_prv_buffer_size. This logic shouldn't belong to
this function. Move the logic to the mc_init functions

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Christian Konig <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 2 ++
 5 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 8cb4230084f9..ab1c2b85695d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -180,8 +180,6 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
 	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
 
-	mc->gart_size += adev->pm.smu_prv_buffer_size;
-
 	/* VCE doesn't like it when BOs cross a 4GB segment, so align
 	 * the GART base on a 4GB boundary as well.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index f5b69484c45a..405d6ad09022 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -346,6 +346,7 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 	}
 
+	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
 	gmc_v6_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index dee2b34effb6..210ada2289ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -414,6 +414,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 	}
 
+	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
 	gmc_v7_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 2d832fc23119..c1bd190841f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -599,6 +599,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 	}
 
+	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
 	gmc_v8_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e7efae0f98ca..563a8bc478c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1344,6 +1344,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 	}
 
+	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+
 	gmc_v9_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
