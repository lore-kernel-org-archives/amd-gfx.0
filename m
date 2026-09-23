Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9C2C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87E710F163;
	Wed, 23 Sep 2026 19:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dsOx6CZc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F3C10F163
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwEVN8+7lloZHqfBn8Gv1RqGph+qsdkrZXFZhlHXHm6+wRAuuxR8qKN03SlgbDx7qjhDzqyywhLc6+5pl4jHlfLTYqEpSmkB2Fhfl2TuawC2m+ldjdEBk8+OQuEkYikJ7wOujFfUSZq0oFuHLxwwWyJdFYesD0DURmbeEJSNck2YA2cQ2tFH0lNXSJ4D2gWs8lVOPhhcYrgok6LXu+StwICDVNbnAavCe2n1gxOvj0ohpdzSFV3ivEbQxtJ0xOMpI2wnrsus3PwbJn4/1mB5nlRiftLFuEfFJeSzRayigsgIuyhX6oGB2u77kQo/A2vhtbluSAJdEgXI4oQGLb1M1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ6fGVhTlVW/iQwuZGJ5Opl/MVLtQMTkaoW7SH9vdLw=;
 b=npMl7GbDEDBuOEUggzGCAfrFD8bXTk4QwoS7nrFF6BK6wn8JFH64EIQPojtDrgjyuzU6/tuA8pSPcPYVWYezDlzWtaDrzG5KKWg+MPzKVrM/lXLOns79H8hLl3WdQopbznI1/oFJGvL9dAS24+Cub0mDYfBKlPHa6uU2v2cgJwmymI6xUsqbN9Vm4K1QyCD8hWeAv47UaD3Srkr3FTIAYHH0P9D8vanyJoPViQDC1PIHMX8v5tF+Ma0EIgSs6e/t/gpcWTJFkFx3G1j0zQPJwkyxFINlW8/okEbPO2xtqMKVt8T4TBgsNA8zL0R9wgjvMwS6SyVZGBlrhfk4kT2WYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ6fGVhTlVW/iQwuZGJ5Opl/MVLtQMTkaoW7SH9vdLw=;
 b=dsOx6CZc2kG15XHfqT8oD3uFV7Oq+k8QQyFZ3G9ogJoF/dei4DEg6jIfErAoNUSKct5lStKR91Xsybdf7N81YTt+0ACWw04gtsbIe/qGKYRndDMVEYU7AXwebJtl1A5I0MmoWblU+5IExMEa63U10caROw5SEYlqwpiLxaRVdmE=
Received: from SA9P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::19)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 19:34:21 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::5a) by SA9P223CA0014.outlook.office365.com
 (2603:10b6:806:26::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Wed,
 23 Sep 2026 19:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:20 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:19 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 00/10] drm/amdgpu: rework runtime_pm for GPU ioctl access
Date: Wed, 23 Sep 2026 15:33:36 -0400
Message-ID: <20260923193346.2292597-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cdaa8e-f92b-4416-5722-08df19a9aa09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: NpLfxJJxBw4zx8DE1qBwm70W1JRGjNpEmr9/Xh8OAT5kOClBQcXy6It8oaoz6RXgFqGGiUDNLLmLwCW6tHHRckXLB9eNsK4uuiOu0UYDTpACNesS7lixzp0T4Bq8nsWnR2PS8oTeryZCHH1SeSadUWi4TyFlXpeVeCxebHx/xrMowwKec3A90utSadzBkDcRmsXVWn2Lwv4p5/F45lfppgRknQbo8uYWp0ebHgFG99aiwb1AVnmmzLn15Mis9F4j9yTdkhbh4f2MSFLyVD67ZI/7vsEmxgk5Pzh+z6xdSUH5NOCpeTmqgshsXOW1Apk9HixeFUEoxNpzS+zTpQM/+nG8/jjdguJpib+0JprsatQQ/Ecs6cK7MlbLDz79MZjxOx2IzF5yTsG1fVr/SBgG8ZDRAiA2RMPuXtluvMTIq0zz9SqQUIpbDXjsxeBDBC4d1j8PuqylEeCUw9cxTh71vSf+tVFUItlzCEYI/IkHHiIFm11R0+56+g8+lFKK4P8onb/ouSTYZObtJqJdLSAIDvYQpUPySK2g/H8yGxVIBmMBbtKIX3+lLFylZ366JCqKXfgryzf0D2EPGmumCbzwGL1ExJDXRX9gATW4rwnLoJM3cS5MhtIwgN7X+2lxytBZ6b0gLYa/b+gNjtj8yyHD/mumrQ8Ga1TJBydj5ouXCkKzZwdn1AshGXIFWHjvlUww27aVMcNVTB1HtKcDXlqJ1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8j2Ev8/OI01i/d3a1Mj7LuunZT4VBrQ7Vu26DFoU6/hYFnrsmTpfZ8MMIyRuAzUSSDqVO0ogtVQEL+BuJJCyUo1rfaT3MMOny5HjBcszEF7aeDrHUpCrLUbMfXq19vo89Prt/gXE0RdGLmSKRHZSCTntJyobHj8JemMIp7EWrJvFfz2sPuZYNGhUwwmg1MxRM/GsWIZQOrUfFG+ZoLBoofBeKR8DgscklLN5bMwjxiYlDH+tZZXv6V8iVQ9nbk17whrO6IuOGMStYkZqLjjHDlnCaDmQF7uBb7y9V7r64xnSV7TGgDrrPOu1eJ9E8RMEkyNWB3IcJFm6q5Xr+q3pvOtQYKJ43RLRMFPZWkpbieRo9uiq1nKfhLI444b2KVyuQ/l5/bTe3bYHYXOE0Q3of3kUxVmfIbgHcRkUXmaI1MR0w39Vxtf3T8RfkemNh8rh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:20.2161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cdaa8e-f92b-4416-5722-08df19a9aa09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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

This patch series reworks the runtime_pm system for ioctls, cs, and
open/close calls to allow a few tools such as AMD-SMI to function
without waking up the GPU.

v2:
Refactor patch "drm/amdgpu: use pm_runtime_resume_and_get
amdgpu_gem_create_ioctl" to use a conditional guard instead as suggested by
Kevin and Christian.

Change the descriptions for several patches to fit kernel conventions as
suggested by Christian.

v3:
Fixed the typo in drm/amdgpu: use pm_runtime_resume_and_get for ctx ioctl.

Reworked patch "drm/amdgpu: rework runtime pm management for cs" to
take the pm_ref on a cs_ioctl instead of a job.

Reworked patch "drm/amdgpu: push down runtime pm handling in
amdgpu_gem_create_ioctl" to use a conditional guard.

Reworked patch "drm/amdgpu: handle runtime pm in amdgpu_gem_userptr_ioctl"
to call the pm_runtime_resume before the BO is reserved.

Split patch "drm/amdgpu: defer GPU resume from open/close to first use"
into 3 different patches:

drm/amdgpu: drop vm->generation initalization and root PD clearing
drm/amdgpu: remove redundant amdgpu_vm_bo_update() call
drm/amdgpu: defer GPU resume from open/close to first use

Removed redundant amdgpu_vm_bo_update() call in amdgpu_seq64_map as
amdgpu_cs_vm_handling() already handles it.

Editted patch "drm/amdgpu: defer GPU resume from open/close to first
use" to change the pm_ref parameter into !!pm_ref so that it would be
converted into a boolean.

Set the preferred_domains and allowed_domains after the root PD is created
in amdgpu_vm_pt_create(). This is to ensure later on in stack, the kernel
will notice the root PD is not in its preferred domain and will set it to
evicted. Setting the root PD to evicted will move it back into its
preferred domain on the next best possible iteration.

All changes were suggested by Christian.


Pierre-Eric Pelloux-Prayer (7):
  drm/amdgpu: use pm_runtime_resume_and_get amdgpu_gem_create_ioctl
  drm/amdgpu: use pm_runtime_resume_and_get for ctx ioctl
  drm/amdgpu: rework runtime pm management for cs
  drm/amdgpu: push down runtime pm handling in amdgpu_gem_create_ioctl
  drm/amdgpu: handle runtime pm in amdgpu_gem_userptr_ioctl
  drm/amdgpu: prevent suspend in fault handler
  drm/amdgpu: get rid of amdgpu_drm_ioctl

Shahyan Soltani (3):
  drm/amdgpu: drop vm->generation initalization and root PD clearing
  drm/amdgpu: remove redundant amdgpu_vm_bo_update() call
  drm/amdgpu: defer GPU resume from open/close to first use

 drivers/gpu/drm/amd/amdgpu/Makefile        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  7 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 10 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 23 +----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h    |  6 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 24 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c  | 45 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 16 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c  |  7 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  8 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  7 +++-
 13 files changed, 61 insertions(+), 100 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c

-- 
2.55.0

