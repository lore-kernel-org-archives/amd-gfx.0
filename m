Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48302CD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 10:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8EA910F417;
	Fri, 12 Jun 2026 10:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6/ghQ9l";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EEF10F40B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 10:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI6T6/drJE9fcVjKEVWeIoZJQA+aPFC7dBqsIeeTfJVkhsUR05O2nllNSCIU393Por7+LcyvbubUKy3qZ48XMg5b5VIFR3Q8vm6FoJ8WBeiqwzsmWdMbEqmEwHUHTRSGSLOhyqNfFZcLyah/tKLbP26jpz11NuaJzasJSOSbp4JKSxiGvWW9Gv1NOudBjOu+tYEZ0Nf/NYS3ZXfg/wQ6fXhxt7yTheP87KllWme/OyvZSC6VM1gkzww4tB7i7aXml88XvwDFTrVwCPXTaTIBengxcADCftczh2esl+BNV6BuWP728LpkykNMAFLH1P3wkqwCqwxmqCXOhTwCYcKv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir+AFc92Q0i6OePONvCZgEP2GvYYj98P/C5GO5Y6UU4=;
 b=QRBADVOSdWtc6PwqknUANSSfaPxmV8PduulgduULViMiyQxErZ5XSZBsvy//157lHBNKDCNyQcnR+qsfepO5vzDsmpj/jI7KT8sec/fm98aE6F/P1gabTMzqpBw8UaqlSwFQ8/fcJ634b6pvpXiW2lTkt92Af3+TJWcFhCKLQB38kIWQGtVYPygHv9asSAEApVl7fYixuc0LgTNl4K6aRl3WGSHaTREei++3yOFrWWeJygH42Z9THO6JE6uLsyqYkoQSSkgIajSZFXkZnUFUKVf6U04i0I7KtQw0aTlqlXEij2vSaaBndWMtQkScKIItp3SXKmxaIdLMxzlRYKONmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir+AFc92Q0i6OePONvCZgEP2GvYYj98P/C5GO5Y6UU4=;
 b=B6/ghQ9lH6dCPzy8HXd3yJBNqtH+NO8zD5Pzi6SEkvrPkvv320XIzUv3JfMeg5UTTTB7wwlEbsxW728+IDRS65kF0XP13E2ynw5biv9DCD95c2xtUlaw0817pJXVHzrEWkEGMzazTFt9CxdBg9H3Rsl3YO2jUW5vMb0ZMrlEC5o=
Received: from BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::25)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 10:01:18 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::40) by BL1P221CA0029.outlook.office365.com
 (2603:10b6:208:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Fri,
 12 Jun 2026 10:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 10:01:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 05:01:17 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 05:01:11 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/fence: handle NULL guilty fence in reemit path
Date: Fri, 12 Jun 2026 18:01:07 +0800
Message-ID: <20260612100110.1708530-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdbc195-1cc9-438f-d247-08dec8698beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hYZ7oWWaCTSepgzggERYYLXPkK10AyigJfSrNqykxe7iPDVrSSItm4UE1IE+lGC89J2HUV9QAdEYRzWKbtfNehY/MC7wvmz4VzSf+N6PH/OwlZ3X4wGl479+Rll8m3xveDav26yuNYm5J9hMXWXl0mLLkdpVytCp+GZVgtBhQY/zuLS7EUlO/6ZuDIiL75nh5/E/Vc8ivQmfLh7SKv045Q5+564zF93RZuRNG0fvbgnIL9vQjVDFnvP4engXWcjPT3Yoa5rvN/+pshS59ULIMzjnUjxVA4GkukC/6Vg70kEqx+l26LC7Gy/e1LzOqbWRe6dXSDHYg6HiGpd5wX09jnODSDCfk8+AtWZVrfAwSFqdFFSXQy3FUQRvT0u+z5R4Ri1h8IzMBixIdt3CYb0OgbVzh+lCBx8Cq0l/qro3iZw3lessM5CB+XRttPe9C1o5aXRWpp8yAPg6Q9Zef71+ULmsBhjW5sjrfq404nNhg+HHvmMBYozc2DswgiH16ZzhFuf2Hzmf6xQHcqDKPhoeBxL3Rr19ngDOt/U2pcGCE2m/voZ98DQOhtQtiJjvetWg8FwNsakkhkSu7Vv4IqjVTTbGrmRpBmY5Kuzb6T9UKZT7wd99sie8TR7R2nyPXc++vkyX574Nb/wrpP4QjaZBEP8O7/MYa5ZbD6UQAwlGiFnJfcCBxe74qw7r06GUh/Gk+jbB7csRz4WSGL1tZjiS2krj43OvS6B0CGLmWByPicI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sI+OCijJKI9FmazEseHYdaHbX6AqOh4d/73kY/Qug22ZHb13BPD1HcwVEhRo/t45QjIgVSZ3upugkb6DSvnda9IvtrgmW+7iCS8H/56C7TJp9mPrpiraQ2/ypV8e8u4pGhQIB8STfloKf2/32h18LWhe5mmjySouNKHrIdFJ9wkT0qPHe1ZW3M32mJR4aPx+eiO38qx9an5hQHP180SwqldXxw/eYoYXHSs4OYgfP6SAzrovqJu8OS3EpGgWKvLNfnFFgirv9ndtPoVWf3B0RZhBoi756KtQQ2lOenDV5esP3ZSTrTb1J8rSDKRsmLR8RWcZSfsqrXg3c7j7Supjf6QLZYFamlUnmDHElL6nuYgM4KkSG36jCotpvy3cK1S6a5+Ct0Oe4bwW9yJBuWO3WH1LZ8pUDQBJOVxrSJdvoWCP3vZtfCgynSCEJwbRl6a+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 10:01:17.7429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdbc195-1cc9-438f-d247-08dec8698beb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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

amdgpu_ring_set_fence_errors_and_reemit() unconditionally dereferenced
guilty_fence when ring_backup_entries_to_copy is zero, which can happen
when queue reset runs without a tracked guilty fence.

Pass NULL safely to amdgpu_fence_driver_force_completion() when no
guilty fence is available, avoiding a NULL pointer dereference while
keeping reset/recovery flow unchanged.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3043ad041bb4..ff1a82a4cdac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -733,7 +733,8 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	 * we are skipping it on purpose.
 	 */
 	if (!ring->ring_backup_entries_to_copy) {
-		amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
+		amdgpu_fence_driver_force_completion(ring,
+			guilty_fence ? &guilty_fence->base : NULL);
 		return;
 	}
 	ring->reemit = true;
-- 
2.49.0

