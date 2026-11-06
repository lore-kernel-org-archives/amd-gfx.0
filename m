Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B3606A31B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GomB1RsV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F09110E07D;
	Fri,  6 Nov 2026 04:51:31 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE5D10E07D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 04:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x11TDzBayrALbfRpfX2KACGPAPfNgajay8ZIVbICNG7ireLsqj/sUJ62v2dAuGmRvnpWELMcqo0J4dpkbFbuLBXh5pnKDGae0s15JfMXgwwFhF4gfscOQDkCfYt77uEmNCSBf9nbVsmlhMhBi0E7LTE/dOjC5e6IGAU1FgrGvhPQu11PAFrcb8fwpgtEpJ77yymE9VeSpZQLu2jDc4tv5siTNOlZqxeI8wafiA58j8bLkz9JwU2jrN49KMNt15BKEs9qBY/E3ME6zLHftPvpU1z1VbR7+4sCCk9J4gTOch2vM6C8IHsqS7aQizM61xpAVAmYWLWWqgapCzV7g3vDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5Ahc3GA+hGauPMkIZ5pUThR3NZPcHbC9lzMqUD6T2U=;
 b=HJmAidPtCm7rUoIvizXqysYWUjTOh6D0zp0ixZcxt6Vt4gNeEKG6Mg26kTBImp3oBc9AUKIBPCtebKhcxCiNHsEQEWr7eZGPkZjrGAU9uvoOnamdeb/Ug76uzGedNXbNGqTWohu/Tcy60+9CobdJVPyJ+Zs5FUfaHrNQA7kiRT3JpMOa0t4DJnG3eu0B1rM/+h56WEjQwPCIJbAJ49DCJMIia85SHNEyoKK6I6CE9mnI6v22xu8PeBJRKRwC5r/B/k/Jc2sxC536hesWbNLqRetRzMwLkerlJh8fobkGJxrKywaIgR/XqsaCbCv26zRLizvq+RxPozgBOzAA+ry0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5Ahc3GA+hGauPMkIZ5pUThR3NZPcHbC9lzMqUD6T2U=;
 b=GomB1RsVJbAstHGSzyo84+lC8e4CPckAIve9WSy9Z8DyRUPDLymDK2ZPXpB2hFXC1N5hvwAyuVYNlJfTMlIIIF0nWvefLYuKShQ0Uwe8SjeSLd4MwxWSb21nnnkXLjZpf4PSOMWntTBW+nJfuhx15gnUWQWMvQs+Z8hdkK4vDUk=
Received: from CH2PR18CA0055.namprd18.prod.outlook.com (2603:10b6:610:55::35)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 04:51:19 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::90) by CH2PR18CA0055.outlook.office365.com
 (2603:10b6:610:55::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:51:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:51:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 5 Nov 2026 22:51:16 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 0/7] drm/amdgpu: Add CWSR and second-level trap handler
 support
Date: Fri, 6 Nov 2026 10:20:54 +0530
Message-ID: <20261106045101.1562366-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: d44f0225-2a90-4972-de26-08df3bc19879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: u9adB2fI1LPdk1SZHXQVzWCkLtfTFkmEjRsgKPj3EL2Nk/BSmvyRMY7kyuLL24/rr3VMjNuuReuFJfhya6Qm537cDbxMs/C3zXtby7cf/ft0YKPOnui7aUH1A07sw/+njaFaHPfs0AZkn2sKHqNUUz1t/uShasbIHeSBOkOaL1DHKJarI1nse8kvMlanpPLGb7JFG3gtAESzMW4QxUTVdVrmgSchKlI4AgXB5p/w258XfCLqaJLzvCiqukmKx2pi+/8/XaDGlyqV127a8oryjM8Z8nvfL9qWDjgCN6cOHP36kvSvWKsnqmUY5ZQ3b5SwAWtyANsNoAvp0zl69me+GqWs+WmQtJE0S8Um5qK4/Z0ZqjoU7awYSkYxtmzZq6TWiz996bDaj7ykTaa6weolfVD83ewx7ufNTVSS6ETRDgDSR9QKSVOBeMgIWwjqW7TOeBL9t9xZvv9pnxcXxwf5E8pKS16abC9hDG5q8bKTzNvKf+DwEmHBNtOU3wXTCrN/FD0r9GY/F/3r+7E+MAqkM7Zi3zAMuLUXh9ju0FTvDyCk7ucZZ0esX+f5wP5VbKDzd+qC++6w4fHLWVOLzQNTYA3EsK55/qvPReNIZcS3hTsOr5IuPJbrZbjnGLrxeqJpT+FbBuiRGxtFJX+D651ujg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ys/t6v6jpTL69W3iAf2CGCJUkS5sFZ+dP35pQDnouJy/MtsWfDWv9f6tIi1sTSXkMdGIvQCgV0sbbcb8QeBTpDQ13/FtzyhHV/wrIl22YSlCypYSOvO4HS75xmBpxgWNqhcnQZSl6er4W0rvL7014HdRom4jj6zp1FamoXl7vpmIS3Ez/jYLqBq7FuO/Cmr1T+OZ8KGv+w38b3XNNLliCckMwkp8op6JFLWUFOWIsNBOXUT/5xCDlz3NcLYlS9l/q5CFRvZp121D/73wxHhwa3xORT0N2FRSgoW5JtiIb5K39uqOOkp4+uNedKaqnYmE5yemK6YtHBqU110Okmf7E4cnk90NdosS9HuLzJCrxNosuex/WQl1ynJ7huKq9zoeODaAv9yx8Jk3BWTxK4s9nlFpEmmcOJBgx3ucd/xiHa3nfNTnFoDZWXJzmQsChIyD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:51:18.2189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44f0225-2a90-4972-de26-08df3bc19879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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

Hi,

This series adds support for Second-Level Trap Handlers (SLTH) for
AMDGPU user queues.

When a trap occurs, execution first enters a kernel-managed
first-level trap handler. The first-level handler then transfers
control to a userspace-provided second-level trap handler. After
the second-level handler completes, execution returns through the
normal trap return path and resumes the original workload.

Changes since v3
================

  - Resolved rebase issues and adjusted trap infrastructure integration
    accordingly.

Base Tree
=========

Series developed on top of:

  a261f3540b7a
  drm/amdgpu: don't drop the gang dependency fence twice

Branch:

  amd-staging-drm-next

Patch Series
============

  1. drm/amdgpu: Add CWSR infrastructure for user queues
  2. drm/amdgpu: Integrate CWSR with user queues
  3. drm/amdgpu: Add CWSR userspace interfaces
  4. drm/amdgpu: Add second-level trap handler infrastructure
  5. drm/amdgpu: Make first-level trap state GPUVM-owned
  6. drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
  7. drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl

Validation Platform
===================

GPU:

  Navi48 (0x746f)

Firmware:

  MES_KIQ feature version: 1
  MES_KIQ firmware version: 0x00000094

  MES feature version: 1
  MES firmware version: 0x00000094

  VBIOS version: 113-G2820100-001

IGT Validation
==============

Associated IGT series:

  tests/amdgpu: Add SLTH validation tests for trap handling
  and trap return

  https://patchwork.freedesktop.org/patch/765208/?series=177473&rev=1

Validated tests:

  slth-gfx-kq-vgpr-proof
  slth-gfx-umq-vgpr-proof
  slth-comp-kq-vgpr-proof
  slth-comp-kq-returnproof

Validated functionality
=======================

  - SLTH installation and removal
  - Trap invocation and trap return
  - VGPR preservation
  - Execution resume after trap handling
  - GFX KQ path
  - GFX UMQ path
  - Compute KQ path

End-to-End Result
=================

Testing on Navi48 hardware demonstrates successful
installation of a second-level trap handler, trap execution,
trap return, execution resume, VGPR preservation and handler
removal across the validated queue paths.

Thanks,
Srini

Lijo Lazar (4):
  drm/amdgpu: Add CWSR infrastructure for user queues
  drm/amdgpu: Integrate CWSR with user queues
  drm/amdgpu: Add CWSR userspace interfaces
  drm/amdgpu: Add second-level trap handler infrastructure

Srinivasan Shanmugam (3):
  drm/amdgpu: Make first-level trap state GPUVM-owned
  drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
  drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl

 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 771 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    | 148 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  98 ++-
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
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  | 107 ++-
 include/uapi/drm/amdgpu_drm.h               |  90 +++
 27 files changed, 1885 insertions(+), 62 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h


base-commit: 414fcda62e2f852a47aa8c71341be3141ab74970
-- 
2.34.1

