Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D23C5AE59
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47BB10E576;
	Wed, 28 May 2025 04:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gk1Q3Nwb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D18F10E576
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpu4FBLjCmgmTEJqiHaX2G8tHIgnWXFNWP7h/n1gTJXlcpmAg4XCS9sZlVgYrlOjLp33pxvTqJNpY9ZOmVG4aazyG7fS3OwHlhks8nGVfBucbREdgTtOBcq3nfKk3F6PDsHv7lDzu4uiqW0q4jgPtYVyh2E+bG8EBJMcHMb7bJavpc1O1ldrDWDrT/Wn144wuSfqFt3HoYEiiwhD3eCj9BHdVwuOTM5KA26MbfeMo51Y+vimFAR0NH24+IbWVN2TmP5w1F6MBxnKKaspxeTF2jAm4g9G/09bZp2x69rTYdVXd9Facv256Wmx+XsKLc7N+03lvbrcHbbCcRYOMH2FiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knmUlnWO0typ9+xysgCDhbaHdbfgVfz702um9ywgeB4=;
 b=tijCmYmwFFM/Un6wk4BvdBsqjndMQtg45dSmUPRB9xOIvXe205P+0wkYr+mM6Etwel49t7sdiOCNJPBlZdT+RHpraGx4OvV/Dc2mt40sWOMeJeiFR7dFUoadwDFotUvnaIYAzkzb7TBpJ3rbMlHh4DwShCKnCwEY67ITSTqgXY28ZnsyYzsw/Z+VXBI3At+kzXVd8Yj1DnafZoHITYZQrCEzTNK1iuvy/9VG9K1TAs/gkAxprdwTLe2/1D1PRoKEksP/DIpAf8fgGnEetWkC31f7HWXBLkOKoQ4Pdz7seT6pmAOr6J4Mrkt7KPIOcfbLg9vuzv95HbELNyy5ujbDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knmUlnWO0typ9+xysgCDhbaHdbfgVfz702um9ywgeB4=;
 b=Gk1Q3NwbKqr1FirKQIcn2RM+5Qa/GbioA8dOMJCE5hG0GDoI/e1NIfdLbY+WT7w04SLSKrNqpJP3/XCYLWbV+cpC3vkV0Wr/Y/f8qipAHgPPgcKu1nfG3LKW3E9YBdpuiukTKnYeweh2NUOdWYObnDB/K8VIWcxlXs9ZbuagUo8=
Received: from CH3P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::12)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Wed, 28 May
 2025 04:20:11 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::21) by CH3P221CA0022.outlook.office365.com
 (2603:10b6:610:1e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.22 via Frontend Transport; Wed,
 28 May 2025 04:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:20:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/19] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Wed, 28 May 2025 00:19:10 -0400
Message-ID: <20250528041914.5844-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: d6762833-cf2a-465c-0b6a-08dd9d9eefb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n5APRoseTSk91TeHDhpVpHfs8Dp/lP1ok0IPsmcE8WcWYw6xW/XqxOTJvFav?=
 =?us-ascii?Q?bvw3Si2yQUucII4jFsIh8g3UvnhyG3gkSBYlgqk4X3xUPmnZQs1Kdf+KkMqo?=
 =?us-ascii?Q?xy3SC5ZS9rY+6yNA8KjPFF63HOa7nQc2tR1lB+bQLzpFudsyIXJ4pIUexrqb?=
 =?us-ascii?Q?6FpAsK91GlHU4848XPVc8CQg96BCy5vhdURrKIvDlUD+Kv30/lF36gHvirFY?=
 =?us-ascii?Q?tIknofP4UnSlYIFJ5Xu1JuMpIPSV42Jwi2LEc6g9MLGPm5MYFHPAbbmOTk51?=
 =?us-ascii?Q?j1SxtS0joMP7bcLCAbtpULb+4VxdH0W8/NYREjcbdl3AXoRKZYJyAqjRWR0p?=
 =?us-ascii?Q?vgoqN/Oq1/UQzpehkPg1v5f+hwlNW2JRp2FVdO9MxxQ0uuE7mMtLXUbBO829?=
 =?us-ascii?Q?2UvSdBNhphJgVHwm7lcY5h74berwy/NW57Y5PpfZn0v9ixuXaLe494cQE0xu?=
 =?us-ascii?Q?XC4SPUp8+C8BhzkqSzbkP2hotMmF+iVlCuzERae3VgFRM5mbEMRZF7SSc6kx?=
 =?us-ascii?Q?avbs6PdCP4KGKfaJMn8iaIOyF14Ss4W6XPc04V496EcULM4JqDxbP+mSIkWi?=
 =?us-ascii?Q?nvTS60LQMlj+EfTqWNpMDjja3VgJtlmaAkMzjlXel7mIo5TiVOE2MiFY9Foo?=
 =?us-ascii?Q?HrIB/0Xmf50yF68JULZUYf6HJcU7vpiizES3kQs3GWAk2H1esT12YUJg3TmA?=
 =?us-ascii?Q?AfbOMX/Hpx0ePRmljt90ZSnJEPEkygFi6URH07n8mE7Y7BxKNM/jOHqAfknp?=
 =?us-ascii?Q?1/511RhNaWhiT4+UgB4ZjQStyA8fL/eqUI4V70Gj/BLDtf/wVBnie9VmWSVO?=
 =?us-ascii?Q?f++VpsAenSjV+zs2MvjEtjKO+j2qi+VAqmI3RW6mt6NxxHUWM+rCVK5404DT?=
 =?us-ascii?Q?V9q+eMCoP6wOVgq1UiZP/tdMlGjo5YBbh/zT9ueomelW+bZcpb4fR6VKRh34?=
 =?us-ascii?Q?Ij8BUOqWU9Sjy6/CMUXf9JWiHJTu1MtI40MHYPxTPSdwginhQ+rhBApeC6Tx?=
 =?us-ascii?Q?L2imhvK4AL+2Yj7d1Xn1Ft2/Feq0pIbMKhCRMn1qvQuiTS0EYib2D2T6PvBl?=
 =?us-ascii?Q?cxZYPxR/lhQL0qn2Z1ds+6epa1U7jhucirXWbjcEyG6CYuExwlxwd4chYDg1?=
 =?us-ascii?Q?CpJrp0l7FK3N3flopo8NMV4zYlY4tzmPuXBI1rVzPZsyEE0V60c9H/sU1mqj?=
 =?us-ascii?Q?qBk86mfOasSZck16w1i2E9NLLB7HuoAF+GSyZJf4P8n/CqqZn2Rko11ItYCT?=
 =?us-ascii?Q?QLtQmzds+uYdcvqk+0s+0f2jEOz15/OE84WkZdPQ2wCfEsYwmIXRliWvb23F?=
 =?us-ascii?Q?oKQUGmc+ROwn3hIJOHT0BZr3nWoL5fAtpZ68g2ID0tbGN3TEK7CyhyeVADCT?=
 =?us-ascii?Q?zbSD/bwJ4/U87NG1tBCFUdPG9i3JXXAaWkCI1nDBF0Crk6SH9cyJ0mS+UGeM?=
 =?us-ascii?Q?78tB+TjeDLaLu11VATC9fnvbLexRPClkXmTWYpjONebGWc+3fl+OCgwBQQOT?=
 =?us-ascii?Q?CVOw74dGJkaa4Ej+SFsG8iL2KR2n2CgEqMex?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:20:10.7885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6762833-cf2a-465c-0b6a-08dd9d9eefb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d50e125fd3e0d..75681075f1fc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7216,13 +7216,22 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.49.0

