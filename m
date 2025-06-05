Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E9FC5B555
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F9E10E7C2;
	Thu,  5 Jun 2025 01:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IUt454VF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2586A10E95B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEUCmSaPzugu7ZLLZPE3SRXCACldABDEj/Ce7jswZepUH2BaX12r7znhw99ociMxTKXvMBOOXBxoNWbxo2krtqD07AUtqVJ4BbQ68RfIMoPkOgF1s1tw2w5KaQB46Wtai/Yv1XZaWWoJELFSgAYBBxVpJX1FnYIJEmedT7hkjfT3sWg3PiI/nsC0MQNJQw7yO1rDy9qA241D+DSEoYS01slyn7g0IDaGBLQoBuDDv9/r9n2D5sLCMGhXZ5KXZA1ZgRGkkE3olnOxYMO7R/MGI8GJ2DfBz0P8Wt2q6ILcE0l7uoO4EQJK6eUwQIYhoIKeb7r1jI7IpXGYKGHDdgX+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tikB6WBLg37YAG/QollEvSWKE3Vst5jGuzK/BfMVlM=;
 b=BOPyUDLH1RYFVO4iLN15oMR2sz7sqems2wiMOTubd/z3G3o0jlolJT88rf745ukQuwbGn74liLF0YTJxCkX3mrv8reLQi/5TsJu7XfakCZn69RA5V3M2Cv7KjTw3ObbC042qxeSUY897F/iT71Zal92vZb16zBdPeUecXZ06SOXTa5Kf6snEda8Dz5DMWYO4WWM8KIoMzYwfxH/DmlDQOhkZ9oDa6tGiidZuT5q1RUwMpuXHsv7nWW1izhNGFnHziTQHKlYG4et6EOrGCMKQxPi9Zpc5jPiXLnbkDcG2TrPAF0OhuYegg11meS1rjS5eRRsJJX3bnPAW5bg6dLA3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tikB6WBLg37YAG/QollEvSWKE3Vst5jGuzK/BfMVlM=;
 b=IUt454VFkC6iVvdM/kazLRRFBcjjCiZO4+AGskhl9Ezrx49eVfpTbajz1a+UNypFbj4WprcOL+PcQh98UX2UnOFgps8q8HgqXLS8kr6LERU6DZArqll/5UdEnCkJu54wKUbYfaSvAmCUN8a3+1oTAL8ba6n1V8aaeAa+BApVAZE=
Received: from SJ0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:a03:39e::31)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:40 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::30) by SJ0PR03CA0296.outlook.office365.com
 (2603:10b6:a03:39e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/31] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:46:00 -0400
Message-ID: <20250605014602.5915-31-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a869ee2-ac2c-4c0c-df2f-08dda3d2d0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lgtWuupgwN9GspvHh3ZGSYc2Ln4/nMmwfKNm/8MHHNzWTrYt5RyL/I46SPPd?=
 =?us-ascii?Q?By9u0rQFAjIfH/iiI8EbMdGUJfMa00k8DB/IQnWADai+JjL/xtoYIODehym6?=
 =?us-ascii?Q?KESVS9Izu+YE7y103PckRXH5jkImEX9+pX86tpTf3xk+z5UXBMgTaUHj4xPZ?=
 =?us-ascii?Q?T6jBbrswFeZdpTtG8CtvsFEgs3RKr4ow3xSGwbGaFvmch1Xrgb3ztJG4o6k6?=
 =?us-ascii?Q?99LqFAXeBKSI3ICaPj5ynbEcOu8R0S3l7yLi0qzGuSvnk8XBEZAXfqFc7wr9?=
 =?us-ascii?Q?8uANmzRM2gYmzbvI56tmMwc64JNFKybQLQiuwUC3RpBE14hXBbEajZFZdCz1?=
 =?us-ascii?Q?7sKmClxAwjze71Q19mdwGoXzshU22OHXJj6MFxsUTNDilzRMw2c12y6C736k?=
 =?us-ascii?Q?juvssZjjzB8oTOqBLEPUuWR3PiZQCv9ueZImTYd9RW9orpslQHHoGPaIc+hJ?=
 =?us-ascii?Q?EnClZckW3Iv0im9cwlB4Pd65tiFc+d7LRSpL1gNWv/3F0gQmGWyE4yJDRxIt?=
 =?us-ascii?Q?tEschht95T09SkjrOWxzhJZyZISBvlQx2HKqPaU6ib929HO5PZ+dDbmc4dTV?=
 =?us-ascii?Q?gpWObx2OnWEmuSyoSaE89BB4w9+to1jfmFydjmG9dRJ0V1Pmhd2It5pDCydw?=
 =?us-ascii?Q?sy56H3Y33kHuMe6867vvyDAU2tzVn12w1iUxoEwWrJaZ5Q6VjBDZNACgUl+z?=
 =?us-ascii?Q?iPIbnOIEyai1AoKHI9XVYwj4vmRYJt3P2hZkd7AhmuOpIMTLMm4ZI6r8qeyv?=
 =?us-ascii?Q?5XIUQDrdmEXCn0FMWx/g0t9rK/VIHCxT6QjwQph5fsPQw8opTkOizBaVVYjq?=
 =?us-ascii?Q?aWyJUG6ZGt5MkJD7A5+nqeefVpWQYvcEpkRFXmE+kDvtiCdLqHKcuBq/UITZ?=
 =?us-ascii?Q?hpJ8FLhrsIS2Lv/woD39y4dZO2OmIoug1FXpG5pQoeSqKAFvqfzhvjTAY/j2?=
 =?us-ascii?Q?yInQKJ6kZXjr9oCPFtjpac6TFlem1mroBMpO8Rj/qaeF9KzUoIXmKKfLSQ+f?=
 =?us-ascii?Q?3tb7cjgvpnE3NKTIHWt/tgI18kCo2ikS27wpmu/RSrqH8ruEki1dx5486tN8?=
 =?us-ascii?Q?neyeJxYddoR3OQhEYthh/wgskNsg8kLTe6pGycroN505lLz4AwVaow1dSl8e?=
 =?us-ascii?Q?GTs8CGJaF9W147tGY2iI9ZyTY0tVNb0IEm/IHr8naaCB4jmNosW8SE//o5ls?=
 =?us-ascii?Q?d7GT/yaKchH3MzP34fH+A0UH1CeKAW8ecyMQY5XXTQhkNF2CFHf+fwbNnvhs?=
 =?us-ascii?Q?iMBO0hbu0pSj4DwW6dbMoPOkTOPi154pl5fUr+YSRYZN6qvTQney1rs6kgBy?=
 =?us-ascii?Q?2htZBYJs7FxS1/HNeqFcYrB2uXCsj/o4NMTcteOo1ieZDjMPRO3ydVi4dNmd?=
 =?us-ascii?Q?v+x6MyNCV7WQU78vBC1HiI1Hs+C08mwIFZVfmfh4QJ2ORHDtKrdALVujeeQv?=
 =?us-ascii?Q?EVtHJ/jgactHIRN8PIfJq71BdRGPZnmSJu0vKn6qgftiGvms2okhMFbILE1n?=
 =?us-ascii?Q?FuIz3DfajvM3drPncB+VzkIC7G1kICob9in+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:39.8083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a869ee2-ac2c-4c0c-df2f-08dda3d2d0d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1c13ceb3bed8b..311d44edff224 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1475,9 +1475,8 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
-	amdgpu_fence_driver_force_completion(ring);
 
-	return amdgpu_ring_test_helper(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
-- 
2.49.0

