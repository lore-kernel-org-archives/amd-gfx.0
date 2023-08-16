Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD2EC25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399C610E3C0;
	Wed, 16 Aug 2023 21:28:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB80110E11E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOwMlKxPSk2S9otuilYuMcGzYH/J6UyixgMHGJ0wScXsk9Msi+xHIx4jQA0nxD2lhT0AkFSonwe2yjGJVvEGNhnTy0RWHoyZTDWK2vlhwzj2xNLLHalGs3MITR+3ALRufNjsuLGwBOmNzlyR2ddsTNFKI5Mw34C9anOTtUWxLN+1j/5sLfPnOb1TnnOO3XkFbxrKP5fXowOEg6NJs+W+Ni/eRlDRYbp0pCYliYLDpjDnyX8TnKSINVJ3poToKHm674WA5whqO/o8cmliJFcMmGvgbZCU0TDgxabNsLg1aBdvCB5SYxhFH2/rPBSFpSi9TXHB7z3iMP1KkszXgy11nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uew4O5FPShcSE+WtvTKBtOWXCEiQWAAiB1YRHV3qDfI=;
 b=gIq+O94trH6dI+WsiyU3i0rRVk2IUV4GjpkeQCXW+AQu7e9e1qIOwvfiwxIkf1lx9mlVMB8HGoXv55Ct1JFUxcO8wcj3eVJgOAmjqGiH6J4SuPOcz4ZDC+BfJzojt5gQ3gATP0xIywyBi+UElILozIxp99Dyq2ogG/c4lXJVyDadX5xQP8FyrzEx1ZuMYhtkdY/mQjqhnZCAHAcyqUOjqOadxgfk5FzLCWZb7vqJ++37bqe4iMAe8dHqIHrVBROQu+r0C5dxM5iizF8Rlc2z4foairYYpuGareKQlp63XEd3i+pxvLrKjzmVzdGt3/LNJxdFXos0l1Wf6o8AxyqAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uew4O5FPShcSE+WtvTKBtOWXCEiQWAAiB1YRHV3qDfI=;
 b=r7d5HkkKogqwW8R7D8lym610vdhSqVFQVoKUuQKBbn+WLyCqknCD/lVWGZL+kq/X92VYYbN9V1GNwoRgW9u0/1ntXVRsyadcYqrdsD4JlqyvMqaB9wtaDuYR7K9q/A3WAqUoP4YGnN5jITpUplF2lwaJSksgzPB+SDakVTJ5Mow=
Received: from CY5PR15CA0234.namprd15.prod.outlook.com (2603:10b6:930:88::24)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:28:34 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::8c) by CY5PR15CA0234.outlook.office365.com
 (2603:10b6:930:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:28:34 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:28:32 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/18] drm/amd/display: Enable writeback for amdgpu
Date: Wed, 16 Aug 2023 15:26:08 -0600
Message-ID: <20230816212626.987519-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 9caed37f-afc5-4f49-4e52-08db9e9fbefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Z0BavVdFZxfoyoUDVcvkLLX9QFiI3CNORTSc5wb/9zaKAaDtww8BzK7rti6noLjeaagQPv+y/xeqJFFi1PAa7gzNIV33EI3o31B2JiBDXlfh6p4bkIfCqJWPJrWGNaP2HxDhWKnbKoT6giFcqvOFFLjXQ7gkkcr12FdDwSaN7IAnmTXyqgtUzMYqF3ccygKlatoSDKiP6K5VyfGb1wLBbrEe0W/E/8R2fhjbfh5pRG8Jt1bWkoXhLuRywE2ydPJrKO0QsOxZbM/vb780w/LtC8MAI36UJJlwUHQGEx6D4IuKT8ztsd+HRxKC3BfkYPi39VhKDNzkyFyuGtT+548brSJIkXOx0ZFPwjYdFbCZJSUXiRqsmPqB5kX8XiPchLJzmN3UrK1r/O56MxI3hZ8InWRqrBwh7oEo9gQuFlGzmkCxXcMhjCwR7ibMAcD1ysD98sM6//wLZKYyhojGDK4UjPgzaPETas/x+7ZPtsyVsyGz0qw8TCb5j6kV/qhF3tivQy6oznRUsDjnwKoZU9EKOZ6vWU/QS0r0Y+vLEIPIw15b7d+hbC7MhG6iCpaavFU4sFX6rpdS8T4L/VP/v1IUF3c/zrUcRmd4ggCvSQNw2/XU0N085AJrPDqoTzB398HcMNmCaXswUZIAm+hugOXTtv0aQNev/1PocyPtJ1xj32h8diTLCcsy9QEt1mJ7m+baDvfAWJGQGagmYWt7vausl0WZ7i1yOYmNZvse2yVLc6/S7nYD/P1yl3B4cnJYI6p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(966005)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:28:34.3289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caed37f-afc5-4f49-4e52-08db9e9fbefe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset adds drm_writeback connector supports and enables display
writeback block (DWB) in AMD hardware.

The function can be tested by IGT's kms_writeback test which also
requires a number of patches to enable 10bit (DRM_FORMAT_XRGB2101010).
Patches are available @ https://patchwork.freedesktop.org/series/122536/

Alex Hung (10):
  drm/amd/display: Initialize writeback connector
  drm/amd/display: Hande writeback request from userspace
  drm/amd/display: Add writeback enable/disable in dc
  drm/amd/display: Fix writeback_info never got updated
  drm/amd/display: Validate hw_points_num before using it
  drm/amd/display: Fix writeback_info is not removed
  drm/amd/display: Add writeback enable field (wb_enabled)
  drm/amd/display: Setup for mmhubbub3_warmup_mcif with big buffer
  drm/amd/display: Add new set_fc_enable to struct dwbc_funcs
  drm/amd/display: Disable DWB frame capture to emulate oneshot

Harry Wentland (8):
  drm/amd/display: Skip entire amdgpu_dm build if !CONFIG_DRM_AMD_DC
  drm/amd/display: Create one virtual connector in DC
  drm/amd/display: Skip writeback connector when we get
    amdgpu_dm_connector
  drm/amd/display: Return drm_connector from
    find_first_crtc_matching_connector
  drm/amd/display: Use drm_connector in create_stream_for_sink
  drm/amd/display: Use drm_connector in create_validate_stream_for_sink
  drm/amd/display: Create amdgpu_dm_wb_connector
  drm/amd/display: Create fake sink and stream for writeback connector

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   4 +
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |  14 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 375 ++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   3 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  22 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 215 ++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  36 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  80 +++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c  |  23 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |   2 +
 .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |   3 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   4 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   4 +
 17 files changed, 742 insertions(+), 70 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h

-- 
2.41.0

