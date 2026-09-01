Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B513EC624D6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5A910EF0C;
	Tue,  1 Sep 2026 20:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PuJdzvN/";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE42410EEF8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOnb6sj+FTF6T4a4Pu81nn8u4nASamAk1bQymaMkJ3ERn3mKHnMeiMk84AN2t5OC3abVq1d7dR+PLC0j4js7EdXnTauSIp3+sjLyPYQyTwlZGPH5aLB1a1nUVzJYmJ630Lq4HgvM2Jtm61/Z7pI8UyqBqfuyxwk/27X2wv/Rp7Y27ERDV50PHGomLy4MBzfShGICtBbyABw1LL1fNU5dKjtkcr1VNnzdoBO4iUhg2oYKWyQQ5uDR3OJbBdgDb5CHJcJxLMUzGeYjrHzpYRzYMcyUuGFEqPwezwb6cxj1D42b4hB7WpfkxQKYW0zT1+AD6rest/fsr99aIFT4iN845g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlEQYGSOJwaseoNzZluebcLOmvde8B+nv6PinTOAk8Q=;
 b=ZcvwLJ+F+ClnWdnqEGqB/yzi8FPt4KNMBtMCAmNeZY7vh6WH4P7sYpQgaaOv6/LopXuzDl2Su6SRGMnG3ny5I85jD/YVWSxy1sbDTkVywUt5yv8AzTQ4yZm0c2CPgh0S5z6pr4UbW6YGImBBVp9ebKmLBtr3WeCjXVRAeGKfWOgmEqoQymy0R3OjcYX13g1aEa3T0Tr8XN0eO4IySu/MQO5iTUKVNa9xeGyWuPiIEWoRxYKsvg/iX4NpUbH4B5DCqB1xpLFAYR8WDfc10S71k5L/XrN+CKBot0lQSln9oOK//3P1K4BUGknIgcG1ADZwBCMNoSUIABPpkIRw2puY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlEQYGSOJwaseoNzZluebcLOmvde8B+nv6PinTOAk8Q=;
 b=PuJdzvN/A3JODsxhJJ1Hohh4ZJ8X9EIie3WoV9ZPfUFNMvFiYi8NR4L9Dhzr2UlVFMqzKvZthWiqt/y9HClyzLFBbcBOA+zoRL8xum8C51JVPAuOu8MnAa/BBIBmSZmLTpDsnAigaayqADH79/D8DfRqRQQ/PQVrsE/gPOigpFY=
Received: from PH7PR02CA0022.namprd02.prod.outlook.com (2603:10b6:510:33d::20)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:04 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::71) by PH7PR02CA0022.outlook.office365.com
 (2603:10b6:510:33d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:11:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:11:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/31] drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
Date: Tue, 1 Sep 2026 16:10:28 -0400
Message-ID: <20260901201034.2960437-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7477ccf2-bea4-42b2-77f9-08df0865257f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: XD1xXScbORKVwuNloBdfIaJsaPG5mIhkkXqJp3EyxMrg9ZEbv7jw5/rx0d7soywrrzGKLhs4vNcIi555MfSXecwgP0nj/rTzvXwE8odN9+zpu2kfItRTT+UCoRJ4UmxdT+VC/651UvXxAqRm5WAIr/oJeiDwDrVMMQAugR8Li3n+uclSOYzcN56Y4m513q5WnAk1at/L/iAp7Zj8QST6Q563hzdEwc0BZn3VCTu1bYSiZEwdFMH8yCxCyTSHt3crXqiHmVjMi8ymBfHVZNtwAWo1n7K6jH3pBxue5/6W7iBj9V6wE5NPRZy/v+iNRBB+voiroEkJ3xYxQ+TcpTALoYdSvH2jfhwswiWEscakqsjGBXC+fRMkMWqibqSAIRx8Ng7eGVOLipyaSP2lJJK50S19QZQGxbSGE1urIqbP6u5eGfosReYdlj5lupE6ZwpN92y/CTQQo9EBfD/Qb+r1BJQ1c89mUckr6BtFdPdq8ijWH1B8Gv9ok2Qv4FLv7Z4b2j3YoxAG4ETWvSqqvVF6PC1j/M2uHcz7hPK1ZDz8WB1ntSFXqrlV2DZ7+AGDgMOg7xYOECY21OxEjHc5Z/aUwkeUql3wH8HCmdvQwa9dRF1AxkZ4wWN/jLRWy3MDRAkS+wn5YdjwLmKNVNvAvlTI635HmEhnpr107bKvMFcyx6Kj4RrubuRFXnpRauScLx5HBJKdBzO7aOTgWdKKFa7h1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uhxdcztKoO0N6tdblAhk/mVCa5ZxBGd9js8WgxvUNnli6AZNps8eR5JNUyJ8uNiNTKG92nNE22Az4Q6gFxwW494g6CMFMUEHtvp5y+nzuV+TNPcxjt0iJ0wLroQi7gLZbXzTAHHAEdjmopO0g19L6nQ85qZZcBUt+ieWhElwYTf40/daHalNO6A0G4CeIFC4bvGpQwrA0AkwozQLjFFZxSzTfaTzTiF3hH5mNa1wc5aHHIgEdPMOuc7hC/G6CRPNhdRJ7gR5YMOuZjbmPbG6fOI7uw7RY0XlWNndBVbCNVa51HS//DmLkaIDeRytpU77WXM+WP2y0Dv/6n95GkX9uNmMiErhDsbTZwfPsrtTBjlveDVMVmFBEMEmLghmA56r/hlyGVPzC6nhFwo4JB+9742Ye8d9Ak48SlO4NzccsBNKBBw++88GzcnVvUu4EdCq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:02.2855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7477ccf2-bea4-42b2-77f9-08df0865257f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index a35c84cc7385f..46e98fe66dd3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -952,6 +952,7 @@ static int gmc_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
 	if (adev->gmc.flush_pasid_uses_kiq)
 		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v11_0_init_golden_registers(adev);
-- 
2.55.0

