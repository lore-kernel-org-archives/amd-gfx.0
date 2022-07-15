Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0108C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761AF10FB99;
	Sat, 16 Jul 2022 14:36:07 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9395B10E275
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXC2RaGULXUJo1J5sYX6dDo7SePobqeY4RM7Xd0JWX5pQEA940m7qKaoAdXaEJL5J3xq2IUoPWc6oAPWacm+VxOlDaOFg6k7uBiDwFbwkT8y/yXGd5YgIMNp/y+DPBqTA9BGxuwec2dxJ9MSmQVvLuDDR/dCNZoGnb4nyi67Lt+p63qn5pZWlnlmSCNd2o2HQKWc6CgR36YqEUMkLZhdM1XREkHEg5UeqM1a2F061t25BEkdfsrefe8HguhpG8nWnTY+pVd5CAF1pdUvuFj4cOegehhTJ2vKh+4Ot9ZtBefRon6VlZJOW44VWvLq4wI0P33N0B5G1eGoIOBblWkVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50GOR4BbSi/a+dNldf7LI05lDAHL2o/VWrv4AgsSsu0=;
 b=KH8ggRBJajoXQeNKj2b/Kw1N8tUtSNnHGUmM1Ri0xNamu146R+bI3YfUKyG9cFV4Wg45ja0FlL+88tJMPQJ4+FurSGMqF/SuAKmT6LF0UfQwhx2Ot45EDsoa2cWMmMfNxZ0PTpTBAgeCo0uzw8GpEOyvFc6mqVX4soDmOCkuT8fYV+vr3XDGa4P5v65yjVLMfCUdRRoEj9j+fsY7VrtlNLaQeNWvWoXVqohH1n++/soFFqbE3+l6t2pLs3AETMWVmbDgspIxn9YzzU9AAbdecm9/T+bIvLdr8HnuDDRhi0FPk9ewP91IDjf80ByaYaA5M3oBeWHDPr5Pwp0AT5UIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50GOR4BbSi/a+dNldf7LI05lDAHL2o/VWrv4AgsSsu0=;
 b=GxLv8t1RemFAkKgb8v3rNF/hDcowoA1dJP7awxA+i9KR4aTkQLMbFafe6IwIWViiNZBuSZqmOqmi7yPx4CbCDYuStK/IrK8UxfX6oyHfkkhJHKgCA0vwhTdEDsL/v1X4tdKc5cJ6ZQZ5ZYfIOmTIIENwxAPfCttyig2biV31FXE=
Received: from MW4PR03CA0296.namprd03.prod.outlook.com (2603:10b6:303:b5::31)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 18:17:03 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::45) by MW4PR03CA0296.outlook.office365.com
 (2603:10b6:303:b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:02 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/31] DC Patches July 15, 2022
Date: Fri, 15 Jul 2022 14:16:34 -0400
Message-ID: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa1dd89d-eb28-4672-013e-08da668e379e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4500:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mR9w9Hwy8oNBH0aq1OVUItAhGFhaxOTpcLsvUwJV/VmjFQ3fafQ2SHrP4+EiGzZlyIsvv/2J0YhPJ75amFXHJUNN9ot0Co4E/jW7iN1FkHNdxynO9Q85n/1DtnHg43xaYzxkQkZ2ZY5xFg+kR6+lMUZgnFzzC6AKWR4LleqJ1/1YNmleVCgB602eLrsPm0p5FwwTeChTjtDKJdlU2YvR4UDKWjw2lFCJQR2yjJ1Uw8ud9fV3y1vmky6WkYpD0O3lvKcELvx/zEG16h22Uk6odjpoUgrAufCEwEbIDQzeVif9JxgfL9+jy740QyPcc2KE6Z7lIHps2YN7rVpDgA1KBTaBKh3aJvoYDXjAOJ3vPSWzZzvVU0tMSylzuke9PVyHFiE66ProHbOvhLYISq1XZin2aGncKwM/yn7nkuaWeDUGyD4LZTs2sBQ3gAnYLu8Gupuau130xKlOhsvqlHSc7m4ck0ptKiuZ/Kg7w4VupeEAtCB6wJOV2OUsQZvIjLldn2cFFuSNfQ5uRJJK4TJdBmf6AUObqXhTzjF3QOA7UvbsZH9E4OahayJgagagLzzwTzyW8HUWb2hk4CzwrIAJM++p6tLYFV8vwXcCsqMy2CJVrNOgdSTZaWNBamQ1GWrZ4NOGitg+vg6YOJpSLV9Fnj6bOE8nml0qwvXWepgkkSazpTeZcDSn/dqTUDOpj+poskKGC+xVjyMsG3ZuC5GNeCqMoqB1W1kVYKVb3lze3WGQft+lJDEYj1Wy44VsM7CmIt8DEoYsStTn5EnBgLdFdJ07u+nXrMNvENnG7Z0Gi+fR89qWaCl7qIBENgsKiQ37vZE7JMI/tgWUbbGEXuNbslECdv9vQbJHQIA2g15f0CA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(36840700001)(40470700004)(46966006)(70206006)(40480700001)(8936002)(5660300002)(83380400001)(186003)(81166007)(478600001)(70586007)(86362001)(36860700001)(2616005)(4326008)(6666004)(336012)(426003)(47076005)(54906003)(356005)(82740400003)(6916009)(26005)(1076003)(36756003)(40460700003)(8676002)(41300700001)(82310400005)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:02.8962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1dd89d-eb28-4672-013e-08da668e379e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Isolate FPU operation for DCN32/321 under the DML folder
- Create a specific file for CRTC and plane based on amdgpu_dm
- Fix DSC issues
- Updates tp DML logic

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alvin Lee (2):
  drm/amd/display: Update in dml
  drm/amd/display: Don't set dram clock change requirement for SubVP

Aric Cyr (1):
  drm/amd/display: 3.2.195

Chris Park (1):
  drm/amd/display: Update Cursor Attribute MALL cache

Jun Lei (2):
  drm/amd/display: Remove unused variable
  drm/amd/display: Update DML logic for unbounded req handling

Rodrigo Siqueira (16):
  drm/amd/display: Create a file dedicated to planes
  drm/amd/display: Create a file dedicated for CRTC
  drm/amd/display: Fix hard hang if DSC is disabled
  drm/amd/display: Drop FPU flags from dcn32_clk_mgr
  drm/amd/display: Move populate phaton function to dml
  drm/amd/display: Move predict pipe to dml fpu folder
  drm/amd/display: Move insert entry table to the FPU code
  drm/amd/display: Move phanton stream to FPU code
  drm/amd/display: Move SubVP functions to dcn32_fpu
  drm/amd/display: Move wm and dlg calculation to FPU code
  drm/amd/display: Move dlg params calculation
  drm/amd/display: Move ntuple to insert entry
  drm/amd/display: Move bounding box to FPU folder
  drm/amd/display: Drop FPU flags from dcn32 Makefile
  drm/amd/display: Create dcn321_fpu file
  drm/amd/display: Drop FPU code from dcn321 resource

Taimur Hassan (2):
  drm/amd/display: Update de-tile override to anticipate pipe splitting
  drm/amd/display: Loop through all pipes for DET allocation

Vladimir Stempen (1):
  drm/amd/display: Disable GPUVM in IP resource configuration

Wayne Lin (5):
  drm/amd/display: Support vertical interrupt 0 for all dcn ASIC
  drm/amd/display: Expose function reset_cur_dp_mst_topology
  drm/amd/display: fix trigger_hotplug to support mst case
  drm/amd/display: Add is_mst_connector debugfs entry
  drm/amd/display: Add tags for indicating mst progress status

Wenjing Liu (1):
  drm/amd/display: remove number of DSC slices override in DML

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |    8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2557 +++--------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   20 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  463 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   51 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  114 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   13 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 1637 +++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   73 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   25 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   81 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |    3 +
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   28 -
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |   40 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |    3 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 2039 +------------
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   15 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  130 +-
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |   25 -
 .../amd/display/dc/dcn321/dcn321_resource.c   |  649 +----
 .../amd/display/dc/dcn321/dcn321_resource.h   |    3 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |    4 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 2244 +++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   74 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |   64 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   70 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   10 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  684 +++++
 .../amd/display/dc/dml/dcn321/dcn321_fpu.h    |   38 +
 .../amd/display/dc/dml/display_mode_structs.h |    1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |    2 +
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |   14 +-
 .../dc/irq/dcn303/irq_service_dcn303.c        |   19 +
 36 files changed, 6035 insertions(+), 5189 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h

-- 
2.37.0

