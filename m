Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945F3C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 16:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E9E10F13F;
	Thu,  2 Jun 2022 16:12:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83B910EE40
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 16:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T49Lu8Q/kwfksxCyhBTCGt0p2296nMIzr4p/mlwYdEcXeBOYpjjmC7KlSglbUtiAG7Q35K0eYntE8jOuQJ/OVSfZHSWzXnZY5TNhDGjxJMhYw+wqhSI95eJHIePQFkzlNhXDuov5G8VubBrj/XCrU12ztMuGBdhrGAud5X/Pi6FXqCS3w4Gia9oM79+senagWtowF7zPsMcJKr2UKC4AoY4RTMTqwSLrJFTTVdbLrW9vym+sW1IbSXjoSp7MFLO7L7GdTTSMGLCKMyHwP5g4qale6rb3Bl4LdCwBTbZJYliT0SZfWrgoh7xr/mT3czuZlas716Q0cOeLnZ43ev/Ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4Y5nJbiehMnW3UCW9VPdAFbwn7vX5AyVthpZAzT8WE=;
 b=cnTDzChe//StXeSXsU32riFZC2vCKv+dR3MYfg9U/lVMuxoyYuVqk1RtjuOGtEVNrnxsXcSg2jvCGP4u3F07NAqZsWEcyi1wZ2Lx56NKK3AN/H+kVywW0F2aASGnwPG4lZiZsdOqR6GgrUH/BnZ2I9BOrfjiddgDDpq06ESVz5sdvxnmmeTznl+jkakdTThN1L7ycE6CGd0EbVi5/X9jLlB9Eb1HVg/a4wmS7pNPDLaWdBr+ms9Xz8oUP0xbmQM0kt0jeCtLjSNMHdFiXwjlXfDcRdlJvrTAWCgeJ7lUkdzh7EimGRIeMif7BdZOzF5WUcPvGzKfKbo8iTuEVbwMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4Y5nJbiehMnW3UCW9VPdAFbwn7vX5AyVthpZAzT8WE=;
 b=T2fXrb2+2N66aAbDep8bNUIIj4Hg8oyOY+vgF8/uJiomswTfRKWdMprb8wqCxgc/T2T9uiXv9E6F160++4XwndC/BIb7+QrSZLWf2PXyra9/wTI85G0YvN/D54ff7Mq1E0Cwc0yuut0XTQWRc85AiQ4rmG6G3dxwMG9odpoigfk=
Received: from BN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:e6::17)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 16:12:23 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::41) by BN0PR03CA0012.outlook.office365.com
 (2603:10b6:408:e6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.14 via Frontend
 Transport; Thu, 2 Jun 2022 16:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 16:12:23 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 11:12:22 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 0/3] Some VRAM cleanups
Date: Thu, 2 Jun 2022 12:12:07 -0400
Message-ID: <20220602161210.19380-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef443c35-c133-45c1-1dba-08da44b2adcd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5183:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB518371D6B986392806FDB3FC99DE9@DM4PR12MB5183.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TsyitouXbLxTCrn4yAHWYq2rTUcxFAItvsxH9zFrvuCXe4eRgxmdMl9QA2FH5SxGnlUTT6hQSEjmFdRkctWzG91OaNJnB0nOvr2GEkHP267p8XDqX/9kMvMfN50SCiDtJRGmlO8f8p5yBQ/h5T+JZj3V/ezI6ZkwJ7JmGb+Rj1I/3D6sl63ljhiiSABV4lkrrxvi+yoqhi68HVWtMkbQLm3cx7Fslw8RbiB1/CMC7EoriaJGxgwEtMXDH1lkeG0WvibWtra2DVN/mGj4QdqgSJcrZTDFlJ90Oac8JKjbejp0Ocvi+jcK2ep/E0WIFHdalQj7N8LwzJW3QaMYBbEUoHWNDEUAfD+Afz5LSFKw6hoH5mj2iWe5/dHA5RuftPiDitgayVVVzMp7ejXdNXDPYLqjaTcSrajVf8FTri4UpCEoWT8it74dJ/jl9dDWT6MqAIYpr//CSg8wJ3KQghMPrbPtbl9epcH4tStDX6RdfpqI6niZr3XabVWujPfLquC6q0vnVBjOqYoqXN0/YhVuBi2gscxVTuTIdEdMLToCUw2dgeNsMhk1yk/rDG9hh+Yw4tRfvii7ascMKfs3eLb9inB65C8j0XvxjPZ0dGnBlaJXX5q5bopedPbSnwoYndV3ckn9jD0/4e2KU0XmvDLYUhyS0sqYL06tJJZA3SwUE5MoTwRNjk+s0glR77n8lHe0bHDHdXabP4j3Aygm9Ha1XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(5660300002)(8936002)(508600001)(356005)(7696005)(44832011)(316002)(110136005)(6636002)(70206006)(70586007)(8676002)(4326008)(81166007)(2616005)(336012)(426003)(1076003)(186003)(16526019)(83380400001)(82310400005)(47076005)(40460700003)(86362001)(26005)(36860700001)(2906002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 16:12:23.6489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef443c35-c133-45c1-1dba-08da44b2adcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some VRAM cleanups from Christian. Second patch needed some work to be able
to compile with most recent amd-staging-drm-next.

Tested on a couple of differing systems.

Christian König (3):
  drm/amdgpu: use VRAM|GTT for a bunch of kernel allocations
  drm/amdgpu: rename vram_scratch into mem_scratch
  drm/amdgpu: cleanup visible vram size handling

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 27 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  7 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  7 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 20 ++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c       |  9 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 14 +++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  5 +---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  5 +---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  3 ---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  3 ++-
 .../amd/pm/powerplay/smumgr/smu10_smumgr.c    | 10 +++----
 28 files changed, 79 insertions(+), 74 deletions(-)


base-commit: 6cc31d9a3e0944ca02dda6f53f9c9320b8bee928
-- 
2.36.1.74.g277cf0bc36

