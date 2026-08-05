Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6111C561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5600110ED07;
	Wed,  5 Aug 2026 06:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aAu1Q8tp";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E0710ED07
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWj6aKg2HwSf78ZCbYlGGXJEHsrsjgncnQcGN3xdahSkUbVFc6sgZGj3XBCoU+NF4s9nGt6jUWdxFVt0OwcWjLYucdslH8F8ove5WBFhenvMIJy1ky09xmpO9NwoduXUhi2rCPkWIYmh9JYQ3qlOmlkqvsOpAOP9UXtfzahYb+GJO8SOhKM/DV3toTNhRU0ETxoyaX1OZQEsmamF6RnXXNDVfdWuu3WDClzHQmphyF95SE90S5IwfeN0PO9JOmRu3PasddaYH9EERxqw8Dcp+e1TFK/kPo6WxS3vNl0XhIAn4vM2NvwvOcZVJX3VpClH7tXg9p0CONwRWQSSe2oc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jJRhff+IoYgj1pEHbUqrku2Jj5OaCwo2sfEOyiAQG4=;
 b=s2f0oxVa1UBvJ8q+BCFAmTDTkVROCw9izrp64V4ic0yCmPCf9e5eYlQVmYdnl+9vyM2bTLirLI0kT5CwyG9yOiN0stgN+ep52QLeg71D/pePks633eJ1P5x9TYLGztaGhiLVhyyPeF8fTYq9las+8CEQ5BR1bD2LWpfR4p7XIXYOf952ZrjZ9ksPfELUyAqGCxDn5ax+Wm6BWHpoDH5B0Z03UL8izaSZxws9SMYvhNKQQdCNeEbHYbAfS2ojoFuitxrjeWMCxJt0/ej+vBs/NXik1MwGtfE8n+wITVyijhwEugom3orkqmACDgqtKzSRpD0yGQRrhoXiZExZaK95bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jJRhff+IoYgj1pEHbUqrku2Jj5OaCwo2sfEOyiAQG4=;
 b=aAu1Q8tp4HCPjtgvmK8NeiDUwEO6V0PafeobEY3DXQ2IDOqnw6pD5SFF6tEsVud5PFiwSHgvcmAzcHkIP5WM8W2aPFTrt5bL566K3tWD2zcpUKg+jgnUWxHtjF720E2PUD4dvaNO8dJpVJG6XxgTjAe29SXumtlJ6fGlJqslJNo=
Received: from MN2PR01CA0037.prod.exchangelabs.com (2603:10b6:208:23f::6) by
 DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Wed, 5 Aug 2026 06:40:39 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::9a) by MN2PR01CA0037.outlook.office365.com
 (2603:10b6:208:23f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:38 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:34 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 12/34] drm/amd/display: fix HPD program filter programming
Date: Wed, 5 Aug 2026 14:36:24 +0800
Message-ID: <20260805063937.2145774-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: b37b795a-9a6d-4945-9dd7-08def2bc7669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PzZB+CxFKCAMf9JJ0QnQ14aCegWseyF5y9ouBsCHKBqqJf5Qj9S2CkgtFrZ54KXSZGBKNZnSCa352+5dTsPu1dmXVyvG/nhYYrlLN7n/6czc3qMCMkGswAdRChlfRtP/vAMSGWbFvz80XAuxHj+qEn2YQW0j2Kv4csGNCFJK/yVMov26edceSCn23VyY9tLrMHQvhKApcbmO30H7xCpQOCwHMD3Zc8MNA1mqew2ZHbjX5Gqcixgwc3ul/GG16l1exm7c0j7ltBBwSOyios+7XsXckIzkdhW/vP8tjDzAA2uJqAbl1Z76V5Lg1cj/xuMOCEqBuc2+FBFsu0jNtgcb1XvLdZi4QTY+Apb0y8tWvTGTMISPzEq9FBXKXSkI/22X0929Uo3+xD59vAMH2SXfKqh+I2VJAq/KYqK778wfJko+7qxd+o7TSZz5aMcCmK7ch95i1FBAyI47G6qbP3QLAo1FJ45Bd6O5R4SI+sQfqi/X8/ophtjfFY6yzqx1naHJ1tRXe/kxiOLK5f8dk8QZfnhATk+XNQo1+H/tyD1NwDVXoBogMoVuod3144nZc1Q4twwnSecUMjq8YXd1bvnZ/jSDbwK3RvtkKdTLM/pFnNaMkQo5jf/pH4JBWwYeb4uK45gBCcJUd9tE57aL7bHCzs1FIXuGUnVFpue224EeB2U9YRc43RYyOFTIJXj8HLNrVjulb4+M/Map3RJM9V7Jhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B3XUIwnspNe1qb0nMAIUAYFhwfhk9GcP4jyhkJs90d1aw26ypJFH5m3d5Aps+cHaho9mtvh7jypqKhrpkPlv1QIxJ7jhHA52fA7uDQmXTfXPmbiOqIy4HKkuYEewn2hIFg2N0/UAMPoNFvB798NjCdtZo6KF8RFVbM8HqALxjSo5nu92Efy99A23HOTbCraBdJlLx12y8SfYACMJ8Mr5skklRapUtvCbSXC8CDohrM3FYblU0c3JctkBXXQgH+YG/7jOBNv/+5DGKX5MxSp4Vk1dUCSObWg811ybV9f2qK1FVOgJdouciu8cRJsY04zezMi3qfWC56Z3zDE2A3UVlpv5dX0XDf5RM8SbSrUg8eyZmQkVn66tmFiYdrof4/I1uW+jIm5DWoONcdjvz+kTT4TpPG3KvcLTGINlpVW3v8IH+Q6HnZGin19cRe6yWMF5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:38.7173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37b795a-9a6d-4945-9dd7-08def2bc7669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
fix a regression when moving logic from dal_hw_hpd_set_config to link_enc:
Toggle_filter HW register programming is in wrong unit,
which caused the connection time extreamly long.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
index fae49b3b170e..50174aded6aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
@@ -58,8 +58,8 @@ bool dcn42_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 
 	HPD_REG_SET_2(DC_HPD_TOGGLE_FILT_CNTL, 0,
-			DC_HPD_CONNECT_INT_DELAY, delay_on_connect_in_ms,
-			DC_HPD_DISCONNECT_INT_DELAY, delay_on_disconnect_in_ms);
+			DC_HPD_CONNECT_INT_DELAY, delay_on_connect_in_ms / 10,
+			DC_HPD_DISCONNECT_INT_DELAY, delay_on_disconnect_in_ms / 10);
 
 	return true;
 }
-- 
2.43.0

