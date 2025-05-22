Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D359DC54ED1
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3761D10E1AB;
	Thu, 22 May 2025 21:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tn1AV3i/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35BF10E1AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xziqUekjAznzMMMMgx+yN8xzdUhDr3Ky3WSl5y0v+uEUIM/W0IhD1TGEabwCpnkTwHxrvPYlbRplSc/GLS4iuLs/4s3F9t1A87KPk4StRYP//h83IvpJYl+6x/uJ9hH09zJMeV9mbR+LmObXrk3BtKmFa+IpAIEEuJPecegRS42Y2/ZMtwZe6CSLXJXjLsHFQG1HqwJJH/mmMWVDlmCYbClMyAqxJ8jDn69ni6OsQYXw6b1axmAzTR+BjPn1z3fP4syCrAF6dRj0J1fgtBS62XiJSxY1YM3XO4kKiUSh6esnXIgbqa6qLur4CbUNjIupCBBQLf8K4M5Ha/2fTXwmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRXK6vpK/pFL9D5Nd1v7TnRZHCDdxfx5+1hceT/OPz0=;
 b=VJHd0LGdslQSJMFEOLQ0nUIDplafNC2+QXHxrWhCxgbBu7aJlvOMrOq41oJVT9ziwXlHG9lN7EuVrO/5MXq02+S9T3tZ0A4FxL/zAShVp0IlezYeT50bWAM5CmhvdSxnGQ2FLIhC+BFe1xMT8bEi3XtCoBIz+3YHVSLVu5gdGtotLFpecXZNfDXLanITFrVvJ2YQ8OjEbH+MPtTmhuzztf9/I5YVVC3lYP+1fSCDpOPyZelSdEYx5WDDZfe9C60vkz8g4L/E+5FlbJeoApftQGmqKxozguJ1bQF1EblYobkqa/tSk/pFkc939P5ZNwq8Pcs1vu8eU11QrlVw2XI6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRXK6vpK/pFL9D5Nd1v7TnRZHCDdxfx5+1hceT/OPz0=;
 b=Tn1AV3i/brBHLa1aC0QIfODKLuhYAwPZEMjGJxOjDtFKZM9ge32PiH5KMhFPdIz4skuYKtHqTsJzHpKMuIbPWTpl55B4JyyBrXe2iPFKtoiYXDqcJ5ZPwB6Ijx9rGblquxoJZFFyi9CzSfmvk3jrkA3kGOVjHWzuadX5jIQrN7c=
Received: from MN2PR22CA0026.namprd22.prod.outlook.com (2603:10b6:208:238::31)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Thu, 22 May
 2025 21:49:43 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::d7) by MN2PR22CA0026.outlook.office365.com
 (2603:10b6:208:238::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Thu,
 22 May 2025 21:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:49:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:49:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx7: reset cleanups
Date: Thu, 22 May 2025 17:49:19 -0400
Message-ID: <20250522214919.11912-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522214919.11912-1-alexander.deucher@amd.com>
References: <20250522214919.11912-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d26fd02-edd4-4c0b-6c0f-08dd997a8fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3xbsVvuv+GhacX9eRLOTtMjgiYsCHPYW8ypGw597chvCLlKLQhHV7mnrAqOB?=
 =?us-ascii?Q?p5XD+Z3zVN1zOpmLqmYMbufxMzBV888FX4cdiWZVgQmp4e8WuGCFvcfMYgYT?=
 =?us-ascii?Q?5cnGsT2Y9IzNroymvwlB459uRasG4dU7VCtQ5dBAIgZGNF4rN9SXFzUHn8MU?=
 =?us-ascii?Q?37MXcrqtUO2CCJohRhfDnBp4scrx5uxzgkaLBrcBcwSOibFVRLwFpkVhJVpT?=
 =?us-ascii?Q?wze+uLO6AduX2D/Ef+UGBZw+XRwLQsZSRSjUyqkTUKYMUnHE/XhIn4V4sSZv?=
 =?us-ascii?Q?Z0blTD/GfhS8NyZSV7b7purm/FWcPaeFm2LIGeVCiqGExQUmSMdPLyBGldps?=
 =?us-ascii?Q?h7Ez2n6rIsO5cWI56P6Nd7QEodaZ/CwUO+RZYicOpzXJCInB7Lox7CGGCt01?=
 =?us-ascii?Q?6cRdwkXspXm8zwbMxP8z+vqNJjnER5THC680N/IAH2zy0ok2fo4/H+1uhD0K?=
 =?us-ascii?Q?FaUxlE7E2Ix79upY947EcWjW2mViLxGnuP6tYhAoI1vPDnEzrPckXIKtFgss?=
 =?us-ascii?Q?DRUGSGOkSiyHgiLuPDrFplLh6i9yMepAKqZNms9G/gXb+LgduqdnB7YCUCSF?=
 =?us-ascii?Q?C9vMeHWxO0y0xpB5INa6j7ER2O5D2F8kZwp9FtIo7XtBhbzfGqB8TIIsK4n3?=
 =?us-ascii?Q?SOHW1SwFsO8ouuBxgtz0kEOPUZW4tx0AaMTuFNur0PnSBmu9liyPz8s/0xlW?=
 =?us-ascii?Q?aqdT/nSCeGpFXuxPXF2FgrWtJDNk/UI9HIy6sEaWcpcPxV7pIGD1tuM9WZkx?=
 =?us-ascii?Q?QMrMC1oa7TAY7DiIx7cJ25ItFPbWT5aRezs7YRxnGvmpuHcUb47JaqzyWjxU?=
 =?us-ascii?Q?PYktALO+JTZMTD1IXFot8zRkg3lS4wJImLQMny6GlNGUZSV+8zAFgRtFawrN?=
 =?us-ascii?Q?tzJA7KCBO1stdPerQsu7WbuByqgr4c4bPdtNILwOsd2BvvktiBKAkYj5ImSW?=
 =?us-ascii?Q?8v0mujCCcJryFrvixB7bY8pg1tQaugTJ/lZbJmrPvUh8jWJVDbirZ5Y/WARY?=
 =?us-ascii?Q?vG6zVApLbqGMzBJRsErtt3c1EeczSP3yophjyKuKDr8a7B6285eq8pkW7TVj?=
 =?us-ascii?Q?7319fv4953Yp6q6PitaaMrw0A4w+AQyiBy2kqnjfnxstXc1OoFfVGsafsDU1?=
 =?us-ascii?Q?QQuz5XVVNG6nVfM7c1cdL6ERJkGKmjxUxWtHyLcmbsunMe7Z78l+cKMhFNd8?=
 =?us-ascii?Q?eCT+PQwYJ19gkJXaSfxqsf06SU2qNTOwXhZ7m2DnvLoiHUo1xrHqQstztjgd?=
 =?us-ascii?Q?0eorSxpujBDJQmSZcy/FwGhU4S7blrqS9mItFtv/4khhKM/rijQmaDVjYMrO?=
 =?us-ascii?Q?mnekgtO+VdwQsfTwOfT6qv2oAm5uC+Pxyt+tphv+XZxPi7PnddG8IevzIHW5?=
 =?us-ascii?Q?ShpO5qvZSQ7i/yuxSW91yQphTjYF5bm3A0lM41QvC1cnPD/rUMzdX25izeqi?=
 =?us-ascii?Q?QVNaZODHgGiqR39G2ezysrPTjlk8fm9mXrrmlLU2jz5zSYO8caVlVhBjyn1M?=
 =?us-ascii?Q?XXOrosc2tVbotgyFZtLa7YO7PbGgCOi+jBXv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:49:43.3065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d26fd02-edd4-4c0b-6c0f-08dd997a8fc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9
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

Move the KIQ ring test into the kiq lock, add
the missing ring_commit.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index da0534ff1271a..e8b8035fc7900 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4937,10 +4937,8 @@ static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
 	gfx_v7_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -4950,6 +4948,7 @@ static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
 	gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
 	gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
+	amdgpu_ring_commit(ring);
 
 	return amdgpu_ring_test_ring(ring);
 }
-- 
2.49.0

