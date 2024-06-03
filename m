Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37916C27C50
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 21:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 960F210E3DD;
	Mon,  3 Jun 2024 21:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3cc4EGWT";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD2510E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 21:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcUWVjROAv3ZYugc8v9DyfFL7x/qZQkxbmyjZ2l1yxGMNP+WoF7fJuzISdFv2/IcKOZZ8y1i6EAGij6Hy2vRa2Kqy3WWsqOMvOOzZhJz2f1hLqJx7XCMTMV69VhkKPbS51LCLHskLOe5N+3SMpcC8+LedomHYENybHfOaTNLOpF2PBbEt1y0BrgIBNzBojfcHwYvnvJXPoEtLyXcEDGpxqZlqQQmwhqEzDFvJRBSF1DiIZQYNmAdawZSWOepXD0L3t8Cu4laGfQeeTIXdTZnWp/3vB54Kp7l/NmxxpPTmGP24hT0eCdkBOcTrUweqlgtUxPdLqTVwm94llZtbUqkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKoCVKFCIv8VbA5has7hI8Q182Y4i3SIMvi3qOsBTvs=;
 b=YS0awHvEAzXn1o+jzBkARc+lX+994sLIOBEqYg1Vc1MR+YKoipUh1s8CQ1y41qw8Svbshjp6PikPHOKF7IS3CbZzO7OHASAW1gyO+40Ch5RyeBolwkxo+MbZeTdOfvQtU8pu7kJC7l3303HKGza3ULU7YtePBlEuuKPa0xh8BVWoQ/GMTyGU3QkoTccHpaNSdx9hZ+T4QFigb4xD7iCiGALo/6NC2toYtxFCrxInTyUd9H309F1nua9eNMU8qOoQsmznDKBcL78KOILwPkDo7fUGdAELj01viAXVrSLLa+2NJRMnBs1BxLgpIKxFvOiDjB81Z0qnB8kHDu1a5porvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKoCVKFCIv8VbA5has7hI8Q182Y4i3SIMvi3qOsBTvs=;
 b=3cc4EGWTdCchY8Fo6eYN+cG3yxRxybIGAvZhwQUNVg1zf0k7DYRDZe3fF0Id9GKxlNWf9X2etObzobyfLOcmTaaMI8p+o6PuA8+/qBLDK4dWomiwrInrGxvIwL72wo+RwssL+/XM41mRMzhoN/m6MdkTJxrrAG7FT+q/pqjJnO8=
Received: from MN2PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:c0::32)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 21:03:21 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::40) by MN2PR05CA0019.outlook.office365.com
 (2603:10b6:208:c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.14 via Frontend
 Transport; Mon, 3 Jun 2024 21:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:03:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 16:03:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: remove amdgpu_mes_fence_wait_polling()
Date: Mon, 3 Jun 2024 17:03:00 -0400
Message-ID: <20240603210300.31057-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603210300.31057-1-alexander.deucher@amd.com>
References: <20240603210300.31057-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a16863b-8633-4bbb-3596-08dc841099e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8H6u62q+pnq/Dpm507zt2b/RYelOEfQU/nRk5fj1j7bUpLvspetN3EdBrNo4?=
 =?us-ascii?Q?DS4HSVpP/Ltebrnq4+x9NW8PZpgRMv7b9+61jLh4kU5dOw9eec4uzMpQAV+q?=
 =?us-ascii?Q?zwOCvduzu9gzuQ3dgV7wcDKLx/ZFR5SCoOIkcS2thAyNnOorhVg6cCVIrAdR?=
 =?us-ascii?Q?w4BB81OmX4EQbz245tAPrkC891UatLPym9JSKQrvzAiH7u4pF8siOuxgRQTo?=
 =?us-ascii?Q?SG61aQMFcgWY2U9OMsXSc9LiIyIDe5cREPUcmCc/BnFUwf0kxRy4gfAeVtVL?=
 =?us-ascii?Q?NLhC21Ebcbus93MDpQqQmklRlPjjdZz8uhcUyK0g7EEhLOqf84MTZy0b5wLf?=
 =?us-ascii?Q?/rinYlHGnnXe8gio9Myen4bu6deSVFgPCZvhwy7G4La71WvH6apHRvv/S79J?=
 =?us-ascii?Q?FQyBhD73qo+L8EgG4l/gVzWEp4SC1lh4R9D9WZbLsARwE7gJnqoPTEat2fyv?=
 =?us-ascii?Q?PFbuGwWI4C16FAKyIXA75hulg7wm2hpHzmcoum8CyYCJubOHKXmh9uyYK9Wn?=
 =?us-ascii?Q?94SmxpmUUXJzRyWp4KIHwk04mCRbw1FmziO4R//2jb8qOCaTEyqwRjRT1lTO?=
 =?us-ascii?Q?h2OUExgKp/8qzFAVqMgT3R4+0u8KDvejQnlnCGzY5YV6zmlLItd0OFRV5V1S?=
 =?us-ascii?Q?TnBmCTmW7Q6iy6pk3dJPSxf2qOb4EvCUX1Gx2mDMwJsoj+oNcBKgMQme3rEX?=
 =?us-ascii?Q?WqnJEymv8K0AfwRmlHp9SDAeCl2kaVdX0AtLmeU2PLCbWd2iDcl+QW2Fa7Rr?=
 =?us-ascii?Q?+4cGxDOXVxrR1iS6D7SS29sDw1QQuvS59Y5aMql5LDnlm9W9UjJMU05Jo/wQ?=
 =?us-ascii?Q?ApEweEi0PMpVBu4Y4oVOWKovoSxxoubMyrumMUkrpd6/mgh+T33cJtrHV+7h?=
 =?us-ascii?Q?MXhJyBh53gF4gO3yEIRIjkuY+/T0GhOmKXRvkB2endPfSQf0XYPRc0oahDiG?=
 =?us-ascii?Q?99anvOLnJAobyEsf8C5NSyiloS+7o8RttNadkL3l8lrjfLbIJ8vfUWxqXZPH?=
 =?us-ascii?Q?+FBI+6ZzahpzlQyYDsTWEHVpUZuDJCOp1Jjy1pB9AFZHSBjVNdrD2I+PdJK3?=
 =?us-ascii?Q?63E7+2zLSW4ZRZF2phNNV6up4HbDBeGKtFmcnE2fAhC/hdcwSJPU0HqIWUyo?=
 =?us-ascii?Q?yD9wKhv1Xu9lSziivEYOBKi2VPajyT2uG3fFz6SzWRTJONAYv3PIF2asv1RS?=
 =?us-ascii?Q?0MBVwyS9RapVWudtXpTp/d+qxUgQiEmBKoiuVVylrQH4Cn99WZpJ7AQ+tREU?=
 =?us-ascii?Q?wMndboMApdo2NPhm6CM662tAy99P5keTgyTOkblAk5sf7n0LDKwGRmLb2CGY?=
 =?us-ascii?Q?C0Ak2Nw6SGy46UeGIdrWKPuXBRKZzJd0146kcbZ9nqg2/se7M4+UDfN7I7Ap?=
 =?us-ascii?Q?4IiHev35ls3HUXaOHWU+vzaE3lwa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:03:21.5865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a16863b-8633-4bbb-3596-08dc841099e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
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

No longer used so remove it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ----
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 62edf6328566..e0c36e0d7beb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -32,18 +32,6 @@
 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 #define AMDGPU_ONE_DOORBELL_SIZE 8
 
-signed long amdgpu_mes_fence_wait_polling(u64 *fence,
-					  u64 wait_seq,
-					  signed long timeout)
-{
-
-	while ((s64)(wait_seq - *fence) > 0 && timeout > 0) {
-		udelay(2);
-		timeout -= 2;
-	}
-	return timeout > 0 ? timeout : 0;
-}
-
 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 {
 	return roundup(AMDGPU_ONE_DOORBELL_SIZE *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index df9f0404d842..e11051271f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -352,10 +352,6 @@ struct amdgpu_mes_funcs {
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
 #define amdgpu_mes_kiq_hw_fini(adev) (adev)->mes.kiq_hw_fini((adev))
 
-signed long amdgpu_mes_fence_wait_polling(u64 *fence,
-					  u64 wait_seq,
-					  signed long timeout);
-
 int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs);
 
 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
-- 
2.45.1

