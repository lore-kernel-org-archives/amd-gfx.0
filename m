Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEF1C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A56010EC5A;
	Tue, 14 Jul 2026 08:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MjEQQkBz";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11EF10EC5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNlCQpN60/jQlN5QjEba1fegH4loDNkhvI90wv5W22EONpgEjxHPfejnvSylMkTB2uVHdJeG8fGok46w/9x2g8Q/jXQR9ivXJz2Xbph91ErWO+X2eznQ3Fbiyo4LmokTRncvNMdF0gDz/RiPStXC42NvDsg8tQzbcZwKWqjcWX6KBvJf77DK2CS9on3PLsxNO34tMvLs1DC7FluaUpVewkDpD+cMkCREt4n2wSOWu2VjeQsz/4xKgXPEpT3khQWB4+Qg+qrgSe8gdi8ZMdVvKQfRsrwYv7Y7T01vfmU2YIcRDdcr3M5kY+gaFLvPgTkowm2PdnkjA5amq95pxJ5Dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWKFCuqWplEkEXwMDY2u+7Zo77zZ5LkjpI3SqtbzVuA=;
 b=r0mKZInS95cSUNaGdDVWHwqdZ/fljiVhree+IthJsi3KROXmAIKfkfFiFaDJBvdHV2Lv3HxrC9VEkpGaGJfbjkh26CxHR1ysnsKrBTBN0m8nAnInMmGspHzAXQsQ3QdIsHmonEGqLdhYUJc+3ltZ+cSBUU51g0YkAA89cdLGUaNAQBA5PUWvl0ymykoemFdA3Kju9XQRl4wDCb2RH9k2HNVC+dxZFpEjub/KiQa3ndoUElrzJqKWGiwtgpxueHPumumGN+yP6e75sEw9B1DwpszQW2sUI60ZvH5f12pH39woTi5vdFWPQFAttO5ja4qgcbm2XAmoe+SHeCjFejAJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWKFCuqWplEkEXwMDY2u+7Zo77zZ5LkjpI3SqtbzVuA=;
 b=MjEQQkBzUPYHH6x6o2T+jZXpIEhGu+QYT3mpjGBE3ls3RJzlgHSg/jM8zut2ESaA/bfH+ko4zoHrdjk/SinU7jpxYV44EOBuLEfjUZ58jyMOjm454QQSDUTtghcN4IsNCnzqvpHcyJp0R1+GgacSpS6DFMg8QCiF7gwQ+Yj554w=
Received: from SJ2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:a03:505::19)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 08:10:43 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::82) by SJ2PR07CA0020.outlook.office365.com
 (2603:10b6:a03:505::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 08:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:10:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:10:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT notifications
Date: Tue, 14 Jul 2026 13:40:23 +0530
Message-ID: <20260714081023.3395485-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fd1290-1681-461d-fe01-08dee17f66ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Gr8qlW7Gv4QlRSx/oeH/F6tCH8vkeySuqpNaIU9U30FVHLMfNDEiNFbJRHCcx5tNIm2BS5gnhQ3uHyjiOw4bvV7YlLCSX+pBydgaFuUhNpm3ZjjtJEEbdUIYX+vtO9MKm4y1sVoPIarRGCKyg8Wma8gQK++cCnYWlICT3Yrhim2lqS4krF4DYu3+zBGGoa3FwCA4aaMxCdaV9NobJxCj5zVl7BINXPoL6Clu05EmHVx8gETeINBUsoeZmVcmOji71ElpYQiUd+AuzVthepQ1WicKs2mRiE4tJqWYj5KbGOu7gegNpyqNFM/Il8ziLx56NwU8XvBvzvv92K2dixJRx8poBgnjeyC3Gf8crWVUyZSC5G3it6wwZUxH150XjcWF8rZ/PKeL2JDuhvXVJ06yNPsqFjjZYwENOxheR7zBj1E9ZGftJuAEA2cY5EhzfL33H+4xHU1i+u0Xdgcvm7Abo/hmOpvCHEycgitHtj5A5yCaApWvgxquW/BbT0BtZXWVGH3OWduDr1AqKdnQRExKYPQBWi1lzBFvwl6t+GV0m+0BB082XlvG/pwiIak9TNTh8j3MRLyiRFnt4q7rlZi50HRz3rnLrwXqgYg4X/ce5OuPmMxH3YJnCZvcetVyAOlMs3UuCmZ1sw5Jd2cXVom11IURoEq+DP381aiZOzw1HsAWElamw2EGSIlsj/8Uooz0pig7MP/p+Y1plS1qHewpqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nB7Tu2KMPyOdNHM/wnhe9y5k1SUDSamLlzEfDs7Z/0Fm3XqcHpbp9xUjIkoRM0joVOCqMpEd8wHbRQW7oXnrKQyvDtlwb/oGYzv32nMHJN4YYljc4IKiAXVQ3SViaPXEvKjAm6znd5HTElCr1OUCwafpybGbQjIl6DzgfZTFWZWAkVTJmr/e8m7wtYo3GamUx7hdaAMUQ8NjSksHeKP3I3Vco7/TCX6P14NCnoFrttBVh1S2XZxqq8HSQGwvhgJX/2pndt+1otOFeol4yuI1dPDk65XUkhxXUsbUq0coPH2SoLFxNEExORwIPmyAWbuw1Fj0MqzoCDPOdO/41rwfG87YU3Yc7wrejvA4TNLEdlYQ2bLwRmDQIzDhu4zaVToOrj9nIn4BWZYFBAqzB3iZxsQji90fsFvzfwT34bECtK1hCPElFnhQZmfDH13JbrXt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:10:43.5967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fd1290-1681-461d-fe01-08dee17f66ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
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

The queue reset path already resolves the affected queue directly from
the doorbell and funnels successful reset handling through
amdgpu_userq_handle_hung_queue(). Reuse that common handling point to
create the corresponding WAIT_EVENT record.

Keeping the notification in the common helper ensures that queue state
is updated before userspace is notified and that both EVENTFD and
WAIT_EVENT observe the same reset. It also avoids duplicating the
doorbell lookup or adding a queue scan in the MES reset path.

No MES or GFX interrupt changes are needed.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 28f9d3fe0e80..9e1d03eb31d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -166,6 +166,7 @@ void amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
 			            struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_eventfd_mgr *eventfd_mgr;
+	struct amdgpu_wait_event_mgr *wait_event_mgr;
 
 	queue->state = AMDGPU_USERQ_STATE_HUNG;
 	atomic_inc(&adev->gpu_reset_counter);
@@ -176,6 +177,11 @@ void amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
 	amdgpu_eventfd_signal(eventfd_mgr,
 			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
 			      queue);
+
+	wait_event_mgr = amdgpu_userq_wait_event_mgr(queue->userq_mgr);
+	amdgpu_wait_event_add(wait_event_mgr,
+			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
+			      queue);
 
 	drm_dev_wedged_event(adev_to_drm(adev),
 			     DRM_WEDGE_RECOVERY_NONE, NULL);
-- 
2.34.1

