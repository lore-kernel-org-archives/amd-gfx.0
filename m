Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9236AC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB55C112F26;
	Tue, 30 Apr 2024 20:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kWWVPV/Q";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDAE112F27
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR9vTd+uwSHV+YyWlo4xOI1q3hnVpN3LmGcoOC3K1spi193YCTRFOpSONiqEmYIaUjett9UM0v8y7e+enTLOj5fS6jhu/uDavNnRxKwlxSCPQyTPy7QExW9jePiOz6W+XQJOciZkldW/zJJJ+pkK4EqZXYHfKGz7u8OF55HALDBnwtQwBpcvVAM5lMZch+lnMfIh2Yr57vqfSGKAbIIjG77lusYAIsG73niEeHAddZnI0TnWAUEfjmhI5XkArZYBcP2pVyaJWh03pYaXGSM1OgBORw2RmpVeWS73Erv615rIU0d6iWAXJjVUClmaIlNiEh/cYS2kM/Qh2OE8Hocx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvIkH+h8UNjI5GTUoW/HDVItjPXZ0Bh78tBitHKPOGg=;
 b=EnNM6a+SX16aCu8ZPOcUPF47QbWFEtFdRcAmfxEq8HcPIQLOKqtV3sXhq4SKCIgYG/A4QzsiCmuJYPAiwlWK7WlLF1LvtbeevDn7JybDjMCPnuPnUQAy3eNXROFXXvliXX3VUsFNHvTCDp3VWuC/2ZrGOiyusZAdyJUZg3WQPJOmRAIbUxQGvA5gfICIW/ux45Y+osH0D3AqTRJ6hCmflext/GcOJaxQCQNEm00vbZYbM03T80qF/w7QFk3RMK8pPQ0KZQk9kSa+WiMVju8aPCXiG6g9fZwPBHjtB4AasqbwW39JOaE431es9F1ME6bfeYLWe3fbm0egjmvdgfdGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvIkH+h8UNjI5GTUoW/HDVItjPXZ0Bh78tBitHKPOGg=;
 b=kWWVPV/Q2zgHPgUh2BZV0ErBG64fD1bjfV8rgf+CXK+URFfUeM3y2ZDjLXeAHgpLGzo5AyinBdLPlBS7KlP/lSOHNzHiNW3Kd6rgbIdiOYdvhdzsAAWSWlUPETi3RpQamlspXpFH9OHb4DZvnnAMF9ZiKpRcCQIygh27wwe4Sto=
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 20:34:26 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::ef) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 20:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:34:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:34:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amd/amdgpu: enable sram fgcg on gc 12.0.1
Date: Tue, 30 Apr 2024 16:34:03 -0400
Message-ID: <20240430203405.798798-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203405.798798-1-alexander.deucher@amd.com>
References: <20240430203405.798798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a15fa9-a76b-407d-d7a2-08dc6954edc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A/84SO0f9oS+nduShfFPLoZoJyMLD8xmFNpxjWyaHtFcjSZ8eb5avgS6yHNS?=
 =?us-ascii?Q?1SFqyO6dsGjvK0N40VdM5dYj6IjPJyHdWtzGxwTntYzoVIVoj6MUm5UqD58L?=
 =?us-ascii?Q?S14Je+SIs+AzPu071BUof9wVtinbMR+arCvGezas/4AsYV7C2l+KK21dzYRF?=
 =?us-ascii?Q?cZidgeSHmxgY/hclPW9/UwtaqJ3UROpk5aTh9nWEAMzY9hLw9jEsfVB0Bhwk?=
 =?us-ascii?Q?EA8zWEwkguS10AcCteHaIAgQqaq4hFzzoclOPS9+dT8B2aG8idhnqIirQYS+?=
 =?us-ascii?Q?yg/2zekE5LPMnYmgaStsy8B5xVmG+kGysQ24qDeTztYC7/POjgz0Ypu/qMww?=
 =?us-ascii?Q?1+VDH6Ge6Kk51gTz8HtFQQ6Hlh5O+kmSnk5cT1Tw4XLofrRrrqky/od9FW/g?=
 =?us-ascii?Q?O6QxTtCcFGwuVnH0JOh+8OkXv8+2Ih9G7VTOx/6Iw43sxiSIo+zCKrP2TwqB?=
 =?us-ascii?Q?B6seGqZ34aoiQUVtABjmklcK5qO2fcBtgBswNDydN4Tl1TDsfQUg9u9yMY6b?=
 =?us-ascii?Q?TxPLx7BAXqECSA6Y8z+FeYvnxilhYGkKqaV9pdm2UhhazDG0+vmq/QSWC+CX?=
 =?us-ascii?Q?p2saV145tRifG4o0GyyzcynW+lVUYCMBkTJOceN7X+CYEkFzOckcTXRVE9p/?=
 =?us-ascii?Q?8t1kuoBKD5lwgchVyqy6fb13K981fjwJS1leFakt9w4+ZXEv11FwmoYaPUFg?=
 =?us-ascii?Q?0TwUU6N8ULn8lL7EMmHe3F/KIJUqIFMsEKxz6qu75/ojSzyHISElcd7yp+uO?=
 =?us-ascii?Q?hTv5igkKDr4ABGsLApBIvSlWEdpCm3w6/+du7vxqx4Y0dBR/0i6Izv4l0PJu?=
 =?us-ascii?Q?KMGJUoA2DhrTu391UwNfl3/7MCYxnOjLH0LSlqADWGzc1QtH5fVhix3ukX+O?=
 =?us-ascii?Q?j3LHn7+M9mwU85B0n/KcsVM+2znaPW8gsi8akHVHUjMjsQsovPuFj9eyBt0O?=
 =?us-ascii?Q?Yh8qVE0qapcrV4AYI5G+EJ0JW1rl6o88rSs2EDJyKeZgXOM9n5ZUmaY/HqJ7?=
 =?us-ascii?Q?JvnLWYVoQEzz9/dhLRPCQ1NlTjZKoO7PiewUI5NlCfK1+kYFjnXynw1Ulrzx?=
 =?us-ascii?Q?96Y/IHXWj3p+YW+dwr0HrwzV4QsN4s+wURaMQIjBm6jXcZy/dXgiexDOLHlO?=
 =?us-ascii?Q?6g5bbfVkiLkbIInTicKAFzPWrgeQG1WcmNcpVLYkzXli5gWnZWnHlOkqDmtk?=
 =?us-ascii?Q?qul2EXnEEa1oQuIzKjQNwdQzYt4+X9u2S3kC89tAURJJMu5h/u4jfTuQoP9d?=
 =?us-ascii?Q?Y6JerYlP3GTQri0DekOwxLyNfFFphlPhSCjHjYu56UMd1D7q4R1K1YTv01Lj?=
 =?us-ascii?Q?kOPq3+2lGWrjNw/uqKRBzAAEiM0fLmDnduQ8ohlb538C1mxT9zRh8NZ6Wtip?=
 =?us-ascii?Q?d0Ht/65qhuZHPpvgfSVXnqam5ty0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:34:26.6594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a15fa9-a76b-407d-d7a2-08dc6954edc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
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

From: Kenneth Feng <kenneth.feng@amd.com>

enable sram fgcg on gc 12.0.1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc24.c     |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9aeced9d31616..8d4b234bd287e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3797,7 +3797,20 @@ static void gfx_v12_0_update_repeater_fgcg(struct amdgpu_device *adev,
 static void gfx_v12_0_update_sram_fgcg(struct amdgpu_device *adev,
 				       bool enable)
 {
-	/* TODO */
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_FGCG))
+		return;
+
+	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
 }
 
 static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 701056a865a4c..174126bc5f602 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -407,6 +407,7 @@ static int soc24_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_GFX_PERF_CLK;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
-- 
2.44.0

