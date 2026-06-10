Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D61CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 06:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B48710E70F;
	Wed, 10 Jun 2026 06:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Z+wVFmG";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A2F10E70F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 06:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGuHddvZD/0UmnRFOb8F/KZvgun2efkkKzEg0hxNpCYistcix924t0EHBOAosst5z2ueRphIJ96QvF21mjjfB4f24yjFflsdprO29DjVAhPQh3JgOwRQamPmPFmZOXC01aJVHnEFaLhUcERKSpXtpnf4uGoaS5Oqj46KfTSC1w4Yh6W3TfIX/E8B52l0EGAkC4RqExNs8WuH1Q4uthu2WQaUiPeTup4oD2Eh6mPK8PuD1MGSQTslaxMPLU2Iap93sYQvDdStkUPXPjYr1EZVBBv8nTAwNa/c1wJBWtNVixTLf3hGo3iZipJvueRgvXzfv5wC1hGzYKQNuEOgMEPJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+hzoYuaJGWhVqJRATvJhcyco37UeQwkd+FSHgAqGB8=;
 b=F8VxZgx3c3DRLHdtBUATy9JIe/rkP6GhMLwiaIVPtlEdB5QX70n6Md+v8jUV7B7sMU6g8JNCCtYRwWAeHr2048Uxz+tgHiwdA9gBTjxvccGMq/ZXAWKNEQBLBwmL6QEPdAMaNS6ssIvHvPiugaXHFr8fTPk66aZabUeJKeYpj0c4d1eaxZjK7j/uo7As6QhqKj6cWh/wybkZh1GwjBJmbNT4xP/AeKQwhQLgANVk70TcVJVGdxgGEaYScwXFKBHlB9r94CKQGE0HtPktD5x/0S91MVgY7rj2+CcJMC2l9vFP0kH1t5IgqdspNBMi2jv3KdCyGFIn5pc9jACKAXFubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+hzoYuaJGWhVqJRATvJhcyco37UeQwkd+FSHgAqGB8=;
 b=4Z+wVFmG1h/bmW9KqVxTLSXXuKG9GkcWZrjjoJTfmrM8m5fBiF7JDI9xd9Kp/L17ar5FbkAMwAFch1I9DPOgbU1F8RYqafwarYGSHhlXwE2X93jpuYi4vuSjC3GXkJj3XXzl5DXsBceHVnWeQgp1jbJYqpa7vPhs9J5xgg+gHac=
Received: from IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::10)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Wed, 10 Jun 2026
 06:04:31 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:461:cafe::81) by IA1P220CA0004.outlook.office365.com
 (2603:10b6:208:461::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:04:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 01:04:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 0/9] drm/amdgpu: Render-node EVENTFD subscriptions (toward
 KFD/KGD event unification)
Date: Wed, 10 Jun 2026 11:33:53 +0530
Message-ID: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: c10f4c8e-7228-46a5-b546-08dec6b622a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: IljEX7dWIsCvWV77Hu7CexLNK/tzO5HBrBYqtvMaG0o6gp7y41I/47Vtl+cZRZ5jh1+09PTQtapT8595tuA684/DtRq7ToI+s+P9dvQj4qh0jlm2qn9LKaxSwFyQ96vQ0olJl4zLkyXtUacBxvclDUiwPHd1t8mM6fAH8C/Hub3Wd+KFBPTM1WyYC+Uoozwy+Czl2yXfKDQx8WZ1QtRJSNUuLSy+HMu/NblF0sF/Du4TDLJ1FxpW/mRTjJ+Yr3X+jec3/9vpHnNDQX/LTluyM23lz4Z9YJTNxyHhVPLfS3vK7PrA+coPbVviFlXAXBk79SBBOA8gnBRLOy9uhyC8ttO0tBztXSw2BwKMq/mbOWNHmJKh+PL2/u/66zFZi6f5Egc60RYeGLNXWokHlsQVK1wG3AytUAzFR26bURGF7Eds4LAw91uWM2uMzEYh1a7YEhwFbK+EcQIYuO6rmtL1ijld3NH1Q4riYWz8/C2g1uYjqvSdl9+QsxMizkJomF/kMTyw0JsZI8UGA1cYC87eXQpZAwbIVQk5OKY91+F+tKv1UABYklpRKP5XT9ICIjzITEK4xSky20NSw4VJVfUuhK1BbVtGcGp5mHnRy5alf82Hqf6sdcVgIJKEtoKpe2XytznYsPUhrhixHAqZKaTFTLfyZdFU1QoDJ3KD+MdW8+Z3smYohKLLxYbHmdLNHyV17vMP1tlczZzA+rCOPbx4e5pGpc/O1ZGvlkbi5ZRCGYo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7KCr97/gXuA+2hPr5GIiRWH6XPEffgancyC2M72fon56womXf2u/IO+7zFa2kFY/IgU9s5bCaxnPXGhUqDzvtQ7mEQn7xJMjFOP6bZxwkFfKPEPR75daWCQeR8B7f83krbNq1ciUGVPH9G+NWBt+FJbsr7p6Jvrc++X/jeKbMJXvnSZrBaiCkPII/FnltC9wBeRbZZciaciPoMQmYfdGWNmdnIyRckXgN/nnNkYR4hrqNDDZ9ruYYkT5ehnwq0X434PhF8rOhGySOxDbN7Gkxby4MbX+qMs3Dj2EMwIMmjQ/j1YzcfDL7wiHpXE6ncJF0KX3clY4IttonTp0Dppwk7FZQFzjkGxwoVL8TI9ApiN/Zb2qxKQxeGqNUS2Qmlc2BbSDwtnYPEJWW7NiJTLfd1gDLupBmo9T2MMPNFQhuLnt5Lh7/X7I+vaVAiaadith
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:30.0264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10f4c8e-7228-46a5-b546-08dec6b622a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

Christian's review feedbacks addressed in this v10 series:

- EVENTFD manager embedded in fpriv.
- USERQ manager wired into the shared EVENTFD infrastructure.
- Separate qid storage patch dropped.
- Queue references/doorbell-based routing used instead of raw UAPI queue IDs.
- USERQ EOP routed through the common EVENTFD path.
- Related UAPI pieces consolidated and cleaned up.
- Overall implementation simplified following review feedback.

Testing:
Compilation tested
Driver load/unload tested

Srinivasan Shanmugam (9):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
  drm/amdgpu: Add helper to access the fpriv eventfd manager
  drm/amdgpu/uapi: Define kernel event types for EVENTFD subscriptions
  drm/amdgpu: Use queue references for queue-aware EVENTFD subscriptions
  drm/amdgpu/gfx11: Signal USERQ EOP eventfds via userq manager
  drm/amdgpu: Signal QUEUE_RESET eventfds
  drm/amdgpu: Signal MEMORY_EXCEPTION eventfds
  drm/amdgpu: Signal SCRATCH eventfds

 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 491 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  70 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  51 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  31 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  18 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  13 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  |  14 +-
 include/uapi/drm/amdgpu_drm.h               |  43 ++
 12 files changed, 743 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

-- 
2.34.1

