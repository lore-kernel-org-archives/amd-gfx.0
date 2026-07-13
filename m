Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCEDC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 16:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E45D10E614;
	Mon, 13 Jul 2026 16:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KIE8Fw5K";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B857710E614
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 16:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqtUuwU73N3Rxl+9oxqk7LhJ9Qq3WzTBdNskGSEG5Z1KSpqixP5Hs/Ffdq2fqzV2PM/jWG6EJa+GGSE4TH8ECWEKn7RMCcVDrOUI8RpiaNASS77guV5oPWgtHKlaHFF8lWP2+IV/FKzcqbJT1zqTZAwrqQ0QgxQ2er56gvnLKn+6BcoGRBWeAJJxIMmT+T2wxgyZVya1TorwJX5kq3QR/PxhdXsggMGKpihHMQe5hMsvn65jmIB2+QmQLkoaHiZKBDadQaxQQM9IANwwPjuNvqsyflinexdsLQElcFuSDQVHWWSXnaY2pFGz8362Cpx2l+YgcXAnr1KwpJttgujy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QjfSid55Nt+tmuAMD5gL+qpp6TJS03sfgY0QmLRh00=;
 b=BqL6q93bi0sxGgZQvQTYAZV1y7uW7XfqxPFFf2LdCzXmI9GIwijl1bp8A/I4hMGOpyFPTC3Dgem6vb1r9hftxrvxmwse6Ajgx2QLNA0pXUS6rEzQyhQTGPprLr5iNm1InRr2M3cNqi5R70k2HFxbrV1MXbZv0HhOig15K6sGR932+CISRd9XcgnF+DpJO+pFxO+RDfAxYJo+VJMlce3KFH8DnO/5FkW2wcmG3zk5YZohvtO+Bnn7TbZPHd5iu0bsa7T6CVNAy/4tCk2vgpyh54bFXq2zRpOWZyVmSwueCBeF+oTS0Dz/sp4a4z9tY+8476qeRXJnI+Jw8RVxYtxzvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QjfSid55Nt+tmuAMD5gL+qpp6TJS03sfgY0QmLRh00=;
 b=KIE8Fw5K8nJ5OnnjHvTqu6Gdz29IPcWdRm/7v9S47O5IzXAtjlS7FohsGA7rdcA84cu8GJOoBG3ulsxJ409Ja1QLMeSNCb1rbBePg1CG7jbRDHp56K5bErRuTwdlkNJJUs6J1ps0h3xt8qzl3kGO+2DX6K6i99lCpJa3ZaeJfGk=
Received: from SA0PR11CA0178.namprd11.prod.outlook.com (2603:10b6:806:1bb::33)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:43:47 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::72) by SA0PR11CA0178.outlook.office365.com
 (2603:10b6:806:1bb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 16:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 16:43:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 11:43:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 0/6] drm/amdgpu: Add WAIT_EVENT ioctl for render-node events
Date: Mon, 13 Jul 2026 22:13:15 +0530
Message-ID: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c282a93-5ff2-46f7-3afc-08dee0fde7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|6133799003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: ZHyq7oOO64lQwPwz2a91CYvfF609j98JY7pfpGSjksPxSUBzBmggC63WsEQeV3mDQ9JJbikG9aCS9S2nasj4FRGR6TA/9zMjNdRcVa9y7jraueXtDCST5CkjNsfdFLgIzhVZ0pUO11gUYrSkF2Eq2PR64N2axTy+73CUR0v3mqzJSxDY/2Wkk6xkz6KE+YdcYlIKcQ0TPGECOKDUyx4m/1RtKyD/aT3EHEq2vzVhiE5jpSztz3MhUIBDj/MIZ8f2vjtjQpcS8XcJr0Uj87ogwVlqtRe9Ahbkr531/aVSo6SEQMTU6X7KF28IsH9Oi+2DwxzFg9V0fYvNg9ufUs6v7FWTaFQMFQ0Ogw4SxbeN47jL0oxV1GB3bibKCinAL4P7j4WfaC5jyMpuz6A9/mmDi4ksSHxoVVTSrDDS0zHK7GtS4Dm4TjNUeHaATCIJXJWaMJ5Rqu1TWeDyh5UqSuj8pNFxq9b+R5oXUqNCm4RY5js3GEf4bUp5SpIXsOgTnz84NtieYL/Z24uzFyh2FOQPgEmnfsivnu1/22X8vUmpn/B1sh6BiV4/qqeggxgoFmAbRZ8pO1ZRE2n32izjm6hMIw1K4xxLRlsilo/ILJkEXXKfor3dyv+LQH8DeqUZqkydffD3btjDtlNXwhWSJ1uazw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(6133799003)(18002099003)(56012099006)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: elXta2TnkGohWKbShhU/MdGN+z4FbsqeMDhs9XERL4B82vTqS6XPfkje7vvMo3go1Pui7d92jd5OTDOzKbS8kADzK/S/OfYb9AtbjATLF6to3zSTO6KiRDo7e5BFgooWXaUpQPEsDV1lhx4VxcvYCl94uGQXniGRYvQnYpBLkYXBBoVGWq3SilYQQ3YQEUtJFYiI10wLVb51m97PpXjv7ZwfOWXxqsojx1XiqnlffC1PnY5WRFAcRbOwh5nwt4+Y/GXXeVgsah+9gwEasY0/qof//tGNyBWp4+LSMXencYxcdqJbzptXgoekKUqbp+4/4OeY+uhArr5pqYSGf9PD7UkWlFDJnRIW2NC5MS39m8d3EEJ0V9Q0Ia0orEauGbdFnITq6sf+Yq5sZwCHD7JkG3xORmPj3IinxzR4L26gT3CengsZUusiD1mlD/tFxmWx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:43:45.1313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c282a93-5ff2-46f7-3afc-08dee0fde7b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
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

This series introduces a render-node WAIT_EVENT ioctl for retrieving
AMDGPU event records and associated metadata.

WAIT_EVENT complements the EVENTFD notification interface. EVENTFD
provides lightweight wakeups when an event occurs, while WAIT_EVENT
allows userspace to retrieve the corresponding event type, queue
identity, and event-specific metadata.

This series builds on the render-node EVENTFD infrastructure introduced
in:

  https://patchwork.freedesktop.org/series/164618/#rev7

It also depends on the EVENTFD producer series:

  drm/amdgpu: Wire GPU events into EVENTFD notifications
  https://patchwork.freedesktop.org/series/168402/#rev3

The series adds the WAIT_EVENT infrastructure and producers for
USERQ_EOP and QUEUE_RESET event records.

Base branch:
  origin/amd-unified-interface

Base commit:
  540d68973c0b
  ("drm/amdgpu/userq: fix NULL deref in amdgpu_userq_evict_all")

Changes since v7:

* Added a USERQ_EOP WAIT_EVENT producer.

  - Record WAIT_EVENT notifications from
    amdgpu_userq_process_fence_irq().
  - Reuse the existing doorbell-to-queue lookup.
  - Keep queue-pointer-based routing internal and populate the userspace
    queue_id only when returning the matched event record.

* Added a QUEUE_RESET WAIT_EVENT producer.

  - Record WAIT_EVENT notifications from
    amdgpu_userq_handle_hung_queue().
  - Reuse the common queue reset handling shared with EVENTFD.
  - Avoid additional queue lookups or queue scans in the MES reset path.

* Added amdgpu_wait_event_add() as the common IRQ-safe helper for
  recording WAIT_EVENT records.

* Populate queue_id in the returned WAIT_EVENT record at the ioctl
  boundary rather than storing userspace queue IDs internally.

* Rebased onto the latest EVENTFD infrastructure and EVENTFD producer
  series.

Only compilation tested.

Srinivasan Shanmugam (6):
  drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
  drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
  drm/amdgpu: Register WAIT_EVENT ioctl
  drm/amdgpu: Remove queue-scoped WAIT_EVENT records on queue teardown
  drm/amdgpu: Record USERQ_EOP WAIT_EVENT notifications
  drm/amdgpu: Record QUEUE_RESET WAIT_EVENT notifications

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 339 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  78 ++++
 include/uapi/drm/amdgpu_drm.h                 | 103 ++++++
 9 files changed, 567 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

