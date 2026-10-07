Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873C5CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6BB10E432;
	Wed,  7 Oct 2026 11:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a/VqlEHW";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4CE10E432
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 11:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joySR2xHdCIMtKzTneYFtp8Un02N54J17fwkU+TDp5r17o4lP9/rGTNO6An/WfPQ/VsSuF7IZOvfFHy4HXyJUZ6/kRV8n7JW5Ts505iAFTsQMJFUf705vqSMXWgIIrabUuEPMfkdyoKF4ke8fljqITnuE+P83oy9Jy4e/fWTnS/WhR5ir0KG3P0NB5g+hALmBfx33Hx2o5U1Ljx8jKZ/LOONmMPXIZBw5BVYepowqpaUcNSh6rfizcZWsqJ0QA0X48JCPj8CnBQpqjAKMTNztqLtSMRr1G0kAT7A8w9A9CfDENF+GHklMCspmqnXxurYlP24tiwl6DGycr5F0lf9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhwGOe75lCwgJ78XqNG1QU/n8LEH7JcbVzsFQyr1SS0=;
 b=XTvwd7m5IeY0I61IrJwwbvmD3JBvP938DBrsOGSQvIj1I8epA1pB8XigRXidKLE2AvTQb4D9ivuYpz9FxowaTw/VG97pvIW2l4XmnDoXFY1sTPYqkxXc+dO7J3H+whbRgA+E1tIl/+MEazyAfzlO2qR0CUzgCvQMJyagR2TOg8In/3V/dF/hTSjl1uSwXOtxUzhxo/+Eu9kaHvL4mo3xNAtrrK0MyTi6kISI+cGQb4ewvOnTIx3ef8kj7Xgclqebk8wOzCU55bLWNyNf6MTy39jBtvYRkBFjD8bI4oXnxIfB7KFkQR1eNzkWSNjwx5k0ULLSgbHv4Blp1nMiRWoi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhwGOe75lCwgJ78XqNG1QU/n8LEH7JcbVzsFQyr1SS0=;
 b=a/VqlEHWZi6xRu/TueNif9ah6gkkBo53/9qZHP3G2N74VHvPSaPk5Ha6iluwqOtrPtU/XfeRBUPBgPzSBWRCgqeuM+b8XmQ1ksbCNbIYZzGrG0RELed0azI2Oo3mP0BUMmXWFoxCPdGgnnrwbWPPm8MpdmCoa5gtL0oADkIbvK8=
Received: from SJ2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:a03:505::20)
 by CH3PR12MB647349.namprd12.prod.outlook.com (2603:10b6:610:365::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 11:05:22 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::9a) by SJ2PR07CA0011.outlook.office365.com
 (2603:10b6:a03:505::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Wed, 7
 Oct 2026 11:05:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 11:05:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:05:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/9] drm/amdgpu: Add CWSR and trap handler support for user
 queues
Date: Wed, 7 Oct 2026 16:34:57 +0530
Message-ID: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CH3PR12MB647349:EE_
X-MS-Office365-Filtering-Correlation-Id: 839cd52b-dfa4-4077-0b20-08df2462e1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|18002099003|10067099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HeuA3FAp0Q/Vy1AiUnmNHL/OrB0nEF69Ly6BlQuvvRfU+TsSK3LsXZcWYfeYU0rH4TzjODLYkzyaGgG8GVGgi7eBLRTNdH/s6ap9jIvy00lUCHPje3dzM5afkJ7yvIaPrZQPKfq/S4mTBA5qeCGMBccPJ0qyUea+1VFvf25wenOyLynidQttSwF6wWcQ7HEAQpkBRN+D3wp9NCDwlkycLr9SHvdRdTLRwywXcY263/RM1ZszG6BgLEZK1x+FJeB3wgqQDeWRSeSb5GYFtIydj79xTxB6uHpH2KCW4cNZFEamTWFApqDuUlmrZ3X+qT7ONmU6J8p7XndqQl9I/du7E+s21wgwvXwlqXVrGg6RQ6U8f2bLO4DxOvVGPQDekaC0A+wleq6JVY6s8326pUqLdPoRhFdHxEStQmpgEIb6TQlMgNmhuNcjGT4Xy6pvE4w3JVKUOeK6+Il5EPUckxDzy94/96fqWoTo54q66pxdeef1yjuSzN0mkoE6yMfkI6Ao2LQ4HowSYUiBqjEdQ4xu8hH+MXdSmJkTS3CCYszUm+dhP4dqVFKtO66uNUAd2lfBEQrT216KTs6yCFYznFqwrXXQgP+yzIKPIg9DQLJdM+J2fMRGmVFcH6J/8qcJSfINcvrcpieupAX6Lwd/yj+a9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: piTQHY8cCI1ZC370hMNUnVv8DkJROZWmI02XWc5kETvW7S1AqWl3iVary6vlK05NS7upt9dLkuAi2tT8m586Kk/G29VAfk7KC4nNUfmiZW88H9OlyElNW3fmiDHSm5VEtXPlerD/u7M1/ZIjiqdkhxQRTgpPByRDbO1EZrDnMk3hdd7Es8QBcaQIE+crmCIx6mby3lGyK8DrSYUV3vaP0wHwXUN+WLSq5rZFvM7gDZYwk7Dck+rerScvxBuj+lvRFDNTX01ty4M1oOFRV1o2wxh0obhe5FefME2L5XIJPwsQtagMKkRtwKMe0ydDRvchpXnAaT0USAMVNyywBZokam8shMRTbyaeulZCQ1jejOU9TH3EO0EZavTHyQwePkT0T3kbavM5JWmWcYo5G/xfP7e95RQFVCPkFiBML04F9nKS4kOYh0sIv99YKEn8IReA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:05:22.3182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839cd52b-dfa4-4077-0b20-08df2462e1d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB647349
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

This series adds CWSR and trap handler support for AMDGPU user queues.

The series introduces the core CWSR infrastructure, including save-area
sizing and validation, and integrates the first-level CWSR trap handler
with the device and user queue lifecycle.

For compute user queues, userspace can provide the context save-area
address and size through the MQD input. The kernel validates the
save-area parameters and the associated GPU virtual address before
using them for queue initialization.

The series also adds userspace interfaces to query the required CWSR
save-area sizes and configure a second-level trap handler. An additional
interface allows controlling the debugger trap flag in the TMA region.

As the resulting infrastructure manages more than CWSR alone, the final
patch renames the generic amdgpu_cwsr infrastructure to amdgpu_trap.
CWSR-specific terminology is retained for functionality and data that
are specifically related to compute wave save/restore.

This series is based on the CWSR and trap-handler work from the
amd-unified-interface topic branch. The prerequisite changes were
cherry-picked and rebased onto amd-staging-drm-next, with closely
related commits squashed into logical review units for submission.

The following commits from amd-unified-interface were used as the basis
for this series:

  4cd417bfec49 drm/amdgpu: Add helper function to get xcc count
  c50a45b2e98d drm/amdgpu: Add cwsr functions
  df9097c600d2 drm/amdgpu: Fill cwsr save area details
  b3d79401d5eb drm/amdgpu: Add user save area params validation
  09673227ef61 drm/amdgpu: Add cwsr to device init/fini sequence
  6748338e7d6e drm/amdgpu: Add first level cwsr handler to userq
  7ca9abf4ac38 drm/amdgpu: Add user save area params to mqd input
  2b419a703c20 drm/amdgpu: Add ioctl to get cwsr details
  310b37612d61 drm/amdgpu: Add ioctl support for cwsr params
  633f9544e6d8 drm/amdgpu: Add ioctl to set level2 handler
  7289d8136917 drm/amdgpu: Add interface to set debug trap flag
  71c944500a84 drm/amdgpu: Rename amdgpu_cwsr to amdgpu_trap
  a0fe30c73b88 drm/amdgpu: Fix recursive ww_mutex lock in
               amdgpu_trap_alloc

The recursive ww_mutex locking correction from a0fe30c73b88 has been
folded into the patch that introduces the core CWSR allocation path.

The original allocation path acquired the VM reservation through
drm_exec and subsequently created the per-VM TMA BO through a path that
could attempt to acquire a reservation_ww_class_mutex again. The
submitted series instead creates the TMA BO using the VM root BO
reservation object from the beginning, avoiding the recursive
reservation locking problem.

This prevents the series from containing an intermediate commit with
the known recursive locking issue.

The following user queue validation fix has also been folded into the
patch that introduces the user save-area parameters for MQD input:

  drm/amdgpu/userq: reserve the VM root BO around CWSR param validation
  https://patchwork.freedesktop.org/patch/755116/?series=174525&rev=2

The CWSR/trap parameter validation eventually walks the VM mapping tree
through the user queue VA validation path. The submitted version holds
the VM root BO reservation around this validation, consistent with the
locking requirements of the VM mapping state.

Folding this correction into the introducing patch similarly avoids an
intermediate state where compute queue creation can reach the VA
validation path without the required VM reservation held.

After squashing and reorganizing the prerequisite work, the series is
structured as follows:

  1. drm/amdgpu: Add helper function to get xcc count
  2. drm/amdgpu: Add CWSR functions and save area handling
  3. drm/amdgpu: Enable CWSR for user queues
  4. drm/amdgpu: Add user save area params to mqd input
  5. drm/amdgpu: Add ioctl to get cwsr details
  6. drm/amdgpu: Add ioctl support for cwsr params
  7. drm/amdgpu: Add ioctl to set level2 handler
  8. drm/amdgpu: Add interface to set debug trap flag
  9. drm/amdgpu: Rename amdgpu_cwsr to amdgpu_trap

The two locking corrections are therefore present in the patches that
introduce the corresponding functionality rather than being submitted
as follow-up fixes later in the series.

Thanks,
Srini

Lijo Lazar (8):
  drm/amdgpu: Add helper function to get xcc count
  drm/amdgpu: Add CWSR functions and save area handling
  drm/amdgpu: Enable CWSR for user queues
  drm/amdgpu: Add user save area params to mqd input
  drm/amdgpu: Add ioctl to get cwsr details
  drm/amdgpu: Add ioctl support for cwsr params
  drm/amdgpu: Add ioctl to set level2 handler
  drm/amdgpu: Add interface to set debug trap flag

Srinivasan Shanmugam (1):
  drm/amdgpu: Rename amdgpu_cwsr to amdgpu_trap

 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  31 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   | 655 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h   | 101 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 107 +++-
 include/uapi/drm/amdgpu_drm.h              |  50 ++
 15 files changed, 1034 insertions(+), 34 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h

-- 
2.34.1

