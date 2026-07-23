Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA54C531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DD610F1F7;
	Thu, 23 Jul 2026 20:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5Lq6AlS";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2914010F1F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKosWWEIGXNq4RdD/xHWh2hzio6wY5xaj74LckckAeZnlOpNtNoHYX1hy1o/qrRUmMGerCQkLrCCH6c4qAUDELrJoItTZ6wkRKo+1XiyQOwxQD2dhPPx6a97FwMsm6B+qbEeYVu+ltg0OhKhf9fPf813wNC8rLlpuQQoIIv7PyZw+dj67Qyg2YtwEXyZ4mv9QIMQ5HeYFSoTzJznWzzDYywNL3XqnbF7eyYhRj8tLV4EaHKcyMmV2Hpm88ric+gWyvymdlb1ueX/il2tfLV8vYVLshFm2y7pOfGI0mO5gbFwrEPBo4TnxuvrA+J3SPjwvCZSt1Ago46T4O6ESwUhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdxyN/l8onmTErXpot0/NiD8DaS6dUO47s/oCYwMuuI=;
 b=nUqPGZVA0KIbc00x3mFoTvI7S8LblAofvwstBI0+vxkUpkbibNBpNLnTjcA0d4GgkjUxDxYRYOBQCAfoj6f6rJ5M12pFGs1a5F1Pi45d2mtOmrGMayUCrh+kCNZWmDrIUOUWXgJp5dJgYfTyChz5kUUqXewXCl4T46eD9RwF7IySYjEz1QlTcylvb881VixNsy12mTvbMu2Gqz7WUubQQcZcYQoIoJWf39uvgYhZOOjfXC/aUDD7ZDZsHR62wqUq1oFPxEhZY4zXncX34invpkeTShUvNf7wiMDjW5hFvPkedmfbJf/9Y/bCCrOl9/ysVidU9AFn3bGaMls9ETgBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdxyN/l8onmTErXpot0/NiD8DaS6dUO47s/oCYwMuuI=;
 b=m5Lq6AlSCtU3LcjOSzlSmi18fj2F/wPhQ6BWMtx8Aj3Wmpmz0HFEozAJOtZt7pi9V4Fj6G/KpBQ4qCHz9ai09QRIZZ61flaUNxD/Qi8rFmKQqdNNdr8XPg+fyKtwNi7XBMb4xZfYh7rmMV7m5PRCRoWtM3IRxL9kSKPBMOmXweo=
Received: from BLAPR03CA0075.namprd03.prod.outlook.com (2603:10b6:208:329::20)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:20:07 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::53) by BLAPR03CA0075.outlook.office365.com
 (2603:10b6:208:329::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:20:07 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:25 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, "Santhosh, Ashwin" <Ashwin.Santhosh@amd.com>
Subject: [PATCH 49/49] drm/amd/display: Promote DC to 3.2.391
Date: Thu, 23 Jul 2026 16:13:57 -0400
Message-ID: <20260723201908.373300-50-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d97ee1-8aec-4ab7-bf44-08dee8f7c9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 3AbHUg3OJMhQiIfgApxcMheNFV3K6SN1CKgVD7B9/zZqrStAp26TlMNiR116WKYSjZfJ+1foGE+yZNccei3chmiCa8ZeqeIakvEasTN26H4kw5abJ6q6RumiM81uSZmya6nWHvn748tAIBn3JxOgfEkrekHRhkVJ809ucGW0vxJ8tWzmdOJRw36ohHOzcgAbYRIEx4Vy24Zpm9nK7O0inkUlZq6YwRi5+PMEgzVuaouGgjKUjG4Ny4hxKJCSHvgTWfAs1YX3EXDc9M7FT1woKX8uhG5vwAmoKiw3xHBC11V6+uSEW7tSZR8qPs1xRQ96dzYkln96zawtNHxqn2oRaSnvHeeih6S6+opLm16v4AkLFoHfvkAOOPSVm5vKJ/jKXEjgp+xCU5pTJmyRyr3v7b4QTxsEd6fdaGEMb9XMmGWPGJTXznbXwFpL1gRnIvoOOnDOP2MeqO82IG9kdSyUlRi2jyFsutvEhKYcMpFcY/nW4UBQeAiO01miYlp6PlvrIvYSEZww/hcQOWXS6l+T9RoI9c8rzv4tonN6GNzgcPELJT/l8BfHZaNgv6E/8MqR8sy2EoryfKWfy7mLOlndkurgGDTMm16AXxvsLnXdsxhdiw0ZJtmUD/vklBmEvvkbvE+rDgvBzE1X1Ck+c82q+SfM+eU85v4qfTU0a/fbCb6ZhJQIny1kt0BkAFQduvOQ0ZEFP+PbX+30M9x8jhuhlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kmMBqzZA5vwmW1xbpQ6pxHdB+NALBHzq8r8ALSZw/FCKwS5u635J3Eu9+tqpCaJSBURsZMD1ouczR1LaTdSTOmMhgjpQQesCSXe1m01C969eoSDOh/IfI4o78bXVRitcPMpJeOQuWbw86J8VmbkZlPrRcR08HhnRhGiNfW1bgNN2R9qw41eI1hZOFsRcQeoi05pyxOjJtZoC2tVVcZkD9+pSKPOIQI6LO64v7uvVQv5Mu/VzOPboEa8aEFytff9ydZa2bfjadJ5poJsrRVswM3ap1iV82wH6MPUzbyXna7QyoPa7kRaH9+Lm7Egc6VfPP/fRJevN1NlL+/KhYLmAX/cnnh4KdmX3SWT/LvYrmmNjvnjJNmv1hlxbRlLZTZ7R7X2Tqow99asMseO3IFndrCVJBVYbuD11ZGWuaUCLCV/TZo132YM6wZIp0cJnDlSF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:20:07.2426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d97ee1-8aec-4ab7-bf44-08dee8f7c9c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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

From: "Santhosh, Ashwin" <Ashwin.Santhosh@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we have:
* Expand KUnit test
* dm refactor ongoing
* Fix apple 5k tiled monitor light up
* Fix frl dsc upstream mistake
* dcn42 fixes

Signed-off-by: Santhosh, Ashwin <Ashwin.Santhosh@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8eaa219132a6..63c0dec85697 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -66,7 +66,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.390"
+#define DC_VER "3.2.391"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.53.0

