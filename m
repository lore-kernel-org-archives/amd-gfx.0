Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDAAE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 10:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD5810E0C9;
	Tue, 14 Jan 2025 10:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bob2NKFI";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884F810E0C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 10:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+cqWgYESjnKUE1ccnYJjOjYkeUcO+3Vuc5BD2EmHrFTSCBh+Vcgd9idjOEzMkDEauAu7RzSXOpAMJ5fbE5QeOElYgakD/erAncNN2i8PhklE3uNHFPsPmsXVGlptnQMJDa5Kt3qF87vYBEBd8rk+O07bmL1mtWEEeLYdLFvjQpiWCnKMzB4jwiaOCxBCJq05NUCkwJiw5VRwjQ66EPU+yOJEgm5SJKey6kOQhLPn/IIkEtSboJhZYZXSsr8R8InwcN1l6+OYqZyddnEhuxOKRVEtOI7A5z7Cn3VNShDIQCWZX5Ytfv+56MnCkpdaYW0xaRazeySWoJjpleqM+oNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IXSaLbLcuT+opvk7E+396YqTqtrL3iEh8uR9GS9BRQ=;
 b=pILTcMQB0Rg4Mvz24sYxQuzLj6Fdv0HSQ7NPWYyTDt92IYPpeI+1OLGAzrfKv1mM0n1/eh96d6ETWu/4oLcuJzJ99S5ru9vC9UMs4vFgu9O9KBKcGJZ2DLVBpyaC8PtAXQD6krKIU5jnPPJZKVQkd+uPoqrTiS5FTyViG3XNtPIq3wxzQhYXcZn453JYbr+lfXoMbXx7UReYQyH59/vGSFARie7rtb0lT7tUOIe+FlOqAnbuW7bG9sTGa4f9R333Iq8HrunZXpfgbAYQfwwIK2S8R9UATjqjuHQW8z22JikKXbXDXEz8LRWMpzGbkjjV4tcH4JqYEBTfkCCWhF6YfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IXSaLbLcuT+opvk7E+396YqTqtrL3iEh8uR9GS9BRQ=;
 b=Bob2NKFIgmo2Up5EkRgXJrt62+L7C2vI+SpOB2eVD5HRgFR50rODtgqiNWMWfd6Dexh7df7qEjQDhMkvmiqAmD6M3a7ZLGZxLUHySahZtfbA72Zy4+G98IIlIF76Z+MvtbsChVoaQhk/hrfl3BXmXBqmJYKPk7Vm6PRR+IezHts=
Received: from DM5PR08CA0050.namprd08.prod.outlook.com (2603:10b6:4:60::39) by
 SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 10:06:08 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::c1) by DM5PR08CA0050.outlook.office365.com
 (2603:10b6:4:60::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 10:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 10:06:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 04:06:07 -0600
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 14 Jan 2025 04:06:05 -0600
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Deucher
 Alexander" <Alexander.Deucher@amd.com>, Lin.Cao <lincao12@amd.com>
Subject: [PATCH] drm/amdgpu: fix ring timeout issue in gfx10 sr-iov environment
Date: Tue, 14 Jan 2025 18:06:03 +0800
Message-ID: <20250114100603.20997-1-lincao12@amd.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 9394b564-c6d3-4bab-af6f-08dd348310b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x93zIsK0kxy/n3QPit7zbwCDqZcEfrzPDCHMZqGzhYXIt9fJ/mfl9NIRG6xF?=
 =?us-ascii?Q?lSY6aAbZppVZxHNjs1u3E/E1XojMC9DAPXdXWUxa5HqpIDCKtiwRXzMiYF7o?=
 =?us-ascii?Q?P9mtTo1ETXr3G/JNO+SDX6kL3IUGYTfUpIW0l1QHv8Yhbhk3tEMCnw3nftiK?=
 =?us-ascii?Q?zJX9DOGUjwXn0jQ+n7g7+rHvycgHdQTi1ytQQG6YUKXtCFG0y8QHiGguGQSy?=
 =?us-ascii?Q?WkRHv09D5yBxLa0+b8PuaA0M/s7zssqC4Mx19+uHkjiPk9Gw1DGIOoOGdzPa?=
 =?us-ascii?Q?HCcGX8M1xjEXMwmcHjT3QmSn3a1fKj4JSlEh8SH0bA1RF4beq2VuzMQ8HJhh?=
 =?us-ascii?Q?vA8PMKf6gE7Og9q3O70NHn2VTEXLauys0S0MO5mpTiDrQN0vjtXoiVIBGrB/?=
 =?us-ascii?Q?4DrvxGesMQNlXGpaymoKpRc5++sVVxAEErcXyBdWWK9u7FJZXPrBQqMmbS5f?=
 =?us-ascii?Q?2LQUIXPOAO4BnWKWYEUX0AoTwFz9yWFIQqA55CHnWNB/DqgtuXJAMp7FJ72D?=
 =?us-ascii?Q?0bAOWiO7vXHjLEHnRn8N8mpMAKlcGLLByNZkgSqr7cJ78eL0FodhUMvpuM6G?=
 =?us-ascii?Q?tQ525ePUZmHxyJmfa39e/JsHB9qMBJ+7kOVwMePJDPBb6YvWcoOo2MNgxoKG?=
 =?us-ascii?Q?ZawRuo1dlQwS066e1FqSLyjFQoMqKgkCEje3t4/8uDaxsyq2SdWDow44vXpn?=
 =?us-ascii?Q?0BWUeL7JJWOC7IIQm2fi1crr5ZnhINB7JH5meU45kXql0p37kEgc69kj2MNh?=
 =?us-ascii?Q?R6rZBzvxgY2hfA+asQoN/ULvyyM0x7945xs7oD3AZ2C5wIymCBikT77ed0Dk?=
 =?us-ascii?Q?Qbp9ECuSKaQLVJPYOQCOPxKOYVqhfCsaV/OQgsDm4e7KpT4JNfuilejOhJa4?=
 =?us-ascii?Q?nSuHG9caMtKsg49t2aE29eT8fkYtFb//C3/VKPI0RgQrf25xNYrnFRbm/72l?=
 =?us-ascii?Q?4S/4VCvOTtt/6kU+CFXp2ztYdEdOpzfFK/thsVBGzLDtXlg+MBxsDgDdgSgv?=
 =?us-ascii?Q?rQV0TZBZjKJ6s+wYEOycG/orRumsPC7M5nP8YT2lvVyOPDTC7jkJdp5fL+Fb?=
 =?us-ascii?Q?ArhNlzqCVf5yw1hy8/hC1Ib4f8qLBcHoaBFd4LG0RSjmsnpSkby5eKo760Pu?=
 =?us-ascii?Q?RXhWLZkI84JTQEVoTD0+5ClSSPOtkk+9/BTZFQ0tYGFFwwGSgBjVAD3ECyeN?=
 =?us-ascii?Q?uxTExNJkqPBJIswxUWljsWK0xFiLJX163UJNCRigdn/h8jHo32SLFcQ63AV4?=
 =?us-ascii?Q?80ErWrPp+GuhrRcla31I+woBjt7wNPU95yIUj50sKG5jEw5VLuWRrZ1V18rc?=
 =?us-ascii?Q?+rVmATdtlGMxu7bmn+6wAXCBPLrgbeDbA1QmGRTP0XmHX2+2+icPLp1LQISz?=
 =?us-ascii?Q?OXaHr2FuhGORhigfpKIt8Sgcc3hKbUN9hbaKGjIJkOEPwEykDSHxNWpfLPqk?=
 =?us-ascii?Q?PyhuQkWhA1tBQfzEpzdMTHTHDYCa4jA8jZj7K2R5tl7M9IqQRKLvkEj/kpII?=
 =?us-ascii?Q?jjUJBM0/rifhKDs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 10:06:08.0658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9394b564-c6d3-4bab-af6f-08dd348310b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
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

'commit 6e66dc05b54f ("drm/amdgpu: set the VM pointer to NULL in
amdgpu_job_prepare")' set job->vm as NULL if there is no fence. It will
cause emit switch buffer be skippen if job->vm set as NULL.

Check job rather than vm could solve this problem.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index e0bc37557d2c..2ea98ec60220 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -297,7 +297,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
 	ring->current_ctx = fence_ctx;
-	if (vm && ring->funcs->emit_switch_buffer)
+	if (job && ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 
 	if (ring->funcs->emit_wave_limit &&
-- 
2.46.1

