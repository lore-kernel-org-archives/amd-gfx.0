Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06610EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 22:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20ED710E3CC;
	Wed,  5 Jul 2023 22:59:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626BD10E3CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 22:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIxT7guFt6IM+r4sUDwQE956leGOvrizENogHwWn/1ls17HtZ/X8gLsryJts1DX3KH+oXeSx6JZl3Waz+ozhPKzD0Jpx6ijUl4hQdyQOa5cYxXJybJHsZDH1q+jBQ8s6YQqO4r3/a/B7fFrnK2a0RB4wmRO6t2m6wUjpzB+xGlj5DqHzA2i+wNHMD+h4ecrhUoNUBPNoM+gPBYqCxUWxzFmMc3W1xDlRc/W4lt2Zf7maVPguGyZnJbRBVahiZpnsoTQGs0xfXsbrP56p2JIzNqP1VCVIMtcjeEs+vJxLy4mn3XjwgO0ZVFRZCJ28QLmtkBafuHRl5QH0lLFrgwHX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN5WKpoEjKSDPKm6+weDo9Q2AoF161AUB4CIEsBUg/g=;
 b=QE8yFQLwq6vdIVm4bljnFQnYz2DyBkHfDDJbOvkbLxY1V0JJlD8g/Me13asWh1VvDTuRV/HAj0qU2Ao3o6EpoFauIu+QMt+Vabdt0+ldmSZ1Uz+DqF7fpaSWQv1ZxIEEGO8dKBFsYBcTxHtNU9cUIMjxxAMlCPDfh1Wgmp4gG/2yCHWmyoZkmpqkNeIkgmtM58Xx87VbG+QawSwGA+aCtlmHB+obf72nx7YHwQ2ftbh66EKEvAVETI+993R0gixWifkMnvqgMMVUTHcYBjP6ADJXWCa7vpPNG7iw0E6iGZiW7T1GZSof5kRvJG+glyAc28Py/QlWpdhVpNwtp/KlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN5WKpoEjKSDPKm6+weDo9Q2AoF161AUB4CIEsBUg/g=;
 b=E6QYMYCh/vAmVBDzyTGtLOeal4w+0YozUGDYi7+5Lwxaa668eLZeQn7UC4baEGBrQFjWpjh/+0CPjmo8uyuWx1JWSfhvwBMFbaAMDGGD5YGoU88RMN4wbMPS5z3GiZhyeQ1iWl9oNqxgw7XPhPL9gEwZXgGh/z3fTs0w4eu/pGU=
Received: from MW3PR06CA0010.namprd06.prod.outlook.com (2603:10b6:303:2a::15)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 22:58:53 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::c9) by MW3PR06CA0010.outlook.office365.com
 (2603:10b6:303:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 22:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 22:58:52 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 5 Jul 2023 17:58:51 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] Upstream debugger feature for GFX v9.4.3
Date: Wed, 5 Jul 2023 18:56:50 -0400
Message-ID: <20230705225655.299335-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e39575-b209-46c7-987d-08db7dab6758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4erk8DPXhKQI288W3nGfeqiVhoWBpB94ItEvS21pmZWOWWVoVlvBHyS6hUr9UCr8ic4b5PLuUdpSwykk935r3+HBySlVxEDCBL40kbItPcxiMVMe8FtD2rj6qOxk+rYuEPKGLu7qCWz7vpkvLFzWQ+hRsv/VqW72kTaqgpggdlpQUhlMY6SbB/FoaZ5wvOOoeisP7t8opNBCS9aO5Wyn+jOMCbN/qyMoCe0xpjpoMnApWoc+nCkMI2EEtRW7fybFPni4tjCvMHxpp9AkLxGp4J7uwOJhB0ofHTM3vugJ5GJFoaTjf/vcuoOIMGD4R3ADUj8g86tPqvTkZMKj75Ofx9DF2wGwIioAhBGVRL9F/HJ0P+skPyWTyXvfWsCGFRTjSur7bC7GN8Hajz0o1xVHpy/WaqrwlMp00bcppq3UIc4etJi4mrJ7TDN8T/I5+5YuWVkmK/0+61ZbdPtKLjgOD7Lp587mkQbQYUli7urYQCcKjMSt23nCR/T30gJ4yK8S51YpemOG1+9eYBQyMEmeLXL1nde90vyQAOFUKSTQlxBZdJAxqcKf03W9iZwpD3NXWpEwEgtROVe7tfRIN1hnutD/Gi84hMFs3wcBaH9bkXC3juwiSXCi+BqkFYzI7+I9mn4hbFdKOuiE9zNGSaevGxPzmgwEViD1W+z2clHBHSCr4/qlJrw/Efu5m+YnEDUVC5xL4TKCGHxH/dzICveuXScWfH/SpEocnp1m1VamiTa0AJ99P4q9e9Kb8SJo2L5n6o/cz7wop3bHMpGSHkZ9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(7696005)(54906003)(1076003)(26005)(16526019)(186003)(70586007)(70206006)(2906002)(82310400005)(41300700001)(316002)(6916009)(4326008)(5660300002)(8936002)(8676002)(81166007)(356005)(82740400003)(40460700003)(86362001)(36756003)(47076005)(36860700001)(2616005)(83380400001)(426003)(336012)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 22:58:52.8233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e39575-b209-46c7-987d-08db7dab6758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Eric Huang (1):
  drm/amdkfd: add xcc instance for debugger APIs

Jonathan Kim (4):
  drm/amdgpu: add kfd2kgd debugger callbacks for GC v9.4.3
  drm/amdkfd: restore debugger additional info for gfx v9_4_3
  drm/amdkfd: enable watch points globally for gfx943
  drm/amdkfd: add multi-process debugging support for GC v9.4.3

 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  13 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  30 ++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 153 +++++++++++++++++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  12 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  13 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  12 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  18 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   5 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   2 +-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |   3 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  12 +-
 15 files changed, 265 insertions(+), 40 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h

-- 
2.34.1

