Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4726BE95A69
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Dec 2025 09:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D80810E2AC;
	Tue, 30 Dec 2025 09:51:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wil+MTLD";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E9E10E2AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Dec 2025 09:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro/atB23YhPms201v6BrLj+bN0tQnjoiw09fPJzUFMCy4/6UZfDHqeSR0exrl0e9nhiYVIhx5QLqw87xbx8fJuaZEATEJDvCg9FehMdivQSokJVqj2P29RUxEzuYmRI1rPUJSlyMT5yrVRI3YQiFWUsmFtytJ8OMgT9z+C1NmeamzNy2y9BS1GeIsBnMf5UTZ0s2LH3SfaCMgZ5eQGl0t+o5h6kqcNz1d1Ig+jvI+Uo5QSvP5oJutimHwFmljy74HZOPEeuSepHJsG8zTBhxe21daGU1BC8RC+jNj3OwuBmr5mZ1BPHNq6ZLkCTv3tWM9cn3zK4Y1+ADyXHwgz9Ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVFcOpQ8ayw6YuXG6w2pmPPGTGVh3FhZsQVERDW+5Dw=;
 b=mffrbszncW3JwEJ8w+M2vi5xST5XYvrVu/7XlEV6yt7pdsa8YumFRETuRsO8sG4SFNkDfwvuLYgim1TJMOKYyPPKsfKEIzl+L4U2b5+giVUl5NRiMi9x+jYql/w4jBXDZB+odyiZPGYAk6tJgntWMvVSi/g2FHJiZGmu50jNKFaK+hc1TR49Wv1DlTzWIiIZWQp/GHpQHIAG0AOjg0/qpVMjdtKWg3aPJGUVVMhNjcwGLHECAbtVYN1MTmu5GF1VJGay41au/C3P6B8hZOgMXM7NUkKSypxxNX7wuBSKPjw6g6tcCkVyBThMvFn1U0yyqhUQhsPWSu7AEvNtxYmtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVFcOpQ8ayw6YuXG6w2pmPPGTGVh3FhZsQVERDW+5Dw=;
 b=Wil+MTLD+W9UzrBbKNoDTFjSTOZ5UHuHEjQmK5zyHMBEzm7uFFCtRHWzHrTuoWq0VaezGzeXQd8JGSoX6AbJ4oZNxtv+Ico9xizR3B1ti5nPTCZshHTfkWnTUMeg6s/vSYcJM5jv+a2piV38pvZdLtMoWgKkJyLmzoXccIRfls4=
Received: from SN7PR18CA0015.namprd18.prod.outlook.com (2603:10b6:806:f3::6)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 09:51:37 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::43) by SN7PR18CA0015.outlook.office365.com
 (2603:10b6:806:f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Tue,
 30 Dec 2025 09:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 09:51:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 30 Dec
 2025 03:51:35 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Dec
 2025 03:51:34 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 30 Dec 2025 03:51:23 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [v2 1/3] drm/amd/amdgpu: Add timeout for user queue fence waiting
Date: Tue, 30 Dec 2025 17:50:40 +0800
Message-ID: <20251230095122.3587835-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8a69a3-b2f8-4db6-c771-08de47890544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O7f9dEQEaJjIOIb8qYy+1Tp2J/a//HxJ3hkYipy3He9n7atJCipVOKpMFBR3?=
 =?us-ascii?Q?k/2tHTfjfCz5VJiv1XBzdgr8HCkd+tW8rwFVmsm6Ahh2v48PWESnOfQT0ZMQ?=
 =?us-ascii?Q?30EBfsSMclaa7tQtwilgDF5B5ZS33gJfqukQxbHYq/sN93/d0ftUsyONazxy?=
 =?us-ascii?Q?F3seS1uDPXe9WieGb+6YVlj0cQf0AUahuwdGICXY+NtfnKQZAI/uqdJsmd/M?=
 =?us-ascii?Q?OT+uhblgaA8chIHyr39lOn9MS0OSuoMR5dTsulEWCYFmHdY1EtG0LUuFanMk?=
 =?us-ascii?Q?4suq+nhprwvxs7rqLG2VGzrI9wPGCEqws6oV0O1hvG/DKUMKeWrq1dZEEWnh?=
 =?us-ascii?Q?hT6WZv2d6XbDsG6qscEMaDhFWeXH3SJjXr/Uojz8f4a/If2SquPNn23SmGQQ?=
 =?us-ascii?Q?efx/xq+kA3wTxiCXZlyMzQvw0CLBc6F9Bp8OO3scEJk0T3HGluTJz/tysDHG?=
 =?us-ascii?Q?/6839hUrZNro+IR+7YRVL2+2cH6meLh2KewTwEcBL/XO2LUA3HVGw5AE9m0Y?=
 =?us-ascii?Q?z1+AZV+1Bj/XKb3czCUfyHUEWbBdC+GxUBsozGPId4gukj8VkTLr+g6h5fYa?=
 =?us-ascii?Q?AVqYxWu2g1GV+WA5c/GHvhBiwR0Z2ByS3gHmUbavhx2Brehsqv8TdiAc5nZe?=
 =?us-ascii?Q?gQU7ywoAlKOut6BrKMnfbDp1W8YtjUbsB5SEM4ig7Few81AeiTaeHGERys0E?=
 =?us-ascii?Q?Dqgo2DPljpyT7AtX35BKLA+ikOXDbCniKLI7I/kGXg7EkkNTDEhd8/K28BHy?=
 =?us-ascii?Q?F7shyqJy2jtxuKiYTIanzKxTVWu8KC03sn5MFowr2SLAh/aCdkIT/AjcMXyl?=
 =?us-ascii?Q?oaY0LXiDLXs9oKBqvKs6FyyCCPCapaNDWCgFkw83ubhkZL4buqFoJqRav0bl?=
 =?us-ascii?Q?NPhBqXavc5NXNHbJNoNLISkaskokrC/+6DUvsOtX90C5tFjgC9JPtSvY7Sl7?=
 =?us-ascii?Q?v1gGEeFAQSUkIzrUIscHK3mzfT7CiuTM51Tug6KuIIBacT69Vf3WVLU8U3R+?=
 =?us-ascii?Q?jE4oni+Ca2E3NzQpwCFib5wgMvGhfy+QTO25IoUbADjx2wVyUJfsQJ3rja+5?=
 =?us-ascii?Q?iuJHL1GSfx1TD4gFm0cebEs2G14B7zjdYCsfxFmPTJ2FewmwFGOJW8SM67fE?=
 =?us-ascii?Q?AjKBC/laVgtWgDTMwG2Jw5UK7FMAlSP/6HfnQkCsr7e+k/G2ACBVGkZ4qt5f?=
 =?us-ascii?Q?YExvbjY8cNC5kz7eLjYFYO+5UR6yKRRRbnRb2DFybzUh/avLMbBOkw6RkZxx?=
 =?us-ascii?Q?z+U+ZtZjhWEKriTZv5/LI7K3upd2fJHPj66hfOVLNgPwIBIs5zxMXYPa9OZh?=
 =?us-ascii?Q?z5ca6ZmkzuBvIGNwlVW2X1zxnaKa30nnkVEe3DPaO9dQm5uqpOcErTl1vbaj?=
 =?us-ascii?Q?WTfx86BeDHZJwugQXYLrhT8eVOVzeKM+aRGavKaIDNbSEjidJ7wllgHLRFg6?=
 =?us-ascii?Q?Kzle/bSaklBkzmXh+D+BaBC4CWMTBwkaT5miNS777k+SY9QewOajtHoURIA5?=
 =?us-ascii?Q?EolqTsf1bRZ2SPgFobr2T0/t5DZIDbYbG7xjXNg7EFEuBGX6P2YyL9pt3mTQ?=
 =?us-ascii?Q?N3b5P/1N0U1j9aIbccs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 09:51:35.7023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8a69a3-b2f8-4db6-c771-08de47890544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF
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

In certain error scenarios (e.g., malformed commands), a fence may never become signaled, causing the kernel to hang indefinitely when waiting with MAX_SCHEDULE_TIMEOUT.
To prevent such hangs and ensure system responsiveness, replace the indefinite timeout with a reasonable 2-second limit.

This ensures that even if a fence never signals, the wait will time out and appropriate error handling can take place,
rather than stalling the driver indefinitely.

v2: make timeout per queue type (adev->gfx_timeout vs adev->compute_timeout vs adev->sdma_timeout) to be consistent with kernel queues. (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 98110f543307..402307581293 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -367,11 +367,29 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
 	struct dma_fence *f = queue->last_fence;
+	signed long timeout;
 	int ret = 0;
 
+	/* Determine timeout based on queue type */
+	switch (queue->queue_type) {
+	case AMDGPU_RING_TYPE_GFX:
+		timeout = adev->gfx_timeout;
+		break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		timeout = adev->compute_timeout;
+		break;
+	case AMDGPU_RING_TYPE_SDMA:
+		timeout = adev->sdma_timeout;
+		break;
+	default:
+		timeout = adev->gfx_timeout;
+		break;
+	}
+
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		ret = dma_fence_wait_timeout(f, true, timeout);
 		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
-- 
2.49.0

