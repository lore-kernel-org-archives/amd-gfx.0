Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D18606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lgU2d/8n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD68F10F1B7;
	Mon, 26 Oct 2026 23:03:12 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DEC10F1D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwHXMjMMDijTl4/5uk75rI9iZ0Xe3KKB7fHoYgTCHy0RY3i/9IILus6wTR0H0TZ9xcceruf4C/STaAYSfZZ6oNNhsHMimiPqKdt0h5816p7lik7Cj1dFJcBVpxc+ZlDZ667Lz1j5/r9mbL70cjL44GG63vWNurdamEZ1LQfaKe9xUnlKeU6HxNMb515eQA6W3iXJdlTsTCTwXg/PTRN1/p0rdpQWDnnFYjDT17zo4uGqagvTn7IxQPkSAfB33SX3fny5YdtSzk8n7+pbeQmNdo8IDRA05AP0vCyYXSHq1/fj4YMJ81Z2i4KfK4miTpeW+c6V58YDb/7XOCWRhqnsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyoNL58nB14n9lA967d49P4CPZTKUDKmSke7FfQ7vWA=;
 b=UI2Eg8K2K68WF9EsKC4e/XsHGDuWo3250Zd6WCwhQu3b3u1de37EHZNW0RckR+1XLylA1YJB/8zvTOyH/benGQbhijYVtwxBfTWe13exJfUxyNfPlzl9BNeSqck4buxXQb8V0p2T9izQXZMUcp0DRaDHGrafqqnzXmvEgr/2HTSQtHKsKIkvaWGLxaPPkOL28HWW7n0Vl1MD7vcOQR1o4JmA2rLRZ9lBJcLZx/pUFuDz0sS3OGbHulWZYEa8L73OsGnZKulp7sIKz5hEOjZ1zkx9zzt+lMJfnL6McziFrhgRrRlaJCdDmbaSwV/xih4gr0YoqOPGa9vduBBAGtjS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyoNL58nB14n9lA967d49P4CPZTKUDKmSke7FfQ7vWA=;
 b=lgU2d/8nNjNqYqMJDba814yomYaKZQQb1LgL9hcMEoUChJUXEBXh5IM/ElSkLnvOAGdSOISomAtVj3Yi0pXATE5l59kvqZZRXRjmVdmoVP1GUie7a6ODvPusFQ9xD8XVegJ/Xgirea//t1tnX3NSQODsp3FWgfYb5anfi0g7zVI=
Received: from BN0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:141::6)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:03:03 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::19) by BN0PR07CA0023.outlook.office365.com
 (2603:10b6:408:141::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 23:03:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 23:03:02 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 18:03:01 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 0/8] Add UALink Loopback support
Date: Mon, 26 Oct 2026 18:59:22 -0400
Message-ID: <20261026230248.1597606-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c05dc6-34a5-4c5e-1a99-08df33b54990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|261021123027099003|261009223027099003|11063799006|261022075727099003|261021121427099003|10067099003|18002099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Q8vSYxB56avAzZOxyGzNAh7IuoNQl6sw2q5w7VT3fAWyh9cld5+ZTmYe8mHQ0BS5Xdf6OqcMLd8G3LYAQwi8/R+9MlAg8zoo83QpMA4aE7X57xjJ2iD29c4tRi86IdfHVZEOUlUOr1ErsrTWCMWDbPTd6Wt8YMt0QMZ5OQsjHYn5fMbKkt1V5OURlUvpWC3QZyLwjUElhqbBgNvZeFTTTkEooE0KvvS5cgDsfpb2/iy51vkSCCG9mxlVOUlwxoITvV/4fdXrtY3BqrK9Uf8hpxM9YQ0cRK78QPlCoH9ZvAaLIPx431u+P8alMFaSkr7+eDzfpLo1OVtxnrnBCRykuPgjXH0izh36lKKh2Q/SFnmldLKO5SI76jKWy4YSuGdQc68iAgYdk29MXtxCWJOgB8UL6//xTxU/JotodHkRXsRWFLNseR+cYyW7t0kks0BEE01Kc12TwyCUpQEiRTsjXJnSTF1bltrvLMNN5TbQ+Px99j8uaj7PkRiZgQMr4yBPM/MnO6gaQTV++8BrmCGNndd+PnLcMxx5Li6Kxk4Rk8+YnU+IYM1U8+NW0m0PlPe1+BgOLyXthVtbrUQwsbAPWOKWdilh+ar3Np8kVrBpbWTfX/ZEOawug3Y87q5/wyCOBh5YYYopxMcIyEoHQj3DZ31BGkjEuwTDN4Ajy/5/yNnswAUeUwcI40wfmrsIxPFkjBeHtF6n4sprzwjXcEmsRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(261021123027099003)(261009223027099003)(11063799006)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9lEdq5nG8C4t+Y6pi40ChviE9z+oVXg8sSY0ubCQPD0vMpP26XFR3XxBMCuY5PiwL7h03171vw2eegIO1F49gWxl262ETN62GnvqccgcVMZeqB3aYDvgWgei9NWbpdRd+/XfDKTp1PdmVaMWlcug3Z/gMztWCfvmdF00u+5z3tKQaDlFXyLb0yawLTKyo/neKAh50/6dOQOHzRFJlOwdNFXmt0rQxNutF+b8BcamyOXMOAKn2M5UX93K9voSd6XzWwQhqMqsIPOx3IEXOknK2uj3Acj06wMYm2R9+cMKvVNItdB2WOoNil92UmqKX1BxeXV2pdQoiIFzRyl8bHG63YcL9OcCtfnS6abgXJvjrrEvcF/FtbmUDe2XgB0Z9lwTHlpF77YJqNb7WzuEEy+enfMMMFmV6t/0mR3Oxm0gjP129px7Ej51OpuCHAQMsE50
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:03:02.5344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c05dc6-34a5-4c5e-1a99-08df33b54990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series of patches adds UALink loopback support. This will be
used for validating UALink HW path in manufacturing.

Mukul Joshi (8):
  drm/amdgpu: Add UALink loopback infrastructure
  drm/amdgpu: Support VMID 0 GPUVA completion WB address for UALink
  drm/amdgpu: Emulate exporter->importer UALink messages in loopback
  drm/amdgpu: Attribute UALink loopback messages to the correct sender
  drm/amdgpu: Set up UALink rings and metadata for loopback
  drm/amdgpu: Enable UALink loopback mode
  drm/amdgpu: Reject config updates in UALink loopback mode
  drm/amdgpu: Temporarily enable UALink loopback via module parameter

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 486 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 ++
 4 files changed, 479 insertions(+), 50 deletions(-)

-- 
2.55.0

