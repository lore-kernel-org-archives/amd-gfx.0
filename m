Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64208103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8DB10E83D;
	Wed, 18 Mar 2026 14:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u8MQl3bp";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC1010E837
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mboDNkoLOsKYfEwVA93WupkKrIH3kYpveX7R/ftpnXnIouTecusKbHgkI4aiOowQHix12dt6qSS25N9PZzXC0UAuHSdeKxyqCXfWDja2L92Kyf/UiboSkrs9EJ/8OFk2Y8gyV/VUrjK7jlsjwh7E28Wjh6Zbs8eBw4RBBV7/ofAWiQ0Qhe+dRyXnC2NQiq7Jn1J0nSFea2bcmZ70MoQ2BPI4doevJtktgf4lcEkdC6vn1ZiqvmQBvHAtxBzV7lcA6HfHOTd15bYdKPefeMSUTXdW9UfhJhVgf0o2OJiMPM+lNN/bHpsydyukA63vjSfXATNrdsyIIADlzzGzE3Rzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsoPCyCTs2EeZBOURDz98bnd5Xe1BYKNo/ZiRi8K+lc=;
 b=F2kf25JzgXy1/CcRPxspCm4bEsCvLrX7E3rpWJ8hw/GVnmzvVAonrOpV2SftvQ3+FQbPUhURe7Mr9G/itpBof7rIfUdIfCtyzKP4KeT2KSwJrOWlfrsXE3Ci/DLFvZjP6cB7NAjHIEIK8s+IcZ2Nzz782V9/wDd/mzTseRHIPexxKXRQUTVOWxAZIEAjsyQ6G27bn4t9Nch4IysffzdSk+cyhDKsnlO80V759RTX1jJlGzPNHpTp6fpKpTHnrA/feJyHydmt0r0mK3Q8L23emUPlQGoUGdpIBgieOlaMeOiy8ShPtRuINv43sv0+Qns22hbwbdt+24Wo5+Shnk5PwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsoPCyCTs2EeZBOURDz98bnd5Xe1BYKNo/ZiRi8K+lc=;
 b=u8MQl3bps99tTR+WzqSnA8bln32Exk2DnnXBJx5PC0oM1pabVXJb1sTIqbSDRYRMHdvNmz2n95KVQp1TZm83KF734ao4lmaQa5n4FnG+viL9EMIoA4wc3uH19rFMftu2eF/iD+ai2mbMyHYylIR3kpSWo/6SR4duOgNLjW5fd28=
Received: from BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Wed, 18 Mar
 2026 14:11:45 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::54) by BYAPR07CA0049.outlook.office365.com
 (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:11:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:11:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/sdma_4.0: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Wed, 18 Mar 2026 10:11:25 -0400
Message-ID: <20260318141129.583333-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141129.583333-1-alexander.deucher@amd.com>
References: <20260318141129.583333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1512459d-ed6e-411e-61f6-08de84f84973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 18FLOAySbOneKRwqkvpAZyqubXW3UeDPEmvCGTky/Lger2VtG4U9EEsUATzwMbxWX46P4HPS6mp5GuiQKqb+dcnNIu154kEAXQ2juJR3BgM4YMWcYCXS7N4RVO5EIXgqxLq8FLosRUFZ4VarK0+s8BxNaJFWxGagUm7gftrjIri/5JF6f0QjR2gY29kJ1OTg+DGwTJazP6FRNdN4UMfZc9LowvVSkQ3Kzk5E4uhwUhE8OSTnhkrchkow/oak1OxfPYm+ZNDnhs8gf9JDuqr7FHOtR0hgWMcsGr27ZdukdL1ZT0PASHKZE+NfOyiZijaRH/buHaMmIXobdYC+JGS9JRy1kgpxLodP8OQ6Vdqu4RGSf2BaI4k5A7U0Xop4npkVdmLhhAQiRnJM2hT2TYvJARTvdE7lHwPrzRa42+M657uHjfb6/MpwAdgZkPLacgOXkEde+kiPAgcgQRt7uMdc3cC+zR4aTlPvrgkiAVQPlDjJDAYYNrc9gqTveUv42bGIb/gM3IuCzijQsqp6K+Enk+N+iTySxixJXg2TTwd63B0I9q2JHjx5PM6QCnirMwd6XtZ/DPLYx1cIIE56YaAw/AnjNz47Ej3zARTUoTQ+On2YQKi5vNBJUBJWWmKP1IFdaTF4FZUIAIChdc66PvW/h5nkjrOBKmXRgZQqOpHhc+L4UhfiPUogLfgTQdIQjJNUb0fhP835gzz9Pp+v8GzTNOhr+CqDe92nu49zY8ftISQXB/GARM8sQk+UDdMiOoU5w1T+BABNh5EzIyDyw8NNTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l8wRxQmHiJ+s8TpzAskh2rl4cW11NZHl8VyPSUkI86Uq9lUotCbrx5wuTKBzQ6DsLY/RArXbivW2S7gSxLwoziBXwgnXoLmYiQeP2ogz674X3KJ1mitUtEewzGBJKUZqf6EAXHruWCSiiBxgcwrG/aAaNE36vKSXCO0txoe6kavmBqVzD+UdGDGpNo6Nw/Ld7OXLY4Gee8+fPydP2Z9xfKWll7icc/12Owt3sRuYwofYr+mszuVI2FlwrR6mHwo7jGVQTKypHI0qwzv9znXoPneMPm/0V5JzlcIxWolcb+KV9WInd/kcJ13iylo/I4sNGzMxCJ3C2Grf39+ZVyk1M4I6dKdJTV96zTewdW0so9agZ+4d1cojeMDPAdzdHPk4pNuAcblrUyRB+bqDjoWCuRAIWhQlo3ouT1hR9h2cFiy4xnrdugfsuAyg3s+3YZRJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:11:45.0830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1512459d-ed6e-411e-61f6-08de84f84973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 44f0f23e11484..f3aad579085ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1404,7 +1404,7 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		uint32_t temp;
 
-		WREG32_SDMA(i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL, 0);
+		WREG32_SDMA(i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL, 10);
 		sdma_v4_0_gfx_resume(adev, i);
 		if (adev->sdma.has_page_queue)
 			sdma_v4_0_page_resume(adev, i);
-- 
2.53.0

