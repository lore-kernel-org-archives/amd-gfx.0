Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE325C79FA0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 12:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A06A10E008;
	Mon,  7 Sep 2026 12:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SZlsNPbb";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0130A10E008
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 12:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tua8cbr8EbUnybBxhYy0fcpEiLVxUj5fb+KLH1iVNmxGeWQvpPmVSCSlST9PuGd6NEpO+ieQxyWhGylQvCCyYCW6vhgSA16Q87K+Z6ohPHJp1TlahFDKA/xR/p75dUchO1rf/pUJOedtJaWky89QzFrJQXUSUY/IwTlv801hre1aKHrqqglrrSlZ5N7tf9ZZHNQS3tw4Lq7LCIMIdAY2eGrZhW2C+5d0J1LP0/Cg00HUQOqEC+BDUn1PG5z1hsHPnDLIiBQfBeLckwvqElztsabcGsDgl4vfGx1zwRYg2xN0mzYucJvR+hOOOabxfkT1+uA4AihlSTFY/9rlpZASwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auDQclGMVKqlbq0VcoNjc7OQ3sQzTO8xI3fFKCTEs1I=;
 b=D67AQNKCW0TLB4a8XK5gp5DprG21Fx5QqcWGn8ZG+Nm7yIM0jChIIsWrv7L534OCo33KLntqVeYcJd/I5MzuFVcnieowjeQkiArqARB/rZ4zO5iE/J117xL7n+yxQ6ard0JG6lelqp4pVDWkckRQWrS9hhHHZNMWumFkQH79ZM1hY2w3Po3OvxpqHmTqVvsnsvzzC8LZgGgts4Nua5avf/K+92BHdk6cbBaA/HKGN60ejXcfMPcTEoM8PPHRdhSlttRA3ypTEN+QNZYKLZDbDgz7uwUEpdC5gZ47rJpJRl5eDGTLkNhzzHoAKnnQ6NZtgHM7X/Yc6yuuG9YMM9hHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auDQclGMVKqlbq0VcoNjc7OQ3sQzTO8xI3fFKCTEs1I=;
 b=SZlsNPbbsLcYlpHVOgTK1XqXTGX1+WdEHTZpC9ewepDDMI5gRfH7W7sCzCCkdNwmNk8bDr4T/I1qG3AInGjObueAE71QEEufjaAysY2O70FyZIBem/IDqzorNL4YufFp8a3yLvCsXulho4rcXh9zkVvE/6OpBFOX7O6EwqC7Rkc=
Received: from CH0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:610:b2::7)
 by BN7PPFED9549B84.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 12:53:53 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::a1) by CH0PR13CA0032.outlook.office365.com
 (2603:10b6:610:b2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 12:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 12:53:53 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 07:53:51 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: filter out idle userqs from pending signal
 list
Date: Mon, 7 Sep 2026 20:53:43 +0800
Message-ID: <20260907125343.647133-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce70442-2ea0-43e9-fd39-08df0cdf1254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: aRgUMpcOR2ISq4aDocYkzkOzTZ0lzN6XE6gozbpk4CLmONriuqZgKW1e/0Ajk97mQCm6MtcbY8e6wm1/7ZUTq7Xs3B2UaKfqDTj2+N5oR40jYzdgrlIS89vT8CZ5rT0Rt3mw1pNHB/p6XELn9CLQdT3Oa9zVoglRAZPCXIxsceNkDcKJL4ApJhGd1ylzS2BFnK95cZZQCtIzX+5PRyu3X52HZdP+rdMzNB9xmwu7l0venSnuob4iyoN5l9LBMG+yJ8MK0V0paqvjCBECeNvyU00NqDd8eEJBbgu+NEvJtWmj5OKVEf3aJbunls3Pa5DxFs8Opi79PBH5219BF+hUxGk4V0W6b7D2xz+P8mv0n391z/bOmyNXUHuERw9H56vwXM0CO3zgFrEbS20EekXc111/Q9o0f9wmVXbQhJFX87jDvCnOW+KX9hDSmrCHs4aNzFmCTBgFNSA6H3qejMauR8T3RR/8Q0BlwoIVfongkkV0uZx+K+LgMtj+Zvnxy4WGJy3SYE8b6LAluLpxKUCCBgE//wdQGWac/ZB9YuwD6ruA5a3X3qZXPe/PNu/L2Vhku6jhsXT6BT00qdWa3roBInI1X634K3rAUJTQpwSPpDU3SN0Yk4pCqL/mSNvD4betRCMKXYlZsmkI171TA4DOeKeD931M05uT/h2jrmpRkPKVspTmiR7G/bTMT7SvQz3b5zasF6nGM+i6OM6sqcywfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LZi9tcA4mQHZmPj7j8k8YFcOhqInszjuJRRvyWaId2y4xvSdfliGAGSc9/J4I4TZlDKd5YNY5lUksa6iI5fMdvsyTudL5Yvo2gEuTX+22QUcR37+ElIYZwOUpTc71J2Y3PTl92+EQ7oRQLbKPvDbINMNGB/70tSZZcKSXVwZBD6O5zIat4QFpszr4VAVGFvWHsx2WOI+lSxpv8YoiiH4TKlB9otjoETpMaU2UODUr1B+YQLn8TQ42sh73plKNbIynXofVS3VAkNuRu1FEa/u+rwxEwr2bVV+S9ih5mgjngq4QzuqInRgXzn3Y4QUmB4o+7NCZb7m41AZv8AYbD7uxhbdJWiJ71JRgr6NOz6rr1GG+v0VfQH1QSIjAhRCc9o0Q6hB0tUdX4P4J5+B9efcLQBOS7XTky4ZJcj5B5EGSBpsQjW5MSN8jjLV0rdE3PJZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 12:53:53.4159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce70442-2ea0-43e9-fd39-08df0cdf1254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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

As for the empty pending fence list case: after cutting the userq fence
driver's fence list, if no pending signaled userq fences remain, this
should be treated as an idle userq condition and the hang detection worker
should be cancelled accordingly.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c270635c907b..2f38872dcef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -162,8 +162,16 @@ amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 				&userq_fence->link);
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
-	if (list_empty(&to_be_signaled))
-		return -ENOENT;
+	if (list_empty(&to_be_signaled)) {
+		bool idle;
+
+		/* distinguish: was the fence list already empty? */
+		spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+		idle = list_empty(&fence_drv->fences);
+		spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+		/* 0 = truly idle, -ENOENT = pending submission*/
+		return idle ? 0 : -ENOENT;
+	}
 
 	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
 		fence = &userq_fence->base;
-- 
2.34.1

