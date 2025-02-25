Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D9FC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D5910E36F;
	Tue, 25 Feb 2025 06:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iDAXrwkl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE1310E36F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtUI1WlLiiAga/mCCY1WknfOyRmPNZPr2tRWZhZYoE6U1VT3W5XdmM2L1lYTwmAXNK1z8OjeLlPHaAP6CIosBd4S944WzR+TAZvJgz7FeNjB7CTkYY8gS8H8F/KlVIJYMT1Rnwm/ktyBXkGogCxgo5Gfi25VVB5TMA/FhPesI/HgdYgcZDK5fJoRH8HqUKdkFgkIpf5bMHX45Q8V2MN93MGRNwYm/qwMk44rnbXcQcw1QZV6yemxZYQA6tOLFiBrqMbwQycmZaG98Wl1qmye/iOnDVyzYitCXveOSOlFQXX06HsqxZwkMuwnUEUeaGSI85jeO4jDAcVjA9RN3JJj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCWNCuO33WTk6F4iqIhmUnI5xZDakcuWdUV9/EbV4sE=;
 b=JZ2fFPkZhFmf0RSmjunpywAj2GvG4MmnAUyADr6z43l2t3IjAcJJxeRpxTx3PwLjsnT78FcxlQpeRFMQp7VoXXkTi78JV5W7e9kSCECS3uMAmowRJGxePNh+mTIrK6Fnhtl/lFcahXAzGSXJ3f4PxD7zASmNvSr4wN42L1qmN8KsMFXXboRi9EJ1WcJvPCvyW1fyivOQuRysM1Ums2/uugQsK0ccVmenLsnDQM645SvnTtbjIHWidHgb2gybXbHflI4YLajol3dNHiW5dYlD7ntqxhYCRun6x6npqUa6yik4weM/M4mn0MjjKGZZ4LTOmOPxi/6bb3aLp/BPjbRXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCWNCuO33WTk6F4iqIhmUnI5xZDakcuWdUV9/EbV4sE=;
 b=iDAXrwklSvg++TszvaznbwrseV/fHXVqb1KOxN/CDefwAaix24N2mZ7UH35qqzex74nzDPgb2EZaYenFHJB0IEBFlMbTUUE2fs/+7vGnyQBTtiMvGs1OMUPsgmi3YrK1VCP5UyPnLREY0zN3rWqNQwB2qaWEfGTNEvNJNpFjYGM=
Received: from BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) by SN7PR12MB8792.namprd12.prod.outlook.com
 (2603:10b6:806:341::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 06:36:25 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com (2603:10b6:207:17::4)
 by BL0PR1501CA0015.outlook.office365.com (2603:10b6:207:17::28) with
 Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id
 15.20.8466.20 via Frontend Transport; Tue, 25 Feb 2025 06:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:36:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:36:24 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:36:14 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 00/27] DC Patches Feb. 25, 2025
Date: Tue, 25 Feb 2025 14:35:43 +0800
Message-ID: <20250225063610.631461-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e145816-f0f1-4698-dd98-08dd5566b9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fI0wYpLW0lQtBsuvBwhRr+Ttsr1uJfnPVFsjRAcBczAY+k7kk14XYmmMWWkA?=
 =?us-ascii?Q?MaWz62nl3il0ee0sAh7wZgV5rjyq12tsEv1T0B770poJrsf5hYjTny7bAkU9?=
 =?us-ascii?Q?1cAb6JKiNpXjLX/p7Lw1wdJTcLNQLkfHPD2Kbg5FZSktTA8vhQPy0rET63pg?=
 =?us-ascii?Q?XCwC3+1JM2DLpOFmQ2w/SXmbnojKCuZ8gIuq5wWTfm/uK6Vt9Wvs7taQzLbc?=
 =?us-ascii?Q?x3XeqWJ4zQAholj0RhzbHcKBFMBpye2llD3ekuxOqEm+9gB5NNvU6Q4cqe9d?=
 =?us-ascii?Q?BRwQRtMPN3aM1JoIdOhUj31Q+tPBIq6it4i97HdCP+rjNx/R/s074OVQxJLw?=
 =?us-ascii?Q?bJXmW20lHzzuzXVjJAASwOhu0KfEkunbSXaAZmhYkqL2rdg5je/51gXzUnGY?=
 =?us-ascii?Q?OeQRkajfkiiQN7nKvM13g9CqEIYwTISjY234Xkb0aItkmzkcmGaRU8nBR3JN?=
 =?us-ascii?Q?RmsxVSDdQAEDUlN7KoNzdmkkn2hEzGIjWLjinAufLwwSzyuITJTxnjNlrIV9?=
 =?us-ascii?Q?y5Y+cX9Ch74tAW3OWr3eNdN1OV9WGqzG2H9S/A9F4dJKnRzH1sE9aSI1QL/t?=
 =?us-ascii?Q?cm5Ia++6tvgzjuVBMTqSAJnMMYIjMbvB1qV04ihrz7cmM28xJuzUfRanYF95?=
 =?us-ascii?Q?Tka6wAt2So15rpx8w1JvjpbOVreBGT08my4OLJMfShjHUkBfi3mYfp4lWLnf?=
 =?us-ascii?Q?o7hEg3sq76konU7mkjo0YnLgWP9KD4xod9HAmHxpv9vJkZsASD5BAk0uqLzW?=
 =?us-ascii?Q?NmDRKzTTTUEnT+13xZwzey9Qiz69VIaehnGQ2XnVvd9oQmPKLC/J5y/O+Ii0?=
 =?us-ascii?Q?SRus3CVdGCmD/bLnKo2C0eKoTaOs+6haZH8Z0/bC4sH0P+gDNT06ceMxygh2?=
 =?us-ascii?Q?fCqGVEHvGbPNYmketBOGkXaEDLBf6ueO1Sz6CykTfHPyl6vlaK/hR1PECcR4?=
 =?us-ascii?Q?rARqg5xHrCaqiAzut7jI63tnt2LWJL0hBoXxRGyEUQ3Q/OIlGYg4sHnCZpVu?=
 =?us-ascii?Q?ELfbLP0gTZvGxkvZwtiX2yEjCyl2gkpXa993sizMI6FG7Zz172HV0+CgjtIB?=
 =?us-ascii?Q?81q8Snjyt2fAjZJZ+HmDoYsmW8Ozkc+fztGwoYtU1cEzYnFTqV4nMfDHnLDS?=
 =?us-ascii?Q?xE0dQSS8XMmbMN/3JMjD1u+GewnwwNaaDppxA9gDdJpqP3HL+1naKB1YhUDo?=
 =?us-ascii?Q?10mNHXqN5/WR269dUMWPdj8B6amv2twc8kgh48LgAiuv/KFgcF9hp+1z09Ed?=
 =?us-ascii?Q?o6ljUVbRMXN2DkgZHJbl2aH9LrtbcZ1N2jMoWcxQytvMmPeqwxgsrxvr4C2v?=
 =?us-ascii?Q?pjvpMteA+CeIEazsRwXWhUYYnJwzRr9nmAaAXA0y14YGbInNXIWSv5nueWcw?=
 =?us-ascii?Q?Oow+XoU5GaCBGdj8P91mACLqruzuQpMY/DHYDH4cfTMBC0UfMG68beIkmllL?=
 =?us-ascii?Q?AOTCbQcOrn+0WZ4gebO9ADxV+rteQtgM/D5lq9J28jPEGQ9t/5exIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:36:24.7262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e145816-f0f1-4698-dd98-08dd5566b9bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- Various cleanups to amdgpu dm
- Add DP tunneling IRQ handler
- Fix display corruption for dcn35
- Fix dmcub reset problem
- Adjust BW determination for PCON
- DIO encoder refactor
- Fix performance with SubVP under gaming

---

Alex Hung (1):
  drm/amd/display: Check NULL connector before it is used

Aric Cyr (1):
  drm/amd/display: Request HW cursor on DCN3.2 with SubVP

Ausef Yousof (1):
  drm/amd/display: wait for outstanding hw updates

Cruise Hung (1):
  drm/amd/display: Add tunneling IRQ handler

Dillon Varone (2):
  drm/amd/display: Fix p-state type when p-state is unsupported
  drm/amd/display: Fix DMUB reset sequence for DCN401

George Shen (2):
  drm/amd/display: Skip checking FRL_MODE bit for PCON BW determination
  drm/amd/display: Remove unused struct definition

Hansen Dsouza (1):
  drm/amd/display: read mso dpcd caps

Leo Zeng (1):
  drm/amd/display: Added visual confirm for DCC

Mario Limonciello (13):
  drm/amd/display: Change amdgpu_dm_irq_suspend() to void
  drm/amd/display: Drop `ret` variable from dm_suspend()
  drm/amd/display: Catch failures for amdgpu_dm_commit_zero_streams()
  drm/amd/display: Use _free() macro for amdgpu_dm_commit_zero_streams()
  drm/amd/display: Use drm_err() instead of DRM_ERROR in dm_resume()
  drm/amd/display: Use scoped guard for dm_resume()
  drm/amd/display: Change amdgpu_dm_irq_resume_*() to use drm_dbg()
  drm/amd/display: Change amdgpu_dm_irq_resume_*() to void
  drm/amd/display: Use _free(kfree) for dm_gpureset_commit_state()
  drm/amd/display: Use scoped guard for
    amdgpu_dm_update_connector_after_detect()
  drm/amd/display: Use _free() macro for
    amdgpu_dm_update_connector_after_detect()
  drm/amd/display: Use scoped guards for handle_hpd_irq_helper()
  drm/amd/display: Use drm_err() for handle_hpd_irq_helper()

Nicholas Kazlauskas (2):
  drm/amd/display: Revert "Increase halt timeout for DMCUB to 1s"
  drm/amd/display: Ensure DMCUB idle before reset on DCN31/DCN35

Peichen Huang (1):
  drm/amd/display: misc for dio encoder refactor

Taimur Hassan (1):
  drm/amd/display: Promote DAL to 3.2.323

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 89 ++++++++-----------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 14 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |  6 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  3 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 20 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 14 +--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 49 ++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  5 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 50 ++++++++---
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     | 50 ++++++++++-
 .../dc/dio/dcn35/dcn35_dio_link_encoder.h     | 23 +++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  5 ++
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  5 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c | 40 ++++-----
 .../drm/amd/display/dc/link/link_detection.c  |  5 +-
 .../dc/link/protocols/link_dp_capability.c    | 41 +++++----
 .../dc/link/protocols/link_dp_dpia_bw.c       | 26 ++++++
 .../dc/link/protocols/link_dp_dpia_bw.h       | 10 +++
 .../dc/link/protocols/link_dp_irq_handler.c   | 43 ++++++++-
 .../dc/link/protocols/link_dp_training.c      |  3 +-
 .../dc/link/protocols/link_dp_training_dpia.c | 13 +--
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  3 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  4 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 47 ++++++----
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |  3 +-
 31 files changed, 424 insertions(+), 162 deletions(-)

-- 
2.37.3

