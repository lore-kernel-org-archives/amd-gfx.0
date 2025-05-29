Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB5C5B553
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF2B10E786;
	Thu, 29 May 2025 20:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vHCEErSt";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C935C10E755
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dd3v0lZeJSKQ9W8dMZacLTREVwak7BY++ym8vXnzMnh3utE8pQfNCWKUTKw8/wfhoAxmvYWij39wdU8i1udNWRXIwCK8FF90/2goZ2DW2XwdYSh4oL6oxkx3MF4jjYNC571SJuja5lyFQDVGevJ6q09zVV84Mq5bR12CnZO2a+Fzd5+VsQIOvO8jC17qBIbW/xZTbmYEI2Q8DNILA4HN6tFh1yuIqZ8HuQWSvuudc4xgGpwEUvwpSzH4w0Ui0DE1vorAMUEDPLUG+gxpzy793BgOUdxQj/ceUDmZo8uXJzeKC1HAFDF428AZ8HhvnK25VWDGrB5tQQbr5obu3OxM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag5S+sAJLmukocxrVGu1c6ZRNLjFTfHsX1Sdp9iPgjc=;
 b=LgsyjgofZ+opaF/DuvUnhWzcMdsmNcRMb3fo71mXUBaPrOaQcvNUEEl6WTvZav2GnEFw5/VQmSs5gUjYfEo1JdG1JVF6Rr8KP6PCdLle4VHyRK7Z/VkQGvs0rfv80PKcyIP/TcuDOvnbQ2YrWvIEWPHTTkz+UJ3DzYq8rNNtkz7QJ/Ij3o3Ck0KRAev9XR3oSuHGRMRcxx1X+6LOX/yNdy2U44UzO3y+CwbedVm7OF3LJwB9NSAyefVzyYg9fJZIuAzh5f+AttvqxSNbUwBGW9LTSDhAHzWS9Jt9Ptfkr2JSfdqq7jMQvdE1PylaM+I3nxT6nq2cC32gJtXCbfezIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag5S+sAJLmukocxrVGu1c6ZRNLjFTfHsX1Sdp9iPgjc=;
 b=vHCEErStftFhGpuYfXipp3bUPMjvoswu4RojKikD9UPyqmKYnHUfupw4yeEIEpCSK2Hb9zT1khTaoTtRro1ExAvNg0VoyA9LWH1mK0k0mUQlzxfDTs7NKH8bxEKfw9Cqbaz1m23+v/PRvH2PHhtHKa1GvLtVcCu7FR/X09589QM=
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 20:08:33 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::41) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 20:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/28] drm/amdgpu/jpeg5.0.0: add queue reset
Date: Thu, 29 May 2025 16:07:52 -0400
Message-ID: <20250529200758.6326-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b6d3cf-0c9d-426a-e449-08dd9eec9675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V1F1qv6umrrWaiDMVeY2YvbetqiDDjorUwSkdb0GHF16ZSHgXSvSKDtTZ4+N?=
 =?us-ascii?Q?eNJiBMeAdq2zE74/nhlbjZqq0PNoweZ4Eo8Q0RA+RCeeG9Nf1QDoVHDqfJ2I?=
 =?us-ascii?Q?bV2Mc8sPTtHSYQ7kkgUvy4ixsxskTMwufUlG8fM+Scr30JBbPWRUoNDywGdD?=
 =?us-ascii?Q?pzVjyaZOnKkdRmu4ztItgZriesN9nQnxDlnwfXQovNWMZWdRrNehA5ye9OFP?=
 =?us-ascii?Q?4i0iDxv8+M50nafy45X9fPte2PNUXy4J7/oDvmd8Io8DHeImCBgcgzg1FryT?=
 =?us-ascii?Q?kVyhGsmUDRkpzhsXcbDLGFjYySzjBtpYxHhj0ZA5wATtTH3X6RDnSGTTtmJM?=
 =?us-ascii?Q?wNAYKJQnEpVJ9aV5oNZT0sTGJN1GEBeKTXsX9x7n4mekJKYbAQLAO5i7ITVy?=
 =?us-ascii?Q?fdwX/Zabt9OIdewlO6Iw+JbxRqDJKLibd/9e0thlcrijvI8wWdI/8oOtwjS2?=
 =?us-ascii?Q?LOrpE9XvpY0al+kzXeD0a5b75VWeXAWyUqgsinJV4GZ8VXc9N/RF4SDGqbp9?=
 =?us-ascii?Q?96M34saCfcr0Irjb4FeXbG6UQuLDExFwzXK5a20lIJEHFcUhNanR9qjCGg8v?=
 =?us-ascii?Q?GA73flUtTIjiIO5tM5Rg6tsbdhW4+DJQ55CeuIiMralkg4GsvetlK2nRnu5j?=
 =?us-ascii?Q?Y4nMkQDtNq8YiCepFiTnSTljoSwOkGJVL0ZcDVNF7dSbyeNLVQaAqaNnTvBn?=
 =?us-ascii?Q?tWLdVGdXTGQlFXOJhBakfOY+R+M8wff7mPU9iE2SX0O/EwXJ2ypJHQabPMm5?=
 =?us-ascii?Q?9y1WNOy7BZlnXVqNBaq+1E6+HB465tkYhBMnW3ARw1E58TUo4WONLVHn++3o?=
 =?us-ascii?Q?F7Fa+mGXPXtj5XXhbZAO3sZOpKoE6J6BQLFFe9YqudaMbSSGDSZzcr+O14PC?=
 =?us-ascii?Q?iA3d1FdyJHB6/5gTG3TO1rq2rgrx2NZGB7UCBaFi2uG+A4VJhTQTcIH4VG0T?=
 =?us-ascii?Q?LT8SR1QAiow0vyF7K46d1IbPwo3JdH2csSmyOziLeEHcxFGCzYcbYA7XKHTL?=
 =?us-ascii?Q?+ZyQ39KMbwspbkg4I1xZXdwmKJeN6Kvwnt6pB7YgOyC6UhOcSL2poWNyqwIM?=
 =?us-ascii?Q?Rph4dFg0got/mqsN9ffgflEXzt4lp7bZbjzn5eVCNLJpmYD9KkdBj3sAVPsk?=
 =?us-ascii?Q?k4ogCDDEmUxbNeLdHxkJfcLYz07gXABU1KUI6z+qwo65vnNFS2HF2oLlZCqx?=
 =?us-ascii?Q?XIW+eePq6QnTID5umItZ8QbJgPEHUwWhUTKKpDV/W+3Pxtt5vnotEqfEMMZ4?=
 =?us-ascii?Q?gEDvkamSQl/Tu2/D7qAtp1HYlKOf1AoLgBzptCHKfokt3LTU48oxMal8ay+A?=
 =?us-ascii?Q?g+hzLSv0lFx/3+OxtdGm5lMR9xvFAuqTq0i6Cl2L+MmqRlH36UWxJXyquYHD?=
 =?us-ascii?Q?sqWUKBWa67NOAuUfB5b5ucCFEvLAHY8bGzPe9Nuh8G6pnybDCUPyVV8hETBb?=
 =?us-ascii?Q?/FdnSuEOozviT0TSde/KkzLXJYiglSpLBqoQvnrdvw2RR9EVBt7j0L38/M6i?=
 =?us-ascii?Q?2jQaqJD+JRW/Mrg9frD+cLBpurkyiu1sKOik?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:32.8980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b6d3cf-0c9d-426a-e449-08dd9eec9675
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
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

Add queue reset support for jpeg 5.0.0.

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 31d213ccbe0a8..231639f2ef0d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -644,6 +644,17 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	jpeg_v5_0_0_stop(ring->adev);
+	jpeg_v5_0_0_start(ring->adev);
+	amdgpu_fence_driver_force_completion(ring);
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.name = "jpeg_v5_0_0",
 	.early_init = jpeg_v5_0_0_early_init,
@@ -689,6 +700,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_0_ring_reset,
 };
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

