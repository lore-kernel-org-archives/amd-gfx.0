Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDC3D5B862
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D5710E4C8;
	Mon, 15 Dec 2025 18:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Mex6oRj";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E0E10E4C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyQYU8lozeL+2DjD4WSP3HH9kMwqAL7J6cIxtnKJzkgVR06djSeODeYPodpxwcA/YDJu8EfBQaVNbKUS0MSUKtL8JbMnpkD5UGyA3ZAp0Npi1pQUcmRAtOPz5gWfc93Y3CG2oSNvpvYCbmiqxrFfL++2ONx3SMiofgtUY3mGD178TRm5PmDqutu9jSTEpbzaIgcD2/zwiXdWxszpKBb0fyvJOd59yz7BvuMnTj32CXsnM+46IWUQEs+hIZNl3Gt5BtWfWkEgMHvu1zp/5Y1vz9UU5TSSyeqWjylEToBBT3COyXdETc++V2PSa85n35FQ5CZCjz3CzRXmnSu5z7y8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++BXX+fgQfq6+M5VbHVrAxN2Waqk8FeJM/yDgUd0Olw=;
 b=gWuLcmMpmKwdcAAqJstvTRDKleY/+gn0vFdPt0d2ArDSYiuLEwOkzlbt/oflD6XZ0j92BMGzmGvOqeQGi7y01b+gXbFUNc72NKl/Gf2GzlleTX1S2H/C6g8KJ3a+gXlZa3YMvNLOxre3ZjZBLnf9S8R/X0ecsN5nyx6svAwp8n6UlB1InPhPfXEAzM/40DhTk9r++WSej2kQjQgf3GxLuN6e+OTJmV7ek5nh9SYJLOQuwXwDMFyyhrG/DGz9J6RRVxWkxNblavD+F12IlG7xZL7+145K/KKgYavH94U4gJt9EdiKk6Md9JV7sXdYHK6NRKQIF4mCt+9VKdraJypomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++BXX+fgQfq6+M5VbHVrAxN2Waqk8FeJM/yDgUd0Olw=;
 b=1Mex6oRj7p0kV0FfGytZvm4x+GInELfwAw5c33MJbRt5SQrE9LOy2tXtSl4tQU3jiQHzg+64EC/NFqUfq8JU9H8j2IvyZMe5WihDhgjXBIiuy5ga92+KbL/3bgfyJqZ1P0/ZpdR9AG8C64NlX5JOmjCu3hvjdxO5fUXS0r0obr4=
Received: from BL1PR13CA0214.namprd13.prod.outlook.com (2603:10b6:208:2bf::9)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:23 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::c1) by BL1PR13CA0214.outlook.office365.com
 (2603:10b6:208:2bf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:23 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gang Ba <Gang.Ba@amd.com>, Amber Lin <Amber.Lin@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add SDMA queue quantum support for GFX12.1
Date: Mon, 15 Dec 2025 13:15:53 -0500
Message-ID: <20251215181607.29132-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f01178-3145-4f55-7b27-08de3c060dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0f5fSyRuIWU0u0pCUBRuQ9Ca8Rfr7DsoDv+cODMe0Bwb141XvUZE9AFXlXhr?=
 =?us-ascii?Q?bt11H+coWxBD2/S5lyQEJQzLKsk71r+ZtqCRZG5kYWPURh6aQrz7OpYZSiN6?=
 =?us-ascii?Q?tsWWN8e6qNadpw72vel5IVvekSFVelMh2so1TwdVdxYaoUsVRtllPb6WWE9b?=
 =?us-ascii?Q?QHNxOwkf2e8jqvIul2QnsjyK+v3EsXhvYCBLT3Zi4kjh5W0fApci+nIRIIwi?=
 =?us-ascii?Q?bAhrSDKHVyrXLKbvN5cYMH3/zspuzeKySPOQ6KXILL3LIPmi/dVxq8m9zzS1?=
 =?us-ascii?Q?Btrl+bphn+dMOJ0AQ+onPq7ISiCmcBJzOvHv0QRp+GUavzf6xSuw8xR2k/IJ?=
 =?us-ascii?Q?GZ2+SK7qvle2S6wjcpd1INGFcwQu4+GLxqnuBcfxRm9vdlRQxHF2OgexRMlS?=
 =?us-ascii?Q?bFRJEQEzYaxdDVdHy/NwiKmhWpg97qld31qgmANBqufO1dJRW/biQ95uy6xR?=
 =?us-ascii?Q?lhhz9jtmDYm9ILIcmIOr4K2L70byiv7Vbd9b3+1kF/xo1M8KCnmkqyEwTIRm?=
 =?us-ascii?Q?/LCvn3bBglOryI1GfpSZ8I/jziR3uiTz90oGhG2ZonVjm49P9EQo1yN90xZo?=
 =?us-ascii?Q?36J22ANk6eV2hhB3cmBCtg28Ro4dTDepRs9eGz3HngO3H93JmX3nVUpD6Tmj?=
 =?us-ascii?Q?6TzWe32+zyyOAmUH5rIHYwlBj1rw/wbl75elLR3NKCF1dbTG8BJji9fFt0eI?=
 =?us-ascii?Q?zAopDEcbx5OHUEkC0+oaVyDpWlV9wmPpCTLsnPceX+62O+IjdhfVfaA3n+OW?=
 =?us-ascii?Q?+/4eR6/9EI1u3hk4+To+bdn4SeBA4DBQKszfje7odghWZ+jBa3KnWLusaHpe?=
 =?us-ascii?Q?DJ4vkmNHYsxbBcoJluzE9uDIhquHaEwGXRrJJD2Rhy4wb6Rl8RSI+bUXFIW3?=
 =?us-ascii?Q?gKVdVtQmY40Fhl3w/AVCIpWmZ9VRHUOx3u07G8k46ItM3WEahuCt1iFvl1Lk?=
 =?us-ascii?Q?OU+iFz/ZcxzTZDFm8uZUbTsSQKKdRtSyF/WZZPfwkfEzauEqmpI8z+3hOFpB?=
 =?us-ascii?Q?Kh8EyPPfcwylw/qt+8czkJjG0rT7YyINxf/CAeMCIumNhy/gAEetVXXT/tQh?=
 =?us-ascii?Q?23unkt0UpcISMh5nUtoUgctOh/63Gf0nxW4cv3GSdtd9w7QyG5fHm+HKW9oW?=
 =?us-ascii?Q?B/bDIdqO0hbaECUNRaPB5CuyllxomWeP3V/q2B0d/D/RZCfKOB5ZLzCLy7PH?=
 =?us-ascii?Q?ssO51Jv+2KS2t1CNt2HjaVWxV5IEHvrvDCTgqPpqHgnMCElrEiN2iGQDYGA6?=
 =?us-ascii?Q?TBACAvrnvsV0c+9HaRq77BBER36QGwm8I4syREJfA4ckTzdtyLF0YJMw/yRg?=
 =?us-ascii?Q?UfRyHO3db6Z3yuh4j3/mffk2N+NKVeNJnFOaouwjr8TxSKgq0ajkwl9hklVU?=
 =?us-ascii?Q?9tgyL2HprftjKkbMSOiVntrBhjpd3MXaBsFrwYgm78Ip250b3sfM5Z4bWhor?=
 =?us-ascii?Q?ZsA9i3u7gJzAv+LB43jHs12U78JBM+PY3cFdUGMvDOME0xz2/hJyKRxvS/3P?=
 =?us-ascii?Q?g/WKHubUrim187+Qje4Ne8jYOEj9eCcTVHOw6Fsa8YywNwTvj6vDSQw3FmtZ?=
 =?us-ascii?Q?PN396Eff4K2+qIM3lr0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:23.2443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f01178-3145-4f55-7b27-08de3c060dd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48
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

From: Gang Ba <Gang.Ba@amd.com>

    program SDMAx_QUEUEx_SCHEDULE_CNTL for context switch due to
    quantum in KFD for GFX12.1

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 9cc8a1ae88f9c..1d8c2c5612c6c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -358,6 +358,10 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdmax_rlcx_doorbell_offset =
 		q->doorbell_off << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
 
+	m->sdmax_rlcx_sched_cntl = (amdgpu_sdma_phase_quantum
+		<< SDMA0_SDMA_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT)
+		 & SDMA0_SDMA_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK;
+
 	m->sdma_engine_id = q->sdma_engine_id;
 	m->sdma_queue_id = q->sdma_queue_id;
 
-- 
2.52.0

