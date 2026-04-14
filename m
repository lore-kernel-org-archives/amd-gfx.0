Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BE1ED7B8C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 09:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA6D10E5BC;
	Tue, 14 Apr 2026 09:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYePqsZG";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA3510E5BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 09:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1jmRyJwThXWWlbUQJ26DdIqEYPkt1QKzZAne6nD4uJkAur/G5hvBUPrrsSbKQ64VDAGb31+4M/nKoH+q/jJGhOQGvY4BP3KJpOYIGZM8LecMLuYmAfNCeU0/SQs6PgTtf/54xtQSfXCmqoyGE0SoPwx0uel/SfQiYXh8NB0LELmm8pcv8ALUucFYaMASmtUBpP+lfmu68tw+s5IpzWl1QsORMsLsdGYniuxbXVVUv3S/Rh+yy77EQwqhzr8ykRJFDAA8nnPx4ObUo0NrIkNU2VgBmiFC/7AoKZpt1yibfcdeWuz8Npv0hQr+H2eTSPvQkXRLLfYyodLHCbPXU+k+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ga/NnP2ABNJ8CKRyRG+z7t1a7OwQ+t6khD2Wsu+F0E=;
 b=RbPpPfgQvglwyWZSe+vNJShA0FIOdkPT2h3fvhlw8XR6KCBIKVBE/NuaMTdxDWH5pdp+gIPdcts4vb1MmNCA3A2lSkoe+Sfi/kcSD0ctZ9n92CPx4jxD92KhsBuytLpANWBQ0J7jT4hFIUehwZmxi/fgyWi/veWGX+TeumRskUze3DnG25+fPx9A/Y+U1kLm5lL5GF8Vrb/2+bxUB9BRNmHzqmhZ29N9+RlQlHPy66dmGiGodCr336YqozizqT0zIiA0MNl5DbtxxVZeXCEJ+80tKJoHRv2yHlA4KMH7LyVTq8ng0Bntb2w/6d2mXi9e6uFcAU1FgEaTe6Gz3CNq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ga/NnP2ABNJ8CKRyRG+z7t1a7OwQ+t6khD2Wsu+F0E=;
 b=CYePqsZGm9cxrsakXsIS0yBRuYf8uePSACLgKXdH42vMlLkvfCjy6Tso+J4SBpyJ5+VtMVm6yzaVKBE2JYxxprtTGyYTNTRZp4UiqcmsoqDNZmqxrl0aKuWYy1/+3BT7ZxG8ebeY3qt4VO7b8tY4QYOTpT+WSwZvxGdM7uYkrto=
Received: from BY3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:254::30)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 09:00:42 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::b) by BY3PR05CA0025.outlook.office365.com
 (2603:10b6:a03:254::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 09:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 09:00:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 04:00:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 02:00:40 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 04:00:29 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 7/8] drm/amdgpu/gfx12: enable per-pipe reset support for
 compute queues
Date: Tue, 14 Apr 2026 16:58:54 +0800
Message-ID: <20260414085926.3171086-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
References: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 426bd136-77f1-4f2f-665d-08de9a044ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pYLzDahOc3Kt7MxGugk7R4CPnkiG8/CrqJOIldpoH5KCQbhvjCHy3cU5MgVIb0Lh7/DeLnIPxpp7nhMr4V5LVo067b1KU02O/K03XupXalmWMN30zNZ2XrwYFiXJXN+2EtCVOqBJi7BntqFxV3YHBNJWVtri9FfTDshzMvEJhkv2ACi0pjjd+S7OYJ3nEQEbbVCMByM40fchPTCy/2iKdR9dH2HSX84PStzZHJsCdMRAhS2TWrI6jK6y3SSw7FjeHX+ctKZHbZ13H3GwzpAdzpwADGpNM6lWpE5LfVclAUcHAc0D1a1l62OYMsXORMlpQyLReYN7MY7siwfjzplmmBK/cQd6ivI2NWmZOLeJ6obhOlz6ini6VBvQkgj8J2vJQ7JyIa0Dg3oHHwVmA3Er1xbLis5vUwfngA2URPeHgrnAvCGQUPPT6cDIaearHQ0NeLRXGlju/cpsZySRv6rsKz+WzSDHnDVj9HGBzkvxOp8hzWFWkxYYGYLlX/JySEDb+Ke7myPYwCQZWf23C7YIhTTlQv227AKrn4lcptDCeFwM0NKwMvQjpbpif24yABo6Y84b0JuUpKYXcZSdtvjMTjhXBV6LkxE616Ha8lEOAl4jjxogms/wOH7jsJ6pr1TELa8CYlwztS1kRjcPJz2f5txiogeQYsM7pXlrii7zu95dtxg4MspeG96hWONEpsTCTWvrpmsdpBUw89itigYBOGn7tGCXRIEsm7X371J2ni7Yzh+xjysHiYJoWqg8AxTjaJ9bokg8PnrzP2Hat3shzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o2uO4CEql5Xfx5VXmXKsix13wI5iEgm3EJ3pwqgxAjYS+8mNHrBmUw/TOCbfh505cR0cbPG4AcjVMsKlu3FCnrIvZ1+S+3MGNsqR5aaQ2GFLpmd/uD2f8aEEIpnA7aRI0ZDHyZtZSij3zOZNx9oafXqUjlULwvvnmDHorQ6hJhtTfSkCGMmCVNmcu6EVcFPZRqn6WmYLW+QdInv4hn/FaOcNoiNdK2y/mdqOpA9LBxPR+yc7arawLK3AQdpt3JY/QQezGBgLiIZ709PSVnwtv6rb0Blc6qJ9Jt5E9ZyzEfB+/QE1qNua3zKeclq9uMrurTL6BgMFLTBw0ndxIaKm+j3+6wAzGNKv7tVOHA0i1ogEWt9S/E0oBRCTNreo56agUaOZdGpuPrRGxqwPo5aXNeQJa8ZbMTfi0NJ4NtIhDcCL5vzA1vEtzSgyHwzIJia2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:00:42.1647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426bd136-77f1-4f2f-665d-08de9a044ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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

This allows the driver to fall back to pipe-level reset when per-queue
reset fails, improving recovery success for hung compute or graphics
rings.

V2: replace both gfx_v11_compute_pipe_reset_support() and gfx_v11_pipe_reset_support() with
amdgpu_ring_is_reset_type_supported (Alex)

Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f90354e2ab3f..2dcdee1eef1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1557,6 +1557,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			if (adev->gfx.mec_fw_version >= 3190)
+				adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	default:
@@ -5257,22 +5259,12 @@ static void gfx_v12_ip_dump(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
-static bool gfx_v12_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
 static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t reset_pipe = 0, clean_pipe = 0;
 	int r;
 
-	if (!gfx_v12_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	gfx_v12_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -5333,6 +5325,10 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
+		if (!amdgpu_ring_is_reset_type_supported(ring,
+					AMDGPU_RESET_TYPE_PER_PIPE))
+			return r;
+
 		r = gfx_v12_reset_gfx_pipe(ring);
 		if (r)
 			return r;
@@ -5389,9 +5385,6 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_device *adev,
 	uint32_t reset_val, clean_val;
 	int r = 0;
 
-	if (!gfx_v12_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	gfx_v12_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, me, pipe, queue, 0);
@@ -5485,6 +5478,10 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
 		reset_mode = AMDGPU_RESET_TYPE_PER_PIPE;
+		if (!amdgpu_ring_is_reset_type_supported(ring,
+						AMDGPU_RESET_TYPE_PER_PIPE))
+			return r;
+
 		amdgpu_amdkfd_suspend(adev, true);
 		r = amdgpu_gfx_mec_pipe_reset_run(adev,
 						     ring->xcc_id, ring->me, ring->pipe,
-- 
2.49.0

