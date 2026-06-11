Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25524CD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5CC410EC98;
	Thu, 11 Jun 2026 03:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iLKYJhDH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175EF10EC91
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgIqUcknGeNmpb1Pj9OHgKv8OzEbhvLaDP8Idv8wOJEoZydG3+y7fuhvBiFXXckHqcaZMYoea5syq7GhIxZVEHF2nn9XbgX200ooN94WWGS37hZd0qCJVB03aNcsGc8+gi8cSgFk9h9NBr4l4NyWxKAZ1pfjjW/A9VsJNSyqgtVWwBYBnYKvFsa89rhSGPALJFRdAwIColJ0D+ZHN2SH1Ri8zpsMV5oCkiZj2oAmGt4Q9/9YWB6PwE7tj/l5lELCdxDCx3Y++yD2heIyCZjvCdeoxHY5DcrDu6CnPM57YG4heVXGHHIH1DXSczvAsai575m81ymGrQzLzTttNu3vEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQGV0gq0eaA38X/S3dbf9PNEnNRiYb3rbs8J5LCOxEw=;
 b=XXiLHiq03W/J2Kalzqf5UY/i7pwg0bvNuilX0Q4DCXQaZCkdT5n48QsG/wFjEcrvHsQgFsSDfuQ6UylhEDWd9jrEoxmX7/9hZb03a5g5XTzgPK4IGpaBupKmC7qrjVLRjIXe5zondSDLWudjCGbUSplJst2iutWs11q/BP89SJFsWkkEy7v+IjnO1n5lcewljwgau9jF3FstZetxP5RHJTwqNYW465rqHQwxmqVc19ST/J+WnwYdT34K47/A0HOKs3G+D9mkm/QSIZ+5GD3IeVI7lNRz1eegqTR7CjBCo8MsrvDKz4Kwly5cYZqfsrzuhWnTJ2V2/cK1uulfJfJ6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQGV0gq0eaA38X/S3dbf9PNEnNRiYb3rbs8J5LCOxEw=;
 b=iLKYJhDHfIkdJZpeBreKPRUayaQO4tph/v8vg44xQBQhKc2JZ2F8ne7+SIm3RSUr+sAnDqKvZ7kXkLZsFc4JxSwhBiXWuFHUkn5CcczGcBdl+V1PG08ClXybBZstIqnw8EDNIRuBKjrOTSw3ccAMOMTOQhhDvW0ZwoXjNc7VP2w=
Received: from IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::15)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 03:58:15 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::1d) by IA1P220CA0001.outlook.office365.com
 (2603:10b6:208:461::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 03:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 03:58:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:58:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:58:14 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 22:58:08 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 4/7] drm/amdgpu/gfx11: strict (me, pipe,
 queue) match for gfx userq EOP
Date: Thu, 11 Jun 2026 11:57:31 +0800
Message-ID: <20260611035747.548780-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260611035747.548780-1-Jesse.Zhang@amd.com>
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f8cf3f-cc08-4fbd-845b-08dec76daa4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zzb0DJ/NY0VIHWEOVi+T0cRCQY+oXnlH0NRaLjpIzBJFbUDb0tTW2gmGsL/WUKO+yH243ot06uKOfuM52YJF3QlIQEMwDCvuoUAWcu9Jsjz4WbgAtZJ/pibV2Pukc/9aeKapPLJ2T56Y1IDZU9XGLCZMWi2gmhHnEcL1ifTwAWMob0k73/uPhmDww0ChuIrbw/aEqXBAQ6jMBoPZRRO3xh/hv+JgV/V6pg147szAcz10b4Og09nxXIJvwUXHh49u+dn5TD4Bc5hjFP7GpMzdLiu0vy8JcwtgbZbkIGDVOaObPkpA2k1PqT/rogfXpfXVkb+rwyAa0T5Ug4e9PipGjZj7hZXW+ScMprrMWacHXanzkKTw4/EpXd6b7TKjJrvMeEaJjrz34fC1X8KGYRUZjyROqdHu4cqikovPEkFVIRBvdYvZaARYuFInv/RVV5+A/Ph4zZV17itYdiaqx8iHU/6v8ptVKH92KgXHSTDT7GGKA/AFatBJ6EwILtnlIA/50oGVbVYTyH7gevPRiKheUxQeAGLsHVwNzIFgC0ayTTy/hxOyGBHRKdJqfdrJNsCqpkyE8pG0bYbpy86zsM4znUTBufPTSZegKqRsAaGJwmk/f9p14j8sapWLz4i0uozuaTUqHUqaIqJ2Z4WOhEj66wxqmk8uu6T/pau2249kDOuS80T3bB5vwDA8FD+Ro8OVYayDEBhpeJZY6JHyrOOGgbR/MRI/WfM3MJBGoZtTdIs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qVU37hvFb+/ITX+MyH0sUu8HldElAtNdmAkPts4EuxkSurOoI4TblmafqMyIUvSrDzCX8+JnonDNMTQiznhiikrPZxEcJO8feN6scRsjtBMo39Bg0osRCurhhGhk9fiaIa75XEpWPrbSLtla3+bPqQxakdiC4w//F/PNH19PggRhVw4oi/QiyDLwkYJA8vtRTFvOkWXz+Gpy2Y2Az471hbPtJ2x8LiZ2VTvOFH+zK/QCaSP8NldQl4NQVgN//8c8KaCNposBJxAL5a3eXiQ1ToLJNeKR2TKuboWK6reOh22gzPIov8tpePXI42D1QiGWLYUI0NDZOk28TGuNzPKSPb1Y1cC+ab02v4dmPMPTw6x9oDRA8+HCbp5XRbw2r/naCxo++c7LAWzW6Xp5OUNKkp8yti6HLArtbbCJXsJzBEAc+v7aJsOKwAgUMAzbkb+Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 03:58:15.5257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f8cf3f-cc08-4fbd-845b-08dec76daa4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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

Require a strict (me,pipe,queue) match in the gfx case, then userq gfx
EOPs fall through to amdgpu_userq_process_fence_irq().

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c49a31a3789c..208f9ffed60a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6530,10 +6530,17 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 
 		switch (me_id) {
 		case 0:
-			if (pipe_id == 0)
-				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
-			else
-				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
+			/*
+			 * MES splits gfx HQDs per (me,pipe): KGQ owns queue=0,
+			 * userq gfx owns queue>=1 (see amdgpu_mes_get_hqd_mask).
+			 */
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if ((ring->me == me_id) &&
+				    (ring->pipe == pipe_id) &&
+				    (ring->queue == queue_id))
+					amdgpu_fence_process(ring);
+			}
 			break;
 		case 1:
 		case 2:
-- 
2.49.0

