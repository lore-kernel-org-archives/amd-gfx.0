Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8F8C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A8C10E06E;
	Wed,  7 Aug 2024 07:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hP4gBiTI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339CF10E06E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzvyzbnrNWZ3xd6NeEqqMPzRPsCHq4RXoR0/CMkuATJ0CxSA/fbTcjB0x5e0IDTT4zFU0N9pbth1y65gdUkahT2Q28vTCZ1CaCjAV5tWKwDqmdQVKceXOs5EI/O4HLhS6d2cmwXsUqMSCLzyt0u6HVk6UbCW1TgUTAgUHm/CmZ02ciSSk9vRhNX4k5umo8XfdOMhdW6n4C7dSRJvEJlzEp8qxr6Qou5EDFGsSB6jxE0W5E+1VK6aAsyNAnkNfz4hJTpxzvzg1qpJqJecM8/fh+dj5gXYblHhhNXSG6LsNr2BKAJl3ntjzXZ0otxKG1a4CGqxZgjNz9xfTID8UjnYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HjWnipC9i3nKGsa4CsAxb5slL97+CXT7S5/YpxL9tI=;
 b=t9+L62RUjoEbtlaIEPYTu0al3+WO8ZzpegrVveAvWffJlduQtkf6HvFL7irqfS8B3Q7TPntIaY1Pin1ykA+xSJI1rIPVsl/SPfj1Mm8FvgzJMXxwyK+Y2en6I5IB86Uh0rUa0RGO4XESdZpAlbV8Knm13rnwUo2Rs38rmfSMMUoINykAr7FAdZGsIQxxbgzq89gV/SYYorZMMbc/SRjnVQYjDFN9g/2m+VJxJ2jpwJkQInJWylZtWxAPvvNHM6r66VtQHENM2nZjQ6p/+XDkyC8f5ke2fZ3CRE3epGqOb/c84f6gOSNkz3YLl+c+HKOsB54Ri6FFKTJfOWhcbig7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HjWnipC9i3nKGsa4CsAxb5slL97+CXT7S5/YpxL9tI=;
 b=hP4gBiTI85WK6y2x+qRcJ/byOiW/lYe99g2jXujzJ34NxQWGLvoEgd4leVFYvx5FZwCGZZbsniNXJFJH4G53wdFBbOpQ20nuZu1HJpcLSMw5hO6sS9/DLJ/zpykkYb0uoRDlZygW4QxGI7xZuFjd5GjBvuD5dPL25lEN3M2n2xQ=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 07:55:53 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::9f) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:55:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:55:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:55:52 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:55:49 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/24] DC Patches Aug 12 2024
Date: Wed, 7 Aug 2024 15:55:22 +0800
Message-ID: <20240807075546.831208-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bc23ac-99e3-4cf4-0b88-08dcb6b65c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gdkHhQ1jTSLSO5kbxHqRNKljlXKTvBxHf6ArrCBz0K7JLc+lwsc2UQTKVPKM?=
 =?us-ascii?Q?xQaD0dJnKjCXh8nsw96etq9LQzUlrfgRceZviyn1jiOTJmEZPS1UQe9Kx8It?=
 =?us-ascii?Q?WMKJb3FaSvyv9+IhOsIMfrSqacua3S8jQxIWRTSM/afX8swJX6rIJGwvKYa5?=
 =?us-ascii?Q?NfQTLzClUyWMGfERnevr+Vrp+iCry4UA/Cp3azCuXpn7py50liMjMnyuqDsY?=
 =?us-ascii?Q?lqOfT1sCbBFAkFzLWh/eFyGXNQED31gg93dmRGdVO1E4ef/1ahmVU+7aVsgL?=
 =?us-ascii?Q?AKeG3/KrjTu+0D5+dSGmQN+KQtAZOUnZJdZF2vLTO2mqWYHvZTiwrwhzLLFu?=
 =?us-ascii?Q?XDgmvdVcDCxZ2iDrhPDR7wO9Roux8ZeGcWmF4fj+deFHnn0cYuRRrELjZJ4G?=
 =?us-ascii?Q?ySzgKiYnPu3Xqb0Ob8I9BMvjS4fJU7mqPWGMaVmJ8EwXuVAj+45+z849Kmkl?=
 =?us-ascii?Q?U2cL5CNVDiE9hvnJD3xOozesgTdSdJDurnKshPUDDKtxKGKXGQ7n29/NvmN/?=
 =?us-ascii?Q?7dPDW9GnINRCX5KjUaigggOWi65o4D5nZsumFfvz8vhM+LCMTZYPIU7AzNor?=
 =?us-ascii?Q?z/o7M2Wzxj+oO37dVULjTjtquVGmJeIl6TyspLt+/pVBkoC8K/8tMzZMFl8G?=
 =?us-ascii?Q?fkQsMduORvbzNdcZf1ljpc/s6fe8VkovDLZ6U8oFEE+WCWftxftSuAATlGcR?=
 =?us-ascii?Q?Yqfzd3c5zA7YrfpGPYsKyYxgjPcg0+aMrc53Z+gz6s8JGbpFemy1pXDZ5JCc?=
 =?us-ascii?Q?/UX826K2HTgvrRsx61ZxIdFdqZscRSeuX6VEuyJxf52x8/tzqsmy+8lYGRha?=
 =?us-ascii?Q?J1+NMTlziPrKr7EViytyX/b7pL91GYAhHkPtBgMwmGphPX2VLIyLyIb0B6gA?=
 =?us-ascii?Q?qjVs8aYCXDpPkGRwoPGw4ktK99k0UQm+Bc3W6mO4Yj3B2cYE+JIHSjzA9qo9?=
 =?us-ascii?Q?PaTC566lMHDd1xD+DmC2JeOL795GvruFRJFuCjtfxKm7uopmf/M4PVElBLmC?=
 =?us-ascii?Q?FiHPhQ6DGgRmkecKpmF9e8x4NYkj0VK7EnwR2fcNHkMbRhf4Ht0mdQuQ8rHk?=
 =?us-ascii?Q?bw8wdNQ/p7wyeYltH73MU0iuJ6B7isbf8JEQFF7p7tfXul1Wa45W6/+5FcLy?=
 =?us-ascii?Q?ga/Nc4T8Cqxv35coPg3WFtizmq2gBISnk233oVNFooBnn2v3qODmQpLHcFlm?=
 =?us-ascii?Q?6zU+LyAKBTCOPMzi9aBL4K2NOpt8CUw6ow+fIIgpvP/xSkTWfzK7jjmlR1k7?=
 =?us-ascii?Q?tzN2DSqCZazKY1+UQJvf85PHXC+HJ4XzuDx81s7JUP4ro5V5BUKP+yWWLC6d?=
 =?us-ascii?Q?BBPn+sVWkNzw6U3+70YB6tcc97UZMDdjL4FCvHLnKtbecoHuN4EZiP4QEB6f?=
 =?us-ascii?Q?W8Os9s7xPVi8m0BgrbY/mg6BjXf+6Mv2S4h96nXCUC8DKCz9vR5pHtdeuL9D?=
 =?us-ascii?Q?yx19TZYHqa7WmFyDrZEKA9VN/3CKbzuH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:55:52.9113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bc23ac-99e3-4cf4-0b88-08dcb6b65c5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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

- Fix some cursor issue
- Fix print format specifiers in DC_LOG_IPS
- Fix minor coding errors in dml21 phase 5
- Improve FAM control for DCN401
- Add null pointer checks for some code
- Refactor 3DLUT for non-DMA
- Optimize vstartup position for AS-SDP
- Update to using new dccg callbacks
- Enable otg synchronization logic for DCN321
- Disable DCN401 UCLK P-State support on full updates

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Check null pointers before using dc->clk_mgr

Aurabindo Pillai (1):
  drm/amd/display: Add more logging for MALL static screen

Austin Zheng (1):
  drm/amd/display: Unlock Pipes Based On DET Allocation

Charlene Liu (1):
  drm/amd/display: remove redundant msg to pmfw at boot/resume

Dillon Varone (4):
  drm/amd/display: Reduce redundant minimal transitions due to SubVP
  drm/amd/display: Disable DCN401 UCLK P-State support on full updates
  drm/amd/display: Perform outstanding programming on full updates
  drm/amd/display: Set max VTotal cap for dcn401

Hansen Dsouza (1):
  drm/amd/display: Update to using new dccg callbacks

Loan Chen (1):
  drm/amd/display: Enable otg synchronization logic for DCN321

Martin Leung (1):
  drm/amd/display: Promote DAL to 3.2.296

Melissa Wen (1):
  drm/amd/display: fix cursor offset on rotation 180

Muhammad Ahmed (1):
  drm/amd/display: guard otg disable w/a for test

Relja Vojvodic (1):
  drm/amd/display: 3DLUT non-DMA refactor

Robin Chen (1):
  drm/amd/display: Optimize vstartup position for AS-SDP

Rodrigo Siqueira (5):
  drm/amd/display: Check null pointer before try to access it
  drm/amd/display: Remove unused field
  drm/amd/display: Improve FAM control for DCN401
  drm/amd/display: Adjust cursor position
  drm/amd/display: Remove unnecessary call to REG_SEQ_SUBMIT|WAIT_DONE

Roman Li (1):
  drm/amd/display: Fix print format specifiers in DC_LOG_IPS

Wayne Lin (1):
  drm/amd/display: Check null pointer before try to access it

Wenjing Liu (2):
  drm/amd/display: fix minor coding errors where dml21 phase 5 uses
    wrong variables
  drm/amd/display: apply vmin optimization even if it doesn't reach vmin
    level

 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 124 +------------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 123 +++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  28 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  26 +--
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   4 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   3 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  14 +-
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |  17 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |   3 -
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |  23 +++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  48 ++++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 171 ++++++++++++++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   5 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  17 ++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   5 +
 .../dc/resource/dcn321/dcn321_resource.c      |   3 +
 .../dc/resource/dcn401/dcn401_resource.c      |   1 +
 .../drm/amd/display/include/logger_types.h    |   1 +
 29 files changed, 460 insertions(+), 203 deletions(-)

-- 
2.34.1

