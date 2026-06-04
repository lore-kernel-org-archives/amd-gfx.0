Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37DCCD6E6D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE86112843;
	Thu,  4 Jun 2026 14:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DiBR46A9";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD1F112843
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGP1PN92Z8HtWH/RLPROXx4aQyiMt5VYunUdZ5uC7DrPnpo+0k4V0zJOvIDcip5UrjDxRmpTq/k7jkVKtPhNUpbdxAgyS4tUcgSKI00U9WZbp9sJZJoRVsTAirT1uAri1AzXkK/XK8R8JbGg7gHw9Jw/pLmwRIPm+XBYbcIdo+q2+YufAqxm0kMeLajiqSCFOhXgh1nSjuMuj53oYTLzNG5TqTs22b61Fm8OVNzdK9ovHv7IBNxCLtO4ZUIERBL2sdFVfsDfTth3ao5wS9ZzVC3RFJnjn6Bs7CGKkfHKelEx9oYWBDvow5tSFP+L2N3oInsru7YuklX1wMexvY3rnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYSrFQ1wD/awMPNomaHNaJEIKvjw2O24H69Xlzon9z8=;
 b=FyFjCI1ROdFgkFLoN9b8DaI/UVP9nIuSYHhl4dRWpMjFTWkPJosLO4cH6n5Ru2JO/W/iYfCnQfajvWxGDE1j0yyFV01jRqURXBLbs7Apuzcq5WYzG5Y0tqmSGM0et//XbAQpy4fn7Dbsanv31yYS0oWv8PzY0nY/tqR65okqO6HYtGxmjwaEd4Cthas/7g1P3XDjaYkv5Rl56Ns66tA7OWtqHvhKtNOnTPVqvoE7sohT7igFkpmQ+Mm3sPGcoKzs5BPxXETFaCb3pg+DsRpL4kORiyDA0IvtNwMWwsCoCRE7D7UYoMP4i+1Qoyc2WbPNt+rmPbXHiA/IrKRPjoSChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYSrFQ1wD/awMPNomaHNaJEIKvjw2O24H69Xlzon9z8=;
 b=DiBR46A9N1hAII9v6AiQrs9pDuqXEspJpDJLC+zmDP7d7algiMJlPLY6ZR/W0EOExO6ouIjT7iVUopOAr5Yp3+HmxG5b627cJoKEYRXsSil+KAjBgiB4dpikyIVS9DDOjedYLBqnkyT2MwiDN5IFoxlTqPcTdTreo9XnIT5WL1k=
Received: from BL1PR13CA0434.namprd13.prod.outlook.com (2603:10b6:208:2c3::19)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:55:16 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::1) by BL1PR13CA0434.outlook.office365.com
 (2603:10b6:208:2c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:06 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:05 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 16/24] drm/amd/display: Remove duplicate pp_rn_set_wm_ranges
Date: Thu, 4 Jun 2026 10:52:10 -0400
Message-ID: <20260604145428.809959-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 960cbd16-c80b-4a86-febb-08dec24949de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VJ71pxEC5MyUUegREvdDaW6Qgp9lPK5Y0DZ7epX64+Zx9wZht4dwMqrlnBCL94/xJ97vID38rbC5T2LznZOqBXKERcZukytICIOdDfRED9QBJT5LkjPQZOLYqEyOeRaEdxT5uLc1+B/10MAVCFi/1AeVIsMmtEJHtc6VMcnYqvOoVZG0XJQigXyQ0Ra/wmSPK5NBT9QxutUtwihsOPogXcrZhTtbIdckNTyQCG0qguteBgb814tKP6liePKIKLSU8r2+wKnjAYyDyBWAQU+HqPWdO+Yn2C1fWuUpDUnDd7bkhTPrE33XpE0hnVMZEFiVnbY2J6TvjGOFeR+6aGZ/cyjFUylZKh36qw1kAeBzwJJbXH3DbUomaYJOyVjTnQA2lyeNsDQ7/wiCnNp6joVLGzo770AkzvY69aXo2i3WtDMbJp6uxb6tl2pIJwTItymhnX3Ie6UwgPuTEkJABp5/PIGwsjbAO+QC0K+sFAoRRehGkROvdzkTv0cWt1gZnAi20eeUDKkAhw2fa9x9DpwzOxb28K0JldlOqGgMXRLuiltmcvsQ8h/b7XZJtc8i2s3tu02I3QL6EgIu2g39d3ZY4oi5R9tqUxDM78Ra+qw9595KuOFXyjIjlOJSd+HTbS9WnvwGo+sq+VHZd3pjapKwCzp9oPY8BL7iJM7m3rYm+V16UP8ypRKnDil2orUa8+RrK1jV8lNkJEzAjwyooXtazB+dyheuaH55EKccXC72mCs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IEBW047k/bHcKMZ/MGvqQURoyCT305neNP3Fw1SAmxuZ4lbzIPo26709kkoYWbGilPnP4EbaSL2PRIUEXR8wD0N4oEWQySweIw7VGs1oYLmq6MsrKQv2vXPh66KR8CQtyZ1BMT3940Cxx5WAiXQtWVbHISJCyGpmTC6KNac/oa3jIQhUmDYtjdHozynlkHDFq4AG/38S5F9irgZW1tcBDUQx2i6FKxXOLiXulIxJaeE6qkMoCEzYei0y57KJ3UookAkjVj+ZMa0YsYbXEH/akdTTPmlEI1MuYx7rq7Vdnjd23MVr0lK7dc9MHEeIskayhKwn5hA1CfpZkADDQ6o26alb9pytK0Il+5KP34M5WjG9azmPxCMzLCuNRCByDSLUBPFy86m9m0rVCytd88guP8uQMRNdAZBNtbedrscKn8BIXtkfbVKgObC2B+826Xby
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:16.0582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 960cbd16-c80b-4a86-febb-08dec24949de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Remove pp_rn_set_wm_ranges and reuse the identical
pp_nv_set_wm_ranges for the DCN_VERSION_2_1 case instead.

Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c    | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 2cdb8fea504a..2fda6fbed88f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -686,17 +686,6 @@ static enum pp_smu_status pp_rn_get_dpm_clock_table(
 	return PP_SMU_RESULT_OK;
 }
 
-static enum pp_smu_status pp_rn_set_wm_ranges(struct pp_smu *pp,
-		struct pp_smu_wm_range_sets *ranges)
-{
-	const struct dc_context *ctx = pp->dm;
-	struct amdgpu_device *adev = ctx->driver_context;
-
-	amdgpu_dpm_set_watermarks_for_clocks_ranges(adev, ranges);
-
-	return PP_SMU_RESULT_OK;
-}
-
 void dm_pp_get_funcs(
 		struct dc_context *ctx,
 		struct pp_smu_funcs *funcs)
@@ -743,7 +732,7 @@ void dm_pp_get_funcs(
 	case DCN_VERSION_2_1:
 		funcs->ctx.ver = PP_SMU_VER_RN;
 		funcs->rn_funcs.pp_smu.dm = ctx;
-		funcs->rn_funcs.set_wm_ranges = pp_rn_set_wm_ranges;
+		funcs->rn_funcs.set_wm_ranges = pp_nv_set_wm_ranges;
 		funcs->rn_funcs.get_dpm_clock_table = pp_rn_get_dpm_clock_table;
 		break;
 	default:
-- 
2.54.0

