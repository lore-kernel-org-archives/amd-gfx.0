Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438A7C61DE1
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Aug 2026 15:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A546E10E212;
	Sun, 30 Aug 2026 15:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GfAaLtTX";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDC010E212
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Aug 2026 15:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPg4nGTCPjvVj64J/z3f/7EI05WZKgJp1QHrXZXntxZXyP8wOl1vYZ7w4HmU1WnpVvgaviNpUDGpD5rlvPZmvhoeZn8ZuaUIlLqnouXtO1fyJDJPU6n4511nspigX++UpEdV/CLrOSFeoe3xQfI2QPeOgc+apuhpekJTjSt17jzv/jYVMPNLJYQBpOEkacwoBJL3cxcp+E64A4nXWaLjhRQpD6sLT8zyTHJfzu4vC+w2xrNoKd8JwrFQduHnEsAkIGo4baoeFo/vtI74s/bt0vedlU9PqWPaegkIoZDMz7ugc0ag/68kwTDrM0dMPt8s5dRSw7Wef/XNYbD+R2ve2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYkHneRPlX5f3vxnlvXHC3u35ums2DX0Au5WyNlu1kA=;
 b=U4pkyRhkm7ab2Y2V3hKtY0MCgxgqnkQp4rJZMlW0Rqlxu5PnplHLhCNuxX0vgxfVdXv/p7akjCZANUuvcJsdif20pCQS2yID3Clak6VBKef5zaIMMveX2OqVoPL3XkXh4R2RQIfGVG5KmSsx7g/LdsNkb2okygAeYjUJFhiUXPC/jyGHVDU9MfNcdP3ulwuxTru/XoOWSLKApHwxd9lH+agra9jDWgKhZ9/hv97V7Id/iAwEryYJeGO7E/JY7nI2H89H3nXGgPW49CCF5uMjWMlV8XORfYwfoD8WML2Vcpx4z5YYCNeYHV5P0yXXsCULHhp9+WZRQpAncVALLWBy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYkHneRPlX5f3vxnlvXHC3u35ums2DX0Au5WyNlu1kA=;
 b=GfAaLtTXepob+YrK7/pMo4WcLW/e4Q1ukaXoD5t22/8PThHOZUjj1ogQNo4xyfibyqDDupmuhzpcbJ7qVyPdaIK398LVwGN1grY0axgDrodNVmDpfhDeD4kUK7/sPWUceGfxE4OIYM+RiZxiAw6K7bVtbhvtAvxxrBFB9w0WWAQ=
Received: from DS7PR03CA0143.namprd03.prod.outlook.com (2603:10b6:5:3b4::28)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:40:46 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::16) by DS7PR03CA0143.outlook.office365.com
 (2603:10b6:5:3b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 15:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 15:40:46 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 10:40:43 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <timur.kristof@gmail.com>, <natalie.vock@gmx.de>
CC: <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [RFC PATCH 0/3] drm/amdgpu: unify SVM notifier and VM eviction locking
Date: Sun, 30 Aug 2026 23:40:24 +0800
Message-ID: <cover.1788103444.git.honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 92da4c99-1efa-4e09-9b20-08df06ad0f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|921020|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: KfsK2tNV/4l2T+Hp+HZbtrbFPd/bs/0RWGFPx082BOfyrOn+c4XfQqWtZD7wy4KIhqdK4g9KDaLI3CKVLYyngSoquL6hP48nbE2KDQl1ra3BWkHk4fr9V7o7SbCEjfc8PiLl2NdUizVBinfQOQ1gowShARwxERLJk95pEnxgJHAzfyOBDluJc6ZazrVnvpkGWRX+/7GEyHsDPRb+nQKfw9eqejlTpGSSveU6hr3fHTlAPux43xI9R69Va8h7fLnt9/1g2zlL6S1HNCJP5F6yjJ9vnICx+gPTx2pG7wZG/t9JoB76kFK2UJvrNukr5Myp2w/uAVUU+mRLecU1C5I9Nb00RaBAWSxfzlU9E20sHKp5GYWXfP/g+ZkmQwTRih0bThXAEd7wSKeCV7a4Trr+wuKXWNwjQTE/G1LZoD999kCA47LAwcMtTY+NESGohYfbc1ghjSFrsZvtOLDwX9m2tnbskNMMI4mTY4dTW9b9QzZIhnZoSDGJv5eN4oDHKvLA5vZKiTFN7SkA7e04sgqjvjBC76N/c6Dfnv2GeKMBBUCcY8OXLwWBaqQTfmpjx3bamEZsgL16FHkMylQVrkQaEJtZsfT0FFo9QnbYdwKlr/rYe2sz1hfFVd72gNqu/DE1vpG9zymCRE4Vq48AzAHPs2HRpvb+zUjVtch2E/p1uYtdjwQ0WCt18MWrgglOjGI65Aj2KRwW+P0MrTuwiuORW7iY2BvhasQ5Ygjyzfgtkg9Rjx18rV1Tavrh8WM0u3HP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(921020)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tsaBExg5TwLFezkn2LKIN55rkadv4qLBLu559V9tNbr4KCICLcT/duHCjp2G7PP5HI/MbU/IAeqH2R9EIaE8P4Qe1Sz4BmYAhIt7zlxyXbUjQvJugFEGfz3q6qw9/xrLWrVmBmT9011ReFibmLXZ59zfmpKDVZJ4pkX/0EuOcd4y9Ua33WItSO6gGlsLFu1+lVw0lGVQnSOqITPaoiswHCjgoq1FEOIw4xAPVoWmFWqsW9XRccSjJnXo5IOgxPcQ+YBb5qAEaaXUOUN+7cCY/OZV0hs5nheL2N85O5IK+45Xm/t1d84g7GXRuTtEhHEbKqTMXS9ImQfZ3V9U+QzcCZsRFpLiisnFTLN75i6ZQ4544LAmQI+8iWbcwH2aF1825HSz8P61F9M/pCbRQZVSzbIJbso7WSLJfXEan6h7JdGQDJUG/GrpIxRd3LgV5l1F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:40:46.6917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92da4c99-1efa-4e09-9b20-08df06ad0f68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
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

From: Honglei Huang <honghuan@amd.com>

This series follows Christian's suggestions and builds on his earlier
fix work in the amdgpu VM critical section.
My understanding of all amdgpu VM locking details may be incomplete, so
review and confirmation from the VM maintainers would be appreciated.

It is described that the ordering problem and why both paths need the
same lock:

  "Originally the notifier_lock only made sure that the CPU page table
   updates were done in order and originally the eviction lock made sure
   that the GPU page table updates were done in order, but essentially we
   need the order for both.

   The point is that the updates need to be serialized. In other words
   when one CPU is doing a mapping operation and another CPU is doing an
   unmap through an MMU notifier we somehow need to make sure that the
   corresponding GPU page table updates execute in the correct order."

Before this series, the update flow uses two locks:

  map thread:
    notifier_lock (lock A)
      validate range
        pt_alloc drops only eviction_lock (lock B)
          allocation enters direct reclaim
            MMU notifier tries notifier_lock (lock A again)
              deadlock here

The allocation cannot finish because reclaim waits for a read lock that
the same thread releases only after the allocation returns.
The VM helper also cannot drop and revalidate the notifier lock because
it only knows about the separate eviction lock.

After this series, all three paths use the same rwsem:

  map thread:
    unified notifier/eviction lock for read (lock A)
      validate range
        pt_alloc drops lock A
          allocation can enter reclaim
            MMU notifier can take lock A for write and finish
        reacquire lock A for read
          revalidate range
            range valid -> update PTEs and PDEs -> publish the mapping
            range changed -> return -EAGAIN and retry

  MMU notifier / eviction:
    unified notifier/eviction lock for write (lock A)
      clear PTEs or evict page tables

The allocation no longer holds lock A during reclaim. If an MMU
notifier invalidates the range while lock A is dropped, the map thread
detects the changed range after reacquiring lock A and retries instead
of installing stale PTEs.

The three patches make the VM eviction lock read/write, support a
caller held lock with post allocation range revalidation, and use the
drm_gpusvm notifier lock for SVM VMs. Non SVM callers pass NULL and keep
the existing internal locking path.

The patches apply after the AMDGPU SVM build and VM fault-path
integration patch.

Testing:
    MI60: KFD svm test passed, 2 known attribute failures (attribute get refactor).
    HIP catch_tests: 98% passed.

Honglei Huang (3):
  drm/amdgpu: make VM eviction lock read/write to match notifier lock
  drm/amdgpu: recheck range validity after page table allocation
  drm/amdgpu: use drm_gpusvm notifier lock for VM eviction

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 37 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 52 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 84 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 15 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 30 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 29 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  7 +-
 11 files changed, 176 insertions(+), 86 deletions(-)

-- 
2.34.1

