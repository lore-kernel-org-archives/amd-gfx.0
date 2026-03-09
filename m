Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A75BF417E3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA24B10E510;
	Mon,  9 Mar 2026 14:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oRFNT5T5";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF7C10E510
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaRpD8Swi4WJ8HMHMtajcEpwyzvostzMklZ6W4qD95NMnGGUqU59jBLt380svdWof8RKNiLK+AnNiZ118dmhdXFRmuAjKamoP6FI0RJX02TGLrB/yx8nu/hgyAcvQNeQsybiJfuysNOnGT7I8n3wk4KrBn8+TI8gfVkYOWHahB3V1Hk+44DUKpgFJbxL4R7dj3T8X6x6eXf7BP8u6WuBY9IckKlT2mBLbmIRupjUrezJWVv7h5j0S2V0GKgHHh6mNy6AoZEEDy0h3bfouhwwsT0tfInKMgS0il1y4AsyyN6LehVBg+zZDIGz+eQhACAnupbxkT4HM8XHHleaqrST2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhuvxR7Oauw0piL7/XliC7AKJpAQBBaWE2fBRCfaZk0=;
 b=An03TYZ6ZBTWvBVEgQUUUTbTmAucYKv1I3IblK1Bmc2LihOyPyKsgpdmp72f0a/N950CAjJ+gQFJkplHV/JdXI6gNk+AntMuuYFKXg66coLMmOsAIzhoRnGY3U8FcuCRllOL5SZ1HYHfjP6iS+y6+JQbbxbKlvGkKhlKIQJeebzCXDjB5+hw6g4a8YdISUw7g12F1cUy1jDqxIpYGWp+zzWHw6qxaAKIfAMN8/BY1v6YJRlgguHU2bhaG8IDzeuz143JJMS8O8FtRcuCgWKjf0Zz01XPVicMW3O5GH+fSk0sGsEzmkLGaVURm086yCbkICKW/ghQ3J0vygfGDdKNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhuvxR7Oauw0piL7/XliC7AKJpAQBBaWE2fBRCfaZk0=;
 b=oRFNT5T5MvH78HW3czu+tG32o+mxDmV3cwngtwYiWVsHUgUPo7evfT4OsyHP347iZ3YjU+lIvZFYMoxP+63R1x2n3hax92IpAJ2mAGg0CTZXkWnDD7+rPHmY3yronyZ5+0cWXWxhsQBQujQyDzCDgRFE+r7u23YW2/0nmGTTtWQ=
Received: from SN1PR12CA0069.namprd12.prod.outlook.com (2603:10b6:802:20::40)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 14:26:42 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::9b) by SN1PR12CA0069.outlook.office365.com
 (2603:10b6:802:20::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:26:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:26:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:26:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update cp packets for gfx v12_1
Date: Mon, 9 Mar 2026 10:26:20 -0400
Message-ID: <20260309142621.2843831-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142621.2843831-1-alexander.deucher@amd.com>
References: <20260309142621.2843831-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f494ab3-9ea6-4782-037c-08de7de7e282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: Y+IiRU5i2nQoU0RnVrqpW7qGTBiabxrI6lftgkxpQ13Qq7G3kp43BWb5IgRXOlqrcQDPKwMlhCKl+4nm+iMOThC4ycFR0XNVH+XoPL0HsbzD0FzeA+pe4UhXMlyNbEzbxdLoVr9CTgeKaQtz20ma/3wXke24NWxILJ1jzobpCGXiNBZZxrFGyyAdMQpXesqhL2dB3UN0Y4TDi9/yiShppJ6k9eS/lCPwfAftPTGxKQ9CukWFMhH1hE9d5Oqi/BNYEjKlqKwVlu0k3SgW0AQPINxHCsZWflnp8Pdtx1Mfr5LvA1fJFHVmKNbHJqpkjcgQ4HfTU2y474wG3IkbwQ70tedApl4ymcEymvF8nLSxfr8LJxCBS+Golu4qWsn7HeN5tNrnGvQYwp+3Wbzec7e8glmFmYVYkVWO15bY5MEPjrdqpJ+VjymJbXvFhBT0viwdOh8TWLuyqITlLSIFcNEbgmJmOVKMFfcvDOnsH/MSlUV/pj1Uph5Ntr2CwyEnZvSQN2gT2oUq/BubUyAkbmJJetDZjOjnKa6WjgjkA9x9ns+tevh7zoqt6FQOwvrsO4KKqDWY/GFakgxD7AbcaX0iQ7zxRr8enXsJKNJCQ2ODwutzSzgxbt+x7fEUD7ZVy7SzbKuSmmigpUDOnFnbssTllZpmDU0BgBiqVK/YO2q6EA1dOcTrWP6DKGAp9VYZIgEgLsMcjYuI1m3FQToi8xuOQLK7o9eVvUUpaZ8FNLOWTi0LfbP69T00lyUbKmEey0qq3n3T4+6/a3S92UWXG8s1zQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5s9o2OuH0i1zc8ktNGUhOqpSjgC3aYNRyvYvS1haav77wOQN1tCGRdtxisonAaQfARUw6pQ3cJvraa0XQY+C2RQbkDXfaX3cnZGsvwbiSp7qG7eee19sMinJLw5cveo761HEbhqhHyPXz0tFu+AtLQYHJxPi0Q339h0BFn7awkuyD9vlLj1GFB89eFhys8RsOl6xy5T1ZQSOVGrMEBPAe47Azzkd6tmb9QZpojBih/tFbIGg6JHOvLZlWvfgE/MeTBZUDujT/7h21au9e3R5Hn7Y+b/Kzhc8HvyZf6k4w79OP8LLONN5mR5cxymhPgx2R0pekd6X11tO8COZgc24p43QKbzkr/Kdn0FZL0sEJjFCYB48lo6/pWtOEsXyz5MLX5rbf6DD65lJws3NjfWDyx2bUUrRhqUEPPAgJiyk4NQLqSVFXDnyYcc48/hFd3cH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:26:42.3611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f494ab3-9ea6-4782-037c-08de7de7e282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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

From: Likun Gao <Likun.Gao@amd.com>

Clean up some unsupport CP packets for gfx v12_1.
Update CP packets for gfx v12_1 with some new definition.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h | 223 ++++++++++-----------
 1 file changed, 101 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
index 9a5c82c8db53b..21a07530c64d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
@@ -53,16 +53,10 @@
 
 /* Packet 3 types */
 #define	PACKET3_NOP					0x10
-#define	PACKET3_SET_BASE				0x11
-#define		PACKET3_BASE_INDEX(x)                  ((x) << 0)
-#define			CE_PARTITION_BASE		3
 #define	PACKET3_CLEAR_STATE				0x12
 #define	PACKET3_INDEX_BUFFER_SIZE			0x13
 #define	PACKET3_DISPATCH_DIRECT				0x15
 #define	PACKET3_DISPATCH_INDIRECT			0x16
-#define	PACKET3_INDIRECT_BUFFER_END			0x17
-#define	PACKET3_INDIRECT_BUFFER_CNST_END		0x19
-#define	PACKET3_ATOMIC_GDS				0x1D
 #define	PACKET3_ATOMIC_MEM				0x1E
 #define	PACKET3_OCCLUSION_QUERY				0x1F
 #define	PACKET3_SET_PREDICATION				0x20
@@ -74,47 +68,42 @@
 #define	PACKET3_INDEX_BASE				0x26
 #define	PACKET3_DRAW_INDEX_2				0x27
 #define	PACKET3_CONTEXT_CONTROL				0x28
-#define	PACKET3_INDEX_TYPE				0x2A
 #define	PACKET3_DRAW_INDIRECT_MULTI			0x2C
 #define	PACKET3_DRAW_INDEX_AUTO				0x2D
 #define	PACKET3_NUM_INSTANCES				0x2F
 #define	PACKET3_DRAW_INDEX_MULTI_AUTO			0x30
-#define	PACKET3_INDIRECT_BUFFER_PRIV			0x32
-#define	PACKET3_INDIRECT_BUFFER_CNST			0x33
-#define	PACKET3_COND_INDIRECT_BUFFER_CNST		0x33
-#define	PACKET3_STRMOUT_BUFFER_UPDATE			0x34
 #define	PACKET3_DRAW_INDEX_OFFSET_2			0x35
-#define	PACKET3_DRAW_PREAMBLE				0x36
 #define	PACKET3_WRITE_DATA				0x37
-#define		WRITE_DATA_DST_SEL(x)                   ((x) << 8)
+#define		WRITE_DATA_DST_SEL(x)                   (((x) & 0xf) << 8)
 		/* 0 - register
-		 * 1 - memory (sync - via GRBM)
-		 * 2 - gl2
-		 * 3 - gds
+		 * 1 - reserved
+		 * 2 - tc_l2
+		 * 3 - reserved
 		 * 4 - reserved
-		 * 5 - memory (async - direct)
+		 * 5 - memory (same as tc_l2)
+         * 6 - memory_mapped_adc_persistent_state
 		 */
-#define		WR_ONE_ADDR                             (1 << 16)
+#define		WRITE_DATA_SCOPE(x)                     (((x) & 0x3) << 12)
+#define		WRITE_DATA_MODE(x)                      (((x) & 0x3) << 14)
+        /* 0 - local xcd
+         * 1 - remote/local aid
+         * 2 - remote xcd
+         * 3 - remote mid
+         */
+#define		WRITE_DATA_ADDR_INCR                    (1 << 16)
+#define		WRITE_DATA_MID_DIE_ID(x)                (((x) & 0x3) << 18)
 #define		WR_CONFIRM                              (1 << 20)
-#define		WRITE_DATA_CACHE_POLICY(x)              ((x) << 25)
-		/* 0 - LRU
-		 * 1 - Stream
-		 */
-#define		WRITE_DATA_ENGINE_SEL(x)                ((x) << 30)
-		/* 0 - me
-		 * 1 - pfp
-		 * 2 - ce
+#define		WRITE_DATA_XCD_DIE_ID(x)                (((x) & 0xf) << 21)
+#define		WRITE_DATA_TEMPORAL(x)                  (((x) & 0x3) << 25)
+		/* 0 - rt
+		 * 1 - nt
+         * 2 - ht
+         * 3 - lu
 		 */
+#define		WRITE_DATA_COOP_DISABLE                 (1 << 27)
 #define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
-#define	PACKET3_MEM_SEMAPHORE				0x39
-#              define PACKET3_SEM_USE_MAILBOX       (0x1 << 16)
-#              define PACKET3_SEM_SEL_SIGNAL_TYPE   (0x1 << 20) /* 0 = increment, 1 = write 1 */
-#              define PACKET3_SEM_SEL_SIGNAL	    (0x6 << 29)
-#              define PACKET3_SEM_SEL_WAIT	    (0x7 << 29)
-#define	PACKET3_DRAW_INDEX_MULTI_INST			0x3A
-#define	PACKET3_COPY_DW					0x3B
 #define	PACKET3_WAIT_REG_MEM				0x3C
-#define		WAIT_REG_MEM_FUNCTION(x)                ((x) << 0)
+#define		WAIT_REG_MEM_FUNCTION(x)                (((x) & 0x7) << 0)
 		/* 0 - always
 		 * 1 - <
 		 * 2 - <=
@@ -123,33 +112,66 @@
 		 * 5 - >=
 		 * 6 - >
 		 */
-#define		WAIT_REG_MEM_MEM_SPACE(x)               ((x) << 4)
+#define		WAIT_REG_MEM_MEM_SPACE(x)               (((x) & 0x3) << 4)
 		/* 0 - reg
 		 * 1 - mem
 		 */
-#define		WAIT_REG_MEM_OPERATION(x)               ((x) << 6)
+#define		WAIT_REG_MEM_OPERATION(x)               (((x) & 0x3) << 6)
 		/* 0 - wait_reg_mem
 		 * 1 - wr_wait_wr_reg
 		 */
-#define		WAIT_REG_MEM_ENGINE(x)                  ((x) << 8)
-		/* 0 - me
-		 * 1 - pfp
+#define		WAIT_REG_MEM_MODE(x)                    (((x) & 0x3) << 10)
+        /* 0 - local xcd
+         * 1 - remote/local aid
+         * 2 - remote xcd
+         * 3 - remote mid
+         */
+#define		WAIT_REG_MEM_MID_DIE_ID(x)              (((x) & 0x3) << 12)
+#define		WAIT_REG_MEM_XCD_DIE_ID(x)              (((x) & 0xf) << 14)
+#define		WAIT_REG_MEM_MES_INTR_PIPE(x)           (((x) & 0x3) << 22)
+#define		WAIT_REG_MEM_MES_ACTION(x)              (((x) & 0x1) << 24)
+#define		WAIT_REG_MEM_TEMPORAL(x)                (((x) & 0x3) << 25)
+		/* 0 - rt
+		 * 1 - nt
+         * 2 - ht
+         * 3 - lu
 		 */
 #define	PACKET3_INDIRECT_BUFFER				0x3F
 #define		INDIRECT_BUFFER_VALID                   (1 << 23)
-#define		INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) << 28)
-		/* 0 - LRU
-		 * 1 - Stream
-		 * 2 - Bypass
+#define		INDIRECT_BUFFER_TEMPORAL(x)             (x) << 28)
+		/* 0 - rt
+		 * 1 - nt
+		 * 2 - ht
+         * 3 - lu
 		 */
-#define		INDIRECT_BUFFER_PRE_ENB(x)		((x) << 21)
-#define		INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
 #define	PACKET3_COND_INDIRECT_BUFFER			0x3F
 #define	PACKET3_COPY_DATA				0x40
-#define	PACKET3_CP_DMA					0x41
+#define		COPY_DATA_SRC_SEL(x)                    (((x) & 0xf) << 0)
+#define		COPY_DATA_DST_SEL(x)                    (((x) & 0xf) << 8)
+#define		COPY_DATA_SRC_SCOPE(x)                  (((x) & 0x3) << 4)
+#define		COPY_DATA_DST_SCOPE(x)                  (((x) & 0x3) << 27)
+#define		COPY_DATA_MODE(x)                       (((x) & 0x3) << 6)
+        /* 0 - local xcd
+         * 1 - remote/local aid
+         * 2 - remote xcd
+         * 3 - remote mid
+         */
+#define		COPY_DATA_SRC_TEMPORAL(x)               (((x) & 0x3) << 13)
+#define		COPY_DATA_DST_TEMPORAL(x)               (((x) & 0x3) << 25)
+		/* 0 - rt
+		 * 1 - nt
+         * 2 - ht
+         * 3 - lu
+		 */
+#define		COPY_DATA_COUNT_SEL                     (1 << 16)
+#define		COPY_DATA_SRC_DST_REMOTE_MODE(x)        (((x)) & 0x1 << 16)
+        /* 0 - src remote
+         * 1 - dst remote
+         */
+#define		COPY_DATA_MID_DIE_ID(x)                 (((x) & 0x3) << 18)
+#define		COPY_DATA_XCD_DIE_ID(x)                 (((x) & 0xf) << 21)
+#define		COPY_DATA_PQ_EXE_STATUS                 (1 << 27)
 #define	PACKET3_PFP_SYNC_ME				0x42
-#define	PACKET3_SURFACE_SYNC				0x43
-#define	PACKET3_ME_INITIALIZE				0x44
 #define	PACKET3_COND_WRITE				0x45
 #define	PACKET3_EVENT_WRITE				0x46
 #define		EVENT_TYPE(x)                           ((x) << 0)
@@ -160,8 +182,6 @@
 		 * 3 - SAMPLE_STREAMOUTSTAT*
 		 * 4 - *S_PARTIAL_FLUSH
 		 */
-#define	PACKET3_EVENT_WRITE_EOP				0x47
-#define	PACKET3_EVENT_WRITE_EOS				0x48
 #define	PACKET3_RELEASE_MEM				0x49
 #define		PACKET3_RELEASE_MEM_EVENT_TYPE(x)	    ((x) << 0)
 #define		PACKET3_RELEASE_MEM_EVENT_INDEX(x)	    ((x) << 8)
@@ -180,27 +200,30 @@
 		 * 2 - temporal__release_mem__ht
 		 * 3 - temporal__release_mem__lu
 		 */
-#define		PACKET3_RELEASE_MEM_EXECUTE		(1 << 28)
+#define		PACKET3_RELEASE_MEM_PQ_EXE_STATUS		(1 << 28)
+#define		PACKET3_RELEASE_MEM_GCR_GLK_INV		    (1 << 30)
 
-#define		PACKET3_RELEASE_MEM_DATA_SEL(x)		((x) << 29)
-		/* 0 - discard
-		 * 1 - send low 32bit data
-		 * 2 - send 64bit data
-		 * 3 - send 64bit GPU counter value
-		 * 4 - send 64bit sys counter value
+#define		PACKET3_RELEASE_MEM_DST_SEL(x)		((x) << 16)
+		/* 0 - memory controller
+		 * 1 - TC/L2
+         * 2 - register
 		 */
+#define		PACKET3_RELEASE_MEM_MES_INTR_PIPE(x)    ((x) << 20)
+#define		PACKET3_RELEASE_MEM_MES_ACTION_ID(x)    ((x) << 22)
 #define		PACKET3_RELEASE_MEM_INT_SEL(x)		((x) << 24)
 		/* 0 - none
 		 * 1 - interrupt only (DATA_SEL = 0)
 		 * 2 - interrupt when data write is confirmed
 		 */
-#define		PACKET3_RELEASE_MEM_DST_SEL(x)		((x) << 16)
-		/* 0 - MC
-		 * 1 - TC/L2
+#define		PACKET3_RELEASE_MEM_ADD_DOOREBLL_OFFSET(x)		(1 << 28)
+#define		PACKET3_RELEASE_MEM_DATA_SEL(x)		((x) << 29)
+		/* 0 - discard
+		 * 1 - send low 32bit data
+		 * 2 - send 64bit data
+		 * 3 - send 64bit GPU counter value
+		 * 4 - send 64bit sys counter value
 		 */
 
-
-
 #define	PACKET3_PREAMBLE_CNTL				0x4A
 #              define PACKET3_PREAMBLE_BEGIN_CLEAR_STATE     (2 << 28)
 #              define PACKET3_PREAMBLE_END_CLEAR_STATE       (3 << 28)
@@ -218,26 +241,29 @@
 		/* 0 - ME
 		 * 1 - PFP
 		 */
-#              define PACKET3_DMA_DATA_SRC_CACHE_POLICY(x) ((x) << 13)
-		/* 0 - LRU
-		 * 1 - Stream
+#              define PACKET3_DMA_DATA_SRC_TEMPORAL(x)  ((x) << 13)
+		/* 0 - rt
+		 * 1 - nt
+         * 2 - ht
+         * 3 - lu
 		 */
-#              define PACKET3_DMA_DATA_DST_SEL(x)  ((x) << 20)
+#              define PACKET3_DMA_DATA_SRC_SCOPE(x)     ((x) << 15)
+#              define PACKET3_DMA_DATA_DST_SEL(x)       ((x) << 20)
 		/* 0 - DST_ADDR using DAS
 		 * 1 - GDS
 		 * 3 - DST_ADDR using L2
 		 */
-#              define PACKET3_DMA_DATA_DST_CACHE_POLICY(x) ((x) << 25)
+#              define PACKET3_DMA_DATA_DST_TEMPORAL(x)  ((x) << 25)
 		/* 0 - LRU
 		 * 1 - Stream
 		 */
-#              define PACKET3_DMA_DATA_SRC_SEL(x)  ((x) << 29)
+#              define PACKET3_DMA_DATA_DST_SCOPE(x)     ((x) << 27)
+#              define PACKET3_DMA_DATA_SRC_SEL(x)       ((x) << 29)
 		/* 0 - SRC_ADDR using SAS
 		 * 1 - GDS
 		 * 2 - DATA
 		 * 3 - SRC_ADDR using L2
 		 */
-#              define PACKET3_DMA_DATA_CP_SYNC     (1 << 31)
 /* COMMAND */
 #              define PACKET3_DMA_DATA_CMD_SAS     (1 << 26)
 		/* 0 - memory
@@ -247,13 +273,11 @@
 		/* 0 - memory
 		 * 1 - register
 		 */
-#              define PACKET3_DMA_DATA_CMD_SAIC    (1 << 28)
-#              define PACKET3_DMA_DATA_CMD_DAIC    (1 << 29)
-#              define PACKET3_DMA_DATA_CMD_RAW_WAIT  (1 << 30)
+#              define PACKET3_DMA_DATA_CMD_SAIC     (1 << 28)
+#              define PACKET3_DMA_DATA_CMD_DAIC     (1 << 29)
+#              define PACKET3_DMA_DATA_CMD_RAW_WAIT (1 << 30)
+#              define PACKET3_DMA_DATA_CMD_DIS_WC   (1 << 30)
 #define	PACKET3_CONTEXT_REG_RMW				0x51
-#define	PACKET3_GFX_CNTX_UPDATE				0x52
-#define	PACKET3_BLK_CNTX_UPDATE				0x53
-#define	PACKET3_INCR_UPDT_STATE				0x55
 #define	PACKET3_ACQUIRE_MEM				0x58
 /* 1.  HEADER
  * 2.  COHER_CNTL [30:0]
@@ -307,10 +331,7 @@
 		 * 2: REVERSE
 		 */
 #define 	PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
-#define	PACKET3_REWIND					0x59
-#define	PACKET3_INTERRUPT				0x5A
 #define	PACKET3_GEN_PDEPTE				0x5B
-#define	PACKET3_INDIRECT_BUFFER_PASID			0x5C
 #define	PACKET3_PRIME_UTCL2				0x5D
 #define	PACKET3_LOAD_UCONFIG_REG			0x5E
 #define	PACKET3_LOAD_SH_REG				0x5F
@@ -324,12 +345,6 @@
 #define	PACKET3_SET_CONTEXT_REG				0x69
 #define		PACKET3_SET_CONTEXT_REG_START			0x0000a000
 #define		PACKET3_SET_CONTEXT_REG_END			0x0000a400
-#define	PACKET3_SET_CONTEXT_REG_INDEX			0x6A
-#define	PACKET3_SET_VGPR_REG_DI_MULTI			0x71
-#define	PACKET3_SET_SH_REG_DI				0x72
-#define	PACKET3_SET_CONTEXT_REG_INDIRECT		0x73
-#define	PACKET3_SET_SH_REG_DI_MULTI			0x74
-#define	PACKET3_GFX_PIPE_LOCK				0x75
 #define	PACKET3_SET_SH_REG				0x76
 #define		PACKET3_SET_SH_REG_START			0x00002c00
 #define		PACKET3_SET_SH_REG_END				0x00003000
@@ -339,47 +354,19 @@
 #define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
 #define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
 #define	PACKET3_SET_UCONFIG_REG_INDEX			0x7A
-#define	PACKET3_FORWARD_HEADER				0x7C
-#define	PACKET3_SCRATCH_RAM_WRITE			0x7D
-#define	PACKET3_SCRATCH_RAM_READ			0x7E
-#define	PACKET3_LOAD_CONST_RAM				0x80
-#define	PACKET3_WRITE_CONST_RAM				0x81
-#define	PACKET3_DUMP_CONST_RAM				0x83
-#define	PACKET3_INCREMENT_CE_COUNTER			0x84
-#define	PACKET3_INCREMENT_DE_COUNTER			0x85
-#define	PACKET3_WAIT_ON_CE_COUNTER			0x86
-#define	PACKET3_WAIT_ON_DE_COUNTER_DIFF			0x88
-#define	PACKET3_SWITCH_BUFFER				0x8B
 #define	PACKET3_DISPATCH_DRAW_PREAMBLE			0x8C
-#define	PACKET3_DISPATCH_DRAW_PREAMBLE_ACE		0x8C
 #define	PACKET3_DISPATCH_DRAW				0x8D
-#define	PACKET3_DISPATCH_DRAW_ACE			0x8D
-#define	PACKET3_GET_LOD_STATS				0x8E
-#define	PACKET3_DRAW_MULTI_PREAMBLE			0x8F
-#define	PACKET3_FRAME_CONTROL				0x90
-#			define FRAME_TMZ	(1 << 0)
-#			define FRAME_CMD(x) ((x) << 28)
-			/*
-			 * x=0: tmz_begin
-			 * x=1: tmz_end
-			 */
 #define	PACKET3_INDEX_ATTRIBUTES_INDIRECT		0x91
 #define	PACKET3_WAIT_REG_MEM64				0x93
-#define	PACKET3_COND_PREEMPT				0x94
 #define	PACKET3_HDP_FLUSH				0x95
-#define	PACKET3_COPY_DATA_RB				0x96
 #define	PACKET3_INVALIDATE_TLBS				0x98
 #define PACKET3_INVALIDATE_TLBS_DST_SEL(x)     ((x) << 0)
 #define PACKET3_INVALIDATE_TLBS_ALL_HUB(x)     ((x) << 4)
 #define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) << 5)
 #define PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(x)  ((x) << 29)
 
-#define	PACKET3_AQL_PACKET				0x99
 #define	PACKET3_DMA_DATA_FILL_MULTI			0x9A
 #define	PACKET3_SET_SH_REG_INDEX			0x9B
-#define	PACKET3_DRAW_INDIRECT_COUNT_MULTI		0x9C
-#define	PACKET3_DRAW_INDEX_INDIRECT_COUNT_MULTI		0x9D
-#define	PACKET3_DUMP_CONST_RAM_OFFSET			0x9E
 #define	PACKET3_LOAD_CONTEXT_REG_INDEX			0x9F
 #define	PACKET3_SET_RESOURCES				0xA0
 /* 1. header
@@ -394,7 +381,6 @@
 #              define PACKET3_SET_RESOURCES_VMID_MASK(x)     ((x) << 0)
 #              define PACKET3_SET_RESOURCES_UNMAP_LATENTY(x) ((x) << 16)
 #              define PACKET3_SET_RESOURCES_QUEUE_TYPE(x)    ((x) << 29)
-#define PACKET3_MAP_PROCESS				0xA1
 #define PACKET3_MAP_QUEUES				0xA2
 /* 1. header
  * 2. CONTROL
@@ -411,11 +397,10 @@
 #              define PACKET3_MAP_QUEUES_PIPE(x)            ((x) << 16)
 #              define PACKET3_MAP_QUEUES_ME(x)              ((x) << 18)
 #              define PACKET3_MAP_QUEUES_QUEUE_TYPE(x)      ((x) << 21)
-#              define PACKET3_MAP_QUEUES_ALLOC_FORMAT(x)    ((x) << 24)
+#              define PACKET3_MAP_QUEUES_QUEUE_GROUP(x)     ((x) << 24)
 #              define PACKET3_MAP_QUEUES_ENGINE_SEL(x)      ((x) << 26)
 #              define PACKET3_MAP_QUEUES_NUM_QUEUES(x)      ((x) << 29)
 /* CONTROL2 */
-#              define PACKET3_MAP_QUEUES_CHECK_DISABLE(x)   ((x) << 1)
 #              define PACKET3_MAP_QUEUES_DOORBELL_OFFSET(x) ((x) << 2)
 #define	PACKET3_UNMAP_QUEUES				0xA3
 /* 1. header
@@ -464,12 +449,6 @@
 #              define PACKET3_QUERY_STATUS_PASID(x)            ((x) << 0)
 /* CONTROL2b */
 #              define PACKET3_QUERY_STATUS_DOORBELL_OFFSET(x)  ((x) << 2)
-#              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
-#define	PACKET3_RUN_LIST				0xA5
-#define	PACKET3_MAP_PROCESS_VM				0xA6
-/* GFX11 */
-#define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
-#              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
-#              define PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM    (1 << 0)
+#              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 28)
 
 #endif
-- 
2.53.0

