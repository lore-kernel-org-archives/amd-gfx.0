Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEBCC53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 08:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFCDE10EB17;
	Wed, 29 Jul 2026 08:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="snfNzLZY";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801B310EB16
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 08:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ml5JeenCRf49GE5Ua9+V1nZ7bUqN87a522riANvJSpGFVIDtZxNoCFvDTVoRfbyBD8jjtGLugccxgHZSDL1YyNoTQrcxFhqfHdWNm3Ch+MHrs+rq2304Nn9p/daMeVUuRbaxxS/Qsd4HFG9gg5HSPO009IigjJXjgmpBsdS60xOKd3TU+ErM7QfXOBfYECXhjr4NVzcNvGIlcujGpr2xTsoDtpGLlPjWnuqZEhAXwCmTd7yQiXKFjAsrx9l2gYDePEmvx1SFCPbqAQcG778gRpQ2lohEj71/A5/JccfyRSm4mTP8vPtSM32U1bZyLKzxSjBvp3PJKv8d26X+tjGyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ius6Svk1ApFOFNl1V2MmuAwd5QH+QEXbw8LGhRijVis=;
 b=l6CR1lQ1NRVsK3wygehj2B9M6aF/nZVEkXa21PoYg4LOxUZjC5VW3XcddS6pL1+95Ss+XLVPzQRsjA6EeI/Y12Xt7XIpz6CHoqJguwb3M5L3p772ci1KBwx6HffzbNWa0uYCrElk1rb0s19/HPmV0q/nQm6vuiwA+xk+zBOCIa4MrZQf8jxnxYFQtQC0H03pqP+aXzc8O4CB4tge/q1Q5nIGph646K8Oy05Ty/ON5diozuPKl+SuY38xwFJxFFXUH2GKyEnIf//ESG1FOq00KKWR26V1/hlk9lGEg4D3qe4JEsXbZ9RAsLtl8YTIj57Jsf9Wq6fpdg+oQykzEWUd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ius6Svk1ApFOFNl1V2MmuAwd5QH+QEXbw8LGhRijVis=;
 b=snfNzLZYJ+VoZfHIAcG/ajkVlQGLnECirmdTtmFkcNSs/+xcYesWpfEF0dz1WuVr2hqSYJem+874nK1BHDphqzcWQUepjMXXTrw9VM1IwwcweMkx6TIrZvkpqxzNMaDgh28Tn+iOMOopYMPWOQpkK1Qd2Q/wkDdbr/41R+TjUpQ=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:58:43 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::a3) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:58:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:58:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 01:58:42 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 03:58:41 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix JPEG v4.0.5 queue reset failure in DPG
 mode
Date: Wed, 29 Jul 2026 16:58:17 +0800
Message-ID: <20260729085838.1338931-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260729085838.1338931-1-Jesse.Zhang@amd.com>
References: <20260729085838.1338931-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: 022906b2-3966-4a0b-7569-08deed4f974e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F1yb1kJGhTXL0gWi586/ibBNLC2IVfgM4JMTsG7GJPra7GxxmynlgrWA3b13gUJHpM5ZnrbgAPAvKMv2igeiP7KW/dXrjdEid4vabYmyQw/FDNhdiEsjRykWQqCntIO8Ggc5GpGOs4KTKGPjF1D+WCC1FeD4+ZX+5ZWAXAHNSsz/8HPmysr8C91RBg9VJv7y8bQE7xYd5UoL6dklZUieAMOHxu51kZtzUNgq75Y4idPdnsnK+4sVOTxTmfgAjKPQoi5D/74ElmDQsOOoT8wIOK/bwmB0vS7X2jhl8pdjHvwlT2rjmajsDmTfI1fO0EYaoPNAk2aR6FAkGK7DyGkdGniPS8SOOvv+GQir/VAg6pF+e/CmagtS9AqA3LQxHtcUWYUeN7/F25jG+nwkV8gA3Mik/zT9G/t14U4DS0JULpiHESzgMfQYVeJ/2L3pnYU0boex2VmMtLal53X/rwvqa3SWVI1S7DrQUpN8wBMSRPP865z4Hqjzl11lPA4hTpz4vt2n1vCxtSvwUV/kc7+TgwvnMiwPOtKfhcAizBis62BJs45t7WRccJPEM4FaLuTnviHYXF2cw5nuZ66s0PmqgTIQJbFiZurSyaXHM+KzDjLh/LPhcW8jpMJWihDO/0gWfT6WsV7pVhq9FPCksj1dZdpxCJJduJFrKZ/i42k/2dvxMYbGvVQjMGp6wku8qK3DivA4oDw0IDewGTfF2M/iRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5WfnMK09hQGkgTIPnFUaH6d0lC0NCiNXDt7S059EAhOkGzx5WlN2JyUf0RHr8Bbh5jFT+sNAncb+Cy945zlK0gbLfkwTkCpe39ra2oAwIoQfbjpPpclg5r6BAWgJu3PGp1L0bmxmxMvW1DFVxfYbapN9EKBYXA5nYnSd8wTUaJJacPwLSGTo0xpL88J1xOQWQBBzFpzOL4fEPR9tj8hyHT0UCzwNF3iGuZHM3Ij8ONldb97mkS94A6xdealay3998Vh6bYcQModqRGM2uUZr9Qmx1ZASiqH9xBBa5+JRDcGJZs69sId9yW5M6BieN7G6aNl+Zrqi4ba8pXn7qBfAMpXONu+DRz35KM6KW0pDRFfJ3Zcl8Ccbfp+aIxfewblTcZPaCeKKvXn6BKUlUIbu87zNQgkUrNKKInOFN5c2AiQnJnqjqqH5cMvQjnBcvZeL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:58:42.8620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022906b2-3966-4a0b-7569-08deed4f974e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229
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

Like jpeg_v5_0_0, in DPG mode the ring reset path only clears the
JPEG_PG_MODE bit and never resets a hung JRBC, so the post-reset ring test
times out and the driver falls back to a full MODE1 reset.

Temporarily force the static power-gating path during the reset so the
stop/start sequence power-cycles the JPEG block (JMI soft reset + power
off/on), matching the jpeg_v4_0 reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index a43582b9c876..3f61d5367d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -772,15 +772,28 @@ static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
+	struct amdgpu_device *adev = ring->adev;
+	u32 pg_flags = adev->pg_flags;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-	r = jpeg_v4_0_5_stop(ring->adev);
-	if (r)
-		return r;
-	r = jpeg_v4_0_5_start(ring->adev);
+
+	/*
+	 * The DPG stop path only clears the JPEG_PG_MODE bit and never resets a
+	 * hung JRBC, so the post-reset ring test times out and the driver falls
+	 * back to a full MODE1 reset. Temporarily force the static power-gating
+	 * path so the stop/start sequence actually power-cycles the JPEG block
+	 * (JMI soft reset + static power off/on), matching the working jpeg_v4_0
+	 * reset.
+	 */
+	adev->pg_flags &= ~AMD_PG_SUPPORT_JPEG_DPG;
+	r = jpeg_v4_0_5_stop(adev);
+	if (!r)
+		r = jpeg_v4_0_5_start(adev);
+	adev->pg_flags = pg_flags;
 	if (r)
 		return r;
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.49.0

