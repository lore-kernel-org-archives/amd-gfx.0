Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676C3C46CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E3A10EA6A;
	Fri, 15 Dec 2023 16:00:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A696A10EA61
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXv1BRwVsc9xT5cdqcW0OVwAySV0q4KvCteXtR3x2WB5th3Gc7/b4wDQ7oMwJyYOxvC3Fc2jBogjaPcZYxqqP+PdAxHOB3Lm4KYKQLtvwuD9HEAohy4xMfsK0h25GEFS3bvEhw/5EisbAb/us5dWxSJ70QMVlrAB1f93fckcU3bWiWE1vGE4ar1wQn6QcLkNojXxyBerUOJAvU9pW4Cdp8f5JcbxjHzKCmKr4G+BbMlRNRt+S7/F1/BIzFv7ZoraG+FTu3aPS/wsV5uPewpkfNrZSDHjZ6PMcB7KJ5WY2mLcHHTkHoel6BKf7Hb8vmo3kf8ogR2zVBS16H3MX5iPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1/SnOmMcExHOzQzaBMqz1FRbPTaDykluQqtbbvC5aQ=;
 b=CNjD8oG+YmhS0hDJ+lksEsJBVP4XPr05Y3WC8anfIAsn8Y6iYeV+KC/uNmxvcOq+Omuf8p4wKKHlaIpzffFf/gFNoQOa3fcuy2NyW9Uh4vD5W/RxlJk5f4o8CUlu3neYLZPpz2ijICIVgUSdSlO0XGyWWCR8KJy78GO9s+nPlnyhLb95o6dsXX9XSmTkq2BJ7oqhMHl1Xm0LciDDHy2XuazmcB9UwnE7uVVy801y9DxcxaGHK+VW+0UPZxmWxqDRSUE+RMD1rhN7FUFj5epXsEPCOlr7YBndCZXgiZ6QA/hQrOovpXtPLoJQrZ+jsKSaU/8s8F5fwzJFXOr0XNKc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1/SnOmMcExHOzQzaBMqz1FRbPTaDykluQqtbbvC5aQ=;
 b=4faGmM7YDoueSbjNT77oYMXTHJ7Sd4iJyJ+7jLT/TmOdm/l2H0c8679xwX+hMQibR3cmDBnlVOPYBpWN8RNuhHQi8xhIkDjj4oinwEMQR61FnOlPBwz7oyEPMtdssDjgG8Q1UP6N4cnCcMQLLjABYVMk04yJF+wCszl+GI14B5I=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:00:43 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::f6) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:34 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 00/24] Support Host Trap Sampling for gfx941/gfx942
Date: Fri, 15 Dec 2023 10:59:27 -0500
Message-ID: <20231215155951.811884-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc6485a-8011-4b45-7575-08dbfd86fe5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJzb3sAtXYm54HsKvjh0St5vi7ZxL/SJvzn9OjMjNW2gxwKbsansgGnMRhEXcAfqIUcE3DL5vkpJQkuZlUa4cOQzNvIynZFMWkhFlXReJkm7jlPyY4kA7uJW5zI1q+kmmKtxjdw8GnQEtVcVnd+nbU74LLkz4NyunQYDtl+yXGPYOpkD2zgmGtEaT0oWd1SQpkq05eE9YxHcO2B/EQBPgh0rpe6OWcBeFCSR8kzV4Qs56kengaR2o1uGm7jIly2DdFLk3IreO73uGGvMytYDR+TDmwNhhyKViC+PhqY+NZhJfslEfFrkf4KOAxth9Pok4/Jhj7X4OHmVxYlf0B/PXavV8TNvPnFsFVc1dmb4BSrXxlYv75JTTS9rV1l7gExLXgyFHaVe5T82LImmYmK/o8jDAF7AEy1kAjMs41spM8pA8cL6OvhZEu0CHxnK1o+vo1PISFTwRhi8k+6NBqZSgEZHled7oFTzhdFsfP59eQNekZ7KoJtwQdqZ9+iWpzoXMRpcu3o7sV9ZABGCKykZbEon4pE+dS4EfTFkTOQ/hsLtpTM0tHA6ZivlEWjJHWXnfl/BptlIG15c4dQAW9pS1C33r/7bsAhrLer08t3Mdu0d/o8CdUOARYbk4YtopTeMBqo2i/VJ25mX23BjrSe5cLnpNdhy4OXetMDdiNQYirILaFIplREEX+LR5NTR3HTctXspZ2hlF6j0u9j7M1c9ShY8LW2sbmwu99qtYhp0jc6JASOcbivC3f8/diPss6QdQeRdunnHBH/9NHWGyaslww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(6916009)(54906003)(316002)(8676002)(8936002)(4326008)(1076003)(83380400001)(16526019)(336012)(426003)(47076005)(70206006)(7696005)(6666004)(478600001)(26005)(2616005)(70586007)(5660300002)(2906002)(41300700001)(36756003)(81166007)(356005)(36860700001)(82740400003)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:43.7218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc6485a-8011-4b45-7575-08dbfd86fe5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PC sampling is a form of software profiling, where the threads of an application
are periodically interrupted and the program counter that the threads are currently
attempting to execute is saved out for profiling.

David Yat Sin (5):
  drm/amdkfd/kfd_ioctl: add pc sampling support
  drm/amdkfd: add pc sampling support
  drm/amdkfd: enable pc sampling query
  drm/amdkfd: enable pc sampling create
  drm/amdkfd: set debug trap bit when enabling PC Sampling

James Zhu (19):
  drm/amdkfd: add pc sampling mutex
  drm/amdkfd: add trace_id return
  drm/amdkfd: check pcs_entry valid
  drm/amdkfd: enable pc sampling destroy
  drm/amdkfd: add interface to trigger pc sampling trap
  drm/amdkfd: trigger pc sampling trap for gfx v9
  drm/amdkfd/gfx9: enable host trap
  drm/amdgpu: use trapID 4 for host trap
  drm/amdgpu: add sq host trap status check
  drm/amdkfd: trigger pc sampling trap for arcturus
  drm/amdkfd: trigger pc sampling trap for aldebaran
  drm/amdkfd: use bit operation set debug trap
  drm/amdkfd: add setting trap pc sampling flag
  drm/amdkfd: enable pc sampling stop
  drm/amdkfd: add queue remapping
  drm/amdkfd: enable pc sampling start
  drm/amdkfd: add pc sampling thread to trigger trap
  drm/amdkfd: add pc sampling release when process release
  drm/amdkfd: bump kfd ioctl minor version for pc sampling availability

 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   11 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   14 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   73 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |    7 +
 drivers/gpu/drm/amd/amdkfd/Makefile           |    3 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 2106 +++++++++--------
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |   29 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   73 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   22 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |    3 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   14 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   11 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |    5 +
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c  |  405 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h  |   37 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   43 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   32 +-
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |    2 +
 .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |    5 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |    6 +
 include/uapi/linux/kfd_ioctl.h                |   60 +-
 21 files changed, 1881 insertions(+), 1080 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h

-- 
2.25.1

