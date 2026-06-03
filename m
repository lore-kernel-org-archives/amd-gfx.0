Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145E7CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE68D1120C6;
	Wed,  3 Jun 2026 16:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JQPU59MI";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9001120C5
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gs+4fpa/tpEf73Q+3qf87EIj5SfUSABxwb0Aswp2fKL9bi1/KU+QHUIwYjqBkQkxPJ9BRwTjwxD/M30537zBsaOd2rUEioURiklxM0LZUBlGQb8BNJ1t1cBb/L7kXHK8sg3aPKwpUu4z9uRAuKeibJm4If0bnqWETDeoSHDiqIfJ4ObVFtqgHnDFL9wReSc4NxQgkwndh6kJMHSFlT91dURAIzN/XtVbRfeh8BQ2peFmacG9krYaAyNOMNOJnQ+S/H9HoFmEhi4IlgUfls12Hz1lOaprMm5veJzfKvXRvdLG/kfkhyWyJC/C/rr96Z7rHWduU+2sWIu3arvhZ70IZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb2fYxZXPB89jMv6ynuRcCTfpsirWSli5bhs3FVbT0c=;
 b=PDORCVjETnMpwjjeiXX4JMfB6mSXF3bRTINUDY2aZggxF1o72t0kcovecucnlZff6j31lf2WZiS91qVdYnfqCWzUQRmyd1QL+EcWj0EOqtsRTj43b2JKol3Lc53USKW53L/PGdDclKi3cBgfj07iMHggSzWfg6xczgqRlfY0BB3q0uEaGBnOZgz4zf6NJgH1t+xWhhzRZhndKezx3Jq1UVNwYGpFtBKcSILjFAChKtjQzV8IAew1h3dYxdaWhj2rMRxTptsEp/jgdwvlC09BLRWnUQoJC9GNJGrzFYxG2Iny5ykwi0EKCPsP2SA2RO3IUeD7ee3/ja/PN+0Uy8AhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb2fYxZXPB89jMv6ynuRcCTfpsirWSli5bhs3FVbT0c=;
 b=JQPU59MIKBIx+OHOwptATc9wxtackWGkj5pB7tf4FMgk+iNfqRIkFzu4AspGoG70rFpMN+pHjzlGwemh2mQpqB6S6IdK0tgN+UTx07AlB3UcFtkkPrV687W0Ioy98WT/IcPYbwrLGniiwY9/z+MPOmoAr1pZhI4G2vlVKiJOwPA=
Received: from BL1PR13CA0340.namprd13.prod.outlook.com (2603:10b6:208:2c6::15)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 3 Jun 2026
 16:34:09 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::6a) by BL1PR13CA0340.outlook.office365.com
 (2603:10b6:208:2c6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:34:09 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:34:06 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 00/11] drm/amdgpu: Render-node EVENTFD subscriptions
 (toward KFD/KGD event unification) 
Date: Wed, 3 Jun 2026 22:03:39 +0530
Message-ID: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f75a121-45d7-41f0-329b-08dec18defff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3MjIQc/okGsQB/04BwyQ481N5e9/Yo5boPeM3DQ4vl0x9d11mCDdS9VOgpEnwWrvTEckw9yVhQA5UedGjHcndPWmn/yvC+KYua6+Kph3HvN47rAovwClZwIUQ5ZooVcOVOIxUYCB6IwfU3bFlGJ8pjp5xch9453NoXxjcW8Ollwopqkub1ygAEiZSPV9VaZLA2kT98btDPDG76KudkzkBftoacrXSZOuPhrkfFVYRauTq8ylWkXE9Ojd7ggsSrEvqV+B4EaTCe9bw2WnunMxsyEUxKbKUsfMBnE2TOO4+CFYDICYqlFVDT0RYAVGJL1xUoyE8RU5738fQMBIeV0QUlYhdF+0f7dVVhaeaB2wOkDdTzAlQI6oLs6SbqUxI3WGh+7aBo6c3DHMStojtB2j7HyzOIO6sCqLYk2xjffDfbex0IVT5C+8/aVViwYbLWMeK+EGDxbfGAYUsSx9is8tfL/l71703oW92bt5fK1wDrhlGq33VJQy9BmH6qP6Lz6P1+aoT1Daw6LE/XMd3HlRMrS0Cj2yhvlIp15V3I1ZNfYwlE60+uPubOQ2zj4JmnILKBWe+yvbwiCwICo7h3IbTapgS+fj9hLVcCwdm3Dgft5o8Z+VGi9SQNMxTUFboZ2K1f51QAc3faV+aI/oJvyffqb7g/FOecp/IFzhUe9DHoYGOOWW3ZgEcbXUvcPWkskSrhrbbepB5B96occu64W7Wg1rmmtzXa5Z75cjmzNGe5A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VBc/ZY/Exl95HJfpaD00btUCTQIlZKWPtCDx3jgbbnjigc0r2krkE+oUqqgF6YuDqiMu9ytwVkqv1gq9nfo09uSbDla4WprzUGwV343nOcKjOnteykZ42GVV9a2J8ZyCOHJXsdHzMqRO+ILx1r1l07wWvDX3Aat15cl2eNxj3BfJx4tdsdwXbGfJiAqrvqOu3D1rci5VFtSdWfgyFPaLDW/MgAkJs1rCRGpo2JS9iZdtROUpCNhvub29OAwH0/8uSIynxEmCvDsbXfqVIhj8tN/45TZUNdsKDbuB8DMu0tx72fFH+FsvmPDqZoNVhckixcQ725SIcogZn8NmoY9l6V5sWOo3YnfaR5T1Mu2E5hMah0n+EDUo55chzdaxUQsrJ4/eSYOjNAusDvbDwmOleNm59kaZsOJAbKuQ3OVILXIJO7h8N5GL7GeKCNBUNU3M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:34:09.3747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f75a121-45d7-41f0-329b-08dec18defff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series is rebased on top of asdn commit:
1b4722a07966 ("drm/amd/display: Disable FRL and add module param to enable it")

Testing:
Compilation tested
Driver load/unload tested

Srinivasan Shanmugam (11):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
  drm/amdgpu: Wire userq manager to fpriv eventfd manager
  drm/amdgpu/uapi: Add unified EVENTFD ioctl for render node
  drm/amdgpu/uapi: Define kernel event types for EVENTFD subscriptions
  drm/amdgpu: Make EVENTFD subscriptions queue-aware
  drm/amdgpu: Store user queue qid in amdgpu_usermode_queue
  drm/amdgpu/gfx11: Signal USERQ EOP eventfds via userq manager
  drm/amdgpu: Signal QUEUE_RESET eventfds
  drm/amdgpu: Signal MEMORY_EXCEPTION eventfds
  drm/amdgpu: Signal SCRATCH eventfds

 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 416 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  67 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  44 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  21 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  13 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  |   7 +
 include/uapi/drm/amdgpu_drm.h               |  43 ++
 12 files changed, 637 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

-- 
2.34.1

