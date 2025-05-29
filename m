Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C46C5B554
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499CA10E776;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zgT6Om25";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 070DE10E76E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6INCJ4KS/wpaeokCbbnhFdKUxwK8B6RRDcO8eGtro9997m3ZZLqh0UshxvHlW1DzK28v3dXh0AqE1b/KEbVm5REC/M4ma8sTc3ItmfbFlpUR7EY1UTktqXqDaePQeIe6k3l0xF2Xo91kB9aSOClh/FxK+l8kIq+nIhyM+pxWeh1iH3O1IIq9cx0Qh+n5MHYrCq8O2n8/u0x2f2DQeJdqbRjP1rj5dyNIOIv5yNc2Qe2bL+RIw7Yr4OBP8mjwmFXpOs0haXB18+YYD1znqJ8OMwJreQraXOF7aOGMd22Z/dP6qHIrRurPzdxmdiuvqFbDXCsDk09DjH1JWUD7tXn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kX+cMqSjvyVkH1larurs5v2ktSlAmFaVaGmCJLagtpA=;
 b=kLdr02fJ4p1owlZanD7SUwsdLPTlypKnUhyKHPSj97l5k/8c6A0LsuzWWdxwRM+uqJpFcrYi7VJF2/18mv6A91BDca+j++41lgvbCr6SFq1+1Aawt1/wgc18H1+xEKFntDPl9BmgQtdxalJPHvEZdWh3ctfC6nphrM+CCH/ZsviYBLaRfqtWAQICDyftTs2R3aBlzNZFj+acxlLvcfP8L6w3EtWssfk+Qbqz3NnwJ65j2ae6Hv35MpMwnpLWWgi6vHlViMxcB62pyArBD6AEpBQMZ2uvvVDz0N/Fg/3i4/D/nm87a/fAUbdrjae/h+BqQhbO7ikpTuXIDradcH53Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kX+cMqSjvyVkH1larurs5v2ktSlAmFaVaGmCJLagtpA=;
 b=zgT6Om25IkKSteSt1hWrYz8Npg2IHjvhe9dtde/e8kj3+dG+XrWlf0sexrcPe8hQ8FtbHzezBYiA9tiAMCrDO9p87/CiUUqdLSD89szFRmGW0IwhU/ZrjN0/C6VHE36DX5l1k+ZzIwLV8qX+MIgE5J1pAD7LnLam9jgCi314gHg=
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 20:08:33 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::aa) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Thu,
 29 May 2025 20:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/28] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:51 -0400
Message-ID: <20250529200758.6326-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8b7397-b651-4ea2-16e6-08dd9eec9667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TGR7WMUw4JIrL7Y1M5Lj944yGEr133ntT9miolZlEbIR/h1TFvJYZc/G91oL?=
 =?us-ascii?Q?1mYYyiCWZkTSSN2l6rGk8AB3YS5Iwv5vpxGQ11LAs85Dtgh7TRmho7R51IMQ?=
 =?us-ascii?Q?DoLruYnYjkbujFqG30zfnHd/hHVQN2wtybABPQPOXOfRRN2Yc5dYwSFvEwdm?=
 =?us-ascii?Q?LGsWjW+u217pGL1GjCjw143wdHS7CKHUdZw4kn5hFq3fjuVXtYouHCptAoHm?=
 =?us-ascii?Q?A/bGVAKzLmt6yY2Bi1MvEuWoBjyk75vIWp//crkam4hieGkp/oaQ25n6N8yH?=
 =?us-ascii?Q?+fAATjYQqIVs3kMIKkpS4vsNWQ2DeLmgTt59T+ViKnOtAraK+nwfpE/u/AFj?=
 =?us-ascii?Q?Idsj2K59XEJhQcwpRc5Vy9xrLqkb7zcT5ebS7Clt9mpnPrnkEVoA3Q4YrbrZ?=
 =?us-ascii?Q?9ifpY3Womcdm95hlzV2Vom25xNlnZu0DbjsMRgAej0kcO+Di8LBlqjQGhP81?=
 =?us-ascii?Q?qUvsYN2kLEjVuBohZW1nkXy3qAHlhL9PEpkED4MS0Ly+s3/VQknF7Bi75yoL?=
 =?us-ascii?Q?U0EscssoSs+NczWA4yCunPDi+X3ydcWm/8Ie3FXphcH8zwG4BT7a9RbV11e0?=
 =?us-ascii?Q?p0geFBux59VpXIreVfOwaAAew5ZNRcBZiGCsJkdKgAHNJMlMtm2coUJqs00Q?=
 =?us-ascii?Q?zBt0vnTwCSZ+IopphkFxleQJhfqQbIQM1oNJKPyEh3piLfILKkq/316B1ftD?=
 =?us-ascii?Q?/PupkSgyp3vaN7oOvIkcFK2lx0UHCvy/2KEnmqnsSih/+1iDeAV5IcQTWoAp?=
 =?us-ascii?Q?lEkpERCdjb4oV/LpV9L9d1Of3kDpts5qcFozBSyBVIT1JYZekU2mCJDSw9sr?=
 =?us-ascii?Q?Ev6CUSvo2A6l38zkyiAt5BDa6DIz/MlDwT3QE0vTfnwDxDX2G1I23S/HNWLe?=
 =?us-ascii?Q?7K/i9t9p+bheTDD49L/5Xz0ei5aTAGvWl03f5uxeZ1inNaBUyukoJVP7BTop?=
 =?us-ascii?Q?uEoykHRG2+HoxL7hNI8dvjfBprOFq00oX+fgwUnDKxDf1FIKjVsRCHho7S3z?=
 =?us-ascii?Q?ldBCQ+XA0vwKvNfxGjNKubzxhQYNS/6rjud6LO69hwU1amHAPcryy+lOxVZC?=
 =?us-ascii?Q?UgadI/KYov3dAaE+YnnwlsIJVco+GvMRg5THdS+I+QRjb5IPvf22XD/GpOKy?=
 =?us-ascii?Q?4vbSQf91icFhhcjCRflff0kJzdeJW1tt/FsAuZRf39HoTccj111Y7MRTHiYj?=
 =?us-ascii?Q?sa7523k693fxiFGSrQ+KxMQFtMin8qkqa94QWb0EnU6EZsKXzxPi4hGq9cDg?=
 =?us-ascii?Q?RfkbVx18sPzqHS9PqyQRgZ8fE4bmmnPMHQQ4PPVqXOOgQZvcp4PEwYxerRBh?=
 =?us-ascii?Q?yJzYN+VbVBk/h+c7qqPBfXKvEA4QV7Hrf4WHbk9mWvb3FCVDb0/mnxnnbJJt?=
 =?us-ascii?Q?qGD66Bjvsnq+55J7Aamd9Z1rKtbCl3F//zPmPUoT6uzfBQlpIiOfTpUpwTzI?=
 =?us-ascii?Q?AjqJWORomrDV85ElIukt/ZIxbzJ9f3b2AwfQuGGQULcIsZ0NidZF8l9/TIVy?=
 =?us-ascii?Q?yUmDwSoliGGx19SyTWElgdTFWa8u9Xu/6idx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:32.8029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8b7397-b651-4ea2-16e6-08dd9eec9667
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index ef5075e111300..986fcfb2ca726 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1150,8 +1150,8 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
-- 
2.49.0

