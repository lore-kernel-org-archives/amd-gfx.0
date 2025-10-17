Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA455CCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 04:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FF810E137;
	Fri, 17 Oct 2025 04:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nxuLmz8L";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56BE10E137
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 04:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uyf3hSTtkQLf7yT5EyRSdMCrTksuZgmJAckekEIHqqkAmb61WyT0NdBlIIeHPln3R3TVNEbtDyTspvJa21Us8y4ugka8BpE3tcF0bJwt/+izAoo40WA9r6giWx8x77tlK8WYEYDtcE2c9ejkOLey9uGuIax3HAuXk9pe+PVATpJl9ojcd96nkC4WRFaDUygnkrosuSwsiF3Xl15YO3YRoxOS7RHbN5Ko+bQVsupPV1r/fLMgbZuwLQ9DW8jDg7fV/u80lfl8vFOKw8e+Wf+2BUl+ums3JLFVIt7Wvd7+zpJVisnPUobDX/MZDlektJJqaULhCe2BrD6KUXMrQhTokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7eoB7Z4I1fXJyoSNTzrPlTyqLhFTjJOOB/1Z0rhpmE=;
 b=BtzdC8HY4fqnWsAEJ1xxsZ0nxykg6MUsZIDotABC6ZQizrov1bFS4R5Tsrf1D4nwaxPs0mfz501jQ7Q7sv0IvPC3f/AQWwOAQ/K/GHhaSNsNGTk02DI+h8yRvVVhFeAd0rsBOpY+0ZCTfsYQwx94uCoe4NTP0GlypehIfPIoykShNvHqZ7S4nzAQULZ1aM4G/1mHtG9EjzRNeimgk62+edE8fYWbZ27aPyfcF+mtLlo7Kybkkfqqhyy/XQWa6Xydx9g4OufNBSa8SnB+3fGQb6EAxjOs+Ynbun/UfTvaikiywAtGQCwtzMRyn0EI/IEwXER5IWzMkEHowoSUpG92fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7eoB7Z4I1fXJyoSNTzrPlTyqLhFTjJOOB/1Z0rhpmE=;
 b=nxuLmz8Lgd7HgENSvgs94OSZNqa8a5hr0InaLFkvhy7t1MbRmiF3Kohd9ZCvZUZ5PSMsVuPy7rRu+ea86oOGWxj79vsWfqEsOfA3oPKA7fYFzcvvS6kpkSfiqgKo7g2YEh0voEzQe6orNvHerC4Vy/5H01LwQtjN+1SS7OycOKY=
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 04:32:31 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::ec) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 04:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 17 Oct 2025 04:32:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 21:32:29 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Remove unused members in amdgpu_mman
Date: Fri, 17 Oct 2025 10:02:09 +0530
Message-ID: <20251017043209.3591423-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e88e73-9d3f-455a-ffb8-08de0d362f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5H2HbgvsSSBa9owy8QAcDeIfbZWH954D7qnID1aplUS6cP8NRIpamCw7H3+U?=
 =?us-ascii?Q?okgIvPBDZ6WlUMI13USibv9IZMAI17ESgPM5TzntvhDnNrF5dW9khRkFhF7H?=
 =?us-ascii?Q?kxBZ/JpCQBmzqhPaTrIZeWjl98PoGBJZy5d2XYNNeLg1w9lMw/oUzYqfm6kR?=
 =?us-ascii?Q?xEyIdABPAm3tm5v+RVCEm9KtdjvINJAQqNJ7qpa7rpbFeTkoggIPGXW4+me/?=
 =?us-ascii?Q?Yx5YQZFLC+b8iYPYrK5VBTO8wERHd1CNEtkzAxi+DqEb0Tyu9NFinJ2v+BUL?=
 =?us-ascii?Q?PC77vMMoe3Qo7ISZYUt6UCExr8zPydhgqXOwcNh0a1KsZTAhdrjJglLTtmP4?=
 =?us-ascii?Q?FEb1KJhx5/Oj76kCTEcyIYGNtB6x6JUzuwcjNqhh+RMQI25j6KD0IqKG3FaR?=
 =?us-ascii?Q?+LCibQNovcdHC6qbfjDuF3FwlzeNZdm1rJNzm920Z48e4c/zJkNTsdcd51i0?=
 =?us-ascii?Q?uGqVYNY0CFqp7ylqKK9EThx8VBzYKPASG3Nqjlc/X7mpmwnbAZR98HFrT2x1?=
 =?us-ascii?Q?MSNYPtVHxmk+l64zgKAN4eUG5quEni77YHnKAkMeLPKMpa6fryMKMsurlRcg?=
 =?us-ascii?Q?AMq7zql735xxPv6TVIjS+nrG+8FEQk25TD1cZ0hCMcdYmhM8sWxozzOrFd2B?=
 =?us-ascii?Q?7LRRE+BcuTm9KPxtnAiIoZAAJNxg8DXfEZQ2W83r2gKeI7FJ2QwIw+jUa1cX?=
 =?us-ascii?Q?YnKFz6yd34xOAiFd8mzaF0pwPNLrc3HfvMX10DwpNCRGMThkhU+1LfeUqDe9?=
 =?us-ascii?Q?PTC65IvB1OUMaY6UMvUMr4PskTZ4bw40y+4z/opDVyM3zHbIXjFGC0Yj6wEq?=
 =?us-ascii?Q?EGm/akLg2cjtwQ1jNnxy8/qktbmy0JLW3JQLupBaNR8rA523D2AIi6uTuNF/?=
 =?us-ascii?Q?l6Ny/H4ld9/e6WTpbytgNxd4AXApfoZyeffF0YAQNEHm0yMTSVpkxE3o8/uz?=
 =?us-ascii?Q?jbGiFWMqRUcrdl5LXtMrSgxcIH/9fxqZb2XgGlomh3p7NDBc+YXe9saU/HXN?=
 =?us-ascii?Q?tOlnLy3vw+7nZsAkbLMj+f0s8OVTmo4LVc0ApSOD2CJ4SHNsaTCXERlYxjc/?=
 =?us-ascii?Q?F+TXpBiB/EKDPMtClSjQFDRu2vcaDHv/DP7zI9Jwx0M0dQ+0hb1EuHItiH0y?=
 =?us-ascii?Q?u7boq1b/HooI6BM8qmNME2MRQgsyNbLE8YNhl0co6Pj3jTg9BWUWGBrLH6I8?=
 =?us-ascii?Q?3nhrlAeDuY/DejUhagjNyDdCtoDyU2DglfbbSChkJF6CNm50rb1WMxuN8JYO?=
 =?us-ascii?Q?CF7ePXWvZ5aVqHUsfRzTVh3PptLGRcQOTJOJTpgucTv1gy0Z+TCCFRJkFiYy?=
 =?us-ascii?Q?NgagvPeqAKJgKEprUlwg0GF3GpmDVsUDDxEFg80+Qa6NQb7CFD8PIOCkMY0Z?=
 =?us-ascii?Q?uGI0SLXhgv/zyPUba2sZ+z+I6mAlUIEgyrsV0X+/JzMVxP0lziqk5P7BVBpJ?=
 =?us-ascii?Q?j9NU3qfgWoJbz1MjZoTWBvTDQHtPMNLsX5OLK9BNwURer4oq2lqGiF17ubiK?=
 =?us-ascii?Q?lNfI/s9Bva1y80k3lQSnN63fRp0m9bDMY/y1IasjS6N+gPCYypwJelVK9aQu?=
 =?us-ascii?Q?jE/EVe5OmL0T5+5VPZM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:32:30.8091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e88e73-9d3f-455a-ffb8-08de0d362f70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
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

Discovery related members are now part of amdgpu_discovery_info.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index aaa3d8c7172b..054d48823d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -83,9 +83,6 @@ struct amdgpu_mman {
 	uint64_t		stolen_reserved_offset;
 	uint64_t		stolen_reserved_size;
 
-	/* discovery */
-	uint8_t				*discovery_bin;
-	uint32_t			discovery_tmr_size;
 	/* fw reserved memory */
 	struct amdgpu_bo		*fw_reserved_memory;
 	struct amdgpu_bo		*fw_reserved_memory_extend;
-- 
2.49.0

