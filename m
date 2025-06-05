Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B86C5B549
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F2910E847;
	Thu,  5 Jun 2025 01:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y+AkYHAa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310E410E9C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzeeD1j2CR410yOzEXlmXw4ULSy2XP49QwQza/1Jw+KkMkbvpnhb5FK1r5hwKZPJ5qlrAwkp9KAgyAI5wS+CZ5Qg/8VuKtew/AMSliG+BMe4Derq+eMJYUipqR5oAve0Rq6AwHulTTGCJBHQcFue2P1bGJq5tZxSJMhJ4Il5gKh8EHrLNZgtQ1qlFqXYeJ9CmHt2/E0yY7Lgjdl6thyAmUXh6GlFwV0IB1m+msmkYf57UAUxT2zvVIbHiyGxBqPeTbr8mKsjXkyGLffrmESw87+dbZ8hAg9mxA9iEdnnSKrpWJYs8l1LZ2NJl3q/aZ4Eqf8Sr5HphLwVOzERSgiVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16VlXFSIeoQ/eIUCVASVePY6fciY3Mfbq5PTemesRDM=;
 b=aE+ELlvPxsiFmGLhGBV8ch1h6/p/VZtyzNnN1itTum2zpBvoFPUugilyiN8JOzNMpUbqvm//vYZP/sCGnn2rJLEU4nlXQ1PivQngtvk+ihyj+1CeABAbs/j6ALu5XiEttsC39WjCim9Uu5foDQm6PKD6Yk678hkdZjJO9Qrr8A3Mrn7Fv84RKlpfKDwqtw18RZ1F1paFDAg+my9qaMLfNIsKphyOUexMVXJSlNQSV6IoPg+KWukBtzH2KilvbcFqB5UX2axhR5LMBKdIDkEchBBpUubw8OH2rhQrTGIeb/lBwEeepMT4+YlsphmWvpYtXiuz2hZqw2HSxK2/D/ounw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16VlXFSIeoQ/eIUCVASVePY6fciY3Mfbq5PTemesRDM=;
 b=Y+AkYHAaRc5X6R/uGaMwb4BO+ddqkLuvUkJnM+n4XGXijb7kemN2VPOWRjU3E3eFd9VFqVhFxauU8pKFEEcOSns91qmpPd4IsxeiNwBivyIlSGeFsIc0FNEoZ3BQREYOEGVYSqrs1iHnV7Y+P9cEqwOqkiU7FhKKRb3N34qxltM=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:36 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::fc) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Thu,
 5 Jun 2025 01:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/31] drm/amdgpu/jpeg5: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:56 -0400
Message-ID: <20250605014602.5915-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: a72b1b43-69f1-4291-a7c2-08dda3d2ce7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SU6vkmrSdHfL7VyKxwH3jjfk5WNY2MBoAvSqHLS7JMIfQgDXyVMhhoFGw6tg?=
 =?us-ascii?Q?GHskI5aruRkef5YttOdyxvfJK0CjtxpbC3wWH5I7nhvgtprm1xZc2aVmcp04?=
 =?us-ascii?Q?zxO7YU7GOcXUDxOpD8w8YYIzw6Zrh5fgDBrhzcDlV0zv7yCWb8apxopj4mSM?=
 =?us-ascii?Q?2acktlbxV9QoayMaiD/vEj5mLWbNeOpli9RhoeHyR2VVReapDcwLAHdK0FSK?=
 =?us-ascii?Q?+TP3/ia+v4dhBpx+5LK/cuVzC8UhngDXrpbeUnuT6OTvPJDmJGV4euKN8iCk?=
 =?us-ascii?Q?8/p7zTvPWj30PwCmSn8Jq9G6CokT5qM/+GEF0hGVCQosNYMtvbRR+BOYjgNq?=
 =?us-ascii?Q?tI/YPyD8/P2kxhE2og1gEsxEgVjqi2Qn9gi0IeGzQYitV/UGgMNl3Fs6pKt5?=
 =?us-ascii?Q?BLdNzHZKeDedJdihjWE9DgygtBwgxNFwr2rfYHaIHUJ/PngXVxNj9zAxjhrv?=
 =?us-ascii?Q?e+b0wafVVRWBn8W+K+MUqxc4ULmzhAG1GpfXMAizwd9WxPhYok5gNigbK0dW?=
 =?us-ascii?Q?agnhaGMCdh9ZUEc3Db0NsoPLojfxlsb2nPBsIV0AZVdNo85dw9u51JXDyowB?=
 =?us-ascii?Q?0xyNzEPVUt4xOJ9Us3LR/WQd+h5ZL0M5lZyRhQMhZ3oUcfoNVNeng1vXFJUq?=
 =?us-ascii?Q?8H79Og4zJV9zVp1FNw68VwQMmqjReu+5i4F8fGI0x+myc2SNBJ4ZdCU23Zbm?=
 =?us-ascii?Q?/kQ5UOb74cL4KVRVyXTLxb3W0e0BbZSteqJhWjAExs2VmW6+WiZUQPOL9C8e?=
 =?us-ascii?Q?YGhNBEhCES57x9PPQgxh2Tm0IcKE4T4Od9tMv1kqmRfbaDzNByNHTgSZQOec?=
 =?us-ascii?Q?mMjjQuO7n/0cVrLTWe2KQdb2F90YyaheytHFTnecVNGHCygYl2tCEb2OCHgz?=
 =?us-ascii?Q?G3loOI1HZqOJXqOOc51ba/mW1gOEcPfn20SHoycRVU9qOirvDFLfv63nkcch?=
 =?us-ascii?Q?OmFewsjlnmdOednpMQ85hKfveSjFf2jqFhsbPKSD5711B4YIXM1gUA5H9LfZ?=
 =?us-ascii?Q?mCxPTzvtSdFrt/yNpGKouS/Mjej3SnMcfUbnQ9kGkK0tL2PascyFrJNYAsd1?=
 =?us-ascii?Q?NsFiQ3ABec2qu7Fwy0sKW+B/D7f93XFAEQzoXwTEsQVyzl3tQwykPPlvz4/H?=
 =?us-ascii?Q?/Wtxq8nt2hF9d0LBt5nznOACBlk1X4uR/uKf8+Lj9hrSvox/Bq4cSMTHNEbn?=
 =?us-ascii?Q?EszntfaHU7GHwoqBSQPbcybJulxPAMLCDI2+p9uDTX4CPQVUfYjFtDmi6Koy?=
 =?us-ascii?Q?vCfCUxNCT/4LZpd6oCvNBJ4F7Rv5LfRncMo1h06ihodB/7rLUcK1+vUlffX7?=
 =?us-ascii?Q?9bVdbbJK+OFpWit2xdQkyg57SsUWq8IYlWOLUwXg1eaiWbUzQ2S/4XtrfjIn?=
 =?us-ascii?Q?CvWW5m5+CY7xng+RPsObmIoYkrq51wi2oiyfVpfIurTC3iOsdmBAOtwzIMHG?=
 =?us-ascii?Q?UonGgrtqg6oCYR5aIXpaq3fsv6WkGiHYjO8vYaictuJmhfvCY2QcckjDlwbb?=
 =?us-ascii?Q?TSiT5Zk6VfA78UbwHwtnBJpsAEgFPvBiVM7o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:35.8397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72b1b43-69f1-4291-a7c2-08dda3d2ce7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 231639f2ef0d1..89f3cdb8616f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -651,8 +651,8 @@ static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v5_0_0_stop(ring->adev);
 	jpeg_v5_0_0_start(ring->adev);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
-- 
2.49.0

