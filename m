Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4FDD58E4B
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 03:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAAA10E1D9;
	Mon,  2 Mar 2026 03:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q0qEQYnO";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D7C10E1D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 03:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGBmNAB6DkTefXF7tpsETlUefYkmmbX7860BU2tqltbng89ty79UCiaFGFW4blIrQcJl7sMF5IpBwT4wZGBVsAiy52GCepIUfdsaDnn2Sup4CuUxlilL8E5VrC9ut4vohSEFFhasejxHnh1TxEOwzegkt947k+IvvPTa5g9mBLtd5YDVWbtNFM0zhkjPfc80TR+JINCa9S4A1Rdc3N9rnDbyUpziBtx1tD0JBN1vgJ7tHObXLSMYJ/AAM6i/vN99aY19gQftOxTZ2XzdbtnATf9Nqq+ySZg/3IoBrSBiuQxmmlWCuY8LmJgcJVFeu10LtCHdgFVrux3UTpyZdiRulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YE0hWnG5jr1hkoIadgc+FAFz58g1t+VIeXvdeUitwE=;
 b=FPufO168iEj5dhLWUa5e9AjwW3nBX9UO6johQjQ44BAOllzLkXker77zRV86N2N7LV9Jq+Pz/tXDfgO+07lwfuu6IMbdTnunNPfPVdoyKbr6fqQ8NXQfmspWgZWk0tX8SjaQgSDDG99iM/3IMqWRz3UxGvP7xVfIaNY8eXr3nwzAQsXV6rxz1nh5z80+uNlo/5HlhRdPOSH37xY2BQgtUodvK8LkA0AyBSULqc2+WEWILKO+96SkxmozutqqYJ1JQPpm6fc8FvC2kzyN7ppKFc+jaWipnU5y8zmo5p+5yMggQU6jZp8vv+G71ML5tH2CrL5xojBpA5B267EV/y5jEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YE0hWnG5jr1hkoIadgc+FAFz58g1t+VIeXvdeUitwE=;
 b=Q0qEQYnOu7hKj/KLVUc46g73XWzHWDcWcQzIcKFmj96hcKk5t72vQlJOgdwO4bzQExT9LbktEehFwh8gvqyo4VyeLCWqRC7YlxCu7yTXXUdfZNC1yEdNV3csIq9EIKG8dHJWN4YpcH2042k3PHoENDiZaaf2ts3j7EOhJIxfYOc=
Received: from SJ0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:a03:331::13)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 03:02:42 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::2b) by SJ0PR03CA0068.outlook.office365.com
 (2603:10b6:a03:331::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 03:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 03:02:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 1 Mar 2026 21:02:39 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/4] drm/amdgpu: Render-node eventfd subscription
 infrastructure (toward KFD/KGD event unification)
Date: Mon, 2 Mar 2026 08:32:15 +0530
Message-ID: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: eae389f0-4cc4-4f6b-170b-08de78082b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: 7BSBjKkB7I4Abqiu+34YMav8vkuf2JZcqzTZy3OeJbA7MsVqyD3KVqY/2Cw2lTg1ALzlOCTXj3hgQDaa1rVjt8kEMLehvFJM49kVxPRUjCDk2EqiQywJVmMhUrMQpbn3id9BmttSmGiZcFPmQTcSOuXc/yRfVgAzv1FHuo40tuRRDsT2nZSiGVeoOMMLSEcTN0rL+n2I2ogfiQ6PACpCn9VPekA+if8oLn3brto92LOK8tKvJbZxb40SsBhfVTYCukK/wvwE26YxaUOkUJe+pxFcKmVJ/FStGKfv23VXH9G+nxgTbf35k3OyZIfgvd7u9P3CAaxUf3fpN3fhHdhl81AGEOAkpgkMh87WfWalw7zMEr/6EeQcrYD39WcAjhC33dOJQOs4motmXa5LGdvRkuaXq/pAyvxQY1UCWucepFMxLlw9yDd0Zo9r4+0mvXSvrFmlPlnd3yDLgxUBZ66AQkA1AIcUbKtr1kLkeO2lLc6PeFsgPdafvXMmLh8h68iAyhvPcLi+AMnRMnqirZNuyM+wxG3w/u8emL3Btu/vkLAEH9iK7BYgvfdVhX4ekl9GL4hh2PUEx5MR95iW2WPmoThN6sTLH4/nTJOG2kkE4b2gH1d1xI8HMBOG94TWWRIroP5m8mk82hS+YtX0CdGWMNc/SeUK8JcAZ4e/rqoh4wP7FtC0Nnez69I/Ow1xnCLbmudxejjr/I5JVo01vgP9884pyWwqCvfBll8t5YTcrtNB82RyPrDfrR6uJ5iV2fdYNU3rF8Ul399KSdbvXDNszmJY8yNosnaxtKY8tmJ54BkZzeh4QffDK8f7lmDHD2nRraTz0ytFczeOcv8bhaQTaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z2e58aE4tT9EYWzrD2h/+l0fAgOydplZIG//c887KZnmbG4+Zywxq0Vc1UW7eMmkvqF05yg+BH7bK3fX3IINYSlmSvLFzd4Wvsg00FR8dHIVFvjntJhEoxxNCo+2XmmGbbT7N0cHn2Eprf9hIQDz//EBowt6TAXpGxfqRUCoKHinTQEJvliufqayqC/A2bp6gS3wfdVTa5s0DnF+ZEfV0WU3kQDphaxMIZzNfUhVx5FEotWbP3BiT0cWR06Eenp7t/ZkpadjMYvSZmD+QF/JuVOYBBK3uFN5M1mmEdWNUWymE+2hKYk/suiyTE4xMmuHNB5WLXNynesfkSJbNmDdSRDjBFH6NqqL+eZEGlWtnw0qSMlNZMLeDLnaaN8NQmFLbyMZrFNuBLq9Oh3tIzqqVnG4hGdYZ+rV5R0p05WBPqY0EPC54pu3ARVmfLdkqpdN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 03:02:41.5858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae389f0-4cc4-4f6b-170b-08de78082b6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

Based on Christian's feedbacks:

The core concept is a per-drm_file "eventfd manager" (owned by amdgpu_fpriv) that
maps event_id -> a list of eventfd contexts (fan-out). The manager is kref’d so
it can be safely referenced by longer-lived producer objects, such as the USERQ
fence driver, which may outlive the originating amdgpu_fpriv.

This v3 contains:

Core: amdgpu_eventfd.[ch] implements the per-file eventfd manager and wires
its lifetime into open/postclose.

USERQ: fence driver stores a kref’d amdgpu_eventfd_mgr pointer instead of
referencing amdgpu_fpriv directly.

GFX11 producer: wire GFX11 MES/userq EOP IRQ to signal a fixed event_id via
the manager, by resolving doorbell_offset -> fence_drv -> mgr.

UAPI: add two render-node ioctls to bind/unbind an eventfd to an event_id.

Notes:
Multiple eventfds can be bound to the same event_id (fan-out).
The UAPI structs contain only fixed-width scalars (no pointers), avoiding
compat ioctl issues.

Testing:
  - Compile-tested only (CONFIG_DRM_AMDGPU=m).

Follow-up work:
  - I will post a separate series adding the KFD/PASID bridge:
      * PASID -> eventfd_mgr registry (refcounted; no PASID -> fpriv raw pointers)
      * amdgpu_eventfd_notify(pasid, event_id, count)
      * Stop depending on KFD (kfd_events.c) to be the place that “converts interrupts → eventfd wakeups”.
		Do that directly in KGD (amdgpu) where the interrupts are already handled.

Srinivasan Shanmugam (4):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu/userq: Hold eventfd manager ref in fence driver
  drm/amdgpu/gfx11: Wire MES EOP IRQ to render-node eventfd
  drm/amdgpu/uapi: Add EVENTFD bind/unbind ioctls for render node

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c   | 321 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h   |  76 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  64 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  24 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  14 +
 include/uapi/drm/amdgpu_drm.h                 |  18 +
 11 files changed, 533 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

-- 
2.34.1

