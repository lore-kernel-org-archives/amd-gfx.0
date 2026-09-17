Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B90C982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 19:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3906A10F0B7;
	Thu, 17 Sep 2026 19:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0vZIs+y+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4415510F0B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xX8RTCQsb4cJB74ejEFHXqLMq68V3ivNRitcqbZs9jFPZQ+VVWULHj4UOPhPsBPY/cvSwOEUIEMXDjhavBcIiA5v1uvapAab4ZiEW2mJpPtP25HF6WEAySAOlJTZ8Gc7BdyY3bp/Ydh/vkO8c/BN5D/OVGqd7NJSLhoStGL95XwfzWCvsMEotWkCpkP5ktOzekuxITEiI0hi8kv2OARdndLQ4BWQgm5CISxfj8CQPyp8IM//l4RWw8agtWULMGsvfkSxS3xaaIo7eMZeKgBZGclGr+HThXPyZb6YY51zHxq22iMLR+JXBcmKRGVExCW03+lmxtxtc/ti/4OWTnLupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EydSbgzbtj5w8tSIa9H6ExU8S3GeFIR+udY9bWg4/fU=;
 b=wSJygKPy58MaU+LKrKdnkRKoqtUJ1uwNHP8XDjJ+RRTHq+AK/e5wJqJ7UdptTrQnd59qe+QIU2+KCKifnBuVQMAVDQNBtrPa4QfbG6Gb+JG6i+QfynqVBnNg1pYFw5uos0maB//bqsqFoL48soxZMdkquBwATWofbEoQfwAw+1LFx5T9BN0PWPp12jN6un+OtHeDEP1o2CI6QNTYsnyNfahEUB3OvcWIsqPOFZ4RT12lNLK3mOJ2jCYq0M62QgVKncXXH6E0B3iLSmDGZJpxfabBrDF6G+rXhWYd7i2jkDXvt119FOQkYDmnWdcXCFCWcOckbXyzX2vGyen7yMFROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EydSbgzbtj5w8tSIa9H6ExU8S3GeFIR+udY9bWg4/fU=;
 b=0vZIs+y+nw+w8EpeZiSzjZHpoLZ/rrxLAmCp90dxu4JQRjCji85+6ycYtKnctToVHAfy0pkGdTYvag/rizpHaCkaglf2Kv2JqcOaqNvuffHUWDPBKhcysPwuEcgF1KrNxAAXLGA6qhetanFIQGvj3UideJjsjdcsxVdU3NrDXhI=
Received: from MN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:208:52d::29)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 17 Sep
 2026 19:58:24 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::3) by MN0PR04CA0030.outlook.office365.com
 (2603:10b6:208:52d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 19:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 19:58:23 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 14:58:22 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v2 0/8] rework runtime_pm for GPU ioctl access
Date: Thu, 17 Sep 2026 15:58:01 -0400
Message-ID: <20260917195812.72917-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: a8077562-84a7-4753-2776-08df14f607ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|6133799003|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: tx4RdoGSZXy5ZhO6VGQQLP1sFNoJMrDKeG2b68vhmgpiQM4Ea8/Gv/J+FW+/FXA08M0LfXav+XEielPYt9sdTu1tfMaLP71SdHzGPCdrjJ4Wa8MDsyHSD4/u46z6JT9rhCLyr156pkeboEdQK08AI+B3kXEfNwehWOJ0YnMsJZOXK2R9u8Vz0ZXw1Ag+rrxAvDLkXqqBuXL8/iBFnfukqWEA6zjdwYjqx7aQtxkLTQUwjdvgh+pFkkzhCtYMxoOf4nVnsy+O0Kb7rLaFj3ZO0XloUugIhe0PmKNZf+NTLd667hU84kod6/pxHvJrfRDIqfB10xPNIng8g8f2sKB7Xwq8HqMig5G72qiSmHkGfYhEcYqk7Y4mW36S5wtXvjKTft0MBbq8xhSzOQe/bnHEX5o/IpHKUwpXIoXraV7AvEL/mPe36Tx+B22CeQdsYhe42FS9Anbb6NxC3vaIZmIfa6SGgJY332lZtNZlNNWjs3+JDk0uvR1wphjSev3EWLpLg0SSd6KNXoIyKJNuAqnv2vouEajLB7Roji/AGNAHMiZJHw7yakHQL5AXN+SecNnfUhSKcMzUFvm1GhU9EZpsRN7KRrf9vOqBLOfVRkaFXAYfmQ/AU1S6rJSK2WDMMuh71OJsY4NCFJ4TZW1TGbvoIR+t7LjyOxa6EwMLjxULXHCewtyqZc8HM9JsFxGAMKDi6oGxI5z6YnY1PurRsqdlXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(6133799003)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +SyyA/2KoEeuVQj7mCTX3qUtOgbJ5YQi4JltAFMeGdOAwAB5GtIWm2R7dPSAjFBG+CEtP/YlK7L0wW/gKX9up89gYc6ISp5B8vUO046xZT0D1SonKCNKkeYdMBwwCcqfCBkesEdSaW9R0wgiwylZLnM4doVdS/qnhQjg4rQky79mf7mENF3bZrJFi/XwAFkjrPc3Uj8vuS3ZSSXW8zeCZwTpU7ocMgt6q37Q3Nl3XdXisiOaJ8DzDgjM3YCYkwbAKwzkmQmrYrUOPNN4AjHtb7uQjVHDDNYSbV83kjfekgs5vEHQEZ18Qtzjm67JS7ZEhgd/LRwAWP8gHvPn16VFXo0WRAyoAIsoudad4IY7S/oOOvZifXLtkSFHqxlLad/3dySO1A9fTDxhC5MvNEHqIMHjMxmnZxh4f+pHPnCDqjkULg0Jh++hRQ0zQZ0C75Tf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:58:23.6266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8077562-84a7-4753-2776-08df14f607ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
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

Historically, the GPU was woken up from sleep anytime userspace
triggered an open system call or utilized an ioctl, even if 
hardware access to the GPU was not required.

This 8-patch series reworks the runtime_pm system for ioctls, jobs, and
open/close calls to allow a few tools such as AMD-SMI to function
without waking up the GPU.

v2:
Refactor patch "drm/amdgpu: use pm_runtime_resume_and_get
amdgpu_gem_create_ioctl" to use a conditional guard instead as suggested by
Kevin and Christian.

Change the descriptions for several patches to fit kernel conventions as
suggested by Christian.

Pierre-Eric Pelloux-Prayer (7):
  drm/amdgpu: use pm_runtime_resume_and_get amdgpu_gem_create_ioctl
  drm/amdgpu: use pm_runtime_resume_and_get for ctx ioctl
  drm/amdgpu: rework runtime pm management for cs
  drm/amdgpu: push down runtime pm handling in amdgpu_gem_create_ioctl
  drm/amdgpu: handle runtime pm in amdgpu_gem_userptr_ioctl
  drm/amdgpu: prevent suspend in fault handler
  drm/amdgpu: get rid of amdgpu_drm_ioctl

Shahyan Soltani (1):
  drm/amdgpu: defer GPU resume from open/close to first use

 drivers/gpu/drm/amd/amdgpu/Makefile        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 10 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 23 +----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h    |  6 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 27 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 15 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c  | 45 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 42 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 16 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c  | 12 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  8 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  2 +-
 15 files changed, 114 insertions(+), 102 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c

-- 
2.55.0

