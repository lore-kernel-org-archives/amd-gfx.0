Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787BAC83F0D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E02710E52A;
	Mon,  7 Jul 2025 19:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VS53K1KC";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0AE10E523
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADt2ccG7ZSZm6i+OeIBgrbN4lNZOzPv2T8WnB9eb3AMv6ZXonCEmCg7rgQJAn4qF9qfHNMF0EuW70BeK7kgabtw1ODWJHkQXEQ6q39+WhV86cc383VageDu+apWNZOxbW2/t0IX3wkAJ6uOI7tnwW1dto+kXc/lgnYeM1h3Tk/fZ/uI0oVK6Fi9hRJs5PgyXqhiPV3WL/XsTzmjEJodt1Uo3KhLozLl+6kCo8ZHDgmMj1dBI2b/8whvYxSWCz+phZ0/T1sRR1ttntmdomI+90oRgu+bqI2Hh6QmGO/GsUncFZX8U9+r66S7dAlmiPlHoEclqRYuqRcFfXpXbsCIaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=kgc8h2IwqTN8jej2XOCjEh5RbkydOM+WlF2CEyZ14FhRRbnJJpjVLJ8fcesS3xxh4s1NN7yrGXfXc8ctlgTWS0BjXJnEOM9QZfyptFfOJfkKy0hl3ia41FYLeSXuKV0aZjmETSRby7T1As5Z2tBTR6tyKhTuqX0aHbREsUJeEglIgSfqHmxdC6BeJ2ZixIdvmQ/Jo4gj22K0rs7hvfpo+5hZrOt9C9hWw/hv0CrRCwxC9EtxhLtKob52+kLH/qyHXso/i9yZIrvAw0tBDvlqKprJJKlSDuxOvsMCxYHR65xOYxYwLPNmTXeTEf9qUnnrD3kOQw7BmmTXGy/TygTQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=VS53K1KCFl20TZGiL9v6fSKgvZ5hA4Z6bjzaVpliRhRleqxLfs1GeF+D559hty6jafy7vBZCwEWICwUiQ+Zmv1hnSErRGS+vGnajSmES9glO8mC0mgTZQf4OV8rxiP+kCfVS0QiBBd9IW+XkreYLhpVvuRrRlUm2epDtlRHuVZ4=
Received: from PH7P221CA0077.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::12)
 by CY3PR12MB9703.namprd12.prod.outlook.com (2603:10b6:930:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 19:04:28 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::fa) by PH7P221CA0077.outlook.office365.com
 (2603:10b6:510:328::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 28/36] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:47 -0400
Message-ID: <20250707190355.837891-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CY3PR12MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 7640ecca-e29b-440d-ad0a-08ddbd8918e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YYTKc4BN9ZjbtkCeXF0Ak3BI3B/BGLSg+b/1J+/IqxxsZyTjLu2f9jNL86kU?=
 =?us-ascii?Q?gdh3pKqeqmJMP8UJI9iTOEVU3h1C/IcHB2eUrIiJUE1CvzMMD78E1bR5DE5p?=
 =?us-ascii?Q?pFB6v7EwsTKDRNzAD+8KwqmpySjQVjs+Vy9SmMfIbq8sAeDHUVTj+zYICA+e?=
 =?us-ascii?Q?EMYDfxz1BcYO+MDt+2aqJOiOebVj6VTZVJw9A3FvNpoYknH/EKBJ6TJpM0ff?=
 =?us-ascii?Q?QTCw+or0PjlkWaX0oGtr4lJByaOlUca/CsvKHKGZJu/pQ4rCUmQVKz20VrbP?=
 =?us-ascii?Q?ySvJiALBmUuZewN6FB2gx8FT7ocU8bfe6THOhq1IJMzhJEDtQC/wtjBV4lPh?=
 =?us-ascii?Q?D3EkvgpnbTHoHKNgLkVslhdNRXppEg8+F9qTZ+iql2rTnIr+ou7ZFr65N26w?=
 =?us-ascii?Q?cb1bdXJIK5Blihwm6s3fKvkmtuDNBjnqxilxooCaonenbQRPXcsoRAGdz4vo?=
 =?us-ascii?Q?RJoAK8lCoiO++Dc92NdhI8qwKY8lluc6pwBG3mDXEh7TmHs7W/ei6XjYvwq8?=
 =?us-ascii?Q?B4s9Elxdsi3iTemhBMU0y2vMRI9+v4OoZTR5xIDwzDhs8fdsktxtoIOJ3pAv?=
 =?us-ascii?Q?9HCR6VLIgWyJP3fyf98KfOX10gSIKr1PhvsH2GsbPNedZzywG23wgrOsryPG?=
 =?us-ascii?Q?/2rhogBp1OJssXlL6Wpsjh9VLL/X56cFfY+OI78knbZdCZR9c2IH3cNmHdv9?=
 =?us-ascii?Q?2dhvj7AfwaPrB401KrNJ9mVTYhirrbnrKN1O6D71q0nPg+aYFL+yKBh0RsqE?=
 =?us-ascii?Q?hlv24S2tDonjDpOc4wpBi5Cpd2n6DI+ofoDucwoDsKS/+MaR3xKDOu14z1Cb?=
 =?us-ascii?Q?kC7EkJ1FShh7EBZtJV4yBj06BN1TNdphnbQnSkkLI1mKbUKZblJSceDFJ9ih?=
 =?us-ascii?Q?0Dqnf1j+dYoHRHlN4SOtdE/HvzQX5BcgQrLwpivagfzZ+7VXio8Y5a5N5hOy?=
 =?us-ascii?Q?bF7yk7Xp+HtUD9rDjL3IJX0oDojDSZ0qbO83itAIJfxPvG2OBVCp1VV1q4Ye?=
 =?us-ascii?Q?KBwV71IOEXyTodroXQ60+0krzIBw77OjBiPip4J8PTsYMg/HBJuhBDF0ILxV?=
 =?us-ascii?Q?2nJH6R1zwfbNklfBA38cPKVdeFdGw4AgC88xqP5NVpzVSD9m3XPH8lK1j3Hl?=
 =?us-ascii?Q?6WAmmNIGlOugt0brM4eoQGlJVVmj/71ES3NkQqBjGmFwtBCH9+Cy008dgI6h?=
 =?us-ascii?Q?QajqC7SUIkAi2wbuwYdKNmWvCCeSNumNs202ZEdWE5TqQjZVVSkYS9fwHk9D?=
 =?us-ascii?Q?kgS65q+2ZV538fsNLBzjzCcsC1FlO7kM5GkHwPGVu40/RcB3PGuqVMIl2XgI?=
 =?us-ascii?Q?/r16Rao1AfKopMewTf/KyF36L5VtmAyGSJ2cEJrBrkW+s79q5c5DB63N5p/0?=
 =?us-ascii?Q?7V/pkECqtryKau+PD0JXvYqF+KPHpPpwDxwcslINfAub9t5fZFBS0jPFfP23?=
 =?us-ascii?Q?USuTGDWRlyOO31KlLo12dYbFYRO5YCS85i/KW0+5MOMiSnBqaU2LUQgjHFZG?=
 =?us-ascii?Q?tRIRXiAesXENP2vntuWkpmUMem+YetJQRCCd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:28.1731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7640ecca-e29b-440d-ad0a-08ddbd8918e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9703
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
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 6f8a16da9d608..5473cbaa5c0e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -838,20 +838,13 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
-- 
2.50.0

