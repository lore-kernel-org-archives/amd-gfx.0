Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFA5CD3424
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 14:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA2810F537;
	Fri,  1 May 2026 14:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GFuk30wn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B155B10F537
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 14:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIrLFPrntY5NY8Vgvud0VHne/Zyp5RaRbkZnOoPL+EHJ0/LRyFuMADqWdm+d9s8DEdAO6Nn0c/1+3Q465lp4mgwPZCTc4r300sm+fiZ9L81+hyn6uTvq4bdIE1GCYgul7a6wjif3rvbCxJ5k5fTFMVSOaN/yDcj2VT85YFb1hTR2QDkNv6iYv3by11LK+wjNlI3dYaFfiRMmAeKw+YbVbLC5DE79DP88sT9A5guVS3ajyF3pNJ3SZZpn3Y0fS7fvM7fciFeP9rU3eOVdWMtYbC6CpESWM1+ttEuO9fCbYUP6iNDEYQnZ3gjkP2ULCQYcqk+gP3V3/9y7wQEhLHzjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCaY3A0D2WhnbyfPgiJEXqV00oGraWQ8B/X3ffI6III=;
 b=aEkOG081yHKZgqKro99aqnzcpGJUkxB45cZBkBjCnB6BT4z8yLo/bpD0OeOAz3PdLjMAHiazkIXcjOpp7tJO5GLGtVCJevxDRivBwEmR//8QJct38qSeHv15fWTSK1WU9LKqZLv6guFrK7s/8A00S7CeLZ7gV/cFZpPbRiw6pgWL9Cka4bBQQhQQrn1ptYRtQdzcBxG2enUTuNsFirYHDqPqdJ+/DbUteUuAkVzRjWdB0rrh9YDHwISXgNKm6w43chcgDXJ+eRWMEH9wiTac4QShu1ADptOtlMz7pq0hNKLfc3bfAtNy7wgRxVH4D1piv2+ya9/GriK7+DDtLkboLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCaY3A0D2WhnbyfPgiJEXqV00oGraWQ8B/X3ffI6III=;
 b=GFuk30wn+vgNqqDmTi3m0c+G6QEDYRzGOecUl+/SELP9dR6cmjwWLE5zu9G1By6bE7nnNc7zRe+cWf9XCS+oF8OI3ArRl+u6lhazywhfjdhPM859Ncbx5idJtgKb1xrVE+ReMeXW9yY0T8bD8KinrWhOtYF3IHDoHiHMT+Cc26o=
Received: from CYZPR17CA0012.namprd17.prod.outlook.com (2603:10b6:930:8c::16)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 14:04:51 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:930:8c:cafe::f7) by CYZPR17CA0012.outlook.office365.com
 (2603:10b6:930:8c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Fri,
 1 May 2026 14:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 14:04:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 1 May
 2026 09:04:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 1 May
 2026 07:04:49 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 1 May 2026 09:04:48 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
 =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Subject: [PATCH 00/21] HDMI FRL Support for amdgpu
Date: Fri, 1 May 2026 10:04:16 -0400
Message-ID: <20260501140441.41068-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: b71989a2-7755-4291-d29b-08dea78a9c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2gTYmEzX0wCpN85dzo40OcWeGNqCXUXFI0G1IC4ovUPtbaxX0bH2V9HhuP5cT6amZJt56EALt83kfw0T7Dt1HShtFqfvzOed18aKgYTXfqB3klIBLeUkvgG6FrqmTJaU2wgm0Eh+nDsCrH2iQ1VGV5r3EQNrSb/7q5izWojRQDaY9pci4IKjjlUD45XE/plLLOCuulnvRPtPq9SVQJg+1mvORcBQr64kAzbcSZ0oObA6zf62nM15ehASoFhk3Zkz0m4OA/5/1qCidWXwc6Nyj494qSOKTS68i0D94iGwDIrnkuPrBmhXS+cnRFzC8fx7Z6QAA8kHbWxvLgaVXovjYBZ7wi7lvaIOUjsQinH6mhdMj9dPHz60pS77vfF/mAtBVO8jElymQpDnRm1iCDvWNZQOudejzOmpThluQvzq1j3mL3fqqHate9gxYVatoKIepOqqn+FbA2XKkhwRBM0bEJ9WDqJqrn0pePtfyLK+ymUQjezetxjVvEKDWP5bB0j81VRxDQHgjewk1RpXEasnBWBPUm6E4WM4KLpL1YssTkyzgLgKv4wRAlCJGNSdhXyedbHalD6bXAGzggovDuFTy3f9KbZL8SDZ5Qpcv62jOvcaXCPHEiO/l//GMav0kBGga6xb16BdjzRNXCYJddLxdOhoKNZZikp0dLpKOmARe3xryNlG6dw+4Uoqr+x5tJ/YjW6UZCu1PpfbJ0PXxGKVhqFw/AIZPSUc6z+eHs8SQdE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ovdAyZK0EsbFsaqqcKwIvdoef1+6e3G4e3BUNZU3z3Uce/P+kXcft29YKrMRHA6Ai5dxAhQulL5kISIfnwzIp6ukhNdFQ/UOtFKKy3PMACShIJt6Cuw0ViJZUwAg8WF8CFk/ZxLQNIG1KaRKPOcXXHC+Brq+Tc/ZTi8EIkOr6mw/r7xMKzsXCCXSDy4kVYpodeUr9qUbfL7jfZdimHxYdUe3TodPMymdVf3MVMqdZ3oUYLTicu/eJAapFCW9Rocbf6VQBoeQouhIbzaoWl03ip1ABxGoj+mugC3vAFov8KhzHcby6+UPGgv39m+aQfANciCQasR5g3SNpDM+iY13h7/PuVQCflx0gzw0byAZldiVu2GwWyRvxwsyG4jKuXzCb5fYPwJYoL0is6dKKR/4ueJ1WE6j29Qedtuyo99POtlhfjtG8AzUrg+Wyv1Du3NS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 14:04:50.5335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71989a2-7755-4291-d29b-08dea78a9c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
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

This patch series adds HDMI FRL support to the amdgpu display driver.
DSC is still being tested and will be sent out later.

This work passed a representative subset of HDMI compliance and a full
compliance run on this branch is in the works. We don't expect the full
run to show any failures since it passes in other environments.

Thanks to Siqueira who prepared this work a couple years back and
unfortunately didn't manage to send them while he was still working
at AMD.

Thanks to Jerry who has been making this code solid on Linux and
running the compliance tests.

The first patch in the series isn't related to HDMI 2.1 but included
here because it moved the code around some key bits of the HDMI 2.1
stuff around too much. It will land with the next DC Patch series.

Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Zuo, Jerry <Jerry.Zuo@amd.com>
Cc: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

Bhuvanachandra Pinninti (1):
  drm/amd/display: Implement block sequencing infrastructure for modular
    hardware operations.

Fangzhi Zuo (1):
  drm/amd/display: add HDMI 2.1 Compliance Support

Harry Wentland (10):
  drm/amd/display: Add HDMI FRL definitions to includes
  drm/amd/display: Add DML changes to support HDMI FRL
  drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC support for FRL
  drm/amd/display: Add FRL support to clk_mgr, dsc, hdcp
  drm/amd/display: Tie FRL programming together in HWSS
  drm/amd/display: Add DC resource support for FRL
  drm/amd/display Add DC link support for FRL
  drm/amd/display: Add support for FRL to DC core
  drm/amd/display: Update HDCP and info_packet modules for FRL
  drm/amd/display: Tie FRL support into amdgpu_dm

Rodrigo Siqueira (9):
  drm/amd/display: Add FRL registers for DCN30
  drm/amd/display: Add required FRL registers for DCN31
  drm/amd/display: Add FRL registers for DCN321
  drm/amd/display: Introduce FRL registers for DCN32
  drm/amd/display: Add the necessary FRL registers for DCN314
  drm/amd/display: Add FRL register for DCN302
  drm/amd/display: Add FRL register for DCN303
  drm/amd/display: Add FRL registers for DCN315
  drm/amd/display: Add FRL registers for DCN316

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   80 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   11 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   28 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   23 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   79 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |   21 +
 .../drm/amd/display/dc/bios/command_table2.c  |    6 +
 .../dce112/command_table_helper2_dce112.c     |    3 +
 .../bios/dce112/command_table_helper_dce112.c |    3 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |    3 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |    3 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    3 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |    3 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   12 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   14 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   18 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  443 ++++
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |    4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  622 +++++-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    3 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   45 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  233 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   35 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  121 ++
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |  162 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    8 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   24 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |   40 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.h    |    8 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   88 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   13 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   25 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   68 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  321 +++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   73 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |    4 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   33 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |    8 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |   30 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |    3 +-
 .../display/dc/dio/dcn20/dcn20_link_encoder.h |    1 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |  250 +++
 .../dc/dio/dcn30/dcn30_dio_link_encoder.h     |   17 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |   18 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |  114 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.h     |    8 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |  214 ++
 .../dc/dio/dcn32/dcn32_dio_link_encoder.h     |   16 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |   20 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   21 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |  220 ++
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |   16 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |   21 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |    1 +
 .../drm/amd/display/dc/dm_services_types.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |    3 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    5 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   89 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |   22 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  277 ++-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |    1 +
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |    1 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |  240 +++
 .../dc/dml/dcn314/display_mode_vba_314.c      |  238 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   10 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |    2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |   16 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  124 +-
 .../amd/display/dc/dml/display_mode_enums.h   |    1 +
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |  589 +++++
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h |  164 ++
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |    5 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |    1 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |   10 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c |  286 +++
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h |  146 ++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  |  938 ++++++++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.h  |  436 ++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.c    |  906 ++++++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.h    |  335 +++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |  206 ++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.h  |   59 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   99 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   37 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   19 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   49 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   16 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   42 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   13 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   38 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  377 +++-
 .../display/dc/hwss/hw_sequencer_private.h    |    3 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |    2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   10 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  176 ++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  227 ++
 .../amd/display/dc/inc/hw/timing_generator.h  |    6 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   15 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    7 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    2 +
 .../display/dc/link/hwss/link_hwss_hpo_frl.c  |  113 +
 .../display/dc/link/hwss/link_hwss_hpo_frl.h  |   34 +
 .../drm/amd/display/dc/link/link_detection.c  |  111 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  185 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |    1 +
 .../drm/amd/display/dc/link/link_factory.c    |   44 +
 .../drm/amd/display/dc/link/link_validation.c |  298 +++
 .../drm/amd/display/dc/link/link_validation.h |   13 +
 .../amd/display/dc/link/protocols/link_ddc.c  |   90 +
 .../amd/display/dc/link/protocols/link_ddc.h  |    4 +
 .../display/dc/link/protocols/link_hdmi_frl.c | 1147 ++++++++++
 .../display/dc/link/protocols/link_hdmi_frl.h |   53 +
 .../amd/display/dc/link/protocols/link_hpd.c  |    1 +
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |    1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    5 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |    8 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    2 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    2 +
 .../dc/resource/dce112/dce112_resource.c      |    3 +
 .../dc/resource/dcn30/dcn30_resource.c        |  126 ++
 .../dc/resource/dcn301/dcn301_resource.c      |    1 +
 .../dc/resource/dcn302/dcn302_resource.c      |  109 +
 .../dc/resource/dcn303/dcn303_resource.c      |  109 +
 .../dc/resource/dcn31/dcn31_resource.c        |  127 ++
 .../dc/resource/dcn314/dcn314_resource.c      |  127 ++
 .../dc/resource/dcn315/dcn315_resource.c      |  128 ++
 .../dc/resource/dcn316/dcn316_resource.c      |  126 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  131 ++
 .../dc/resource/dcn32/dcn32_resource.h        |   79 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  132 ++
 .../dc/resource/dcn35/dcn35_resource.c        |  121 ++
 .../dc/resource/dcn351/dcn351_resource.c      |  121 ++
 .../dc/resource/dcn36/dcn36_resource.c        |  121 ++
 .../dc/resource/dcn401/dcn401_resource.c      |  121 ++
 .../dc/resource/dcn42/dcn42_resource.c        |  121 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    5 +-
 .../gpu/drm/amd/display/include/audio_types.h |    1 +
 .../amd/display/include/bios_parser_types.h   |   14 +-
 .../drm/amd/display/include/logger_types.h    |    2 +
 .../drm/amd/display/include/signal_types.h    |   12 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |    2 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |    6 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |    2 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |    2 +
 .../amd/display/modules/inc/mod_freesync.h    |    3 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |    1 +
 .../amd/display/modules/inc/mod_info_packet.h |    2 +-
 .../display/modules/info_packet/info_packet.c |  122 +-
 .../include/asic_reg/dcn/dcn_3_0_0_offset.h   |  129 ++
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |  600 ++++++
 .../include/asic_reg/dcn/dcn_3_0_2_offset.h   |  112 +
 .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  | 1907 +++++++++++++++++
 .../include/asic_reg/dcn/dcn_3_0_3_offset.h   |  111 +
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  |  941 ++++++++
 .../include/asic_reg/dcn/dcn_3_1_2_offset.h   |  109 +
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |  548 +++++
 .../include/asic_reg/dcn/dcn_3_1_4_offset.h   |  108 +
 .../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h  |  544 +++++
 .../include/asic_reg/dcn/dcn_3_1_5_offset.h   |  111 +
 .../include/asic_reg/dcn/dcn_3_1_5_sh_mask.h  |  548 +++++
 .../include/asic_reg/dcn/dcn_3_1_6_offset.h   |  111 +
 .../include/asic_reg/dcn/dcn_3_1_6_sh_mask.h  |  546 +++++
 .../include/asic_reg/dcn/dcn_3_2_0_offset.h   |  109 +
 .../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h  |  544 +++++
 .../include/asic_reg/dcn/dcn_3_2_1_offset.h   |  124 +-
 .../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h  |  548 +++++
 179 files changed, 21627 insertions(+), 179 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h

--
2.54.0

