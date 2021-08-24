Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F7C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BC260F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61BC260F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0209C6E0BA;
	Tue, 24 Aug 2021 19:07:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C9F6E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHkaYche4Yb2NvEb/cJDSxTdGL51LpBp0O/UqGMjcF0CQGYNLYzb6NXkNjHUYT35RhlNvER53a6Fs/YrdqfGPFvkgagz0rgl8G0LtDjrGIVo7NfRIDQJiLFUIuk1W73sZkc9Sw2KQy5VofjIhG941LFsGFbgTJK4yzp08PPnYQRmXi2MI8u8ds8NFsL6D1qGZqkKD457ipAajdMMOesAtEh8KrXrM0hEKQA4904p35Axvjkbx5yifNeWOsymSvfKfwrh1D5t6eX/KPW8rNOtuDjNYvFsKnagxbz64bLVaES/P6Zc6WwS0eqWNuP8OZ4vK/zxVW/AtqxK3kyZAmMSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X74z33n69NNH+lAdCYaXuqIV5N3vC0HWbmgwJ2BCJEM=;
 b=b6dANRvCYkTNJoKhq/3TXuM52y444WQ2qWK1cc67kprFXG3FKxXeeDAq7tauCjvLQbAn7HDCJ6A9WQHNsVFsmH3/RImC3DHtUGA3lfiqK6G6vwQEUJ3uDe1ofKptj6hAQnwTmncRUdCb3qvShxBlRbLuBmytCzzUsPIztZZymRaItyZ7ZERXP++NPswanqIgfmcMWZM/4tRkOxlN+r0DnDWekaglGoXYrzJaHBmeWuBky397sFzAoSaUAEBO5JBLGNr+IEwWY4d9UUmwasggOX1NUAyHsjWUpUu0kW0+zBfPhjfmu7ejefzCHF465mYwVdCXUQQg+9UbFYBkD7LQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X74z33n69NNH+lAdCYaXuqIV5N3vC0HWbmgwJ2BCJEM=;
 b=etmwvbSHTs3hXgSUUxKEVun+8fAz4VVnTLK3Sq6yZ0MeIrVWVbTa7neRj2GS92zal7Jvbdg59TysCw+BQYCwyRFh1sFGBzdFMqxGyq0AAhN+RbRDQi2yyysWjjqZL+6qOYArIjLRvZR8g6eBCG2vWStnBaBYti1oQ3cSieKImfE=
Received: from DM6PR13CA0034.namprd13.prod.outlook.com (2603:10b6:5:bc::47) by
 DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Tue, 24 Aug 2021 19:06:59 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::b7) by DM6PR13CA0034.outlook.office365.com
 (2603:10b6:5:bc::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.5 via Frontend
 Transport; Tue, 24 Aug 2021 19:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:06:59 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:06:57 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 00/18] CHECKPOINT RESTORE WITH ROCm
Date: Tue, 24 Aug 2021 15:06:21 -0400
Message-ID: <20210824190639.6288-1-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b51a756a-0874-45b7-3035-08d967325923
X-MS-TrafficTypeDiagnostic: DM6PR12MB3993:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39931DAD318DB9D087FA109595C59@DM6PR12MB3993.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaFYrd1OLy5CBY9NWHZ56Xs8QOF489RrFnT6bN4XreRAOLm1Ths18EmzY0laX2YzhM9093dlh9LXvNlXfb8H6ixlgEV8kWyl3aXPOV9S62NKTAPhNt8KB/tgcRZRMBUkBS4f3SA/7c8HNwbN2ZWSrFtom5eRkC06IPGsOrDiYP97BYwRmW9o/l6tRwZDz6jx2/S3RFyKTDVqYjYiZar0JNBWAhLpGZ6AQ1TaP3koakDQOVtJbNoesA7GdLp8kRj9AMH6SLp3QDdW1Mx6QJSHNwRQvHDv3QMHW2gO9du2DsFPaMbSnz5WQqJ1wuCOqW8PwIptbBcz3oRyKDDCHMTYWAugZgwfnCcQqCOb00HyJJ2ttMAo3KBeOCuyLhViGDquM51FpallfUBFx8Jc7b+E0ZCuxOAP04Ne9E2t0ijv+Vs0m2QytKNNs5dWBuOx0QiKREVO2Qm8yj1DDAqvavK9LhtfW5UPgQWOtxhTU/IaEeqhIcQ2z7qgV0ZCmP5hTtqFOH2A+D6dNJ02TYiXdegtLH2ET4hILwNlMJOJiSQaxNmiLdvkgjWBOON/R1Q4JwmkB/pKSm2uuhX1Jovx2L7DdVZYi+UgTH+pkLN9plugKM2wxj6P8vnVzUhnJraZX/l1knAOzdVBkBemtoC1zQcQI1xnsmKBqmMrB1HQKl61sr7G5eVgwB+uJb5ujTNSr7QkPGy5L7e5EJR/Sij0r/X1QpYO86ZmogDltCJ0HNJWJoB4oIcAxLfi8fOMrREWvYRuTkvp/RU/lChiUz24IKZjlRaqfpoEIE7CkSpBGxgkoNnHtJVnRnW8xa6Y70Nzvu2+NTrLuTPhg2sn7C7SQV0MKDSpAfOgxr/CHx/BBf/jHIs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(47076005)(6916009)(7696005)(26005)(81166007)(16526019)(186003)(2906002)(86362001)(8936002)(6666004)(1076003)(8676002)(336012)(478600001)(426003)(83380400001)(82310400003)(36860700001)(4326008)(316002)(54906003)(356005)(36756003)(70586007)(82740400003)(70206006)(966005)(2616005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:06:59.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51a756a-0874-45b7-3035-08d967325923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3993
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

CRIU is a user space tool which is very popular for container live migration in datacentres. It can checkpoint a running application, save its complete state, memory contents and all system resources to images on disk which can be migrated to another m achine and restored later. More information on CRIU can be found at https://criu.org/Main_Page

CRIU currently does not support Checkpoint / Restore with applications that have devices files open so it cannot perform checkpoint and restore on GPU devices which are very complex and have their own VRAM managed privately. CRIU, however can support e xternal devices by using a plugin architecture. This patch series adds initial support for ROCm applications while we add more remaining features. We welcome some feedback, especially in regards to the APIs, before involving a larger audience.

Our plugin code can be found at https://github.com/RadeonOpenCompute/criu/tree/criu-dev/plugins/amdgpu

We have tested the following scenarios:
-Checkpoint / Restore of a Pytorch (BERT) workload -kfdtests with queues and events
-Gfx9 and Gfx10 based multi GPU test systems -On baremetal and inside a docker container -Restoring on a different system

V2: Addressed review comments

David Yat Sin (9):
  drm/amdkfd: CRIU Implement KFD pause ioctl
  drm/amdkfd: CRIU add queues support
  drm/amdkfd: CRIU restore queue ids
  drm/amdkfd: CRIU restore sdma id for queues
  drm/amdkfd: CRIU restore queue doorbell id
  drm/amdkfd: CRIU dump and restore queue mqds
  drm/amdkfd: CRIU dump/restore queue control stack
  drm/amdkfd: CRIU dump and restore events
  drm/amdkfd: CRIU implement gpu_id remapping

Rajneesh Bhardwaj (9):
  x86/configs: CRIU update release defconfig
  x86/configs: CRIU update debug rock defconfig
  drm/amdkfd: CRIU Introduce Checkpoint-Restore APIs
  drm/amdkfd: CRIU Implement KFD process_info ioctl
  drm/amdkfd: CRIU Implement KFD dumper ioctl
  drm/amdkfd: CRIU Implement KFD restore ioctl
  drm/amdkfd: CRIU Implement KFD resume ioctl
  Revert "drm/amdgpu: Remove verify_access shortcut for KFD BOs"
  drm/amdkfd: CRIU export kfd bos as prime dmabuf objects

 arch/x86/configs/rock-dbg_defconfig           |   53 +-
 arch/x86/configs/rock-rel_defconfig           |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |    5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   51 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   27 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 1170 ++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |    2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  187 ++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  323 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   11 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |   76 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |   78 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   86 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |   77 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  138 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   69 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  475 ++++++-
 include/uapi/linux/kfd_ioctl.h                |  221 +++-
 20 files changed, 2815 insertions(+), 263 deletions(-)

-- 
2.17.1

