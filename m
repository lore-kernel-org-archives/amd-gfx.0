Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED90C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48EC10F9FE;
	Tue, 28 Jun 2022 14:51:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7094310F9BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn7aPJDWLzXsiHZNTR1r14S9SmxNb+FgCb8qFXX0MWf7L2BRE8DFQX6xPnD43YSrZBxC8aPjri+6B0zQ3vd7TMJJysyc/Y+H4rG3L5S9oiDrRYQNUYwOxrIC88yZvjfLEDiSu1aZynS5QGRmXEWgHYFbs6F8cYV57Is/GGtiUvdvDjnA27OSdjysyZSKdnGeKodDRcobMdGgezpL2Ex+PRP94U7LRD/PquCTLud97EFHW1k6InIzIIHhNQLFmq3iA1XunwDmJ/wlwEOaL6bkih2hVURnJMeQQYduX/EQhH6wQNNIapz6kjCVNZqFy7dR1xNqfAoEG1CAejEB/Pj4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1nuvTw5WFyAdEs/TvLacbODGk3Fk9I22kPfbu2FyAs=;
 b=j5uKzFJMLCZ49ELIxE8bXMutJ4s2TQ0NCudkpZzZ8XDi0cygFkWr7tUkvv7S1uX3vZLoXisoszn8ic/ykYyhmpQizu3OlLXuuLmcigDEhivBTLUeqZHOAsIV0Qaz63GIiMyvdvCIAjktKCJgPNAoL0hbPCZDl3snH9TEbSWioGE69ZJtpZ8yLcgnIDiu1RrvhkFuEMuRHeukzOEd/BKhEdU3KuWvJm75t7e4C4s0O9SHMyrjsDCck7OWztqwXyRZTaW8PCAWv/IDAkd0WzY/9FyuO5r5E7qZrRimsfaxfJFKiRHfhAJR1BVDIzYyts0JguEy7DunjRD0y155G/MZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1nuvTw5WFyAdEs/TvLacbODGk3Fk9I22kPfbu2FyAs=;
 b=ktdMRJUQl+GJ/o3X1hu2wwGirpq6yKyOFGy/UAafSFiCX3X03hM+Q9UQqzuLWlAjPsDgbntpQ8wnbD+y2KqsLsmdkg7bk9t+ZTLFN0X4Fz8IU9/mjDkqmm63JnSYTB/SXWns2pDv/ERwk+h7c0K/Vm41A3Gkoq523awXIccMcmE=
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by BY5PR12MB3923.namprd12.prod.outlook.com (2603:10b6:a03:194::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 14:51:11 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::f5) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:05 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 0/11] HMM profiler interface
Date: Tue, 28 Jun 2022 10:50:09 -0400
Message-ID: <20220628145020.26925-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f18eb7-5525-4287-5fa0-08da5915a410
X-MS-TrafficTypeDiagnostic: BY5PR12MB3923:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gc7wCHk65+t9eR2RuWmj2aUopS//GpvqoE6a0EH555G0br0ISx5vVHR7+oMIKMIz11DH6qDJ0ZJAMZI31aOcrYQEJqQMSAnldpfbY5LH5KhCXlq+B7/tsZFBP87T0ezFbXiuQF/4rghLObTC/yBgXVnJQzGVKTItNQtKrg6skA/qO8rNwO6TLyiBINbka9kS0lPwBR1x6q1KpsSldJY4TYU5ggO44XSv+sCIEefuvF4hCphoOoBWK5UHFz1HCI392lZMsMK/SZsD84XvdJpl5bo7IajI+tv3vUwk4BKoYSVY51bo9WVgnzxnLdYQGIWLTWmLfP9nqPK7kvN3Kn1Pk6ZW7kepp/Yg5HtFh4nDdn6Q98QdZifiFwKZkqfHx8veXwWg79DLng5RQNTpBjlkjryfBWgiIJHsgJ5UnUBYs/dxL71joMDY10xu07Qas6cxwU2335/i2yLtTicS0hzLNmhLIdEOKadrsTBU2f51nQA3kCXemHtmWbD/ueqMqqa/Y+Nd7nXKmUXDRfIFA+ys8I9yjgUczn7A+PSSi6K5ood4W+AyknakxBWbVOPzBaOB4LX4pIw14vdrUDcKoR0jWVCXnyxtUdm+pGaLFBVlqSB+AcUBkEgD61cNUdLq+y88I9yEXZBIQfz6vLqjAyX6L4ri2lhN8FoYc7QyJsKJ/0pIx+ui25Z/bqqRL2kMHLo3dbbuMm2LM5lLo00aygnuqZOFtbk2S382J70oP1jZka+jd1XqC2yFIjcA24hqu96zEa9C2FApEJ7X4IUMvcYEcoyh8tWanzOIA0cO55dwTFh0/YRkLOL/w1bBugpbSid0OOWnQyK4bC0rJ9UpPghKUI/4n2ygcIPHTnf0W3BCdMPlYdxOdycZsvBfV9u1CgVI777h0YmzNjo4NI7LnL+ygA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(40480700001)(2906002)(336012)(426003)(316002)(47076005)(83380400001)(7696005)(966005)(356005)(81166007)(82740400003)(5660300002)(8936002)(478600001)(86362001)(70586007)(4326008)(8676002)(36860700001)(70206006)(6916009)(40460700003)(82310400005)(26005)(2616005)(1076003)(41300700001)(54906003)(186003)(36756003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:10.6193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f18eb7-5525-4287-5fa0-08da5915a410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3923
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This implements KFD profiling APIs to expose HMM migration and 
recoverable page fault profiling data. The ROCm profiler will shared 
link with application, to collect and expose the profiling data to 
application developers to tune the applications based on how the address 
range attributes affect the behavior and performance. Kernel perf and 
ftrace requires superuser permission to collect data, it is not suitable 
for ROCm profiler.

The profiling data is per process per device event uses the existing SMI 
(system management interface) event API. Each event log is one line of 
text with the event specific information.

For user space usage example:
patch 9/11, 10/11 Thunk libhsakmt is based on
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface

patch 11/11 ROCr Basic-SVM-profiler patch is based on
https://github.com/RadeonOpenCompute/ROCR-Runtime

v5:
 * Fix multi-thead profiling support
 * Added user space usage example Thunk and ROCr patch

v4:
 * Add event helper function
 * Rebase to 5.16 kernel

v3:
 * Changes from Felix's review

v2:
 * Keep existing events behaviour
 * Use ktime_get_boottime_ns() as timestamp to correlate with other APIs
 * Use compact message layout, stick with existing message convention
 * Add unmap from GPU event

Philip Yang (8):
  drm/amdkfd: Add KFD SMI event IDs and triggers
  drm/amdkfd: Enable per process SMI event
  drm/amdkfd: Add GPU recoverable fault SMI event
  drm/amdkfd: Add migration SMI event
  drm/amdkfd: Add user queue eviction restore SMI event
  drm/amdkfd: Add unmap from GPU SMI event
  drm/amdkfd: Asynchronously free smi_client
  drm/amdkfd: Bump KFD API version for SMI profiling event

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  53 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 134 ++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  21 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  64 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |   2 +-
 include/uapi/linux/kfd_ioctl.h                |  40 +++++-
 13 files changed, 293 insertions(+), 65 deletions(-)

