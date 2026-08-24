Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B70AC5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 04:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F4B10E112;
	Tue, 25 Aug 2026 04:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AIMlce9s";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBCC10E112
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 04:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXhAWr+gRg3GWPUKSyrVrtAdaiSyZ39tlb+/Fxts+dNPIA29e8QeH1H+G2KhYoVboP6bNEvvlxN/6sgIs0Uampn+PppLtHPWdihRcS0ivb4V9+0SyuqG+cApHGBcE6F28FYzNZI6YKt4eVosKPgJv1ufNas6pY3fzw/AXVWB4koYxA2zkPg+nACPKtNgaW8CdzRCdZhLeqove6CuiSX4zBUIoCUwUiKEVhdHZP9iQFVXwBkg531HMKezwqlGTwl4rPp7CTc+EEQy6CSkqIigavcYLknHLpfYzGXWjZbxcr0tpx3qmwscK9zc7KwcZdED0/OQqO6azpiEX1fF8MVEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQjaXqVrJRVFhN8pJ0Da4Qjjx+sPhOs4LZHvkql8iIc=;
 b=xiXqrYVQKwJQz6AcPOa1Uq0jiXzv05FP10B6tWqMkbYScsL9UOOYXus5vKFYN5+cIAsDFTUEAxdTESsItATXuexEav3JqXmcnIqeRgQyfTTarYe03yPfqJbKM5KDLTMGQvereZ42aF6K6MdSrnA7Ap+MGG0rfnx7ydiTQ75hui0UZTDJbC2hYXK+lCXvfrGVLgGcazO+PuEv2Ep/vD4MS8T/gl47KpgraB3s/LiLdqoY4ATWmR/w0UKGnEWB3LmcLDCyDiGUkoTivX6B9ZhycyXAvZBYO0mS/IMTti3QdnOHITZn2kT4cJrt25onDvBe8UwcfiUQaUIsvOR3ylYg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQjaXqVrJRVFhN8pJ0Da4Qjjx+sPhOs4LZHvkql8iIc=;
 b=AIMlce9szvaHy+SZqHAotxLl88E0DZsBjEK62QL7A/8yiNtoBeHySap5C7vk+jb5G1Vv2rtYyrKdYDyajMcq9m3PyNrfpsji+ye9rYZJI6bwmOxTKVxUn3GbuIz/oZOegvdpCf5gpaPJmJSdMTNC4NMLLaIdCZmMtow8umN3U5w=
Received: from BL1PR13CA0073.namprd13.prod.outlook.com (2603:10b6:208:2b8::18)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:23:03 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::72) by BL1PR13CA0073.outlook.office365.com
 (2603:10b6:208:2b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 04:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 04:23:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 18:30:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 18:30:48 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 18:30:47 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH 0/5] drm/amdgpu: fix userq crash and lockdep violations during
 GPU reset
Date: Mon, 24 Aug 2026 19:30:00 -0400
Message-ID: <20260824233040.125300-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bae05dd-22f7-4164-1222-08df02608dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: fD9hFMqe5O2L1Dv3uLuVXbcmfRtWdp1ahFdwyUw472JXOpoMQlEWbfz8ukNAMHYQNCOBB7IQfRQ8PnMYO9Q8H+lSdK4raYaEmSXwZVeB9j+HduYwNnVPjkG5AhtMs2o1fqh1kZHZorLssf8PteckmTaOKeXX+Y1DPfHQXKog68g2CMlEB5ZLgejXai99NSkjdMJhmu2BTiUBW9kYv5KhOzmBqihFGCuohsp8t5YM8MdtFF90DsC1KmEfXLsc+DseqT8uVZHMKjI/itdjWuuy4oTG2QM0PByD0rOak2bqYyP4J07gukzJLf+mw4aly4sruz2I+C+tTOQ2v9l54lvYIEj9BJGxQSU1bruPIfrLLEkv0+DQHZqaY1Wx1VMi0nJSCVguQEdC6PnfSfKlbsT4I3j8laU9jeN5g5u+Zwit0R7CXyuE3qd+Nk1phxGBgHiUdOF9Ukz2OT7xTEtH/9a1os4n/cf5fOyioKH6eXwth7wjwSL3Hb+WrASZOWhc61dpX/E8q6d+WZuK8hn9/BX5p2iYZycHo9U3lyLl7oydP6FUfsvOjZqHNtvkb5sV9idDJQJ5nRTg1QbpEW2v+nhwtgLGqqGW79685OlICMTjW4kH13ur9c5a4hYTN9Wj+Z9NfjJv+rIQO+dfKsIFO4qktypS5CZW3kADWL0jXvTLujIZubBfEirLBgGrXAFQ+Fcb5o7x4yv0CpI/WV7GLVeyNw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u5LnjR4ec/TdgCzahqVu61VquJw0HmABrLxpHTsBoHF6pQLjaea+vES28O7itvt3wwyNWE7dJK/v2AD9DeuzT/BZDqEJpLR0eWy8rs1wwyVEkPznwCkFzO6MZDoE7gpqvqUh651HX4jXwGZRRkHbvGhKswLmAwVbuNnF0qLjBwNjbop+moM1bBTMG+SmcjkCYx0c42o4N4eZuQ3yyky+89GOyBIkQK4E3fhotmlcdNqNvDbl3uCM6vNYa9dI3O+nrgJ3vujpNSV7HB0OrPgCSQmX4frr3AfiaEK/nJmjSp9a1W++g4w2x9cYNz2H2l8QxWUh5pk8onVBZCMz14DQfyvZ1W7oQSRdRgkuZCxRdguCaKCxJisd+ECwOPegR0L3D5BorKEiJEvIs5hxlZMT6xY3Syn0rFxFlDaJ32IirJK3pc9fji82MLyncbyMEHZG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 04:23:02.7374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bae05dd-22f7-4164-1222-08df02608dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

This series fixes two bugs exposed by running the amd_basic IGT test with
AMDGPU_ENABLE_USERQTEST=1 on a GFX12 GPU with CONFIG_LOCKDEP=y enabled.

Bug 1: kernel BUG at drivers/dma-buf/dma-resv.c:319
-----------------------------------------------------
amdgpu_evf_mgr_attach_fence() calls ttm_bo_validate() then
dma_resv_add_fence() without reserving a fence slot first.
ttm_bo_validate() consumes the pre-allocated slots for its own fences,
leaving none for the eviction fence:

  kernel BUG at drivers/dma-buf/dma-resv.c:319!
  BUG_ON(fobj->num_fences >= fobj->max_fences)
  RIP: dma_resv_add_fence+0x294/0x2b0
  Workqueue: events amdgpu_userq_restore_worker

Patch 1 adds the missing dma_resv_reserve_fences(resv, 1) call.

Bug 2: four lockdep violations during GPU reset (CONFIG_LOCKDEP=y)
-------------------------------------------------------------------
With lockdep enabled a MES timeout during cs-compute-fwm-UMQ triggers
a GPU reset, exposing four lock ordering violations. All involve
reset_domain->sem being held while other locks that must come before it
in the established ordering are acquired.

The violations (each addressed by one patch):

1. halt_activities() -> drm_client_dev_suspend() takes clientlist_mutex
   while reset_domain->sem is already held. Fixed in patch 3 by moving
   the reset lock acquisition to after halt_activities().

2. psp_resume() takes firmware.mutex while reset_domain->sem is held.
   Fixed in patch 4 by skipping firmware.mutex in reset context, since
   down_write(reset_domain->sem) already provides exclusive protection.

3. amdgpu_device_reinit_after_reset() calls drm_client_dev_resume()
   which takes clientlist_mutex while reset_domain->sem is held. Fixed
   in patch 5 by moving the call to after recovery_put_reset_lock().

4. amdgpu_userq_destroy() calls cancel_delayed_work_sync() inside
   userq_mutex; the work itself takes userq_mutex. Fixed in patch 2 by
   moving the cancel before mutex_lock().

After all 5 patches the amd_basic UMQ subtests pass with no lockdep
warnings on a CONFIG_LOCKDEP=y / CONFIG_PROVE_LOCKING=y kernel.

Tested-on: GFX12 (Radeon RX 9070 XT / device 0x7550)
           IGT amd_basic with AMDGPU_ENABLE_USERQTEST=1
           Kernel: 7.1.0+, CONFIG_LOCKDEP=y, CONFIG_PROVE_LOCKING=y

Vitaly Prosyak (5):
  drm/amdgpu: reserve dma_resv slot before adding eviction fence
  drm/amdgpu: cancel hang_detect_work before taking userq_mutex
  drm/amdgpu: take reset lock after halt_activities
  drm/amdgpu/psp: skip firmware.mutex in psp_resume during GPU reset
  drm/amdgpu: move drm_client_dev_resume outside reset_domain->sem

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  9 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 10 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  4 +++-
 4 files changed, 17 insertions(+), 8 deletions(-)

Vitaly Prosyak (5):
  drm/amdgpu: reserve dma_resv slot before adding eviction fence
  drm/amdgpu: cancel hang_detect_work before taking userq_mutex
  drm/amdgpu: take reset lock after halt_activities
  drm/amdgpu/psp: skip firmware.mutex in psp_resume during GPU reset
  drm/amdgpu: move drm_client_dev_resume outside reset_domain->sem

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 21 ++++++++++++++-----
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 13 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  5 ++++-
 4 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.54.0

