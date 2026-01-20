Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23843D2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 06:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE95710E256;
	Tue, 20 Jan 2026 06:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hBw3zFbU";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B281F10E256
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 06:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSrDVOReW0xFarUI5kDSAGRr3TuVaTarI6k+dVOUZmcp8kdB65f0iCggyhO9G9WNWwhJE6HiPc7yX5zgnkfLYykZnE31oJhoh3/Y4xUMoizr71vRbPWYoy4Hvdh5MZ44M3u131xFbyVMkxqwTQre3cFWocTc+dxw+FZQJII6Y5tXlOyoaML89o0R2bM7SLhH8gxkbtMiuOYSmia93L8x508Zwu4NB2iuSr9ecSiohstYSaik7twDUQvO0xpR3aFyzw3BqZhriE2MBk19NMWb9A1QjM+ZYqhUBlLhbNmx0QTu1GX9e7MpHNQelFIBIrnrJU5TMc0dIUOYXLxoRzkmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3Dt2B02JcYaLcJv6n7FVB28FndVBCKV/GrXwMAUq5M=;
 b=cYu6epofyAW0N1oKf9F7h9cXZa9TBN/KqtQP4sR8MhwE9uVO8jxHeqitlke/WLCVf3V5F9sFmOEUbHK60k1prlUvc9u+dClTVJclx9sX7ioLM/0RxDiDRB2CXQpve8hw8y2vBExb/YbAoma5YHjkanKHoZkv2dh/Ikx8zGOfQCwMJpNKDL4OgUIE1HSVfzw4k+cExso570L/Soi+Qoqe0AFPAi0Ts9I87jSYF4QyUdxDb6v5mF3CzyDhgQBvLECKSKCDrhsmhJIrZL6otjiP6vYNjUZEPisILyWP0JdIj1FHtCA61tHRSlpfX5M48yKK/dC0HfCtzKeKtad5GVEv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3Dt2B02JcYaLcJv6n7FVB28FndVBCKV/GrXwMAUq5M=;
 b=hBw3zFbUkA9kzRRgrlsiYcuqdrcodwD9dhA/2/icd3X9DiDuZKqxvOULzMysKJV7tu6iH1kKnIooI8iXcK2b1IvzvwvKOCU2AGItkmU6hwIGL6HaUoT0jAb9LyvJPrCKCsUdNRFMW9qn6zev/vITCkoRQt+JSU/KiWZNffTaP5k=
Received: from CY8PR10CA0037.namprd10.prod.outlook.com (2603:10b6:930:4b::9)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:14:30 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::b0) by CY8PR10CA0037.outlook.office365.com
 (2603:10b6:930:4b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Tue,
 20 Jan 2026 06:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:14:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:14:28 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 3/7] drm/amd/pm: Remove unused logic in SMUv14.0.2
Date: Tue, 20 Jan 2026 11:42:20 +0530
Message-ID: <20260120061402.1287680-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120061402.1287680-1-lijo.lazar@amd.com>
References: <20260120061402.1287680-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8ad54e-d8bc-46d8-6d4b-08de57eb2c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3pxxLaQB2KPZW4xj0FloFlS7idP0/dzmvxUy5fG1ItXbL+HPmwdCvh838PlN?=
 =?us-ascii?Q?iQG/B3DBJHWgKkBHMd0n9z9PCd20sAerc4TCjFfW3hiv5Yb/gpTO36ediMVQ?=
 =?us-ascii?Q?dXUb32ade2ZI7S5XqRTNFzEvcq6byzr1FMlzlfGpGyXxMvNJbFcEWy6vaPxq?=
 =?us-ascii?Q?mz+AdRX/DUHeok7bnKfek8OLf1jga556bFEs/MTBlU9nw7v6Onc7kuEPMZoW?=
 =?us-ascii?Q?zVI8Xaf/NLOPyRaDyRUFnR26RK7xWqT2kbTAVZu/dBrgQSetyKQzV/dCoRAi?=
 =?us-ascii?Q?QeITjzJe4sapNXtSUpTypmSZcprG6aIWVj43YtmoW6NgY2HpkUtjK77aVyfF?=
 =?us-ascii?Q?Q3xBuE56Px+2utZf4ABdq7Y/zaQJQTM9Ip4kWKYj1+IXiaOrBzBWToj79YNL?=
 =?us-ascii?Q?K9trQrxAaSY/kSQMH4kXLOGAS4tlhACiF1dCG6cQo/8R87S4UWtNhMfZhP1H?=
 =?us-ascii?Q?1prVf94wrc0GRMY79OiOJE4/mjBjnSRdWXU6SSOTsqJxcHXZLpahh5dvxyG9?=
 =?us-ascii?Q?AaL6HOW7ajksl+eH0TXQhFWr+SoyCCnL/HbwJtDPZoS1uqJNgbspoGyjeMfM?=
 =?us-ascii?Q?kthbWBHiqZKyRYZBrkWZGAapwS12HdiL1IEg8gLjxnB4ytUucmm347or7Ylb?=
 =?us-ascii?Q?kezB+5pX2UWWRgL+FWumqHcjonEdIo2bZl1aBDvSrMyKLQEXy273Ax8+0/UX?=
 =?us-ascii?Q?ZiiNMLMqq2/q8FAf+sBm4mqgoD/Z6zPaP5FlNANkf4l2qMLZi5TriCKJ2z+m?=
 =?us-ascii?Q?dnb9+WrS2FOX2x+45ejNZlWxlhgQ1dJTwjsf8cqeMcQpQOwzF79qGlfTMJSc?=
 =?us-ascii?Q?N+qdZITuposEEyKfT90qcreQ2R/cwS8X6UZ4laQrogI6KPhSKMjoZgdu6C3l?=
 =?us-ascii?Q?y9LqHhaDm8hPdSvQomx7P8PZ6FSdJdZ49pCN1EQ6tS3BpxFPWW9vr+oYlURX?=
 =?us-ascii?Q?RXmCEU/uuGxQrii0G17ZTAllVy9UlAYVrQpON9JeDCTwtjfb4oCf1WcKW8/o?=
 =?us-ascii?Q?5L6T+aDFtAdGvXQK3ztaFqP6/7YIWFlpOXQf0q6Gg2V61aWejINR6PtTpwH8?=
 =?us-ascii?Q?YgcDPSOTWIwzlIQks2nD9Tawt+7bH1u2fPnB8pMwoHH3NU76LReRG8bsXQyI?=
 =?us-ascii?Q?Bf3rOgSmCBnwm+lDel6QU9SuWcQ5DoctlEuXVXjo3Yl9MPRMD5Uaz3hyOzHq?=
 =?us-ascii?Q?u+lX8dxfpWPBSEVw46TxFfHwgPWC5ViDxi/RTFMTmXEEEljgS7RdZiH2Uo3I?=
 =?us-ascii?Q?Y+NAvXtW4FZXfJ1Kl0HOZrzHzDQBgdiCrlaEpIMywsv9pUxUrNroJYKc5nCj?=
 =?us-ascii?Q?yoZhxMayninCK+gbqowU03QEXt0HSnIiUFsGzTKpbMAI1v3WSwwV+VjcAozd?=
 =?us-ascii?Q?fPsbs+FnIpH5j9Q1WvGMbN+545iWAOFFtlzhPHZA8NE3sHQeV0xpZqXPUR0N?=
 =?us-ascii?Q?yyVAqZ5OxvGNR1GB9crhMHpXdNZer3kdQY9uG/StDtNaxt9OL7/NXJCcLCO6?=
 =?us-ascii?Q?dLHzKiiKDbvWfrRfjBS1zXVWVPda4q9cFtUgI1BYOLPHo/v7ixz5EmWMNRbP?=
 =?us-ascii?Q?6urWoW5rYOSA7mk58cwL5U0z7c/qdJkYz3pD5BrlDNOIufQfQgLpcblBqRST?=
 =?us-ascii?Q?iCDuAJVdfhXCzWFzAFa6/Si6cWezN6yQVmrW1x7lfCJxl7r7o8iYBVTpgo1A?=
 =?us-ascii?Q?Y9C58g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:14:30.3803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8ad54e-d8bc-46d8-6d4b-08de57eb2c42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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

Remove commented and redundant logic in get_allowed_feature_mask
implementation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index faae1da81bd4..d2aa5fabfca4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -268,50 +268,11 @@ static int
 smu_v14_0_2_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
 {
-	struct amdgpu_device *adev = smu->adev;
-	/*u32 smu_version;*/
-
 	if (num > 2)
 		return -EINVAL;
 
 	memset(feature_mask, 0xff, sizeof(uint32_t) * num);
 
-	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_IMU_BIT);
-	}
-#if 0
-	if (!(adev->pg_flags & AMD_PG_SUPPORT_ATHUB) ||
-	    !(adev->pg_flags & AMD_PG_SUPPORT_MMHUB))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_ATHUB_MMHUB_PG_BIT);
-
-	if (!(adev->pm.pp_feature & PP_SOCCLK_DPM_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
-
-	/* PMFW 78.58 contains a critical fix for gfxoff feature */
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if ((smu_version < 0x004e3a00) ||
-	     !(adev->pm.pp_feature & PP_GFXOFF_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFXOFF_BIT);
-
-	if (!(adev->pm.pp_feature & PP_MCLK_DPM_MASK)) {
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_VMEMP_SCALING_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
-	}
-
-	if (!(adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
-
-	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_LINK_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DS_LCLK_BIT);
-	}
-
-	if (!(adev->pm.pp_feature & PP_ULV_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFX_ULV_BIT);
-#endif
-
 	return 0;
 }
 
-- 
2.49.0

