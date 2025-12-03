Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DFFD12D5C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165CF10E799;
	Wed,  3 Dec 2025 13:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXpfNUa6";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2A910E799
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0Saq2M2lK4Glo7OKM6/4p2xgDGL4COi1ehEaloWz5GPqieIacIjkFTeU/otzrgOpMN5dLW0ihyRFn2ATvbLRjsj7jsEFuw9KTumODncHsEsyslUQyj3KyDS6DIn0iwT5zjUyhoulSkOWN9EyfyNvcxwUt8vFSRw7bBwlMHP7JHVmOQS/7WND7N367wOd1Kfb694iqDCuqOkbzz/JTzwDrI+c4jmlr8A2RXgafvebgUl1Owrvj8sqiWSU0UUXu6qKeVh8xBXlx8LAvbFa33W9W508iYBbO+0UBgkgoAhCCpspp+omONsIBX+U4g7fUUZhQcY4kL/6oKzG7j8qJS47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km0K2LFw5Cp0Q1PSaRHYLPS45oonLqUz7SCp0mP3500=;
 b=TKxrz9tWGgmrhB31XGwUsyI28ftdR+/XO7aouoZXefE5TctPMCEmbErZKl4SU23QaTzKG6kl9f21q6fjOJCXPSVaNDXylcpxMkDqgUonUiDtPDAYW9q2sMU+GFn21eR3gg1FP16OU0TDSxbtHBH4CvRLxpRGj93fnFWR7P6FMc/pxuKRgo6CaxIwVJDScoZJWYNpM4xC3iv6etAMG25JxQu5Cx1oCHFc5ue1+StLaY/JtqqEZsVeKYu+uY/t0YWFh10a7nQ0DSaMLd73VkqPiiUEDfyID1qMwmeJNwvv6rfBI6Qf2L6lqydQZtACUxhMb8BeGeslckJg9eU91+oOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km0K2LFw5Cp0Q1PSaRHYLPS45oonLqUz7SCp0mP3500=;
 b=LXpfNUa6WFIFSJ0cPAp560Iesx1Lz4/FTiY73KRvCz7cvjGQW02kR2Ec75ZvaMYc4G6E6eTP8wpzDaBIqHXUrXHD2cMfyHFDfSEelbstcELE2spqMEkpOOBtXUYYkuZEdZDo7/go9J1Fvj9JVj0RFT39/nFYynUxmVel4npsrlI=
Received: from BN0PR04CA0187.namprd04.prod.outlook.com (2603:10b6:408:e9::12)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 13:05:09 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::21) by BN0PR04CA0187.outlook.office365.com
 (2603:10b6:408:e9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Wed, 3 Dec 2025 13:05:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:08 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:05:06 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 05/10] drm/amdgpu: Add cwsr to device init/fini sequence
Date: Wed, 3 Dec 2025 18:24:56 +0530
Message-ID: <20251203130436.745633-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203130436.745633-1-lijo.lazar@amd.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e936c4-cd68-49f1-0e78-08de326c9641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sy5FiMeb7QbN0qiwqlixmyjmE38afGtk+ufRlKGq4mCoBfACGbrwa+mv4eJ/?=
 =?us-ascii?Q?m28TQLhgscuIBnTO+pvQA4kSbdqKWJZqpv1HaR01qfUHkvoMV2nseJEKPLP1?=
 =?us-ascii?Q?a6DGud7QkfFyWgpjeIPl7eao5kQCsELLoslkvzjhUhmUs2KgVyT6O9EZ6WaH?=
 =?us-ascii?Q?CuVQwrmSCh+SCEDVgOBTD+wGHe0H8P3p9HUmDQ6pbaNu/Yg8EYgH4k0v0dGJ?=
 =?us-ascii?Q?BVeZqRnNodkbPCcxxFMfBt2drFMiYdh1Zki2G0NKE/Og73Ic0U1hGgeybkyo?=
 =?us-ascii?Q?bObjLdz3+kX2EcmtLHx7U7nP3Au/gAm4o7xADNwQdXNFQOtJFhIRAdaZtZ0Y?=
 =?us-ascii?Q?gPdq9N4ITa0p85KB1ZFF7ju4zcISB3xwjRBGXLd0g94wJ5LPhwoCXczlSBBz?=
 =?us-ascii?Q?4WqV+SWClYYu1ZUXBkIZ2CjEcCbOZKniMR7u1HCMRFNCuJGdbl1gn61DEJkC?=
 =?us-ascii?Q?H8kLHEQ7hLgoAv1519eKINW5MzkpXfFdBuE3uBVH13c22yTGT+YBOmWweFMv?=
 =?us-ascii?Q?VpiNAl41lEHM729nvVTdDznDltPIMjHY2IdRs/o+AsW6O0Zj6wsS4XdvHPpZ?=
 =?us-ascii?Q?e6SE/xhpk71lHYtcu/jyaVKz0GrB66cj1DDcGiLTT3cNz0tsWNqv1dazEvJQ?=
 =?us-ascii?Q?zg9e8zDb7DODRsdk+pl3JwUByuKVN6wEQsTvrTdVlocjqGTk+2eAJHUNLDmt?=
 =?us-ascii?Q?ycGfDCKe19SCV0lR92VEHUUazqtnR5l9R5GaTCvcpuV+XD/TTFVb2/+yZcRP?=
 =?us-ascii?Q?GH1Tj4OAqz+PZtGKVNCm79kLTa6I8+EjZDTQfUr5gFDXMeqnjajLl4vlxiQC?=
 =?us-ascii?Q?GgpeeS1LkYDz3KkbVzUXfh+c55NqAKz2y7Eg4lIpFBEzy9mYwSZy1KAOZtJo?=
 =?us-ascii?Q?BJ0xK6CT1GIQ/FV2v+hcbaiz8OS41PvN91JkBTy3qu5TwHr92vkciZjMc9ET?=
 =?us-ascii?Q?srzNk7+ItozOxOfds7JXjuz2dMq6S0h5Va3kVp2zem1K8cRiDlMeTHIYpvAg?=
 =?us-ascii?Q?3Gt48VJPC6GrjUUchu3aHcGHgDRbP+R96Sf3JB8NlOrTNIXNKPeqWtarjFm1?=
 =?us-ascii?Q?0LBcVyBHnyVdcdpCItR8Xfeu9OALW/YvcIKvH6FCCiRRU7rCDNx2h/FAjjQL?=
 =?us-ascii?Q?SfA7DgTZIfahesVDVdN/Ch6VOnZ2mqV3XF99QHXG5HEXt8YqjMtG1/SInCxP?=
 =?us-ascii?Q?6C4LnYg0dTNWJzzWVb+ooSckgVi2jBfkBVvyRpA6bd4K5EE1ilBvEbV3gVAd?=
 =?us-ascii?Q?WvSUNJ/RKUrQSsSNqKZfWEOwCNRe9sFnIgJaT76Rs3q9WwnZcG9+fv5J5Lm6?=
 =?us-ascii?Q?vqHZ5ZClgORwMTJqBBIf7huLvPNnwGBrLCjCewu0uy0856314/dW/fDM1K+m?=
 =?us-ascii?Q?WVaRrWm8moTXJce53DIif1+DBqmFiFMkZFyPkhOKSgz71XKZoy6eVrDn0FIz?=
 =?us-ascii?Q?A/KDdqnNCWemrLpE4HkA8Eg869Mb4stva+/0mZFoGiOI9d7/5JRruGAak6cY?=
 =?us-ascii?Q?+KOdTwos5HE9TAmR+h/+ezh2Kh6hcdC26SPbkPDj0rqkdGC6huWqL/Z4OSqe?=
 =?us-ascii?Q?5C5JMDEM5lqRsU+j4Rs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:09.1432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e936c4-cd68-49f1-0e78-08de326c9641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize cwsr handler related info during device initialization.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a0213a07023..43848e905ae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -77,6 +77,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_cwsr.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -3324,6 +3325,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	r = amdgpu_cper_init(adev);
 
+	if (!r) {
+		r = amdgpu_cwsr_init(adev);
+		if (r == -EOPNOTSUPP)
+			r = 0;
+	}
+
 init_failed:
 
 	return r;
@@ -3713,6 +3720,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_cwsr_fini(adev);
 	amdgpu_cper_fini(adev);
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
-- 
2.49.0

