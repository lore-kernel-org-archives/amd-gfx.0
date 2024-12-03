Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA061E74AC3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 17:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E6110EADE;
	Tue,  3 Dec 2024 17:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5uf6mhAJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622E810EADE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 17:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVUCv9Ukzqc/ELvb7PAIPWg7P2GwVr6XEXBPTPDlqeUCVlCY33zeatu58MQ4L9ijhhRi21RJDgFiliAJ4I1xE+0tzKLPfnzWrDgl+EFupigcG9ZsMim/v99JZdSJVlv/VfVisAzKENtM/Qx/cu49V6IplKWqJjCDVn0IhhXIMTsA7SzAD9+g7LDIuZahA0cbdZPZhg9XYQYP3f/jaAP8+09o3HCZbU7GTsjF9xxET3xnovp2KFsmflyEplAXNaWWotr4vj23OD0LXWP1RpVCtKagh4sLVKvTR7939/HfKD3SQAJFpSipOSQ4FSHG4WFuUoyTdoE6fJKZQD5Oeip8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJfmP1rMXptWzszIQiU3rr+vkBxDsNirlJmYNResD+8=;
 b=yTDSPDGeJRIqyKA5vEtIb8Ydp3mjb4nifHVWpCshVhDNfQodxLGzATsudkpNPdqD3EznF93Yl+Fb9Gj5/ua9JCS+YHDXdP4MEHFyqTIYrp9AfmhuSAg9UgRVfGTdItrVVb080WUzIdKmTzo0MU/v8dI2+HElW7kYgPsacY/7V8Rmu23ig2JmUmXAli/5oNhBK226tDEYoCO27F3l6VlfUKbwKiojQK7yzyx5zO2v63ADh4mSqtokPgC4mOguWi/jFyoMH2CQMAcqkZgt2WtCcgVVMi4/92xVBowtSfde0zoJ2BuO0IDVh6/tN+nd2kvGSp/+8cdvZAxUZ8y3WmC9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJfmP1rMXptWzszIQiU3rr+vkBxDsNirlJmYNResD+8=;
 b=5uf6mhAJsayAHTT9fo/eA+UE7MCrtI9uqIPn1l0vDpG1Kd6I/URvIhTC+ijBGhr3hOn2AZqlXLCVKiPVBPkqkxAdueqQvHvAKYoxAT2CgxsGtlQS2lc2kzzwQrk94toux2my0gHEaMerQn9ZXYB71khUYIgZ9lNJknSUH1xcBFw=
Received: from BYAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:a02:a8::49)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 17:28:22 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a02:a8:cafe::c9) by BYAPR03CA0036.outlook.office365.com
 (2603:10b6:a02:a8::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 17:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Tue, 3 Dec 2024 17:28:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 11:28:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add initial support for sdma444
Date: Tue, 3 Dec 2024 12:28:06 -0500
Message-ID: <20241203172806.2830668-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 4757f9ec-4ab6-4c35-37cf-08dd13bfe29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ju4NFz268In+7U+Ot3TvIdpR4JysZkD56aL8ahmfdzSITnHPo2JmARlRxYQv?=
 =?us-ascii?Q?l1NumogE64/8FhTklkpn7R8n2vXIifqXqCcRzCNuh5x1BnuzCtVa4BjX0hIO?=
 =?us-ascii?Q?S6Sz8fhTNC5Z9pp/wQks/OmeQHhroUc+Ef5JnkqCg8I09BKhcL8N8Yn3j+ET?=
 =?us-ascii?Q?1BDgs6+UE4+czR/N+9sySvN52vEOCEGuxwH33GEzNeHKfjb7WVkdnTZr3sRI?=
 =?us-ascii?Q?G/jE8GxItgHNumSaoMfkrmGEKuXPC9ro7AepHMg1ejdPQ5corariQ53uCDtg?=
 =?us-ascii?Q?CAcxwrASF0PfL2rcSBj+cF8nJPlrrvPYCrYsbwRFlEm4rAXVZxnYSBzRvBWj?=
 =?us-ascii?Q?QjrpdwSUDDOVPGuAvV7EjDmNZAAaM0tP5V8feX9KrnbIO1/JS5xChRis6cRp?=
 =?us-ascii?Q?LJQuL5qsPCjYvUcPjZ+VsIg71fiEzrjN5iKAz5JeFNZGwq2miLF0bVXlH+Dk?=
 =?us-ascii?Q?FtCGKXxayMACRdq3PieAd+3ApqaoFNpLQJTchXJKG5x//vSMZ9H1EbI0faHl?=
 =?us-ascii?Q?3ilei9B9OGWvf7PcKCQORpaW9GGMRBLsdw46A7HFDAuk9ryTzAdz7uWKHPav?=
 =?us-ascii?Q?N6aZ7bUf38b6WSevkypzIgWYTVGF0NYJoL0q3aVqzU6Sjy1m58xNmjI4fC/S?=
 =?us-ascii?Q?t5YO0wKGHyYUIF+gMb3NpjelokrQm0zXfVnXltoFWMmPwGqbfpVAx7oS2t8f?=
 =?us-ascii?Q?5GWpbtQfZcd57qvnW1M4mgrJ+px2sroSVfiGuSqCwfwTdm3TcdoRKCuFQufF?=
 =?us-ascii?Q?UgxCcYNCXrifhAhD1DxTCg8YguGqTvwcIGaE1W43guuJnjzLGj71XRNQs1sJ?=
 =?us-ascii?Q?K07nOBovV+0hSu9HYz1H1WzvNg/0YVGc2QhFYcK5unDLKoaOuJMaktm54og+?=
 =?us-ascii?Q?8qKXm5+GHcfEIAXbdNUq9i34vKmmU+JcxfYHNUwxDrsRDlYHLcj+IH215+AQ?=
 =?us-ascii?Q?nSNUzItR8iNnacr9l/ptM+WO+/O7GIq/lyd9dj7MwNAvvTL7k9glxl0cKOpN?=
 =?us-ascii?Q?4lnc0/Mt9lXxci2gUuKAdjcOyvMZ2uQghppIkjaG7Q7Ir2msQnY4fZehSGK2?=
 =?us-ascii?Q?pE9gsxAZimH9zSyIOpkKLlrn3CTd7teXzM8sMHVtjdvjYJspq4Ji1+B/OhHw?=
 =?us-ascii?Q?aqBvJ5FsOTALHUWetZ0aW5Gs8WO1kDsq6B36g82rWY2KLNaB2x0mTESxp/MA?=
 =?us-ascii?Q?saRwqOgqFmvjaUM/jyHxpJTDzxBoEMEF45TthqoLxtYbVVxup8YVczPbe+Sq?=
 =?us-ascii?Q?qSNIk+r5GOoHNP5IS3GVs9Suuy0PpQroR6vENBFIRa+yqdoy2i+zAhbDonwh?=
 =?us-ascii?Q?UapdvSe2JhmBP3K4o9nyb98FI6uWw5o3kbyB37VTLYnS16esKnBSJA1vcFlL?=
 =?us-ascii?Q?1cfyUIij+tOPq1kTLcbaxSfnEpxiTjkX6Yxf/LJRF7sDAtP/Q9N0yZGZbscu?=
 =?us-ascii?Q?V/fjUf+cFkpNY2Ram3I0btdgPCVZLsSJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 17:28:21.6642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4757f9ec-4ab6-4c35-37cf-08dd13bfe29c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
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

From: Le Ma <le.ma@amd.com>

add sdma444 basic support

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2d0bcd85cb490..57b36cae64546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2241,6 +2241,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(4, 4, 2):
 	case IP_VERSION(4, 4, 5):
+	case IP_VERSION(4, 4, 4):
 		amdgpu_device_ip_block_add(adev, &sdma_v4_4_2_ip_block);
 		break;
 	case IP_VERSION(5, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 113f0d2426187..d9625e9d25960 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -260,6 +260,8 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 					 * groups of SDMAs */
 					if ((amdgpu_ip_version(adev, SDMA0_HWIP, 0) ==
 						IP_VERSION(4, 4, 2) ||
+					     amdgpu_ip_version(adev, SDMA0_HWIP, 0) ==
+						IP_VERSION(4, 4, 4) ||
 					     amdgpu_ip_version(adev, SDMA0_HWIP, 0) ==
 						IP_VERSION(4, 4, 5)) &&
 					    adev->firmware.load_type ==
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index ef6f852d43dde..5e1cb1c2c0f80 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -189,6 +189,7 @@ static int sdma_v4_4_2_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2) ||
+		    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 4) ||
 		    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5)) {
 			ret = amdgpu_sdma_init_microcode(adev, 0, true);
 			break;
@@ -1485,6 +1486,7 @@ static int sdma_v4_4_2_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2) ||
+	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 4) ||
 	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
 	else
-- 
2.47.0

