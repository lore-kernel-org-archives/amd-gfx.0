Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98026D1F9C6
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 20:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F33810E0CD;
	Tue, 15 Oct 2024 20:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j3cNHcpk";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0195610E2CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 19:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGqqjQ2K7v+FsB0hMBlaaGGTDXpRLqJ8Dny8bQf1+s8cGw3KMNSD9/010+sI5UdTxdtl283OL7QxazekdnmtlhYJcbUQ7edju6NCbf0/WhP6/NjgcqUT9amzOwZ9GWwJ7BzPzK5/nqNS8QKcB7zci/vhBu8TnFgII1WeBrfNXPvkmDZtuqZ84kTU51QReZnORYeUGC2wTNUnqeImUcO3WpO+k8AxCQZs/XjUmZhvc+LodngCHUU4xfU3GLPD4ZnyW/Qkz6AlE7hNVIVGOGDKAOSHmSkNz/NFE1qaN1z93Me0S7LEPyAHs8eaRdrK/bo99FEC8pbmCdY3E6/ht++Z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3k6cuyhPFGnZix19fXPXXbW4H/boFXZyMaD1+lcA5E=;
 b=vDrOuDmV6PBuwYj6CzrJgaYBvvLPJLEjuNSQ2dM4nf2xf392wGmUoJC4q1OhVU4XB+8romqU+UZBTiDroFLCHpsx8unFb3BYcomCpNbjylWt1qmaYTRLVrMw4JavGzELHUuygdf1/Im+56Yj0APrpC/igAXw9LtLnAoD2XB1XpjX5US9YDxYO1qX6lDXMLXAVnWrpRVDoD6fcJ/T9DPGg+IVhAcbglf6ur9iYGallAl1mmxmt0mKktAJN5M9j5RccPIZ2yUPm/7Ci3jsZq/eMUSR4rfJjjEQ8XAICushkLHo75KW4tUtj1CW8N67Y8YOcwz9T/5ZDwQINsByL5ChiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3k6cuyhPFGnZix19fXPXXbW4H/boFXZyMaD1+lcA5E=;
 b=j3cNHcpkklShYtciTre86w4ZtA8tYquY9LsnXRvDVWn/ZhUJmyONA1sbw42UsJ8IPxMC6O6N3bf2cR4iSyiPoN49AWCgXHiMtz2lSBRK5yw7s9oz8fZjwwtSOl8ZoRGAZnv2Yz5py1mcjyMZPBRW0CV68xN6TA5dCb9tF3MqKS8=
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 19:59:49 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::38) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 19:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 19:59:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 14:59:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH] Revert "drm/amdgpu/gfx9: put queue resets behind a debug
 option"
Date: Tue, 15 Oct 2024 15:59:33 -0400
Message-ID: <20241015195933.2500409-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: c72b0ffb-d507-4dd4-07fe-08dced53ed14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?na96z1es5JbzpftxG+83597n9/9blbLFQD+fM4wjaa+HFwYeymhgQrOFpMaZ?=
 =?us-ascii?Q?OJaW79JOE4V8Tqibpxt2jC9/jBxvija44INXbnZHSjz/6tp+ifNaeHpaFZC+?=
 =?us-ascii?Q?zJwkLwpzx+fmvXnYI32PeM+/zUWk/GDvsUSu629cvRALJQ+mLq4TP02OGvzn?=
 =?us-ascii?Q?/v5C9gi1Tt+X6qTPa5yHLvfc+NlZOZPjCAogGZUPC3uOUP8cJjMCi0GwfrRh?=
 =?us-ascii?Q?ZTUo4hUXA3VfDgGlurqNh5NNBQ7D+fBWGbL7PB/AMYqRXyHkfzF8KX+ATWgY?=
 =?us-ascii?Q?vzb5eU9FTl/cUgiq9jeOpuVkdUPhvBE0n+bMeXN3ag8Zb8XB673L3XbwIWO6?=
 =?us-ascii?Q?vcAa/727jAPtTNZ22qFVoyCjkOz9c6N74EhpJi6ctPMnENCexHnBWwYICWS0?=
 =?us-ascii?Q?aHRJSRU+xoAyDgWR1zBB3+KgmHhuX9JCosQUXr05udNkfJHZ3gp2zlv2PS2p?=
 =?us-ascii?Q?Bl8RFjehtedwY1BWNYDn78l/gMAF2Jh9PvQi0wVpOd1++MBsmC2J53UcxTkj?=
 =?us-ascii?Q?WKgvaqrChRwShdRNL/1Hu+L0TQodrKk/y/B4LV2LNPS2PJ7bJH3PqkaLsdmC?=
 =?us-ascii?Q?Nj5KGeoaGGUM/pS24VqMbSai/uAaTcSufS9V7NPdj7+QQsXFmwj5D3D4vTZ/?=
 =?us-ascii?Q?T7E0WxMG8ST3gT2LbYhR9idoB6vqCPPfxDIUNlgCuOu+HQ3+sUwUvpdzd2k7?=
 =?us-ascii?Q?EFHz4fFm1zPhiiUsBjE24ySVEqQOlws6YUBYASIrHcuoMb4bBJzkNH+esqw3?=
 =?us-ascii?Q?dQpfYXnu/LvYns7W3eT5yUOyJztHs6Oyt5z5dB5LAQsTkM9uMVJY8d+4bs7/?=
 =?us-ascii?Q?j/AaauQHC81aD/WnFkefAbSMbE5M2KZnKtCb2DP6wQOFU3QI7HUOJfduaYlA?=
 =?us-ascii?Q?l8UQnFRH4Yr208x+XMpTTsBHamp6aKzQj8ZhOXfhr4bOfzEFR7znig90+Me3?=
 =?us-ascii?Q?NuEjiBa0/zDCK80o9fExEReQFbJAay2MOUZmbDOcQ8ppF3h1G3RyhsN9PV4r?=
 =?us-ascii?Q?C+jr/fYCBXiHw98gA86EiPSxShxxUQdhWcZ9hAD1uEAOo4LqMqnRn4z/0NoV?=
 =?us-ascii?Q?c7bp7yf6WlZ7v42xWr8bCcnFRsML6xli0cwftAB2USvvucwAY51UfSHvwJaI?=
 =?us-ascii?Q?YyD1roXMtNskyYIdjP7ZLHfmkKnjqnmWx9OyyMQ8axO88k6UR/ogrOy9PdJZ?=
 =?us-ascii?Q?zN8GW968OKv02AqO6umhIJSDUCS1vwJmWxJwgqXHGa2vtrV58jTPhne5ldPg?=
 =?us-ascii?Q?VRYh3KyN2mx8BtyEaAAksivLyTpJLscAyNc5iXWSFK49NV2L8N3IZTKCweU+?=
 =?us-ascii?Q?ZtYCXbqNpleVALJpCOCM6lbx5iQMBlCwEZwNmAlcV0jtOKhaVBlORPBH/TJy?=
 =?us-ascii?Q?EAtA4O0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:59:49.3942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72b0ffb-d507-4dd4-07fe-08dced53ed14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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

This reverts commit 7c1a2d8aba6cadde0cc542b2d805edc0be667e79.

Extended validation has completed successfully, so enable
these features by default.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Jonathan Kim <jonathan.kim@amd.com>
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 6 ------
 3 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 2817198d4b55..740525407154 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1132,10 +1132,6 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
 	uint32_t low, high;
 	uint64_t queue_addr = 0;
 
-	if (!adev->debug_exp_resets &&
-	    !adev->gfx.num_gfx_rings)
-		return 0;
-
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b5102da25798..508a2dcc0b1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7260,10 +7260,6 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
-	if (!adev->debug_exp_resets &&
-	    !adev->gfx.num_gfx_rings)
-		return -EINVAL;
-
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ccd17dca0396..4fd7e9c5856c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3055,9 +3055,6 @@ static void gfx_v9_4_3_ring_soft_recovery(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t value = 0;
 
-	if (!adev->debug_exp_resets)
-		return;
-
 	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
@@ -3573,9 +3570,6 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int r;
 
-	if (!adev->debug_exp_resets)
-		return -EINVAL;
-
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-- 
2.46.2

