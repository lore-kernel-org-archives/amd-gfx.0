Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77611606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kg3UHtUQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1EC10E263;
	Wed, 21 Oct 2026 06:56:30 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DD910E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfV1H/XGbXdz7LbTNzqeCIvHvDkb7prc//3sTO7NO3EmW6bdOLfvjuHcdIieRlNTBMQ8k0JSWBABmnlv9C8Y9hM+U9PJA9VT9OhIJs5OfUw/9U7XQnVuDgi+FrBj9mqABS7lkbijyeo8wtuiJYRC/K+VV1k3+yJN3Mzz2LOuNfAC9khqJe69rgzP9kzczHjJca2elkyGB2z2QlToQPyaqRzLcxrnoO82v2LYNPAJY2hkMqxeKWcQJnTrPLKm4thOrc+EZF3rAyECpN6Iu796LSgGziCWZ1+3XZg7wmUSh/q/VIxMLlDrVJ26Zf6sR1C/kElpnmsQ8bAGuBWY8nhStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XPyByES5cR5/gcUH83fcPziGqrQET/zbTwTGq9xqFo=;
 b=isVKq2vNColyHN/1RLNSoNtjHWeQpLmOtrBfokUbsoOMGGEWDWwm0FZ7cHBqS8/lJ6xI2NVibwb6unjCYBCxE08Ds1Eo/itZcj9LONRYs/G0mNSjjEMv8uqahYMUhlD/AyePcowzu2kGTbN6nu0JUF6gc1wDjFWdwslXkKrkzHFVO11zPNVK9+zwevowGzNKRnp/qbLd6hDkdzdtHUU47COaKnk6Vgm551ZjTmaXVhWzOnPvCcwZ/+QXwmsKrDwkJPaIrZPaV50pNljoVyDSGnjZBefuQHWBFhcOJ6cFHhjwKyhaWU88Z6GWL+lyqJyxR7AtETUFmzpfd0ud562mVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XPyByES5cR5/gcUH83fcPziGqrQET/zbTwTGq9xqFo=;
 b=kg3UHtUQ6CH/ja43K+vjbwrxjrkGr0EfDM20sNeKQr8pXHyLpoZbkNy4xfoqu534UUejnNgXKWSTOxR6x3F8ggh1VkkvpC+oye1ET+GtppyNzvg4W/4gCwezKo4uXK5x7Jar9UBDDuDbJSCZzAY8T3NtYh2pJnEed1kPILGnXP8=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:56:21 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::29) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:56:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:56:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 01:56:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 0/7] drm/amdgpu: Add CWSR and second-level trap handler
 support
Date: Wed, 21 Oct 2026 12:25:56 +0530
Message-ID: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f686d9-aeb6-4fce-f6a0-08df2f4069b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|6133799003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: U9+TAKhQA/ZEKmU+tUPi7CnBde5CSE/+RMxQcS0bDigAe+FtUsA4QBqmX4xbTPyl6SeDvCj3Wawqnw+b/CcTQ7J5AZu3p5ac4eoXPPkfE83FQR2t4KjTjC2FYdlMMsA37/pFEwI43igzncsEjhOuk/KSgv+eqCImvcUh8fGcsER0nK2tord+C5WYoO/+nP9A+Kp6KzOuzpQb4QA675VQeKxC3rUgfqRRv6Og7ukOi0mJecZ9Tip/giJwEs3In7DQHRYNX8SImCIZojEitE0UZ657JK8of63gjnOPgIAxx7U8tF0Yb+yjjyiFN8iTGbuuLIqmZTmYkKmzw4X8IadXbNhPtwQoAtPl0Bt40U7eQK8JsLs3LHwMIrHE3XvqtiBTCgye5puPtadUg4exWVgMTxG/Ek375n2BM0nv703VWBoZ3h1BlS6uy3YxvdGkPMiYiWvWva8gibnHLcIK54wC8XqmqOAuigjb1zPIr6ObChK8SbOVxnTzeV413GNDQYMQWiZ1wcUFzHKYzy79Fd5o9h/ofosOEg+ot3fX/4EVx6jDh7aed8J06LRYslnztZt/StQ6DunPzSkPSy5uWyI8CYE2fMiP1YyaB1/C8GCbNg08b/rmcmvVpZ/8ciWJsi1wbdUTvouVa4TKXfYkukyyyUph3YZYSNRYorwN6s5iUEGJVdxeJoWAiRKZSTJDRd0qvUw3IGnpJaYLL1It9abaBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iQjIqcSlKVC6Ktew+i6mietkFMjFtF96JQKBHeP0iwIlQI3/GsTkjkJvoyQD6NkLBpLv65NpB5egqDxQnM/8abfyr9D3dHuniXVZ5Ca93Qyjzrou7m5dkn/9SK1oU/ExgByiLRejbCJnc1NCSzJV/wWq3WMboHI/55W4k0EzCnKEJz6NQKZFJq/zVXozPRjrRRZdGgOZldgmLcHdt/oGpUSf95e4uOfFGtdp5T58CB8oBgo9AuwWHfK8mO+KcXOwtzytdzLtG1+1UXj5QD+PK2RdYg/Lj+eMqvLWNj+si2Nc/mQRFkLCtrfa6WomwGzsOVKmMbgS8PZqa/p/ZKplqJIQ3IN/13bRlXVk5sv4P2JiOEpf/bnSkeQCnOpoSVHYsrnj/oGifx4Kr+ni5lROPkRnlhzxlrQkDIo2gsdnkJwqIpB/84MGlXptIpL618SI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:56:20.6781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f686d9-aeb6-4fce-f6a0-08df2f4069b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds CWSR support for user queues together with the
infrastructure required for second-level trap handlers. It also
programs trap state for kernel-managed VMIDs and adds UAPI support
for installing and clearing second-level trap handlers.

Changes since v1:
-----------------

- Address Christian's review comments in the CWSR integration patch.
  - Move the CWSR enablement check into amdgpu_cwsr_alloc().
  - Follow existing error-handling style in amdgpu_device_ip_init().

- Rebase kernel-managed trap programming support on top of Sunil's
  VMID-mask changes.

- Replace first_kfd_vmid-based handling with vmid_uq_mask_gfxhub.

- Program traps only for kernel-managed VMIDs and skip user-queue
  VMIDs tracked by the VMID mask.

- Preserve existing trap configuration while extending support for
  kernel-managed VMIDs.

- Update commit messages to reflect the VMID-mask-based implementation.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c    | 543 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 723 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    | 148 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  60 ++
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
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  | 106 ++-
 include/uapi/drm/amdgpu_drm.h               |  91 +++
 28 files changed, 2351 insertions(+), 51 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h

-- 
2.34.1

