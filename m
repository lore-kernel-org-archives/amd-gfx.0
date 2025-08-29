Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0ACCA0FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 14:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD0410EBC9;
	Fri, 29 Aug 2025 14:03:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="27pRE7to";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C2410EBC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 14:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8rxyjwlO6519agTwgvOlHZvfGOI7vCzy9BbDg5XexHnGSvwWrD04CTYqc/pdPOx09EzO/oemXOvQRyq60+/Nmp6A6eWpoi1/d+QbPXPk9dhdDu2eNmeO8E+RA2MzT1EqBLszTs+FXohAyZyTx7KzffyQjM0vjwufHhXYrZlqZal+icF7vNQ8eeuCQ0l3gpRo8UuisENnrCLor5bhsFD3Yd/j1O7yIDRhkAeVd187aglEnmaDIUHMG3xwwYuEQxosTjSxieiZvIYlGrjDVvNOsuKjdquhWi2AYthhDC3lMB+z29IQORKco6hk4PDRbXWtNkGOCW6eJofUDKHnSC+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVf2V/5090SK2/YrdFtrxCDce+pQHKnYArwBjjo6f0c=;
 b=WmtGd37L3rXh0xr2flKXuR9UDFsaPibgLWkJvwIocz+5gSl5itw6XRO2ll7sR6IAOhixbTHWxp++MZjnlGd2TYVBsf9RjU9Wa0CdPgsY5MHB417DXx2NYZo/tUn0DYkxAhN3axeTfdAhirZs7Cw/WEJqrnREZaeUh21F8/Bxs+G4/QU6S4pF/6VsX8zW6V2yiIRUxempGCC4SvEukKsoDSxCc5C1VhG32LH3CSFwInmbYdStWLAvMdPAet/mHrVnUOy2rhBbN8YWMa9loxrK/odKNoQvu58CJTGmhnl37T5Kz8XExHhafrdhblZCp8pokBx2yw91q4/lDemtaiuG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVf2V/5090SK2/YrdFtrxCDce+pQHKnYArwBjjo6f0c=;
 b=27pRE7to0hGXUFwbgziuU0JvqrAhQT48dJFn7yYKuGhctIJ19budhk9P+FMB6lmMXLhvntRrSEhAPZYNcTb6fIqC+/3r/1o3zhqeT+m/Apt9lGcWutCVFO+pQVh44ClsxlcTkFw0H9/iAoCSMmfcmeZwPv36FCFnOLA0agfZmJ8=
Received: from CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::8)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 29 Aug
 2025 14:03:46 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::2) by CH0P221CA0027.outlook.office365.com
 (2603:10b6:610:11d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 14:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 14:03:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 09:03:45 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 07:03:43 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 7/9] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
Date: Fri, 29 Aug 2025 19:25:21 +0530
Message-ID: <20250829135523.4032168-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: 2627929d-69c8-47e2-9cc3-08dde704de8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEhReVpuR0ZBNzQzTDhXTFJhQk9TNklody9mbiszcGpwM0IzWTJoQTFudXdr?=
 =?utf-8?B?cUxLZ3JQT1V1QnpzQTZWSFhOK0xiSG5oSExRRHAxSUZPZFY4WEJ0TkFSYnBz?=
 =?utf-8?B?bkpvVjUrcXhMbkJwQkdIdUMyM25QalYyWFd3ZnFsbXZMVmtiLzZkZWhXbDlh?=
 =?utf-8?B?SUszd2FiTERhandjdk9EQTJPUmplWW9NaFR5RFI2SHl2V2xGenlLOWFjcFBR?=
 =?utf-8?B?QzJ4MjZkOEN2anlSRmVFdXhBN3Q0YzN6RkZFLzFRU1BDZmpTOVREMzFqTWEx?=
 =?utf-8?B?L1RPZVFIZHg5MVhOWWlCMnl4WWN3YXExWDZEcmpQOHNIRHRMcHBIMk9WekZK?=
 =?utf-8?B?YVFJZmxwa2ltVU8wYVloTHZDTE91NUtoNE1lMGFoSThwT0UvQWpONVp6SVlr?=
 =?utf-8?B?SFZhODdiNkJZaG5jTEFUZm9sVGlyM2diVXVBeVZxbUhXZGNqcUc4a0lkVTJ4?=
 =?utf-8?B?SjUweHdwUlV5WisrZ3pVS25UK2htYzNsV3ZjMEwrQnQrSWxsNDVSSHROUjdU?=
 =?utf-8?B?cU54ZS96eCtvSnF0bTdGMDk2TE1aMjVYUFZoR2llNmRLbkhXRFVZMHhVRk5R?=
 =?utf-8?B?Q0E2bUgxV3pYNjN2OU82WGozUlJMSExZUm5EeCtzS2pHd2dTemtMOE1RSzlH?=
 =?utf-8?B?dmRaVURYYlNVMk5QaTF4dzNjWWNHK0dROEZTNkhKVjNZTXQrYzlIMkJ3VGtj?=
 =?utf-8?B?eHBJY2p4UXM5K0I1VVM2WWN6RDN3UTVEU1d3ZlFRNkRXeDFBUnA4NThnbGg3?=
 =?utf-8?B?dE9DU2t6bnZ2bWd1aXFoV0g3akVVMjdzaTN1UzhEL2tpQWJUYXRYaCt3V3FI?=
 =?utf-8?B?TDZ0Z2ZGV2hDN0V5RkNkZHV2dkJlUTQ5MVZ2R3M5TXlRTWp5cjBwendiTnlL?=
 =?utf-8?B?ekpSZnBJYlJsNWF5NzhzOTEvZVJMV3MyN0dvbDROaFd5MlZvTUJseElCbnhs?=
 =?utf-8?B?TG4xVXlneHJkSTVhL2RtTWdNM2NwZThSQmxhNWo4L1lKQm1jdkM5d1ZseG1a?=
 =?utf-8?B?T205WmVJekpvUlFHTUUyUkYzYmMzdDhWRk1HcGd2Qnc3SjJad2FsVHh5OHp1?=
 =?utf-8?B?OXVtRitCZVFtcTd0N2pvQzZxallWWGZ5ZXhTRW1QcGxldC9wVDA1blRmeFV2?=
 =?utf-8?B?R0tyeXU1NU8yNGNMZ1hMWEJQTjd3eVdtWDd1ckxNaUhtRUd6eFlLR3dld1lG?=
 =?utf-8?B?SmdVZW9HSmp5NVIveVl5dkN1MVY1MW51QVpvVjZQY3BCZ21aRDFIRW9JVWJY?=
 =?utf-8?B?d0hTbWZHL2E1NzdiSWg0OE5tM0FJSWZQTXFFQ25YMUNlRGk5Sm1VU2NWUjkr?=
 =?utf-8?B?aUdNQVZmUmFaTXFwZDdkNGFXWFl0R2p2NnVhN0NlRVZIQjMvT1FpVnloUmJr?=
 =?utf-8?B?R1ZicU9rUFdFN01laUZMaGUyK0xyYzgwQWNzTnk1ZFp1a3Z5cVVDSE8wSXZh?=
 =?utf-8?B?elZQNnI3ZzJ0UE93VHJPbWFoYncxM2lGY0poQjFtT0lwY3lIU1h2ck9ZMHlQ?=
 =?utf-8?B?ZjhQY3AxQlBaVmxiVUhsbEppN0svOEVIRTVSQmVDcWpZZHZSKzQ0Um13RGMz?=
 =?utf-8?B?eW9yR0tvSEZwVlRmcUtGalcxdWpnaWxHazI5WjdPRXp2Tk5CTzhOc0l1TkVu?=
 =?utf-8?B?b2pjN3R0MGhMZklydnQyb3QyNlgrN2RuRmVWdzBMR0hnRHI1UVFiVk5VSGl2?=
 =?utf-8?B?a2l2OWZaZktkTFFnekVNK1BVcFNyR2MzcXdGQVlRRlE3WW1rcXZaSGc3WkVJ?=
 =?utf-8?B?MVI1cXRTYVBoTHZFdW9DS3RSdktHOG9ZQ0h3UnZDZWR1elg5K1VXVUsrRDVk?=
 =?utf-8?B?K0hOWUtNOTJLdTNULyt1S0s2dGhXbzVqcWFWOXpURmZTd1dwQm1ndkZkcUZ2?=
 =?utf-8?B?UjJiSFR0MGtwUS9YYThBTXZaT0REVTVFMFNKR2l0dlJIWUl3WHBXTnR1OVpp?=
 =?utf-8?B?ZkhUZUZHMGRVaFBxSDR5clZFVkQ2dTZrNFdmdkVXeXVmeU54eU9GT3hKWmdF?=
 =?utf-8?B?bitueko3a3k5VFdNdmJxOTVCN3ZtTzNxOFp4bTl3U3dEdEFraGdNc2h6RUps?=
 =?utf-8?Q?NpQ/Lw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:03:45.5769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2627929d-69c8-47e2-9cc3-08dde704de8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5f378f5c9350..7305d40a62e7 100644
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

