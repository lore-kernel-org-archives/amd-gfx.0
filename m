Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF7C3DA58
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB0410E544;
	Thu, 17 Aug 2023 18:11:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3123410E09D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAVwq7kIlt9mwUEvWtIp+Nn5ZLql3JXM028Y+L+kGbycEuMOqclqjJ/4EfH8xMPksK4GHm4Iq6eDOA5gGIBYIT50yxZdDLlXb9zgOkkHIeTnQa68xWEbImGVQ2XO0WO83cWDJxDSbfigM71Gfq4k3YXKXmxf7vudwnenv4NV1lXY/sYuZKuGKVdDNoh3hoXwUurP7BTm7Jwjp+ZKIoxZqXs3hiXg8GxHJvnoTCKNYUReTdtDsDQ48Th7gJC56oFn/vB6HVhdJot/OmOeQdzqgQIlJpoxSudClfEDyBaXkik5SiQzws/qWTWyiwMCLLgqNHTJIXqCuWlMXhkBP095iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gI3KXASrG4h03PI0FqcPR1nDaJZQgSIbN0StUIbuFis=;
 b=c1tlCqxbJ/zzKHgT9k4OMpKLU/lzwboRhZqGwU2We+/byO/RG1lKH6ygzUDJYztLAaGcafR7IKuBlLbf1vnEP3o99/ge3vV8BteRUt1LfkVjQFgDl3n2Ns7sV3kbuYV84tc8PFYNJOlZkX0J+Pxz6ZsPeMJc8jUu2me0jUDjftXbsCaNSPPwlPJwzEAGgztAnVT1TX+jCxDh63YDjGzIqmjG8oLqEhhW7xVzI0+NKA8N/3Rz1lbvrm/0l9a9odBSCV/+hA53Rt5jjp/oLzGAxaTfQkKjRaFMtpfqkYn2b+1DSVq7yDVXgzp7LQRZlktwzXVAUrBnnV2pe4fTp929Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gI3KXASrG4h03PI0FqcPR1nDaJZQgSIbN0StUIbuFis=;
 b=A+EcUVRxPrbjsZcm90F9gzftZw1RE5MeLtZ0HFF2bgBEUHI55oh5rBOP+ygKEWT9+fQrJjl6vHbGPC9J7QNaFw89F2anyWacCmzI97N7osL9K9RuSBvm59hF+ohC5S1jSFfN6j3YoVXQcUHLaIwmI/uldnwPq2lm8VaX0wmCQLg=
Received: from PH8PR21CA0010.namprd21.prod.outlook.com (2603:10b6:510:2ce::10)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Thu, 17 Aug 2023 18:11:41 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::f4) by PH8PR21CA0010.outlook.office365.com
 (2603:10b6:510:2ce::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.7 via Frontend
 Transport; Thu, 17 Aug 2023 18:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 18:11:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:11:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/9] Add GFX 11.5 support
Date: Thu, 17 Aug 2023 14:11:13 -0400
Message-ID: <20230817181122.1543473-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 06362c61-ac2b-4dfd-351b-08db9f4d67fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dumVT3X+Bi/9Pto5aDAGEE+pDkik6+3vYNgkU5zS9n9Wx+ZmT7h1ItVyigmW26167RBvFAc/I6/CQJQs+6tUpPLjcAOqgTSgaXQuUbgLAMLho/sJA8fNXRBZ6W7/ZcAaJI4y35tkcsa5Mgh8q4hwZbL1hkzr+rZUYeCFemljZBPMGJhuAA8Wu8o/hRztUHesam8V58Gw3+Vbf6MYGxMx0iHW8ytalb3HFKAu03RyU6tNKiNKGEQyMkUVL3jMjOwcZR6NnQbioY/3aKncJ4ch8WxEYu4CtAc1FFwAyLXBenxzrENY7Y2Ikj/NsRjxfO76WpMxfYCMC/s7ejd+Q/XM1yL7PZojcNY2dg8XsYYvawrtLRAHa/Z6elDsF8pMCV+gJPq6tyjUK378xdwoDdRQ720Q595pInj7dA5vwWfURjiaGfiOzHzMMa23g+e/WawiPiE6kifvd1dL5gV0tmbWJXfgQ23QA6jURyffZViBbD4cGqvXJBfPdT5OqyPKT1QTWuAFKQLf3L2d3rkQ7/bBos9RwtDSBNfZnGfutf+KpHynIfXGEDiSJEYMeilx4D/eZLvIMHSV5Y5P4xSnFXdZU6/QBs2DqoU1CyAGuJMV0W+nH6lP/QBdELiit6xCf6g3GgvzCwwUoCZF2XH9DUudH+02a9WNd+YTF3F2N2zZ9myKMEfS8FkAq/jG0oEv5+iDIK6eLf8pw4VEFSJMC3EcuiYyA5biW0lQXShBhHyo1ICn27hJ10XCM6k+ds3yUZvxVtN4WZ2sre7wTeHXFLAfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(83380400001)(26005)(86362001)(336012)(40480700001)(478600001)(426003)(36756003)(7696005)(6666004)(2616005)(1076003)(16526019)(5660300002)(36860700001)(41300700001)(82740400003)(356005)(316002)(70586007)(70206006)(81166007)(6916009)(4326008)(8676002)(8936002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:11:40.8246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06362c61-ac2b-4dfd-351b-08db9f4d67fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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

Add support for GFX 11.5.  Add the relevant
changes to the existing GFX 11 code.

The register headers in patch 1 are too large
for the mailing list.

Aaron Liu (3):
  drm/amdgpu: add golden setting for gc_11_5_0
  drm/amdgpu: add imu firmware support for gc_11_5_0
  drm/amdgpu: add mes firmware support for gc_11_5_0

Lang Yu (3):
  drm/amdgpu: add gc headers for gc 11.5.0
  drm/amdkfd: add KFD support for GC 11.5.0
  drm/amdgpu/discovery: enable mes block for gc 11.5.0

Prike Liang (3):
  drm/amdgpu/gmc11: initialize GMC for GC 11.5.0 memory support
  drm/amdgpu/gfx11: initialize gfx11.5.0
  drm/amdgpu/discovery: enable gfx11 for GC 11.5.0

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |    34 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |     1 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |     1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |     3 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |     7 +
 .../include/asic_reg/gc/gc_11_5_0_offset.h    | 10000 +++++
 .../include/asic_reg/gc/gc_11_5_0_sh_mask.h   | 36531 ++++++++++++++++
 9 files changed, 46579 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_sh_mask.h

-- 
2.41.0

