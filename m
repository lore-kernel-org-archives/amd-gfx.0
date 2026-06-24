Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5D6CDE000
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 17:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6159A10EFFD;
	Wed, 24 Jun 2026 17:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sCOEhJ6j";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE4810E0CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 17:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCKB+xkAPq3OMvCqyh7illJhwx65xtMK+iTPA5vamEAxXC7JqOI6cj+kmBZs5tsMXa5GCpbKPXdr8opgy1yY3iSGF4Oaxyy8GXGCSu3ISgPEUeHu71/kY7apUAHpoyOrMkk8MFYvkJk/VAX58uyUWACmW5mmO/zodiBgPAhdeSj2Psp7bbRT5F/KWg/Ri5oqS1BZKXPCo5+9MVFTjI23x6xtSxGjZ+R0TIoHIj48ujNssyvGFrVmtEqwKOikDVDaA8c6eaAdIB4BzCHbsKm/FVW8cz7WFJJCLrpTZw1UHPu6JBf578SELeSv6MJuuj0D6tPWmvVUsvtMbsCZW9V+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXLkFbIVXBJF1O33oQppojn+SOSisG6H2V/DQ0n52Vg=;
 b=kDT7m8D5/vfVQ7xEgZ1YPaihM6jsq5PHPy5B4a+qMvA8xRN11z0mNg8wrLnXnQMQkfrNGBrQw6h2laNGpxTFx7fcPCKCc/IcdH0I2TzwPW86rNNcOUjrnk1wenqd41RIojRmw3aGYmCYgB7/0BjrsBw2zeRaeJiZbCGpYkL0HAEp7cLKWpmiWwK/uwQozB2s4jwF4suB1umJSTD2mgpihtVOl2G4LlEn1yXIEO8BlHUYyp7EOSr0UA+HVSIQDJigPTVqxqsRp++ija5rgN0lNCxbqy13wq/98bKF6cSyF4CnX+ZLCIgyT8pllSNI1cTWB+HDzGtHFMtfTOrvfCv/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXLkFbIVXBJF1O33oQppojn+SOSisG6H2V/DQ0n52Vg=;
 b=sCOEhJ6jK5aKLlVS8rqSpn9F7Hc9pBjcBL07y6FXqx8Wy8eSF/xEbTMMuP6wZV2NcXTCYwISEbgfxXYl68H3Ml++1uT87oYEHao2v96CHNJwdpLDJv7TJWzfKagebqZ0IGvdj4hn8uU1BU2r2PQhIr5Vufk9AlG49t/oNZeHfNc=
Received: from BN9PR03CA0173.namprd03.prod.outlook.com (2603:10b6:408:f4::28)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 24 Jun
 2026 17:56:04 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::69) by BN9PR03CA0173.outlook.office365.com
 (2603:10b6:408:f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 17:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 17:56:04 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 12:56:03 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v4 0/6] refactor monolithic amdgpu.h
Date: Wed, 24 Jun 2026 13:55:01 -0400
Message-ID: <20260624175554.489406-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: aae57eb6-6574-473e-a14c-08ded219dc54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: m06quioqIRLpAIGDyql3atLqK8ojqeW7assG+8B60Y3NHdxm/aMuq9hv5+rmgsqJXrD9kFz25WMpEl8FcuXFImEDEvugGHe2rqnBH61dXSPE/U5cykrvPH4rMZCax83OXt0Alyk+R6LY2nZEO9qzgubR+u/avVaXEIVG06dRf5mGdgk2oAqnpEnQRsju/nMXhs5B2+8Y2N6Rk0PMxk4gCwUorpwPy53kShAb8YfTtGzz9f6lxjoY1p/L17KljKQ4ckAsrp8sQRWoEcmGSWn1hs1wsfKxfL3edd8CVIy0SNk9NJn8QJXBmaXNITDd33DrtTkNCs5bxzFX9CqswjLNqaOEA0eav0xO2jTnVJ9IFAUSrwP4mzgS7IoqcHZT9wzmYfriRS+YumkXDB1CxurcZXjyJ0St7StECrwC4FrJaVGYvW+abwNv5MuYwBL8WoDhnYIDZZvyeRjmAOmvR78ihMZWGjBcJyKWk4N/OfrE03UHJqNduGr5iCAYHXhRu+AqmswB0Y7G/sIMITApMEGP29ddwrm7oJYg9x+IBiCirf07krt8OeLLyeMdHGmF5zac6brbIDbvAvkkqc9qKA5nUWlDIxJDfEzZLK5zZ4rW8kvqn61yOEjhClgHLfRvqoD+yv0q081eCcILvPase05pGCq6uyQ5ug6Dr9+8iYs/DBpvqppVm2mCC3skjCIIhiot0wE+CHqitBmCU6UUoYSUpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: puz3T5lZnPpLtzBdXk/FO8cbrA51Q4mHdf5b2ERKULbCa6/SJJvJVEHvYtpd6WRx9vLKE3OWjhMnLsLh3nRLEfktzM39b2eCIQckRIJZH0m71e+sGHu5AlaRc46A093LDSgZ48nV45+Mp16SfKC62e4MO3eYCAiUEkPcBSCVVIKX4HwbS10Sb1/dC70f8Iwi3Ftf4UOiRSlbIQstYvkEo1nQ5WkBbe0voLo1bdHcm1eBTnqf0QVHovNZfVYaSMIbg3FgkpqrvFCMY28WrKerkzb7qbCOI83xlhnSrQE2cPXR+o2o5XuovevWLzV8ZKUF/xfnW/JLkZxnVpHOtYM+myqpesgagfGLngrsGy+WQsf7Mihu5h4j2Yawdp+ds/H1OO8rjPZ9gCJ2lYRZQVKjE4M9unpQERcYZ6mfTTgUbBHS6Rsaf3BKmTIOcgj2V7WJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:56:04.5335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aae57eb6-6574-473e-a14c-08ded219dc54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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

This patch series refactors amdgpu.h by moving several structures and their
associated helpers into dedicated or existing header files. This improves
code organization and makes the structure easier to parse.

v4:
 - Added amdgpu_device_wb_init() and amdgpu_device_wb_fini() into
   amdgpu_wb.h and amdgpu_wb.c and removed the "_device_" part of the
   functions addressing v3's feedback.
 - Removed amdgpu_uid patches (v3's patches 2 and 7) for a separate branch

v3:
 - Dropped patch "Move struct amdgpu_sa_manager out of the monolithic header
   amdgpu.h into its own dedicated header amdgpu_sa.h" addressing v2's feedback
 - Removed the "_device_" part for amdgpu_wb functions addressing v2's feedback
 - Patches 2 and 7 are unchanged but can be dropped if amdgpu_uid is not
   desired to be removed from amdgpu.h
 - Removed amdgpu_mqd.h and moved the relevant structs and helpers into
   amdgpu_mes.h addressing v2's feedback
 - Dropped patch "Move struct amdgpu_init_level and helpers from the monolithic amdgpu.h
   file into a new amdgpu_init_level.h file." addressing v2's feedback
 - Dropped patch "Remove #include "amdgpu_init_level.h" from amdgpu.h and add forward
   declaration of struct amdgpu_init_level."

v2:
 - Moved amdgpu_device_wb_get()/free() into new amdgpu_wb.c file and
   amdgpu_device_set_uid()/get_uid() into new amdgpu_uid.c file
   (addressing v1 review feedback)
 - Removed v1 patches 8, 10, and 11 (addressing v1 review feedback)
 - Moved the includes of headers amdgpu_uid.h, amdgpu_init_level.h
   and amdgpu_video_codecs.h out of amdgpu.h into files where they are
   actually used (addressing v1 review feedback)

Notes from v2:
- Moving the includes out of amdgpu.h into where they are actually used
  caused the commits to go into different subsystems like /pm.
- Dropping patches 9, 10, and 11 is advised if this isn't desirable.


Shahyan Soltani (6):
  drm/amdgpu: move struct amdgpu_wb and helpers into separate files
  drm/amdgpu: move struct amdgpu_video_codecs and helpers into header
    file
  drm/amdgpu: move struct amdgpu_mqd and helpers into header file
  drm/amdgpu: move amdgpu_acpi helpers into new header
  drm/amdgpu: move amdgpu_allowed_register_entry into
    amdgpu_reg_access.h
  drm/amdgpu: include amdgpu_video_codecs.h only where needed

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 267 +-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h      | 151 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 110 +-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  46 +++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_video_codecs.h  |  47 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c        | 129 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h        | 102 +++++++
 drivers/gpu/drm/amd/amdgpu/cik.c              |   1 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |   1 +
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   8 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/soc24.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/vi.c               |   1 +
 47 files changed, 614 insertions(+), 481 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h

-- 
2.54.0

