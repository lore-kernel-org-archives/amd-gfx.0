Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9A0F43848
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FED310E24B;
	Wed, 15 Apr 2026 16:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NzaP5xgZ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7030B10E24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJyiwENPIafmZKfz69ukRJR/s6ypW0pWGZFXWc6SUOUKemMJ+JrHrgMq633Lu7e8RicRfkS3h6uJoLPRYETdSF5glNIYduNT20OVJz/4LI0lTX8x2GbPmqsn8yu9O+p77EfiUthkzUXz6naOZpLB5QHwORE/M30DDyH1/NWlblzP9NHQewNlFhg2PbFmuuD5HTHx6lO0u+uxasXunr98i9BQZaZx6fHzQwNGlVLnrZ9koyBqaLA2tsaApMO/U9xa7DmDSi5nwRMTbh8/MJLD9E0IzfOzgt3zxJtsF9g/XD+RxcDjnrN/0jweXtJzOoYeW+9MWTha9Dmt/lPmPdDZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD2wVSkcvbTU3ttQsMaD+ZhsbSSxroj/E8O6X5/u9ZQ=;
 b=wzO7zmhoEk59IzuJu4pDKWKPHHokffJrGxH5tUeAI1dAyYomhp4ZaM+c1hvPMIaH+k3GTL/axLNrmp2jxHEKUQiTg/75r16ksAkZCyx/9PWvIIDIOBeyUBt6GLliLpKpsEis6dUKU10HxOaOGcOPLJZrsAQ84IfLzt/yvR/cgj7dAus8aCgBz1nQPz8bDKgAiHIelOBs817eWikBSzVsHA6dM8X4GqUU+Qdv+XEHdOx1FhKJ2w0Rs+WaFcYvGmlPupqKhNARv5tz6VfofHJneRFjykS7aiqKiG9bTXgF0FZtShI9RJIl6s2TPzvdw6NU4StUPXurU4qbXtjXulwVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD2wVSkcvbTU3ttQsMaD+ZhsbSSxroj/E8O6X5/u9ZQ=;
 b=NzaP5xgZEJsPY+hdlMnPFT65hyFoqYRVgqQeZbo4BXwt/uNOHEcuQCHBLQ3gtXqvticCY2xXv5qPD5IEXeOAE4hm6iqvC0JPUVl6ZYLQ3c/wLhdGuPdwOa5UCfyXz8wZ6I6+acIr5U5GSLvgSpbJKZyx0BlZ8UjDChwdE/OoyII=
Received: from PH7P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::25)
 by CY3PR12MB9655.namprd12.prod.outlook.com (2603:10b6:930:100::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 16:07:35 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::d3) by PH7P221CA0011.outlook.office365.com
 (2603:10b6:510:32a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 16:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:34 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 00/10] drm/amdgpu: Add WAIT_EVENT ioctl for render-node
 events
Date: Wed, 15 Apr 2026 21:37:01 +0530
Message-ID: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CY3PR12MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: cb39a48e-edb0-47ec-d8fb-08de9b091b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xfDMyu1My9wB5UA9xfZZy2D4bVTyFgQz+X4QOv5H2eCliRY4ndafNmMQ+jUIX49qToaI3ACtQff34wWdHhqHx4m2LsHIClYgFn5hiu+i7YgxmNid0bqb5JYc0e9sn/iHKEERoTw7/C3B5xRJNN/XNmnxm8XD/4nhNiGkliV7eSBkc5TBW4oCyAMz3BCYZaCn4wn0TnPotTuF6WrKKDgaMCt54MAKV9gA49Xphan1WADxeVtIRJ8/KJCG8KQ8RAyCyw9V6iNLABgfKLYAk6YRK8JmxWVfOrzfgkoOzq/RiKLHUJtsyh6P6Eok2hgHuhMzc2Q5aGpbZNZYfx60a1m/XcLaolHnM/exyay2cmIli2et1LcqBrDCrYhTaLg5fuufVCD7DuQkaT9pTbJpFP72V5Ljvd8eVzaOibOfyHPYv2JeLOSZg/B4HFgUzGA+L50WxPveWVaK5M25KU5P6bkeHx5bjXh2CUGddb3eyomnaoNhURFXwTicHWxfHhPuxeg3wtw3fskrg6igcR5P/6+F9YJc03hvFKut1CnC35slCbdvqUxm+P9l/NF9x+SGBejKeF6aErFW+kjHuy1GaOEcfS/p59R4sOYID6dLKj2D9pnDu6GERxJdSzpp1F7PiqpGK3wspNhNu+txoO961Tm4dYwTNwEForl1O3WMpYtaxEHwvlg/adtykBh7L5sYDPUCZShiOTffX/aeb8MtsihUbiVkuB6pHiqyb9UAai+hUvVzNHC0urMVPA0Sa80b/XliO0+GN1uBDiMW+dZE8zpZ2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9O0astjRfwIr7LMB95U71AgQNUOU/fHzOxr0y3OnnQSWxRNcsassavlfstWmA+vM0ntRYjTBpZzIqEV7ZPnD3WNdr0baSS33u3lyuvYt+X4w2HqCYJd5A5RCuQll1C06YhsAXlR365JKbTxqWSrLDlssfHrW3yvPX4j41/xQ/iaV+nPPE4MEhS1tdBUulZxZqYPC+UntAMbibh2xah+W4donwtIRqoK9vIrQfVaA3yUGZHJFvN8K+sFJoHqKpJEbVGRGpvNhx+JJHju/mSA5rT1RrWr0dKY3j4mMemhInvyy4idXZVzneuLzpru/Jkb0PqFPGRPOvZKfPWrjWHXJ0y7oI3UDXhaw4oov0Bdgas+ZmHVJugfBWVifEDWDvcaeyvyPa3Mm6SLaPtR1Cdx1xfeZPjqLlK8jygttcw2YsG6xNCli3V8o8NdPNm5aEnID
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:34.5474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb39a48e-edb0-47ec-d8fb-08de9b091b2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9655
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

The base WAIT_EVENT series introduced the core wait path and the
condition-wait follow-on added optional userspace condition evaluation.

This series extends WAIT_EVENT with additional producer coverage and
reset handling.

Specifically:
- add queue reset event generation from user queue reset path
- detect queue reset during WAIT_EVENT blocking
- add memory exception event generation from KGD-side VM fault interrupt

This keeps the existing design:
- EVENTFD remains notification-only
- WAIT_EVENT remains the metadata and consumption path

No UAPI changes in this series.

Compile-tested only.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Srinivasan Shanmugam (10):
  drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
  drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
  drm/amdgpu: Register WAIT_EVENT ioctl
  drm/amdgpu/gfx11: Queue USERQ_EOP records for WAIT_EVENT
  drm/amdgpu/uapi: Extend WAIT_EVENT with optional condition wait fields
  drm/amdgpu: Add userspace condition support to WAIT_EVENT
  drm/amdgpu: document WAIT_EVENT condition semantics
  drm/amdgpu: Add queue reset records to WAIT_EVENT
  drm/amdgpu: Detect queue reset in WAIT_EVENT
  drm/amdgpu: Add memory exception records to WAIT_EVENT

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 400 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  95 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  14 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   9 +
 include/uapi/drm/amdgpu_drm.h                 | 127 ++++++
 12 files changed, 682 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

