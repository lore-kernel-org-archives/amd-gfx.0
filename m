Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B95C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D2510F890;
	Fri, 29 Apr 2022 18:02:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E929D10F891
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBu8gTofZDiaGK5NpkcuRzs1R/ZP3/6Snp1vXzpsDrHm1u0QioEpw1KaaGs+hpzcTG73BuaOx6k91O7sC2jJlJ+AxBLK4wYo49bbgsLKumOyccTN9pYenhNwowypwY5J19CE2wrJWF4rHRCdHMrSnnI/a3mt6X63Q+UgyYtIwNPAxkjglkEex3+3hf2GyhDKfIGps8w69wBMsxu+0aWgVNYXiGHodKtwKwFz/nx/LH3Gn//+f+6gS2rOif927NDhyS6BdMP+/AEIEDlXc3umXM/hLlyHaErLe+huZH3p8wW7pizTzqR7AQf0LSWWhiRbD2MKieJhBIpShXSx9fEPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyiMcTOifKGYpNuFgRTJDboLdtHyzB9oMsdh45EY3AQ=;
 b=CXZAyrlMx+LjfvI/9rvbkKlU/HREmpYJkjh9GlOMAMBwH4Qb7IO4JMR19xq4tPadAQcZYg5Da1zh0/cS0ogPi0ESbjg9gkwJUOuGiFONBTJ6013KLrg7DcW7+9tIugnRYmgWEKuYF5l02U743QFvinU7aJ45+IKzEeBtuuHIaWjCJwkqfYngi3slVsSY9C5+nQUMiaYOghVuwmPy34AlewA/0lF7NfCnRcyppaN4AYTINPMveyY226ubFtDC5RKprSTMf7WjQUCAGslQOuEaTMYPNFC1cW0RHM9ICubTj7Ab8KO0U/pbRJvWskXoEv0Ddb362KWVJc8jsqUm4pU2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyiMcTOifKGYpNuFgRTJDboLdtHyzB9oMsdh45EY3AQ=;
 b=IV7xX0fwl3u+cUKLpJ04yCwsugNZ2jfDJcj3+BuE4/sDTfPfkzYZhZgptPxFNnwRx6ilq0VV/bHpDHzkVxNwjMYr6tpQRMqWAjl3OyfsJfzVBHoItJIGn/U/cj1/sfOqBhoujgOIgSsQPtE/0RttP8wCw3Z6esSg/9CtgTk4edA=
Received: from MW2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:907::46) by
 BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 18:02:39 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::33) by MW2PR16CA0033.outlook.office365.com
 (2603:10b6:907::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/29] Add support for GC 11.0
Date: Fri, 29 Apr 2022 14:01:57 -0400
Message-ID: <20220429180226.536084-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ea5ad0-b49f-460e-b9c0-08da2a0a732f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4195:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4195D396CA06E63F6D5AE1FDF7FC9@BY5PR12MB4195.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vCH6sqNk6o92dWYZRS1n7IRPYEjFukJmSnTJlBLOl+g21Xi9eP6N3GOBkh23EyG0CSTvUPhtA7IPIgxrwC9OoJaCSxAGniY2Emv8G9NQOJS4z96YHuA8mJbeIGrB0h1iOjOHJel3yoqYkKbN3SZWVQ0aGvOHzllV+NjDu2qszY0LDRhD7pGHgZnhfHcrseWr5IoX4mQeRzAoAhxNYc0EYL90oA6U8ed7OGLmOh20OHMkbFHN6uCu1JzUOsc77OdUhQGvrY2g3fAdvCyjxyAweLlaW5W4k3eF7Mg+UEiJYLn+ANUYZvJKu/C5LsdiiWcrnhN1M9MWYh4cOQN2Znv8POt5B535XOQhvEBOCvg+vDyEiDfHpher+Z2Hjz351fU+ELl7HjMRllPPXxOj/N2XI6CQMNRFhYUXwtLh1x/Alg+z+ENEMOanSeYFR3/TfDzkl2o3K9DaR89X3yzgntKH1MCN98fGDomxSckrteUQSDDtZNDPytSxp9VE6zizis1FrVKbIOHGdXVUGFjzLx4ccjLg8ARVDzIvlJUbme5j+kEL7qn+jQxYNve6N26lYyrbtnpYODxItSWHI3qXRVOabCg01sLSsZhPrpmsiUkTyiWMgzfcqgYHbfoKVFkl+5pDLiNqQnoxtekql3IoDn3nAPrj5evCEypjZmZyIjG04x4GL6v7mvWvFbNhw3NtENY7PaKT2rUcBj9fU/1gzGzxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(426003)(336012)(47076005)(83380400001)(70586007)(70206006)(4326008)(8676002)(40460700003)(2616005)(36860700001)(186003)(316002)(1076003)(16526019)(6916009)(2906002)(26005)(86362001)(6666004)(36756003)(82310400005)(5660300002)(356005)(7696005)(8936002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:39.5018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ea5ad0-b49f-460e-b9c0-08da2a0a732f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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

This patch set adds GFX and KFD support for GC 11.0.  GC11 uses MES
for engine management and has a new microcontroller, IMU, which
handles power management for the block.

Alex Deucher (2):
  drm/amdgpu/discovery: handle AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO in SMU
  drm/amdgpu/discovery: add MES11 support

Chengming Gui (2):
  drm/amd/amdgpu: adjust the fw load type list
  drm/amd/amdgpu: add more fw load type to fit new ASICs

Evan Quan (2):
  drm/amdgpu: enable GFX CGCG/CGLS for GC11.0.0
  drm/amdgpu: enable fgcg for soc21

Hawking Zhang (2):
  drm/amdgpu: add init support for GFX11 (v2)
  drm/amdgpu: enable GENERIC0_INT for gfx/compute pipes

Jack Xiao (6):
  drm/amdgpu: add new CP_MES ucode ids
  drm/amdgpu: correct cp doorbell range
  drm/amdgpu: add mes unmap legacy queue routine
  drm/amdgpu/mes11: initiate mes v11 support
  drm/amdgpu/gfx10: enable kiq to map mes ring
  drm/amdgpu/gfx11: enable kiq to map mes ring

Likun Gao (14):
  drm/amdgpu: support RLCP firmware front door load
  drm/amdgpu: support RLCV firmware front door load
  drm/amdgpu: support for new SDMA front door load
  drm/amdgpu: support IMU front door load
  drm/amdgpu: add convert for new gfx type
  drm/amdgpu: init SDMA v6 microcode with PSP load type
  drm/amdgpu: extend the show ucode name function
  drm/amdgpu/gfx: refine fw hdr check fuction
  drm/amdgpu: skip amdgpu_ucode_create_bo for backdoor autoload
  drm/amdgpu: fix the fw size for sdma
  drm/amdgpu: renovate sdma fw struct
  drm/amdgpu: support RS64 CP fw front door load
  drm/amdgpu: support imu for gfx11
  drm/amdgpu/discovery: add GFX 11.0 Support

Mukul Joshi (1):
  drm/amdkfd: Add KFD support for soc21 v3

 drivers/gpu/drm/amd/amdgpu/Makefile           |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   15 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  625 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h       |   51 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  335 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   85 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   51 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |  140 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |   35 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   22 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 6342 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h        |   29 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    7 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  286 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.h        |   30 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |  175 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 1181 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.h        |   29 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |    4 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |    8 +-
 drivers/gpu/drm/amd/amdkfd/Makefile           |    3 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |    8 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   24 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  299 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |    5 +
 .../amd/amdkfd/kfd_device_queue_manager_v11.c |   81 +
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     |   56 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  383 +
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |    8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   10 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  508 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   13 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   19 +
 .../amd/amdkfd/kfd_process_queue_manager.c    |   21 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |    3 +-
 drivers/gpu/drm/amd/amdkfd/soc15_int.h        |    3 +-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |    1 +
 .../drm/amd/{amdgpu => include}/mes_api_def.h |  167 +-
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  579 ++
 44 files changed, 11417 insertions(+), 302 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v11_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
 rename drivers/gpu/drm/amd/{amdgpu => include}/mes_api_def.h (68%)
 create mode 100644 drivers/gpu/drm/amd/include/mes_v11_api_def.h

-- 
2.35.1

