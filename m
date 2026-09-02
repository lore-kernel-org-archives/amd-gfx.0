Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03210C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FD810EFC5;
	Wed,  2 Sep 2026 05:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WwrDmAmz";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDFE10EE14
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgoRipNvFAla7CwjvIuSTSvves2i99gIL+WUbcxr9aIwM5sjiJ8dHym7a6uPlf5U6ijOxGIdMBuS5f3Zq680huUdVsU4XZZ6WPGc6jui6AEoSjkYnRv9O93r3yubN0PXR+bLdtrV7ap2q/QXctOc1RDvbQ+drIomn/6QjE2gf4397FwKASQg4PFzksjbpzcNIwOEI2kvSIqGdWvyhMOqXWAjvv1GEaA6kEjhlbUoA3tYd4WjTIAY4FQ4ZitDdchM9uOGr4GJFA2l7fupMkbLKav8Z1MEQgZxgB5fytR6kpnvIP7+UvGJOtZ0xhswJUEK0sgvolSGVTmKtbkagMLSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CI3ObvhH93gNmQbm1oAFhcMHvKZAa63Ag9JAgXcmko=;
 b=EhYdu1gRKBdF5ZyHsx380bUbqaJDWMWNpua2lcKLe21Ph32ACM5wrW6XXPPqiq6VajMzGsRQasoYSxdk2VxsKyfTTIWBQqntnwjKsBg+Tlmh/PTLGBsZgeuByCJb0zPYW0148n/0Vhkhu+wKvh7t2gqc8UVaxVJj2QWUngmT5jDbjbK0i3JFSKCf+G4YD/iZk4c6rE8a55v8dOzZk6ikznZ/xpAC4DgRpe2cc0Jyn4jEjcbvGh/W0G++S1cI2sZjRpXc5GfoStTq5ThZ7rBdU05q+dm+D3a+s+22lHOJx44590u1CVIf9/bZ27b+WrtKkjlmXgpv0E//BZzvhgr2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CI3ObvhH93gNmQbm1oAFhcMHvKZAa63Ag9JAgXcmko=;
 b=WwrDmAmzYGtOdmKvzqZ/XABQ55FkKehfv/VcEfiR/DDx052tUfRmQ4DAHQl2f4qkPKv9mhQKc89vpnobr3myePyRG4KWBrpfo3BqAc/V+Mg5wTs/SJByjn+WDboaeWuo/V4VKx9B/42mJkSODUwY6MpaTJotNVk9SEwG4PDDjxI=
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:06:47 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::8e) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:06:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:46 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:06:37 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 16/40] drm/amd/display: Set mpc_tree_params->opp_id during OPP
 resource construct
Date: Wed, 2 Sep 2026 12:58:38 +0800
Message-ID: <20260902050411.3473916-17-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a84fee3-21da-4f44-3d28-08df08affd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 5/xFDClQ9AulNIoJ7r/tayPsFD+TINWc1nKeFPTJ5e/5apHMnsa6fDIRfpwLmTs6bhgbVw8IMPnaxuy6Nh+VCGxUU16oiFytBhqZOik8C/lfcxYBsEfpgQboOnhXpJ5mVLf8o1QcWA/6s64iqmMZc5Fj1ZbiJQlKTF6eJvvQ735Ym2NeZ7ZsJqNZ81pTAyxc5ZFkyeLq3CCwvSQJsABkh66oeM/NpSVOJYr87K2+9W4JUR/yFHTiv0uxRP8jchOvrxbrzXlRtEZnvB7sZrTRvQF0RlnPixCAxq5u8AaZL+A5AadsSXVhuAxlYeZML7Puq7OLuXh0U160iRv9oQHVf4losZVzRHBzE8TZiCvA5C5xGlwhwTRkk7L2QVfU4AMRRLhXR9wosHQGWl0K4Iz5Y90CMXk64VpjzB/bFRhcBE9NHvmxgIechNeQwX5yB4ZO10TsGm42eJ7aaNPfLwC4NSYv9P+TfkhWtkt9JZvyRMJUcgtq5rJwrf6vGHUYZ5Zo21JSBvWT873JSAPuIXsDOwO26//D3+wlRo7oxd3NaRJPgx18cJeAzE2enPmrRPmWNODdR8rj2s3Pyb61skvHBduO/C2ys/5Ts/N2gJkDdw7B3PpSrvrjlJRZHeFYyJVqv7MgXdxTCSz2YSPJvqX/fME25jOMFYmZEWhYrVMC88JAEGuDKC9YfW1Sc95TKN303pEZnnTP6oxr9IB56tnUyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fHdKqzSntR7paRqOpyfFyZITW7SZdKi3FWq9Ohx6QPKqmUAFs2g6Op0fS2knTJwNuDTVDubqRKahuNbUGQ4TPyrLntqrakbNg0P7QFD1LoJllRuzaHV/jcMyeVVF6KVj5FzT7rizf4Ll4DiyFTyFzCHJFTTTGLDxJImoCXv67qtL1BmpklAG58sV6dpsVifQtw4pG5gW3nTULXork4sKrOY54zxrgSyUTvbS8FZu0qiqTZPa4+toNMYtfIUzDayoFaBpNr36SULfx3rQIx5lS3NgMyoz0UrT1nWC5xJEjfZBaF17r0rwu+I3rTxErIKuOMUopw4qClC9uXCQj7hnUG3U8N6yP3mxj3oL/90RsLcVXqM+VBqOlMpPnMZHeuAaSsq128RsE7rcK6hsOWLfzRC0K+b80yzud29y0AzDL403Vnkq8qr3voF0JK/v5Guy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:06:47.3792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a84fee3-21da-4f44-3d28-08df08affd70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[Why & How]
Currently, init_pipes() is the only interface responsible for
initializing the OPP->MPCC resource for all pipes. However, during
seamless boot transitions, init_pipes() is skipped and we transition
directly to an ODM2:1 config where we end up programming the default SW
struct state of mpc_tree_params, which is 0. This results in a config
where both HUBP0 & HUBP1 are being fed into the same OPP inst, 0 in this
case.

This is purely a case of programming incorrect SW state initialization
values into HW, so fix this by initializing mpc_tree_params with the
correct instances during resource construct.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
index 881b8da656b2..8486175a3b56 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
@@ -455,6 +455,8 @@ void dcn20_opp_construct(struct dcn20_opp *oppn20,
 	oppn20->base.ctx = ctx;
 	oppn20->base.inst = inst;
 	oppn20->base.funcs = &dcn20_opp_funcs;
+	oppn20->base.mpc_tree_params.opp_id = inst;
+	oppn20->base.mpc_tree_params.opp_list = NULL;
 
 	oppn20->regs = regs;
 	oppn20->opp_shift = opp_shift;
-- 
2.43.0

