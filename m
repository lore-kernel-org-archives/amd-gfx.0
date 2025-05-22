Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09491C54EDA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406A610E144;
	Thu, 22 May 2025 21:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b4az/SM9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F70F10E2AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aghUGNw+PMT7CXlrgpVW1D96wQ3HbQxkOP5YCiYR7CzBIUSCMxGbzb9+c/322+Qve1lM48VVjaYMiierviyDq+++KDJMAb5LrCNdiUHoFSDM2aqSdWVjOukBk3j69YKOQwCaMw3VL5m3iYvp5oE6SpfAnAran/mTjX7KDDo9S+BYL4RR7imlYrki82Vka9IpH6Cux8Zy8L4nirrZgv3gPTs6WpcecLw2uMiSybTD6nEZxghOasGue2ksseauZaJsasoXp3Yk4CBgBPtaIB/9qRA2M2j9Cw3bY+ToSnnWmMzBjImYVn1uvnfyaL2nQlQogW7H5pgmguDAFQyS4VrSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFMUMBtCDrSwUtiMcErMBV1YE/Z1I2bmTkkKkrQhOXQ=;
 b=oPi3eXwbV5v68QF5wDOFORK+2ZAFF9u8g6+UxmBBhB19dYKKpOXU0m2Nx5MpI2j27BIWqGWR7nOyKCIHcTsJyIb1vEVrxiEuVSVvRk5bzUqqW9OjFXs5sKRLCZlRx00ywVvivIeaxB8ZnnLFzFTsyZ7TWYrNoRJlTB2qgEbBsi85lKwKsV8++xehYxvCXhJ9F79wRQk9UECVrJ25MaexvBDePr0PeJf7vom4+muNCJ0oMyKT6+OjeETMkj+7dtR2Bzrfbch24xZvNZ/EPDP1ifJZjOKU25a0qSZdyTUjrYq3rDBqP8+vvTCakEL+lpUnJQl15gMXki051ROajo+hmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFMUMBtCDrSwUtiMcErMBV1YE/Z1I2bmTkkKkrQhOXQ=;
 b=b4az/SM9okKPAssKFS4ANlAY8157tDX2Y0gZcTAQUlSI+YbN6vuCUKXcJNEGmX9i7mZPBi3fZ9K/N+jnQlKbwLVW3HYltqV9tj4ll7JrpAYfiSiXZN6FzgXnnx75okPc4pvJaJGxYzeEl43srv704zR529FkI107fW2/aPdymVY=
Received: from MN0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:208:530::6)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 21:56:15 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::56) by MN0PR02CA0003.outlook.office365.com
 (2603:10b6:208:530::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: rework queue reset scheduler interaction
Date: Thu, 22 May 2025 17:55:51 -0400
Message-ID: <20250522215559.14677-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 40beef2b-c5ff-411f-9e7a-08dd997b793b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUlSK1BMK29ERmRPR0xFZDJFMFQvTXYrWXd3RzFaL0NETm5UMDVERWkreXBF?=
 =?utf-8?B?ZW1FcTJqUWphb3Z2QUx5MU5mT2RZakdtb3ZpU0ROUCt4Z3g3TnJCMWdxYis3?=
 =?utf-8?B?OFpqaDlPUlUyVHZ3ZUNtMnIzMHVsaE90S1g3aVkrdWdIU3NBQjVVS0QwSFM1?=
 =?utf-8?B?eGw5RkhTWFRTOGVza05Oc3lOa0lJL01EZzB4QlpvTmhkT2toeXIzTDBpdGlH?=
 =?utf-8?B?M1hHM1ZsWWxQcnVuL3NINDBBWDl3VEhocmtlTDZHYjdLdXhKYU9jRkZNMWhC?=
 =?utf-8?B?QWJkUTdyVUZpNWx6OHZYRWpkWFVDeVV2eEs1OEtmd2dkOG9uYW15Y21vWWMv?=
 =?utf-8?B?SUIwSXZONGpVMThsamk1QXg4ZytBL1V1TXU4UElRM2tZSFJNYmg3eXRrUVZi?=
 =?utf-8?B?NCttMU0wV2Z2aFlpbUhTY2h5MXlZc0p6YjdaaTNKUER2NG9nMm1TeWlabnpP?=
 =?utf-8?B?eThBaGR2Q2pYbkx4NFJKc1oyQ1hEbzdNTGVEdUJGT2tLV1I3RDd5TFhEOWVn?=
 =?utf-8?B?Y0U0WnhjMFdhbGtwWWExM3cwSEdXMEdQUkkxbWU5MjRCQktscXZLcUl6WHVm?=
 =?utf-8?B?RTdoT2gxLzFPbVZUVEd6bVY0bDZTT0diVUtuclZWM2ZWalRZYk9jNGJzOCtp?=
 =?utf-8?B?L3JFSXhvelpYZFViVkd5V3ZNQ2lLOGFzNkFyVlZUZTBzMlQ1QkdDbTJvRm5L?=
 =?utf-8?B?WXFWd2FCT1AyT2JhVnlPMlBwQk5rdkxJd1BSdlhtT0ZQOUZIamVSMEFJdHU3?=
 =?utf-8?B?QlcvdU9vUHIvVHE4NnllWjVDcm1wRCtyQnpGUit0RTdOa0tDRFZIZHpyanZv?=
 =?utf-8?B?TDdjUDNob3lyeXpKejFvVnkyZ3ZHQ3pKQnJXT2Z1TmxFTUFuYStERVVtNjht?=
 =?utf-8?B?REhhaHUxUWtLcVpPM2ZEaWwzRk0xMHR1d2dodk1LRnQ1OGFTWk5RWEh2TUZo?=
 =?utf-8?B?Rnc2bjZNWkNsazJlSHRiTU9MOFZqNWNJMGFLR09BMG5tQ1BHbFZ3QUgycGd0?=
 =?utf-8?B?TTNvQW1TaHBZUjR5bHIzTXBGMGM4N1h1M3VJRHhxSGdmdS9yOExNZG1xMHdC?=
 =?utf-8?B?NWVyNWhlT1A1S3FTL0pKNlpBdmFHcW5kRUhJTTdQWEVoOEN6MEkxeGFKRjNP?=
 =?utf-8?B?ZWVFc0diL3g0ZzUxQUJtTFI4ZlBuWGZtejhkN241VDZsVkRuYkZNcDRpK1lp?=
 =?utf-8?B?WGUxczBwVjlnTUJiRzM0aGZaOThpRTdMNHgyTG9GMjRvUDFvQUhTWElDNFlM?=
 =?utf-8?B?WkJodEFBV3hGaU1DK0pzc3BzelBhZ3RlVmZveTZJK3Z5RXljbCt3czA3WTBV?=
 =?utf-8?B?Q1VuWEhaTDZ0bDhPcFBjdTg5YWNaZGpLQXp4dGNRRVJLYkJCT2t1c1lzSnht?=
 =?utf-8?B?cThXaCs2dllaUGt4YlRub2s2VnJ5OUNzVlFlWCtQUGthbVEyZWdjQ3ozRXhP?=
 =?utf-8?B?cXUxbEVCVCs1VktjaFI5MEF5NFFWYXA0bjJpak9WajF0SGhPV3VxdlBZYUtF?=
 =?utf-8?B?TWN4a2RlbHJ0MS9jY1dhcitxcTRHY0pCdWN4b1U3N3JteHRyVStNMlpmYUlP?=
 =?utf-8?B?bnlQaVlHeDZORDNBVXJPYTJLSXkzeWw3RU5INU9yY3M1eUVVRXYwK0owZWVG?=
 =?utf-8?B?ZE1pdEUyN0E4UUdSOVV5ZVZwQ01vVnlnSTB6UmpXTUhyM3Y1Rll4WU9mdVQy?=
 =?utf-8?B?RlhRUUVEbldtTG54K1BRM0pZbnlvM3luZFJGQ1ZTOU5FTWQ4QlNOWGpWc2Z4?=
 =?utf-8?B?T2lkWkUzMm5tb0JBS1VhajZsWkhucnJ6ZzNvOTI4RXRTc1Ivbmw1Q29zZm5M?=
 =?utf-8?B?ZGF6S3l5MGljT1FhZGxESExhMklRK2tkcGZTWldmUUhZWDUyakZjQ2pLRE1G?=
 =?utf-8?B?bk16c1FnWVMxd3ZXWnc4N2d4UWtFbk55Z3NTaGovTWFRaEVSUmlGa2JSOU0y?=
 =?utf-8?B?SUFqa2ZEcWR4QU5OLzdNdFd4RDgvVTlQRjNWdDYzZFJQekE2bXh3bjIwQi9F?=
 =?utf-8?B?d3ZsdnV4WmhESmNNN3ZCdWxQV0loOVQrMDd6ejhGbkpFSkI0TWFsUTFjVDJt?=
 =?utf-8?Q?x7yxGx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:15.0040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40beef2b-c5ff-411f-9e7a-08dd997b793b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Stopping the scheduler for queue reset is generally a good idea because
it prevents any worker from touching the ring buffer.

But using amdgpu_fence_driver_force_completion() before restarting it was
a really bad idea because it marked fences as failed while the work was
potentially still running.

Stop doing that and cleanup the comment a bit.

v2: keep amdgpu_fence_driver_force_completion() for non-gfx rings

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 +++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index acb21fc8b3ce5..e57401ef85140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		bool is_guilty;
 
-		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
-		/* stop the scheduler, but don't mess with the
-		 * bad job yet because if ring reset fails
-		 * we'll fall back to full GPU reset.
+		dev_err(adev->dev, "Starting %s ring reset\n",
+			s_job->sched->name);
+
+		/*
+		 * Stop the scheduler to prevent anybody else from touching the
+		 * ring buffer.
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
@@ -157,19 +159,19 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
 			if (is_guilty) {
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				amdgpu_fence_driver_force_completion(ring);
+				if (ring->funcs->type != AMDGPU_RING_TYPE_GFX)
+					amdgpu_fence_driver_force_completion(ring);
 			}
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_start(&ring->sched, 0);
-			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+			drm_sched_wqueue_start(&ring->sched);
+			dev_err(adev->dev, "Ring %s reset succeeded\n",
+				ring->sched.name);
+			drm_dev_wedged_event(adev_to_drm(adev),
+					     DRM_WEDGE_RECOVERY_NONE);
 			goto exit;
 		}
-		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
+		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
-- 
2.49.0

