Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39856C83F14
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 20:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A5710E857;
	Wed,  9 Jul 2025 20:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQyhVFGt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB6110E857
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 20:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQ84U0IufCtpqp0jDreMKZJynd9dyCNf4tqb1o0LKFfkK/4eCX1oaUKK7l9KSlO8uju8vhr87k02k6eJHqF4FF6W5PWbu0X30H4stMdfAKk3LXesneZGX+I7fLSEcccWxKKy50poTCWIpes54d17zh9pNYbRqW5Mo10BytD+ODaoTuWUkqEW/phQd9u7o1/lkCCI9fbUp43PLphtZOlY+2JPTZhrlQU/at6OwoojWxYsgrQtDzafSmlfieKPv6O9i3pHGOaq0BXv0eNs8apGXIVwxSJKP2R4JEvyW4NzMLVXEEeR9QV7jqGC1y+lt/XX2PKeQo2gohPw94mc1qA/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZHH82xfxMsWwKTisWmsMTfgbS4gRMt50PTWBQnzBPc=;
 b=mFhfhVBHrSEj78r1ub53JaEJ/iDUwUwYATeJONI80b9V+H2m/hs066jluYkjkBFuGTUBhQNC2Fx1WXxiH8KVWOIooTcTU9dvaqg6GfYYhCLahshCGbRjHaVaG9dl6MXfs3m9pkyeud0csXETdRYl/rrxMAGKWAxoZpxw5NbjC0jLfCdsK+M/5/I0ks/WHl4fiet+jVYpQzGtEYkLrZrleKXrwgy246cfXUuYci5acL46BTC2FN8VX7gU/f7IJJ1wnnpi1sMjhtqL27xsxktflFJEh+G83tGppRWzT9OUA9akxWr+18COVyvNduAeSOirEOCbQoV9jiJO+sLELJ052w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZHH82xfxMsWwKTisWmsMTfgbS4gRMt50PTWBQnzBPc=;
 b=bQyhVFGtBqtm2eijheyyy2ZX+5pF8FDsCqli+ZFSM4WFUl3sqrmXcgpclVdC4pQ6oCVsM0unvGWZF4KTYePNDCHQFTAmTT30f2qH9X3VGKaM8o6XJzEtvoS+wb7YKtGwPOpOwRjpg7bZCHBuUy9Gk1RvHUOAYy4bEyJm6JZTY9A=
Received: from DM6PR07CA0097.namprd07.prod.outlook.com (2603:10b6:5:337::30)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 20:32:11 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::b0) by DM6PR07CA0097.outlook.office365.com
 (2603:10b6:5:337::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 20:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 20:32:11 +0000
Received: from Devmachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 15:32:10 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid extra evict-restore process.
Date: Wed, 9 Jul 2025 16:31:56 -0400
Message-ID: <20250709203157.404490-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: f7eeb058-db34-4d2c-9844-08ddbf27aecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iRiyE5H+kQxWfrg6aqcSXtJb5u+Y6H0+aOaC3qtxeAqFfoyiGYR+UT0m8RAq?=
 =?us-ascii?Q?hRaaeyBuUHVfq65WToEWIqfjLI38KdtEiwYo9kkMRJjQtPRHfwdBLxJwJobZ?=
 =?us-ascii?Q?j+cqjhL0QErjSHu5U0WHFNGW4ED2WH6wbURB8YhbKZEWn4WxjoC2EMzULrf3?=
 =?us-ascii?Q?vrjTuTYLI4mlK5mNDahhPBdJYrjgXspzQ2jGeRn5mQ34CL6ONhiH6/huvxuB?=
 =?us-ascii?Q?8TUaaRiyMgRUt96lg98MebxstEUvc5PFrJWEuSTgI66sC4nttTrbY7+UjB+i?=
 =?us-ascii?Q?pmgnXnSqKg7mZDH4B9y2jA1rkZE1shN44tJxqQjdoiX6AIfj5sA1kpmMvvce?=
 =?us-ascii?Q?vdOAW2gkBxMPkgzcVH/2mah25OaUkaTTPY6+gVpa+WQKK5uLrMaBckdanoF+?=
 =?us-ascii?Q?zF9k1J7qdQEn46ZHR9Endy45TaKbyZ7v+APFqhQhl6eX67Vd05Dlc+T7I96w?=
 =?us-ascii?Q?N4pPyDC12LpZ2Rs6ciJ8fAPNxXvkx7lpv/EBbnpIi0hvwFlsmrBRoVtpWfk8?=
 =?us-ascii?Q?aBrkbKO+wVxW8Tya5VNrBXXXUumRaQ18xQP1GGAn08pxOhI6erEnGNaIRo8L?=
 =?us-ascii?Q?RMvmtZ+oCII7RnDaRfBnrT/pQhsdSRq7mlfisQo+OoKtCNHbBNOXm9H31PRD?=
 =?us-ascii?Q?roh4rbAIKmFwiETgBRV2Hh5t0WqoPYMeXdjE0t4defJq6+0IlFJM3mDoEZx9?=
 =?us-ascii?Q?iTbcAe+78XXRgA5xmrkJZCRowPNpwXuavAvHDRR4tM1MMSHxmXTsoG/V50Xo?=
 =?us-ascii?Q?x2raOgOlCq0l/2QlExj6brAlGU9pwvJojWn1jpzu2mJQkDWgfbsEVwTiNtDT?=
 =?us-ascii?Q?mYYOWchw89l5Q1Jj8nbJR1Jwwq5/PYJPzyrJK1nBPWQUrelxkQl8XETQPoaW?=
 =?us-ascii?Q?/dF28HerXBUbWMnn0tlLVk5sCE9YpJZEH38RK/UhKsQ4tjOGAt/GzspnjPR/?=
 =?us-ascii?Q?5MsFMR7XdkOhfj7pnhn8bObwb0wlchjfH2dl/b1sfmmWh61LxkGUQSwvldFh?=
 =?us-ascii?Q?FQckW9IbuKwQD8cdTw7AavhDIXmwL67Xi9Wh2d4qgzb5coA5g2Ll47fIrArl?=
 =?us-ascii?Q?sfILbBKsdz15tKfwcJBqsyLI9LPx2RRIX/8fITgyk/W9EFNpwo5yu3QVCAyx?=
 =?us-ascii?Q?EJfDb0KasShHBoKn6gadwwIhVBIItNSMeyC7/eoD7aobobZQYJhiq/9TvDCq?=
 =?us-ascii?Q?gPZ0EukwnP5JnoCCSsgT0o9HpPOu18bGgj5TlibwFgAEEsrzU7S6rlIpde5I?=
 =?us-ascii?Q?dfpzwmhbvVVYCh9Auq3l4ii3af+LRjvxJ+o57RBZMAzssUoZETMkzdPv6z4M?=
 =?us-ascii?Q?h8sgNxIPqaGDfGM6vH98jYIVuk2ca7ax2GbVJHBnFXzmnryd2o74Vsa+CPNe?=
 =?us-ascii?Q?E3mCSyqZyPGNkLzkUcKBkbFrVQ0SxMC0ZV64qxy5kRVNY34iS/ywohYsmzsp?=
 =?us-ascii?Q?gyuNFGY78zsxGwG2BaT2gckeRZO21g5WOd6D4iAxS8QTmWCcphfjJJdQRoaH?=
 =?us-ascii?Q?o+F7gGyE9ozHuHorXrPxPDZpgLvpxEfmmvr3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 20:32:11.2880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eeb058-db34-4d2c-9844-08ddbf27aecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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

If vm belongs to another process, this is fclose after fork,
wait may enable signaling KFD eviction fence and cause parent process queue evicted.

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f042372d9f2e..8ee1b7e62dee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2410,6 +2410,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
+	/* If vm belongs to another process, this is fclose after fork,
+	 * wait may enable signaling KFD eviction fence and cause parent process queue evicted.
+	 */
+	if (vm->task_info->tgid &&
+	    vm->task_info->tgid != current->group_leader->pid)
+	      return 0;
+
 	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
 					DMA_RESV_USAGE_BOOKKEEP,
 					true, timeout);
-- 
2.34.1

