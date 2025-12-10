Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C77D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 06:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797E010E66F;
	Wed, 10 Dec 2025 06:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s7nXJlpV";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21E710E66D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 06:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh3KqaWBjqpznRnHZjDslF2OVBXsjw/U044Df0cULQzsq89ApBkDMkkfgcfi2e75XNNt/cuN5t9uzKRRMXjqdWTKxt89IF/0M3zi4Nd765Ov3ZyYPD7aOB0A7BTGL6eKQ5hkP7caDHNq+MGlhM/9CQsaMV45xaOMM+5gAj59OKhTCN1wW3ivtfYY/EXO37lwDsvEb8teXCbJqfGbBcgi5041RnRxn0xJwpasqEWJQlLkciLLe9pGuThEkZi9WnZXa2mij8btO4y9a2/6VxE41nTnco7C/CEW8/l2KE/uQc9dqQfrg3HG6XsORviEJbCgiNQtkGqahHGIT5g7H2a6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e+7mgq2vAWN/jqWnUSnVIBT26Gf0U+fv1YIvTTp5K0=;
 b=mlG0WoBhFMYhgOnvzzgi0VmOKb6Pee1LepGtrIl8vIzQQWEtUcayM350fTt/2yMqOZUVPVrh+b5wUJyrWHGb1BN+xLqOSMU6Z1LUoWlQgYEGGtxgsMv/KMmKub/Ub7FkUpobZaDcqQnsvej8tdK3aFK8JjefVaPWB4a9d/lIhUyGdYttGl1YekorsZZgFNh6sBalNyAZ81HQ5XRhH5EjLoDMr0w5ECueKBOxH0STe5iBWuYc0DqaZMkBsIRwHdStE+dHqKQFwDDqaog6KvSHMyoWikkn8a4ptM2JTgrZt6FlFQFK2zImh6dyzoMjZD1db38LV/zmFZAYeyObEvkbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e+7mgq2vAWN/jqWnUSnVIBT26Gf0U+fv1YIvTTp5K0=;
 b=s7nXJlpVHwvD+CizRJadJ6JAjxoCnpmhVxCclNfokZViFk4C2XQ5xejO2QcvnGo7BOEl0oAu3q/cFHkL4nhsIBHz+XTAi7fZEK6dMY/q/BFlbJeE/jNaSj8xXLO6a7xli+kRBRizNnxzc5hBvKhTyt4Z7url778zmiERaRtZ7rQ=
Received: from CH5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:1f4::9)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 06:36:34 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::ae) by CH5PR04CA0024.outlook.office365.com
 (2603:10b6:610:1f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Wed,
 10 Dec 2025 06:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 06:36:34 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 00:36:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: don't reemit ring contents more than once
Date: Wed, 10 Dec 2025 01:36:17 -0500
Message-ID: <20251210063620.5816-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e172c44-b18a-4fc6-f12b-08de37b676a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tZSVOISUQup6Zm7A2M+ZJhB+nf7XEvwaYYV1u5OviB8DWE8kSwttJq0CD3in?=
 =?us-ascii?Q?2rWZWdX8pe8YH+GISrxuog7hI//I18XoTYSXzr117q/QXQXrJJJ9jz6babQ5?=
 =?us-ascii?Q?tPacwM8cGPlEw9RekTS05o8deCYxylpodEr7bxZvr4B5sIvRmM052QeMBpWc?=
 =?us-ascii?Q?PZImQaK2pjiYJcp9TBTlASj1hq4GQCoHofONL1BJ+aB+BRYPTdzUYQOHBnMT?=
 =?us-ascii?Q?omezd3jqvASXyi24xoVN6irhTlbwew9330wDwkwC3HcGTchEOG8JgN/kRRmt?=
 =?us-ascii?Q?0oSdJRjravESQwRRX1B+vzqvZTvMrRuZ6/3zdZVZWtsQo5wRuLPxX+1gse79?=
 =?us-ascii?Q?KwlL2gx0YxBWxCin2p5ajkef9n4nTsw0KP7NY3nnVljy2E478M1IZ/FrbNkY?=
 =?us-ascii?Q?nxSG+LBXlMNPAKWkUvnchFw97oJAUpu5gS+Ja+vQ58MwLWdkiamrGrjKiROB?=
 =?us-ascii?Q?1EISfgL0/qlar8RBy77It9I0r9iv9VKJiGidZHoRyef4hJA30VoW+qtnjqo+?=
 =?us-ascii?Q?5SzUbkJkWwnsVW3MTx8KtNA/J62mtHyJNc7nnJ2KC9mOBxbp03bUfjto2sCn?=
 =?us-ascii?Q?HbmAkRid5wOGxm8gyfIqjttUx7sKVbXb2qb8EUKFWSun4+kgg96TRQQuMpzj?=
 =?us-ascii?Q?GW6Zff38Bd6xNOG+R0opZ9zQV6geCZyp5uuR5SV1VrdmZ9YgeGBwGkvqTs5U?=
 =?us-ascii?Q?cJg56WgCZKmJHv+WtvIkK1nlZtQu7WBYS8buhb6RkzLYN15di9rVNQdsXHhl?=
 =?us-ascii?Q?itU2JR/vmh/KLxkMhntAgbKffek51fEwRq8mMmY8nxddwa3oiwOwMPLYPcF0?=
 =?us-ascii?Q?bSphzIsVU/kX792amHlX2EQEfd9IL6T/+TND8KI8iXHhbrojUzBs4WsttRU3?=
 =?us-ascii?Q?QmpUsAHrnzvI250BRBa8CBeLI87E9lth48oHc858tc2PdY3+bm5KLI+7hoaP?=
 =?us-ascii?Q?jAMQjwFgTQEVHI0DzfCsttyhMw1z7UIP/JCWKDKiiAB+ZYRtUbK0+AkVNNon?=
 =?us-ascii?Q?TjSmy/fTlKmNdun0uWB4pXbBNacWOmdc5/pYiuS6iMTJTHbeGZ5X0jv1FkIw?=
 =?us-ascii?Q?NAmrE0iLQHyNqrkF013urJf+Dvs5F5NypkkCjpQg+WpMhlQ31q1RiiPWDPOd?=
 =?us-ascii?Q?Hiw8ZGSPzr8JvYm70PZ9SpmXoNJ8rSUWefh5stPZQn5tCdf8yUm5xOtI9ghs?=
 =?us-ascii?Q?sG23bidZPXhTnxVqcTjmQtQ7dt8B7Kbor+nIhS9wb2iLQc0B6ltySU1yXPLS?=
 =?us-ascii?Q?hx2Wv1bQc2rMiz8EfDPPRH3p/S9Wo840Be7u1Txc5aH4v6UJoFl8albbxeCN?=
 =?us-ascii?Q?QABBbFm/+xVheGkBn2/23KfLSqXt+fVMgAxONC9OhngRldYFrLqhtNImRNH8?=
 =?us-ascii?Q?yDZopuu997rAv/+EnQCnQwm6Isc9in188ypdHguW+mZ7I5Ab01cv8XEWPABt?=
 =?us-ascii?Q?eePwp6o+vwAB6MLqTKalqXAe1s9+sCQlAfpu7DjYQqWtfL25JM2FKf8CM0wH?=
 =?us-ascii?Q?THJx3aA+1KOY9jXAFtP4XQfL8KniovIGgR8Tb1RuLellQYSaVAxxCggNuDxa?=
 =?us-ascii?Q?ehKcpUclv/90Dbv2FpI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 06:36:34.6896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e172c44-b18a-4fc6-f12b-08de37b676a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
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

If we cancel a bad job and reemit the ring contents, and
we get another timeout, cancel everything rather than reemitting.
The wptr markers are only relevant for the original emit.  If
we reemit, the wptr markers are no longer correct.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1fe31d2f27060..334ddd6e48c06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -710,6 +710,7 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 	struct amdgpu_ring *ring = af->ring;
 	unsigned long flags;
 	u32 seq, last_seq;
+	bool reemitted = false;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
@@ -727,7 +728,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			if (fence == af)
+			if (fence->reemitted > 1)
+				reemitted = true;
+			else if (fence == af)
 				dma_fence_set_error(&fence->base, -ETIME);
 			else if (fence->context == af->context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
@@ -735,9 +738,16 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		rcu_read_unlock();
 	} while (last_seq != seq);
 	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
-	/* signal the guilty fence */
-	amdgpu_fence_write(ring, (u32)af->base.seqno);
-	amdgpu_fence_process(ring);
+
+	if (reemitted) {
+		/* if we've already reemitted once then just cancel everything */
+		amdgpu_fence_driver_force_completion(af->ring);
+		af->ring->ring_backup_entries_to_copy = 0;
+	} else {
+		/* signal the guilty fence */
+		amdgpu_fence_write(ring, (u32)af->base.seqno);
+		amdgpu_fence_process(ring);
+	}
 }
 
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
@@ -785,10 +795,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			/* save everything if the ring is not guilty, otherwise
 			 * just save the content from other contexts.
 			 */
-			if (!guilty_fence || (fence->context != guilty_fence->context))
+			if (!fence->reemitted &&
+			    (!guilty_fence || (fence->context != guilty_fence->context)))
 				amdgpu_ring_backup_unprocessed_command(ring, wptr,
 								       fence->wptr);
 			wptr = fence->wptr;
+			fence->reemitted++;
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index a1fb0fadb6eab..d881829528976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -150,6 +150,8 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
+	/* has this fence been reemitted */
+	unsigned int			reemitted;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
-- 
2.52.0

