Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5CFC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 16:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED9D10E7EF;
	Wed, 30 Apr 2025 16:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C9e92mLO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2105110E7EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 16:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNGlYNxixi6WJLVL2sTNL4CYkddXIzu35w2um3FsTfyPyA4m6Ri2Mzd46nXbWRED9B4FWXN1Tdr6Zy6butvcNojM7DuqfwrolojMGazM777NU+Xl58DT0m7ezMNEtK1NgCjTv2ILeZXZVy6VFZ4vB+2s03NRrx4zPPAN0cyaWZrV3z1o9YJme5NWrB4SIYbBhVvSguPCtzfpkosYp3thTHhMGy0OmuiWBgE/1jODnWElggHJdecZatMOwkqN5MIZ29kepCBZRkJM/Fn+Osr7buVdRwUA0nv/BjhMFCz3qRc7/hEjb5PSA/VqKvWWwya3Lif1wRAUt1HhJskDSJd5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7d+M4HqEqhhWcykQLuvqLzLDn6PtOSCAan9mZ61ZwYk=;
 b=wwZ5lKE6trkTb1Is8MUmJhAYiEpyqveZq6Mz5U5F1r9vZ5BiLcR8xQQCUcOKRsRMsT1NSsAPRnPH/nhYzqwY2BUTN28dQJlrYPjLazN4S6gFj2wx1pdDE7xyA+Vc+oeezRPkQpmJ2Z0vXinpLx9aPNFrt0jb6qSeMhBJp2KWWJRPpIG74F0jmFK6aQvF96JArvWs3svvFKcgIkvhDiDxrOdWO1d9yU9fOIJ1aW4wsnnvNduMRUD/SFAlPQC7JAn+NWSc3QVef+/FVLPIep3TNiDLQQWl+FEYpTguBfPKAWyLvZCDUn9oopDOig2qIrzQVKvVmKFIyuBxVbmGF8NwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d+M4HqEqhhWcykQLuvqLzLDn6PtOSCAan9mZ61ZwYk=;
 b=C9e92mLOTvraliYTImlWOGRTS6bO11neeu6A0xiIYlMfwREyzMAkRWyBjsJ9LLr19jGnLZTyFAb7fJKUB1YVx0tjHKe6epPIBzoz/2q1DpDibmYz7ly3rVf6CnYj/by7Znnn/TIzELA8bnh2w7680fRd2o6SBChkEEgkNVM712E=
Received: from BL1PR13CA0076.namprd13.prod.outlook.com (2603:10b6:208:2b8::21)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 16:05:47 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::6c) by BL1PR13CA0076.outlook.office365.com
 (2603:10b6:208:2b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Wed,
 30 Apr 2025 16:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.2 via Frontend Transport; Wed, 30 Apr 2025 16:05:46 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Apr 2025 11:05:44 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: only keep most recent fence for each
 context
Date: Wed, 30 Apr 2025 21:35:21 +0530
Message-ID: <20250430160521.35670-2-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430160521.35670-1-Arvind.Yadav@amd.com>
References: <20250430160521.35670-1-Arvind.Yadav@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4587b3-d2e8-4cc3-35a7-08dd8800de64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pq9QR2blH5lT/6LmnhWjpolK/CSDTwnbgvmh7ypY/oM9cYpc0RzPR+slAp7f?=
 =?us-ascii?Q?mf01zKoUG2A3g29qVooxHuN8NGaxbGNr3mnRxLDegKcQWHndzgQykkL9XHkn?=
 =?us-ascii?Q?OpN9YProN350i8mFJlo5KTItvPJlz3mE834qCcTqsqdt2MRYD1u+IiNoZ7zd?=
 =?us-ascii?Q?B/VkD85NrUG8N9OVq2gLlx+WkGt4yD9pYKg3DKdwEZ/ocAED5JclF78/LJdo?=
 =?us-ascii?Q?wpcqf9w+5vxsB5p4oV9vxIeoCxm0I07W50oRE3+sHsvrazELDCGgScLzWo8o?=
 =?us-ascii?Q?dPNt2muERAuBcLhpHRyYKUyzske1p3iiLt7BVuGnyyoeiP/2oLXGF+SWnEUM?=
 =?us-ascii?Q?IEixowy32aKtZHYuE/OyoCsT3kPWbnaVK/LI9B5T9rbZPRPls8Kf8vVLn5iy?=
 =?us-ascii?Q?xG5CkCietcd6ca1Vs53kVr6dpalKXOTml2eLSQ1prZtKyo7mozwYA8hxRgIB?=
 =?us-ascii?Q?5wcd/jA5nGd8YFYufIgY942mo81io6Zn9hP7ErbHnPOKvvAQ3/uiQLzDZEOg?=
 =?us-ascii?Q?ouBOipT79FstMkRmgP6SnrRWMk9UNK6MAI9yTI57uWGmDRa6UPjMrC/nNEpz?=
 =?us-ascii?Q?TQgL4RrHle/a8OUqAS9ZcXZGUerPNYs6bJXefnRM4P3Iwj2/tfuKbiFX0aky?=
 =?us-ascii?Q?Zwi0aBcM6/GB847KzmkNMYog/CIyhglqu3trKFpjD1b1nnxMyl80QHclaRto?=
 =?us-ascii?Q?Jj79a7kZPGoEfiR5lELV50i3nfQ+lx1h1TFyOjeoo7gzZXTesxlm5/ElEIuu?=
 =?us-ascii?Q?Dku8WRkVkOAK8DvODuLG4+azxz9vhTQ9Wc/UZHRBncHsJ+g2zyiQDfOlYBPB?=
 =?us-ascii?Q?D9TlqGsg+MGEw2C9D4qR3HWhnVzVjj96Dk8yNlCQSfz8JulSLNOuWf3heVLd?=
 =?us-ascii?Q?k1mzotlNmoqukfkd+DbMwYkOGvVSa+5qccFNJl2wXwtZBm4KpfvAqfMTCCf1?=
 =?us-ascii?Q?L68n8Lihqdw3JDAFtA7I3eBDSezuUfuq3GxtHYLDqhNkEkY9yfwEtovCfUT8?=
 =?us-ascii?Q?SldjNRvTfhJqPiQ4Kh0X4iix46CZMYaHmio7AlWSj/yJevA4C4ysiE9N2mOr?=
 =?us-ascii?Q?CtYK3nr+gyAgqYFTcidTisSlOct7/L6UAU/R55XhMB1jFiPJyWd3BxQRZV04?=
 =?us-ascii?Q?oriFivpsssNzqy2PW9b+3A882Bsn1VCtgwiDiKbRPzBn3TGoXQv14y4JoSL9?=
 =?us-ascii?Q?KnO4mOj5ebdnq33r0HIbt6sMoja0dDY6NAPu4hKGVPR3XJPNdFfUhRGZ/+fS?=
 =?us-ascii?Q?Bpb+9SV4s0fSXdgDUO1AnUpC8Jup64g0FsNWDo8WnuCwX1ZVO1kkpoO9v7uQ?=
 =?us-ascii?Q?ThCgOFmXvL3gheRxI+Ymd7CkaoDTfD9n6GVjkXjQU/J+r/VMY3n4p5k/BB//?=
 =?us-ascii?Q?uYo37M1RlvZDZTKsLfa9PMTjU3KKYCj8pmFhy2EBmK7tzF//y6r9nSqRRNI6?=
 =?us-ascii?Q?O6fsKrmet3W4+LJDAcLZh7gBdcViRiGfHa8KRjXdsYy6VEZDYV+KpucPXbYC?=
 =?us-ascii?Q?P97jNiYpg7BcvZbLBEmQ9pI4U5L+WSo8BUxY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 16:05:46.8541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4587b3-d2e8-4cc3-35a7-08dd8800de64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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

Mesa passes shared bo, fence syncobj to userq_ioctl.
There can be duplicates here or some fences that are old.
This patch is remove duplicates fence and only keep the most
recent fence for each context.

v2: - Export this code from dma-fence-unwrap.c(by Christian).
v3: - To split this in a dma_buf patch and amd userq patch(by Sunil).
    - No need to add a new function just re-use existing(by Christian).
v4: Export dma_fence_dedub_array function and used it(by Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3288c2ff692e..e3e4aeee1356 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -851,6 +851,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			fences[num_fences++] = fence;
 		}
 
+		/*
+		 * Remove duplicates fence and only keep the most recent fence for
+		 * each context.
+		 */
+		num_fences = dma_fence_dedup_array(fences, num_fences);
+
 		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
 		if (!waitq)
 			goto free_fences;
-- 
2.34.1

