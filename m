Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5654DF36B9A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 01:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850C310E873;
	Fri, 10 Apr 2026 01:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m4RdDG0f";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9641410E873
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 01:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXHw9ZWgrhJ7oT84eurJ+z7wyeXzsJaghc1KJ7ahE5gZHuuZurj4fhgzq1dR8RDb6pZxL9DFqJQMfKfIUZMF/Ap8gy0RJW6fnCddkrbj5bSaBH51I6PWhHBHXjOqzm8LXnLuz5DpwrUB91Oq6o1/Gjy9oHoSs9bdn81O/IDZdf3SDeiggPAnoFcrMvzcGrECPfvlmI/acUZgKv7zfCdmzSVxHAbxs5o5pdL07nnA53aC7RtUv8LYvuUjosq4AF06qn285aTi1IJAIOWCditC4JIATkR1kqRv/PTufbqQqYn1Q2H07iMhm5mlxenKOaYF0tZx68VgS9QbIa4ljuhcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB0FCV/vVIORtxvdQcW8HlJYS/apQZy+c7UFAbJMiYY=;
 b=vF/vnH+rN4G7TmnzcrcbWiH2si4e9xNFsQRQi3E+IknEJRnAj/p+ZctX3SvCl7QgUKZ5CccJGNs1ClVTxqapp4Dysl2zQTM23RDZfHiJ+xw8Go/ropa/8MZ36159lpMjPZW1VyDZ5i5xDharts+zyMLctZzBpaWVWzgEADQcGLZJw/rA8jPPetyqje033RUN9m49LU/7kz5lC3TudwbCqTpLSLCOLjfb92r6puQWuq8xY9jBVaF97Nr69V1k8rnrmomyUUBaxr6ipJv7t+pZM5GGoGGjmFRC/NK0qCqVVeYqzxbtIasKKHqFqF83Ba3qS6OZtP+Z82dH331DCxZjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB0FCV/vVIORtxvdQcW8HlJYS/apQZy+c7UFAbJMiYY=;
 b=m4RdDG0fLoUtXIxePbdbFqtE17fOyjHmVE3Er3l5XMxnTYfSU6QJahpksFeI/gIznty/T35CXzPrX51+Q13zKOGzipVRko4cPL39OyCVdh3Y+P4oHzVj6Ui9XveIO1dbfOb/ind5CHbTeyP0dBB4MBnAPxx9cVNxqkLmif6yFko=
Received: from BL1PR13CA0434.namprd13.prod.outlook.com (2603:10b6:208:2c3::19)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 01:36:50 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::4f) by BL1PR13CA0434.outlook.office365.com
 (2603:10b6:208:2c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Fri,
 10 Apr 2026 01:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 01:36:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 20:36:47 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 20:36:47 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix heap buffer overflow in amdgpu_coredump
 ring dump
Date: Thu, 9 Apr 2026 21:35:51 -0400
Message-ID: <20260410013639.129917-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff4026d-0f74-41b3-4292-08de96a1a2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 76XnQVc+ftaTIEMleoTW+666YGWblrJDkpTygoIpylUFqloBcOg3W/xPPvDz+yrXvUnY4g1i1mW6rFQ8VHcFFn+ekTvZmJJKFU4gzhXQbb14qTatmnQhWslfl3wch0d7GQEIrQxTrvhbZQqULLAMCTdctsOK9VziS/jZ78kR+XpcEIjD0A+sLwqZlKG5Z0TGgUHj6CNMD52HEMUFBL+6VohxqbZNEAdfksUE1wzRCzQ7Z7nw9LFVQFzFWtYUpv62fS+Qoukfll2ENbVAuy5qi1BCY/2K/jTA93DS8ykkExZ/StT2UWg/840L54TjxBYm72Kk1cXWBuQFDjctIwxSCyTH+PCUskAtM0itQgAKArM/PhN3Wq1U0WRVTUYwZH4eqNHH+Lxi3ZG0MFn+CXqVoTwUrkwwCGmIKMV/wAtVOQkKSS7CuLhJmfB8tvJFbPsFw7jnrKO1ZKunstt2Z85mMNV8YzTDBeBOWI5qxo/jUxQ+JYtzv3RYlgQTx7Jwrxtf0M/0tLoTji7nhRK3lwm4iHpZ9KiSjkbWeowVzgAKy1qI0mjb2p518OSz3ILqr8VyFBGYgrla/nsJ0zV9Jh/nKk2MxNCRIdYGPseO8+Y6jqRu/yikQ6fiR7ht0UbzpOfDDocMTF8h0RHM5quJU4W56qtxy6PPFiUuAVPqVhCuqlJNOIkZIqe8+mXDVb67wsGk2RJTVqBRfg3nkJ++LjS75voYTKgTdx7xhOl7zlAXMUwgUuNj+FUrWzc2H8VxjA2O/YDEFUTVGCUXyvkgKHcPjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZjaA8Bo4SDCiXsireDlVVpslGrqfS7MJBY91jHW3UYSDMKhv/7qa7J7P2P9gIYzvAbPRSMs/sMBhiDFPJdPGA6fAV9tnXcHuKVFItEtZtWd8TLsNywYkqN4TdebtKZZz3KXEDEjWJCbWEr7X5wehLndPA5R9KCVb7eR2hGKhF5MwTxnsgr8bCO4+0wG+qbmwbWlQXjlIWEKBKPjQk0l3gYO/vuigkBjXERhfo9LrLSvVnuWGq83bNa16LBNaKPv9rSYDL5j7DxtBhuYI+h3spTPFDGJiO+M0QwUR1AFky++WV48m0dPHsCB+EIYIWXQZqr3eik95QKaN40savOKwuy5i1Ub5obE5PV/zhOktl0Sji26M8jabxeh8dsAXmRrdNWUUN9qZRSYBTmTKBnZ6SguaWhZEUlWiOwzH3MFmlparPJUulApNbVlhadFhog1U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 01:36:49.6057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff4026d-0f74-41b3-4292-08de96a1a2ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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

The off variable in the ring content dump loop tracks a byte offset
accumulated from ring->ring_size (which is in bytes), but it is used
as an index into u32 *rings_dw.  C pointer arithmetic on a u32 pointer
automatically multiplies the index by sizeof(u32) = 4, so the actual
byte address accessed is:

    &rings_dw[off]  ==  (char *)rings_dw + off * 4

This means off is effectively quadrupled, causing a 4x overshoot.

Concrete example -- two rings, each ring_size = 8 192 bytes (8 KB):

    total_ring_size = 16 384 bytes
    rings_dw = kzalloc(16 384)          /* 16 KB buffer */

  Ring 0: off = 0
    memcpy(&rings_dw[0], ring0->ring, 8192)
        -> writes bytes 0 .. 8 191                              OK

    off += ring->ring_size            -> off = 8 192   (BUG)

  Ring 1: off = 8 192
    memcpy(&rings_dw[8192], ring1->ring, 8192)
        -> actual byte offset = 8 192 * 4 = 32 768
        -> writes bytes 32 768 .. 40 959
        -> but buffer is only 16 384 bytes!             OVERFLOW

With the fix (off += ring->ring_size / 4):

  Ring 0: off = 0
    memcpy(&rings_dw[0], ring0->ring, 8192)             OK
    off += 8 192 / 4                  -> off = 2 048

  Ring 1: off = 2 048
    memcpy(&rings_dw[2048], ring1->ring, 8192)
        -> byte offset = 2 048 * 4 = 8 192
        -> writes bytes 8 192 .. 16 383                 OK

KASAN catches the overflow as a slab-use-after-free when the write
lands on a quarantined slab object:

  BUG: KASAN: slab-use-after-free in amdgpu_coredump+0x775/0x13c0 [amdgpu]
  Write of size 8192 at addr ffff8890b2400000 by task kworker/u128:1/329
  Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
  Call Trace:
   __asan_memcpy+0x3c/0x60
   amdgpu_coredump+0x775/0x13c0 [amdgpu]
   amdgpu_job_timedout+0xdb5/0x1420 [amdgpu]

The corrupted object was a 4 KB drm_exec buffer from a completed
amdgpu_cs_ioctl -- the ring dump memcpy overshot into this freed
slab region.

Fix by accumulating off in dword units (ring->ring_size / 4) so the
u32* indexing produces the correct byte address.  The reader in
amdgpu_devcoredump_format() already consumes the stored offset as a
dword index (rings_dw[off + j / 4]), so no change is needed there.

Fixes: 678236b37eee (" drm/amdgpu: save ring content before resetting the device\)
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 3f1cc2265645..8edec416fe2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -563,7 +563,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 			coredump->rings[idx].offset = off;
 
 			memcpy(&coredump->rings_dw[off], ring->ring, ring->ring_size);
-			off += ring->ring_size;
+			off += ring->ring_size / 4;
 			idx++;
 		}
 		coredump->num_rings = idx;
-- 
2.53.0

