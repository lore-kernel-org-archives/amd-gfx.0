Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C82CD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4C010E567;
	Fri, 22 May 2026 00:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AVJw8dMX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5BF10E55F
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JX98aMMU5BVIJqBBlc4DrQnKBERreQS3Z0JdjWyOXsYRXbEmWIppZfvhXnYHENevocdEdYFJiUD1qE6g03mUXj9zIvVXp8Gkbs5ZjA6Bj35SJV1f17pKH07QWcosiKQs/4dFKjYAYmxLoED4pbhXODlvy0JG1pCQGoPQwacw0AwAf96bfUuitfVYZz4ZhK/iBWx5aoqNbgs+z3m9aLuGpv//a4eGypjJYsqkzJpY1ooecnIYr0BMpkRBKcpXzpNFuLQvEXeTeD5ssxMf9hsJQUst9/QVnxQet13gFrkPN6eaKZqv28Ab3MaSgnF7n1ucCrftO4rFxnFvmVbZAOWKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnD0dZ0bOevBL5G9iKlPpjKdbL4NAuaodIeTHDcTqL0=;
 b=GWmrhcncBg7yJl9tiYjYAbVmqM93+fNhkbOSAWMgPSDPxJW2tzRmfOv+Wl77UEtecwFwtGI1NKywZCW5jkHMYGzn0eTMiTntRsZ1JqI2PrabfwDELokk14++ukFtE02tSHnlv6xI+guRX8RPG9NQ8A+lY8afywt3BchxWH+StvrmpzCJjWQgx/Z5oJHFb6TOYZRh3tmT2SptSnCG2u4sAUSFThX2ns64iHUtI17ZYhm1bOsr54PpmvwXurlRLL2ZXmRiNIldxQAjK6BDLWvS1fBGik7bOtdy1Vt1uWlkdw1tjxVCXJ3UrcH85/EJIq36+BgvsYyKvj1B043tbM5U8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnD0dZ0bOevBL5G9iKlPpjKdbL4NAuaodIeTHDcTqL0=;
 b=AVJw8dMXfwHM8cwVBeiuk5mqXt4ORLRJBAxGmItOaFpqoaTjn8A1uIWxCDdTwVw3Dt1v6ZKOIME2HbnXApkDUY24RKKAZSRXbIWV3ZwnXBb80VP/tQbT6CVQn+YjRn81jzgv17WZs4ceaYrK+Nb96kvfrQH7/KwFHJ8umzKleIU=
Received: from DS7PR03CA0177.namprd03.prod.outlook.com (2603:10b6:5:3b2::32)
 by CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 00:21:24 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::65) by DS7PR03CA0177.outlook.office365.com
 (2603:10b6:5:3b2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Fri, 22
 May 2026 00:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/42] drm/amdgpu/fence: add helper to extract the guilty fence
Date: Thu, 21 May 2026 20:20:10 -0400
Message-ID: <20260522002048.98506-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 065f6798-e796-426a-bf43-08deb7980e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|3023799007|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /QTgK4HJHol5f6cN0KZ89TMPEwkhCwtW3UZJNstsXrzQHtFAFHjldlo9E1iIbOIrHMw04focFJ2HJvFQkYqAcfX3jArXnbmSlCatfHGdTQRe2O7DErQOcaLrGaSosp3IOsCw5DLbqA5nrULl64+PrL19m61gAV+XPejlYoakhLRHa6utqHKlOEpqQqgafRRInFO37sJMS7tUQBhJTDa61rOJemdMA66p4HLqwQQ11oRjqPm/losHyMRhR/ltaWrNNB2fAKPvUk5Ab5KZAtqGsiQKrlUR4qMEYmhv6g+ui+YuCBvOAVJb0QtK48vcf1URntiO6jIz3xzoekzZcSCRQnbBWBCGkK7RpyhdlWSGfvvPdT/rC9S4BXcodgjix8ghxTAL6pOcx7b7ZrpaJf/IZCGqzHhYoHouT1O2KqD3XXQUa0UIW1hHA5llx5qx6FIzZtdFgOCAj2Hj+KUvsziqR86zV/i1T0/KCc22b9YatHyQgqrG6MyhGDHxXnrop5rqVl4a8vUMYGP0u9AvYTnNmrHciQcKZPj2hV6xscq+Pv6iEFB/Yelb0FPn3e9v2XuzPajO1NquwKb0HD4TUJk9sI0zqg2KjH6q9W2ALT1eWs62+4a0P+AOEWCzwliNyNmnzTNTc/y+4Rk5cH/Dq4LvhJaIaRZNw0tbaNXsD4fuceeZ5U+xvpb0UQzDJGZNnMZzgLucY7GUa6RRSsvVQE4+5GAFyjJXQpjOrufDoyJHlms=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3bSqeHWN+kNnlw0o7+7xC8iEGodo/OXROt7tsPCSebmuDs7PTtOBDJLMe1dUQEG0vu+BdKNIox1Ob/R7GVaNaJupl37Ags7x1ZpK/mHTINPnphavU+DDiI6xq6m4/O/Y+V8q2HiFn1Xv++jsyPrqo+GoTYWukkx4quyzKRp2VL8rOBoxguVnh7SJk1HvkeywfybC3io/NGZMBVUm1FRjmswGLprozciPJCjtonLQ1q9gxgfrU03WjEs+EMsDQtRndCXCdmQq/uZUs1dgaf61NWurYN0LAdhNiYnAIIo9GjjxTiWdvMAhu/KJTfmx061vhopFKpVBWNAD4aYoLc1+KyWYEWpwhZ3MXs2l/P81FxC42DYmU0AzaZj87dKEaz4iWZbvmfH1Mg43i2t9KF0dpR6MPnB0JafhTGzyR8j3WJ/3vm1F+8YvD3G6lQijgcFE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:24.0648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 065f6798-e796-426a-bf43-08deb7980e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533
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

Add a helper to extract the first amdgpu_fence which has
not yet signalled and is thus guilty or at least collateral
damage.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 31 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index a7a6db0bc6940..733e9b668ed8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -831,6 +831,37 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	} while (last_seq != seq);
 }
 
+struct amdgpu_fence *
+amdgpu_ring_find_guilty_fence(struct amdgpu_ring *ring)
+{
+	struct dma_fence *unprocessed;
+	struct dma_fence __rcu **ptr;
+	struct amdgpu_fence *fence;
+	u32 seq, last_seq;
+
+	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
+	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
+	ring->ring_backup_entries_to_copy = 0;
+
+	do {
+		last_seq++;
+		last_seq &= ring->fence_drv.num_fences_mask;
+
+		ptr = &ring->fence_drv.fences[last_seq];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+			rcu_read_unlock();
+			return fence;
+		}
+		rcu_read_unlock();
+	} while (last_seq != seq);
+
+	return NULL;
+}
+
 /*
  * Common fence implementation
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 9276a3bb69de1..71cd9bb12f75b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -589,6 +589,8 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
 void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 					     struct amdgpu_fence *guilty_fence);
+struct amdgpu_fence *
+amdgpu_ring_find_guilty_fence(struct amdgpu_ring *ring);
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
-- 
2.54.0

