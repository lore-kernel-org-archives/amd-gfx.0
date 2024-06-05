Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4817C25B78
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 01:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A5E10E66B;
	Wed,  5 Jun 2024 01:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDIbe4G8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80BEC10E66B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 01:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM5SPp9iu8KaRrdPTSyxV5I1HEHP6F4chmoysshQJg91/DsKcoYxX/EVqIs2reIi/oLVWsyK7NYtjVVYFFF1sgQerVxIwRLtmdWXOFsVZT+Ns0uTPD3KMdQ4AiZrVZydOcz0kjwZARZmgTmkPLHG6CvoiejsuLCdOtVJxkIiLOSpGfSqDdoygDa0RhQVPHcEoQByZBoe2UDepO6IARRc17R6rNLDP6aTOsm7O/nPkHBd8/cqE+hOiQMHev5ShvXeZQ83TWm89LMirESGAFYZ3tQpPPINwHRvzeyLinHZXxek+F1bwJ6hOUcZTcYcRJ/+kxbRLE/x1W9V0dRuWw3WuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=634kHyhT9mnOtHboM53X0ZD4Jpv9076KEFmToFL8//U=;
 b=Q3OnYQ80C2O6IbgtYH/1fCK56Mrn29BwLEhAuDv2PazfN6bJIuUJGzV44aJZd+Phnwvsxk0/bVvzwFZQAoGuwT20H+e7GQ8AKGDyJJX/lCE0UiKgn1q8sYr6o9Xs6VtDHfwR/12la8/yTfSa8B7d5Yxzbbr2aeD1xXBuIap/h7tUs+CKCfKy9SWp0IaAgecyqHBQP8kaaZeRWSodq3+jktjRGCluYkltcLbjeBLfIHkj4o+gQeZ1ZXavYKoT48Xl5MonwrPsO/pDqsvyuNDXxNURygx9GrTcsmZ9jvgV5AnaOK01eJ5IzJ3waqMV9Be2F5HRph9GuE5X4iTwfelIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=634kHyhT9mnOtHboM53X0ZD4Jpv9076KEFmToFL8//U=;
 b=kDIbe4G8M3HnJf2CuYehMw5KKsOZqlZb+tdAt7Kjl4himgi6fz2r18iXwPubvT4pmionjL6sfLNwL4Uoq5NYToV9ppIg0xo55vqr8WnxBGCx4uC9eHNYuwdgZZ/AgjJ1Y1Bxocb8iddGjMXFeLcbXLXNT0d6W4ZJTbdlIq8j5Tk=
Received: from BN0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:e6::14)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Wed, 5 Jun
 2024 01:33:50 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::90) by BN0PR03CA0009.outlook.office365.com
 (2603:10b6:408:e6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Wed, 5 Jun 2024 01:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 01:33:49 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 20:33:46 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v4 0/9] drm/amdgpu: prevent concurrent GPU access during reset
Date: Tue, 4 Jun 2024 21:33:09 -0400
Message-ID: <20240605013318.11260-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9c6050-f4c7-49da-f185-08dc84ff8cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGhja0l5OGo0V0R3UUdJM2k0T0FZejQ3Z1lMcXYxMmFRVlVEYmpMMW1jMWI5?=
 =?utf-8?B?RlM1K3BVVzhzYUtTR3piU2tUUDA4alE4QnNyK1ZxZWpIbkZ3MGhUYmRET0Y4?=
 =?utf-8?B?b0Y5Rk9GellMUGljU3BQZ0pOSGRuYmFLSDQvelRtYTVnODVrTnFSd1YzaHln?=
 =?utf-8?B?MjB6WWEwbDZ2NTJuaS9xeG5PT2FqZjRGeHVtOVMweTFKbDRnYVF4azVkdWxv?=
 =?utf-8?B?V3BJZlVjQTIvTXlpRitPMFNGL2EvdjV3NytZM1VoK05yb29Kbmt5T2syWUZy?=
 =?utf-8?B?MVRoQ0lFY285NVBVdy9EZnZEUzc4cmtwMlhmWEI2bU9CSm9GL0NOMnBBK0xm?=
 =?utf-8?B?bG5md0NISElQMk5xODFLRW1ENVl1Z1RsUDNKL3Z5ZFZrMnZmbjNPZ3ErVERo?=
 =?utf-8?B?VUV1NnVaQmtUQ0d3Mjl3b3dIMGU3K2hFenlTQTRsS3l1TkxXZWVyc0xGWCtt?=
 =?utf-8?B?SG5YNG9UNEFNWTI3Q0FxVms2RmhLYjFORmRNME9CVFV4bFBCWEVyUy9QZFhy?=
 =?utf-8?B?V2svOWh1cHZLZHJEZFczcU9xN2FoSW9YNjRQZFl2aXJmUU1yRWE4NmFMZE4x?=
 =?utf-8?B?YkdLdHh3aWhZcWIvSlFLcTZkVHhBUnBybkc3SnZ6RmFVbFVna052NmFGQXF6?=
 =?utf-8?B?TVJ1UkZPdE1YNVF1MmFMamhGRm9ZK2ZycVA4TGFmVk9zR1dFVjh0QjdIK3BZ?=
 =?utf-8?B?NHRsTHk3SGpNT096VCtGQU1aN1c2b3JyVTJjUHNaZjY2MEtla1YydzFaQ05J?=
 =?utf-8?B?bmxRL0lmWmpIS0xkWjhFWjFoc2RJbzNlWkZObE1Ta2hMRENjK1FJNXVkUlRk?=
 =?utf-8?B?dDZXbE9ZRWNTY0c2UjlTYVE1Vk9JSHh2UVJibS9zektTcHpiYzNzM0JadG8v?=
 =?utf-8?B?ZVVrVzJTYkVZRWFVK0dzNTg2WVhjQ0VEak55S1VkbEl4T1VMNVZrSHdjcGFL?=
 =?utf-8?B?MTBQUUJDcVhIZitRUU9zYktTZ0Q2bHpRcW03TVl4L203V2wzZlBwVXZxdGh0?=
 =?utf-8?B?Q040Yi9pQlh5d254b0llMTVPWTk3dFg3bzdYNUtrNzgvWEd4ZFlIbjNlcTdn?=
 =?utf-8?B?MEE0WE5FYks3cUNKekd4MUZpdjIyektEd1Q5d3c3aUFyUm9BdjZzbHVxSE8x?=
 =?utf-8?B?SVJEWjZLV0dnamExWnprTFpKUmZ0aXZFZEEzem5BanF3VnlwenBmcFBxaXVQ?=
 =?utf-8?B?UFhIK1lESUJVRVRVV0lPN3g4U0JSTGIzdXkvSWNpUXNTaEdsamhZbE9jWm5C?=
 =?utf-8?B?STBvQnUvQmxjUjF6WS9LMFZHTW5JQnZTbVJ6QWFyMEtuK1MrRWhWUUdhR2x0?=
 =?utf-8?B?eXc4bWhXSEltdk9NSDcvTkVQQjBxTUlaaUZPVEtFeW1IVHBnb0d1NFc3K2U3?=
 =?utf-8?B?dDdpTDJkYVloSXJmd0t0TldRN1hLUHhROGtIVElHV0dNOGtQeVpVa0NDSHJ2?=
 =?utf-8?B?ZTJLRkFhSnNhbDdlcG5DNmMyeHhwU1RoaU44N1dLai8zVGtoVGJjcFdjZFJ3?=
 =?utf-8?B?cHdOQS9lWERvZXh1WHl6c0VQSkFYVEhYVUtJRUoyclVpWitiZytMZUlQMkVk?=
 =?utf-8?B?djV3NkJ1YjJzSkpjcTJOdGhIbUFnajRMK0VjYUhyR3R1NmdBckxpMlljdHdC?=
 =?utf-8?B?eDQ3R1c4OVdxbUVPeVNyWGlXQnVabUU3NnE0R1kyOTdyQ0tjdmJ2dlNINGI5?=
 =?utf-8?B?amJGdWxZK1FLQUFUM0xsWU1IZ0V5ZUVKMzBPU0ZJdEt1emF1NHZxTlVIUHpS?=
 =?utf-8?B?OW1ORFpKR3FyQlBITVdLQktWTmpsVXJlOUpNUkRiZngrV1E3N09oR2JkWW1G?=
 =?utf-8?B?cGE4eWtJYnppSDVpbDhzMnl5VStoYVdrc1JUU1Z6QXVYQ2ZLMjVWdGRXWlYy?=
 =?utf-8?B?U2NiVjh3N2wvYXZzQStmMmtWejQxa09tVXV2VWxsNnhscmc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:33:49.5048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9c6050-f4c7-49da-f185-08dc84ff8cef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

If another thread accesses the gpu while the GPU is being reset, the
reset could fail. This is especially problematic on SRIOV since host
may reset the GPU even if guest is not yet ready.

There are code in place that tries to prevent stray access, but over
time bugs have crept in making it not reliable. This series hopes to
address these bugs.

v4: From testing, it seem that removing the flush from gart enable
    sometimes causes the gart to not be flushed at all. So dropping
      drm/amd/amdgpu: remove unnecessary flush when enable gart
    and replace with this patch instead
      drm/amdgpu: call flush_gpu_tlb directly in gfxhub enable

    Splitting 
      drm/amdgpu: fix missing reset domain locks
    into multiple commits
      drm/amdgpu: add lock in amdgpu_gart_invalidate_tlb
      drm/amdgpu: add lock in kfd_process_dequeue_from_device

v3: dropped:
      drm/amdgpu: abort fence poll if reset is started
      Revert "drm/amdgpu: Queue KFD reset workitem in VF FED"
    updated:
      drm/amdgpu: fix sriov host flr handler
      drm/amdgpu: fix missing reset domain locks
     
Yunxiang Li (9):
  drm/amdgpu: add skip_hw_access checks for sriov
  drm/amdgpu: fix sriov host flr handler
  drm/amdgpu/kfd: remove is_hws_hang and is_resetting
  drm/amdgpu: remove tlb flush in amdgpu_gtt_mgr_recover
  drm/amdgpu: use helper in amdgpu_gart_unbind
  drm/amdgpu: call flush_gpu_tlb directly in gfxhub enable
  drm/amdgpu: fix locking scope when flushing tlb
  drm/amdgpu: add lock in amdgpu_gart_invalidate_tlb
  drm/amdgpu: add lock in kfd_process_dequeue_from_device

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 11 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 70 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 23 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         | 39 ++++-----
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         | 39 ++++-----
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |  6 --
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++++-----------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 11 ++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 13 ++-
 18 files changed, 154 insertions(+), 157 deletions(-)

-- 
2.34.1

