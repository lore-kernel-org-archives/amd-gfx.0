Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5A606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mbtLMgfs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D857F10E125;
	Fri, 20 Nov 2026 03:39:25 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E63610E125
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 03:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdFPpV8sQU9MFh/IDZ7B2TsqW0oUl83ez4b7H2bS4RB0oXLtIyrR4iHQt3g2qCzXthFaaUSApAPS/Jbs/CUmku6voMRTMd2fMy/zCSWS7Tow8ZV7Lcb5L86RQyv1Ob0IZeD9oWbVFR7xlrjF2moCzNwDlinZ6eOkufeVxdWwL+B/Xq8giolstu9KqcgvSg0GcAtHFXkjI+BZQlPXDa3s2OO2TVkC9AdJ04Gy63S+KgWXOT7peTMEiZ486HekUYTsz90vWIba+ZEkYJ2bDMWq7KKm0RciSCS0/dJbgTuY0r7oST/KrAecxvW3OaH8/E2ENzfGOx64A2Odqpx0rCwS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnP3mILTfsMomV5Y+F/pedfDBUHSz+ueVm7mbniWFCU=;
 b=rV7ojXNHpq6hjDh5CYSj+YUTi2yyt9bXEhL9bG6ioTptJVNCEnY40lqAodZ+XkrpNgo6HO40dwCRk9uwFY7+eild2LPscc6QD/EdmdpCVt1IIvwx5CG7svM1cJWxyFnTWnBpeHDkyl9QMUc8FqYAVLkj03++SFUa8e9u5lJ2yHiYMw9XBlbiuKm7OURYsiMBcurxZnLU+LwRBZgOgVDUa36ooIYUSSBkqVhPHUYn02NWv3H0Vahw/aWlB1EXrZEwGyFxjn8Qi1gxiP4IZQZ7x/V80cYH4Srei6+6BbSGr5Ev6GoUE9ObYkED7sOoovGm/NzenFRwcR2bXEhQzFSirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnP3mILTfsMomV5Y+F/pedfDBUHSz+ueVm7mbniWFCU=;
 b=mbtLMgfsK/0w4jTCTOrsTUBgoZytm6HZd/k8Zhqb27JZMwl0e7NV+3Ok78Y6a1nAT500r61dr+QQlyKqORVJ7hw+/a/b9q+LxPPrJFwWBjXmYm2jHjLj/R3HbRNha8KF51embebXInW4aWeGQPhBBkJFt4Kn4IeJFp4gSmCI5hc=
Received: from CH2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:610:50::36)
 by LV9PR12MB9808.namprd12.prod.outlook.com (2603:10b6:408:2e7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 03:39:13 +0000
Received: from CH01EPF000BE94A.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::50) by CH2PR16CA0026.outlook.office365.com
 (2603:10b6:610:50::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 20 Nov 2026 03:39:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94A.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 03:39:13 +0000
Received: from ruijing-dev0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 21:39:06 -0600
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <ruijing.dong@amd.com>
Subject: [PATCH] drm/amdgpu: keep the commit padding when re-emitting
 submissions
Date: Thu, 19 Nov 2026 22:38:50 -0500
Message-ID: <20261120033850.387702-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.55.0.193.g27ea71069a
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94A:EE_|LV9PR12MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b18251-613f-4344-8985-08df46b7d85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|261009223027099003|6133799003|3023799007|11063799006|261026121527099003|261026140227099003|56012099006|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: YlhbA8tTU8MXhPOFLc/1iSlHXbCJcinXWQ7oDVhIgl1YnHJjKl37pu3qZnTwn2ztRvBItt6UmhjHOHbVBzGsKdqqI46WcX+pjYlzfhd3lUioRVB9ggu9n8Ppd5Wv0kq6joaJUiYWzTz1YCc3GIPjJk54JrnwPlQWBMcYJ1vLmHjYmQJ8jULdoUZmYh8GmvgjTx7lNAs9Lm2Fth8IEWb/r3d+PbVxugwgpLH+C5Q9OmVsR/Malz02kKNhLbpu/9itoyRPC/CPryrXfs230WFc/kiwjd+luRhTB9o0+aE/ksykuR4bsWnG8NzzqfI78c3xvIEt0HDOHni0+93XfV7h0Nt4VwQo4+My9KhSER2JGQVLrz1cP+hcKO8bvYOthtWviz5vxjmf9wkjcW+mrs8/fuRAkh/4rOzLz1YUJjGlrXvhR87/K9kNsAiyCrwIu++H3wcVF+yRLyV0gj0y6/0yNBt4fLmmn7E8JvWmsacCyJedjqcqTOWEZVhKLvg8qH4aYT9c5ut8QfcvFfcBOA0Q+AAedy8YZIni7AXHq5aFX/gOhP4iwKdWNzgoSWjEwn2yhwlZQTYNDSKaPM2p9gePSuwxNNImAF2AHdhaU1J1hZ9x/ggOBZWoURMmlY8xDgrICOTqtDhyubSvAi/zWlWFnu0IUh7UwXFaMDu0W/r+3HE9p8VBxwmCE4luLsqM3BRblXy2ME0CLAhZ0f5cORtDpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(6133799003)(3023799007)(11063799006)(261026121527099003)(261026140227099003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VZSEhNgW4nKvknlouTxilaOOeSaD/lPH6kzefANiQyGTWk/YpfIvB4DA13q7KybGuEoVeOSx9+yO8PNmbJ/08dh9ZTyCwa3+Ypy2aPwq1bOWiAEtEfTnZrX5t73pSnweBrgcHUdS3lxyLUtGmnXKHlO+4tBPk3i1qFar+L8hFfXgKt0f/LnFTxyal91qnqc/fiAZJ58c7AmU3QcnUHQr2ymVrrq79rU7n1b7AEpwGdTyUBszgJxtiSA8L2CKVoWjP3t8m3vr0ngSgvqj4oQMAYDETy8bSWTKDxWpuNmKQcFDnQZFkaroJBJqOOUpuhPHwvqYFvOCWvluAkIprbj/hpQVhC+pVSlofmiLQdDRiZPwis/ioiQYnGkwVz075vi3eikGPD/szqC7Vn8D6o5jTQ+8d0WmUUfRX+EwkwUP4FE9l1GkQPaXXW0Gc+gjGuVa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 03:39:13.2455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b18251-613f-4344-8985-08df46b7d85f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9808
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Re-emitted submissions are written back to back without the padding
amdgpu_ring_commit() added. Pad each one again, as commit did, since
some IPs like VCN require every submission to keep that alignment.

Fixes: a17ef941212b ("drm/amdgpu: rework ring reset backup and reemit v9")
Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 25 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 +
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c3f56253d3b8..faeaa65355ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -745,7 +745,8 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 		return;
 	}
 	ring->reemit = true;
-	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
+	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy +
+			  (seq - last_seq) * ring->funcs->align_mask);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
 		last_seq++;
@@ -778,6 +779,10 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 					amdgpu_ring_write(ring,
 							  ring->ring_backup[fence->backup_idx + i]);
 			}
+
+			/* A job fence ends a submission, pad it like commit did */
+			if (fence->skip_ib_dw_end_offset)
+				amdgpu_ring_pad_to_align(ring);
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 7b67e8cecca2..411c74802d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -142,6 +142,22 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 	}
 }
 
+/**
+ * amdgpu_ring_pad_to_align - pad the ring to the fetch alignment
+ * @ring: amdgpu_ring structure holding ring information
+ */
+void amdgpu_ring_pad_to_align(struct amdgpu_ring *ring)
+{
+	u32 count;
+
+	count = ring->funcs->align_mask + 1 -
+		(ring->wptr & ring->funcs->align_mask);
+	count &= ring->funcs->align_mask;
+
+	if (count != 0)
+		ring->funcs->insert_nop(ring, count);
+}
+
 /**
  * amdgpu_ring_commit - tell the GPU to execute the new
  * commands on the ring buffer
@@ -153,18 +169,11 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
  */
 void amdgpu_ring_commit(struct amdgpu_ring *ring)
 {
-	uint32_t count;
-
 	if (ring->count_dw < 0)
 		drm_err(adev_to_drm(ring->adev), "writing more dwords to the ring than expected!\n");
 
 	/* We pad to match fetch size */
-	count = ring->funcs->align_mask + 1 -
-		(ring->wptr & ring->funcs->align_mask);
-	count &= ring->funcs->align_mask;
-
-	if (count != 0)
-		ring->funcs->insert_nop(ring, count);
+	amdgpu_ring_pad_to_align(ring);
 
 	mb();
 	amdgpu_ring_set_wptr(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b2040f80b7f2..6224a9f94826 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -464,6 +464,7 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring);
 
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
+void amdgpu_ring_pad_to_align(struct amdgpu_ring *ring);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
 void amdgpu_ring_undo(struct amdgpu_ring *ring);
 int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
-- 
2.55.0.193.g27ea71069a

