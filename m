Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EF5C02194
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2933710E57D;
	Mon,  3 Feb 2025 21:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eQmkObIL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5284910E578
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YA9u/HFwjO8+dgYzhrz4w+odh8RoQZ0cxk4eyubhNBXg3hBlh8x4rwAC96/Owgurb4Cg5eEg3kEl7ZxjhO0zVPLI75sTdOSm3eRPqtHq4VKLubtD3VMSqwZduQ1be6m5uiUZWn5jlMdKuhwX6M1wPR/dpvGk0yNDsSXmS6chv74IY3YeDXwKo2hFHkfR/n1ix7Y4SutS+1H4HepKBqlR+PNz7S4VcJwYfkn7KUL9IJvQnkG1Q3QCSsu4K3mMNGa6/dKnGsYJyS1qDxvZXcwFXhB0FbH3MRcKrYO88A1zC/HSbTggHH/y9de+rvAHZkaHIrZYfOY4tM3TIL+ngp3C8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNa7K8qrr5/7ksioZxEBo1plkHHPMm7Yabm6Nk1Uy8A=;
 b=DQA+J+CUEnH6ALoRGPLX3q2bYW6/gGBf6E5NBgnjK5u3MYu4DWa+W/rmJMvlA2OqiCaH++rgaqVkqpD09E9h9PjmCOARZ+2gIHvTiQ/inedr/+EhQJzGNdzJegHyUTfQpg/UX4wu4jcOR36Fej4hIR3SsQaGmaxd12QwkZqNqn5Khomu+JAl/+7Yels67KqqBHyDbELp/JmYMlOK4pefqXJBDgsi1LfmYXuwkfKPVM5fTWIYy12FoMoEVQ8kKzkxs/g+OFCKcQKaqm2XlmKylN2L4RWj2aLV9EFyLPDeg3iuYHkKE6BlYZVxFtG24cg3jl7ksdAoFIsVwxwPG1eSqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNa7K8qrr5/7ksioZxEBo1plkHHPMm7Yabm6Nk1Uy8A=;
 b=eQmkObILy2nkeIIT7eqbQQtIUwHwal83hnfWdM8EYtiOtX9t1g7BGE5fMa8KMwwHJZHbcxalYzpWtySvv/6q/dsL/m607lAcDmqE8RVPfyxi9PHQ8un9AHjzp8fepmRqvUEOlijvqy1BYBes7e1nZXNmODbOu0qitDTq5WVwcu4=
Received: from MN2PR06CA0024.namprd06.prod.outlook.com (2603:10b6:208:23d::29)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:44:10 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::d0) by MN2PR06CA0024.outlook.office365.com
 (2603:10b6:208:23d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Mon,
 3 Feb 2025 21:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/11] drm/amdgpu/sdma5.0: manually control gfxoff for CS
Date: Mon, 3 Feb 2025 16:43:46 -0500
Message-ID: <20250203214349.1400867-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e8b541-00de-4bb1-1d48-08dd449be48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZpfJk24IvWylUtuQpMXn4r/GZ+pXKjYEDbvnjDkLvSZ52STYnslU7FJZ5/vN?=
 =?us-ascii?Q?vURtLJg75TsQQoVfxw7pEWT9fgTDjpXKrx2TRdsoyEz1c//RV+/2TRNtdJd1?=
 =?us-ascii?Q?9G21ZS6sgGn+gUi2AGVEsFZvsbqzLzDNH9iVwEiTJlIhfEYVL3YGvohQDWUD?=
 =?us-ascii?Q?327JadrZ+MsAPlXMhtSBxvLi7AqZv3nd5WOOIK7GpcNPjeZpTDlOOdwGCot+?=
 =?us-ascii?Q?PHjGV/fpPiP15btURa6Qlp2OVeZU42KjkHvY5uVUO41mSbXWmkU681HsH5AF?=
 =?us-ascii?Q?p5avhJ3c1lsUW/6Cbsz68IXxvOmXUPTHerNoUjki22JI3X8HlvugSZMkXjdo?=
 =?us-ascii?Q?FG+bSMD1sLtYfhjgFQhTz+BHo5PGd7CsEsnRVy3WR/zRbDoRZ0AEAwP3T5P/?=
 =?us-ascii?Q?6cwiI/69awKpURyTEa06/zAZIMoOS6VG8HZFn0hKo+l459N5r108O4fr2s3O?=
 =?us-ascii?Q?klkC3iOkuEQ3q4vxXP3STCesr0YZF4d8x56OB7gt2DJ+30MFCgiUsJeYR3am?=
 =?us-ascii?Q?9+YiW3vFGvIOpdWAVIVUVg+M4K7R7RJBurG9b2BPEaN7pfrvSS8qJSVYyaEf?=
 =?us-ascii?Q?wG64/QDD7/FtXJudC9XDaSNjvEx8sff98fdcTHut4RWKyopY6osLhUjx3Nyg?=
 =?us-ascii?Q?AGjXAv5IYtJHYE4dWP7IsflcDCS9I3PGeclYUdcTkqATv82zzw9KraY2SLxf?=
 =?us-ascii?Q?6+p6J1BR1buepgHdPL+tZBn8WGkYDNTr8GupRTnkjRYCJMlfXTQl818qnadH?=
 =?us-ascii?Q?jx+M0nNXMQFB16fbTaAE8kFqGVEJdEjO78Wmbul3N5NQwTfMB5OrMWZxAaTh?=
 =?us-ascii?Q?VTUPl9Z2zpaIafoOn06y/jZ0tknyjU3QUHKuYSfWPbNlXpx8CgupFc0pHQZ1?=
 =?us-ascii?Q?MhloBzzdKqdEAakGE9xJzH2S6dttDuPuiA11LCxC9D3aXhnBkhtW7Snq7asv?=
 =?us-ascii?Q?bGsN+2AeQRZMVc/IHrI5dMFdq3ChgigPUS8uj7LEiR9ulCEpz/KV4xWcwacb?=
 =?us-ascii?Q?1rDRr1KhYKbzx3bW/a/DsagApZWF+TgpkTZ1YW8fPwxh0fEs6p9QD5nCNZtm?=
 =?us-ascii?Q?Rv+uFAOAlw2w3cjX68xcbvNLW6SUa60oHj5Yrg6NY1fw6hV0Mz/MqBC+d4qj?=
 =?us-ascii?Q?pa20rqgUUPpcs/V5Ywj0lzvxHcS+gIQwLoGhrah+YvCd4oIwNDBWFPw8/DOm?=
 =?us-ascii?Q?eK3nLw9pByfDPAOXHWiSCWuOcL4TAZ1p6aAP8Vhafp6DvEGBGfKLFQNhPOo0?=
 =?us-ascii?Q?8jgymdDWYVl1Nm+fesSqBY5qPb0d982jLbBnX6+SuVlHCw8YG7ulo5XZq1ba?=
 =?us-ascii?Q?rjqZkq6D2IenBtXVP597eNV5fJFpD2g4ZGa3r3mrQOb3JHT7yd8uBA78fbhe?=
 =?us-ascii?Q?9whz4SCTyxDklGJ8WNqr/T/WG9r45a0LD6WFOoMeo30YIwvpdXZ2HgtZPi7N?=
 =?us-ascii?Q?wDt2M65kvGOFmQ661Kz46Sg8weoMzjezWvnDjiMceUx/XZkMcXXKsvz08q9J?=
 =?us-ascii?Q?NCeSBIs8QWtP7nM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:10.0770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e8b541-00de-4bb1-1d48-08dd449be48d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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

Manually disallow and then allow gfxoff in begin_use
and end_use to avoid any potential FW races when
ringing the doorbell.  There are no known issues
with gfxoff that this solves, but it shouldn't hurt anything
and shouldn't affect power usage since we are only
toggling it around the doorbell update.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b764550834a07..cb4d253b22b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1944,6 +1944,16 @@ static void sdma_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static void sdma_v5_0_ring_begin_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, false);
+}
+
+static void sdma_v5_0_ring_end_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, true);
+}
+
 static const struct amd_ip_funcs sdma_v5_0_ip_funcs = {
 	.name = "sdma_v5_0",
 	.early_init = sdma_v5_0_early_init,
@@ -1998,6 +2008,8 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
 	.reset = sdma_v5_0_reset_queue,
+	.begin_use = sdma_v5_0_ring_begin_use,
+	.end_use = sdma_v5_0_ring_end_use,
 };
 
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.48.1

