Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6389AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E07113702;
	Tue, 17 May 2022 19:21:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164DE113702
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ7AvrUPZYj+fd9wzOoNtyleT8ItyEEHq8Wxg3B/e0uXzWekvjrsHbcmNw8GivUf5cqKEQyB23oLlJUt7m8dEhW5BQI8WOFRjXVGYdf1l74Q+w4VZyHPwFZMq2DSajW35JzeFL2bwzORJPyto3vaeectU02rdyfPtwFAdM0XBEaYa0PKXOXEfTdr+ulIxxwdeyr3CrKz3BJjQdOmT5oVbeqsE0aKWOJNdOByWOpiShZauBiyJm+u5QEZPF6pG5hqmzjxRUZqebzpqnHDzlJQMxQ3P3q1iQmAEaSPgPMFVWqc8AytVH9ThtehVTLy3Q81GLILYAF6Y7ynT2ayV57IAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJSHBA+z+JI3iqyD/93haJdTkRXcdbwXRpOfUdNeFWA=;
 b=TrvrYo7cjM81fuXC46Np86xO1nSq+ZBggIUnryWhfKsDU+35jRfi48db6o8UPDvfndwODuWWB6wbyZUVjxKrzJqpz+rlnHc8gH7RKsMNkcK+3Y9aclUjPmG44pnmZsKaPwu4sSDWyjTmviM7oG4d/y5nNOdmh1j/fpUf2JLsItya6tFBMDJqZdTMdJ9Gg/x2xUfGdM6M0UM920cYQh7+dPlw/X0U14Lj8laCAhdJzJMK88QFx2vla66fE8DSsALprX56dlDOltks+lX9ROUd8URRT6o1KRgnNzc5ubrpgWx6CpxpY6B6DOodlUFrDbTmt8bluYGoteECwUvXajunoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJSHBA+z+JI3iqyD/93haJdTkRXcdbwXRpOfUdNeFWA=;
 b=X4e9xf5n0n0U/44cW76rp8kzc8wehL29M5wdLoS55zBTDt+Low9Srwt5bYb7J8O0AgON384U7X2D8UUJS0Bgfxntm0457LiOXVqfzSkmrYNKSIX7DN4SF7mncbVi5Mkuq7t6sIWYvWcq+iz2kwhZlpSstszxC0SmonuU4tfOKTg=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 19:21:25 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::86) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 19:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 19:21:24 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:21:23 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/7] Fix multiple GPU resets in XGMI hive.
Date: Tue, 17 May 2022 15:20:55 -0400
Message-ID: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 074166bc-e9a1-48bb-e85f-08da383a6f2f
X-MS-TrafficTypeDiagnostic: PH7PR12MB6491:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB6491E7038B3B5BEB43C468C4EACE9@PH7PR12MB6491.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkwXGgmHmco1WOjPVahPDpTxoEV2218YCCL5+9tPdUAz7pbD+gX7ljBclfc1BTGnbuib8u7nCp6gZQKnrtHABO0Or3VhxaAp/hX/hFT9URhI/iK5N+6yK6CVH1CdBRmO/1tyiskMbbUyBwUgzJssJggM7+PNE+ghRtcYi+PKpu2WkYFQxPj8PZfF5QHai0I6IAHdMzKevonToP0opgfAToiz3PJ46Y27nJIFsrK/WpXYegA9rv082YTtvP0O5IRdeZStxbqDV9GAIU0o32rFLVTlt+zH2/uOUZqfTS4h3RfjF6IBI551gsS5sHD+S45NQeLtvYiFSQwR5BuoLk8w5xH3tWkanTbWTrcs1eKPbpKcvVMCyJEryioBf+vZ/LI2HUaHWYwmDbFm/8XLkrkNvX5YsF1XnlUw4mvPbGteU6GFeY819PT+s+BDvFmErKMXrinBGPmnC8VjhrRfOQ46LfRcbWFJa/0S8oBXlITXGKQGbh2sUYaCF0akkRU7P5aSchmt3G5L0ScX9qWXtTgmasc5FzJgQ9CCWQ5s1Wc3FQf3dk9i8v5s6qOU39NLp8fONsWox0ZU9hZ2dOGh5VUZHlpweOLeNUapWCEJTni2VtoWbXlRCewCWmVGOj9EvZeFRHtVyNX5u1p2RfcfGYeSmapFm8zl8JT+hPlcViPmDeKgxHmlk/n0flgbHUo9QxnlVdylHoxpX+b0rxA0H/BJjEOyWUatu7+VasTayvB6bhM73ifoL4Z6yOQ3hcs0nzOOEUY7PW0W5z2yR1h6gr7VCcCwrw9nUvYokXzU37Q9lK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(966005)(356005)(36756003)(81166007)(8936002)(5660300002)(508600001)(44832011)(26005)(2906002)(36860700001)(54906003)(70586007)(6916009)(1076003)(82310400005)(186003)(70206006)(316002)(2616005)(16526019)(7696005)(6666004)(83380400001)(40460700003)(86362001)(426003)(47076005)(336012)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 19:21:24.9140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074166bc-e9a1-48bb-e85f-08da383a6f2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Problem:
During hive reset caused by command timing out on a ring
extra resets are generated by triggered by KFD which is
unable to accesses registers on the resetting ASIC.

Fix: Rework GPU reset to actively stop any pending reset
works while another in progress. 

v2: Switch from generic list as was in v1[1] to eplicit 
stopping of each reset request from each reset source
per each request submitter. 

[1] - https://lore.kernel.org/all/20220504161841.24669-1-andrey.grodzovsky@amd.com/

Andrey Grodzovsky (7):
  drm/amdgpu: Cache result of last reset at reset domain level.
  drm/amdgpu: Switch to delayed work from work_struct.
  drm/admgpu: Serialize RAS recovery work directly into reset domain
    queue.
  drm/amdgpu: Add delayed work for GPU reset from debugfs
  drm/amdgpu: Add delayed work for GPU reset from kfd.
  drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to
    amdgpu_device_gpu_recover
  drm/amdgpu: Stop any pending reset if another in progress.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 19 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 10 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  6 +--
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  6 +--
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  6 +--
 14 files changed, 87 insertions(+), 54 deletions(-)

-- 
2.25.1

