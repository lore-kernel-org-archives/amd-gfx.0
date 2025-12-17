Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852C2D65C6F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C63F10ED09;
	Wed, 17 Dec 2025 15:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W8I//Ugf";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA0F410ED12
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAQePe3uqnra5BdG9y2Y3j30Auhsx6aD+yEjUNDnTNbZMh4bgOuwYL4kabRrs8Lc6stxW6jwU5GSFWW8z23Y6MvxDZJzHCg28r+4NCCjiZUFutJtK90oO2qvec2zIdTSAkR0OT88VQyYlJIDShRmLhPN5hyI0VFEUTnZFYjE1Jz1NQ0oKgc7Va4cj0ZAmApYq24WZ2RbUMogf+uEPg0jxzS0T+GEJf+OpTcgt8lp5flZRQy6KipE9NqKA2qtC3SZz6F126ZlzaYMz2Vn+bJWN7DhoJ0QmzHZczNdMl+HrpIUTAGnzg4q/6/hrCWsWLfh0G0hFPSRY4vvwqRpidN2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj3j447+JVgt+ACP1UAwIomPEJa4vmdYkAW3aUmZYN4=;
 b=c5LIMRA9qq3jbZnBjQ2avbYSRNRLOPJ3LmSJRz4SLwukwsr4qvZKEHvC6omspfgdxREhxlwUZQfV4Y8TWM9juNxhhFFazuhMklUDMyN2oMlxmONuR+F1bOfV5T3kjwXMxAUVI9SNzr8saH9pRuLa5JvHSVX6l0mSkErJLnN1k1lDcqFfGm71GyWppDH11w7NFfY7JKPiNYbpyC9UHl9vK93n75TwOkvizhaHubXfLWbQHs8gNqn4yDK5LOQLmCQiD7SMdVz9scpa/t0evwLErGOp4h8BSoCS7f5N1cKTAbj8Z2SgJEIytEZfxbgD9wc8l17/3Ve+M/XqmzWyFb+Bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj3j447+JVgt+ACP1UAwIomPEJa4vmdYkAW3aUmZYN4=;
 b=W8I//UgfRvPcLApNuP6TcKvmq8KQk3tb5indkf4ewlt+0iUrpu/IocP9MNaElxu7CQrEjiXEFySGHL/8Z8h8WOXs6h9btUCSEpGWaRGHLEwigWBRzHs3k3RmFZIuOJVjqzKl+wC2kIAzywFOWozVUEmsWBx70C1vk/cuk8K7Mbw=
Received: from BN9PR03CA0420.namprd03.prod.outlook.com (2603:10b6:408:111::35)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 15:35:44 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::ba) by BN9PR03CA0420.outlook.office365.com
 (2603:10b6:408:111::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 15:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:35:43 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:35:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add queue reset support for jpeg 5.3
Date: Wed, 17 Dec 2025 10:35:20 -0500
Message-ID: <20251217153521.2018841-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217153521.2018841-1-alexander.deucher@amd.com>
References: <20251217153521.2018841-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 8993d18d-7cdf-47c4-7062-08de3d81f103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7OV7LM0rufzrysi6hMywJ0JCr4/1V18g4l7A6F2L2htDPg8bk6iNtldOW3+i?=
 =?us-ascii?Q?f2x+rnaVVsAj07E9TTqnlhEvbF79btSfE9mEUgasxhh81w/JRsXBXsMwsyRU?=
 =?us-ascii?Q?s8oXZ7YbQNzClbvO4j5UXOltdl+mSCgnH2oJ50syqnzZ0TvypdcdGgnWBQDk?=
 =?us-ascii?Q?vEPzzcim1xw9wKJfAKzeYMlOKjrjMngyHc9kecNh9PXR6z4ZZiIat9W1Y1f+?=
 =?us-ascii?Q?8BraMO1cPriWbusuI5fQip3vw+gKD0RG0fBCXUSZpRaPj6XfOlNyopxAeRGO?=
 =?us-ascii?Q?3ZaD7lV5VvyvTMib0XQYijxYBhLgs5QV4kcHdrfcXfmvsiuQyUy/IfEsRZOj?=
 =?us-ascii?Q?hBxDoHi84Yi7LgdQYQ3OtoGeeqgZ0iVR+/pI3kHRkoXp7edKxYEikkRJpJ6U?=
 =?us-ascii?Q?PSf8WbKR8pMOiDCvpXJNi5KywtUN8o0jNvHZbjyHIc2WQWINnuIv+MMgUHz3?=
 =?us-ascii?Q?O53NfCcbOp3KLP1X1e1tyxIOjeSKapcqFes8wGJdj/w7Hbg5ff+Y+bDWadxU?=
 =?us-ascii?Q?iyWrtHKy4ZJGwKBbPAeW47RoSJfbJbTR+u97Q37/oweeXc+/QMwEosLWpXfs?=
 =?us-ascii?Q?KQ/sixj/bZqQD41n+vDHZ57FcB4KPat8zLosxuyG7uY+HRHqKlrl/4p4DFKY?=
 =?us-ascii?Q?yG6vyR+OeektRJRBPeYACFIiVouZI9lv+U8cwJhfI+/9/jDHwsGrHlYEV42b?=
 =?us-ascii?Q?/WmBlIkwgdMWs4Q9uI/IoZgZ+LOdEAD/Hs7UtcTRQh0WqJ0dxaeyt37v6CoB?=
 =?us-ascii?Q?ZIaJufkQLomHi5SOl4pfJvKaQocO+6k9L/QYRH6e0x4BYMhj1Mp06fnxztFB?=
 =?us-ascii?Q?ZvMrH7/7kRFKdl5T7iZzno5DUuU+NiPCVyjBsM6a7cIrLWVr+pmZ4CKQGYAb?=
 =?us-ascii?Q?CqLxkZngdow+un6V+np/txOvTsDC24DSL3e9MXFo7kouFFMBYtip3G/Lxbog?=
 =?us-ascii?Q?521FA2lyOymm/2dVzRmBN1WxjJndunS2YKZnZl7/pyj2q8ELGOWbTMknikdg?=
 =?us-ascii?Q?zZQXwX2nJoDB9cfP3SqBUFF+K8XErtQxjrVdRdg1ms8U7+thES6dkfXGN6iz?=
 =?us-ascii?Q?g785hapROjqbrnBPfe5iOsG1tr/j2OjYNq1b1BR8/SdaqIvQGHbWG302trIU?=
 =?us-ascii?Q?VyXiEmh9NaykrJpvYqag9AvJNOzIDdleYrSV+lq5s83ZhN44uEjOJtuwYj/G?=
 =?us-ascii?Q?jZFVwzn7zbb+kASGrhie979h/DT2nRQdnprwEAbbQfTdEFX/h1mKcfk+oeC5?=
 =?us-ascii?Q?d10SUuowtI05UMyVY9AaDySGNnSFfMLrsvFO5y/eKA8hykcsWCRoTW9EUbtn?=
 =?us-ascii?Q?dxiqOCqje9VWByaIYQKwDWB27BI57EeZT5aVmAyS1YSuYvKplEnyb8hVYl6W?=
 =?us-ascii?Q?2ZNA8eYblBtz7ONxorHzoUF0xU4w2dUsGLjs26kM3aZW3b6VrmzLZN/RjVmA?=
 =?us-ascii?Q?pYVALU1kXCjuU+Hx4217sXtappN+QBkgkgDgg0a132QnmY5h+VYa1ZXmldJC?=
 =?us-ascii?Q?5A/uSbTzY7TiWE6kZJVlCOllYlE1przNkoyObsjH0zZNNvDTKhZcej/3aIGA?=
 =?us-ascii?Q?6HvBPiKDVwnOZ4Wl4wU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:35:43.6322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8993d18d-7cdf-47c4-7062-08de3d81f103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1
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

Enable queue reset for JPEG 5.3.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 084e592fb838f..1821dced936fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -104,6 +104,8 @@ static int jpeg_v5_3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
@@ -625,6 +627,22 @@ static int jpeg_v5_3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_3_0_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	int r;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	r = jpeg_v5_3_0_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v5_3_0_start(ring->adev);
+	if (r)
+		return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs = {
 	.name = "jpeg_v5_3_0",
 	.early_init = jpeg_v5_3_0_early_init,
@@ -668,6 +686,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_3_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_3_0_ring_reset,
 };
 
 static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.52.0

