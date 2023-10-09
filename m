Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801E1E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE76310E139;
	Mon,  9 Oct 2023 15:54:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0EC10E106
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoJksIa8xoBEbJ9ee56ChJ6d3P1bogO2FtL1XtnnsiTTa4nAamClbrqFpaQffB0naNDHi5cJ+oNK0qFZvwcCxmP6+yGEKEnKupfvGTYkF/T9UzJIm//vMdB+bZd0tro/c0jCAr31Bkxv+/DFAFm0zCgxHJG1fVwD1xQndTpXW/XsH8cSOyt1plKO30FqCLPAMTZB9dVcCZulLlPBbPg7dUYrs5Tij51SowaaSkvcZBFFdmvBOpdNZiQaAmjhcDWgzZz3BAHomfGjrKopb8uD8E6AJQkHtfbWonZdUGqSg7KvOZZkvq4I0Njt+htMU8ieE1xRxC2jiJAxa4HmFopH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qhc0Ka58hQ0EitFTmnKotGZkLCOgAzYDWqcBhdoOA2o=;
 b=bLgEHoZO3nLUQCiof9q4DKGHCtbdO5MiQ+n9eGe9Dkdl296zFTZmqZZkrxBEPxmPVeBT6XOoLqYzA8JIqqFg2bdA/7ItCcJTK2x6ZLxMLynHH9fYHK3auXcB3/OhDzQr0j1EWsbvGiqsS9iw4dfCIjArrE1BRPtLARRfAIABM9b2jbST4S2+OeXOlruXKbeOfDH0W/cxH9N43+jFLM6tDJjCYl4EH8tQGuwDE/b0RGqeZ2cQQKGtp+BbLoa29bm1ut4sWdBAfZSO+JUmDR5AfEwsWe2N5/GYw7fA1Cyjg6nu+3tlQGbKdD3S0B3CONtZzo3yrpl1TphgPQ3OJbzKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qhc0Ka58hQ0EitFTmnKotGZkLCOgAzYDWqcBhdoOA2o=;
 b=11yN3vMaou6vqtIW1NZdsqQKmtLnmrms0oiKqdSOT7gwMswBb1nvuCxe6+6RljjAZdiWt/8l4LgQOnqQPcDnVJczVn/o7q981zqT5yXmCwjg061mfE1a8Ddp19Bax2f9V3S0aeN3qe8ZSLFLb3cuY5HhYNxqLHryazrHWDKNxuc=
Received: from BY5PR17CA0014.namprd17.prod.outlook.com (2603:10b6:a03:1b8::27)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 15:54:43 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::85) by BY5PR17CA0014.outlook.office365.com
 (2603:10b6:a03:1b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 15:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 15:54:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:54:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 0/7] Better handle memory pressure at suspend
Date: Mon, 9 Oct 2023 10:54:19 -0500
Message-ID: <20231009155426.96232-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 6829bf40-9692-43b7-8884-08dbc8e00de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWMNHkPz6JrtjHPYXjolQ0v0eW5kde4wAoTJWTAJ6y6Chh3To52U5SNeiYy9bdl4RUI7w6AbnB8157NJGvVdFqlgZZdE7g8YQUOhP0oGEjf2gbCE7wtwttNyZYvWh4QGX4c19VKedgS/iV7jXSbAS8H6roTmHwzhWMpFi0mUeluvB9EpwCuX81lqkC056eByOeSaki1bzTCrRRvJbtaTeb+/i+S/vXZ9/50DSm6krjRhjKlbz4Z8hZIwkdGucZML5kZyFZuSmoo/nYyWa/h24cPeOzXQhE5b3EJbwZiHTwuNfKGTWSLYVS5H59MpoxVtBextQshrwLzyTeoCPmFCKHBjwDvKD1pRBICiXhitggdXGRufGVcWYuzc/oqM5tgUdRHf3cG3uwt2vvk6rDAQihsHGMP7Z9d2c9KWs2tcjUF4aumsvHVz0gZ8ZZToIkJlkqQfBNsMqFG/49zPE4Zo18jP6PMFs/LyXoGHcHwSJPxsIYXw5HcRCAfI6CQU9nMZqpK/NyTOvntcDa4XWXZ+kT5HBNH1FWwA/1qqzW6184n7E/g6izp7xIxRTVLnfBNW4sS1+UdfEhMGkwmwhCi8AWqmjMApwH9KoLz6/fHpfmzIECqrdrhP0UpRx98oT5kparVJ0cG9Mn9TvHal5as5eJvNOn3ZYqinlJoyWJJYXyMvOyqMr5oASgEwbstArze3Fd9gfLE2X5Pa1pXGhEPYPVn6nHpW2ywmBa9XMcqHW02m5roCN8TdwBGIx4E13smE/wBUjfDxhB3WirpoqrNCoW6pGiVx07OdP5JwII4MJB0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(7696005)(1076003)(2616005)(478600001)(41300700001)(966005)(2906002)(15650500001)(336012)(426003)(26005)(44832011)(83380400001)(47076005)(70586007)(5660300002)(6916009)(70206006)(4326008)(316002)(8676002)(16526019)(8936002)(40460700003)(82740400003)(36860700001)(36756003)(356005)(40480700001)(81166007)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:54:43.2976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6829bf40-9692-43b7-8884-08dbc8e00de9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
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
v5: https://lore.kernel.org/amd-gfx/20231006185026.5536-1-mario.limonciello@amd.com/T/#m924d5b955ff2fe933b3c483a61e703724f7014e4

v5->v6:
 * Rename prepare() to prepare_suspend()
 * Remove spurious newlines
 * Add tags
 * Fix up commit messages
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

Mario Limonciello (7):
  drm/amd: Evict resources during PM ops prepare() callback
  drm/amd: Add concept of running prepare_suspend() sequence for IP
    blocks
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
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |  8 ++
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |  8 ++
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |  8 ++
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  8 ++
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  8 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 43 +----------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |  1 +
 15 files changed, 144 insertions(+), 72 deletions(-)

-- 
2.34.1

