Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEFDC83F22
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D91C10EAEC;
	Fri, 11 Jul 2025 22:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gndd1ybt";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 299DD10EAF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf9Lu1YdS4/RSI9oJPGuZ5aifoDES4sOs2uWY8yfaj3qUCE87Eo/1gzSAYl6Y15o1aPgfXlhf7Fa4shPtPMfEbhvZvNqOY9NukjNqQiGJV2TW6fxgZZCV1l/dcx2N6DNAvxLPZ8O7Qmo5BkDmAW4rt4KgM15p0wMGyvWQNGPWke05ZzTYXE2xbdxVtk/AdzliPj/H4tRG/iieaumNQNzmncGdsuhhnhbQpxxXa8kFVTjqlSPuT9pMpGutfLUyN+nJEra3mzv80dyFtKI2DTI27w+zOSYWknEO/8Of08zKA35DY+MgEm3Wc2KUGP73/kYuwtptwa/CicefrnSfywc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wpJUz1h/+LnAspS/X/AzlqwzDHwbbXSfGA6Ag5UWYE=;
 b=tyu5sMTHe5gIxnMdxUv195KDcqI9kFmRDDQPwQTa4Dj/geszg2CEgX77P6FdB07GV8QxSUjZy8XIv3pVgmvjpK9+AIGzrhTWMOS6rjM9Oq3cr00NtICZr4JtuV2wcCPe30dMroCczhM9vbhwdPks2GmM82DFjpQip8Qkf+xr2mLB+5xB4ameJc+6eJlzeo4rn3kN/zP9lwWWTgKZ+q8q2CLi+z0+0gonSWMs+CMjOIoKMfJOMzL3Zh/4QkWtWTLD70UeFQipgoeEkxRFqOT85RhUqWAs+TMqt/3EC9sQ3yuSFmFmZMniCZ3/qpDn4HWAPoRRlF35vWPvVuo4ozs1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wpJUz1h/+LnAspS/X/AzlqwzDHwbbXSfGA6Ag5UWYE=;
 b=gndd1ybtmNpzhbqwy8Eb5ZHLmOuaD3HcQEmBcmOU4AaLl4ryXQ3sC0Rx1MhV4mFnpY+k4IRrQ2cXlS71nVwIR/BYbBTI/NTGBLVrPFnNBOYP1tk6D/k87ub7+m/0I4gtfi1uoex1DTjm4mA80ezx/eb3CNDvE1MmeiTWzyreBvg=
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.32; Fri, 11 Jul
 2025 22:40:56 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::4a) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 22:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 26/33] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Fri, 11 Jul 2025 18:40:17 -0400
Message-ID: <20250711224024.410506-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 993ff79f-0838-4261-287a-08ddc0cc000b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7I4lDUe7w7yVQ243yTRpc7jX/E3I4Hvz4bzpwpCRYzlrPB1Xk1u1UhzLGC4m?=
 =?us-ascii?Q?Y6YIfXMjECNcFSgD5872jRSGGfkon0zYUu6TaDmLH6laVpsbMBvOaQh+u51J?=
 =?us-ascii?Q?AXbVVBL1zCr3bHFq9hsarpdyl+ZP4+hW3JOjtMOGK4c0NOeu6/l+RHMyHG6O?=
 =?us-ascii?Q?odprtJCwdPGwHWZ9HKbneOPjC3iQWCbrhbE9W9PCJbRBBiowG/qDf+qF5UkC?=
 =?us-ascii?Q?fu2nfE+dF0E82bkfYB+ZvPIAvME80fn1QpES7+FSkBJshFZDVImaTnKHaeBC?=
 =?us-ascii?Q?YB8oYDKdFAghQEDDsnC+gXJmdCt9DU+i5rnFPiWjirRAWTU1BKb+T1sUc2HW?=
 =?us-ascii?Q?SYZFCC28OIQBLNI7FN37ZmrNeqnhAunyge+89S9cb6BONRHdC6oF0Zj1GfWB?=
 =?us-ascii?Q?TMpgXWuGz86mUTdUFjWmaKE+31pInpkgu79mwMzfeAU64G3uxe7y0hOojQSW?=
 =?us-ascii?Q?ixPph+soXnkARLlg09rJiTYCmgZGINqg10KLh7ZG9YqJWzu+kFcsBKPoW9Uk?=
 =?us-ascii?Q?67UXJXPSOLMdrLoMsYp3GvHBVeG6VIgfDRTADEofR3j8lefdmUp0lycNr/Rx?=
 =?us-ascii?Q?QBCEAcTGEkc7uFcOUWbQ+Qi5L6BUQMmuXyND1mB85nnjKBnjfcqum872jWUW?=
 =?us-ascii?Q?lGq0MKtGr0nHtNzSuNJGFNIuWuSAqcwLOojVwKD4NIe5Ze6QIcajXojrHQp9?=
 =?us-ascii?Q?AiCO42F64Kx/NUbiKxjg1LvXVzt+LafHcDxSW/Z1AZ9kOmUgae2hPBFko2m9?=
 =?us-ascii?Q?sXor5yaKARC3ML/xgD+VIr0YVawR4o0IQr2wlOYBHjLkKLZJjx9zcACDVX5Y?=
 =?us-ascii?Q?s959yQeIBjmz1ertSr/gV2KQEXIk/CKqiun9t/sRjNffVwWZmrNfOMMQ3ZP9?=
 =?us-ascii?Q?xplgg73DYnj8S5u//yn7T5j0G3vV6fK+9AYYWHah035yOjnGDoVc325ml79s?=
 =?us-ascii?Q?8Iv4hSqTqJDicLbOSUG5RLNhy2kFAozPUY+KAlzo9X+QnRcrgYFeiic4z4Oi?=
 =?us-ascii?Q?ve8sFKHwRxi53F1AnnqbrI16LlSJor60JCRSHgzSwGAMs9oltipRsYocRVy7?=
 =?us-ascii?Q?Suew7zUg65plA7KAbVDy9GuGQq35BDQRnayFtGReM4ErwePhu2kxtAM4Xa6d?=
 =?us-ascii?Q?hJoouBPv72BhloAul6IyhTspBYvFLDcUDfNB0t5jYrnTFKs7j0s8GeQ8fWmr?=
 =?us-ascii?Q?MxLkAaSNkeAxkQdCHMm7cCcysphQTN684rTL1yiKmrn1b52v0Eu4wYI7a/8H?=
 =?us-ascii?Q?3l1KNicYBm3nJ1tJLbv2mVfwQEQZWlg96kqTwXYHg5lb9jmFtYAo2G7c8+hb?=
 =?us-ascii?Q?IjLwQthXBAK9pyhn4MAFVVSwGzIcW6Is/izKDy66/+M5CfXF7xZCGJyf5ygz?=
 =?us-ascii?Q?MoEKLn73X3WIzQ1QmChx2TmtUpyjL1ohuzvV5V0t4mFCswhOQH6Pii9gHz6a?=
 =?us-ascii?Q?NgnreLV4fcDA9gVdjnp+cIx9XD3wAzB1a/xWq1fymaLUhQh0JjHbNQTvTnhp?=
 =?us-ascii?Q?fMffPzqzJtdN6llGBwo1hiRQPaTiD5he1Gi5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:56.2187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993ff79f-0838-4261-287a-08ddc0cc000b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index e6613246d8b8d..f642a06a77b56 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1979,20 +1979,14 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v4_0_stop(vinst);
 	if (r)
 		return r;
 	r = vcn_v4_0_start(vinst);
 	if (r)
 		return r;
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.50.0

