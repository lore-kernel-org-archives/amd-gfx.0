Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBEFC4829B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5E410F671;
	Tue,  6 Feb 2024 15:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lrywy4Do";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 557E610F671
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g30hf+OUUB+hObJ/Lj9SVVekoQAgdumJa1+079bU8jbK1xirhlwFdC1vXRPywAlTOr+70aC38NYF0dcLX3vQotafmiIAD7yNjzIzEAI++J2lhavlyNAxhDH8t4LwngpkyC7ttSEbL5VAomqeUNNosugWntEKVrnCiQW9AldmOoYfv2ck5eBT0N5R6jSCuKzPo35SpNFfKhoShv+zPRBTMg1JBd2wO+T5KqjY1ja1DEvLo30URLH3PaUa33Wq0PdSgaLbUDIpzzq+3lGhGJ+5def56191+jf82SogCoBCiA1+wqvfAbufWeZX4rv2MxeSb3OLkJ8D/rRICrhC/jSqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3/wI0Udl6k4LRzuq8mKerNSaGsf+xvE29/QZVocbsI=;
 b=RWPghQEmd6KgVsltDxPy5hB4NQiVV76jx1vINqPmwM8n8y8nxkVB+T63y/GSzsRwrUo2Wz0cV3jPA/f3TOvUxdZ5zwivoWt/3PF7pEcCOfVdqvCvr7SWvPNKLtOrmqyWsr7gIyOb+3vujJK8aNYJAfsYesiiUEN13NvN7S0iqAqDFaomhhlNp14kHYCDQkTwLyGGMPlbLWwAC6jwr/k9pSq3n7YkV8q0PbCMkIliGiIeoQLJqOF3efEgW3eNoczbMDJbsyxt/nWF3JJz2x3ZHjCT9I8CoHH5OZi2lq/tuQ+aowTtUTh3CIZWDj+GHX6F0zUpy7RItfb+OgXPZJbgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3/wI0Udl6k4LRzuq8mKerNSaGsf+xvE29/QZVocbsI=;
 b=Lrywy4DoKdUtSnX33IEecSbnsqizL/qcBh3OCL9AOL3kK+jR6FO/GIFkuh/TzZS4WLeB3EGCmvGQFcg1Vn7O/AfNhBO8hAxgYYgLXebsw2cSXgYkc8Q89rfHkEbIOB4dCqZkz4ojcU1lRJGxhtAht8xR6w5DpUH8Mmo/EQMp8sY=
Received: from SJ0PR03CA0227.namprd03.prod.outlook.com (2603:10b6:a03:39f::22)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 15:59:33 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::27) by SJ0PR03CA0227.outlook.office365.com
 (2603:10b6:a03:39f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:32 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:31 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 00/24] Support Host Trap Sampling for gfx941/gfx942
Date: Tue, 6 Feb 2024 10:58:56 -0500
Message-ID: <20240206155920.3171418-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: a29cfff8-c533-4ee9-e3a9-08dc272c9be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3L2eTbxiaw94Y7xygGOGYzYtjFjtIBIXnEfdo/80Y6CXhLV8XnCh8Kl1OFzGbxNd9hFDLvvvWIQijV4EfhycPEh4ibvBpR/6RFfDnQjLxst7FlvLoH4P5tMXzBvD7Gevlc3Q8JIH5olV58GLcO6POKnMEJ1eTVpq7EnY7oyThm+ZqV9Gpa57ChewtfJMKzX8tLd85b889+4bQRuAxc2ctfipG4t8PWW1eWieVztbziS1nnRi6aZOUQQ9NaSzS+wZephfSnsFYSnSM7TVCNvmCidiLLIo8zRZTYVIT/MpgeLj+gmX6Y8DRQHfR5AlqLvgIreL7YY5VpmotNDciGvSN9aha1SzCkGqaKohtLJvYKiugeISbYhUtboyYUEe7EO0b0QNMyLU8PG0bP5+CSSgFm2RRNBZmhVktdersvYtVpS/r+ejZ5IAAiZQ4b0sOutKKqFchIVGLMziIwzL6X8oRtL9Jz3d1lH6Q5GQ6C20BCRbBgDsovF0Xey+FMvz878lakSQFax5IguXK46RFaYcjZFOSAk7QkNmWBw31tjKJrRHwFECPmKPYgT6tGUdXCqWo+Q/4T7NTmGoseiehL/T3FSisGBuAyghreaIdIoPNGEF1Ouw+GdzZBMluIOknS88+j2uy8MCmklkEfmbn6pVtuu7AJJSwRjHTMR1cZzEO2S93ni+szSGNYPJeO8/tAl/eFAPRqZaHns4F9mRZzm/H47OJ17D7C1Q1e0WrXP8LO9q+sseiV5Mom2wtPYgv3BV2dt80wGC58r0NZvfokFaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(40470700004)(46966006)(36840700001)(426003)(2616005)(1076003)(336012)(16526019)(26005)(40460700003)(40480700001)(6666004)(41300700001)(36860700001)(6916009)(316002)(54906003)(47076005)(478600001)(7696005)(83380400001)(36756003)(356005)(81166007)(82740400003)(86362001)(5660300002)(2906002)(8676002)(70206006)(70586007)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:32.6293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a29cfff8-c533-4ee9-e3a9-08dc272c9be8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
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

PC sampling is a form of software profiling, where the threads of an application
are periodically interrupted and the program counter that the threads are currently
attempting to execute is saved out for profiling.

David Yat Sin (5):
  drm/amdkfd/kfd_ioctl: add pc sampling support
  drm/amdkfd: add pc sampling support
  drm/amdkfd: enable pc sampling query
  drm/amdkfd: enable pc sampling create
  drm/amdkfd: Set debug trap bit when enabling PC Sampling

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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   75 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   26 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |    3 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   14 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   11 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |    5 +
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c  |  426 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h  |   35 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   46 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   32 +-
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |    2 +
 .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |    5 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |    7 +
 include/uapi/linux/kfd_ioctl.h                |   64 +-
 21 files changed, 1914 insertions(+), 1080 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h

-- 
2.25.1

