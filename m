Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C046E93817
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 05:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A9110E142;
	Mon, 13 Apr 2026 05:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hjXJC2ox";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF0210E142
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 05:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UksFAo/ldSgQnSsKEGORD/V/T5DDlAreBiWXonv46BuKIZrdJOy27c5E1qhlvahYWIjjEp5a6iQnVeJjF/BudLFSHH9vNdbnPxGScFPSi4HBTmORyc64kM0Gl6otedf74gY2/0a9VD0NftgaKIM1WShvNB/6dXgvNBLpx9oehV/4Xfu+QwQHfcvQzViAFvFh3RNA/PL2VJYd+tttDi3iEd3bdRQNqTTQio+0/OTjMzaBNhNXyhqtgmwlKhEkTI4+72HkwqDK+4QH9U7EnVbLKlbmzCHWqWeOeE2QcrtJHMlgSZicwHQhisVXVwHEH949YVUp5KIkW8tTx8SAGU2Qxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TImqq/J9xlssjsG2jWkDzMZ5RvSa2cXYF+mjPjeCiVo=;
 b=O5zNW9H7/pTKBRFLnvNyFt3YfWZlWXGpsBe5Itoc2QG+Y4MSaoPVXIvDA2krIspztZNsL9faQVOrTAsGw9JPKqEMJ58DRKaCINnHA5EjgbGSiLudCisq0U2j1uuZpQfqdbA032axWXhhmy0TYWUl9Zp12qI9qD9e0gAWM11qYEAt4OLQHoNxaQ8vepfyrteaXtH+S7ELjRiE8vnIG7d+tcaYruWrX9zPi/G0W7cMXfORqRhGQsmNvol2LaJ47wXjXXOyOOYk6228d7GkGSMhyamPYQ48Uot03fqzlTwyLbT7roSI0hLXANkosJHqkJPohE+bK/l8u4VEp/p3wquGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TImqq/J9xlssjsG2jWkDzMZ5RvSa2cXYF+mjPjeCiVo=;
 b=hjXJC2oxz8KZYTEUy0iVtZzaLd5OTFvFRDmkN1Q5Zxv1Ol8tuugoJE1j7EUMfsONrGh80B/mD2U4G1rgiE8IYMOxbczaTpNLL0kAe8rYSoolgJK26pXkocfPdOLvSJQ0n0LOGlnpiSENdaxE+TzXCtvFizS3kQETWd2iz+kPX00=
Received: from DS7PR03CA0355.namprd03.prod.outlook.com (2603:10b6:8:55::30) by
 PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Mon, 13 Apr
 2026 05:32:18 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::27) by DS7PR03CA0355.outlook.office365.com
 (2603:10b6:8:55::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 05:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 05:32:17 +0000
Received: from rahulb-Jaguar-Krk2e.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Apr 2026 00:32:15 -0500
From: "Mahantappa, Rahul" <Rahul.Mahantappa@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alex.deucher@amd.com>, <christian.koenig@amd.com>, <Marek.Olsak@amd.com>, 
 BRahul <Rahul.Mahantappa@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: use CP_MES_MTIME for GPU clock counter on
 GC 11.5.0+
Date: Mon, 13 Apr 2026 11:01:50 +0530
Message-ID: <20260413053150.50007-1-Rahul.Mahantappa@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9cca32-f2fd-4042-a82e-08de991e06d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: u7iGOpOYD+MFWJZCyJyLanrfIn9fKWsfzvhsNssqBJVWIPdpBcpLKYGfTFJbLMEN1pORLn0nDLpNCb9ao91f9AyqZ2jC1qfQGdR4u9m6i1PltZogM9Db5E2L8VMJJ5BI+Z+foq2LavM51D7xAtXjdytenVMyrVZIss8CZdzOrobkvEbjEqo/LLMM5e18W3W7EzlR5n4lrHZKEH1d64CBddG55FDW12i25jYFWrZVijgh+/0Fn/UN5LLmVZwTpQUpICIs6vNbjWlh0F0F29pSXCYiPkbEdfTZZK9s34f0Pd5RufkU1/CIAjkepV+kw3V1MzR/Nde8JNyE/8sj6DoTJrgC7yfSH2kQKOBUXFa/WKIg5vWP9HpPFfA0qpdSQXwp6NZqc8praaZFFyMt1AkQdHISk+KvlcPPyuUiMfFJmh235ApaMkD0LicKNyApoXDgsugnx2YWYleOPxfCpTbMT8fkiJDf6+qW+VPw9DST/y6zDniti2sXSlb+no2iRp/MZcWJ0/Oz/92Eg5T5kSzvOdmCFO5OKtU7jCeBQPqTC+IH8pLyIiQ/+Sl3ovRfuPIuln1TNiA7WY8Kt59INRkZHA44VUIGDP2w5d0Ujumq/2XfynrUH/iDKIpfH72zFxFbK/3seedNM/F6CbUq78XlAF/GCxkZnG34uxJop0a3ghcQ8gzQOgC3HnBm4WsCkN7BKm1jrpqAP/0eVDzYqNtfOc8vGdG2zZu0/xPPttdEX46Hm8QCGKXPHCWiSsbX8M0JUQkW6f1HbBmK9h1l6xpgNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jrX7k2/OeS8hesS1xyBHv2CTgOT9T2yVbYjg7lEgcId1D56EyhblDNDKUOf5coc80jNopU3PaUKavNjCL2gM8Djcr4EupKDGleotxsV/8/uOE2dkuyu7x0cgsiV3Tk57KhIF5MaygTiF+M+xg9AIgF5KEoVQfAlWbs0DCf1h5PK97NcMPSFzEyazjFGT7xoHShJdUYA2ZTIURInw6pJgzQHddAwTg8X6kKZw98hU0EG58c4pW56fEkbvTez3nMTE+uAAAAj+36jwjKiFceEnkGvNb0/BH2GcdiKKpJNkGKGknr9L/K+5axrt5Y0LMrcAqNL5WNsM5IeTm2lJdiAJHITMBYL5N75TGMCr/UjwkVGiu0FIF3apIUjetmsVkmr0+3tiLfgjrtd0Lkmj1Zdo8gJ5kuAjqMihgCsnRzQfRUWPyRpFM7xsZAfymr5tVuz0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 05:32:17.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9cca32-f2fd-4042-a82e-08de991e06d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980
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

From: BRahul <Rahul.Mahantappa@amd.com>

Use CP_MES_MTIME registers to read GPU clock counter for
GC IP version 11.5.0 and later, in addition to SR-IOV VF.

Signed-off-by: BRahul <Rahul.Mahantappa@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8c82e90f871b..316dcad0690a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5227,7 +5227,7 @@ static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	uint64_t clock;
 	uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
 
-	if (amdgpu_sriov_vf(adev)) {
+	if ((amdgpu_sriov_vf(adev)) || (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 5, 0))) {
 		amdgpu_gfx_off_ctrl(adev, false);
 		mutex_lock(&adev->gfx.gpu_clock_mutex);
 		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
-- 
2.43.0

