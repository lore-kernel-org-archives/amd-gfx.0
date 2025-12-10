Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96897D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 06:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B7A10E66D;
	Wed, 10 Dec 2025 06:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3U9zN9GL";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F240910E66F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 06:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh3N6Pv8ue2L4OZdWF6Yl6yqtnJBe7B2O0YM/BtEjXyU7iHDCtyRP62tKmFv4KXv2BhHFx2nrzze7Tfm4Mzo5HNCV8vVFCdrmP9QwcHTc0z3RhAaOuGPE8LUNv6dQkvcJrMoe3fI2IwGF40x/XqJh9t8JaI2EXnv880o7qlEBET9SnbT1gPSwkPDu0UypuEnomTuiCQ+nXJW+6xogOlsKOTQ+NPJWMOzaKQgtd0yXOo0AHFl1O3H3zibc0OXJNtLiwhRHbk0kM/uC2JRgsqM9c7qaeO2e6dbRHw7OgRg8sUpEkR7O+kCaseiJvwhelWXeNWIuApQvlWMKYV7DVHgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiAGCiv3hAYrychpFV8gkBlRcM5Pl0N4ErYWJWx+DV8=;
 b=fkqlgUXvQII6MbtcAnZCkAke43XQ+dQUzbvEbopUc4cULBFwSou3L8w5PzbPs6Ed5tneaepb2rOcj0IDCLFAeuQExIacRzn7k8taY87NBOA1Vld8qaZ7zAQ/lHB7kwIR1oxiNS9bCKjyNp+nbAv5WBC7yNOZW7J3tZDt0cL938fJktPI1bw3vcmLJlHV6NTWT4BmqsISS4B6CBbGEn/Ho1JcZLE9dBZQQkv5B9oZYtxolgJAGzFJEg2uEzPi/JfE6Y+uYZF1xzzgJA9zXja4tX6pM1cabo1I+7A6XAjX6+dunZUHYqgxDwrxRPADE/1Y6sUQ7q1dNh2kljeZbbaULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiAGCiv3hAYrychpFV8gkBlRcM5Pl0N4ErYWJWx+DV8=;
 b=3U9zN9GL4aYigkXAyvBA7pk1UZpLIm/uXpxmtO+didIQgmZ8qENvJ4o1CASCQF8V+eCzjGsBTbuI/wnTW1fWBp/PfYmlWdSJvqR5ivLLhk2kVouc3+zNCA7az6w9PkuNzmrLTSmTxGJyL0H/qnwvdC9AFPZQSLBYNZvbmUYJERQ=
Received: from CH5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:1f4::7)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 06:36:36 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::cb) by CH5PR04CA0007.outlook.office365.com
 (2603:10b6:610:1f4::7) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 06:36:35 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 00:36:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: mark fences with errors before ring reset
Date: Wed, 10 Dec 2025 01:36:19 -0500
Message-ID: <20251210063620.5816-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210063620.5816-1-alexander.deucher@amd.com>
References: <20251210063620.5816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b0e473-283e-4186-830a-08de37b67753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DQluGQ7x89FZ3HqMEC+h2czkB5T/chwfFc4A7tt0o3bmPoBnZs38fKAbR+QS?=
 =?us-ascii?Q?WYG+e1Gi+YAK2DvULR5Bg1QKmvNH0q7nyUuXAHTJjt04kQNvMN1v+4o+UVlw?=
 =?us-ascii?Q?EZkk+QG1xcq1wc5pfe2FAt39UTB+Z1xs9K4Kd4GUrktOjTjZybYv1phVf5u3?=
 =?us-ascii?Q?hWRebsRyn9jx3LTxAPs/MkFFHrPuFS2vU2D01k8Zg9AOR1YS6oGA4QkP8VIi?=
 =?us-ascii?Q?fbP1wcsHJFxuB7P4oLnKvZT4RS5EiHIlLFgd+LKQ0fCyjJ+MGbDE5WK2zoRQ?=
 =?us-ascii?Q?TQIcWt+VngNBCTbw3FWu65nqIloOOHN37TWW2gXG5JEY2/bNbHQebT/1BVX3?=
 =?us-ascii?Q?enpzj6GU5oTSJ6jQ6vV+E/tkH2xpbfmHk2wm+Re2cjjyAV3g5NtoOHuQMVXL?=
 =?us-ascii?Q?L/Kv21xlB83IFIajae/9eU+SdQveaZc+kfDxExsYhwMMkvHd6iRXWzsU275K?=
 =?us-ascii?Q?lZtsDdXOyZWMi4k4fYh71M5wogvOUqpC3ibeRLochiluJ/RPzKuC4jKOwG56?=
 =?us-ascii?Q?UgAVNnlZoc8s6SkzOwbhv2nm5vYkr0EwaBDlwNXzZIAJABkaxxae+M1VzINc?=
 =?us-ascii?Q?wb9jUuxWyyOjQtWrCSpfZ8dzKB4MrQWpY44fBB3ca4maOpgQmiH2emFYaCpn?=
 =?us-ascii?Q?E4viJyV1RQ6VvC5IFVap3pa3KqkV7MdmvanYcL/4u8Cz6PYQ2n/rS8/V+Hx4?=
 =?us-ascii?Q?neKwp1Ct6rej5oaZTJ6A+k5SSrdBLPVcvrgn5hrmd3pqh8nnHImpwOLW1Zg8?=
 =?us-ascii?Q?WVWx4Wj1HioPN8BhQ4GiYVpkWKJ2wQHf+YqWUqLA5r2QVfuUYLT0I/t3GR8e?=
 =?us-ascii?Q?v/YzZNkOEC8NOM7Uvj/eyAznYo6xKmdvrlYuBLVewHmjTGGrh7vsAVXkaYON?=
 =?us-ascii?Q?5IZ8xSzn6tZAhCKl6q/lIW3YR7BG2hNUueJj1SPnE5zVbnKXTcekod0uSuou?=
 =?us-ascii?Q?W/ZSGMwjcEnBJoh+emaNsx6RscvSNbt9bSXOfB8PoepkcMTlDW7eQF0Umw7o?=
 =?us-ascii?Q?XQH9qR8Yp0PMm4ftNy+rfY5Xl5/hnuQvVPK3HGDuRO8RFt59FDNrKGiOEEO5?=
 =?us-ascii?Q?qk1TklErRIPfWGIXcHUgovtZd+1Crb/3svvtmu5Idrzqb44levaC1Nbe7oZA?=
 =?us-ascii?Q?+d3FwZlra6e92HZbh34Tz8apPsR6gklUYpb0I4b5MzFBGuUsP+PGJls27nfZ?=
 =?us-ascii?Q?TWNHVqOZ0MCmzvjlJmBi0uFdN8munnhhVNJWuy038vEu8JSsWPDlfEeEwPqj?=
 =?us-ascii?Q?6yCvN/KcIXhqBL2pnOpt39C2xmwBaahM+LudE0iefzrX+UYvh7+xbw+O+fl6?=
 =?us-ascii?Q?vZGtJc5Qy8dw9a6ToKQpQSiesNzl3oNHMlM22+sl7jL2q5l6y1zzpH0Djk50?=
 =?us-ascii?Q?pUi4PDpQMQB60+UdEzpcMhohBOA7wyKASR+PaEuWqcDuJJ6JW8KfQGyA/4LY?=
 =?us-ascii?Q?wZim7aqLMBTjqlM/W4ILkKXSY+H0SzmJmg5unem2DfGE0xA2y+Zc5HhgGeWe?=
 =?us-ascii?Q?pv6WnsITAjVnwFEq+N6iuC0U4/quSm0kjC8O7GohFoxr2i4H6t+yvO4Mq2sS?=
 =?us-ascii?Q?sF1DWdkO+pmqQ/maQpg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 06:36:35.8203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b0e473-283e-4186-830a-08de37b67753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80
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

Mark fences with errors before we reset the rings as
we may end up signalling fences as part of the reset
sequence.  The error needs to be set before the fence
is signalled.  On GC10 and newer, this isn't a problem
since we don't signal any fences.  On GC9, we need to
signal the fence after the reset to unblock the recovery
sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 1aee207b13524..fd7b0f955e4df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -872,6 +872,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+	/* signal the guilty fence and set an error on all fences from the context */
+	if (guilty_fence)
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+
 }
 
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
@@ -885,9 +889,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the guilty fence and set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
 	if (ring->ring_backup_entries_to_copy) {
 		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-- 
2.52.0

