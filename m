Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7BBF417F1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4D510E51B;
	Mon,  9 Mar 2026 14:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ELEUHfnW";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010070.outbound.protection.outlook.com
 [40.93.198.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE05E10E51B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neF+dWFHGtZQv9J2xxWJWTmNOwUwflwUdy1f4lfvVdX7o7d+wZ7QP0KegvKniRqZiiS3BwVlHl7ZCM21n4aQ1nav6h5L7+qccEzocqhy1cj8d4IIkqEIh2WuRVIyHg7OfWp3CZbghY5UGGvhn8BD3UEbsFeDzlzyj1bg4WNEyhcWIKeQcBzBCGmoQ4epPM4JkJa1ztKm6nc/aHYjPsJNZoUNHzoA5rkvQbEnhbgcTGHiRNWCbziAqL0bCSAD34K0AW9WvVaTjAcVQxmyWTCzbWazAx1Ucm9YsIQ36chdM3gHxFPXWnodo4Js37yYsaA6uUC/BQxc/54ZzZz2j/ABZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0Lcfi9arwJUOLwBVhmjt4kHM6fr5keyFCr4D2sTAEk=;
 b=HYbgeGTvNgKcoymgvP9BtT4AtGkqmiQKi21vXWiu5ITSBmVHr/pbaLG5qUai52u9u3wbhHy64bPIkwz8Ngcqqg5yJSibotDiTp5zbYCcKXfqfFs5q2jo2eiF7tVaLppcNP/vOkMEumPFJ4oMp0/2s8RlPpCWyrKCpEUw3KY9nnm+FMc1CfD0eVblxp0rxzCiZelUGcGZaBx+QVd4um0uqcyTCgYQaEyM1GIUq+n+vOXkhV01zzRTenoEvlf/L2/ZYK7UkxjVngAv3+mUpC+6iSL0XnXwWCtI31Jda2KnamO4Fg8LR1Em2v0IRM7uDrrt7atgKk86N4JJHWX+g2pp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0Lcfi9arwJUOLwBVhmjt4kHM6fr5keyFCr4D2sTAEk=;
 b=ELEUHfnWukCzTWBdMcDQLaEBMX3Mvu3U7hZ7N+2bl+1XIVt+MtV89txaODUtJ8zeXxFdcA3vW6TpygA0FOrupvneLP4MnWK5wgil924ZZ0onaoo7mH8CG3PsVFzFLLy27X2CHesUERU9l99gSqaUzyKreqAWxnc5W9nyVeJGMoY=
Received: from SJ0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:a03:2ef::19)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Mon, 9 Mar
 2026 14:56:51 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a5) by SJ0PR03CA0194.outlook.office365.com
 (2603:10b6:a03:2ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Mar
 2026 09:56:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12: Update connected_to_cpu flag
Date: Mon, 9 Mar 2026 10:56:26 -0400
Message-ID: <20260309145629.2844495-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: e4451f5b-db0c-47c5-d5fe-08de7dec18db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: CovA/hfKTgsqSz0IShAuZGfcjR8dwWcDXYumKeb/snNKh+XuZyvdhcwM/IILY++80K+j7SjrQqmdtaclIS2w0X9tzTj24x1B84tU5lkSbHw/iB6wRllePF+H9sYXX9gkqfmccUfhtO+UBfuY1zBk/VFtZ3lr+aRtPHiPk4STW+0w0ARQdDvosXaEDuU3vb4pNLJJRM9cnYm7furryQhKGjY8AziGMWjgMl4m6O4mZfjIj+MPitaSJvOXYBWkrbscvazDh842RHYjA8oLQlmmLZuc28qmuv/JBOhelh8q0TtWOir6rY/7pA+aPSua17KvnjFjDOjrqrELY+gCZtFw74q0Wih8ECY34LELTNkjlCbKlXbQnArnuLAcpzlohDkho3PW958e7w5nksBTaMOhpWxA5iknO2RU6cAioMtXA2kdr+s82C51mPDkXkjkDzVKJobsbLHgcNn1Q2PzCBRtBR0KNGsqBx2nnAX4eFBCTkZJ7JZe8xXQfIWyFraHRRSsW4Uan0uuayvfxAF0MOBfS1w3ILGAw0zahiz39cXSXHzd26jaRrAkL527ElXnWd66IuUoeXBCFh02hpahb5ddAf+3fzHJPPJ4KwqkfOhCmzCoz85RwTWxVz5bwuVXb/+SxtkHFPWxfjr7WU0EirUwH4CsmYntdxw4/kVRehwB7SxWbozQCskd7an81+6uvsuTM6VxLDKqvTtLx2hBblZ1c8Ht4jm5ZF7UY934RYUGzO0qbLoLZ9+DypR+DhDa0Ytrn7WgzgMTrYOZhBUXhuFOQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MeSFUA6yZIZYz1bu7uVfh5lIeAKJAkGwCYFPeid+iZ5kZuPod9ryD2WipYEJseljRspdE/lGK6nlzuvZ2BvYKovdyk/Gni+7NSeFY3FJe48E22UGq/pqCYr8494rzIdo1J6Lnt94ogFaFMjxYugpkedbkbd7t1xoTlW4xcL8w2paKFmB9Lq/NMiC2X/DHarOujg5f4qRlQGRKzX+5sjb8I0vdrAo6ejT4i7O0cqTqeVO+LyK4QBWVIGyK8A9wVsngOhGpuaU2DTVodgf0gTHKU6KnyXaDE4nClqhqseq1QhWRT+GqgNWfK8Iq2Gi1F5LRPrObfpggeK1/sDu5CBYpwnKnaDJ++YmsxkmVSmHSUush7h6nz3GelfUQiQOXUhpnafeXNylPpt6dWe+Y3qFwOp8Vzzvskcxh2FOhjzPkRWZVoRB2zH2dMB6Jls0jzww
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:51.4619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4451f5b-db0c-47c5-d5fe-08de7dec18db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Query the host–GPU interface in gmc early init
phase and set xgmi.connected_to_cpu accordingly

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 75bff46ca5946..2b5f01f15fac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -638,7 +638,8 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	if (adev->smuio.funcs &&
 	    adev->smuio.funcs->is_host_gpu_xgmi_supported)
-		adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
+		adev->gmc.xgmi.connected_to_cpu =
+			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
-- 
2.53.0

