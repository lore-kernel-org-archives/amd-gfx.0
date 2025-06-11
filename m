Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E50C677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 07:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C74010E359;
	Wed, 11 Jun 2025 07:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tNJ9JskX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C483410E359
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 07:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4KCnLL25tZKTQr7gzD8xZCY5T09Zx2zfFThPGkf7NCi0RUmBoPU9EujWjpzjfEBpnhaOJSVO40GunCaOWVnfkS/X3mymMFAnJXJ+5TsW+0bLm9s1OBqQYaGdjR2YcHWoIj8b+2bKKrSDJ8fxAHznLNyqA7LjXzDvRyMPkvInSGDteJM/DTTOfKGtYKHDgtLvuo+BI7K+pZSUbQgjNEnCkXBri3jB5Yqvcua/hlmZlnoMNNSwnIDdg3KfzgUofkJSfNyaIq2u5zb/2CIq+ISLkiHhpsWa7t3GYjMPTUCgLy4/ckNz1KWZ29HHUbbxAGq3RBfDHPiDLka+HqTb7g2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge9US5is25TWWmlwZvItgwDBTVRtpIBC4i/QAETMREo=;
 b=JM2OebO/kfJ1IuA6NXbelFHLIuFfFmJRaFMYlbO0q0ljtEa+OC9Oxhgnx0bpmIvfpk3zDQXUJ8UQyGzOzAPrb5gQ7+k5FaD57dm8RTH6byblJtWDLIyX3Y810OYTO97j6D0eb+bVJW2CSElb7zv/gRREjMkfqbJAZcn/M77ZPgk7gqiqmbU3HUq0qEiov8u3y98lUYUYL2uF448JbHUmT/WRtOlukQKzFcQJRNaNa79gUGTe5yBWjlT/l1tuEfCmJlYtSlGGbi69gqciOUqC1PxjJ37sfmVqMC1/Ev75A4YqRw4CHgdrtwyO5XUJ6iyYpB7MXb1oeEEIlYsLwX2WSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge9US5is25TWWmlwZvItgwDBTVRtpIBC4i/QAETMREo=;
 b=tNJ9JskXkhGUMQVFDRJRQOTMi6PpLRUCHk2XOURk6CgEoNA78AFSBOx6qN9zpLZcRfFIO90esMXRE4Vr19IHe0bBEoRzB7P9vsOFearWOuiaqBcb5IZHS0Zcab99GZwdHhBSiLhwB/Ja7Vgs1ZfvTNdSlVuQci7W7L6UdCWHsq8=
Received: from BY5PR16CA0008.namprd16.prod.outlook.com (2603:10b6:a03:1a0::21)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 07:17:10 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::2d) by BY5PR16CA0008.outlook.office365.com
 (2603:10b6:a03:1a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 11 Jun 2025 07:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 07:17:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 02:17:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 02:17:08 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 02:17:00 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2 V2] drm/amdgpu: Use logical instance ID for SDMA v4_4_2
 queue operations
Date: Wed, 11 Jun 2025 15:16:53 +0800
Message-ID: <20250611071653.3311129-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611071653.3311129-1-jesse.zhang@amd.com>
References: <20250611071653.3311129-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: ce18775b-a55f-4ee5-2c1b-08dda8b7faf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?knJzTocnvFcrZ75gtV7JNBzq8yHVwe0LfZpJrDGTgBpFDSilVGvtO07rw9FO?=
 =?us-ascii?Q?OkH8fZ7b7qHlUBOwkkmfn1cZQSfLjx0d0fg3R8v+iy8E6qj5Umk+GOgFS4OT?=
 =?us-ascii?Q?Ia2cdN5ix3CY6aaYlcQ26bEt7vU5/vnAR5q2KV9hzxruVs0ZqMgqT1jyfpj4?=
 =?us-ascii?Q?z57Z9iPEe08m1Xh3rzOitUWvfi+GxhE61GmyaDj14yk33ZVCpIU28KgSP9h8?=
 =?us-ascii?Q?i0N5J14FczS+TMJh3LIqdwVBfdoep+5cy8iwTRa1O/b89J0/yhUAhJdGG8Cq?=
 =?us-ascii?Q?UQMHW9fKDdRLVni5HM7yLmnshYLFqM/ZKlWoapqIdvCw7MSziWh4adXOApln?=
 =?us-ascii?Q?hNaorufzbgwNNoUSTMyoxK3ow+oZdWzGk/o0k7bhXgdHdf3nUkKzS7lX3LM7?=
 =?us-ascii?Q?MzsLUUzWULFUM3rZjoAl3l+IT1euk91PqHGmX53YMn3Yq8t5S8Tv3YtzPmSQ?=
 =?us-ascii?Q?CVVsZ5MvHIShxYSShsPynvIiI6P9YOHFIv3jW4vB4FS/jV8naHr2bi/Hr62L?=
 =?us-ascii?Q?kEEuNyjVmXGV6qshJwn0qTUT5sK1yopTPXhvoWNKPEU8lspB8s+lAd70KUWV?=
 =?us-ascii?Q?Y/v+1UN0wGhudY5FqZs7WLdcdcWWX7yb+WiyM+Bdvrv62oDvwZSdNnGRicOz?=
 =?us-ascii?Q?ew39h4HEHxGR4BnDgAMt27AdLWKogzEDxcw/PkliVtvciRG+5U7SuQwwdIRt?=
 =?us-ascii?Q?fFtlMq9lW7Wehad/BcxFUJ8tW6mWJ9XgDAJQgumxtndxzyLe1JZlD6HouUD7?=
 =?us-ascii?Q?iXh45fb58gMYzQOeAs4SvtaOxO88WfDcqzQxI0WNDu+HZBRDLiAMZGuf1sN0?=
 =?us-ascii?Q?7T4m3d0Cwp4Ot872nzMDW1yEP3oFakA8tXI5ji4g4N/CsZrTocJv6ORPLMnR?=
 =?us-ascii?Q?RVluiYIdsnJ0rEl/UdOQDTX1ruLq/NYL3lbqXIn8vvUUxIY2T23sQ0UksdGc?=
 =?us-ascii?Q?bZ3/tRvf4MjZMPlz38yijI9YU79qMDpFAMb2ymUl+sU0YnLr/eOP2ESOT8LT?=
 =?us-ascii?Q?cvFVVxQiPPRGRBPtlgVayf/nIKPBldWojm/jybh8SqUncZoPv9/ivuN6gydu?=
 =?us-ascii?Q?fZvnEqON3oU77P+GOy4P/af4MGXn+JqKO9jD7NvDGoEh5AjxvRhjehbAd+5J?=
 =?us-ascii?Q?+oQZCPZ94/4WtE55S2S+PGmvRnN2lYWS6I12ThSTLebdEhNjtAnJAzK/ekMq?=
 =?us-ascii?Q?Buju8H8UHTls5LJ2XE8NEOkFrVmEVCYMKcKD968XQ3N1pGRKAtVe2NKeOXKb?=
 =?us-ascii?Q?V69485CrMgL1IOerwJlIm3qm0AzlsosPdOhILZfz3xpmGIy5nuw9XQxT8ZjO?=
 =?us-ascii?Q?HVLrI4O0r9/4BDT1CQmFM0gxc++8WvRfLxAznPfudu7e7u31oLarMUD214eF?=
 =?us-ascii?Q?9tiu/+HslJc9TEWghluedA113TuZ5wd9K34KN1tCzHqfs52AroMkmtZgKx6C?=
 =?us-ascii?Q?1LlUZ5+gSUHy1AV6mJ1YwBdd7JckNmDIG8TX1W3mMsnLCw9n/mPQRYGogxHR?=
 =?us-ascii?Q?7Ffc4CYL9FFEmUwHNfyLMG8R7ivsFBnBFJjC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:17:09.8010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce18775b-a55f-4ee5-2c1b-08dda8b7faf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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

Simplify SDMA v4_4_2 queue reset and stop operations by:
1. Removing GET_INST(SDMA0) conversion for ring->me
2. Using the logical instance ID (ring->me) directly
3. Maintaining consistent behavior with other SDMA queue operations

This change aligns with the existing queue handling logic where
ring->me already represents the correct instance identifier.

Signed-off-by:  Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c169112a5e7..3de125062ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1670,7 +1670,7 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 id = GET_INST(SDMA0, ring->me);
+	u32 id = ring->me;
 	int r;
 
 	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
@@ -1686,7 +1686,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 instance_id = GET_INST(SDMA0, ring->me);
+	u32 instance_id = ring->me;
 	u32 inst_mask;
 	uint64_t rptr;
 
-- 
2.34.1

