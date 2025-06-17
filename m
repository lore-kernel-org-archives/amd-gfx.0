Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5391BC71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5B510E47F;
	Tue, 17 Jun 2025 03:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="De8BblKC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F7310E495
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROQJbXRxNrKOumdpjWGzPnDMTFgumriUrBgjC2FFQBo2U9YeNTyQ1W/spzvr8EJbhcrTGGL5tuYmJQKmQUBulpFFF3UkUs/taJq/A0LRDKPdi8FlXpW9GnotKKB49qeniGFHBlM7vrFLghbT0QrH9r3/53ScyumiKKF18NtEvnMNOg3l1hKSeMP2WVAOgnBgJmn2EO+GWwFu3kCiL1CtjZtDmml15Phx2zLmfRaGCTVtz9fIPuEALfFfaq/DwtAen3nUt+npq9ACST8AbNzM1jdhQYZCKaVocfCFA1iKSY+SiAZiWncPuHYCR8/AIDdIn5WLOItnv9AQt2ItTcsgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W6fH3Mtt5ZuMGk+q7YCcAe31d5mDq0cmGZ8UEzkPSU=;
 b=FnCOLk3qKGe65mWI1Jc48tggMP+t9MTdIZA3EEZd+fWxM/fjbMCZyo9KO297W0VC5AyeifQ+HJkzYZAcVqNxyYzfAZaifEqqvEaixvW5QQwfKvqpLrEs3uLvFV3yy6dvsWkHw87g0qf48Ud6Cs3t412cmdjqqjuW6Ib47PoQ1hnxTLj1rMPZDFuF90iTHMaeGSMlSnZCgmRm41MfkUB/vB7q9eR+qQBOeqocTEytwG7dt39lJKPbxZLlVQYbQJ3qwdN8X+1e7fNhYep127Fji1pUqhHHmisgKcQxA8bAk43ifLoJvGoPrx6gEy7qbasI776fyx3enXVrDtfpFZnbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W6fH3Mtt5ZuMGk+q7YCcAe31d5mDq0cmGZ8UEzkPSU=;
 b=De8BblKCmNaw1ozJTvRS/6S8hL7c+u4gcm8NWFN+eHBcrkbBTtTO1tQpWTazG5o3FIeoo14Bk3moT1Ecao7GMjeNGjLb4zEgnVizIqXiWb7kfa3A7ElzCf134H2HTChzjen/JJoq1ib3s+XSO3/Dae0iHmxM4066HSu9jkgrG2U=
Received: from MW4PR03CA0016.namprd03.prod.outlook.com (2603:10b6:303:8f::21)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Tue, 17 Jun 2025 03:08:50 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::68) by MW4PR03CA0016.outlook.office365.com
 (2603:10b6:303:8f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.28 via Frontend Transport; Tue,
 17 Jun 2025 03:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/36] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:08:07 -0400
Message-ID: <20250617030815.5785-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1374d6-d207-4170-55f3-08ddad4c485b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d0Lz0S0QMEZcWRCbnx6YMdexYRBDlSG4L3uUX5izDSl2QXm8Gr7/lsKz6Y1C?=
 =?us-ascii?Q?mA1CHMNVLfQwvzH+KAXSamNZwVx+jcXOEG5EA0azK0J3iejWcnUIlOlp0oCS?=
 =?us-ascii?Q?CpwCRzvdI04zlVwrjn9Sn9HmbBX4ylfSj2Ec3nYkhLOkGKSEgFPtaSU9Ukvm?=
 =?us-ascii?Q?zQ9rTn7uq6DVXi8gndN/b44dunhTshfdqbH3/pRdJXQGAyEytdZW3C/Iz0vM?=
 =?us-ascii?Q?kj+do21SETR2CY4VTEhwvl93yktbT2JjUgArNHbURxqwQ+wxwajvrzRABUGA?=
 =?us-ascii?Q?WT4bbhmLuRwtrNnUELrIzmPh86QUywHo6+oN3DHH0h0MbaqgfxTJY6/wdJxt?=
 =?us-ascii?Q?3133hOmv0Jhn3gphWCvr0kJ7j49G631LHhZVzx2rpX5f52PkqfnJ0l80BYHj?=
 =?us-ascii?Q?x6r3XvGTDAqOs7kW2A4h5BRQhLh/nksM5Gx9bQTp+NF1GqTcPp8Rk8yzIyBF?=
 =?us-ascii?Q?tykHzuAix1l0R37QypZJ5MabxTVugqLJxIIb2jnh5QA18Mx/wBRB1EqZ+fQt?=
 =?us-ascii?Q?CHUcbqBftqAagjeB9WLyisdYi6Iq2H95cQJdJ0f/Vh1tbEtmklIqKMLdViLq?=
 =?us-ascii?Q?FWZupoVTQ6Jk8HwVoj6PAqxjRpYO5fMa3FVmMTLYFHZjy2wvy8VHMwmJfgnw?=
 =?us-ascii?Q?Ih1f58TQiVVVCHckzPqL8GH8Uc3RoF9pJXW7Vr6YflT6W9SA75L3KLt1tdLc?=
 =?us-ascii?Q?XfZ/95tXEHCILF+fuxcWQPBLbtT+TPWIDXxMD9RMfMh94VJ0NIHOXlYMIBoi?=
 =?us-ascii?Q?ZTNavoErzgCdj71JiWUbcUdJLAKJouOVITfV/WiVYKvxwlR0RDBXm9VCNaQa?=
 =?us-ascii?Q?9M0791pDJ8P7TaoanRviXIQtkxEW19fQvr30BQbpIoQtMKMFEACGYrDPQfVE?=
 =?us-ascii?Q?xTQc2z/bpx8bMNofGfkN5y8Q57ZUA2Qmynl355RxQarwvGtqcPqIBaZ1a3rY?=
 =?us-ascii?Q?5rf83gLXbHMi89u9Kap5nG2SgRAQidk4NS8cOfh7jJKDgqZ37PYjimyoIrG1?=
 =?us-ascii?Q?H0pK5CL47J866zIAevhrAr9NeP10w4aSMnskyScbKPmvKe3ktL+z5Ae5gW5u?=
 =?us-ascii?Q?V5BDZsh9Ddy6Z7EdqVf6xh1x2TCElRBXPrDcMH0xh6UBNcre8EqtlpDIga5V?=
 =?us-ascii?Q?9hWWpY8GpeoNYIgcrR+6jrDy+PEVYRHl7KgvQ/koKlq4lrMKpNuOfQyIcTC0?=
 =?us-ascii?Q?k22iA8t/iHRcYfyRUvAZW585nAFrU3S6oPkqXFKPIwpTvufFJd3CxArXMM0w?=
 =?us-ascii?Q?KXtFey4zsvsHe/RaVII/g7INIw2mc80QwrWO60vXFL/HIkjAeZpR3IokZ46H?=
 =?us-ascii?Q?NamDzfpCQGrCICvMd1OGGtEANJT6wBCG+CSHGJfwDa8/LE5vgWHAovGe8zKH?=
 =?us-ascii?Q?g+ICOqeaRJhLJBiW9CDKnfekALWGnNShBUey1yXboD2VaoKGvLZN9i9qIC31?=
 =?us-ascii?Q?8TKmslqgLfGc3grctek9bvoK+pBCzVlc1dAokpYZ0azR0jYkDN/gS2bfxjKN?=
 =?us-ascii?Q?eYA8KqVY7LFiGI0jgNUO48zaUDwUtLGmZM8a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:49.8209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1374d6-d207-4170-55f3-08ddad4c485b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 3ffc2a61e6bf0..f49f3cf53b693 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -838,20 +838,13 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *guilty_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
-- 
2.49.0

