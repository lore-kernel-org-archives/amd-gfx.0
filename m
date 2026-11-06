Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19A606A32C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=baJZatAR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A02E10E1A9;
	Fri,  6 Nov 2026 22:44:10 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB24E10E1A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 22:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgOpUw7l4xFYwIS77pA0a7cUJkY9XPyBkB9Al7wftNL3v7WqSjLL/vRrmRH7yag+BqHi7W1+7H5np4GOqPhwZ6E9eobzvF+I3rKeWmY64ClN5Rabe7LDmjIBYLAL9RaxRFE/vhSYJ2QkgAcJZ6sQ0vn97VOtkIJK/1lLxE4eRkpuPYTb8BbrEz2eyD36FtZOfgGCtidbL/L7+pwt4i9KBx9Ikje3vkzRTaFUzX0gQBOjsF0HkDLhveHM7Oo1xBhThygUyU/rBtghpHSr0uP/JGfrxhmKkR9Y4BGTMLRq9J1k+heTy6ogW09E8muAnkxGOfFcdAwF/EVJXxFshKK9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMmJLiyFSA4sDK5kAzo3Ica2A1kNpwVeRBF8Z5zZ8GY=;
 b=keWcFzU6fwc4Yr9APdMlTyZaVpN277zfIDCch8H+2SHlgnib6nlPqPN6dWPyCVTsrgujz31hJSFJY5W2js6DAwPnfI2c/bFiWYuvw8lcOEFL/qMXMyqcvVh9nT4Rv8WH9Wk05xoFU4QmoA6IuclC1jtrEGWZ6iwIQrq1S3BMQENTtiJCqCLy0fcWKjVmeLxBV2BBUPGzuzsI2FjcxCGxsVwhvIVlDQPnv0lSlnIUHibrEoY3ApWsED3lj9x4OlXUca2pDX7i3xoNyunOPZ9UfEcSVrfyCUpYOwpsBZDG563fO+FwRByWVmKNo/ES76IY/h9hiYvj1Nt+wPPPyttiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMmJLiyFSA4sDK5kAzo3Ica2A1kNpwVeRBF8Z5zZ8GY=;
 b=baJZatARXmnf3NwGz3XbBaviNCdqw3yjwnR4327khA5DlJ9m/GtpMbWfeA7uZBXFEDjW7yisrj8o+FgI/vlfgI1oXtoQBJASspa7zJodr0p7Z/E2ss/cf0wFV3B3+qQ/kHz0aRXq8le4vCQlUvM1uDxsIJgZ/nclC061gnF8Lko=
Received: from BN9PR03CA0474.namprd03.prod.outlook.com (2603:10b6:408:139::29)
 by CH4PR12MB088503.namprd12.prod.outlook.com (2603:10b6:610:50a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:43:59 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::3f) by BN9PR03CA0474.outlook.office365.com
 (2603:10b6:408:139::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 22:43:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 22:43:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:43:58 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:43:58 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 16:43:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] GMC 13.x Support
Date: Fri, 6 Nov 2026 17:43:47 -0500
Message-ID: <20261106224350.3568574-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CH4PR12MB088503:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ec4c70-5d1d-40f6-0cfe-08df3c57723e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 1fga83ZzM/owv/jzi/gzQpcH6gBYtrAwYBXWrZKrqJW3sOdiMs8LsnMfodacH3AWwih7cxSksGH1fbZx8w8CJm96yvdMUKQIsYvkN4YkouRCswyb26dozdGVJJSB8fUj80nmxCKqlDIq9LjPP4ENOJ1c3Spt7uIsdMKgJKeB0LVPT3NmDbXP37REucEs/2dWalzFGeYvPexEJU0kmeOmaKjDhCT90K7qg94Tw/k5aluc1gmsx1I0h7CKYO4EfldFdjBwoTu4CGj2A3sQYXAKWgK2ki85rOtdixBPuXkDYKoJH5fhg0BOwH5TEdLm5vQ4VZTORgTUa6Gty9XCAQJwheFISkKFzH1xRljkByVR/kgbUlrKVdvh6K/6BnpbPecyVdnYIfi3kVuF98j3K4D9EGc7RrUkf1tFukN/HeTjgLi59kyHoyAyB5Y9kHHWe+hDx1giBRwSUf1xDcqCtB1X33ypb68SbLcJ39lCzvPUsNNJSlr4MHErmfcAr/OIUYM7AxO7om1AA72PId+0boSKQENAT5mFgLVcF6juhejIpuW+kDxqeCROtrPCfY1phOhHhLS5xCdnmxlHxQgqAi/+ftNMwki4lwGfuSsdY/gBc1IW1CHzig///4zyb3XlVulTLH0NEXc95wBkbUExKO1FjOnBhDWBuFXyEOlBWxY0kzqop/pGo1507K04aPEfsLtI5IWH1z4bM7Mw+33sAkHWxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vRme4Yvv/amN88KNkovN7VhvQ3d+esi8NZ+Yz1kvQzIROFG1zyfePRIl0oxi3PfTPBZxThXiumSXfxUYdnb/ppBtHBpctsD+e6ZxpTy3TrRaGuT9CAhz/l7Lrz3GqaRJL+06Ri8ckHcgkJJ4oPclN4tqs2snFYlWVbRFGGoVnaXEtxUY4aZnAJyGYq07LNkMQ9dXhNSLUn9sBPppeCj8UJrSWoMSWygYdBci8Tzw4BeFqiQWdj7q81PcFycfsqxnIoNiiDdgsb+2c+5NYzjFRQFgaRdqSlUlBHQcMSwf3sXFsq2RjvIFTxQknm5xDUM5dFvrtKXCojfuDYcMVPlSALU6q8B7H5yFz7JpUkRC7posTrsZgLgeDvXcYwkhkF0KqJfHpnUU8W41Sdzh5CGEMFHL9JbUpY3QknCqCuBtbXl86W5V66kpzEGje4Meh07V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:43:58.5930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ec4c70-5d1d-40f6-0cfe-08df3c57723e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB088503
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch set add support the GMC (Graphics Memory Controller) v13.x.
This enables support for GPUVM and memory controller setup on chips
with GMC v13.  The first patch adds a large new register header which
was too large for the list so it was omitted.

Hawking Zhang (4):
  drm/amdgpu: Add gc v13_0_1 ip headers v6
  drm/amdgpu: Add gfxhub v13_0 support
  drm/amdgpu: Add gmc v13_0 support
  drm/amdgpu/discovery: Add gmc v13_0 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     4 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.c     |   529 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.h     |    29 +
 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c        |   999 +
 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.h        |    30 +
 .../include/asic_reg/gc/gc_13_0_1_offset.h    | 16009 +++++
 .../include/asic_reg/gc/gc_13_0_1_sh_mask.h   | 54975 ++++++++++++++++
 8 files changed, 72577 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_sh_mask.h

-- 
2.56.0

