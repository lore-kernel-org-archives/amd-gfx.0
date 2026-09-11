Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB650C88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417EB10E16A;
	Fri, 11 Sep 2026 17:56:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PirWBXYg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013064.outbound.protection.outlook.com
 [40.93.196.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A626010E16A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGsYEz737lSAiIZRjqPXNcV6PGIoSvBArKWUsAgDoUA9I33UNlGo9uP9uWmCfao/q6HAHB4o7xCiE5/8yQNV7QQf82qP+QwZHs6eata3Ze19nHLtmiZSxcqLv4y9PRYANu6XNNkykp1WGzIsqhIm5wHxQ4z/TZes6kIm6CXJEXff7Lu+Azxj8NCa3n3AXZkAMczNX/yQfjitM33VyN/AQx7GBGbbrvWUtbN2GvWbUfqhQQqkReIitMJSXd/5vJAgylHdj1rAyYkyRBTnr+N+1igl28FVYLUWxgHY6gR0frxf/CRSeVBMIqhqXO/otT+3kaZM0dNidjrGw2GPVGE4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEJdrvBL4uom5hB+zTdKJP6PEL5/HurvHo+s/UYMY9U=;
 b=B/vMQ3DZq5x0LFizwm2Q+Q+Y39OjDSX0WCU0UT97kqmmD7sUMZNqdx0xp79G242W5AK4J8EQPNsyEPwYNRvH1xtTyviaiv7ZSN9Pax+UrX5wZW5Q4RnRQnJbTwHp44d/31disspZ17HRgEGHXUa6FM7dU1BsS35e2W9tG0YHU5ArDm8PU6rBGldL+Kuy3RmV6Xko0yf55wpPrs6QVaDogzMnI+5aeEWDeOu76d3T55konYvC8KpcVFfJ55Nlroo4LYMXaGmx5WwVeS5ECF7W0PG61gHH0kLSshJzFS6SEi7mtZALXg/SVgurm3rHOM6h4nYAhx40TZ5NxvmWpEsI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEJdrvBL4uom5hB+zTdKJP6PEL5/HurvHo+s/UYMY9U=;
 b=PirWBXYgTxd2gdcdR4xsvRTEJazy9/tvy/FdbPJ58dRHQTL4QFLXOBRiZQuQXKJ3rR3ymP1woU3X9GLcyYNyhEE98xH3ffyPtvVGhWUCVkRJxWiPhWB0F6NttojEM22yntR8OuknrOXp+2LvJN3A4fFAgdRyZwKUqoM73s/hd0Y=
Received: from BN9PR03CA0153.namprd03.prod.outlook.com (2603:10b6:408:f4::8)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:56:03 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::42) by BN9PR03CA0153.outlook.office365.com
 (2603:10b6:408:f4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:55:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:55:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/23] drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
Date: Fri, 11 Sep 2026 13:55:22 -0400
Message-ID: <20260911175544.1314467-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: d81b0e35-0f18-45aa-9cbc-08df102df1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZnyGCiS39zcYZ8O9hFWG0MHIJvJVskEc8NYngrmCv5PsX45oNyw2j8zin+rBbgelaD74IwRH5wR1pY/v8lPa5nNfWQPlvhDhPkET1oPBHlA1Hk6fWl2LFKTrYI6Yi4T2DphXlt6H9zEo7MVb/gc9oZ1fgMTz+sGhX9VZMIAjLeHE9dsOQMpdOWDN4JNaCystPAG2K8iB6h9sPmQK3YIC26g/NJaqTmHlRX6lGGhxaAYT2+h+TvhtI+jJXSusjlzfVjjD/yCcvCmlQsazw3+VQ0Yu8JY+YP4piIncf2lO9Q0P95TzUeH0MlTQPIzQofYz1Kx6DvllXU61GpjA43KYyTCWma+yxlKARE0Y0oRXB0DbFS1ut0YukLfVbb+YcuGbC36NLYuafvWGD0HYHDBJMNDSSfCjCuRdjln60vo324UFToJwaIHGn2SD/fJC2wAAHMwVlYJBst4joNZIerB9ZH7OvLXSOnpSyEKrzxBDUwtGZeKdcsVbZmBAqcRIBqRSPQ/zypg1y4wdIKV0Ra9Kaau0mChaj7CFKk/H3+t0VtDbFGtZC/rvnxz1lFbzwvTU+dqPlPIJZjEPJiUPdiqwbDF6fTc876U0SiDT/avtuDERTtklYTKi80dd/sOQky1zH57V3Xqt34sspVxZ4Qk1fLBQdnYvbel0tC6tau5NN9gT8lFzUWmjaTddvS9pocRteCA7wgAgHhpGAuRcmqE9MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4yqFfSZV6qN1iXKkP4qzXiNRE4hznjpH6vTg7pcrhwPSpOE1AQZn+aLhwf4dwAeJwar6WGBdEs6W+w53YR8XUDiK6IX7DBKFZFe17sneR5vwolmT08VquzrAvc5gPtrJluYksyQ0zdpInDjWs1DmsYyyyqjI2aJiHOrZKtBsy6TGCkIxKKmKIwusnroJW745stBHil8GQA340xS/nBp4gPn3GknP4SvtImJ0FokLjlVh9p8FQLJi0NpfxCoBlh2g88IiGV34te5FCao+FOJpo/jVltXalB0D2kZAWX33xKQ+3/jQcsfJBpFN9AuK6AHHjLNrqprdYO66PgGAqrwWwx8/Qd6ZbNAG+f7ManieyaWtVKbI1OnuK9T4kQNcdVkP8SB8zBXqYxub+yhHifJ03LyGYFqovRWZSH4+NsEAdWVkXXybZ4JA9OwZAbAFmi9h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:02.7666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81b0e35-0f18-45aa-9cbc-08df102df1e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ for TLB flushes so no intended
functional change.  This just protects the MMIO access if
the KIQ is not available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 633772fa71fda..b036f7fe27b8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -808,6 +808,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
+	/* disabllow gfxoff when we invalidate */
+	if (vmhub < AMDGPU_MMHUB0(0))
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	spin_lock(&adev->gmc.invalidate_lock);
 
@@ -873,6 +877,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (vmhub < AMDGPU_MMHUB0(0))
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (j < adev->usec_timeout)
 		return;
 
-- 
2.55.0

