Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D36C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CF410E628;
	Tue, 21 Jan 2025 19:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HUa3OPs/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F7D10E628
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8ppbGqNUEI93Rix+RXCw+yxdKEn2vzq9o2uE0Wj/XjBftaqJ3hQzN4EX+Ot1wGgyTBCkxeGrK1Cy7IQ7Nen0iDdVJB18dfl9GYgWNEW9nbYp6MWebS9kl2kF/j+PvLumkTq9QCL5HpvByiiGR0u1YCKFNCGYFT/6B+x2okA52RdMO8iW11ABif7bGK0Ao20jn8stTLsfnLOjM7sjPEFK9WSL0EEaaNFfsamYwe6BJBIBgpx8aoGBrGTmz1DIGVlLqWpcF3No1Mpa9muXigbeI6xbagmdNzk/sEVf3Ny7XGN+oTaz/yP1q9FxYG4KV+/nfEI/KzmsNSrtERNVyo7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeSGhy7Q0EC1bjqfDuSwQDq2oGkL+32Tv6v+H/jE3WA=;
 b=uzUIKtASEYMNeWUmpSlm+TfzxJ2A60F6z7Mth5x6c7joHX6kBqDPDoc03FKZ+A7TwB3IanlANJqqWDJEbXjnf3HLWLUT+DaV/KWbI2JIw0P+nkSsNrO3QzRWR8aDmG3nEar8ng2QKe2qTx5oGqtnbKS1n/pAe0rMkTQWr8F+jQS7JqQ5DiaAcCL3DUsAE4eu+Gc1XheLqHgy44ryGm1x4x1f3XeyjRu3uBcZ4fhDNuGaJjkxlQdZ1YkPIQekTYTJzPciIZanYsu22qlZ2Tevrl8eDsKZU+rm7Repb8TyhC++pbrqfAT4y1iPAelhT5Wa6aosYdJBBdUrGR9GMyPjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeSGhy7Q0EC1bjqfDuSwQDq2oGkL+32Tv6v+H/jE3WA=;
 b=HUa3OPs/xety1oSFYVQtlbWf5VTi38y+/VU7MlJAFsi55siG2xjzhviPmVdmsz+O6IQUWF2TFwEx/WInAJ2l98fWS/TagIs5tk8LdvyFh35iBoYkOyHziGajlvaHk2mNnV7HMQDi29leYfOrAdsNjqQyZAAn1rW/pzL0qjSthRg=
Received: from BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 19:39:53 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::31) by BL1PR13CA0193.outlook.office365.com
 (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Tue,
 21 Jan 2025 19:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:39:52 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:39:50 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/14] DC Patches JANUARY 20, 2025
Date: Tue, 21 Jan 2025 14:39:05 -0500
Message-ID: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: dea17fd4-2f56-484f-e0aa-08dd3a536036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?obfArpVsaeGYl54moArLjhpBhoRaFUVTUWqS1kD9U0Ja9Rtq07pKSyQcjfPP?=
 =?us-ascii?Q?bUEncTvWgfnrizTyTMSQHyTU2vRbyQDt2X60vtSWGVrseaX2NjSbfwkHZsvX?=
 =?us-ascii?Q?J/c8/KMOhhlddhvPUnPmVYrngNCt5PBy5GH3LkPOCKu0/SRwlTkCPx5wJKu6?=
 =?us-ascii?Q?w09ojb6WpGSCoKGSaSPau2gA0Vj2yz95rz7ObKFsXSZr8c9aFlp6ojaq6Qhl?=
 =?us-ascii?Q?mbAIcbDGEoDvwxMNvR+AxaQmGoJamf6JKUSndag6DmRL35IDp9yJ9wB6lMsx?=
 =?us-ascii?Q?ZJzcr5DALDzrnxyL4g74k6leWorPAfQNMk3ioMSlf+NKjh5UcklZWS3RyhL+?=
 =?us-ascii?Q?h74CBZFq7YH4eKZCN2EhfuQ5sXMFads7n/7peybhbXNBReL/x+vmIdRF75af?=
 =?us-ascii?Q?mQHAZ+DtD2aheYCnPBQ41QQpmC5PCgURcs2+utBkHaect44l2Co60m8kgp8a?=
 =?us-ascii?Q?qZaEtRaR8SMCIHT55shQhmBCpuWIAvhPPblLil/CsgPD6KefELLjhAu6I/ac?=
 =?us-ascii?Q?sgDsRJwNB58Kd55omm10dW5AU5TkCUug6gw+cN0kbmVXMPguzE23eTETjs//?=
 =?us-ascii?Q?aT08OmCsvENu4uuITduGnFj0CFqdCx+Ie4tH/WMDqPRP1P+zHjLlAQEB02LI?=
 =?us-ascii?Q?QJ1oBrx7CqW+Fe/aKg9uXbTVvKZXfM5IZ5/dsWm/nIl2uwunVl6EDzYNoiXt?=
 =?us-ascii?Q?jnDnXafeCO6vkWz5efV2h4VD6ybq+ZpPzpwK44y/XEXip2QUDuzsjxAzN8d/?=
 =?us-ascii?Q?DUQXA+Fi7ykr0L6LBAF0n2+VHGuDaLpq1vxxvz2AnVX7aAVJ+RlMYIX+pQgH?=
 =?us-ascii?Q?0+F2Hcu//HtZLUnC0B0zICoRpTYJZDGyKqq8GPxKDNp0CY+bsXM7s1s0SZQp?=
 =?us-ascii?Q?cLmnXMR9+xXKTTRz1gRb+aqDXZb1Cx8f770+D6GNESfPz+WDmaWp4Qm/z7Lz?=
 =?us-ascii?Q?AK/IrRVJutl+bCt1u+xRbxaVxeflIDTk/i0LnLaHb+riho6zddl6MQn4rryE?=
 =?us-ascii?Q?AYxL0PdZHiwaWdjE5bObmpmUtR1tOVD7ExBpQAtUZL2sx6tlpR8iyKu8qrNz?=
 =?us-ascii?Q?OXvJz34jSkEMwDKw1aQyc2nwcCMx1eDe82A3skRc5mbHcuY8zlQbCLSULfXi?=
 =?us-ascii?Q?kHYbuu9qQAEfedDru7cMVet7Cx8HLwmhNRVcbQb4RIlGS+/Ag0Zr71k/IHFO?=
 =?us-ascii?Q?xNx8A7FuVvt3ORyn0YwX20OcYygTLizuXBL4+o7kZCFkt6c9GGa5qucheHH+?=
 =?us-ascii?Q?fvIOr4Bi1jcTRnofXkydJITVsS+qkaYKh3THqAVGjiWKyr6AhDIKfCGBLO67?=
 =?us-ascii?Q?qvQrLbbo8vNmA6QGbYVQev9lul4DJ/dWcdTujMZXMtC4gY/AELKSW5Y6wkmN?=
 =?us-ascii?Q?wn5WJIcLlaOejAsqTl8T+72FiRwqyld3V0iwKwVBLl4LkgsCYDjSUtfqTkqM?=
 =?us-ascii?Q?G1nqHjp3QDB/dbbhG3B7bQ7BxAj0kOPnJhAIKseugHFvCLwJHwu7xQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:39:52.6446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea17fd4-2f56-484f-e0aa-08dd3a536036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
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

This DC patchset brings improvements in multiple areas. In summary, we have:
 
- Fixes on psr_version, dcn35 register address, DCPG OP control sequences
- Imporvements to CR AUX RD interval interpretation, dio link encoder
- Disable PSR-SU on some OLED panels
  
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Fix possible NULL dereferencing

Aric Cyr (1):
  drm/amd/display: 3.2.318

Austin Zheng (1):
  drm/amd/display: Account For OTO Prefetch Bandwidth When Calculating
    Urgent Bandwidth

Charlene Liu (1):
  drm/amd/display: pass calculated dram_speed_mts to dml2

Dillon Varone (1):
  drm/amd/display: Ammend DCPG IP control sequences to align with HW
    guidance

George Shen (1):
  drm/amd/display: Update CR AUX RD interval interpretation

Hansen Dsouza (1):
  drm/amd/display: Add boot option to reduce PHY SSC for HBR3

Peichen Huang (1):
  drm/amd/display: refactor dio link encoder assigning

Sung Lee (1):
  drm/amd/display: Guard Possible Null Pointer Dereference

Tom Chung (2):
  drm/amd/display: Initial psr_version with correct setting
  drm/amd/display: Disable PSR-SU on some OLED panel

Wayne Lin (1):
  drm/amd/display: Fix potential NULL dereference

Zhikai Zhai (1):
  drm/amd/display: Update Cursor request mode to the beginning prefetch
    always

loanchen (1):
  drm/amd/display: Correct register address in dcn35

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  20 ++
 .../drm/amd/display/dc/bios/bios_parser2.c    |   4 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 202 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  25 ++-
 .../src/dml2_core/dml2_core_shared_types.h    |   5 +
 .../display/dc/dml2/dml2_translation_helper.c |   9 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  22 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  14 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  34 +++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../link/protocols/link_dp_training_8b_10b.c  |   7 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 21 files changed, 339 insertions(+), 35 deletions(-)

-- 
2.34.1

