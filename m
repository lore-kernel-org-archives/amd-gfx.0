Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBCFCA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 07:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C2A10EB2E;
	Fri,  5 Sep 2025 07:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="siOaD1XC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6984D10EB2E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 07:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLRwdlL5zkoQU854VjFcpL6cVSqDnssQfSPy8HmeBYJtxSLl+BxoGM1sS9PHOOqNrsvBoMjxuIbaBezKm+Tm+CxjpHozA0Rccxzk7G3fkjL7CKpVFVb5p2AtnnQ/NA8Hnqrn3c4F5DEqWQT91lia5I2PkiYl/4G2irYQJIpxGhOJATG1B1DrSM+BcSNx9h0E18GHFxTdn39GG5SsAZnqkZiaQnWgE7CbCNoh0ecldBjlkc8qvA4s/fratY9H+G39YNdKR6YNU8zpEDrJx/SwqaQjNPe7ajQ8HLlSFjJulF/Xo/qmlLtw+NDidWte7Wo9njZUUv2gouzwVXdUc/SOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaYa+7MakYzQkTnggMGBSQk6llF2Y8hhye+fGa86O7Y=;
 b=Yr4pMsN/fUNdroSb213CCPKaHyYhV4HehDAL8IOThmvexDDEjVlhvsR+xK8vh6dLsYyQQ26JHq1jKdDWQDffyDyjwMImb3Wam+4ZODXSYDQVyTqovIvdS98vQjBGMqbynLnyKehzluUb+MVFM1YwO50qLRlLHX8YM4bdAloLpd1zVTQCXGmrrNEcWrjtxi6OdZR63HQRhTYHWPZm+Zx+b7ETx47a2XEgSh7MhK1mWycEhSj9ped1JjcuvRkuYCNpGbo2nzuyih0s8o3ZlpT3v08LGYX3BozYrb8d+JIvxN3HgeunGlxixrKByo1p6IYT7JPgeVzqRycblgQ/VbHQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaYa+7MakYzQkTnggMGBSQk6llF2Y8hhye+fGa86O7Y=;
 b=siOaD1XC6XMZZ9Dsb4kwzY0yYC0Mibdl/d1fLgMKAGXChshq+01mFk0hmxogx/iMBRqFA7HjLEjbo3x2q8/MDgNgTSv94v/zDvHRCmuCEDO8b/kNTyndOgb8dBp9rq0NKrXJWft/sGaSecSe8lkGyhzD1h2cUXu5dzYPmzaxllk=
Received: from DM6PR21CA0001.namprd21.prod.outlook.com (2603:10b6:5:174::11)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Fri, 5 Sep
 2025 07:20:45 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::97) by DM6PR21CA0001.outlook.office365.com
 (2603:10b6:5:174::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.8 via Frontend Transport; Fri, 5
 Sep 2025 07:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 07:20:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 02:20:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 02:20:43 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 5 Sep 2025 02:20:42 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix use-after-free in
 amdgpu_userq_fence_driver_process
Date: Fri, 5 Sep 2025 15:19:45 +0800
Message-ID: <20250905072041.3304368-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 94512c8c-bdcc-437a-25d4-08ddec4cbac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ZCmNWM1ko3ALny0KUv5j/6lgJX+Sk0tOczR1JZkJwsLsRQjLIJryjtXyn+3?=
 =?us-ascii?Q?yf6DgFpx+rNmi3Gk/npUqbh36015QZAgNVFQbLXdjh4L3nNOpaRhBdwNn/FL?=
 =?us-ascii?Q?rHOjo/5X2ienJ1KAIct0l6Nee26uwawnO1csTxFwsFWgEaPebyWQ5e/fxshO?=
 =?us-ascii?Q?8RNeYizKrKLMJk9sAfed3RpaGLYyAesfjkN+ia8bC+cBXT0pDtY36aAzJ47s?=
 =?us-ascii?Q?Hz0MRVQecTHAOlIHFL5I3KThQUMUAIg3+d1kUwrDC1zz0h4lGETqucDXTb4s?=
 =?us-ascii?Q?iSWYEfq0S85nl3MngqkoCCWgDV99Z0kMm2yGAtqQwUAMBpq0fHuEQANQv9sA?=
 =?us-ascii?Q?Qb8WnnWyL6hMePAOTm69S/1m9svLALcFQ/oSIABSLARSBmV3yvo8/aaJ/N70?=
 =?us-ascii?Q?1lTMMQ1lvr3vXGtZhwpsaHfIdqo1zy7C/n/kCgugyRj05GgeltzoBFRLyXOu?=
 =?us-ascii?Q?stWbsGpRVCdTMiagAAQO0iQZpEvqBIuq+Dm6rdfGoDcvWuq99VPVsbcOZU5C?=
 =?us-ascii?Q?YaZsXhB2XQN+dmoC6HMJI5EMVV2dtfrE6WV1SHmv8fjLufyVRw4QFOTD0NVG?=
 =?us-ascii?Q?BjapwHhKAao8uztwLO7FCZCn83xmu8qbPj2pAABYGYRL0gTF2ym5whXU241r?=
 =?us-ascii?Q?u6AYqiIIF/oh/So+GgM9B5H+BxrxBs7YmEyA8Uxn4WiEY7FPJpCcvnhQtzK5?=
 =?us-ascii?Q?nGX7Cn8zRs/w80qUmxpnNF9ZpTr/I9bc6mIeX8bX+YM+/cUwD2FdxUsXIq6H?=
 =?us-ascii?Q?/CEVCWhI9Y9NhtCN81cT8+s4819qsjgkQe5BfzGzVSmK222CrGguoy42Y92j?=
 =?us-ascii?Q?RAkTSmGNBF/lFqHRTR1DruTyRIFdWD5KG7z+Gbg+uEeQsBg+lOHP1AuA3HBj?=
 =?us-ascii?Q?p6CKhtvSSEb57YuwQ9I6a8HhYvHd+oCur0v/mcY9mbBxxw0PtnzQXzWEl/oQ?=
 =?us-ascii?Q?+y9Ro8U8Fe7z0ZQNAtc07i4itPlBEY7XTLFVtMGK3BURKn99Os2oI2CuvllX?=
 =?us-ascii?Q?8cYGJkNyI3NKT5rKdX4f1fuwDLG6+GvJtM6L8roeTEK7y9045EgF9DIcpf/U?=
 =?us-ascii?Q?t2mIbAt/REqlkFyfi2xUptBlHab5Nnho9nKA4rchM9I/XynTGhmNq/6O3Qxc?=
 =?us-ascii?Q?wGEgNsnQjZmFMC0Ul6NtQUbwyG/9wVfeuEcsyHysUXuVn9zDr+k5piNIW+tQ?=
 =?us-ascii?Q?Uc7dIOl5PxwfrM/AfkgyHdm0K34reixRGuDjmOtxMHomHkaeJgDO4x3ZGhNx?=
 =?us-ascii?Q?tCTLNYj3puSgnN9LC3EwerXWj7EhfPu613JE/HvAHNbEWtd6hxzl4lrWNr6q?=
 =?us-ascii?Q?387CTLpAhWIWZurtcJMd8xhcO0QiG1uq7UI1sz5mWtcVEwkA8lxybdPQW/3h?=
 =?us-ascii?Q?0NCTy8NBE2weZ0KPf3tZPJeAP2yWYZxJVajUORYf/8w2nzs9pJY104w79I/3?=
 =?us-ascii?Q?M9644sa1REmkjsS1UfJ5Hsfha01oEMP58WWRGRru51JMQ0LBQdYTz8fGFfC7?=
 =?us-ascii?Q?9IMdx+Sfe0JY31axMjxEj2wBUn6FGi/OWcts?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:20:45.1079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94512c8c-bdcc-437a-25d4-08ddec4cbac9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
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

A general protection fault occurs when signaling DMA fences from
the user queue fence driver due to an invalid callback function
pointer. This indicates a use-after-free
where fence objects are accessed after being freed.

The issue occurs because:
1. Fences may be signaled multiple times if they remain in the
   fence list after signaling
2. Fence objects may be freed while still referenced in the list
3. The fence list isn't properly validated before processing

Add necessary safeguards:
- Check if fence is already signaled before attempting to signal
- Validate fence ops structure before accessing callback pointers
- Use list_for_each_entry_safe with proper reference counting
- Add WARN_ON for debugging corrupted fence states

This prevents the GPF by ensuring we only process valid, unsignaled
fences and properly handle already-signaled or corrupted entries.

0xdeadbeafdeadbeaf: 0000 [#1] SMP NOPTI
[  353.889511] CPU: 22 UID: 0 PID: 0 Comm: swapper/22 Tainted: G            E       6.16.0+ #15 PREEMPT(voluntary)
[  353.889531] Tainted: [E]=UNSIGNED_MODULE
[  353.889539] Hardware name: AMD Splinter/Splinter-GNR, BIOS WS54117N_140 01/16/2024
[  353.889552] RIP: 0010:dma_fence_signal_timestamp_locked+0x7c/0x110
[  353.889570] Code: 10 f0 80 4f 30 04 66 90 48 8b 75 d0 48 8b 1e 48 89 f0 4c 39 ee 75 05 eb 24 48 89 d3 48 89 06 4c 89 e7 48 89 46 08 48 8b 46 10 <ff> d0 0f 1f 00 48 8b 13 48 89 d8 48 89 de 4c 39 eb 75 dc 31 c0 48
[  353.889593] RSP: 0018:ffffc0840078cd30 EFLAGS: 00010087
[  353.889606] RAX: deadbeafdeadbeaf RBX: ffffc0840078cd30 RCX: 0000000000000018
[  353.889617] RDX: 00000000000216c8 RSI: ffff9ed014558160 RDI: ffff9ed00bab3680
[  353.889628] RBP: ffffc0840078cd60 R08: 0000000000000000 R09: 0000000000000000
[  353.889639] R10: 0000000000001808 R11: 0000000000000001 R12: ffff9ed00bab3680
[  353.889650] R13: ffffc0840078cd30 R14: ffff9ed00bab3680 R15: 0000000000000014
[  353.889661] FS:  0000000000000000(0000) GS:ffff9ed198865000(0000) knlGS:0000000000000000
[  353.889674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  353.889684] CR2: 00007f44ebebf000 CR3: 0000000108240000 CR4: 0000000000750ef0
[  353.889696] PKRU: 55555554
[  353.889703] Call Trace:
[  353.889711]  <IRQ>
[  353.889722]  dma_fence_signal+0x35/0x70
[  353.889738]  amdgpu_userq_fence_driver_process.part.0+0x67/0x150 [amdgpu]
[  353.889995]  amdgpu_userq_fence_driver_process+0x17/0x30 [amdgpu]
[  353.890204]  gfx_v11_0_eop_irq+0x137/0x180 [amdgpu]
[  353.890345]  amdgpu_irq_dispatch+0x1b2/0x2f0 [amdgpu]
[  353.890452]  ? sched_clock+0x14/0x30
[  353.890462]  amdgpu_ih_process+0x8d/0x1f0 [amdgpu]
[  353.890566]  amdgpu_irq_handler+0x28/0x60 [amdgpu]
[  353.890667]  __handle_irq_event_percpu+0x50/0x1b0
[  353.890677]  handle_irq_event_percpu+0x19/0x60
[  353.890683]  handle_irq_event+0x3d/0x60
[  353.890689]  handle_edge_irq+0xa0/0x180
[  353.890696]  __common_interrupt+0x52/0x100
[  353.890703]  common_interrupt+0x9b/0xc0
[  353.890711]  </IRQ>
[  353.890714]  <TASK>

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 95e91d1dc58a..e18656d0bee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -163,16 +163,30 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
 		fence = &userq_fence->base;
 
-		if (rptr < fence->seqno)
-			break;
+		/* Add sanity check - ensure fence is still valid */
+		if (!dma_fence_is_signaled(fence)) {
+			if (rptr < fence->seqno)
+				break;
+
+			/* Verify the callback function pointer looks reasonable */
+			if (WARN_ON(!fence->ops || !fence->ops->signaled)) {
+				/* Remove corrupted fence from list */
+				list_del(&userq_fence->link);
+				continue;
+			}
 
-		dma_fence_signal(fence);
+			dma_fence_signal(fence);
 
-		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
-			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+			for (i = 0; i < userq_fence->fence_drv_array_count; i++)
+				amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
 
-		list_del(&userq_fence->link);
-		dma_fence_put(fence);
+			list_del(&userq_fence->link);
+			dma_fence_put(fence);
+		} else {
+			/* Fence was already signaled, remove from list */
+			list_del(&userq_fence->link);
+			dma_fence_put(fence);
+		}
 	}
 	spin_unlock(&fence_drv->fence_list_lock);
 }
-- 
2.49.0

