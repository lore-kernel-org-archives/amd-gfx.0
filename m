Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80B2C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB1F10E94B;
	Thu, 28 Aug 2025 09:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FhocJxXo";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BB610E94B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSMsSLrHqd04lpIFWfZ0xcgPZaJ5sbMHR0K7WKdkQQBkzK84wuja+w8k2hHLmOMjoDQ3wOk8qiKjzuJBkQwKHJt7/8bdotIEqIAWPGJ0HFAFeGi5JtFRTiSqNXxmv3PJrpelqm5Lv8Jc/Ea03UkuoAFZe7YCyet0xCGQtuBD/99W270EzdFpP4XQTQX5YcWTu4YplzdpRsLqUyEBS/+1m8PR9DbEHuPyTMkR6NafKQ5u5LtkSaz36uSwvb24z0kWvzf4RQgTiGgvUraadFPnLDGULgfvVdGT5tOxoZnNPxQUbmMeHpupcrq98UnW88nNbUyUc5j6S3GIJ7b1AxXM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HgSfy1skhkgD1/iXYbPFJPrETgbNK2EKC2qgj80XxE=;
 b=KqzQcNHTrVKA7rm9JRvvcmpf741GAOQ590sLh797NUqWwu57BsICvjUQn9uHocCceAyWc3rPpxYIU940RtB8RmGZFmk7zu4sQqCz96tfvgOOdEN9CZK3cfC22KJGDaFl1Cwvg6/jO4o3BKMauZkvB0exebgkg1ccv/Qr0ivsXU61QklaAKx+tSDg57p78SMqhHH+rQsnFfDrYcK1pI6+mrjtC7YfBQ2lx6v7K1M0loos1aPMJSA5p2gFcceeYW7uO6WtwtFJ6m9+0SDLiYsUvpMKyhXjdY5dTRbgWvDbzG85GnKQ1pbRLddoXtCcpye2bxlYC/BA8mbHIsCfIGqUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HgSfy1skhkgD1/iXYbPFJPrETgbNK2EKC2qgj80XxE=;
 b=FhocJxXoYp9UOi+o+w8VcZ6FpFf+8iYW7MTDDrmhUWWH/pcqE0LfCzhDIPuqJ4iXNR2vZawZ3taOhJoxYbGMpaDqjuKWlV9Itw8QCS4PowXqQR+vqRRDUqGyngeE+019iSOw+kFXxIS3Qudr4VjK1QCDSuK4NVyAwdFcpRtAYfY=
Received: from CH5P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::11)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 09:16:29 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::54) by CH5P221CA0020.outlook.office365.com
 (2603:10b6:610:1f2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Thu,
 28 Aug 2025 09:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:16:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:22:02 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:22:01 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 7/9] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
Date: Thu, 28 Aug 2025 12:43:33 +0530
Message-ID: <20250828071335.3948819-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 029ecc1e-e4c7-47ec-800c-08dde61392aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTAvVjEyTDNod0xFWGlCWnpQMW1uNjcvckJlN3JBN2dMN2p1dWNKMmwyWW5C?=
 =?utf-8?B?ZkFuZS9vYytOMjhzYmxDdzF0UGlOeXhMOUtLQzBVQVhOTVhuNkNZa1hhMGF3?=
 =?utf-8?B?SzVQRWwvWitSTEoyUkw1b1NBZGQxQlJTMXgyM1ZSSk9HcFlCZmlaSUNLeEtq?=
 =?utf-8?B?WHJGdVBPUm5xeXk5MHJtNFhhZTFnbktnVTBKTFFyaUJTRUZTK2lsMEF4eGVX?=
 =?utf-8?B?Z2JNQWQ0cVhUT1hvMXEwNEJFK1cxR0hqNi9TWGZSQUdQL080UGFEOXZvRUlH?=
 =?utf-8?B?WllVZmkrR3VMS1psQ05wTmtWZ0xGTVU5MS9tNVFZWUxGTEZkdlVUYmJVdzdU?=
 =?utf-8?B?L0pZa0NQK0VWRjhjVnZGWlVpSnFpOWgyaU1WWGozUS9KeThCYjArRTdLUnY2?=
 =?utf-8?B?SlhtOCtUREVQODNhSVkvVkMwcFZwa3NXZmRBeU8vSjFPbUF3YjhOdjRjeURJ?=
 =?utf-8?B?R1lvelBXdk5hRmljSFVJQUVPR1lPMFh6Sk96R1dBcVVSdkZUM2ZLODFrN09P?=
 =?utf-8?B?djV5MGV4UCtPVXdXTGM4TWUvUlpMK3gwbFltWDlqcGVaVG0xYThNbC95azBC?=
 =?utf-8?B?OGx4aCtQcTZpTW9rblpkVlF1c1N6OWNhb25KWGQ3bC9WNEhIdVhvdWQxTnBt?=
 =?utf-8?B?cUlWSTJoOUdBenJySW01WnFSRElLd3RTNVlEYSt1UjdtSkJXSU5oelFpd3gv?=
 =?utf-8?B?M1RqWXZmRzJ3MUM5VDgzSkdTbjZoT1YxbXpEdzNVNkxYVlV2R0Q5cjhOZGkv?=
 =?utf-8?B?aDBkV1NBNmRvZ1poZVVsSkFsWDk0czA3OWJhR3BONDE5NDZsT1d3OThScGVZ?=
 =?utf-8?B?eTFieU10R29LN3dDZHlFbWJmaWFnSVIxZjN6dk5Nb3ovM0pqd04xMGMzUFFu?=
 =?utf-8?B?VTI5T3RoSlBGdE5Na2hXSjNxeDBYc2Q2YXRua0xYY3FLeVNoZ2Y0ZitoNFh6?=
 =?utf-8?B?SlNUN0lzL0dldklFWEI5OENwWjYvOUJXMGd5SzJuWWp4YkhRZzVQU2tlSFg4?=
 =?utf-8?B?eGhKcXR5blFGdlVrVzYwVCtHUkcrTHhjclB3MUdXMnNpbWtpRlduMEZFaElT?=
 =?utf-8?B?Y1pldXFQSDZFU1RBVFZudXVOZGpsM09Va2g5OUE0MzRwVmlZMHh4RXJQSGlC?=
 =?utf-8?B?cGxyWHlpa3VtZHh0bjY4UXJOb1QvRVBlZnZQQmNmdUdIY0FoVlRpZzA4ZytT?=
 =?utf-8?B?aXV2aHFlRVpOazl3OW5OcmtrdUQzMWpLMGRSNXlrYWxkZFpFeGlHd0p3eHVK?=
 =?utf-8?B?QW56SlZXMHVQZzZwVnJ3eXRhU2NwMnFBRmZwWWYzYzdvbUlicTFMVGI5enRF?=
 =?utf-8?B?R1VtcXNHUmRsUndtMlF2M1BhVDNQazNJeklZcnFNNG1tVG80ekJXRmNNbVNI?=
 =?utf-8?B?N2VGWHVmSzNGWldVWHJvR3FqTU8xSkhNMjhaUmhkRHMwQ3lPSy9hZU8zUXRS?=
 =?utf-8?B?SG9sTENBeHdkYWVUL1MrQ0wzeCs2RkQydDRsTGVsemNsTXR0cnhFUVAxYzhS?=
 =?utf-8?B?M0tVQTlpN3lLU3ZzdzIyeHNmY2ZIdlU4YWV6MUM3RWdwRE9sZXkwaW5vc2JI?=
 =?utf-8?B?bXdUcXlicm1uR2J1ejRYeDhqc0lyYVAyQ09qRWErOER0Y0xFcjZRR1lCamtn?=
 =?utf-8?B?OFNRaXRzS0l6UGRzbU5xa2hua3pRMTR0K1NBR2NyTHlDNlRpTE10WEVISkVI?=
 =?utf-8?B?cWNvdnhLUkJwdEpWMDdLbkJ0dm1tU2JzRjBYSjRUT0JXdHp1bmtGakkzUWtQ?=
 =?utf-8?B?Rkh2Y3NCc3p6UmR1L216ZnVqQUVHZjdyUm8raXRSRHVNVlZMdnh5cEppSDZH?=
 =?utf-8?B?cGQvUVVmazZzNnpxbjRSUTdYK3pmYVZUWXFZQkIyRyszTGVJZGlEMWc5bndO?=
 =?utf-8?B?U3FDNm5NRktRREhlRVNWNUtGWng4T3dHU05jdXpBUmx6K0FUY3lMTkIxTjdG?=
 =?utf-8?B?QjFTODFLZWVsNTBnak1HSnpydEFQa0VtSjd6dUpTbjlDdTA1UTJ4TVBoTngr?=
 =?utf-8?B?dVJ5SXFBQ29XODN6OHYzR2xwQnE2T3ladFd1RUtVYWV0YzR3cWkxODlPbi9z?=
 =?utf-8?Q?D2SYme?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:16:29.5311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 029ecc1e-e4c7-47ec-800c-08dde61392aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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

Add a one-page TTM range manager for AMDGPU_PL_MMIO_REMAP via
amdgpu_ttm_init_on_chip(). This only registers the placement with TTM;
no BO is allocated in this patch.

The singleton 4K remap BO is created and freed in the following patch.

This split follows to separate heap bring-up from BO allocation.

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9211d250fcfb..7822d8969c9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2020,6 +2020,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Initialize MMIO-remap pool (single page 4K) */
+	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_MMIO_REMAP, 1);
+	if (r) {
+		dev_err(adev->dev, "Failed initializing MMIO-remap heap.\n");
+		return r;
+	}
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
@@ -2082,6 +2089,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
+
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
@@ -2103,6 +2111,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	dev_info(adev->dev, "amdgpu: ttm finalized\n");
-- 
2.34.1

