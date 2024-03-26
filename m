Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EA0C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 15:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183BA10EC93;
	Tue, 26 Mar 2024 15:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OmImvOux";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69F610EC93
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 15:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXUK0jBJrvwF3922vg6/mgy5C99LNQHxEmj99QMIFMZLorvaDIV+Zy2K1puibHjAkA40su2i1XAQ/r61l9tDifVKBCKbPl/czI9bMPj7d/6Vxe1WN4I0aA62Qqn0iuzvmjXvAaT7l9LJuyfhy6RzNXjM4LxxiN6ttJ/cHqX2xkBMyzT+z6fVhHqFQOHofrBUVwIEgsYTfDDEUXH3iZQ1pqF/bpFBACZEyo98TaDOHgpxTI7oLe2SLBK8H4ScsPdbBj9IMskXYu4usWRp9/d4URZHTQLLeykSypkzzoX+bOEeted/ou0NOmt7NprUVSbinJJy/dFGh3QlS2ZKQeNEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlHCfUYlSJ/Z5O26XG3lOAeTMIJwMIVpgCiBWE6WA7w=;
 b=gPF/9r9RfCKN1/nRXd5mWnbLEbHOt3Onw5GODc/6f/T/35WgHSa4R/b+r2kzTWfokuSnncYFjJRdBF+FYrCkGg5XF6KG1KeICh/8VV9HEnsZUUKmenGr/Thrqqa/6jkxPmkZL0/3laEnMHMATak06vmXz0EGS7bH0lYTas4nzHCF3bHxzBs9QCxxiBYfdqHH4ZafIi2KRI8k2nCr3HnpnbAf9LhQKeLGOYT0oJUvlRcChUWh958oWxjQt8EYD9QbtR+//xJ7c+A45SpFhp3OGUJmhA/LVajBYtW8BNIuEQkgYPGYA4PomzKkDUYPkBLDZZmUo0x+0dVrQz7+il7qGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlHCfUYlSJ/Z5O26XG3lOAeTMIJwMIVpgCiBWE6WA7w=;
 b=OmImvOuxZzwc2tdastC/NybnUgvBzEhpTXVHetWDxeyFQw8a3SdQo3yI02qlecauNC3Urun7tVNGgF4RSVvb07/ORZDuw/jYnkGf5cY5+eGaK9PdQmDoGog1d3aJpofPLAHVby8E4hvHSPMNHC56G3PpBI/aVA/j2em3AASZ1iU=
Received: from DM6PR02CA0167.namprd02.prod.outlook.com (2603:10b6:5:332::34)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 15:52:18 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::63) by DM6PR02CA0167.outlook.office365.com
 (2603:10b6:5:332::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 15:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 15:52:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 10:52:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: always allocate cleared VRAM for KFD
 allocations
Date: Tue, 26 Mar 2024 11:52:02 -0400
Message-ID: <20240326155203.5246-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 0663192b-7685-485d-d313-08dc4dacb6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p90J4G3S/OGGruQJrYpA1u1C+Uav5p4gWbSiipC8g9yOd0h60hMit/CZiR5MR/Qoa0miJYp1a8bUbZWZ3FRGK/NidYXdl89nbur6NFoq1qkt+4eZ6ScTQGR1Ok9R0p1EIoF9RHpIPbMKhcEhndhjbaAUXi/jdgBlJ5EyJpDMldsEWLY00PGzs5rzCXg7QGCOeg5CYCAo37RPwq00M5VfwUGUhiMlzc+kZVJmh6IS6RbqHUuAdhFxU1NfUx8itOBnoH1Q84mkmo28h89HoD4vuCdvzdx37H+D1XKYC+MeqjpIFEsLfAC0UtJH/Jp4WbHiPpve8MFe9E4ELDKqp/ibHHBTM5vf1hABrxvZS+21P2aV9WTz9rC+5fT9N3j9Nl9qgi72fzaMVZAd3UEgAMFsCuWV7rNE2Z7HH7VDOaj81UTkKVSQAOWzfvSIrqqWbjU+A0q4B843g/Yfw7yoFoWAFTKGBjRdSmVAxawhxK1UBruL5DLI4tQWaQ3Juhl0457ozgX5eIZvPT4hF3zLyviTZ2saHahE5iBc+3rfRyKZaXNIJHRrdC570w9y5wesC6Z2RCuDVUe16glliOf4o2gAoPgS26N3r4c897152Mup55y1aL1mOGssFR7pY/DqZhlnxgwUwRlSAlpEPk6GVEWMEZ2MXpLts9dIVXlvmhX6FL4waBMO4M2ai0/q3jkvwHxW/v8/qWpwk8OJ9gBh0c+9cbT8JKj/b6s6xb1Iko2pCeWKQxYMbkhQ4ARyu51MxHb3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 15:52:17.6474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0663192b-7685-485d-d313-08dc4dacb6e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
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

This adds allocation latency, but aligns better with user
expectations.  The latency should improve with the drm buddy
clearing patches that Arun has been working on.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ae9fd844623..f9a4ea082821 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1709,7 +1709,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
 		} else {
-			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
+			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
+				AMDGPU_GEM_CREATE_VRAM_CLEARED;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
 		}
-- 
2.44.0

