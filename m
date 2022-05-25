Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C9AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 19:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2429C10E073;
	Wed, 25 May 2022 19:05:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D7710E073
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 19:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJyGIjA9Aa+ynnLWVXBwbkaQ49GXDEkSre2SeejWN39EOezWGD302rdzTkbngkhDoskkxHj/ZrXspSnP2bkdNG9DUsQwBfHcbnbIFgOnalbYuV0qc4ORepHoxwnTkVqW6MYvN2ep2IfH9WrUc8bRV/AmgkLh50hn1IQlW09RFrv9eeF4adre6o4KqwzCFpLuPofQTdBx/xvzuCWzAZe58TcoRRzIdutsD8piVPJO/rS39EAWK6ytIRb4Em8iMDC818+wAd3BJdIbNdmqDq52SbLGPfsCuX6r24QBGOZU9WXiiWoVoro0zfb/IuvaGmeehzU66rc/N9ZRmvH16b8IYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN14P56zllKe77Hpj4M4XXBzQ+jNqcvA4MJ6jGwkQiw=;
 b=balg2JDOz7i35H0kW8wkngEFFViCr5Ad1ykS5bxw8HWiZvtaXjAVRw2r9xdDipQkAOa0dMoA+F/K85WXvuVBzZ7ji5odrpBSp6Lh+AnwLLAW3dW0trzkpNSFcTpi+6NQavMQ+3WZueIAKe2RuHlPxT+znxWLj3FT+KxSM/fFnM+nLj2w6j0lzLlD+bpyO/NZ2tVbnKqLIPn3U7COsJ7EJIkWDCULYXbNDTHACTgZCT+y+nv5LKyfox5Qd+Kda+BtWlM8jbwa5ebkR7S0ThQB34vBR8ycS/Ve8/4V4J0mMlbqRnON26IXw1yWon2zJClnR+X+BAGl7wUuO8vKDP8Qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN14P56zllKe77Hpj4M4XXBzQ+jNqcvA4MJ6jGwkQiw=;
 b=hXM5+LH2yO6qbYM1howU3itfoZZsyW0N+RoXRHiV9WLh5ucucS9n3LVStnx517bXb7sRJhLBCVchus9RyVMUNusCcBb1+/TdzodYPHYgw4JuWmgl8eofVEjRY6/xBNvf3R1BglXrNV003Gjp1fofvgvRkzRs4D+wuPCO9GtuYEo=
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 19:05:08 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::36) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 19:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 19:05:07 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 14:05:06 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/7] Fix multiple GPU resets in XGMI hive.
Date: Wed, 25 May 2022 15:04:40 -0400
Message-ID: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9568c6f1-636f-4d67-1ad4-08da3e817c15
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17250EF0ADBCD783B935DD47EAD69@MWHPR12MB1725.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/Hj7I/2g5ofFN5OT1ZPa58gG36eS/QHFxqNnjoCgeHmybrjyG6Fx0GLlDiWxqpV1oML14dnZekQ9xN/1CEbItCqgL1yfy7HsqdH4v54VWJo4+oJqrftnJV//YyWnW9NU42DP6lhF0hjXYja8ZzVnR0VN5znYh39kUtC33uGNpmmFhooRc19+Nae1vMj6bJhUXtQH5xd+/ZK7Maro7xbNtSJZY5v1SeAMjUQsPLkwEyf9wucx/g3t5Dvgil5YvvVDYLllW3VfZ01tpjkn7QZ0CQrn1dzbgWnsZ/8ApOJkGfBP17g7CQNU2LNaOhvIgiD9E2PDZlS/58QyOI5Vl2EpaMQs/ebwEvi1B6P3uoknJi3UyhtsPNbnJrmRVq4+GJQH9j/8/sc/Rg0Ui2vkVqHQuZwSX/CLMux9ix5qGecQaE15PU7xpgrx3Qj9zJon8XZOyJ6Wr4pWdk9xfeLuaDYWq313RuEUNYcBSyjSmJE9ItH8RsMa15yemo+ZaWe0DMBYdlWAZDJxI14ziBB/NvoaGvUr4J6ZYJ7v/aZ7aIWf1J6i8ogBozVZIGcof78ip9G9vrU57Z8ojBDB5EDrI/pZV6ZDo7nPsIqXQ8SwSjTaPvFBSu44PX7m9rEAJQQ8gLSoE/iWEI67y5LvqyvVX2KAJvMSWr+icD4HRdymQC69AzYqQMugnKotLxFkinTDW7fiVXdHyZDOHFUkDcYijMQ9N8qzzFA688qo1fFFSuv5v8GZl7Pk5UGaXBrByy9nXyU7HuX0HnL7Yu3FTnmiAgemY+vzjvtTypUxE1svPdH4g0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(44832011)(6666004)(186003)(47076005)(336012)(426003)(8936002)(1076003)(16526019)(5660300002)(2906002)(36756003)(36860700001)(83380400001)(7696005)(966005)(2616005)(81166007)(82310400005)(86362001)(356005)(70586007)(70206006)(316002)(6916009)(40460700003)(26005)(54906003)(508600001)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 19:05:07.9026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9568c6f1-636f-4d67-1ad4-08da3e817c15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
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

v3: Switch back to work_struct from delayed_work (Christian)

[1] - https://lore.kernel.org/all/20220504161841.24669-1-andrey.grodzovsky@amd.com/

Andrey Grodzovsky (7):
  Revert "workqueue: remove unused cancel_work()"
  drm/amdgpu: Cache result of last reset at reset domain level.
  drm/admgpu: Serialize RAS recovery work directly into reset domain
    queue.
  drm/amdgpu: Add work_struct for GPU reset from debugfs
  drm/amdgpu: Add work_struct for GPU reset from kfd.
  drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to
    amdgpu_device_gpu_recover
  drm/amdgpu: Stop any pending reset if another in progress.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 19 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  2 +-
 include/linux/workqueue.h                  |  1 +
 kernel/workqueue.c                         |  9 ++++
 14 files changed, 84 insertions(+), 41 deletions(-)

-- 
2.25.1

