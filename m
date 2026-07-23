Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5EAC531F7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E98610F1ED;
	Thu, 23 Jul 2026 20:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p/pTZcMP";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDA310F1EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPXqHR49gt1iiymxpK8t4aKmiD/gW20dSNmipq9qI9LHkmpcNv6oDRoLQOetEnrWLhk8AqnjRMwCrAOcQGrROIidWxEhEeOfinfGmlWYOp9HscIexrvzjndww6aXH5aDB9BPafnh+yEg4G02+WNVcl1pzuDQKhZsNKJBa9H96+lo1/q1uuLTVWVEWnzZ2/0AI3PEabL9BIC+IWwt8RHD3gcL13l5AnsoHP1uVNvX0OSgLfEHnVLKtZo7br9jiujQVlUdX1dVyUyaoKAMMEqoEEXOnA1rle08jq06XXuwJ7xRFve0UGs/ikEgO5oy24CWhoxqRNobqDvYm2sBo+92Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgEbTzOhhuKMFXqLmc07ylyIHQcrtIwHinbeSoqnuuo=;
 b=wW3QvaJAUf2HeA9jWtwf22cIYbTcDwRLVL2vLujTEf4tkYh+D+cofttjMpttufCu7h0m3rX11q+aIwPn9yL/zKA25X2EO4PzDV4x6BPHMd0jZ6DK9LxaOiQ9NiVxnGb7e45XHw0i4tlk1I999cGpyjZiwXnAUm4mzeDM6X70pNOzL960s67/YD7BRxwqVKj1cdxVdetgRRvv0i9Ozn7YLf9tWX/HM5qSNMInprT0EcUy9i9x+5sukgKGWoMMFJzJM5GE1GwYGsqmeVi2MZpzZBges7HX+0Q1lQzVbMscmOtk/ZVVHjM0a7gHdxUBXgsEUn5vHsd+2jhg3zVyreMJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgEbTzOhhuKMFXqLmc07ylyIHQcrtIwHinbeSoqnuuo=;
 b=p/pTZcMPUER+ruqgd4jlCHYWLGn+6dnXRg0EkA41x2FSq91kH8Y0pCmwwj+oYnuRYdlk6KQYr1z4ZYizjGFm7L3Bb+NR6yIKuUS7zhnpgvmDT4YwquY+EPXUKjfFaDfIRCJaEKefSXFzmUjC5jKhIusAfzzSiL0Xtfr0bn6rm+w=
Received: from BL1PR13CA0387.namprd13.prod.outlook.com (2603:10b6:208:2c0::32)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:50 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::6a) by BL1PR13CA0387.outlook.office365.com
 (2603:10b6:208:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 20:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:49 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:19 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 42/49] drm/amd/display: change dcc_rate from 1 to 2 for log
 use only
Date: Thu, 23 Jul 2026 16:13:50 -0400
Message-ID: <20260723201908.373300-43-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d91abb8-d5cb-47ae-ef55-08dee8f7bf7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|3023799007|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7IRjbLgYXoTvVNArXYyUNDa1GTk/Soe/kEovQ48016doVlcn5GJnLZtd+cR85XG0gkg1Acfm8zpJSldyXy0TJDDaTNShXCMJoNl6sMQkNt13XRJG0Pt0b8kJuUgIIdGeAlYZ+kdwIiarqmbesdgUhQj0WMIfUR4whdtKyeih/LZOSRTTQ3M9/KR++J8d1oPCVA+2J/0LQcxiN/QQ+1er34/PXiA4/LbPIwc87eMrEIwQTGyYhTk8+mblNaJPflEwk7H+kNrACJQ+7xmtzIC2iFtVbbCLrlg+TtPHV54bB7g+eb/MQvzdJ/Gbikx7cdw/+YZVFZaILNdkkk8Lj50/ZcEJm1M+YbxqqvR/7bTOeuipXK5LqXhgWgWNDb+n11GL8USHyhO57FMdtuhWQkH9koLiv4WeKDjy45vyXD5TFyPFfcg8MH1lOFpJD4Os2WjMRuGaSLDuBxaXzoTLQJmxAFKXaCPPa7+DWploZke52kK+T/1JrLI/dysKxdAXvgVUnCKc7xva/2QcVZtVCg5ptpgqkFr6aAqBZo29zlbeKNJIzToGj5WLmzsGfDmT8FZ9Ix5JoSK9rWvwQu60QXqUT0RqUJ3uEECim55HUJcoRKjxcEceu2igPupFuxVI0mfr5WcrqKRIvz5Uy/yRSbQUbIPX4Hn2pg3vdAn5fpbf52bIZtJ60mdsAPZ39GL1dd3pO59VGk9hTPKJlDZU6FuRRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(3023799007)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tMC5/zWSNx/k7Mr3KHHu9cCTXMAMKU4YHDcF8g6+iSy57tIO5Z18FcT4ofI9rHMBuErd4MZeZpLvpysLCSIYStnvkn+R2ShMq3Y2+G5ObdI4gXhCHXIFPx9aRHHL80g90SzIKj4exdv8iP5fEFekCULm4ViHWpmye7wWMyQEAQmY6qLp4mzrY96zyBBypA+AZOWvK8jv8uPCvxutSmRcs0y1MpjV3pY3AX33gM7wFyMwjPlQ39BIyb7In4XT/3H8wHLfyvQEexA8Yoy7/ETF6BX3aZoQFtq3hriOLflmfv5cNJNrc45yL0fFd1wpn9IjNYKRcx1tHAwP46tIopSV5fGZ00d4Rh9HaitmOl77ZegkgLY4Rsn2rB0hdFMUgVRqMGwC14B6dr42PFk+Zp8Nzmc+b67gsftoqJkjW7ItTfvGadIXrMGXLoYAOWpKeO/i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:49.9869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d91abb8-d5cb-47ae-ef55-08dee8f7bf7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
The dcc_rate value does not affect any watermark, TTU or DLG output; it
only affects the Z8 stutter-related logging. The hardware
DisplayModeSupported formula uses a dcc_rate of 4, while DML2 currently
uses 1.

[how]
Change dcc_rate from 1 to 2 so the logged value is closer to the
hardware formula.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../display/dc/dml2_0/dml21/dml21_translation_helper.c    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index a76dcde1efbf..47164fa150d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -447,8 +447,8 @@ static void populate_dml21_dummy_surface_cfg(struct dml2_surface_cfg *surface, c
 	surface->plane0.pitch = ((surface->plane0.width + 127) / 128) * 128;
 	surface->plane1.pitch = 0;
 	surface->dcc.enable = false;
-	surface->dcc.informative.dcc_rate_plane0 = 1.0;
-	surface->dcc.informative.dcc_rate_plane1 = 1.0;
+	surface->dcc.informative.dcc_rate_plane0 = 2.0;
+	surface->dcc.informative.dcc_rate_plane1 = 2.0;
 	surface->dcc.informative.fraction_of_zero_size_request_plane0 = 0;
 	surface->dcc.informative.fraction_of_zero_size_request_plane1 = 0;
 	surface->tiling = dml2_sw_64kb_2d;
@@ -517,8 +517,8 @@ static void populate_dml21_surface_config_from_plane_state(
 	surface->plane1.height = plane_state->plane_size.chroma_size.height;
 	surface->plane1.width = plane_state->plane_size.chroma_size.width;
 	surface->dcc.enable = plane_state->dcc.enable;
-	surface->dcc.informative.dcc_rate_plane0 = 1.0;
-	surface->dcc.informative.dcc_rate_plane1 = 1.0;
+	surface->dcc.informative.dcc_rate_plane0 = 2.0;
+	surface->dcc.informative.dcc_rate_plane1 = 2.0;
 	surface->dcc.informative.fraction_of_zero_size_request_plane0 = plane_state->dcc.independent_64b_blks;
 	surface->dcc.informative.fraction_of_zero_size_request_plane1 = plane_state->dcc.independent_64b_blks_c;
 	surface->dcc.plane0.pitch = plane_state->dcc.meta_pitch;
-- 
2.53.0

