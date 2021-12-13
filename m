Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F70C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D9510EB69;
	Mon, 13 Dec 2021 03:52:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C6C110EB69
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJs8mj2FDKwRyV5d09SyOyg8E0NksRQ2WRHzhFKY/gxJdshlU8vp8thrzsmLWP3Ze15VilMY1ceHO3PadSqF3vbzQ/SuA106RJi/CefT4k8Ab2T7DSBG+OJJZqW8snay4eKzjXfz0bNhHZGeDI5+IfKuZWaVR4ddHtWRkdkWt8IvbF+tZu3pvvGJscRjYl7FhU6pWiek9Oo78eT614Ie5kHAJuy/wcCnlzV+QyybzVsoeABUuu0v0na+9dtPxPi8V04eylxY5JBKf1lNIU3YcgFMNwaKzkctJSlksWohJTASZhNo+bNd+Co0VYuHOHPzJlenUC/NUyjYKXq0wbzqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j6ZLIk9IvognLIeSfjlK594BKVsCKcGOHBP3oRsHe8=;
 b=OiS58NPtWIykwmiNITLBWQJtoQrDSbmV3KynU7HInlVy3Ghn2MaeSIjO32WPDCilLSskRph+BW796LXV1X8LCdidza/jT5QCvN2/6jhoCU6PzhlFfd0s6sM+7Fn9udK7SbGDTQmDkM157IdamFY7aCSpC7nMQ3GkR8+S3nGzdquOH+kT++cvcgXFsqeAHPLOD5S6Krv1HzmEZieb7l9LLShZvMQgM2mWcZz/jpsctdSTBwurZ1h3vl680ojlBt0rzA/T+slAVs5hNszYe1+SZqljH6crPfk4l1noiTodY2lGRFIs+0MmBZHvcOmvCx+6OFSv1nV1BnQYbnmxVuWqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j6ZLIk9IvognLIeSfjlK594BKVsCKcGOHBP3oRsHe8=;
 b=MqwO+4ysz2vP9mfOAX5Mm4knPjoY/8OJJvs9jsV3Rr+KqDZc8lPSkb02jtOBCdNjDb6Lnbob3UkB/7aGo0B966TtX73fI4LEaL/GRfCR7kNV5oE554rWgg7Tj1qkVg1EweEsYyVtBkzCk4JHXrJ0HD4Fhal38Aoglbnbyy8ks6k=
Received: from DM5PR07CA0036.namprd07.prod.outlook.com (2603:10b6:3:16::22) by
 BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 13 Dec
 2021 03:52:43 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::37) by DM5PR07CA0036.outlook.office365.com
 (2603:10b6:3:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Mon, 13 Dec 2021 03:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:52:42 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:52:40 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 00/16] Unified entry point for other blocks to interact
 with power
Date: Mon, 13 Dec 2021 11:52:07 +0800
Message-ID: <20211213035223.772700-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d741418f-f2f9-4859-6bde-08d9bdec03ef
X-MS-TrafficTypeDiagnostic: BN9PR12MB5226:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5226669841FFDA1069D54CD0E4749@BN9PR12MB5226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUGgqtNbh6jeewh3nG5TrEy955mO6TM2SyJZFfR/Tyx9GWMdiKAitdx4z3HOkzIwP6KYUcoRZtl49P/9LxbHY+GnLXv1xYoltyR9dlB07jSIMlUtEwZ5l0lOUJvFP7krtTRbacCmFjU1cttbTSULJ6raEwQM/o+cr4UuhznEe4aq8YQjOnGlbochGWA2tgMUtuca/kLe2jVWbB0pKmDltSeWHC2jRo1ukCCWMiRx/rEhV8xDAob3xTlNcS8AnbLszvIgvaCCL9Oug5QWzljJVUbIYVNVLo4OcZr/wrH8AuEvruFhiCTuR4gf5QTsTxy8BZRfGrYMPmHsFNypGTKVxMonkrwBlzC41ovrkz2If3JeG7xCW5N5oUOhL4/woC17tsh1yyxMwDHJMz3WzjloiNT5KXdJ3PXlgZHQSFCxmAxbnBBDXuDwQFTiDYboR2jvuIav/z8OcnvuYj+J4C2kp3rVc8w5Bpr/+Gvrtn3J/CwvhsolnGuLvSzI+zsRIJocm+slnBtiC5MM6/fn1/proDoE/CAhZpPftoBIj6eNq0aaAHnT8WTwvANY+ZMfdaHFrb2mGVZODsqBsS5MNi34t9U9PkMfnu2n9NiYpueV4VUusdOrBfHfUBmxlaWhsqJIQmhJUru06+ZMlkTU8FFbudnQA8m9UkzOaaeF5ds3zRNLwhlbH3gRPatryS1C16AdfPL9RAlzhQ5pHPn6QC/jMUUC9sLf2RdEfqx6W8ucYZN5OrIH+0bUInDS0PUeQEgaxizRoXhXLZQkO07YrDWkVB8GsjWBVSu/NDDJgVEpMsE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(4326008)(70206006)(16526019)(336012)(36756003)(47076005)(83380400001)(2906002)(6916009)(30864003)(508600001)(8936002)(6666004)(86362001)(44832011)(26005)(8676002)(186003)(70586007)(1076003)(316002)(426003)(356005)(54906003)(7696005)(81166007)(40460700001)(36860700001)(2616005)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:52:42.4808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d741418f-f2f9-4859-6bde-08d9bdec03ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are several problems with current power implementations:
1. Too many internal details are exposed to other blocks. Thus to interact with
   power, they need to know which power framework is used(powerplay vs swsmu)
   or even whether some API is implemented.
2. A lot of cross callings exist which make it hard to get a whole picture of
   the code hierarchy. And that makes any code change/increment error-prone.
3. Many different types of lock are used. It is calculated there is totally
   13 different locks are used within power. Some of them are even designed for
   the same purpose.

To ease the problems above, this patch series try to
1. provide unified entry point for other blocks to interact with power.
2. relocate some source code piece/headers to avoid cross callings.
3. enforce a unified lock protection on those entry point APIs above.
   That makes the future optimization for unnecessary power locks possible.

Evan Quan (16):
  drm/amd/pm: do not expose implementation details to other blocks out
    of power
  drm/amd/pm: do not expose power implementation details to amdgpu_pm.c
  drm/amd/pm: do not expose power implementation details to display
  drm/amd/pm: do not expose those APIs used internally only in
    amdgpu_dpm.c
  drm/amd/pm: do not expose those APIs used internally only in si_dpm.c
  drm/amd/pm: do not expose the API used internally only in kv_dpm.c
  drm/amd/pm: create a new holder for those APIs used only by legacy
    ASICs(si/kv)
  drm/amd/pm: move pp_force_state_enabled member to amdgpu_pm structure
  drm/amd/pm: optimize the amdgpu_pm_compute_clocks() implementations
  drm/amd/pm: move those code piece used by Stoney only to smu8_hwmgr.c
  drm/amd/pm: drop redundant or unused APIs and data structures
  drm/amd/pm: do not expose the smu_context structure used internally in
    power
  drm/amd/pm: relocate the power related headers
  drm/amd/pm: drop unnecessary gfxoff controls
  drm/amd/pm: revise the performance level setting APIs
  drm/amd/pm: unified lock protections in amdgpu_dpm.c

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |    7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |    5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |    2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  248 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    2 -
 .../gpu/drm/amd/include/kgd_pp_interface.h    |    8 +
 drivers/gpu/drm/amd/pm/Makefile               |   14 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 2467 ++++++++---------
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  |   94 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  552 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  341 +--
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |   32 +
 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    |   32 +
 .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |    0
 .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |   47 +-
 .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |    0
 .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |    0
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 1081 ++++++++
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h    |   38 +
 .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |    0
 .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |    0
 .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  163 +-
 .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |   15 +-
 .../amd/pm/{powerplay => legacy-dpm}/si_smc.c |    0
 .../{powerplay => legacy-dpm}/sislands_smc.h  |    0
 drivers/gpu/drm/amd/pm/powerplay/Makefile     |    4 -
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   51 +-
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   10 +-
 .../pm/{ => powerplay}/inc/amd_powerplay.h    |    0
 .../drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h |    0
 .../amd/pm/{ => powerplay}/inc/fiji_ppsmc.h   |    0
 .../pm/{ => powerplay}/inc/hardwaremanager.h  |    0
 .../drm/amd/pm/{ => powerplay}/inc/hwmgr.h    |    3 -
 .../{ => powerplay}/inc/polaris10_pwrvirus.h  |    0
 .../amd/pm/{ => powerplay}/inc/power_state.h  |    0
 .../drm/amd/pm/{ => powerplay}/inc/pp_debug.h |    0
 .../amd/pm/{ => powerplay}/inc/pp_endian.h    |    0
 .../amd/pm/{ => powerplay}/inc/pp_thermal.h   |    0
 .../amd/pm/{ => powerplay}/inc/ppinterrupt.h  |    0
 .../drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h |    0
 .../drm/amd/pm/{ => powerplay}/inc/smu10.h    |    0
 .../pm/{ => powerplay}/inc/smu10_driver_if.h  |    0
 .../pm/{ => powerplay}/inc/smu11_driver_if.h  |    0
 .../gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h |    0
 .../drm/amd/pm/{ => powerplay}/inc/smu71.h    |    0
 .../pm/{ => powerplay}/inc/smu71_discrete.h   |    0
 .../drm/amd/pm/{ => powerplay}/inc/smu72.h    |    0
 .../pm/{ => powerplay}/inc/smu72_discrete.h   |    0
 .../drm/amd/pm/{ => powerplay}/inc/smu73.h    |    0
 .../pm/{ => powerplay}/inc/smu73_discrete.h   |    0
 .../drm/amd/pm/{ => powerplay}/inc/smu74.h    |    0
 .../pm/{ => powerplay}/inc/smu74_discrete.h   |    0
 .../drm/amd/pm/{ => powerplay}/inc/smu75.h    |    0
 .../pm/{ => powerplay}/inc/smu75_discrete.h   |    0
 .../amd/pm/{ => powerplay}/inc/smu7_common.h  |    0
 .../pm/{ => powerplay}/inc/smu7_discrete.h    |    0
 .../amd/pm/{ => powerplay}/inc/smu7_fusion.h  |    0
 .../amd/pm/{ => powerplay}/inc/smu7_ppsmc.h   |    0
 .../gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h |    0
 .../amd/pm/{ => powerplay}/inc/smu8_fusion.h  |    0
 .../gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h |    0
 .../pm/{ => powerplay}/inc/smu9_driver_if.h   |    0
 .../{ => powerplay}/inc/smu_ucode_xfer_cz.h   |    0
 .../{ => powerplay}/inc/smu_ucode_xfer_vi.h   |    0
 .../drm/amd/pm/{ => powerplay}/inc/smumgr.h   |    0
 .../amd/pm/{ => powerplay}/inc/tonga_ppsmc.h  |    0
 .../amd/pm/{ => powerplay}/inc/vega10_ppsmc.h |    0
 .../inc/vega12/smu9_driver_if.h               |    0
 .../amd/pm/{ => powerplay}/inc/vega12_ppsmc.h |    0
 .../amd/pm/{ => powerplay}/inc/vega20_ppsmc.h |    0
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   94 +-
 .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |   16 +-
 .../inc/interface}/smu11_driver_if_arcturus.h |    0
 .../smu11_driver_if_cyan_skillfish.h          |    0
 .../inc/interface}/smu11_driver_if_navi10.h   |    0
 .../smu11_driver_if_sienna_cichlid.h          |    0
 .../inc/interface}/smu11_driver_if_vangogh.h  |    0
 .../inc/interface}/smu12_driver_if.h          |    0
 .../interface}/smu13_driver_if_aldebaran.h    |    0
 .../interface}/smu13_driver_if_yellow_carp.h  |    0
 .../inc/interface}/smu_v11_5_pmfw.h           |    0
 .../inc/interface}/smu_v11_8_pmfw.h           |    0
 .../inc/interface}/smu_v13_0_1_pmfw.h         |    0
 .../inc/message}/aldebaran_ppsmc.h            |    0
 .../inc/message}/arcturus_ppsmc.h             |    0
 .../inc/message}/smu_v11_0_7_ppsmc.h          |    0
 .../inc/message}/smu_v11_0_ppsmc.h            |    0
 .../inc/message}/smu_v11_5_ppsmc.h            |    0
 .../inc/message}/smu_v11_8_ppsmc.h            |    0
 .../inc/message}/smu_v12_0_ppsmc.h            |    0
 .../inc/message}/smu_v13_0_1_ppsmc.h          |    0
 .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |    0
 .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |    0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |    0
 .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |    0
 .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |    0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |    0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |    0
 .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |    0
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   10 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |    9 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   34 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   11 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   10 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   15 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |    4 +
 117 files changed, 3232 insertions(+), 2264 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
 create mode 100644 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
 create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/cik_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.c (99%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_smc.c (100%)
 create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
 create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/r600_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c (98%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.h (99%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_smc.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/sislands_smc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/amd_powerplay.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/fiji_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hardwaremanager.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hwmgr.h (99%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/polaris10_pwrvirus.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/power_state.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_debug.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_endian.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_thermal.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/ppinterrupt.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu11_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_common.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_fusion.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8_fusion.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_cz.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_vi.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smumgr.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/tonga_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega10_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12/smu9_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega20_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h (98%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_arcturus.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_cyan_skillfish.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_navi10.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_sienna_cichlid.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_vangogh.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu12_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu13_driver_if_aldebaran.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu13_driver_if_yellow_carp.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v11_5_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v11_8_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v13_0_1_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/aldebaran_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/arcturus_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_0_7_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_0_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_5_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_8_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v12_0_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v13_0_1_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_11_0_cdr_table.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_pptable.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_pptable.h (100%)

-- 
2.29.0

