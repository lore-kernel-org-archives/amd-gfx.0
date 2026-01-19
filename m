Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BCFD4A5EB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 05:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025A410E363;
	Mon, 19 Jan 2026 05:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d7FH6kRL";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CBE10E363
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 05:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVeLhm84gLKW9r9Yq6I3cC9XfcRpv02WjUbrk8zUJwZTLIg5ShznNiu0swEQr3Pd02D3ivL7B5VHEwZjIX9jEGEatKWn648R3bX6iMSAxfyoIgZdzDNebcTDpHPggreQX0zD0ObXzg/MfS12qb3DF/Ma3Sqf35/xLs0Mswds2fxOQBSz9rVXn28UziVP5ApXrMqePub68nLWQ56XC1v6AGOhKWzgc8xv9ANqpSg2Qs4VMRGZgY1bj8bXdiyhxrEVM8K6D/PIADBhVu4pSHxjwH1LFcxr70c3eQb0mbTgpMEOrIsHbIgUbfHsqyFM2ObdI6SuD1SOQfv00f60R/IKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhNsxDYTQr731nhL5MRmgLRw8ioacJOzLHnjqCPHZUM=;
 b=MXm6ohV9f9RmK1SBK5wI+AFjNKVN3ZqOi27zP/enfWurgjscqQIFOPRaqIFFTV94kYCXugIbhR+A5V4ok6VStob7dszzE6VK8I2DmLpm3a+SypuJ++iKGNZcbiqvxnnIQg9s4BOqxxJ5IOmdMbSHRxzppmdY3xM22Ie3ugjLp+1nYmADndYGVhJCWaYMMOksWeUuab2sQhYVVPxNgQ17HZ9vqlQTCnH/tN3lxCvktyn9lkv3Xyktuz8gjIbvA+07I2UIqTZaHt1xNZD7Nmd9gEjABheVPYqEThEy+wx6JVNnM9SVpGaOfjCCR+s1Cx36HE2TUk8YGhtaPkjEHJAh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhNsxDYTQr731nhL5MRmgLRw8ioacJOzLHnjqCPHZUM=;
 b=d7FH6kRLe0Jho1p2d65NZnAIGKmmRDgZgq51Ub8Z1kwcHdy4Vzx852eWyVTYPVnUFMlD0LVNr1+4gExClKJtzrFajV5UZHGxrgkPeGiMuvlNiZAuTHdKgOF9utw8GEKgidNCLNlFA3osf5QJ+fFreH+F0/OM7Mx9TeL0ID8GbhM=
Received: from PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::17)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 05:35:50 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::79) by PH5P220CA0002.outlook.office365.com
 (2603:10b6:510:34a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 05:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 05:35:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 23:35:49 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 18 Jan 2026 23:35:43 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu/vcn5.0.1: ensure JPEG is powered on during
 VCN reset for VCN 5.0.1
Date: Mon, 19 Jan 2026 13:34:06 +0800
Message-ID: <20260119053515.893663-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119053515.893663-1-Jesse.Zhang@amd.com>
References: <20260119053515.893663-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 577278b4-ee9c-4cd0-1412-08de571c9ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SIFnNOJel6O47sqboGLWVRpstnWxT/+uUVh8XuOwfzg8hCn7tQUKbdlBx+yn?=
 =?us-ascii?Q?5M0SwhjrSV1KRKi2TtUt/xZwSOh2vzxHfmV1/tHNnkLzIfD1zU7lD00o+0wm?=
 =?us-ascii?Q?QBXtkgp93j3VVUsiXMEQ6IapATMOdn3WOs8plGEkxV26DtB+aBB9zWjHJX8F?=
 =?us-ascii?Q?gwDCsrEUJPmvCL783XgiGxJ83KgcTWNPWsQggr3y95oW6UlDyhtgDzPHLB58?=
 =?us-ascii?Q?TZFegWnlFwPJt2aVZPek7ozisZekpDhz/rrn5Qpc54mdkJbv9xnsFlfVt/bG?=
 =?us-ascii?Q?mzTJzLA7b18QH9MvAI5+ggD/gqSZMGIJGaWnJ02ZP0jK+PdxqLhHEg3wy8lT?=
 =?us-ascii?Q?zBpKKHQLZmytJkREWDJsFySPhFjqeZCg9LIEzH7Q/K+libZ92OTxNeRYc6d2?=
 =?us-ascii?Q?TdrMYUS5LomYdf+QPEdX7mtQ1yqR+rZYGl4EDPHEkcxtislIz9IU3ImFLtHY?=
 =?us-ascii?Q?4Zb89H7wFRNcciaY+REszqqwZlsZPMqB1jr8J933gEqt/TAcFylDkzUNbk0H?=
 =?us-ascii?Q?Ao6BFnKprDjwRItD17urAHRc+CUScZJbczT1Hr+uFKE3FnWJzG6IFolzC1iA?=
 =?us-ascii?Q?v3IckQ7tgDowCeAeFPb8NBMZk/i8t4ZpoCueQ7kiAZZPT96nL8jW6sJy3cXz?=
 =?us-ascii?Q?DenOTbLBIHEpAQo2iezZL5y7wupw3lI4LCzAwPOqx6wQMgQwMl+2EKlKco1z?=
 =?us-ascii?Q?m+UnJ6iu4a51rovHecgLSi+jF5hGFZWzyGh538vJoBh9jZxEgEU36A8ATd1Y?=
 =?us-ascii?Q?pUhXqf4qZjHfdam8+KKIZnpHaMmwMM+vl93FG3UiYiqQPiZpye08ojv9sP7h?=
 =?us-ascii?Q?KKM0SYVIdEC/XlCe35k2BR3YB2CIvIPJHZ1d39f3aWCCi+qXpqXg42wjAG8B?=
 =?us-ascii?Q?jqK+FRK/2yDyARM0oqerC3bchyp9txI8/23jXdLc47v7haIivwyG67b+o2A9?=
 =?us-ascii?Q?aUUgZbjHC1mMuAYR+0YmziVoCkXWl+B74UI4Pr5Z8UZQJg8KDgQimOdDjaqq?=
 =?us-ascii?Q?tzvqpKlclMKorbgPeWqWrAyES4KJJM3ccmJFshr5Rwyk2YBv3eiSJXrc9pig?=
 =?us-ascii?Q?LtE7S5EooHn7PqHRVvqHCMdOmRLb1m18lnqhBEzu6eG++Qd+308+IyZgWX3h?=
 =?us-ascii?Q?jo8w0a+9eZJo+ENQbrpYhmC0J8aUSurkjuxIat2aELw/OAxrg0y0Btb5j5Wa?=
 =?us-ascii?Q?UroIVmdB2YNVcltZHDSNtWYEipdHknjzGhZrhIxEvDusmsMUhaloXAxFI0UL?=
 =?us-ascii?Q?tvCzsEQ728ais3uRWq4vScU1mkm3kUxZdGTRtmQMlajVKg1fBGtZCIHT3LNu?=
 =?us-ascii?Q?WWDVqQRbHhSHq9kzNo+2n5CYMp3vvsIpii5/jRLVEa3pOwjCpYyhX+ADvUvH?=
 =?us-ascii?Q?2+q7gbX+sjZw/jhfg/pKX2JIxaaJb9Q/TMtWBbmu6JdtdV3HZP6gGlBRWQMp?=
 =?us-ascii?Q?CpajPO1VWEtH8s2ZT2BFXY2r0vRcx4Q5oq9NAdm66BsCt1YsxbuxmUqf3FZn?=
 =?us-ascii?Q?lXsRiuS+301g9/cYeE+hkv93BnMUyUTEY1NVks/4bjb1pBNzTIUxO+DV45hW?=
 =?us-ascii?Q?KXTYgy1ldd3+Y0a/sy6Ctz9XHCiJslKGB63SPKqy7EDD+5SwY10+LQfhyKdr?=
 =?us-ascii?Q?6AmpQq8Dy07JZ5Z82HhXaz3tosMn5cL3aQaY7urGgUFug1vDA6EGFTgmOd1l?=
 =?us-ascii?Q?UNAByQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 05:35:50.2019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577278b4-ee9c-4cd0-1412-08de571c9ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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

Resetting VCN resets the entire tile, including JPEG hardware.
When we reset VCN, we need to ensure the JPEG block is accessible
for proper reset handling and queue recovery.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 26 ++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index db2c8efb112c..c28c6aff17aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1362,10 +1362,19 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	int vcn_inst;
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	bool pg_state = false;
 
 	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
 	mutex_lock(&vinst->engine_reset_mutex);
 	vcn_v5_0_1_reset_jpeg_pre_helper(adev, ring->me);
+	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	/* Ensure JPEG is powered on during reset if currently gated */
+	if (adev->jpeg.cur_state == AMD_PG_STATE_GATE) {
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+					       AMD_PG_STATE_UNGATE);
+		pg_state = true;
+	}
+
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
@@ -1373,6 +1382,11 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 
 	if (r) {
 		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
+		/* Restore JPEG power gating state if it was originally gated */
+		if (pg_state)
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+							       AMD_PG_STATE_GATE);
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 		goto unlock;
 	}
 
@@ -1380,8 +1394,18 @@ static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	vcn_v5_0_1_start_dpg_mode(vinst, vinst->indirect_sram);
 
 	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
-	if (r)
+	if (r) {
+		if (pg_state)
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+							       AMD_PG_STATE_GATE);
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 		goto unlock;
+	}
+
+	if (pg_state)
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+						       AMD_PG_STATE_GATE);
+	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 
 	r = vcn_v5_0_1_reset_jpeg_post_helper(adev, ring->me);
 
-- 
2.49.0

