Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DE606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=v089qJr7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B6410E5F5;
	Mon,  9 Nov 2026 18:46:58 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC44710E1BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEAjcKN5CmH/7O9z4389raraCPSJlJQUWKqLNANkkR6OiuvYKfjXLYlpP5R53utosXZxuH+Yea8rlTqxmSfzyRv+VCHxKcWlQLiYHoVzdX4+CZkklZ9I2EMWF5/1Pd5Y9dtxDVHT6RYRVEao3SAvmiNDPNFYinuN0cF8xQJhN/M9oQQ47Zzkin38CLwSuuQAnOoBAjVd0OOQAiGOGnToD4nJHst27T37RDDIvBwvWiu6aEfpH1Eo0ykZfrSjDL8iDjyX5Mg0Qnf5EQUYrB4U3I7rEpAx1go0uZqcgEVNeYm6ysVTbsJ74kTizh25GCkq7jkYodhBkBXo94e09Ce5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUFKEXvxYmy2Duhk0Nw1ezIiYVtBTUTAAQGVCWNafsY=;
 b=dwTmOSEbO9+teBMX9FWSLp3cYOtPSyt+Z8nuqatGpssrkmdbxlJb5enGbjSJ4QHPnPIvm1xmkVVma7vt0RN8V0A4+iMmX8qac1JEODRjCcvufXx/+LiJ2cazgQ3BvRDrbqqzSt6ixj7dC5LKHVD7uWGPOfakTmFxhWDQaBKZ3+fm2WMeqiN4VOqPTl8t4cGytSFSLXyW2r49ovv6bpcz86FpObr3kbox5S8/5J8elVMIUjsQG+swQBaPoI0BXx2TqjqmeTBa3V3ubwAIbfxcJ5InAM79jB34A8O/WHIcly/LCper74BUNcExVhhy5bNlZFeLJaH7scOphvB1CmddSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUFKEXvxYmy2Duhk0Nw1ezIiYVtBTUTAAQGVCWNafsY=;
 b=v089qJr79zLfRP5rnTXsXTDL+TbUblBEg/miavGrLnLOIor8JZcHNyRm469MXQDwDQX5YI/ZYRS9cBC2mi7RuFlvaaVDcqY+dRmtXtckQFazpaVQeK44fOWcBcrRgkyplPw5F2DlSnS1RUk3M39QrF78KrYUHGJEtBzcgEzohg8=
Received: from SJ0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:a03:33e::22)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 18:46:48 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::24) by SJ0PR03CA0047.outlook.office365.com
 (2603:10b6:a03:33e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Mon, 9
 Nov 2026 18:46:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:46:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:47 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:46:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/8] GC 13.x support
Date: Mon, 9 Nov 2026 13:46:32 -0500
Message-ID: <20261109184641.3656885-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b7dc84-bd86-48a3-aa63-08df3e91cf7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|10067099003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021121427099003|56012099006|261009223027099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: IAPGR05DQQ0Y9gUGR1dLCgkRza7a5Ef001g0xF1AV2pr3LOLn0DKxVpov3BLeK9j4EYT/Yy9MpsDqMq1Spt6pVSRayq2yiFN2mcURa5bfywium1+ZxrIUUEhmkATTGxTOceyKYyQDTSNXURhM2Oe2fCoqtv+qAkZnGaInKx7GtvziwLrOkFP5x2gzA4u/nKgxKmxBGcNkfJ/+g7eWOFCzLLLjNhebhXSdwFu+ke109MefkqzOEZq3Bwcn6dljbmjfTDi9mZmy0IeNW0jCatUv2TE0A5d/xrO0sVfPnY6Td4pMKEX70eIer4GWQ19x/GMhbRCvGSjvkM2SsxvwFUre2YmP4t4WT5K+7wuWdtJFUlfMvMnYhZDJnC+bx/z6/2nDSpgE8VAzqmWblJvIb/ewZsaRMjfanITtSTIdoLqH0yF0PumkXC1qntRQua2KMTVaZujovKumtMin+V3+RPvhNfO0dsEpwB8h+HgGxMbFh9jGiPF3/88/Q3twXKCKAZrkGsM5cRY4k1b0rqKaaW0UQlO/uUwYyBqiprUKU+aOYl6obTQut+V20K1x+xWS+hJTvhBiwFmpY8AAheHAm4YTyRhNWK2ECVQSLiRqlGujWGMZYGmDoSZRovl1CpEfQC7KbocmCVqX87EvsFMCxBA2f/88lRKCN/lCZGWA1ku7t7YT5tjeDd5c4Hqqe12UvLSk8VlSguOBpWWeoh9VA59EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021121427099003)(56012099006)(261009223027099003)(261021123027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ranRkG6JLFDHrOF4uEA3o3B2PRx5/7M+hPVIhgT+iXy6S6TZEcwUxxA/IHxFiUu2zllfcUYvLw++bZ5kBwwk7uYsno3YZbyqusy8TDp7Rtb4TqUBwxaCJPlCijPkZGA7sn46RZcfmlv3N/XreSQGv88Cp6TkLr6kEPNIdIQ2uRNAVJg7hxUa2MCVaSmpMtvhH5ovPoLl8yNlN7jC9NpKH8iR/r3iv42opZi3mmPNE5WJQmEd/werbzaDXBdvV8OI1QB6K2j3ZwcAOI9fIAwXn84BDYaFyZUgk9Qyp+yDYVyVwKUsn8wqWHTQffa53WtJrJ9KRt5Ld7kbbU3KskWrx5wt0OI2yw38d4V9d1UEn8DY+87WTaBj/6BKWBvSmDPQsP8qa0T99WItyifI7/BQZAUUni9FQHQeN6CZSpBvftzeZZJU1WBySfpaAiOPCy+H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:46:48.1202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b7dc84-bd86-48a3-aa63-08df3e91cf7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial support for GC 13.x.

David Belanger (2):
  drm/amdkfd: Add CWSR trap handler for GFX13
  drm/amdkfd: Add initial GC 13 support

Eric Huang (1):
  drm/amdkfd: disable queue reset in topology for gfx13

Frank Min (4):
  drm/amdgpu: Add imu v13 ip block v2
  drm/amdgpu: Add gfx v13 ip block
  drm/amdgpu: add mes v13 ip block
  drm/amdgpu: add support for gfx 13.0.4

Kevin Wang (1):
  drm/amdgpu: enable mgcg/cgcg/cgls for gfx 13

 drivers/gpu/drm/amd/amdgpu/Makefile           |   10 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v13.c    |  521 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   20 +
 drivers/gpu/drm/amd/amdgpu/clearstate_gfx13.h |  121 +
 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c        | 5808 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.h        |   31 +
 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c        |    2 +
 drivers/gpu/drm/amd/amdgpu/imu_v13_0.c        |  289 +
 drivers/gpu/drm/amd/amdgpu/imu_v13_0.h        |   29 +
 drivers/gpu/drm/amd/amdgpu/mes_v13_0.c        | 1862 ++++++
 drivers/gpu/drm/amd/amdgpu/mes_v13_0.h        |   29 +
 drivers/gpu/drm/amd/amdgpu/nvd.h              |    2 +
 drivers/gpu/drm/amd/amdgpu/soc_v2_0.c         |    5 +-
 drivers/gpu/drm/amd/amdgpu/soc_v2_0_d.h       |  680 ++
 drivers/gpu/drm/amd/amdkfd/Makefile           |    2 +
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    |  568 ++
 .../amd/amdkfd/cwsr_trap_handler_gfx13.asm    | 1181 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |    7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   20 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |    4 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |    4 +-
 .../amd/amdkfd/kfd_device_queue_manager_v13.c |   90 +
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |    2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v13.c  |  459 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |    2 +
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |    5 +-
 .../include/asic_reg/gc/gc_13_0_1_sh_mask.h   |    2 +
 drivers/gpu/drm/amd/include/mes_v13_api_def.h |  890 +++
 drivers/gpu/drm/amd/include/v13_structs.h     |    5 +-
 include/uapi/drm/amdgpu_drm.h                 |    1 +
 32 files changed, 12643 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v13.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/clearstate_gfx13.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc_v2_0_d.h
 create mode 100755 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx13.asm
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v13.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v13.c
 create mode 100644 drivers/gpu/drm/amd/include/mes_v13_api_def.h

-- 
2.56.0

