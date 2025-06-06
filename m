Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928C5C61DB8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0958510E98D;
	Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Vhjofo/";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F0E10E910
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycShNl+7wEsbEwmh8+FgBGJXH+igLe5mPep62qor8SEu0yq8a6QfhSkxjWJUvnhGjYMKnvE3cas7bJB+MbWZlJv+mRfAUvllWKqmmPNcxFNS5GFk0jS8AvluLNCYGetP5ZqlTkWKCkMnkuU742g8zjw/O8pGatpjyj4o9c3jcaxBKT6Kwl0qVVLywEGVGCrBSBHaBRoCMyTRyLnyHC6iMgvur+mNJnqRz0QNMAOqJ11mvAevjwQoiFmNGV5Kp6f9eYsoGvHJpTeZCXuatPmXGoy5GmIAZFKG1RDIiaKzSgw7dSF99KgG0X3iYDvSFr2iHJcoD8URT3kBQ3TROcmBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5s8iSAjHVLPsEfE69YeZnztP2LHZLiIEFJb0LAs2FU=;
 b=uxf81dSyoPletil4KZvZB+rcxgNvAOrIZSct/TAuEC2AMwhyB5t21mcUqEZgEsrVInv3+XfTTTPRW1/ySFpCpc5CJ1ELZ20aDqxyfhjiwWTPGZdM5xDUhJHS6VZ5Jr4f8aP/5rXN1y0SuYL0iuu8zs7WDDBLRw7chWMOhonXudKn9JygGIJjCPSsVMXShdBhpsHKsPfLlPi82cMQLtzFE2cxcRhZvfdgzGuNzKCEMfhP+MNn1gNG4VST5FD+sT284l3ndfrQ37xVXQaQv8oezR0DhlT6fsvsMpET+Hg+h2skAeTr28v5rhxWSbj5oblFxG5/SafRpG1UKpntIxLjuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5s8iSAjHVLPsEfE69YeZnztP2LHZLiIEFJb0LAs2FU=;
 b=5Vhjofo/ELSQ8JCzdPie1Yn8ig0zLQV+ZunwU/ijNT3eOqE1j0Z3j+0+EXLCMPM3YDB0fA0VqRsXzI0t1ayePU7j1+a752UXW6IM8SZu2NWL5k29msJrUIHQ68FibYKmmKa7QbhiSNIOLznztpH3e5A9Sa4q9Z8GMfwxVtMKuVU=
Received: from SJ0PR05CA0145.namprd05.prod.outlook.com (2603:10b6:a03:33d::30)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Fri, 6 Jun
 2025 06:44:22 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::60) by SJ0PR05CA0145.outlook.office365.com
 (2603:10b6:a03:33d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/29] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:44 -0400
Message-ID: <20250606064354.5858-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fda19a-dbbd-48b0-51f9-08dda4c591e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ni/oEWGj2FY42pXC7u2nfgIMHqKCV8STKbrNf44NW2VBV79L/EKovVveZ2kC?=
 =?us-ascii?Q?nHKAr3YTo/Cc4ikv01lYVYXYLzHzc8ElFfpk9FTreuJ4XytzPK96ELTLWjbk?=
 =?us-ascii?Q?DL5LWDXQjXB0eW9efPIydhaI9TpBbdBHgF0FjHx6cGbuQaBxyTF42Dyi3muZ?=
 =?us-ascii?Q?Y8J9kAYC+Q/wxciqEwSiQPrx7en3kMUWG3zq+HHdiUtvGt0Pd22kFQUkDXdA?=
 =?us-ascii?Q?DX4eDT0JK7wzY3HF7s3EMr9ezXV9wZ3SaUIQHNxYHXOMi6KaLvkrN0+IrvXM?=
 =?us-ascii?Q?K92daqO8PxKfLSAWl2YypFFF9UNrGjdZ1k7RGpoI3VANO1q8lz8dZNumkT0l?=
 =?us-ascii?Q?WRDjH3pq4YbejQXaHkMeRSWoPjs4Pfjgm5wyrWg4aWUCcasPODQEAj7+cli/?=
 =?us-ascii?Q?CWPK8u7/2OHwV9GibolYr11C+L59OIugZ7VUsYMYIhUcKELaR60ZYOg13Jmy?=
 =?us-ascii?Q?ttOwifg1dBIR81ZIMTl8a+AhAcLFmtogeswnSTGST+Kn0IpAJtvA8QKDV6DZ?=
 =?us-ascii?Q?ZShTwlWZD6J2ZAja9pVJoujto1TcMwqYJhF1orvA9hZNFdq90bwk1YoB7nOU?=
 =?us-ascii?Q?sTh0i82jwBsu5bkHeRvB0C9EmiYwgYrL00k1i2Lu+puUAyvdj0Rwo4OdMMCb?=
 =?us-ascii?Q?RlW3wDRlC/yZongmo8CGQZsf4/Tala/cPuV5fnFTvKkT4+bgLvaiqdnZ4de2?=
 =?us-ascii?Q?osRb7y4Vp65VXYufqlcervg+Jj3LmOgyGF9NQsto8sSl3AKB4aMsrMib8YYt?=
 =?us-ascii?Q?X7EnJ0Ntj6N6rSWAT7s3yrbAYY5REpR76NnKOT+GJOL8b3GmuZcn5PHhf5W2?=
 =?us-ascii?Q?DV9cJj1duk+VAzAqYH5AJhr9/7oR+gFMwswe3G+rJL8UgP+3yMCWdC3XyG5X?=
 =?us-ascii?Q?kMr6IqkZ7idkXcBLG61JhTFq8R7FX8tSkK/LNZoY8OgEi0ycJqUU8e/6sC8T?=
 =?us-ascii?Q?4LFln3oPCtsEZrCoAxDlgCpicAv0b3gK+lGv1n+YbZCDdcQBiy9DfS4Z0gLp?=
 =?us-ascii?Q?IS9c0XMaHkZI+HuQ0MaVIJrR2z0oPRcwGSNYMBp3APu1MKwF2/ZIzb1Jccn0?=
 =?us-ascii?Q?gTd/sI2qv56fmk9YPc+3S1Na7rY/PaGEkqFynoYTcoqs7hkQ6Y4WmD+s8kNR?=
 =?us-ascii?Q?DhHWuLZbLI/WMhVK3i87vZLmd/ePdsGC1TMllDgj/sb3jh8jWdUoUw+UKZ8f?=
 =?us-ascii?Q?1pH+9DD+l4InyKZ7baRHWy+jFpg9vsn0ZmAkA+6Q31I8DqozW8NuA40O6Ilm?=
 =?us-ascii?Q?R2Xdr/z9s2hMK3/IEr6dCMduYqUgIRCZITkpgfzCgvYAbq4y+B7ZRExEglVk?=
 =?us-ascii?Q?c07znFaeQeL03dKhmVKyQURsW6OMCccIUuljnEdKhQvpNEle6X2ymH0NDDm8?=
 =?us-ascii?Q?bhwTjO/JzUk5W6MUby4THwmaxrrekW6BfBKJL9WFR9B8n5unCpdWEG5DuaVj?=
 =?us-ascii?Q?cP6EHVSHEv64NWdS9SPL9iZ8WGRYnvegyjUSx/BWyf6kdXoOsAxp/IzT0JCu?=
 =?us-ascii?Q?/9Bs4QGrFDaPuNkNeKQjagrA/lPQVRFP9RSo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:21.8191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fda19a-dbbd-48b0-51f9-08dda4c591e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5eb86291ccdd6..8787958fb90e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -648,14 +648,22 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

