Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4FDC677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 09:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC03010E39C;
	Wed, 11 Jun 2025 09:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xItHIwxH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98ADC10E3AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 09:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn+JMCIku3EpWSAs2di9wN1t2q4Wa6ML2TW6TY2/JFr/Xpr1cd4kMN+mukIc6bpMl6qyaTpoUhr73HO6YlsKLUcOtHoAK5291p9b+LVo1NZAAJMpr3+VKgZqGJEUUfKds3ISGxQEQ7FRicxuJgttIPvdETqYj2GoeN7wYA7tMOkVfWE5nrgrcSka2mAXMs7xz846jBCmmXuEeiK4Xl9xVUmdoenlbK4ViPJzZvd4aD+WcfrKbUG8kzjYH5zyALP7hZAUfFhcoUs4oT4PxaS+5eaABzz2VaYeM83Rp/1yIQesEpv8vOjKHR0U4RTtdWH7uUlOS0YfwMZq087ULWCTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge9US5is25TWWmlwZvItgwDBTVRtpIBC4i/QAETMREo=;
 b=E4fGhHEaxy34LnKF1Ym9JlVIaz0pYX3PYzD7VfW7xmPmQkJBNiwN5CwXXI8JXHbrS755X4YQyejpVinqXBlpcoA4XAmAwPKCGxKtbMYIlQt7iTzpSdPhNCxMSSE2OQUzsPVOXg3M2Bh1TL5fSkkWKDicIW5lbs5ugElEvXNKhYn7XYSJKj3wRxk4WORO4g3PRw5XchQKtNfdXVJb/rGcZ09F9fid37WcLdcFu/f+08wJt3czTINWuOCaT9Wgxp+kMNmAoxd/p9ja2ZaUDHxQvT+jE9hE7Rpucx/e/E7zVhNu/AiihFWutj3S7mTAeQC5FlHvRecUW1OV0B2hqKRGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge9US5is25TWWmlwZvItgwDBTVRtpIBC4i/QAETMREo=;
 b=xItHIwxHY6BKnh+YPkn5QpSs7YdexNJUH15kQ2X5S/lIlRgJGg3al4L7D/Etoz9s+MskLUxiaaXEYHbhhrmA1GiCRY5JXQ0u4q4MQMagzKiWTebXV5bGCMnFYFrpnopi0HysXqfe4cPvS5qC5r+gdI+ct2ndLE0L541PJRcyF2E=
Received: from BL1PR13CA0221.namprd13.prod.outlook.com (2603:10b6:208:2bf::16)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 11 Jun
 2025 09:42:41 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::aa) by BL1PR13CA0221.outlook.office365.com
 (2603:10b6:208:2bf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 09:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 09:42:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 04:42:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 04:42:40 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 04:42:33 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [v3 2/3] drm/amdgpu: Use logical instance ID for SDMA v4_4_2 queue
 operations
Date: Wed, 11 Jun 2025 17:42:19 +0800
Message-ID: <20250611094220.3376420-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611094220.3376420-1-jesse.zhang@amd.com>
References: <20250611094220.3376420-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e8085d-f95b-47c7-f860-08dda8cc4efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1RBRvWlw45R7SNJUW1Je2ps9u7UFazF37TfbUfBSrs3HrAA/z6zm7KrrbuZd?=
 =?us-ascii?Q?1nmqijfH/cbyWkk6K4ZvXxKc0sUK3Fa0qJsvsF3xQqbRaEYfe3qL+6Xq+hHe?=
 =?us-ascii?Q?Ixiq2ibLlEpz8xShw2lv4ma2c5X6jEciOTfQsvJVRvDZsiOXlf4n+BlcoIK8?=
 =?us-ascii?Q?4w3Yb2oCbohO6P4YHs+Rd9I9+vmEkmP9EI0kJkz0ygSS4PCO6WX9rA4g4t5x?=
 =?us-ascii?Q?Z34P0291Ix2xXl0jIeVKQH197Zyubgk2dbPPPbWwbtv2OGDAfOfCXaV0hPxk?=
 =?us-ascii?Q?uyXh9jls7VaLc/jdkh/PfNouCOBm/iD+4z4+edqLZao9aQMu0pVdjY2S51ur?=
 =?us-ascii?Q?pKDa0v4ZAxDk4yBSPC++vVezGoGKVgeLMdH31P7VKFcq14a/Gxuhf1tQmP6w?=
 =?us-ascii?Q?gTZSTOCCXPVIm7h7ufGA6gRhm7F7chItK7IZ4fCHVUp8d5Iq3kaUA/hc2C7/?=
 =?us-ascii?Q?C4bLwGPLGngaWjODey6Wy413UIB7ZE4ennsj6v/cpg2Dk5DugcPV5oWcjRk7?=
 =?us-ascii?Q?vKEoSL4z6uwkxBa++2MEplT+luCUzUuNbkOPpnTJoffFc70twk8XO9cpKx/k?=
 =?us-ascii?Q?4IfFV112XYopqA1d+3rr4WyGbod0wZWbbayTHWSZqgPHJua6HPNbn6GHFsi9?=
 =?us-ascii?Q?8Vp9xxjZ7wBjySHaKwG0rhsxaswOczkk60+MEa631LIaAx9U4upHOWJ+AK2U?=
 =?us-ascii?Q?KbWa3bcujdCdFDEeWN7t15aV3EJJDw0Azh7YYKkdiEtp/+y/6ot3cwb0pWS7?=
 =?us-ascii?Q?b+EqPyekQDFPOcc1YatY0KZSvzgiR3S8ESWuEMHFpUaXYIGNPRiCmRE4o7ys?=
 =?us-ascii?Q?TnYmiwVnJL1TqvwrApCSwmjkZxXwfWG2bemAlFrec9i6Mq9lTni2aJy2sWXd?=
 =?us-ascii?Q?SM7D6kqM6GYpqd8TsoE7ko6JCBN1sznPQhURXgyeQ67eVYghs30xjxNSe2sY?=
 =?us-ascii?Q?yuIVAfaRgtFnBQrY/i3w8vEvY6hnY1ks0vrKmawt636vaIVtaxo/FqFGYsc7?=
 =?us-ascii?Q?kn2+GV/nmkQygQ3hWX31lvZFiLVdVOXTvLqoRzCkXZEIlvEbr8s8/oPBu10H?=
 =?us-ascii?Q?L2qbvhSvn24AFRaDyXdeyxHzgAkvRXYN6aS4NaNaNbY+IDN315dn233daIzc?=
 =?us-ascii?Q?q/lXuFBiNmLUYmIN39nrkKCUbAd7JEMHnqDnRTb9Y0Yl8fxmXTEg2w/dsd8m?=
 =?us-ascii?Q?PBSJ1bWSpWbEOCHNztjSDxoSeo8okAc3azn0ben4zesOqdYJ/HVrGVI6KXgU?=
 =?us-ascii?Q?27vbpYwcOQFv2ndgcr6mq9Za6TQDAnlLu4mPUpmATyQCKUWyFCKLcR/GhIER?=
 =?us-ascii?Q?KItmVeEYEPu1oVYW0UpnOdZSHCkasJu4OtQFOe0Eds5GW2LPrmXfXq2qL/73?=
 =?us-ascii?Q?D0wTlj04mcHCuomBiGNUbq4EdgRwlJ+BkotvMAY33TE/5vXPGMydPJAvB4Cj?=
 =?us-ascii?Q?l+szXxnkWqjSr1DUgknqc5nZ+fEGYgS5QwHCsijWgZRjipQnOYaXcl9PbiuJ?=
 =?us-ascii?Q?QEdT76hr/wj+1Cgbc7pG7QGhIFRUEZndDqYg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:42:40.7951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e8085d-f95b-47c7-f860-08dda8cc4efb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

Simplify SDMA v4_4_2 queue reset and stop operations by:
1. Removing GET_INST(SDMA0) conversion for ring->me
2. Using the logical instance ID (ring->me) directly
3. Maintaining consistent behavior with other SDMA queue operations

This change aligns with the existing queue handling logic where
ring->me already represents the correct instance identifier.

Signed-off-by:  Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c169112a5e7..3de125062ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1670,7 +1670,7 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 id = GET_INST(SDMA0, ring->me);
+	u32 id = ring->me;
 	int r;
 
 	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
@@ -1686,7 +1686,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 instance_id = GET_INST(SDMA0, ring->me);
+	u32 instance_id = ring->me;
 	u32 inst_mask;
 	uint64_t rptr;
 
-- 
2.34.1

