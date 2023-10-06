Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A58E81E1E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 18:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F4C10E559;
	Fri,  6 Oct 2023 18:50:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E880510E559
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 18:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6i18fYhyh7ZYF0yzvlhNXJkzw4IlxekRH/J5noTs170K3pKR+IbSa5jcoOgUYA+LaLPNSQ39KT3hOff7KCR8qR7dF6gRLi9y63sS/2halyc40mfiQtG73z2D8NabB3yzevgN1ir8WUdzh0QhyRbP00+BDnmILbv9oWzXhFi6p4CH1kVjtdgSsyZMvLAGYPzV/4pOGzzP5HB8qrix0gDXMzLKzS4UKd1f4dphnif9YZYOjvNMg1X0DUchu08+JRqh6RdAIoea4P4P9SL6QSlD6HmsA2N0/kx2DrY8vE/jpEd4fR8RvqzGur/HOQbZYSDM5+t7JTFXz+gEcJylWlpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7o9ASBr07ij/xXEYxc1w3gbycCPiEVunCfMq+5mUwk=;
 b=LYyaTiZQLfYWri/GCrWoVjOKkkyh1quASEsM+3z4kuXATd6FQehf9LERSkMd6jzonsX1sEZt8ZhVN8Kh4kCz6HT161yRMsXWIUjChZ7ibUBKEW9Rtsj0A56BLcLxjP9+Zejqje9egzRNMbXA1lcTyVU4MYDiCIsVR8ZrW+K5Moha7rlE0n8yIc4+tCweSezBEbmDxBRv83rtcGPM6lmZ349vSm6cmzA99TsvHs6Yf5DZzPV83Rz8ucFF3mZIUE+o2Zg/PEZ7QbSLP+YD+M1W2GrSO/oD6shUd0s1hRR9e5NF0OjM9+cVlbV4aBwKl7l0490yDXtcGF96lKkCJ+UBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7o9ASBr07ij/xXEYxc1w3gbycCPiEVunCfMq+5mUwk=;
 b=U/mbs4YWzkobksoX5BciIubSFMt0PEEZkAB1wBJli7r5tnDz3xB66XRH+opkWbyQAhMOuZFfh/3J9su5hz45LMruK1ndosnG1UUccCxEIn8kCpaqOLy3/osXHKxR0c0IXJhvLe1s0+Z40VZzbGvgFbbjuQJ7GWNZTlM/7a9CLwg=
Received: from BL1PR13CA0261.namprd13.prod.outlook.com (2603:10b6:208:2ba::26)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 18:50:53 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::1b) by BL1PR13CA0261.outlook.office365.com
 (2603:10b6:208:2ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 18:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 18:50:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 13:50:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 0/7] Better handle memory pressure at suspend
Date: Fri, 6 Oct 2023 13:50:19 -0500
Message-ID: <20231006185026.5536-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d847823-7c61-423b-877a-08dbc69d2ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIBd/8BiVhpdsqDIX79xiqkHjkLp5Gdw51trXKPN0DdK/VpiOTiSp5eR10drn03KvQkxBT9OEA8E4ifJl9MO76u3pxmTTuuSW0KH01P7fnQR6xT7emtcxuexA58CNZoH8pYeG6etaMh6i6TXAaMmhS9fkfkfPfdYFxvcqpwf0UeLyW0MfBxprnmS1dmQ2a+06a6KWo6ELvGnGn5bQG696yDU64X88dNb76b1fS2EuNO+6MRWx7a6q7bHmOFX4N1bpJqJM7aZJVr9zlCWqf18kUdRCUX48iTKfQi1jHozGHx5t8Ai4HhWc44W9YamvRA0Kx3pkVdLMZ+xdfXz+hYPMC+th8xDD3lmE0x9YMFOyI3/Wmw/tuaL5VmjzOfTy6mHJZuCTmRW5QZoUEEl7evXVqX5597doGU9IBEj00ngdaRarV/XsN2F9ArRo7ZQ1lDKlJsiERCyZ3I9wQ9qJJ1RUAsOCNZXlQQsh1Q+bqI2r13wsAB0NchHoHBEDL2n1ZxeamZcUx/Wba1r2oCiOi4FMWEKvF2veBvTrlarlPrbU/sjK+WbI5aJbFb7QT1UpGww+XUiGhXcBaFH+i04aiqV1WcybNaRlIhAIujeuDvwTX7wd78mqUo6pI4+29VYFIzD2sRpvJaDeb7ptQ9ZGmYqv863V8LRamFwXa2WkndYNwUY+OEs1TgumUci+2meeMNTZyV8Leui3iMzoBKvRaM2zm5s4KsBWXJ85YHiaL9qcVB7CjmC7xA1HokKpYJIzTYAj9rxV8Avq78PwnGzJIHqW/c5UF8QT8A+B4WNqmIGPtg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(2906002)(15650500001)(5660300002)(8676002)(8936002)(4326008)(316002)(41300700001)(36756003)(54906003)(70206006)(70586007)(6916009)(36860700001)(47076005)(966005)(478600001)(44832011)(83380400001)(81166007)(356005)(6666004)(426003)(336012)(40480700001)(1076003)(26005)(16526019)(40460700003)(2616005)(7696005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:50:53.3128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d847823-7c61-423b-877a-08dbc69d2ad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

At suspend time if there is memory pressure then dynamically allocating
memory will cause failures that don't clean up properly when trying
suspend a second time.

Move the bigger memory allocations into Linux PM prepare() callback, drop
allocations that aren't really needed in DC code and report failures
in dm_suspend() up.

v1: https://lore.kernel.org/amd-gfx/20230925143359.14932-1-mario.limonciello@amd.com/
v2: https://lore.kernel.org/amd-gfx/20231002224449.95565-1-mario.limonciello@amd.com/T/#mc800319a05df821cd1875234b09bf212e2e3282b
v3: https://lore.kernel.org/amd-gfx/20231003205437.123426-1-mario.limonciello@amd.com/T/#m00a49b75cd2638bf8a0ebd549d6a6010bfb7328b
v4: https://lore.kernel.org/amd-gfx/20231004171838.168215-1-mario.limonciello@amd.com/T/#m0921840868295ec19abbe5ecbaa0aee75356b9e1

v4->v5:
  * Call amdgpu_device_prepare() from other callers to amdgpu_device_suspend()
  * 3x evict calls -> 2x evict calls
  * Add IP block specific prepare path
  * Fix issue in UVD
  * Raise warnings for issues that could happen in amdgpu_switcheroo_set_state()
  * Catch problem that could happen in dm_suspend()
  * Rebase on top of DML2 series in amd-staging-drm-next
v3->v4:
 * Combine patches 1/2
 * Drop adev->in_suspend references
v2->v3:
 * Handle adev->in_suspend in prepare() and complete()
 * Add missing scratch variable in dc_resource_state_destruct()
 * Revert error code propagation in same series
v1->v2:
 * Handle DC code too
 * Add prepare callback rather than moving symbol calls
Mario Limonciello (3):
  drm/amd: Evict resources during PM ops prepare() callback
  drm/amd/display: Destroy DC context while keeping DML
  drm/amd/display: make dc_set_power_state() return type `void` again

Mario Limonciello (7):
  drm/amd: Evict resources during PM ops prepare() callback
  drm/amd: Add concept of running prepare() sequence for IP blocks
  drm/amd: Split up UVD suspend into prepare and suspend steps
  drm/amd: Capture errors in amdgpu_switcheroo_set_state()
  drm/amd/display: Catch errors from drm_atomic_helper_suspend()
  drm/amd/display: Destroy DC context while keeping DML and DML2
  drm/amd/display: make dc_set_power_state() return type `void` again

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 75 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 10 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       | 12 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |  9 +++
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |  9 +++
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |  9 +++
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  9 +++
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  9 +++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 43 +----------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |  1 +
 15 files changed, 149 insertions(+), 72 deletions(-)

-- 
2.34.1

