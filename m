Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0794C83F14
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B4E010E514;
	Mon,  7 Jul 2025 19:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ix8SC1wR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A19410E528
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQCw9ReReWR9uVv8c9QcXLZKhvsxi8dlROJy2zkMayuYkXk7r1h7w8ivpcwHS5njyplvrH1CnpMsyBCKLHwm3IUXh0B1C8R72hsKYBJr5r1eaIT+KqyiwiHpip8gqNOm+LQpBBTuvMVhKJ5ItFYB2sVq9mWpwRwL6zTaSKilVNYklte/Eht9oudqXTljd+7trmsv8JxGlMHTKoQuurvZdMyOOEKTNX/ovXf4ed4SgZdxlA/HV8uRG1dHT4EMTYPiWSy5F7NRzbZHqWy8jM1ibz8ndrsSh2PJdt+DrRU2eewx5C7gsp2vu2zcVtYhBHSyE9QougQRTs03MabVDOQaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK1+yALBgH65YRdoiqYOlQHpkXfndDVY7F6O8mgJTds=;
 b=Kc0Ob4H1CcuD9UJPCSFdkkx9H8foSgnpmlCva3aSxaHaogUklZtj9ue5o08A12Era/q2WKcjvTNdlT101o6tCmT3sOAQpkiGoGorSBGwlQ3XhqrynuHE2JmLYlOfYfaZ9H+QtcKdZsV6hGZGuZjhDwhXFyrPY/go5S3CXdmHOfkXfHoz4DxMEdrG04V8xkTRDf5WVwQ189OQqmUvtiBHsgAI585Vs6DFuu6NDTzaGrAwoIqBvXNYgnBafdyNs70pw3k/jkivYBovBNUkKAuh7X6iImKwDweTTqzK2ayr1sNl1M/mXNaWdyIZDZGTtbcuD+0n7gfG43bt95Rf6Z4yGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK1+yALBgH65YRdoiqYOlQHpkXfndDVY7F6O8mgJTds=;
 b=Ix8SC1wR33zKvQ2Tu2d8MV3O58Nj2TNIazhlUfv8hvgRt/jc/MXy79BApT/79Lz4pxywyBMI5dGNPxQfpmipsXNcg8JIjiIPQubOjZNhXJXLUHXegwBLGxkpNXPc4QzhvunLPGghVSaYtkeMTOxGzWmzg607qRa2qYmI2QIDZWg=
Received: from DM6PR11CA0004.namprd11.prod.outlook.com (2603:10b6:5:190::17)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 19:04:19 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::9b) by DM6PR11CA0004.outlook.office365.com
 (2603:10b6:5:190::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/36] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Mon, 7 Jul 2025 15:03:32 -0400
Message-ID: <20250707190355.837891-14-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f3dbfc-bbca-419a-736a-08ddbd891342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jBqwsiCfbNRIobOteNhglHd3T/VFjqyKer6tBFstV97FFvAx3eUoD2abEZWE?=
 =?us-ascii?Q?zwgQA4EhbfuRP3FBTZFQ+8TSHLBXj17L0JmX8NCUtk5TZE6c2yVwWoaybRz1?=
 =?us-ascii?Q?NV6X03D57jzCJ/wa60qjxZg00w9IN6FZUw/JBfR32Goj0kA8tR6H4bSBuEZV?=
 =?us-ascii?Q?1eXkDFAaziM4qRhuaiYG/IxK9G5zw2BnNEYdzdZW4c53BbSVHRdeo7g/FcTu?=
 =?us-ascii?Q?39UASNhkSUJy/srPSlfZ8wvQ/N96TvOaCct8h3+8Sqwo8H/Oc1ClCiu1+5QI?=
 =?us-ascii?Q?gGuF/3f3LbkgpCtXcggXAs2CjFdEGWF5Od1a70sFJZJYqJY7zr9NbVab4F5C?=
 =?us-ascii?Q?jAz3+1COeO+d+CGzyWhISfv+AZ7+o2Y/07oLWjEPiOwP7VrcCqGZJ+L/xYRi?=
 =?us-ascii?Q?O/a9ohlPnKSDheZca4fwIcbdr+mOQLKQNpo5mqS6bz2XE+dG/FICJVVOzsnY?=
 =?us-ascii?Q?M3stns3yjDvfDdKudSCmgtNzzVjbaKqAV8ZpfpigyxFlr+JAWtSHPcdL6grP?=
 =?us-ascii?Q?HK8DsYherA4JauI8QJuuYZw2JMoOVrxyLboVA9Kon0RtyRvDaMCuNekR+ezA?=
 =?us-ascii?Q?td0rYLDMBtMtYpht0HbibNIFLIsFHl4dOu2UESb3Sow05cqfRbvvr6xgiFaG?=
 =?us-ascii?Q?+iBJr/KByCTQb+bD6oN6a8KDOAiqxZ2laRZtafzhEgokb+paDbK6XtC5j5GB?=
 =?us-ascii?Q?melu54lI8ODGVS6da/fKyKmlFtvQuJ6WU4qROuqklDs85rHVsIfYCV2oKQPx?=
 =?us-ascii?Q?0cTGLdaVFm3MKNm1h50Scct7xbDSYKfAXPW4bqysLKXN1+BniUMJFcs2WYB1?=
 =?us-ascii?Q?v4YYacd0bLmtEVdmUHODweDfsDlv8a9481vgcNvSi77qJdWmukXEVl5NVqYC?=
 =?us-ascii?Q?fDtPbnEaSnqwLjfpqTs0Lx7ZKn6dwhhlLF+4zTuBm1u2bQuQ89MV4XDdqgq3?=
 =?us-ascii?Q?qiKUxi/ywvd9JxIibDyE5i0M2S/1QSxg9E/xPqzpr+ryaosA1nT1Q5RZF6+5?=
 =?us-ascii?Q?03kTkCmW7KHNG1eZPqx2clQ6OQlziVn4F8YT3JKBcZh/JkJ++AP01ja2g1pB?=
 =?us-ascii?Q?NyoHZZIoT9GGtWnrPJ5B1baKfHGJw6IZkPV2K74MrxjQSlkqtNfZ/EoG+saL?=
 =?us-ascii?Q?IJN8TCazXLZ9JzURJ3bS3S7UuD76YlRXkKsRkLZIREOzFQc+eROrWW4Gt777?=
 =?us-ascii?Q?3UE6Rfyt08wvIicmLoZW0LMSUCvH4OWA/kbYD0LYDJoi6ZQJHiPpm5Sr9+B/?=
 =?us-ascii?Q?wKMpxzYWe0/Gtao3hH2UQd2f+8M/Mm7uGbHYxRs/JFFXRFERY7IgCoCIBw52?=
 =?us-ascii?Q?chl5jQkUr28B5HMZ00r6E468JBv4vaECbKj7n7DSvUMyUmU8GNdQFAYnWIdn?=
 =?us-ascii?Q?eSlBiFqyoZc1o2BY5YsiSmCt4mRjUWWHrDjZ990GT3iaDheWsgriE4RyZlUo?=
 =?us-ascii?Q?nFiu3Xs9WZiWs+VxSWEL+kNnSKzzhffczHDTHclT435P6cf6BjNvd5zdkglK?=
 =?us-ascii?Q?l750fJecUlSMtQ02K3obdme/eRAZpEtTTN7+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:18.6886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f3dbfc-bbca-419a-736a-08ddbd891342
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 5f92975cc3058..21bdf9746db7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3567,7 +3567,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -3622,12 +3622,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.50.0

