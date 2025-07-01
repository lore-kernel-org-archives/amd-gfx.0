Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F9CC7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A6E10E62A;
	Tue,  1 Jul 2025 18:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1NhbOnnW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E6010E2D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quSCttjb6GE8Iq5QwEy63YWkrzdqHblKWOYFyf0OVU6AB1pLT7gLN97ctOh4V8mT1oaUUbN9RA3jFNrSSz1X+So2SL+c6XEeWctiAgMNVVwwfCJoVgtMi/vykInGCF55Sb1vvEVzJ4FBxywnVleUN7is9EwrRJoA0C8p0vKwTskzPQTZS6ItrFRHLtpWJQyAwA3nHpUf3uj0eoiNayou6RQyIRceocS4bZNIue3UpW6gA8Ry5FxwTotonmkQVuljoaUtRpElQ6rfdsfK/4wAzBv+9xoFMSuEUXeYlQKGzJlebIKBUxMAWHVbgAA8V196Yk3lG1WA1v4pkV+WyyotSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAhM0ySDYabhnzhqULnzVBft71MZQIXo0UBgQ29KQlU=;
 b=rE7C1Yx0eGgetzuReVb9EISWQyP9VX2CESERZWP90GmAWomyLSaKtntxOIjJUZs36Rx2wfxfClkT02nWmGfmrktJTcdrT8+HYa78ILBqqtqhz9woHRGn6RSKffh48at6S8e3vLa1sNH3V/TPXXHlgHB/93dLGHc+GD0bAsvbSrsn7gVZqaFHIcsoewHsMwLJvpCFH+fOz9p3YHx1RqqjjUom7XHcWYBR2CYsfqbQxqH9MWZj1HZvLFLiqhTGSuwjTs28pCpUfiBL2OFa7WiLAHGOMjT8n3QmC/bk3JNyj9ALvRZjoC+Jx8Eht4r3YRSB9NSoNm5FW3Ay/VEcfADfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAhM0ySDYabhnzhqULnzVBft71MZQIXo0UBgQ29KQlU=;
 b=1NhbOnnWo5MCIHHeedKQEfCWeil0jgqLyc9ecpXz2P88eCWumQMZIuQivasok53L9tjOJK6bX5ykIV2vsNiBzm0pfk+7oEwD5ADTfTLUc1QusL2kdMdiC3TqvNWBLC7jpK050uaJYCWs8DrXa7Sk590G2tZUXRUX71iSKBhBk2s=
Received: from BN9PR03CA0622.namprd03.prod.outlook.com (2603:10b6:408:106::27)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::629) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 1 Jul
 2025 18:45:16 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::a8) by BN9PR03CA0622.outlook.office365.com
 (2603:10b6:408:106::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 16/28] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:39 -0400
Message-ID: <20250701184451.11868-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0bcf46-9a55-4ef3-7e46-08ddb8cf6b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aBWMAUBw6fakqxWOdlSFLkiWr2LUzfT4x/+azWlzvMxZdMd48mSDCQ84RS2R?=
 =?us-ascii?Q?NSit5h4f020FHIUmtBRYifTK5fmkOjy378IF0pn81HaI7E7Ba/aQ2YXATHeH?=
 =?us-ascii?Q?+RqJ7tr1DAVzTQML5fPneHi9OnFBmfHWJGwtDol95b1lRmwwC0zjhJ/EKabc?=
 =?us-ascii?Q?3u6b9DHlcjluXLo5cuGlk4R4lNyjDg1NdnDrOVIiW/KJsVPL6dvxoqX6C/gS?=
 =?us-ascii?Q?gL3lgICswYGZTrPFXPb3aJpsnvTIRh/hbxFcic4WgefFFl+8VjvHAzVtzpr/?=
 =?us-ascii?Q?S8DdQOsVqV/06KFLfOf1JZ/3+i+h07sSKZJgqae+Y5Kc95sZz017+84sqASs?=
 =?us-ascii?Q?J3NMn0NhkK50I5N/c49bBLXVx0u3+QIe/AieGfb0p7qN2aeEk9BjgDfRTGE5?=
 =?us-ascii?Q?b6bNiQYDhDrzfkQQsHXzL/10NeX7Yt+g7YZuP+gUPLX88IagNojMpa24VU1h?=
 =?us-ascii?Q?g4MK7HDPVVzRWvZtX6M/CFvXGGvjIz9MDUvOwAVThCAPFQfbkvSOyEwr6Lsf?=
 =?us-ascii?Q?DKeEZjxf4Skm0iUVZ7HejjnvGCWdCFoplfDiYqlIhnJ/1D1RQQoBbIKDolvf?=
 =?us-ascii?Q?lugTY2Gt6mwFtaLH4iKwODXefXJlR6S9043SW2fyaeq6k7xdHEBB6mJkgkoH?=
 =?us-ascii?Q?kIwOrXSNLVTOorbV9MgL3jh22p9RHD+rYnTyapHxrWG+tPxlg0cNIPrhXUaK?=
 =?us-ascii?Q?QKmbImaKv2KTKAXpL2lW6STzQYvVR8wpTtqoFJ/avxjQxQS9YxUKoZzQHK2J?=
 =?us-ascii?Q?AYplZS8J/5jZSfE7om0bWJBIKjGrjaP0rrJb69mDJAWoJE13g6tk2Mz+/kfK?=
 =?us-ascii?Q?+5U33rYw0gw4clo8besaHjeyM3iaIUfylX7Hy2wP1j7mfCZnb6nIa7hrVlZK?=
 =?us-ascii?Q?vijVjiNhp1Vv7f2VNGciySKA0TZ7CKgQz1ezpYd1CCBhVHf8zahNUTZ0uaks?=
 =?us-ascii?Q?nenXTar8fPIic3hAG0uBITz5I6s+rte3r+gPoH85/tPIlUlF1tKregYexntr?=
 =?us-ascii?Q?qxOc6c++sYYcb5c/FV7ryws5rANii41tQasLVx7FEbQ1ftx/G6ejSs7gqxjp?=
 =?us-ascii?Q?dCeI3kxOLDZ9W3LX1R/1GQc08yCA45XisjjzRZoldT1xzAljUwUDMUBUKGiH?=
 =?us-ascii?Q?6T7zmM9ePSsz9loeqO3m+xc1ezIOIjdgqodHnc4Z7JbgPYAljszZqYs510Ja?=
 =?us-ascii?Q?XbFPsCMt1J+zDHULiARiUX3omBW7J62kXObmvHgnGH56WhhsLgGP6zP0Ujyc?=
 =?us-ascii?Q?CMCpAptIVrFatr3iJspbCEsppFZr+dyE5Vps2AwRr3451fwwQUDNXS6Mx9WF?=
 =?us-ascii?Q?HCnePqxyfZwVmyNbHEiGU9s1FkMZL/ZFYcfhjZ/6xBey0m1v71qBZh2nxFVv?=
 =?us-ascii?Q?z1tEgYF9ZwiJ/RjjP3HV8BPp8euCKsrBayI5cOvj6fSwbcYoG0vqwUdAwzZW?=
 =?us-ascii?Q?s80MqwKxs+EuZ/LFeeKmu/UB86H++WyuPPSTHfJUy2JepO564zh+4uGOqJVf?=
 =?us-ascii?Q?DBqgDNNs3oXvQVVHR4Lb57/p5DMlJ+gVwdd1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:15.9256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0bcf46-9a55-4ef3-7e46-08ddb8cf6b9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 1d4edd77837d0..e9acbd5afbb7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -724,20 +724,13 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
-- 
2.50.0

