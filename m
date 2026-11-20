Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C07606A333
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iOPt3hW5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B23112ADB;
	Fri, 20 Nov 2026 15:34:48 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D6610E912
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 15:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avtGbLhVW+vLoliBoNoRppqhj+Exabb3P9i9BebT0xmddlcsff7f/9jycWSlCbH0PAwtBRZ858mMESQQKJDGtR4yRdJNUzCYi+BTgsUk6UUikvnoQuWgDB69eEzXb3cGRuoLRKvEA/tUmrS9YKn1oNfx5XXzcC8rQDmUAFgnb/5DcFw3Im3rNUT/EJtDfQA9KDSo0tlvApeeg5nhMW72O6aR69d/I8UhJbP7BHx/KkV/cLWHO4g8ARbuh4QjW2sFA47uCn9PKdm5tCnqAlJ+2rlJTOc5XjUcKWvAdpOWW2zJNWPlUFQ1s4nGH6Y9v2OY4ULaRVDahtsE1H2pLAKrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWqkLScWGhncdwW7GVDzm/sOHg+8HHjGQikVbtDkao0=;
 b=LKwBM9lOCS0sjMtXo+PMa59HZz2PeEgn91Gq5yMpJV05fGw8NrU7RZ1/StqrSgvE4nJGnIHaDZy4C40/1ypw5xVGjKwUv982dIQxrFg1EGkHx7V4il54Kou3xsYrCB44L6wESxs/gvthLLHHK64i3sbKJwryh2yJzicZ/eOJbqWkSNrZtv0NKt7MGrhQ5UTyDdluw+dQ1uF8pnQ9k732z5rDeSI20z8ECpgBqWL0tLN+ByZx3ZkzMYKgVafnyHwjtLAmFD2Ak6pnj8Mmh8e4/IvQD3dEB65r4/XALHDu5pgsF0EiHSDis0zd0jPhkERB0uB7xKaPrq/yqRAXKN1bsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWqkLScWGhncdwW7GVDzm/sOHg+8HHjGQikVbtDkao0=;
 b=iOPt3hW5LI6Ub/Ww9G3Q7vIJeWdEc777TAfl5P6I1td4mrJUlAdkssCG54/K7TNJdALpTfcdcNIVXXgJlFqzNSH6ahHDSGcVJvluYf21c/JNcgT//sAYcevMqOsN721KgrX1TpbjKWxwjzZ38KhioLbqguHI+Qe6ccIOqA9EWJs=
Received: from SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::17)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:34:34 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::86) by SA1P222CA0122.outlook.office365.com
 (2603:10b6:806:3c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:34:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 15:34:31 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 20 Nov 2026 09:34:30 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 0/3] drm/amdgpu: Add CWSR and second-level trap handler
 infrastructure
Date: Fri, 20 Nov 2026 21:04:04 +0530
Message-ID: <20261120153407.1691331-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c366f1-77bf-49e4-f311-08df471bc5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|18002099003|261009223027099003|11063799006|56012099006|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: HeJauu5otQG69N5XkXbF+A5nhTmq6kfnWv1fPK49qXi1lOsJ5i1IG2hT1GWNyCnSUXARgodhoXgGt/QHe+3rQUDovU90+LNqQD45wHeH7BqDYSWTSgFsu2nkm/8tBgFU+BArC9EV6pYd9OxdNfHuiHiNJH+WjaB71JnPeJREC0axjDHiZsN88xqdTfyFVfeOfPd8u7gkCpZUFW5Cu4hm8m67V4++4qxP61CyJ4GhG+QR/0iMP07yK/TJ29o5vyp91l947u4IJvdNZcfFjAN3g+a0KM8yqBgZ/cGltFqNE5NKAqslrVpoEgDUnCLDqkktUPDm03W8DHN1rb+v8tZzljT4YKGuPEGJeP0DaxwNKxmBZCmHJEpzKpicvDVogsqrdqWUC45rbaa75jZSkVYuMXJcdxLUi5e0SJKGUOtYdQ/gj2QuEr/msEeTVoB1yKddJlcbg5K13ce7a7nb4vy7Sps2faZfwUNJhn8WsTJ7lkajtpzVGv8mMgeCxyPMYuQs8sf2p7VDSySmuPp06YEJRIohLHdPKiq0UNFK0mQzsIp8Q7Hi7HScw9f07Isl0VgT9RxdDMf9Y2tNBxtFTU0J6w8PPg2kFm651e1ACWy0jDwht/Gc8p5bsvhVDjEaGU2HstuKw1kKZ6H+wshEkWN71+8NO7qpszWcF0mJ/f6fmAQlPsa+o4PfUCtg1T6HE8+NXYQoY9UN24sC/mKt8DElqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(261009223027099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rwT1/WH4i9TGHto8mdSqgMHeSIJRqfXHrtQ0YprmFYtcWx15uzrKkbIoy75xMPyuJtbik8ohQb894on2kG1E0NUALTGEsnoJnU37MiFg1f2Vh0hkN/PxqLBm+QDZ84QczBmM1oU1yv1LbZBQdvSjyAuPD4xA5hjlsHd8qOivC0xSDiI+GJjfjPy7ckK/CjTrQrozrzQwv26G+rDPw0RFEqK7uvOJrkDPHUAqe9hanf99bWdk+4Uz+x+uy5qTnZ4kSLJxiaAlmHlG8t/NxBiri4liNb7N2Am7TchS+eekHOh2e9jSBWINL2UM/xaPWxPDLWqh/6DoZ7zgV/wvXF7750lrC+SUNil5Hk04ApE4kJTR3WS9uVsGir+SDQYFDzOtEwrz9VDPNLdwbjXxrdxUQPLKyu/lcq9ScH3BpWbJEjQgOYzXlPiM64r7xsOqjzUP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:34:31.6994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c366f1-77bf-49e4-f311-08df471bc5c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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

Changes in v7:
- Address Alex's review comment by separating the UAPI changes from the infrastructure.
- No functional changes are intended.

Lijo Lazar (1):
  drm/amdgpu: Add CWSR and second-level trap handler infrastructure

Srinivasan Shanmugam (2):
  drm/amdgpu: Make first-level trap state GPUVM-owned
  drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs

 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 771 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    | 148 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  62 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  14 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  28 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  75 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  61 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    |  47 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    |  59 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  55 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  |  55 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  |  72 +-
 26 files changed, 1704 insertions(+), 61 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h

-- 
2.34.1

