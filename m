Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0179C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 17:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE89010E4D9;
	Thu, 27 Jan 2022 17:24:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852F310E4E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 17:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNwPB0e0nAgd1ALxlk9eTRAGtN4qz04uYwSEZSznFI6ZEIuxnOXOp5GG3ZyDZmo4cfLKNMhj1+2YVWnatZjpHaBro9AXqD4D9iiqtBJplvCFri9S0waRZhKlfuriJHhyqRe4Bzhc7pcN7Viks3s+kLvIYWQ+cTm2SbDXAT1/xUDj+yDqzyx/BMrgGs9dQdKj4u88ax6Bses8zAuSUYft/G6YOj6mUb3p2tkcDEDhurN+2MktFqhRgpvcG8w+Ebm+MHLl3+N9u1pPrM22usmjy794RC310qaxAlNY1uLKL2Yv8829dlNhKujHodj0SmQCCOAH+w69pE/k+yy4NxM40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXGtiWHiQUG+YgqNl/iF+rmW1loi5vUkSodxd+bZlGo=;
 b=Ug1kA8D6LmfNulsQhETpkLdPFaPSKCNX152MqUHhY1G/QQoxqQj9okapAgmgNwBZrUYJmUud8Vq9i2b0tzkxTYN+XpWdMx29/XnUZzyWw3n7b/6AUKZSRtGvzXBWM5u9QwcUKhqPcy3KVFxX6M9CCHAzXN3mO1OrPgyOsCpVWpEiKgKvHjwmW0wKGGknou/9wm54LdjakjxIMK7E+OhVRh5GJLhMhI9k4BDpa0TAWIdL46TjSLX8hvmJ2BQ77tU5aBJDI6c4YiMq2zBIm8biqx/nDRO1R5dixV+mGyTfNpXdXFY1TorjBw8YaDWkp61BzKMl1neOUtkPxFLYBIfTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXGtiWHiQUG+YgqNl/iF+rmW1loi5vUkSodxd+bZlGo=;
 b=VU1kqZ8hMCAtV3wIyiPPUvRGn0I5vcP+HlImKF5zDxx62DCvmalN5PkQzJjBoMz4VmF9BmRc/lFo9lo1axYa62aVDwN3lc3oD1YxTMQIqB3jZ1FqsLEUX7fiYa2bx2bHgEDYCpNTgbKIOXOiG1DYmRGsgm3IcgaKwvzrX5lKX1o=
Received: from MWHPR13CA0039.namprd13.prod.outlook.com (2603:10b6:300:95::25)
 by BN6PR1201MB2529.namprd12.prod.outlook.com (2603:10b6:404:b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:24:06 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::bc) by MWHPR13CA0039.outlook.office365.com
 (2603:10b6:300:95::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Thu, 27 Jan 2022 17:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:24:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 11:24:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix undefined preprocessor identifier
 'CONFIG_ARM64'
Date: Thu, 27 Jan 2022 12:23:52 -0500
Message-ID: <20220127172353.280369-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ddc4da7-4c04-442c-6ee5-08d9e1b9d222
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2529:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2529BF08F4475EB3E2A85860F7219@BN6PR1201MB2529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58WBg3O5ljuhTwgq9AdU/FNSavAb6jXFXvjGv9yuI/FvPwReYUg9MmshJVDWAuc5TL+xoILLNgD5tYypa0ESOS8GONClp6trOWlzERckHS5XzW6wpiWxGGHGRdPBsmhJJOifi59K+nmkl71TpIsZWEJGzWMZY8dsfyrw2cqCNXR73lprQXOPhFt+1UziH/xP71C1weBzjpzQpgIQbGNVXcLoKBVkxSMeOjN+rAbtwHeYVDzyWDbRk1KGMwMS4pdNyhbxBQbiLX1nEDYM+lHe9AYZrR+a6n+I3jYe6YPXCPXHxEqkL6pKcsVEZ9+8JsefmoHR/2bI2P3L2Y/7QMGKlVwEzfmvh/bAPRjHWonYKEHp5ItIz7In6PgC7npvRpA09vKPpv5QwLZ3mFtnjuwWFaMJFOYhn/pTwsGomcG/T11KAwmh69ew1Pi+CcV40mw7eZME51orZrjrOcchkwh4o1SJd32tRGQhCqNYw97KCEu2P5poodokeadQ5PPWXHtet2v+pecSMQx3soysf7l384PgRT0+WFc/RhDlYzV3wyIxFZZNyG1T2S6PEsJAuHIVlG3toNVHU9Yf6cLGK+0sry2YcCeFHZ1CZ6Rm3vZEmNtCJ9jIQHMxtV2dWxCYnBJdrNLsXgwXAqIrmQD+Q+lKdx5Gt24R3w8iJvlNr/Q8U9ASyDWWyPaxWtjFj+nJyvr/m5RAIq/nP0Xu1SfEOgmzVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(2906002)(186003)(26005)(47076005)(4744005)(5660300002)(426003)(86362001)(316002)(16526019)(1076003)(2616005)(336012)(6916009)(54906003)(83380400001)(4326008)(36756003)(70206006)(70586007)(356005)(8676002)(8936002)(7696005)(6666004)(508600001)(81166007)(36860700001)(40460700003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:24:05.8276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddc4da7-4c04-442c-6ee5-08d9e1b9d222
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2529
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
Cc: Alex Deucher <alexander.deucher@amd.com>, victor.zhao@amd.com, kernel
 test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check if the identifer is defined.

Cc: victor.zhao@amd.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 40803aab136f..645093610aa0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -294,9 +294,9 @@ struct amdgpu_video_codec_info;
 
 static inline bool is_virtual_machine(void)
 {
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86)
 	return boot_cpu_has(X86_FEATURE_HYPERVISOR);
-#elif CONFIG_ARM64
+#elif defined(CONFIG_ARM64)
 	return !is_kernel_in_hyp_mode();
 #else
 	return false;
-- 
2.34.1

