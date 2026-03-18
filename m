Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9E4103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567E410E83C;
	Wed, 18 Mar 2026 14:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sZ4q7WWu";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8EF10E0E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrbCdV8kn/UB6YxBgXX47iPVS4HZELEBKVaVjUXSdO75tbmQoSx+daZv2Cnu7+vQ5Cd7phyRuPksZMi8/Da9asW5UfRDKVCacJemXL2hyh7OufhoVwEnD7tHtCaHqGacpqmU3pKxVuDHN4GM4N3Kk8PYXe96V7grxiXAfuFu+YSOjC06tlvZYjdrFmZ49oiOOCUu+msLC75QWV+Hk4NCipKWhhHmBTnFvgioWfEJE2po9PRTikE+0JSF32uFhY6QGZuZ+lctV6+JM0v3D4fRmvmERoceOXbrA/GoSVq8o/W/dV1v+rs3MlAV+KHzPA7WLIT6E315UVYVWycTbBFqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYzDK8p6C8+gWyBMt7bcf8te+xdUWe8FaPWFYzbf9AU=;
 b=UL3QEWlqebZxYnXp1WRs/BKbjsfz8uqZZXrWq9enCgUrDY0N2580wl2gLIs2+22E2NZtHmlRjphtnfR40lY08vL8aLLY9LFtcvE8k66/I1EmGrsBP8+AP9YFdzpilpIe8mNn/rd66BJP0EgkEKBfHZjuVQIcNGUr67GhLDPUt/lKxKaYzZsTIENRYPSHQlCGSN27MCMkcCtgjGm1RulTwyXr1p+VDeB31VIVoofUfzucHNrTkiT39JRA0gphAn95PaCBu0QBtIh9aOBu+eNIZU204kyXvxD1LXxQkzuTK0SXlWxiUaKSjj1oELOyOFVgPXHDiffN1N9oR3VCC+ItyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYzDK8p6C8+gWyBMt7bcf8te+xdUWe8FaPWFYzbf9AU=;
 b=sZ4q7WWu2oK/iRzWGJmC0UnVE/9RKebyxamDQLPm720QdRj+CYOHTd6GAEKYkLM9foMAb9IQrGmVPRZ1GcjmMFkuX7m0qgBvZjbMQauI+ln6MZ2rswBNXiqT878QQbuJDgGPRH+pIk/DqSzMAS/tfJERe62RrrLnSwTRLSNs3RU=
Received: from MN0P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::19)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:11:43 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::6f) by MN0P222CA0018.outlook.office365.com
 (2603:10b6:208:531::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:11:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 09:11:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:11:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/sdma_3.0: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Wed, 18 Mar 2026 10:11:24 -0400
Message-ID: <20260318141129.583333-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141129.583333-1-alexander.deucher@amd.com>
References: <20260318141129.583333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b72b946-8356-4004-d89d-08de84f84842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fM7JLblq6/f/biUCKVSX08IrnsQOxix5A3qWB0bReqlrQ5ABtk/Cj129lSi3mGfODbOlafgEmICcV0tw07ZU78TjaAS4ACzRFQD0kK3zMbbgH/USVjKXn/JMCtmHsqZW+HxHzGFPC7+QGLllyvEVrG+Va1LA8Wm1y3RXksPRbINiUf102kRTLBCYr4EzSBpzU+SNeToZpezTl5S/Ov3nNQO22QQ52vv83x7rFPqoVW69Yn251ZLovZrYoxEaVqCIyx4LEYAmwt9ahLS3Bi8dg8Q/kQ5IT7IH1sYZLW1+u6OY2kr8CutLMJUXgEj/YcEqhhuAPWPn4UthE5ADKsHTx3CI4atb34JOU11QD5/j2XqoSvZwG3tLsFxCVFC8776r3w+mab4aiipFHEJUFnbSyCHMpTdr9K1ujxCyycUPdiA11JcdcOZL0bFv2W70kApAKwHLLdtFPSN3ozE7w2xc5hkEBfOV+WVXXga4WMYQvv8VIlPHi0PFJOLNL0uFA2wOBi6AwI7F2kqOVAJ7W4NrKNUngTGwBkyFsKEkbTNbQuUgs4DByUMy5epHNl1a8HRjurvzpaqeuTuHKTd0RHlZbcMJz7SkOtWhZHbSVtfHgoF33k1GrFOKvqe3x8gG3HhC4pjQAHdtwk4UF9Q1pemf7BcEHfhAar2dg99Qj7XF1zQ5c9f0u7+Sc1gaWlI73ZPelBxvQZwKZ2kIK/kl91375IYNtHn2Js4IjjtSKh5AqQ9NIr9waHf6IBmLnszPJLsv6txGZhHFZu5jCObMgLdv/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: syu9pWUFaYxPKrxhcfiuCjYG8LHsafda5bovuI2U2U3Wf0wcUTP0Hgv9i7hOWR59i9kODk0GlRbABWjdZFWxuOeTpyjw4daMcb5onsmm3BujHxJRUwrmaM0gitNNe48jnZFj/MtwNSBk6HdbdR3RYYEFOjXtEPnDdetp85AGYk8w/AIdVsFDtsnsbvEl6WSu0gWCsXVTTk+mUQp6IzS++nR7V3DkL6/MsXWixoUJA30C6T+Cv868Pv45lqp96kD8EWO8R1AGPklgf6MUCza/fj/lTsgXvTSSmmWJoHsu47EzF/INsFZD21SZp87Qcc1whd51jOeUoGbgUscxLqD/8WxQkgSxcX9iAqScONrs5baiBdg6Wefko09Yo7ern3msimN3KJFm3ElUSBnkAmul86hpnHoY1HgQGpzuTwciT83vf4VEuAAHupwmFrZmIcYV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:11:43.1856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b72b946-8356-4004-d89d-08de84f84842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 2526d393162ac..6770f5d69215f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -660,7 +660,7 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 		WREG32(mmSDMA0_TILING_CONFIG + sdma_offsets[i],
 		       adev->gfx.config.gb_addr_config & 0x70);
 
-		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 10);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

