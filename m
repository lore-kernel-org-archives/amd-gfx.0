Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6328DF589DE
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 14:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071EC10F179;
	Thu, 23 Apr 2026 14:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tCM/cXIT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD7710F179
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 14:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7eJGpfeeMR35UI6ZPeMECqb1//t1fXAv5HU9car11bfXNf14bbBoZeBisgKRxirnMPiB7DBSP90+Xv8iYGYx0Yhp++OKGWNAhjuOUnx5PiKLO3A1nUjlXJ1YfSmLeJ1qkjU6lyFhq/fkGdC0b41+uVAQ9hF7xvsjxhK/kfQfFumZQwuA10wtR8Ng5/a7WNujBQX11fycy0ZoySarqjxGo7E/AYnj/5Ow8WpevKSm4FuztVgbOjq35nIHrM3kpbmz42w07PUvP1miAFBcZph/yUYsBnQB88Nb4UF564xkNxR9y5hRLaa+uiOOHR1F7RmQA/mkAQVFUuckddC6+vO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc/fzn1Nw6B+Ji900A9DTCamT6GRqW86444OLUT+dgk=;
 b=cCNsCzm+d4Tdpf6BYYXfyRu5BK4fNlC4mtWixkfyySgOMaLiblBJGngtRQa8uDjptPSj/B5rVYUoE9KSt4+BQR8uPCzgT2K6xmTvV9SDxIvK4lKKoPbxLKxWj9LyZ4XG3nOY7PyWFOSf4bwO4Z7bqYzo+T0H7vc8ylDRJv5GeMRvTXcHkB19klaQrdWmMmhb3vlsvQ5FutwJwTf8KgcSQBwWiZfWZMf0UJudEa+66hOIZ+seKCHb3fJQravxW5f7LCX64KtgvjoUWHpJOajK+wy3+gHAiAdZOGOfnvndPvR7d/6UX94HNuuP2A2GZ12vHHrKBqA1JtRUMBO79hDeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc/fzn1Nw6B+Ji900A9DTCamT6GRqW86444OLUT+dgk=;
 b=tCM/cXITnqWpflkBEh3gJXoanjvZCDBpljmJaFWAqBxF+7LGTZzjUSEgHa7lHLj6K/dfmaw6ZImvgxfiue7WP9mOvkvzxDEcK/dTahLNWnkL4m4wBWeJDQE86i3PCuUmTzzpHfP+Bd20UKEvlb25H1544TVMPvZxKcT646drg24=
Received: from MW4PR04CA0188.namprd04.prod.outlook.com (2603:10b6:303:86::13)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.21; Thu, 23 Apr 2026 14:28:38 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::e) by MW4PR04CA0188.outlook.office365.com
 (2603:10b6:303:86::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 14:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 14:28:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Apr 2026 09:28:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Dillon Varone <dillon.varone@amd.com>, Gaghik Khachatrian
 <gaghik.khachatrian@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix unsigned underflow in SubVP vblank
 schedulability check v2
Date: Thu, 23 Apr 2026 19:58:21 +0530
Message-ID: <20260423142821.2445169-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: a04a82a8-2936-49fe-5b49-08dea1449bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: OBDZBBbjZJ1gZV5l+RjVmt7rOSkkprBFKcEy8BkZKVSJLLO9XaaswP7XJhZtkXdlW7IM9PdepTumnzfISaOFubjqboVYfy26G7/+zdr1RqpGX5mgijCbmRMOqk09D/Fb8Y1WLPqi7pdLGzdpDDktQTM06lEXB2JxDbjSw672bvotH7RuQaPZUAYJLji0UpeTZON06UT9NajFvln8pznMKqJJJYirkX0TUUPdrKu80+w2p1/MJrUos/SiNkp2D6LzYkxbuKpo3X0LilZKEQE3VeL6CAB4qkFwUPuq88li+8TcaGmVJj1XFY518J3mP5i9OXmriD1yxJ9ettwvwjFXYwhnLkeipkDj82L7l4ZEPTAY5SK/TErQYGo8dCT7WotTFaBEWCx4Oec/FwJjVDs+zct+5GITyvnbvxOI5hfDYIzo52HIJtBKW1Rtw/3c4Hnrp2lG9UoUGyHdTjhq76fTEmcp9j/JY3wBDWCg5nkdMM9YZ5qAkQj4NVa9ezSwd8Z7C4VfoKwLOYob1k+PgaTujHot8n5JJnEjKsZVAJmCiQMO1KENN+XOS4TV/eTqpxkNnHeiyThELqyWBgd67aZbXrJ3QmXLWMug4qWCUCYfp18a4k0/0rU0o18Jcb+RJ8wN5ZTxfgYbtsRIYGMDg/uTOXudUILxzK1G13HZRE7Lq5RR2bOTVHW5ttmxyTgXqWg/AZdyA4UDXP7eks5nK0+pWMjVbW6rY33tOGpSCkDDokbc+y1qtKIxesJiXbL0GUpjMln7FlSJHv8RMo/ljoAWcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3fZzFfcME7+8cWKMLSg7i7AymNYEIDnu6BZjXy3Jd9PpPiG4Uovbz+nWBpcS76na//7JxoVvOkiGjl0GVD0a+JX+OQMYGqOZnVQoceyVKum7W59ppvtIpAQFQ8fzRWkZV9Dum599spt0nHkZydhBFnnp+w14neLV5MqdehtRPg+UWiKAYLrxtOGOil1kuXAc/Jx2APZzoqHst0UilYe7v4TWw1SnQa5mN0x+LDas3lJTQLo+idzurXjj+GrCcLpG5DlVeTqyFgTGAzZwR8iDMMJ6ev/WLQw+Dascmdmc2KuHaKxbTaJ4Rxff/XjCNRYgYSO53/m0FHWgCtT2IEJ8gNLUh/j+5AnN2O/a0WTz7S6pCa0YI2a+NRyBRSEAW/68X8yJM6xv9iKzoh1dK2vhtyYn90LzmPX3wq+orEfJMs0MQiraAMQodPRhT11TlpvD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:28:37.3847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a04a82a8-2936-49fe-5b49-08dea1449bae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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

subvp_vblank_schedulable() checks whether the SubVP active region can
fit the prefetch time, vblank frame time, and the larger of the vblank
blanking time and MALL region.

Commit 06503cda03a3 ("drm/amd/display: Fix dml2_0 narrowing boundaries")
changed the intermediate timing variables from u16 to u32. After that
change, the schedulability test:

	subvp_active_us - prefetch_us - vblank_frame_us -
	max_vblank_mallregion > 0

is evaluated in unsigned arithmetic. If the required time exceeds the
available active time, the subtraction can underflow and wrap, producing
a large positive value instead of a negative result.

Fix this by comparing the available time against the required time
directly, using u64 for the accumulated required duration.

v2:
- Use uint64_t instead of u64 for consistency with DC style (Dillon)
- Make all terms explicitly uint64_t in the accumulated sum & use
  single-definition form for required_us (Gaghik)

Fixes: 06503cda03a3 ("drm/amd/display: Fix dml2_0 narrowing boundaries")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
index fe667aea6ec8..4543a60a0683 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
@@ -594,11 +594,14 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 		subvp_active_us = (uint32_t)(main_timing->v_addressable * main_timing->h_total /
 				(double)(main_timing->pix_clk_100hz * 100) * 1000000);
 		max_vblank_mallregion = vblank_blank_us > mall_region_us ? vblank_blank_us : mall_region_us;
+		const u64 required_us = (uint64_t)prefetch_us +
+					     (uint64_t)vblank_frame_us +
+					     (uint64_t)max_vblank_mallregion;
 
 		// Schedulable if VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 		// and the max of (VBLANK blanking time, MALL region)
 		// TODO: Possibly add some margin (i.e. the below conditions should be [...] > X instead of [...] > 0)
-		if (subvp_active_us - prefetch_us - vblank_frame_us - max_vblank_mallregion > 0)
+		if ((uint64_t)subvp_active_us > required_us)
 			schedulable = true;
 	}
 	return schedulable;
-- 
2.34.1

