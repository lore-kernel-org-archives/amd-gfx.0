Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DDDEFCE43
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 03:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9184410E1EB;
	Thu,  5 Mar 2026 03:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hu5UzZjx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF3210E1EB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 03:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2tr3pUiEplcKhXuozwboocJNBv2G/UkkmUVPrTzPjPFa4TBAwkn8yI3z3xLfRd92c9/j2YV/inRAD/ZgVda4wIL1BASTPUeBd1YHAeTSZT5N2LstuxKyl1a1DVYC5fhypgvnK1waGWBjxwWlOz3HamRiLBzwo6bWLmUe+F6z6NM1hmIL/XessWTB0PLr9fQPBkmivjIuD+3aFfpnQUhYtwgIXjJ/fjiuxokr1fmeP5N7ijdb8GKICqE9sn35nErATJxzCTAnBYw9fthtvtiSGgEew717QfqnQ39fUsT7SCBxbVST5umJKw0q3U1YkB7qlUoJAQic4JxgttQkGanuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LJUthLsnG+8WCjlxm2h9t425SGeX4uStvK2K1roN7w=;
 b=AVMewa2nFk/EBflG1Rj1595o7QUPWIqueNVfzxorz/7EaB1f54sB9HV2vQWZMYq3mUqL6VsJsaEFYC7lPL69xEGyagfs2dJdSxx/Gdo0BH741BzS9Zdr4Twelvv38HzF5IDmfG8vkT7Xdnny38cWGLLYwnK6ffLRBwzX7rv+UpN0L878Q0LSfB3ajJ5cCOuIW2PicS8iPoprxbn5ma1g2U61oS/+78p1XR9HCXw0PnKTUn4+5e/K2A02HQG5hwaTeIZzr8/LVvyP31PxNQ9TV9581fLSxX0lrRD1RHG1xM7t8yoz6n+EWcXrkA160kO9fA1KKYmqe5avoNAIW7Lpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LJUthLsnG+8WCjlxm2h9t425SGeX4uStvK2K1roN7w=;
 b=Hu5UzZjxhh7XVcxjdmp9fFQPqgpuBH7sIe01NWpCFklCTviRf5vcbf/gGFz4ihrZGTOIR85hPfVe5/P7BHujaGlDdqh/2rxnD4ELLb0uD67ldXlMXj7t4iOmPv+ted58t4i8qPeTEhSY8NTO7XkjfOhbi9nt69EVWyTWJMNOzZ8=
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 03:07:49 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::cb) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 03:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 03:07:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 4 Mar 2026 21:07:47 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 0/4] drm/amdgpu: Render-node eventfd subscription
 infrastructure (toward KFD/KGD event unification)
Date: Thu, 5 Mar 2026 08:37:22 +0530
Message-ID: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c5c5d1-0853-4851-aa48-08de7a646221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: Tm3J999kf/Uma1iM3mHNf0HTJ2zbiwY8e+Rn0ltGD/Mp0/LmJzOg7iwVQncL8Uc98/McdhOt2u6dKYzJTmLOpvpxd7IUFk6SRc+AQ9sd3H5/QZ84aNi+oOEXEzWq/dKFjxnzCssA2GZuhg6AP8pMT+S5QXcImNNZ/D1WOW6eULvarul9OHl/K0R1iZw8dBw7LTL2PR0owtIBQfSGQXVOPfrjPoILry7lZ5c1oXbbRqG5jOhYY+w0jwFabZh9LXQ5zCeVP9MecA45jctTAfAl90BK0EYZDI9UNW02YQMNwJYNfIoNzpTIUa5Ufr9zJG5quqpE4nr6cHrbM0eOzNDRX3MZc1N/7n+Y/GD6iK2r6h7UUGtdVccuq4YTIucOG3H6U9Op7hO4FQ8MPJYBY8JtzQ2mbBSLUyNJZlpjVXA/06vpy5alMR59OdByVMTLVI3hUGExSAYW4Zg5ZqSKmphUlh5ZR2qlWE94l9jRJsSHM4Woo60wlQ2m8Kt1O5zjX9hpL/08qPaxuYUQ9y+yMALDlX3CuFcGk12f8IdWJuJS0ssAwT7ES2vEnXbt4Ai84eA3rwlbTm27hfvtqOKb13mHjHo2A2lE0KgZtvLmEaUCuAyu90E6vI/Z1vIoAm419RIBdVX0T5RXSAmiU1cErfKjlDKNcPumzQfzsdEDZPaIvXCrshQF8Zyis0mWyEsYO4Zf4GI9pl3Ybsm/JwL45abeeZUdd1+4EqWnqcUB5K0eT2rLL7SeIAV5w+aOGOZ0O//+SXUlhzJ9kvSicfUb0WEm3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H1McuA/9pOek70eLG2g3EZcw5uOFmTdlI4SKDvI37oiv48YCvh/DffnKtUIzUzcUyltTDIHY1yphnwVub5oIpqHnZ09Vw+ksAmpQimCNV/4peQ6UbWUfZHqx6L2ZuzqdVfDzFORqg0c5P1Fu2S56LNB20bEPaOzUDg7xQrziGDlHKRLJLg81Bvqpxm2M0DakMIQzJ0wFPuiMerGrg9OiTIVXFhXwvWIJZOBaqW8BJNrEqP3Xg4phnyDm1Qz2SIiaSdwsObT7yTyNzNTQoQjhI/AZHIHmA1cz2vC6ff9ISknDE7d2gQeVlYRWbwpHjF/kntHRFLzDZEMsI4fBiv2ExH+foMGp5brkJmTUEf8EaVsf12hhd1Z/He0PuSDPopp0PbfYnBAD6MLku2Kf0rbz9TrcxfYzrylcR3vByaRoY/x2lRFLo1ajme7f0sUvGjss
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:07:49.4077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c5c5d1-0853-4851-aa48-08de7a646221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606
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

This series introduces a render-node eventfd subscription mechanism to allow
userspace to receive notifications for selected GPU events via eventfd.

Userspace can bind an eventfd to a driver-defined event_id through a render
node ioctl. When the corresponding event occurs, the driver signals the
associated eventfd contexts.

The initial producer implemented in this series is the GFX11 MES USERQ EOP
interrupt path.

The eventfd manager is embedded in amdgpu_fpriv and therefore tied to the
lifetime of the drm_file. The IRQ producer resolves the manager at signal
time through the queue -> file -> fpriv path, avoiding storing manager
pointers in longer-lived objects.

Duplicate binds of the same (event_id, eventfd) are treated as idempotent.

This series introduces a render-node eventfd subscription mechanism to allow
userspace to receive notifications for selected GPU events via eventfd.

Userspace can bind an eventfd to a driver-defined event_id through a render
node ioctl. When the corresponding event occurs, the driver signals the
associated eventfd contexts.

The initial producer implemented in this series is the GFX11 MES USERQ EOP
interrupt path.

The eventfd manager is embedded in amdgpu_fpriv and therefore tied to the
lifetime of the drm_file. The IRQ producer resolves the manager at signal
time through the queue -> file -> fpriv path, avoiding storing manager
pointers in longer-lived objects.

Duplicate binds of the same (event_id, eventfd) are treated as idempotent.

Changes since v3:
  * Use eventfd_ctx pointer as binding identity instead of fd number
  * Make duplicate (event_id, ctx) binds idempotent
  * Replace manager bind limit locking with atomic counter
  * Add helper for xarray get-or-create event_id
  * Tie eventfd manager lifetime to drm_file (amdgpu_fpriv)
  * Remove eventfd manager pointer from fence driver
  * Resolve eventfd manager in IRQ via queue -> file -> fpriv
  * Fix build issues and minor cleanup

Only compilation tested.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Srinivasan Shanmugam (4):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
  drm/amdgpu/gfx11: Wire MES EOP IRQ to render-node eventfd
  drm/amdgpu/uapi: Add EVENTFD bind/unbind ioctls for render node

 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 279 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  33 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  30 ++-
 include/uapi/drm/amdgpu_drm.h               |  33 +++
 8 files changed, 442 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

-- 
2.34.1

