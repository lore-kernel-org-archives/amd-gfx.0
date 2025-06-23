Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7BDC77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5EE10E406;
	Mon, 23 Jun 2025 16:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ufbq0VWH";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514D510E420
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHYT8wm6GM49cfzeCpw/pSU7iiNVLwQzAidNtE2UtEx94o0a28SGAs9TMi/Z+E60S56XTzrL3pqcmAQLgheLwEFeb6nkZVNgjHT1ur/1A/n3wQw0UGoBGTj+Vph4orSMLbdzS7Fsy2/qkmSnr0x0DrjFmWl4Qut1rMMLpWO3P523TKEhn6T9NQUcwHfu1d2vdI6blSZ+MByuMswhVZe3AVscJAeMuhO/pu6hwj694BRZH04DTSyioRLqyNMk4SUuNux+qSDee6KwqHYYm/SxjaY9AobY+7nYcOTtJ/GnuYgP3K1tvGJT0DSNkNvHJsKuNOBYaXR7FXym6V1SIsGK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+GPtiM8b5mvJzL2TL/sLXgOz3SKX8XTXOq7NN/hBHg=;
 b=VDj34oVDBtC2vl9JQdoNBK8aJmWI+9+JlDC3NRPa2CBemMeJlSqvM8IBYQc1WiXU1uGCn3bqJF1v4GShPy0NbzC4xKcCdVUxqgu3f2rJW4bi5o3485RJgbhAP5CnbMVK/RIRBdhnYT3531ypIOfMkuwzpF9Dh7UTMUwCdUiTaixHZTGQNqp8TDYE8DyDDMN9uLiMymtvD0u+RXykqM5YunD50F3uxSV6TBfTM2o3B91FaYSg9XhfKENyf8C0+/8rP5+p+k9u0n05jBZdCQGvUjtXg8Mmhr/4Xt12PqwXeCCQJdO3Te75/pxQoYzk9jmQgWuM4fRbCawj/xl2u14Y3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+GPtiM8b5mvJzL2TL/sLXgOz3SKX8XTXOq7NN/hBHg=;
 b=ufbq0VWHwdd8DJlaJT9P6SfXEVLdYWXA5itbB7OITIQ1tPoI3LuaZ3gr7CUx3+rJ7558/Hs1zzx+Ao0WAv7pEiza1+FL7mwWiM4S2hKjjo2UcE4Q8FB01MKW+7xhqowoURkW9maP2R3Z6V5YoQF8nzquTNrfQoP6TFVm2uwc2xk=
Received: from BN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:408:e6::12)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 16:15:13 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::df) by BN0PR03CA0007.outlook.office365.com
 (2603:10b6:408:e6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Mon,
 23 Jun 2025 16:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 27/31] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Mon, 23 Jun 2025 12:14:33 -0400
Message-ID: <20250623161438.124020-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: bc596bea-fde1-4675-a662-08ddb2712247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RHFOjkeNg1guIBsELkioNQllQwhv0YP1vq8pGD6svm8ywrT1uLVSS+t5xdly?=
 =?us-ascii?Q?8+aGCm5tFv31NlgUng/yc1MoXPL7/evXxI/GK9cck5DNEPyWMMnj84HiIkx4?=
 =?us-ascii?Q?gWojFmkd+JT5INj2cJmvhiTgKCXI8M6FYr8jxPfxwNx+AYFBB5sLmy4S5LDC?=
 =?us-ascii?Q?/c/0+jjyknL1ktqeB/JtOd3t59LSZn9ZmQ1V3jvEcaOaXMyqJ5YgUhiZlut2?=
 =?us-ascii?Q?qTGFlFxzVUAE4BrUM5D6JnMjq88/aEOKeyzSRtjRz336DZg1YZlRmAmN9eh0?=
 =?us-ascii?Q?Q04Vs4aOKY4SeYIIoUxI+cO3blt/1RH1WAqqRQkPVU5vD+hjwdCYxHvvUKDv?=
 =?us-ascii?Q?zNaj8DhfOoqHVjc94/nKwIUNBeGwd1/lYyGaBk3ktBvQKagHkl2lL9rOu02w?=
 =?us-ascii?Q?7MPfSNI2a5CgN+t1Qlp8E1DBkYjmZpVA07cUbKMp+wvkXb/Ion1q32YqrMOL?=
 =?us-ascii?Q?HipTimD9cCfkzEbpVF2p8PRiyK/xToHDGopzEc2edtYf0M2hiVaO5KXxEubJ?=
 =?us-ascii?Q?7XXo81d8j2q222btraQxnTPdZijaHJuzc2bgXAF0m9/B78l1uqGo3H3cYuRQ?=
 =?us-ascii?Q?Y+fVZGP8UiGjnkRxIuLTAimEkLibIGFY6M6ZF93mNV0pLTc+r77xshASuFRT?=
 =?us-ascii?Q?qQbZYF6WEs26lL3T/Otp57JwmrksRUubzy65SWlz7S1bKYgF7SLmg7h/wRSq?=
 =?us-ascii?Q?FVgbiwj1wws0vji8OB0BV97qlBQcqQm+uJwwTI5MxgDxPfKVJMDlm+ojXPc/?=
 =?us-ascii?Q?JOFuby4RJPCrLmibBylrlYpU354d5yO9Yw9brI/0CZXM3bmaAitj/26s0XQw?=
 =?us-ascii?Q?KnDXOf/JfffSKewD+6Jb2iBPO4paF5Qn4wYlSzkqVLohdSKvvWIZtwzgJxzy?=
 =?us-ascii?Q?e+cYCDaeZZg94TRJMNeQBVcVqMn1YTrUqyQco7As//tJAWtT2eHUM117O410?=
 =?us-ascii?Q?fNbFqAoXbXuTv/GwNttKUhhYYP7Gqj+l7bvK80TJ0KfB3sVMrvP81p1uz7ju?=
 =?us-ascii?Q?pD65ABAy1dLCmrGI7CJG2kBietFm3Bh34ywMDMFMVVRHL6k7Xcz5DX8psHh4?=
 =?us-ascii?Q?fSHyGe5FL8lssiL55xH9ZRX8NKdItlhwxJvGNXkz/73KQyuz8k4ONWPYb/sB?=
 =?us-ascii?Q?tgxG7jY8hZIyxwGzFwmm+3swQBVpzSHQAcSEXCYobHzy3f6acteRWulrvfZa?=
 =?us-ascii?Q?r5xr4cQOvabK8uZduM/iMdW7De+057HdiQQZAa62XautUwkB87RJk+6T+Mdh?=
 =?us-ascii?Q?ecJQLzmPJXS/KRR0O8qjbr99Qpilz1hAlN5bAtnJaCzdptI/eeXbj4uSPGWu?=
 =?us-ascii?Q?BVTaqngVLmXR6l/TKtgF4UxvOSSshZXXV1ljgJw1eaYWsscaAEBQfxNZYhbM?=
 =?us-ascii?Q?VBl039ZY3kzq2g3pjCvBinHbVkTP0Olbzf4Q7t9tWYri+9A1+4zwQrOabDbg?=
 =?us-ascii?Q?w6CxypTgg5p5xuoFk0i/3wWjGH8uFYnXpbH+2DgqHFnlnYBRx1fKiUSdPLsg?=
 =?us-ascii?Q?tBt95FXfQhbgO6WzqmaLPRTDO7AhXy8DD4Mc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:13.2242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc596bea-fde1-4675-a662-08ddb2712247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 47c0bcc9e7d80..5997927ac6db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1198,21 +1198,14 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.49.0

