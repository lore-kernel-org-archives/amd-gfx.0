Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3229EC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C236B10F6CF;
	Fri, 14 Aug 2026 21:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J3gqDZkH";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77F410F6CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGrYG8Do+ty2aSTy1kuSmpyZdKnjGynuOrNDm8NN2Fcm5OUHJs5GqGzLOxNWCxTiKXWGAp/UvCVE2OO8JqP1Nq6Zi4I1d8emSQJ3xQrsX1gMG6QjseeeoK5YXa2G2PhVwFvHqJccOm+s9mD5VImGbX9tQBBGULMxTbDOg0C45geFSIWgvtMYK/THAuRcl7wWrNs4aHfvGmHGdQW3kMuyEMq+eOgs9yLilBBVgjfl5XSrXPmjh5ugmeBwOPpGWB/Z5y6yeb6rbC7O6aMvgfkdpqJPv/8in7aRF51BWX3rUDQBcfOnjP9oLkMPtyVsYyHuiLfO2knODsyLFMstMy58IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj5jNosvw6RabuSOzkLkZWWG/UI7PDmZ71Q69W5iLJw=;
 b=wqlje7j32AOPZ5dtudVdovGCVaSRW7dQJksoWgc583Gqz2IZNhSGu/TLnWK3+w7HQu2SGULwh5/DEw7kYtNB3SVYyOvufhOkpXPfFnAYPRS5QevlRq76bDo5c0K5qe9KRZVE4xE/9LCkW60tCb40OGqiD5jQ38PdyMESmV3SGtboiyeAhNC+gL/vFhNEcNZsG1gsYZN1rppjZ0EuYeqO+wwSIrNaYn0JvXWHe9DBeU/N9mzLxn7MKsYuqK9neWsmTSwykPPDoFcn942QsQwRktML1DaNnPWg7BctkkAN4xWGpnk0AIlD3k5sSod7pLUBVzXbvQQCkkuUGqVSntnpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj5jNosvw6RabuSOzkLkZWWG/UI7PDmZ71Q69W5iLJw=;
 b=J3gqDZkHdxN0QB9FWFuA8UQkAtMRJ7W6VKi5fRE6Ax+UahlMmdLDPHsKoBbEY+pKn5VFhFOSipfSYgoc0KB7W5DSEbDBNUE4zdNkLfY8OtG3gEcWdsXA4yQ7xYw1FaAnewDz5vrK0B4Klt6Exz/DggZlY1YOp7eVKRE1D2IltWo=
Received: from SA9PR13CA0062.namprd13.prod.outlook.com (2603:10b6:806:23::7)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 21:02:58 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::5b) by SA9PR13CA0062.outlook.office365.com
 (2603:10b6:806:23::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 21:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:02:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:02:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 000/109] RAS support for GC 12.1 devices
Date: Fri, 14 Aug 2026 17:00:57 -0400
Message-ID: <20260814210246.3067612-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 858e8db5-1458-427f-c1df-08defa476afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|56012099006|10067099003|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: lXScsaRAdvXqakj/4UAkoLWekH2KZhY0MEx5MTXK9KxMUJz/X5t+yrZuSQpRNI1vkm9Sf/qbc68lIYrAubKt8W6/0FSEJyBVIsL6r39Yu95mF+VEdS8QVYEDmNh1d3truu5f1mwitVI7QhtvvzdPfPpgudWW+4J3ssEnH5JsOBKOe4hO7nMyhBT/f6v9v1FqETm2ePWHfMw7IoPpVcKVy5gny4Yc5fv8OTSY4HvHGRqLTFyAopSLRqg7L0KO7HS6sGDx/vBqKAkW+56Tn7Ec8W2wuij1Kf3ObsxWWqHZitAT8XQDheqn8RHlddxG5UyHlSN+vAqzQlz2AiWzHzKDgEC7P2bllJKdGuC9Kxwx19dEd51PiERWrMcWxiVuvHbv4ikz3ZvlYQEemkv0zaJC26yAgr6ztEI9QJlz5//sb1I7wT5WM3xPdiDILRhdSEGWE4vu2cs1TCmI+n+1IkPWhaJctspZYCs+aAVWC0dsBig/wsTqZ21+QFIyB9jA+9sz7HwERWp82HsustVhTFN/auxGH0VKqRP/QeBTHf3YaZFeIhSBsZ68wE0EcX3o+VNAQTjWvmUPM8F6LaOSSrLSgA3Xx1u3uJkeqZCCkOhTbihWrunaQbsNO/QKm0/Ert2TLoZXeIiX/vzaEqFrXzCJF8T6H4c1/CZmPhBdq8YB2wkza4HU0C8kirI6wJ1di5k+KTg1uFHdmOP8f3KXdeQzxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: piHy7Yb0SkJE3McmPu6u1aXE2YBj/d5ZK34aWcIqHEmTaNjBdoiS62v5/cS9Vh7DvRglvkpL8pzuNHftaQSL4TbdyFU3ai48Tx0deCanB3EIBOMB4nRVhTQ1Q6KzuIhSOYx/ZDBOeCJ0dM4esD7+Z5oCC+O1e7pC9XTjxqLr/aW/bvroB8T/Hu8jQQi9Q+4ou4d4wOPzmuSglulYI0Tw1WMskaKbH8N4K9X5zOph/W5XrFKiePvOOqD0Q6ivbAbbaASeJ3Q5WpArzHI/z4pgrLX5expOVIHiG13ozkmEJ2LG4AxpeSlrSnriDthGRFBRxE3WYEmiNHBfv26cY9mzp1Vu/bMwGr5z7H/TGv/hBXb7GKBtINH6/nz1drnKAMq4DwSOSWsPIWRAFyiNpCE4xsk+QNHroUf1g2ZcdxTgU3ya9wM6skJ4eY8pGMk3tXgH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:02:57.7245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 858e8db5-1458-427f-c1df-08defa476afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
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

This series adds RAS support for GC 12.1 devices including:
- PSP support
- CPER handling
- MCE handling for A+A platforms
- ACPI BERT integration
- EEPROM handling for bad pages
- UMC support
- SR-IOV support

Candice Li (6):
  drm/amdgpu: factor PSP v1.0 firmware bin descriptor parsing
  drm/amdgpu: load standalone RL firmware on psp v15_0_8
  drm/amdgpu: load TA firmware for psp v15_0_8
  drm/amdgpu: update UMC active_mask to u64
  drm/amdgpu: add ext_umc_mask to RAS TA init
  drm/amd/ras: add ext_umc_mask to RAS TA init

Felix Kuehling (1):
  drm/amdgpu: Make extra space in psp->cmd_buf_bo usable

Jiahao Li (2):
  drm/amd/ras: overlap VF RAS_CMD buffer and legacy RAS telemetry memory
    regions
  drm/amdgpu: add new interface in guest driver for getting RAS
    capability when uniras enabled

Xiang Liu (24):
  drm/amd/ras: Rename CPER section descriptor struct
  drm/amd/ras: register mce notifier to obtain ras error info
  drm/amd/ras: Introduce BOOT CPER encoding function
  drm/amdgpu/ras: prepare ras_psp for ras_mgr-owned TA reload
  drm/amdgpu/ras: reload RAS TA from ras mgr resume
  drm/amd/ras: add PCIE_PL ACA block mapping
  drm/amd/ras: map boot log events to CPER type
  drm/amd/ras: add rascore BERT record walker
  drm/amd/ras: process cached BERT boot errors
  drm/amd/ras: add missing ras core block names
  drm/amd/ras: add BERT CPER table helpers
  drm/amd/ras: record crashdump BERT sections as boot CPER
  drm/amd/ras: move BERT boot errors to BERT sw init
  drm/amd/ras: allow waking RAS processing without an event
  drm/amd/ras: classify ACA v5 MCE status
  drm/amd/ras: preserve CPU MCE context in the log ring
  drm/amd/ras: define processor and memory CPER formats
  drm/amd/ras: generate AMD crashdump CPER records
  drm/amd/ras: generate processor CPER records
  drm/amd/ras: generate Platform Memory CPER records
  drm/amd/ras: collect CPU MCE metadata
  drm/amd/ras: parse and route BERT sections
  drm/amd/ras: assign BERT platform record ownership
  drm/amd/ras: fix CPER command record retrieval

YiPeng Chai (76):
  drm/amd/ras: Add ras notification event
  drm/amd/ras: add interface to support parsing aca bank ecc info
  drm/amd/ras: Parse error type of MCE and encode CPER
  drm/amd/ras: Add interface to get ras eeprom table version
  drm/amd/ras: Add dedicated interface to obtain cper info
  drm/amd/ras: optimize mp1 dump bank interface
  drm/amd/ras: support separate logging of gfx aid and xcd errors
  drm/amd/ras: Optimize and remove redundant code
  drm/amd/ras: Supports recording data source timestamps to EEPROM
  drm/amd/ras: Improve function interface to record different types of
    data
  drm/amd/ras: Change variable name to avoid confusion
  drm/amd/ras: add common interface to query ras subunit version
  drm/amd/ras: Add aca parser v5_0
  drm/amd/ras: Add fifo to cache ras data from mce notification
  drm/amd/ras: Add mce ras error type
  drm/amd/ras: Handling ras mce notification event
  drm/amd/ras: Add ras ip configuration for A + A
  drm/amd/ras: Add ras_psp v15_0 for A + A
  drm/amd/ras: Add ras block id mapping
  drm/amd/ras: Support querying RAS driver capabilities
  drm/amd/ras: Add ras command to obtain ras capabilities
  drm/amd/ras: Support poison consumption handling for A + A sriov guest
  drm/amdgpu: Handle ras interrupts using unified interface
  drm/amdgpu: Support obtaining ras capabilities
  drm/amd/ras: Remove unused function interfaces
  drm/amd/ras: Isolate ras mce handler with CONFIG_X86_MCE_AMD
  drm/amd/ras: add interface to query nps mode and vram type
  drm/amd/ras: add helper to convert aca bank to eeprom record
  drm/amd/ras: ras mp1 introduces common interfaces
  drm/amd/ras: Support retrieving bad page info from mp1_v15_0
  drm/amd/ras: add interfaces to manage multiple EEPROMs
  drm/amd/ras: Refactor EEPROM parameter config to support multiple ras
    EEPROMs
  drm/amd/ras: Ras eeprom supports new eeprom management interfaces
  drm/amd/ras: switch to use new eeprom management interfaces
  drm/amdgpu/ras: Rework fw eeprom handling for new management interface
  drm/amd/ras: unify umc record logging paths for runtime and preload
  drm/amd/ras: add interface to obtain FW eeprom records at runtime
  drm/amd/ras: preload and handle bad pages at boot time
  drm/amd/ras: add interface to report bad page info
  drm/amd/ras: Support obtaining bad page info at boot time for
    ras_mp1_v15_0
  drm/amd/ras: Add gpu rma exception handling
  drm/amd/ras: use record count instead of bad page count for EEPROM
    threshold checking
  drm/amd/ras: remove unused code from ras eeprom
  drm/amd/ras: Add null check to prevent null pointer exception
  drm/amdgpu: Add bad page preloading and pre-reservation support
  drm/amdgpu: fix duplicate ras debugfs node creation on driver reload
  drm/amdgpu: refactor memory handling to support both external and
    internal allocation
  drm/amdgpu/ras: support loading RAS RL and TA firmware in RAS module
  drm/amdgpu: add switch to select firmware loading path for RAS RL and
    TA
  drm/amd/pm: update RAS-specific interface to support multi-parameter
  drm/amd/ras: update mp1_v13_0 to use smu ras multi-parameter interface
  drm/amd/ras: support multi-parameter communication with mp1 in
    ras_mp1_v15_0
  drm/amd/ras: harden error handling and fix resource/lock issues
  drm/amd/ras: fix silent error swallowing in get_record_count paths
  drm/amd/ras: add address translation interface for umc_v15_0
  drm/amd/ras: fix driver unload failure when uniras is enabled
  drm/amd/ras: use single socket per GPU device to store ACA RAS error
    info
  drm/amd/ras: update aca bank decoding for A + A
  drm/amd/ras: add management interface to support psp bad page address
    translation
  drm/amdgpu/ras: use flip-bit mask to generalize bad page address
    derivation
  drm/amd/ras: introduce row page address buffer alloc/free interfaces
  drm/amd/ras: limit eeprom ras table validation to init and post-write
  drm/amd/ras: resolve compiler warning for stack frame exceeding 1024
    bytes
  drm/amd/ras: replace variable with function to check poison support
  drm/amd/ras: update interface to support multiple ras query methods
  drm/amd/ras: improve ras log timestamp precision
  drm/amd/ras: add module parameter for uniras
  drm/amdgpu: extend ras feature mask to 64-bit for A + A
  drm/amd/ras: refactor ras cper to simplify adding new cper events
  drm/amd/ras: fix ras cmd returning incorrect cper count
  drm/amd/ras: unify variable naming conventions
  drm/amd/ras: add interface and improve extensibility
  drm/amd/ras: populate cper aca register info for rma device
  drm/amd/ras: filter out invalid pages from extended page addresses
  drm/amd/ras: fix and improve bad page count calculation
  drm/amd/ras: increase page buffer size for A+A

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 177 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  88 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   3 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  39 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  49 +-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c      |  10 +
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h        |   1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  18 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  13 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   7 +-
 drivers/gpu/drm/amd/ras/core/Makefile         |   9 +-
 drivers/gpu/drm/amd/ras/core/aca.c            | 341 +++----
 drivers/gpu/drm/amd/ras/core/aca.h            |  41 +-
 drivers/gpu/drm/amd/ras/core/aca_v1_0.c       |  41 +-
 drivers/gpu/drm/amd/ras/core/cmd.c            | 145 ++-
 drivers/gpu/drm/amd/ras/core/cmd.h            |  32 +-
 drivers/gpu/drm/amd/ras/core/core.c           | 281 ++++--
 drivers/gpu/drm/amd/ras/core/eeprom.c         | 472 ++++------
 drivers/gpu/drm/amd/ras/core/eeprom.h         |  27 +-
 drivers/gpu/drm/amd/ras/core/eeprom_fw.c      | 576 ++++--------
 drivers/gpu/drm/amd/ras/core/eeprom_fw.h      |  67 +-
 drivers/gpu/drm/amd/ras/core/log_ring.c       |  56 +-
 drivers/gpu/drm/amd/ras/core/log_ring.h       |  46 +-
 drivers/gpu/drm/amd/ras/core/ras.h            | 127 ++-
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c   | 394 +++++++++
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h   |  62 ++
 drivers/gpu/drm/amd/ras/core/ras_bert.c       | 546 ++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_bert.h       |  33 +
 drivers/gpu/drm/amd/ras/core/ras_cper.c       | 834 ++++++++++++++----
 drivers/gpu/drm/amd/ras/core/ras_cper.h       | 175 +++-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 418 +++++++++
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h | 124 +++
 drivers/gpu/drm/amd/ras/core/ras_gfx.c        |  10 +-
 drivers/gpu/drm/amd/ras/core/ras_mce.c        | 151 ++++
 drivers/gpu/drm/amd/ras/core/ras_mce.h        |  51 ++
 drivers/gpu/drm/amd/ras/core/ras_mp1.c        | 147 ++-
 drivers/gpu/drm/amd/ras/core/ras_mp1.h        |  52 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c  |  12 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c  | 249 ++++++
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h  |  30 +
 drivers/gpu/drm/amd/ras/core/ras_nbio.c       |   9 +-
 drivers/gpu/drm/amd/ras/core/ras_process.c    |  36 +-
 drivers/gpu/drm/amd/ras/core/ras_psp.c        | 570 ++++++++----
 drivers/gpu/drm/amd/ras/core/ras_psp.h        | 109 ++-
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c  |  76 ++
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c  | 133 +++
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h  |  31 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c        | 624 ++++++++-----
 drivers/gpu/drm/amd/ras/core/ras_umc.h        |  45 +-
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c  | 123 ++-
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c  | 220 +++++
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h  |  69 ++
 drivers/gpu/drm/amd/ras/core/ta_if.h          |  35 +
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile      |   5 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c | 191 ++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h |  30 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  38 +
 .../amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c   | 128 ++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c  | 268 ++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h  |  31 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 298 ++++---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |   6 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c  |  71 ++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.h  |  30 +
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    |  17 +-
 .../drm/amd/ras/ras_mgr/amdgpu_ras_process.c  |   8 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  88 +-
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c |  42 +-
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |   2 +
 79 files changed, 7247 insertions(+), 2148 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_bert.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_bert.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mce.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mce.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.h

-- 
2.55.0

