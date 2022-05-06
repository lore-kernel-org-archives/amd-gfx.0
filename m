Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB06910E489;
	Fri,  6 May 2022 15:42:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0368310E489
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIpLVl9pgYGqCcmgagD0/LSkCwsfkQHlPuszWtlcB/fKrmcpMUUpystqqEXmwJZL1ZcMi1of5mZnnCK53ouISfPZIpCAVEXEF1qHaaPHrAV24F6/pBbYQznLRcUmZbB3AZYAsETq+OfLTrW7hsDPZRuCNtrIAC45BYYiHWS+43z02MeEOTHIgJMzD3FsOrng/YxjHGIUyePR8oFntsQgDuHd4lYh2d88w9KG584jYCViSIMnq8m2k6nZfZB3edUdqTmPJZpBQ5wy7uMV6dg9twtCpjh86oresKpBT92yuLceyT0B6PP5cdfwEilhvPYIcBKdXN+EJfRD0enTtrK3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6EMrx6eqlVRzW0hfbEOsIXX2WqPLTpuDWlOxPEUr8A=;
 b=FLsuBnebKQv53H6aG4LndAGtZZkD8nAg1+1PvRZjpI2E6hB4HY9t9RHHF9p2jV/Eguc/+I3FTXi45MAZczVKyC3slmLCu9xODI/0qXDo+K+1aRyK8z2Ax5ZiAfsu9IM7O4NX8mzM1710yArCcdIovxlur/oINdrawuORf29sHcLtOK+wWFMyE84aRD9mCqfj1ZVqFcSaP61YRMacO50Uvkjk50NpVzMBMZNe75b3IppuxO9ogJT3D2O9NCkeFqXiKTyYMwxOwh3OPe1XzUduPLdFTFmNY6f6/eJBYPkIfgOFtxV7p9z8Gno9gBSJV/BV0eqmTtx9CabKdk0bHbrWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6EMrx6eqlVRzW0hfbEOsIXX2WqPLTpuDWlOxPEUr8A=;
 b=YthWmg/k2CKFDA13N4Iooduwi5SX9uSmky1LTuT42TXMKrzTKzwdSebj9til+1EZVjLGZUU1cf93Df3fYqs39OoBwhpD+rTQGVRGKtcMw9iK/Lp9zPi4IDIJ0z2X6N3dZp7fHT1iuVnG4BULK/5sf86K9JWYpqCO2qJ0ZUyAmt4=
Received: from MW4PR03CA0073.namprd03.prod.outlook.com (2603:10b6:303:b6::18)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 15:42:48 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::2b) by MW4PR03CA0073.outlook.office365.com
 (2603:10b6:303:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 6 May 2022 15:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:42:47 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:42:42 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/15] DC Patches May 9, 2022
Date: Fri, 6 May 2022 23:41:59 +0800
Message-ID: <20220506154214.3438665-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96230c1a-8054-4f40-9518-08da2f7711c1
X-MS-TrafficTypeDiagnostic: DM8PR12MB5496:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5496E8B244794466B425E10DFFC59@DM8PR12MB5496.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wCrxXnMZeU6+cPEBgxwbaYzBSMKwHGqR8s0803BpdwgBJnKAcynTE6DfiK8dAs+Jk8lQmobCSohXcsYcd21+qvcMbmUIPLVYVY1eSAN7KG1DaD9bw9z9+t8Qzwfe4m5CiWJGm4FssFp9oOB3XBU773lyiIW2HdyqEBp2cpYKWEKY6TKtUugTsOJK4Q/lM4QSnLN7gR7FSvsgFz3bESlBf/TVzjRUzsGTjvpEZoUsexo7aQTRxkRIks31LKoA2aBkwPHX3S/29FumeszwG0N54KJXHthnRvcR/84Nkp4GoSRF8h8t4p23nLTKlCxCI/1sftBNi/O/EgwAODV0U/n8WfOWDAVBq2ZCw9Lam070ycm5FnYOeYc/NoXHmyYgDjqDKxdwUv0B4eIFkfkJwS9KKvbF5B9kwMTWK2ZSjfLYXvxjYUrRmJ+/WIKImfAGNAOCbQkqtMNJ8/QXd1XVNiNybLHd/jlfhj/l7mbCfipBQL7jy5NlkGmiiecnXdYAiYLZ7J40sQDlivziiAeGA6KLIpmtXvVsu8ql2V1c+QTAT6s2jDmxGPJf4PrQ8FtFDuyEymy/K/qutpltbvU5iS/tyRst4OH4JtrpF068GRh71TY7Qxk3OlarkykbaiWrEkwtkzlOS5Ta4WWQeZooj/BK38tXPD+b5X+HfmUsva2yMFD6wlUOqGVwS3WpjZ5115fpygyXgZcRNgpR/gnhPCdig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(2906002)(36756003)(40460700003)(6916009)(8676002)(82310400005)(426003)(86362001)(508600001)(186003)(336012)(16526019)(70206006)(81166007)(70586007)(5660300002)(44832011)(4326008)(356005)(6666004)(83380400001)(36860700001)(316002)(7696005)(1076003)(54906003)(26005)(2616005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:42:47.0140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96230c1a-8054-4f40-9518-08da2f7711c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
    - Refactor LTTPR code
    - Fix PSR after hibernate
    - Fix DC build errors
    - Fix IRQ unregister error when unloading amdgpu
    - Improve DP link training
    - Fix stutter
    - Remove redundant CONFIG_DRM_AMD_DC_DCN guards
    - Fix 2nd connected USB-C display not lighting up

---

Alan Liu (1):
  drm/amd/display: do not disable an invalid irq source in hdp finish

Alex Hung (7):
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in dc
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in dce
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in gpio
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in irq
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN for z10
  drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN in amdgpu_dm
  drm/amd/display: remove unnecessary else by CONFIG_DRM_AMD_DC_DCN

Aric Cyr (1):
  drm/amd/display: 3.2.185

Evgenii Krasnikov (1):
  drm/amd/display: Reset cached PSR parameters after hibernate

Josip Pavic (2):
  drm/amd/display: move definition of dc_flip_addrs struct
  drm/amd/display: do not wait for vblank during pipe programming

Michael Strauss (1):
  drm/amd/display: Refactor LTTPR cap retrieval

Stylon Wang (1):
  Revert "drm/amd/display: Fix DCN3 B0 DP Alt Mapping"

Wenjing Liu (1):
  drm/amd/display: do not calculate DP2.0 SST payload when link is off

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  46 +----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 -
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   6 -
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   2 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 -
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   3 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   4 -
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 -
 .../display/dc/bios/command_table_helper2.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  41 +---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 179 ++++++++++--------
 .../drm/amd/display/dc/core/dc_link_dpia.c    |   2 -
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  25 +--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  12 --
 drivers/gpu/drm/amd/display/dc/dc.h           |  51 +----
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  16 ++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  15 +-
 .../drm/amd/display/dc/dce/dce_clock_source.h |  12 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  10 -
 .../amd/display/dc/dce/dce_stream_encoder.c   |  21 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   1 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   6 -
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 -
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |   3 +-
 .../display/dc/gpio/dcn30/hw_factory_dcn30.c  |   2 -
 .../display/dc/gpio/dcn30/hw_factory_dcn30.h  |   2 -
 .../dc/gpio/dcn30/hw_translate_dcn30.c        |   2 -
 .../dc/gpio/dcn30/hw_translate_dcn30.h        |   2 -
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   4 -
 .../drm/amd/display/dc/gpio/hw_translate.c    |   4 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  17 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |   3 +-
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |   3 -
 .../display/dc/irq/dcn30/irq_service_dcn30.h  |   3 -
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   5 -
 .../amd/display/include/link_service_types.h  |   6 +
 42 files changed, 161 insertions(+), 391 deletions(-)

-- 
2.35.1

