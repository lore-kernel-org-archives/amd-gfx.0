Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF62C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4F76EEAC;
	Tue, 30 Nov 2021 07:43:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3FB6EEB6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymmr0KmsdmkF76SWADWUk8fgKAjYIZTFwJk6HsQFund6/9WSzDw4Sza9aMXyzIHJHnaFraB5Ik/p7TETWwbkS3uUaMhMH/tGOYQ44Df5R/tcd8BY1baoUNXIaZ4hbNwnp5HXWflOpBjabjRMy7ul0eUXl6bIKnsrepVd2vkizx5zk01ncNCtxvIy20ZkO2YdvBD/q3ssXL9N/9n3XbvIlm0MoAJekM8qQqT7vHwQbUtoNYPgr2xL9BKj+PBNSpmiEXmqB81ehSNqAfJ7Iiv8A0ibZjSoLWFNh8EycnmYeBBFDbNtWvrp9jXoAGAFChrxrIMs8q6v/Cu5td9xQVDPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJqiPZq1k5nTIwM5gOEMvmdOR0RsMXYutpBCnnRmRK8=;
 b=VTJaCSlkLK2goGifyVyDzk15l1tkGT9fb+tXrs4Z8ZFkP9QAruRjtV23BxUqaEYDWNtG0AqEWgo3vThkeqogimkXgCq5lNHHOjLY8aKmerNhKVK1f+ecDWe82rTLjyE+vvReaf5XQeKE3ugOR82EyVIvBC7WYPCONk4X35k9bT/qIJ3CQ+AiY36ZnOkzrWO7GW58GJIWHVS+DlcFMlvlnEozClpw6RxlrYNZ7U2qFUkncczqpdeVN1Mc/xn4GeavCh9XzzVZPh87aBjs07DkFDQwOIxk9xZuGei8nRcpuiHIehUQvcS1CjP/1wdB5wH2SjqR8Fd8NDgD7PgmPyJDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJqiPZq1k5nTIwM5gOEMvmdOR0RsMXYutpBCnnRmRK8=;
 b=v+2g+o395/RgV81YjTG3XkWgjPvXj1xnHMXThAVREz6rxvfYb5+KKrdRy+fpiyEw+vjUgGotN0QisPmpJPq7KkbKsvRX35n+G4uEVL7sc6hgpqppuHqBXeOWXRHgrgeYuV1E84BrMwhi/dvpTVQI6Ux1RI271PeVMXxpW1MXdBI=
Received: from BN8PR15CA0058.namprd15.prod.outlook.com (2603:10b6:408:80::35)
 by DM6PR12MB2921.namprd12.prod.outlook.com (2603:10b6:5:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 07:43:24 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::ab) by BN8PR15CA0058.outlook.office365.com
 (2603:10b6:408:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:23 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:20 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 00/17] Unified entry point for other blocks to interact
 with power
Date: Tue, 30 Nov 2021 15:42:42 +0800
Message-ID: <20211130074259.1271965-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bdee83c-8b8b-4f0e-2d0e-08d9b3d516ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB2921:
X-Microsoft-Antispam-PRVS: <DM6PR12MB292122B8F3DADF56F3CD4759E4679@DM6PR12MB2921.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHYRmvrvjH1bOWNWm5fDaBi0dzps15CnL1jPbQCG5amSrkKFySrvREUanDInOrKaFehnK6YNSIQvu9kr/GlC9c63Gxd9u36+XmcRBxcnkLeJ1z+SejEaJciv8ogd3q7qBkTplWdbOMLo+J8GGyXVqKo8QabPUfL7RLhdWb15oNUDDVT2W2WBQtxRQrBVo+R1mCBGxlky8ECYBgYJt573fnGnp0CpaKU+lVd/Pw7jL+ybFhmEjWWHOAOU3iMBy2dh4wGN/wEwU9P7bYw3KXyMVhFrQ9VMzpg/RGfpDeCxM5eGGpN5ROKqm7P3wBbZ+fFvf1zC3pw3tWLdtL8URkCCT6nummJ7PtV4m0P7crFM5v4f/0IcbZTCeerqJsZISOuOm+ntXvzw/tY1GWxg+SviE48CDssUPKb9rAW7cCrTJc5LvQCJGaCGJVwQkRjfA0D+TJ11mbGhcCFYSmQ3K5OvYoix+lNmopVsHZqPwEoeg4vxDUGEmnw9ROcyQeTN/cTPylvu4WII1zUni75XOs8AMYSFyOxeRoJUlBUa7kbeW89nt5u7M4x2CIcIp3XVSLHBIrD927SxysxKESFLJn0evgRex6rQq8vHl/X1y4VGL+vGytiPxb5bN2+o+kuv4T/WbPpBXxYSrXzFDLhaV6wRRqHnfBU7nCm6tkHGmk1d53uxgHvgpdoB44sEAAhSiCx6cAR1SUBGV7CwRUtrpL6Jd5aauCN9O/BaJu4+aI3GvPm8fiEkZMI7rzEVTMQ90ZCJ7MHZi+05MgsOHKU0SnwtHOhM/5xmXTYSs4Co8iX9FKQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(4326008)(2906002)(70206006)(7696005)(8936002)(426003)(1076003)(356005)(40460700001)(81166007)(83380400001)(36860700001)(2616005)(82310400004)(70586007)(316002)(26005)(6916009)(186003)(54906003)(6666004)(5660300002)(30864003)(47076005)(16526019)(86362001)(508600001)(8676002)(36756003)(336012)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:23.5112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdee83c-8b8b-4f0e-2d0e-08d9b3d516ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2921
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
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

Evan Quan (17):
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
  drm/amd/pm: correct the usage for amdgpu_dpm_dispatch_task()
  drm/amd/pm: drop redundant or unused APIs and data structures
  drm/amd/pm: do not expose the smu_context structure used internally in
    power
  drm/amd/pm: relocate the power related headers
  drm/amd/pm: drop unnecessary gfxoff controls
  drm/amd/pm: revise the performance level setting APIs
  drm/amd/pm: unified lock protections in amdgpu_dpm.c

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  421 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h  |   30 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |    7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |    5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |    2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  246 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   14 +
 drivers/gpu/drm/amd/pm/Makefile               |   12 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 2435 ++++++++---------
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  |   94 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  568 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  339 +--
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |   32 +
 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    |   32 +
 .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |    0
 .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |   47 +-
 .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |    0
 .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |    0
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 1510 ++++++++++
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h    |   71 +
 .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |    0
 .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |    0
 .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  111 +-
 .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |    7 +
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
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   95 +-
 .../amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h  |    0
 .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |   20 +-
 .../amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h   |    0
 .../inc/smu11_driver_if_arcturus.h            |    0
 .../inc/smu11_driver_if_cyan_skillfish.h      |    0
 .../{ => swsmu}/inc/smu11_driver_if_navi10.h  |    0
 .../inc/smu11_driver_if_sienna_cichlid.h      |    0
 .../{ => swsmu}/inc/smu11_driver_if_vangogh.h |    0
 .../amd/pm/{ => swsmu}/inc/smu12_driver_if.h  |    0
 .../inc/smu13_driver_if_aldebaran.h           |    0
 .../inc/smu13_driver_if_yellow_carp.h         |    0
 .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |    0
 .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |    0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |    0
 .../pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h    |    0
 .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |    0
 .../amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h  |    0
 .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |    0
 .../amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h   |    0
 .../amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h  |    0
 .../amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h   |    0
 .../amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h  |    0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |    0
 .../amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h  |    0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |    0
 .../amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h |    0
 .../pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h    |    0
 .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |    0
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   10 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |    9 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   34 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   11 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   10 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   15 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |    4 +
 114 files changed, 3657 insertions(+), 2671 deletions(-)
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
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c (99%)
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
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h (98%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_arcturus.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_cyan_skillfish.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_navi10.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_sienna_cichlid.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_vangogh.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu12_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_aldebaran.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_yellow_carp.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_11_0_cdr_table.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_pptable.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_pptable.h (100%)

-- 
2.29.0

