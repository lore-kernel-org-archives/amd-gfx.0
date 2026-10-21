Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C38606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yXYYFAxw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6875E10F950;
	Wed, 21 Oct 2026 06:26:44 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D305410F952
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAl8ykdjqmFPjE/I5isFvwUHexdx9ZrOxa8FiFegCd2XQTZHoOLD6Zd8ddYHIzV3F/SOWthNwVu1o9jZGFIaeGn4T0j07FPpz9AQ0avaaP9kilyl6YEQEv3DA9HceI5uAL36E9j4mKpTBGLkJtmvH5FspTfWXALnjmy/C4lrDPvjN3MhRfgxNQHhf+ilUJUvky4wswoyk2ceifkVuK1KEmh72qTf69vuQHyzgE2FvtYH8UHZez6h07ebcoRhoPYfphA9eAikrMFIx7LENFgmzzesVSmrUSNwxhyVbw4eG0bwsac+q7M9I+ZZEpXKZ82Odr6yRq8k4/VcPo4iPEN5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o6WDwrf6/IR8V8AQZ6zHkQIDgW2nLPWoalGHReV4PU=;
 b=DA3m03kN8zKnV6tSt2IdebGXs/RIsd27RjQ5P+GAImbeH6BlY0hOhaJlMnb2lcddLyr9XV4xhUpRt0kG8+rT3YPxdDzXqMq06h14UokZRkZVGEvHfFuBxvl5q1DJkHY8BT/VN58pnar88JkASHjSwAIe0o27X7MxFvB9KS9nw9mJKXJ06U9bxOxCPBq4nUhFprCLX9ub79eQc3jrhJApEnROs1jwHjpO1gX/hYyVJ9NOCvVzmKOPT2+AC9UXa44rtkhyJw0P5Moc5dQ0x2DDEjycq+9K2FZz+c7URubJTFGEfpo0sPchGcqOxBLjUtNmkVKeUf6Q+VDmN9N5sjiPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o6WDwrf6/IR8V8AQZ6zHkQIDgW2nLPWoalGHReV4PU=;
 b=yXYYFAxww/3Equ1fZLtEWBClHsUDJ6P+mtY3+XSj/x/IHmU0bTpdSzbKYXIg6fOo6FierWnKGYpD83Z74kGwts4s5ek3it0EGvVez9lBXKGw2k47gS8WKc4EnfO90Mm5HH5Uuz3eM8h7cRmud0zFEikzCUPfCtYAin8Bu4mTST8=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by BN7PPFABD533732.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6df) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:26:35 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::63) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:26:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:31 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:28 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 19/49] drm/amd/display: Clean up allocation handling
Date: Wed, 21 Oct 2026 14:22:25 +0800
Message-ID: <20261021062519.674697-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ee85b5-2234-4938-2a08-08df2f3c4156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: c3lqlmG7VgUSOeDHFJ/gJyj3vQl1ianVFzYOF/bmXZwzcL9oFtzj07H6czeJU5TgneH6rAmj7kwJWwYF0aeILy/AKZPbWZ+VqHKIcReydg3hFi39rmXUwBeqtBWipGET0YzjckYVzWZhrYTe32CUnIu1FLNjFGrn7Aeu/ia6sB9pv4do+Ft1gylYM5zEdp4TjE6MOhjqhIIBDjL0NwGU6uJTwx4LDmZ8NG5dB5o2hzhpacxEq7QKBrM6zWoSVx3yrN0FRpBidd9uMtc4GsIDlkAH7TFxQNCW0bkdhbeQWOMy7jFttUXDEhwku4v7mZIrqKX77fwqCAZgKOEmCXQdUfX2CCnSbh8j81z1mBsKcpzxt9ZMMPziBzaBOdaf58xceGVSeqAZaquZuRlvHvsw3RemnEbdujVCwO0HajQqnFzFaTGNOFDGBvlY2Yv3Pds0Oher1dN+bKdqHjt1EUGZrFq5KTbFUpyujgZR7zqFPF+LPFVD09qsBQfw59fyA5ZI+4v6nwLFMZC3cIRyHlBkggz90iUJk7HDLWfipwf7Rt29jK9BRYmKlM/jUUINPrfYugw3AD6ro1o8nEUIcMyddOo2mSbD9Mx8DNh4lrwnm0mH4WBgUKNf3k7t+bvCCp91PKBNQ4/JbCLoRIWDNhVp7hP3duuSXLQ2VeS93wS/A3O1dbQU9NaGpAEernftAb3u6i7f/vjUTWIvKJVeR4MBQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XjbnQph37iL08s5UFfV/fgc+MxbZfyd4ZOjGqBuGFjsBt4gcp/yd34ADv2cd90Cno+naaKSAzENKEbX0cicpti8CFUtOsmLZxphsZptSDFhN7Qt4EfXwlxTSbGh2QK3NWjed7xh1bZsSYjVZLdBKW2H1bGNef4Q88XSWltHsaJn0vGGE23EhtgxC58DOXCcWLg9xpBMq/cPWGqjad2qWpT29GERerZkNZZFOsKT9H9QPRycKNZjISIydMAQmSRVoykAHXmQ3IxnmGsrfrwSOyjmhodFIaYoA3gbirRwoWMCuwdMYESd/zeQNXxC0pZHmvpBT/AVtNQ/71yJ2BZNqHUTTqyz6ifXbsvcDa+vOPB+YojWFjV6Hf4DMgEjrOoQhz2VL6hlQbDjqX0nhJyjYnYscQxs4SDBCoBZpIxI3VPiEuuipeypSk5FVkafmWYVg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:35.0151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ee85b5-2234-4938-2a08-08df2f3c4156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Cleanup-managed pointers should be initialized at declaration, and
allocator diagnostics make the extra dummy_updates OOM message
redundant.

[HOW]
Initialize bundle to NULL at declaration and remove the dummy_updates
OOM message while preserving its allocation-failure handling.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5c5bd331a9a9..08837477d9c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1777,7 +1777,7 @@ STATIC_IFN_KUNIT void dm_gpureset_commit_state(struct dc_state *dc_state,
 		struct dc_scaling_info scaling_infos[MAX_SURFACES];
 		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
 		struct dc_stream_update stream_update;
-	} *bundle __free(kfree);
+	} *bundle __free(kfree) = NULL;
 	int k, m;
 
 	bundle = kzalloc_obj(*bundle);
@@ -5279,10 +5279,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		 * To fix this, DC should permit updating only stream properties.
 		 */
 		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_KERNEL);
-		if (!dummy_updates) {
-			drm_err(adev_to_drm(adev), "Failed to allocate memory for dummy_updates.\n");
+		if (!dummy_updates)
 			continue;
-		}
 		for (j = 0; j < status->plane_count; j++)
 			dummy_updates[j].surface = status->plane_states[j];
 
-- 
2.43.0

