Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51985C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D597610E1B2;
	Tue, 15 Feb 2022 21:45:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF62E10E546
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCpqSHzyiBGpBGO4pIsKkevyjBFAIitVRlM7Xhx2Qdmm+D4+PNFQw3K8Hrw7B7dZax+8vmVNG4yeX//sEJMOgVnsd8NqZH4VjWW73bn3cdh/QWLq7z63PDuSxk/OJbftcj6Odfq3uYOsXyhGgqzkq2WZYLzKs5MA2qcSLiw0rpylBKcee0xlw8ZK427WTvf4UwQDNGguH2z2vXquNpI299VV2UPQjkmrMRN6SBj2HHDETpvCNup4WojEA/+ACJliknhRFNmLe2kCzgHVJe99J/UIhpb/ywo5v37ISqBUsuquiX1Lp7OWUJiz34eyufFfLwDzsbwZrGliAAUOOppNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDk5mbnB63XY5Xqn2lIMBsf8lAgQKwvS9NWdpqVgXiE=;
 b=bmYbz0qpV6Ir+tfgPZzFOlwveIugg5BMnXbyaU0/fc8RwpmZk7cOXYVUfceKsbNvfIPklZ1C1t8Wwmiep7lItHC7C5bIbeuqg8TsXEH3Qh0ja2ef6O4Ttob+KCOR50WfJn4UEEZZuJDzd0GaIFaRcSIb9lV1Svkzh1DHAyRjRpigvFPKWevsoQpMWYf+5KVGeaxTJb+GcuyScxERayVufvH6B78Niftd97yZKfrP/N0G+gmbcpdObHwGNRKYTKlbcaYPMxGD801XvMhajhmVA5p7LyRmSuW0N745PldWDHMV/D9Z1u3dYtRMjwbDiEyqAWHb/2Z+BKOCxe/RJ2PXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDk5mbnB63XY5Xqn2lIMBsf8lAgQKwvS9NWdpqVgXiE=;
 b=vblIfPNtZaskedmHlSbgBYiR0yVu38K0vdsctccivEngOZEUAF84ElVu77zrKBP9InV9drJtVmK33syfzcdjoXo0mz1FexyYC9Dpx401jnzXTQ00bzij2fHG0LttDom2G+xOgejLMY/DEv8YJ1Cor2YHtNRtsg2i0dm0k6RW9YM=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 21:45:07 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::78) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 21:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:45:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:45:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/6] Update DCN 3.1 support for 3.1.6
Date: Tue, 15 Feb 2022 16:44:43 -0500
Message-ID: <20220215214447.2234978-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf58bde6-415b-49bc-59d7-08d9f0cc6ec7
X-MS-TrafficTypeDiagnostic: LV2PR12MB5799:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5799270F2A7049FF6C8A9E4FF7349@LV2PR12MB5799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDu5VGGuHM8wYhRoNO6ddAr4H1Whaz6HXdsKqRD5fI0E6kEfLJ7Y7ORPE3EA2KaRWsEuelZ7rOSM41SY5vY3goqWRstAD6s9WzWbF51RpTjrKKkx/s7hEeD3bAcSMRU1bEj3ZhTBPHol7To/dz/bcTgk6hGky+2hpuBOP6htSNrthERu0ZZ9YuQZjuaIuJd59xXhZXAkO88FtoYBp7U3ATc9EJlFOJnu4Rj/Wp3eInvyl9UFHzfD/BQfOZHK24iRkYWNHl42jJPdbWlJ6b4Y6ss4tePhhwug0CALdoi+zoMH/wqYogQDAGqNh7EsBO05gIrbu9JvI4xwGcXqqUesJrxpZPb29eUUj5bzgLmiFSxM8upWsU4A/0o5duOZ07/ia6YbXuWlVNwivYHoD1f3KPyPb4K3Qyee03uGZGXV8MQNzEBY9a1yuBzbpBA99+m5BNvYR8p6uFVh5XZvC2MOPROcEGh+Rw7W3zZ5+M81Kztgzaoq8PJQS7s0W1wH36bGYtddptrZXFF0tF93v/ISlI5+4OP/MTzyYv+MlY+GxQyON6FSu9VvI9WG6dAyEottIXd4u6tL6LGu6Ivr1TN+W13bAx4me52Qs2z3rilWaqhse1j9aH4fFLkfEKEmiwHeMu/dzBKdc1z+LJYaxMsqiABuKXC5dSIMfmzGzFHkAmHz0PjEfdsk5NqwJQaath0tAknWavCO2AtnBrkUzLFqXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(8936002)(2616005)(40460700003)(186003)(16526019)(2906002)(4326008)(26005)(5660300002)(15650500001)(1076003)(70586007)(8676002)(356005)(81166007)(70206006)(7696005)(508600001)(6916009)(83380400001)(316002)(47076005)(36860700001)(426003)(6666004)(336012)(82310400004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:45:07.1563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf58bde6-415b-49bc-59d7-08d9f0cc6ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update DCN 3.1 for 3.1.6.  This is a minor update
to DCN 3.1 display support in amdgpu.

The first two patches are register headers so I did not
send them out due to size.

Hansen Dsouza (1):
  drm/amd/display: Add DCN316 resource and SMU clock manager

Leo Li (3):
  drm/amd/include: Add register headers for DCN 3.1.6
  drm/amd/include: Add MP 13.0.8 register headers
  drm/amd/display: Add DMUB support for DCN316

Prike Liang (2):
  drm/amd/display: configure dc hw resource for DCN 3.1.6
  drm/amdgpu/discovery: Add sw DM function for 3.1.6 DCE

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |      1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |     14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |      3 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |      1 +
 .../display/dc/bios/command_table_helper2.c   |      1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |     10 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |     16 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |    706 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.h        |     49 +
 .../display/dc/clk_mgr/dcn316/dcn316_smu.c    |    328 +
 .../display/dc/clk_mgr/dcn316/dcn316_smu.h    |    128 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |      8 +
 .../gpu/drm/amd/display/dc/dcn316/Makefile    |     56 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   2306 +
 .../amd/display/dc/dcn316/dcn316_resource.h   |     42 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |      1 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |      1 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |      1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |      1 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |      2 +
 .../drm/amd/display/dmub/src/dmub_dcn316.c    |     62 +
 .../drm/amd/display/dmub/src/dmub_dcn316.h    |     33 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |      4 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |      6 +-
 .../gpu/drm/amd/display/include/dal_types.h   |      1 +
 .../include/asic_reg/dcn/dcn_3_1_6_offset.h   |  15682 ++
 .../include/asic_reg/dcn/dcn_3_1_6_sh_mask.h  |  62717 +++++++
 .../include/asic_reg/dpcs/dpcs_4_2_3_offset.h |  11969 ++
 .../asic_reg/dpcs/dpcs_4_2_3_sh_mask.h        | 136141 +++++++++++++++
 .../include/asic_reg/mp/mp_13_0_8_offset.h    |    410 +
 .../include/asic_reg/mp/mp_13_0_8_sh_mask.h   |    603 +
 31 files changed, 231300 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn316/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_3_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_8_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_8_sh_mask.h

-- 
2.34.1

