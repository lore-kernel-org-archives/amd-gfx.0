Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB22C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63ADF10ED12;
	Thu, 12 May 2022 03:23:06 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4B010ED12
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTnM71+mnZLkJcKf8ifWuX8hQGuS5UJvm00FUBLKQZy0ho5ZfOs/2SQfaZ/Uurs8UceiDynIihbnrtSnSbNJjzn+NeL3CmYs1Nqk2P0ZposkpTQcUNwbiu8D52WpFXoN3+ANQqnPdDUPiVLn7uFI/xkEk9B0S5POM0diXnfDKdG93tpL2GuQbfaQc0GWcfpMFgAQVekBy4e1522MazuNCOGnfIJIXoA++N82NSpayA+9VvDX3lhy7lBW1WQjvp3szTiNZves6v3pWAc2pTZb3UopgaZ0O16SoOuiZwD8B4bNXZvKlzP75IPcaWGkm/zHAURdOEUG4EynRILayK09qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2RhmdN7XEDACsc6yWaGB84JVjJ7651FIoCGAcwsO/E=;
 b=VqXQ0s9fIBiFpJwqgkQU1XI82a+A211yeqce4Yd06iwEfbZKegzYc55hTeacqGPrflocU7GnfGJcQUFgqCFG+O5dHXnTWcuIe+7/xrT9vYfadPV+r996F7r0UY0FRD7hspq7IfFenWA1zGjLfAEbjZjEJH0BE2y2ehaVfymc9D/CZuXSqLT4UxqH6dLeVwbyoqq1tfhTwyYpYoNbP/RPFJ9rhq2JrA36FhYitbHZMFqXN0bKrv3Hqd0ON0jaRlhjLsExhEdu8NTjMkBv3L5j304ygG6nxMPw0aE1bVBquhpq+CJaTV5tCFBsP9aeh+NYBbVx6fs1aW8YNG+/xC6R6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2RhmdN7XEDACsc6yWaGB84JVjJ7651FIoCGAcwsO/E=;
 b=fb8ZS1nwXFJDKJYs8qTioaSrcVLZsus5kWb1dENLgXL9wmC3jJKkxxYBFSk6i0oEKNKYDUrXSSJKcP2ocKZCeFClT+s7/PNxyMxQIPCKcDsRdBF2jCwy4owyqZEPCeDeb21O1uWmu+Hu6XVEjO+tmex9RHVK8lFyaGYahCFxjmY=
Received: from DM6PR11CA0055.namprd11.prod.outlook.com (2603:10b6:5:14c::32)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 03:23:03 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::d3) by DM6PR11CA0055.outlook.office365.com
 (2603:10b6:5:14c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 03:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:23:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:23:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] Add support for SMU v13.0.4
Date: Wed, 11 May 2022 23:22:40 -0400
Message-ID: <20220512032247.528556-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a977d1d-efa7-42a8-793c-08da33c6b90e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5174710E3927DE16B7C57782F7CB9@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gf4QIl4auncXUgAbUVyCWrrtnQ9jB9hY3AtpvVlHHEoLyCc7CJUuDwwlFT8pPs7CB+FWFErBoz+Gvb4Y95+cx3xzsByTEpFkJkHnuAiSUZ9klZerP8EToSWuU8DwB0rgZtw3GKBmBgLhhiN69H/1YqfGFFJ8FXn5MQDo1HX1tfg7QKPtibF8YuUPC+H1qVvV/UvlNbSyq9Vgxg1vgMyYiovqVNFha+0NZ52A+ETW17FvduZSjst+WFCJOrG5Os/4DoFp+Vfu+IxQDerUB1peeO8raDflaYY0HN6ZMw8z4PJ7IJ/vFnPOcjexQkY7z/gD+f6sqmfsRZGlNR2Ywgye3Ebd3Br2iBUCoQDh9ri2wmKcO0xwXRvSNFmT3Rr64eyqgKoF0PxPomXG6bNUN+KAg6svf4xAkWKrZ2dvCsGLLUFB5tldskz7BFhazyKS21b4emFpKEibS2O6qpCGh5zJ0k1cjDBwJj6gHXw3wadF+/c1UUIFRaysSJEvGQiddrHXp2uphxCZ5rFtvoriOOG82qUWr9o3uBP1ow32X3d3JzXKgCQjF9kUstzRV45+8pMCB4xbKQLJa2i6oQJ1S9YDLcHdj6WnkHvBpWALIBkogJXV0FblRpqaHE8N5XSOd07YYN4IXSH1k6PxONoKslsBwVV21p6nOLzQBJHe4P5RiMKxKT0wzAbDPsAPP5IhRKRH+x8IHy8CMtZ7O4zFLklX+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(2906002)(356005)(83380400001)(40460700003)(186003)(16526019)(26005)(426003)(36860700001)(336012)(47076005)(5660300002)(6666004)(8936002)(7696005)(2616005)(36756003)(1076003)(86362001)(82310400005)(8676002)(4326008)(81166007)(6916009)(70586007)(70206006)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:23:02.6683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a977d1d-efa7-42a8-793c-08da33c6b90e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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

Add initial support for SMU (System Management Unit)
version 13.0.4.  The SMU handles power management and
other tasks on the GPU.  Patch 1 adds large new header
files so I didn't send them to the list.

Alex Deucher (1):
  drm/amdgpu/soc21: add mode2 asic reset for SMU IP v13.0.4

Huang Rui (1):
  drm/amdgpu/pm: add smu v13.0.4 driver SMU if headers

Tim Huang (5):
  drm/amdgpu/pm: add EnableGfxImu message dummy map for SMU IP v13.0.4
  drm/amdgpu/pm: add some common ppt functions for SMU IP v13.0.x
  drm/amdgpu/pm: add swsmu ppt implementation for SMU IP v13.0.4
  drm/amdgpu/pm: enable swsmu for SMU IP v13.0.4
  drm/amdgpu/pm: add GFXOFF control IP version check for SMU IP v13.0.4

Xiaojian Du (1):
  drm/amdgpu/discovery: add SMU v13.0.4 into the IP discovery list

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |    7 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |    4 +
 .../inc/pmfw_if/smu13_driver_if_v13_0_4.h     |  267 +++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_4_pmfw.h   |  137 +++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h  |  138 +++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |    3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |    9 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |    3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  107 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 1044 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.h  |   28 +
 12 files changed, 1731 insertions(+), 17 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.h

-- 
2.35.3

