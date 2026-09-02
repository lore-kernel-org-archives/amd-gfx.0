Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B89FC61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 15:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7E010F265;
	Wed,  2 Sep 2026 15:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UnzhoRyW";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E438210F265
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 15:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVvnoOI8RungOkebygTx/giskxnXj024MrnyZSXphOzCXr9UMDP3w6NId8YzutUisYL3YM19zAIfST60jS86r5ly5PzW32R5whOYmP4JFrEV5nmqD82Vt7RsRapBpn8NWxUkimA+bNHfHtTzW84ZdXAy0tKMQQd2bMkx10yMkf5zb6osohzt3UeuVjrTaOVv7ng2V/QJtQeUvjlQYRve52Zihh6uGP/APa4U+ZLuJ/sOOdY5TV2n3umPl+huRfqWnyKXBWDPmuGl/hPwSfrn23EXWOltzUt46clAUSSQsyHFX5ymJCnsaF2R3Z9OPDtoI0ftTZ0Hv9Qbp7skgLKYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNmnEdc8aSjttCxldRgFCFvIxmtWMiF3sqxcaGRCbhM=;
 b=E/imVjBWPn3D7TIcwFx6b3mYA+FU/t38Tqkvrkp7hhQknpUqduyV/TRS6zHZYtRYNNmKxnYP1ZtDaBsv357qlbdMNSckAl5e2MCbIz21sfsE47JOMRroI7sYJ0qcI9PaZfkwPsN0QeUdRQNFLnwUNhER1Ho1vPps9b2uoRzOBVkFTAJsc/qdwy8SfXugexX9/1q+mrOmXL9NcwIXPIPTpUp7Dd4JsZCxtkjMAnwYE8cIlzBSJDyaPwnqAeP1F5FzXG54/fvnYsQ8tbfQXcjZVYBSUfgc1/O3oHOQyIyMGmxUYN7N9jce1UMYRHQPu+zY2pLbGH+LfP9eZozUY0pMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNmnEdc8aSjttCxldRgFCFvIxmtWMiF3sqxcaGRCbhM=;
 b=UnzhoRyWkukqmv9t6RIrNKnbmqkT1kvk63rC47bFOV3PqvGvq8XT3b7y1NN6FOZ+2wdGcl2iZ2UdxBBHxj/FZmDY2L1SijT7zLSMkNSQzXqKu1fAgvhj2Ar15snilyMTwd8BeYkUQ74DKWr0G90I/lbRrfe47tybuXYeKhxuoiY=
Received: from SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::13)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:07:13 +0000
Received: from SJ1PEPF000037BB.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1d) by SJ0P220CA0029.outlook.office365.com
 (2603:10b6:a03:41b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 15:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BB.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 15:07:07 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 10:07:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 0/2] drm/amdgpu: First-level trap handler for kernel queue
 VMIDs
Date: Wed, 2 Sep 2026 20:36:54 +0530
Message-ID: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BB:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 627693b2-077e-47fc-191e-08df0903db02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|18002099003|13003099007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Yan6tWX2o0wSQPBgi2Vvc5qSFWp+iCoFPt7+/sBVDW6pCkk01fRrSbZGVDRAzguLk/j7sndEkgEDPNxvFxqkm2+9K43k65/2sbxt1fXdVfHmzQRNXugmrFPpgoAQFGpsi+L++myr1hKmtg6mTW40BnlcUKtarA1aWqs+OXvN+gmvkYrxJeU9Bj77ZFigXG9PJ8RkC85qQzPdhAY57uMQlN9H4Il9EjVHdLdacLMfa62iu+S4fFxkOUHZf5tkhsbEUM0yE7ZiH5Q1Y7QjkLi7AafTYlPscXIcf8RbE2BUsp1lrr3fxoZeTphwMetUSR07Z8u/w2+2brMOSGPjHCetTIQ0w0mN271J8Yc0ZEbGHVAK3T4UcM0LqPV9pTvMtXmJHcflAuKG7zWGYmEu+FtVD2fqWi3tCiGrQfqIymAPqRFvp+huInBYavFf1cfEkckCZ0SutI+CaTbcAPdu3xdWKsku9QjnKTBeFwzTHYur1wC5Tpe+yw4IHT6QVJ+IR6qywdLQ4yVtpIthqTI5t01jNnkWs31ey3/dkBcixfD1XFXCQPxgMaL6FjmLYULzVq4s2xu67+cdZdkFld/lzbxVniXSNJBMPb7cSwxlKp1cc85qr7FkMTxCFnUCZDNX68xaQoIEWqJSPYeo/k6pq9eDzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(18002099003)(13003099007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WRPckML5tH6VkBYU8WUWyCFSSBkpGEeCtBNSapXnx5USFZy0tUUpV3MWYKyWyjAPROibn3ht7Xrd8OBIy5c2wxBI5kOesLZlQJAAcQJXFC/wnv7FKFTyFQT54toDhApJj8hN6wexslmZTNEg+CrKfVfkffNIvoVfke6UeXSirD/hL7CMWdNiY5ZZRM+i9/oP0HjLaNH296mahQmeBPDSwywDuFDiZ3ztfNxEujbgfU9TzBSsai4UCs2/qjufkmaTWR+ANkeK3qLWROcVaFjjWJHHQLAYZ/avAGZ12K75aCGwEyIr3omoZh+8BdBkh2lXaO4GT7ubQTIRhrKvq1AqKgLY5rJ8vofz8N4xOM26h/nJd26wpLX/N4ZefmpcTOxXNBakd1VoK85kEpp7M3GXe+wnlVfnIDGfyWxy+vyvQtprkCsnvwDzTAlbfI4pqoPU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:07:07.2543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 627693b2-077e-47fc-191e-08df0903db02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
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

Background
----------
An earlier RFC [1] introduced a new ioctl (AMDGPU_VM_OP_SET_L2_TRAP)
to allow userspace to register a second-level trap handler for user
queues. During review, it was noted that RADV on Vega/Navi hardware
uses kernel queues (context-based submission), not user queues, and
therefore cannot benefit from the second-level trap handler without
first-level trap handler support for kernel queue VMIDs.

Problem
-------
On GFX11+ (MES-based hardware), MES programs SQ_SHADER_TBA/TMA for
user queue VMIDs via the ADD_QUEUE packet's trap_handler_addr field.
However, MES maps kernel queues via ADD_QUEUE with map_legacy_kq=1 but
does NOT program the trap handler for those VMIDs.

On GFX10 and earlier (HWS-based), the driver programs trap handler
registers via SRBM select when KFD queues are set up, but no equivalent
programming exists for the driver-managed kernel queue VMIDs.

Key design decisions:
  - MES owns kernel VMIDs but does not program trap handler state
  - The driver must program SQ_SHADER_TBA/TMA directly via SRBM select
    for kernel queue VMIDs
  - Trap handler is a VMID property, not a queue property
  - Only kernel queue VMIDs (1..first_kfd_vmid-1) should be programmed
    here; user queue VMIDs are handled by MES

Use Cases
---------
  - RADV graphics debugging on Vega/Navi/Steam Deck (Valve)
  - Future Navi ray tracing features requiring trap handlers on kernel
    queues
  - Consistent first-level trap handler behavior when userspace switches
    between kernel queues and user queues

Design
------
A new vmhub callback (program_kernel_trap_vmids) is added to
amdgpu_vmhub_funcs. Each gfxhub version implements this callback to
write SQ_SHADER_TBA/TMA registers for kernel queue VMIDs. A device-level
TMA BO (kq_tma_bo) is created at trap_init time as the scratch buffer
for kernel queue trap context.

The registers are programmed at two points:
  1. amdgpu_trap_init() — on first boot, after ISA and TMA BOs are ready
  2. setup_vmid_config() — on GPU resume, after GART registers are restored

GFX versions covered:
  - GFX10   (gfxhub_v2_0):    mm-prefixed registers, single XCC
  - GFX11   (gfxhub_v3_0):    reg-prefixed registers, single XCC
  - GFX11.5 (gfxhub_v11_5_0): reg-prefixed registers, single XCC
  - GFX12   (gfxhub_v12_0):   reg-prefixed registers, single XCC
  - GFX12.1 (gfxhub_v12_1):   reg-prefixed registers, multi-XCC

Open Questions
--------------
  1. XCP partitioning: gfxhub_v12_1 programs all XCC instances on each
     call. For XCP partition suspend/resume, only a subset of XCCs may
     need reprogramming. This will be addressed in a follow-up.

  2. MES firmware: ideally MES should honor trap_en regardless of queue
     type, but MES APIs are frozen. The driver-side SRBM approach in
     this series is the agreed workaround.

This series depends on [1] (second-level trap handler RFC) for the
amdgpu_trap infrastructure (isa_bo, amdgpu_trap_init, amdgpu_trap_alloc).

[1] https://patchwork.freedesktop.org/series/172489/

Srinivasan Shanmugam (2):
  drm/amdgpu: Add kernel VMID trap handler infrastructure
  drm/amdgpu: Implement kernel VMID trap handler for GFX10/11/12

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 37 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 43 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 34 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 37 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 34 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 34 ++++++++++++++++
 8 files changed, 222 insertions(+)

-- 
2.34.1

