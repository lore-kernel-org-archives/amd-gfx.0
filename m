Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7200BCD5BA0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 08:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138C710E66C;
	Thu, 13 Nov 2025 08:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ny/QbaTl";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B243110E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 08:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gngbn475WjMYnTWyyykwENlH3K9PIpE4SvbB3FMjl4T9ixxI0eRAsGja/BvkuY/KtaH7ZiMc+BvU0sP8L2UrPK+zppKM+e/Ra0JevEHo1x7WAAhazYOpCsPdnKA8Ge4cZe8qwCJWm6UUeHqmEqXBQe9EEU3aT7vWKbjlyDCAxm4eZ5w7Vad9Xb4+07ifjydlDoP1pAz9rWgSmibPG+ALypb+L2Tbc+J7bRhyorl+bnkd+QPTK/8YfP4RYi+1GjoXvxgmkwx65UHepEJuRuHUrrXEGk4NB5LVEEK/jYM5xo2gJnSt4OMCF0XTjX18jSlmsOIfPoHHz7Dt6RMznx1P3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/+tDOXA90HueTgW3g1iTUXXxHKgoM34I03y8qd4/JE=;
 b=BJ4wJLBOhlvbsxkjSAvob+NbJmiBvZAd+g954nPch0o5i+HrnXzBRocyDFIQnzWoiNYk2VUzI8ff5SyNubXrxK9++P1qbfXxpW/q4W0LELV8lwWsIZh0Oy+VscduDG3F7cWj1/39dIzKvoFsvxJrQERYlemq9ssYErd8Pss9jj58kNznbJimHqUvmfBc35yHSu4khVeWscntm3C7Ob1vhK3VABHfLOcIQ1rtWxsBNZ62EYZwfrOSud0x85aq+N105EmcdGj3Hc+wrBuvLB3hcHa1n8BVMurNDts76g/vBXby9xp48Br3d+K/DMqcGqyshZln232vYgiZSjvq1AKb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/+tDOXA90HueTgW3g1iTUXXxHKgoM34I03y8qd4/JE=;
 b=ny/QbaTlW/rJsKsQZhvCt3cscixmCCGZKJxJmzoxk80Jyv0qpqw1ay/DabV2MxzyaNSLbxJKkinjrfnXXhLPBhPxnQwzLKxRJv+B5g9AShHA9tj0QPaNH1mRzbe3LYG7h/mXpvb/Up1hyc1NoaPg+FrTppBcALcpXA8kUrpOELs=
Received: from SJ0PR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:332::19)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 08:42:56 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::b3) by SJ0PR05CA0074.outlook.office365.com
 (2603:10b6:a03:332::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.5 via Frontend Transport; Thu,
 13 Nov 2025 08:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 08:42:56 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 00:42:53 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fix the issue of missing ras message on sriov
 host
Date: Thu, 13 Nov 2025 16:41:54 +0800
Message-ID: <20251113084154.115932-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113084154.115932-1-YiPeng.Chai@amd.com>
References: <20251113084154.115932-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 48033503-8a33-40a0-1b95-08de2290a494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9aMbKeu2Sjb/ewYqpnE4ty+kevtMbR8wzeoA7df8tIjVfw/q0mcWdlh3KKOQ?=
 =?us-ascii?Q?d7FWitFwkVAEFlcmBB/jNT5IspJqlXcO2gkisJ7B9tKxjnjmczjBfI7wWYjs?=
 =?us-ascii?Q?QiM44PEutzypj7O5ft4yZjRRvQQhbIWUFJ8tbVR6KYr0QLLyW/W1wWDuP3lq?=
 =?us-ascii?Q?hckQ/knU899vKMVop8IzR4eaL8eb6u5HIlBVPXlggAfc71VSUKnwYGHMYH29?=
 =?us-ascii?Q?BJtvo3dBIA9ebkFaQe1LeJJPk2LktjN61kEeJvq8c8xLPY10aWMb3i4wVt3R?=
 =?us-ascii?Q?465OdbRivhoG3YlL1no3V4IPbyxZaPhtQEMzrwlF8XL83u0zinN94VscBjQ+?=
 =?us-ascii?Q?W25zzJOMWys+QwFGV9GM5Ob43dd9apgdj+h+uDFEgXcvqO0/wq7z05uhYaRz?=
 =?us-ascii?Q?HgCpsiZqjr3kWSwSVNA2cWrdX04iB40AABuziOnuYLYQuDkOfd6GE3fpbaHS?=
 =?us-ascii?Q?w1lzitBnaQqO4qWHyMn0rqNF+v+b6q77uHgJpRj5wfnYsPp99ss4Z3wbLMqF?=
 =?us-ascii?Q?/FKpT7CkAKLAjbxP3ThZVyoC2je3wfGA/JIqIZpFVDTZzbNbASymSzMMXApS?=
 =?us-ascii?Q?nTkJEnKZ/osAXrhUAvmiR0nFIeKYW7PxPzGNCYDMYS0D3uYwYd9K7q/QInRj?=
 =?us-ascii?Q?eNBad0sIfy55xc5RUwBg35VSF5GdOcKaV/PtVEV8bhzfSqf2C+uQfWWhBcHu?=
 =?us-ascii?Q?TvdlwwvKtLjVZogu9dhIqg5JuxJSj+p29u5ggm659sk2zGpB1D+0CKS1Wbuv?=
 =?us-ascii?Q?N11t8/NOsSVegcuRLAbmvf5JYgFsK244t+DvmFC+0hXvdP3ptw3VdcjGSh1z?=
 =?us-ascii?Q?C+e+pahejs482gFGP4WWv5r47UAxvQan+Z+vltZc/O9qWBMl2Ve/WuNCwX/y?=
 =?us-ascii?Q?lDE1Pgqd4+pfvAJEnSCSUbGBRmFL7UaFiRehKAO+k6Zu8P704CjGz0U49Zcl?=
 =?us-ascii?Q?rcxNIlNM+g9W94tsrCgXo7j2obsTSc3B1S1Jbn5Ujqe715mfBIvYCPbvEAND?=
 =?us-ascii?Q?0rifkPLFLsAxSsj3jFDcvtIN8f97X4IKSwV4nx73h3ljgvomrBAes1JIhEbq?=
 =?us-ascii?Q?M4LN5+J5yO1Lzon4Unk4CNXvrwYBIoJpRvPag4e6mgUhmvqxx2tWJjQmDskQ?=
 =?us-ascii?Q?pEo+VW4x+gxJQlXjEwEXw4PG/+tmbZi7uQy1xrRWwFItGjF+ouaklv3wCKv6?=
 =?us-ascii?Q?D4pnDL0K3nKPlC68Ll87DUiss4Nn+hjj+LKV7padbR6VCiwPacuEhEfVUl90?=
 =?us-ascii?Q?bVHwG17iGn5T6t+KJLP4BL0UZVsearZl1XEtKiJzoSY7ipJuFHINe2hA5A7w?=
 =?us-ascii?Q?EQqImFdlifCvTOesctWYqjCiUfMffEewWQB2gHN/0iX4dGVo+xxFFNQXtFQH?=
 =?us-ascii?Q?FTGsyIY28u+BfwbxUI4iTReH2SOW7M6flPwIwFdhJGFS4HnsPliFX6aGAN0y?=
 =?us-ascii?Q?4bYuDJ4lcXKhcPJdM5R+y5lutuVFRF2fo1PAv+fH1chfT2n++If5IsvQ7Gp2?=
 =?us-ascii?Q?/WqU6g0RaJG77FuRiLoFQtPY87pdj5y+KHWfawY5EYrrWpa0hkEm96gwSKCH?=
 =?us-ascii?Q?4psTU9e+uFMUCDE598w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:42:56.3645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48033503-8a33-40a0-1b95-08de2290a494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
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

This code only applies to amdgpu processing
poison consumption after uniras is enabled,
but not to sriov.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 ---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    | 10 ++++++++++
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 39d712e3e692..70f5334775a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -36,7 +36,6 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
 #include "amdgpu_reset.h"
-#include "amdgpu_ras_mgr.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -757,20 +756,6 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
 				enum amdgpu_ras_block block, uint16_t pasid,
 				pasid_notify pasid_fn, void *data, uint32_t reset)
 {
-
-	if (amdgpu_uniras_enabled(adev)) {
-		struct ras_ih_info ih_info;
-
-		memset(&ih_info, 0, sizeof(ih_info));
-		ih_info.block = block;
-		ih_info.pasid = pasid;
-		ih_info.reset = reset;
-		ih_info.pasid_fn = pasid_fn;
-		ih_info.data = data;
-		amdgpu_ras_mgr_handle_consumer_interrupt(adev, &ih_info);
-		return;
-	}
-
 	amdgpu_umc_pasid_poison_handler(adev, block, pasid, pasid_fn, data, reset);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f540ee37a4ac..a662758b4f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -24,6 +24,7 @@
 #include <linux/sort.h>
 #include "amdgpu.h"
 #include "umc_v6_7.h"
+#include "amdgpu_ras_mgr.h"
 #define MAX_UMC_POISON_POLLING_TIME_SYNC   20  //ms
 
 #define MAX_UMC_HASH_STRING_SIZE  256
@@ -273,6 +274,15 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 			}
 
 			amdgpu_ras_error_data_fini(&err_data);
+		} else if (amdgpu_uniras_enabled(adev)) {
+			struct ras_ih_info ih_info = {0};
+
+			ih_info.block = block;
+			ih_info.pasid = pasid;
+			ih_info.reset = reset;
+			ih_info.pasid_fn = pasid_fn;
+			ih_info.data = data;
+			amdgpu_ras_mgr_handle_consumer_interrupt(adev, &ih_info);
 		} else {
 			struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 			int ret;
-- 
2.34.1

