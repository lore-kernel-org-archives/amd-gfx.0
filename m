Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2348CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D6761452
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5D6761452
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DAC26EA45;
	Wed, 29 Sep 2021 12:01:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 330346EA4A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLauhy/nUV+Hn+FJrt7FeeRzSVIqDtXT+PvNtzwKQiY2Depi/CheZicuuwh+XewnOzR/NUIUx5R6GrISGxfMcM+tdxrco8TDivRbOoST73TMlIcG4ZJze1NWTVsdmO1lE603QEVRzNJYp0XKhpabNGmTDiRbagBpES3+7aqQlHUofzc7T2WRlFPgr9xn3j3Mn9GTiIl1SDzSw61bny5hPVKjoQ4qpxzKRZXjKxpX/j9hTXnqHxbDlvTlo/UFnlU4Dy4MAKOhAOjTQT+m+lW4ZyRojTRMkTo3soLG0W/mTQuOl5CTg+srDYIGDx+ouXHOtm7fgmPWHUj2z7UXL05O8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=urqkusHXtNy7P72HHRjwfQ+Zd9y0S+ZXn9GrCbQMtHQ=;
 b=W+X4JGsCsmjBXKNZk5DV3IHrkM3YdczMB4Qmgsu3Mgq2uVzw1wyo/b9l3qrfOpSD2ujoB3slSugUD0FwH46Pt72ubFl2bd2zKDs7XyR+unGJdYktvx8Sr5GKeAuK6ptfJ70ZtSoOPHUWA5bT9VASJs6ldHA+fI5rjISEYrR5kXyX5UvHjD+5t4eobwmx6EfVnNS88xAUwRSIdwMvK48/mEIiRp9aPd8u/KyZZIcUpLsaQz9qBr+dbyWxngpsdd471POLduzgCQUgE85YtlSI7I29D4XmYNcbU8OQWelkCHK+EasNAnJ5bnp0k7A4HWE7BCADccuaeyYgETArnptf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urqkusHXtNy7P72HHRjwfQ+Zd9y0S+ZXn9GrCbQMtHQ=;
 b=AqqRxv2H6wirU+8p4SBYYdgUosQyDnasaOyUALcpxJTX/Th3Zff6EDtVqPCicyT/s+mErZ4MGHWp0kQnJJjXpBQoLfNz0OP6BIZ8ghFdad7dZskUoSoGF1lV+ltW2U1M4UF9UdKQD8xZecq6R7YR+vzRD4qih3vCwAIdewmC0+o=
Received: from MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::33)
 by MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 12:01:04 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::d) by MW4P223CA0028.outlook.office365.com
 (2603:10b6:303:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:03 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:01 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <david.yatsin@amd.com>
Subject: [PATCH v3 00/16] CHECKPOINT RESTORE WITH ROCm
Date: Wed, 29 Sep 2021 08:00:22 -0400
Message-ID: <20210929120038.6485-1-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53852225-b884-45e7-1ea0-08d98340cfa4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3950AFDC6388B82DB227C06495A99@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ot/felrzNB+ANegPJAd7QwANDsa0GmFLzt0Pusl8z1gcIL38xzmRa026bjuElvDDFyFaV4+RSk4wVoO7aNb8Y8WTxQ0L5b9Jco+FNjDvne8QoOPOIu5cCHH3zOW6AuHqtDPOQssGIWyr2N50g1Qs2wFmEo+ySmqQMoIn7OSMAK5JEqomeErWOLQZ3jkg3HECYmSDU1ulLKBAH8gKxYNMgoQEdromvTcjpULdvRSN8bMIt/JpM7rsUcTPSVa7e89ymXOM7TS7pmNUbFABdE7/twsX+Ce5203v2AMFJEAK0EkbX2/rO/FZeALPnZDdAMuj2pSK149xsePLkAd1Eff0v0xvvI4mAKFvvO5M6Pf8hJCvQNflrSgzotDdC7vNkJG4tY8Q9Vjf4Zkmm7JGZdMC6eWoXdpKn+VjiuftD8WIjS9mlS/orgkjYUuqI12P3YLClGlWPZEUEMVrcy/b9e+g6nN464VyAV+qFD8MGgIjpPT+fROnKMQ7BSs6aHEk/wbzFw1ZDYZHYSj0Kv2YXBvFymaUBTiGysyv4CGGvjQo6lW07i9/YR5FYN9so6pmK71E8JmneF2/EKfnd0XJG50vptGsHOBqWguzRNegExhMMKLa5Akndj99IxSIr7ERtbmzwsxhLAExWtfHfjfSB62mRDWBAtBYrd15WcDT85sNEJyZeeA/Drmr6YNLwmeKtFjTMQKJyDyau1jQ+kWREUClYrP4Ok2vhF3ic1CzutLoaotDGj+LYHjI6SRiELEZATz7Ue6ITsy3H4gHIwc5X6mM9pghHx7Llxe/5vsDKQ4Hwzmp/MdQ/9KDTO39c7TM2WlfLlt6JWmAeAqzdR6cCYb4zo57mgLaUgta6JLi84LN0+I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(966005)(26005)(4326008)(70206006)(7696005)(70586007)(36756003)(81166007)(356005)(6666004)(2906002)(86362001)(2616005)(5660300002)(82310400003)(16526019)(316002)(186003)(8676002)(426003)(47076005)(508600001)(336012)(6916009)(83380400001)(36860700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:03.2898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53852225-b884-45e7-1ea0-08d98340cfa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
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

Our changes to CRIU are can be obtained from here:
https://github.com/RadeonOpenCompute/criu/tree/amdgpu_rfc-210715-2

We have tested the following scenarios:
-Checkpoint / Restore of a Pytorch (BERT) workload -kfdtests with queues and events
-Gfx9 and Gfx10 based multi GPU test systems -On baremetal and inside a docker container -Restoring on a different system

V1: Initial
V2: Addressed review comments
V3: Rebased on latest amd-staging-drm-next

PS: There will be an upcoming V4 patch series with minor additions to the API's to support HMM.

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

Rajneesh Bhardwaj (7):
  x86/configs: CRIU update debug rock defconfig
  drm/amdkfd: CRIU Introduce Checkpoint-Restore APIs
  drm/amdkfd: CRIU Implement KFD process_info ioctl
  drm/amdkfd: CRIU Implement KFD dumper ioctl
  drm/amdkfd: CRIU Implement KFD restore ioctl
  drm/amdkfd: CRIU Implement KFD resume ioctl
  drm/amdkfd: CRIU export kfd bos as prime dmabuf objects

 arch/x86/configs/rock-dbg_defconfig           |   53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |    6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   51 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 1179 ++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |    2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  185 ++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  323 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   11 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |   69 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |   71 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   86 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |   78 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  137 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   68 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  474 ++++++-
 include/uapi/linux/kfd_ioctl.h                |  221 ++-
 19 files changed, 2792 insertions(+), 262 deletions(-)

-- 
2.17.1

