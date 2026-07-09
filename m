Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2359C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D11A10F701;
	Thu,  9 Jul 2026 21:03:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ktpzpROk";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5596210F70C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZp9OWQ1Wnrkv+8gwE7U8MbcaiRpUJpQD98x5Be3eo2kFCbzBUJYd2ikTJOvYlyaZlv8pDMwstV8Hx0Cs1apqBAsnnhGmGQVaXZsFXZ3s22GPSSU3sWSWjNxGMr1QYGivFYPHmFexsZhMrQAzb65d0Wesug6+uRTuFHC0pZ2GahjQ6RON3KEL7OJ7HpemCLVzuSJ6Dte+I3jk/CHcXp+nQdr7zf7n6SSNxTzda/uBMIrCbhzAYjFmKK/0/oIla10Dmx87SsI3OAwkuOE8v9BDJBDxuZ+AxuBeQElR3qpN19tNYsdZE1r9j4CH43oU+v91wUZskBakMGNdHKr6d6FkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93SvPCK6tpvQYPRoo5gMQ819IwuKm00ZmAc4eLf3TU0=;
 b=fFUibhE0PAY5LCPQqcunst46ZumG7ZEIRK5Vo2svPc3I4ny/bbSBXo9hZL/bgqIdzVcDaFZMGyUYU0vQmLn2AtsUy8GOb8XZJFZTIknhiepudAE0+mCx05Vi0oYoI5UdvKQhcgBS0v9dasBHb+KSqruqXhISQYOs2YitvvidWvfLx6tRVsKlvyvU2BCeAfSIwdqu0e33hoShDZuoS+6xGmksmFJAkmaPgXMhk4n+6dCNfFsvOqbhsUMO2oAKMX+E7HSZQ2X7wvi0EvclwpEgPhhwADTk0+YlynEdPcOBfIOUoYLYNE1HumsqwQg6/U8slgX2rwFyn+zuPTJf0zrp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93SvPCK6tpvQYPRoo5gMQ819IwuKm00ZmAc4eLf3TU0=;
 b=ktpzpROkAQMJWJUFQFtReqoQ4k2PkdoGKahiSFlbS78gT6yTZldJYat866oXFY8QYzhzt5llBbVWT9F2TlvY5shcut65QgBECMvhe4bN7+IcSU/qWl/DtzBvgr7jOkjZ0LJKqlDlVkH6/25Bgf5LFiYk0BrYDzapTG8tpwtED3o=
Received: from BL1P223CA0034.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::16)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:39 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::5c) by BL1P223CA0034.outlook.office365.com
 (2603:10b6:208:5b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:39 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:35 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 77/80] drm/amd/display: add DST_Y_DELTA_DRQ_LIMIT reg macro
 for later use
Date: Thu, 9 Jul 2026 16:48:45 -0400
Message-ID: <20260709205936.5719-78-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: f05e5275-5f2e-41a7-9aca-08deddfd6967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: +AyRK0TxNhUH6Jweah5nz6OTRmkUnswNrf/cvZrJwzmMEiS0zxrp5aoiCyGtL8YK8JLHTtcIvl6/naXko6wERx+icPwMeM6a7QtQOJhbLKfHLzfWTLx/DXv6GuULXr8jUnsickWqXB03dmnTk+WV2+tGDjR0rsFlh3tQ7hzifj9DbaftiOlOgbyubCXhoSgMEW2QDL51/p09AvoVyFCot2PpWNoofvASEIBfocm3qojtXfUgS9STJmRNCtkB0ou/7qhO38hk2g3xfDFMe7BxYb7dCUBj/pEA7/tUJ6uf3BRwaUsYRYpkpUUGwp1nY/+ZJvM5Wb4wUYdrJtlHFFC+g2ekVqo/VIuQC1E+VMUWirVspj2UKuyGLifnejTcue3fbpOuiN8mkh88Q+O7+DFPl9AAsFZNAS8m8+KN7Www0jkEqrl1Y6INKeD4NOzOAoZVvlx5W0Bw7cgzmuHpHhvdCgHMJGaQUf+j5in3YY+fJrJZ7pmVInjyvcpIzeOCgbNKanjNILAZknAX9M2RdDxi0LFvmEUk2rxXznV7HFpAmaKD0CcosBHN5f9aY65OR4QMqpNRrIc97whR96/Bu0SI6gX+pnsuYwgJtlsutkS8L6KV7+07/bl+fBbt2B6BNC/tbPWm9CXWPDiCyp+svNAckZssMki52NRQCGiGoWcz+/txVR88Zabh0YNy7kqH98Oglm+fgpaK6NDnd3DQ2I+TLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lU+78v4UXX+hEe6b6hVuVnrNbr1H7OXbHG4ZIXQVlLE6B4bgPn0UX52PmMagyZcalK4EZe92SG1fIGGpuL+oX0WjSQV4fTWrv/qmxxDrbRd/ZyBRku6ijsE9kdfnf3Cet8wnj0uMF2VFgff+EGmY7pNbPYCf3tEEjNp1Y4N5whUUxqeHJ1t8M6y6nN/WKX1RhC+uGpZVunzeKqGrmDSGnokctTDpcqSrMlTgQdot8blIIIsOjEU+V02icVfyyiBJobFh/PCRxMnYIbjffCva1AtvK61ASkUmxRqODmb+xmhLc8EkO8d7ZhjkNKDhrxB1VM5mh3FJOIOnAyhAhRhGtsO7S7VdblwsNmsRTxawB5cBKU220CFF/OBSbmDO4OO0lsLhvNM0bDLjkBVfH6SZ90lX7cPmOZ66cLWekfer2Bd5QgBKVz/CjvvrjRh9Di8v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:39.7616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05e5275-5f2e-41a7-9aca-08deddfd6967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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
DST_Y_DELTA_DRQ_LIMIT from dml2.1

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h         | 3 ++-
 drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h         | 2 ++
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index 80be394a8852..2595c6441f00 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -286,7 +286,8 @@
 	type MCACHEID_MALL_PREF_2H_P0;\
 	type MCACHEID_MALL_PREF_1H_P1;\
 	type MCACHEID_MALL_PREF_2H_P1;\
-	type HUBP_FGCG_REP_DIS
+	type HUBP_FGCG_REP_DIS;\
+	type DST_Y_DELTA_DRQ_LIMIT
 
 #define DCN42_HUBP_REG_FIELD_VARIABLE_LIST(type) \
 	type HUBP_3DLUT_CROSSBAR_SEL_G;\
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
index fc30afd4c912..27528f82058c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
@@ -35,6 +35,7 @@
 	HUBP_SF(HUBP0_3DLUT_FL_CONFIG, HUBP0_3DLUT_FL_FORMAT, mask_sh),\
 	HUBP_SF(HUBP0_3DLUT_FL_BIAS_SCALE, HUBP0_3DLUT_FL_BIAS, mask_sh),\
 	HUBP_SF(HUBP0_3DLUT_FL_BIAS_SCALE, HUBP0_3DLUT_FL_SCALE, mask_sh),\
+	HUBP_SF(HUBPREQ0_DST_Y_DELTA_DRQ_LIMIT, DST_Y_DELTA_DRQ_LIMIT, mask_sh),\
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_ENABLE, mask_sh),\
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_DONE, mask_sh),\
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_ADDRESSING_MODE, mask_sh),\
@@ -54,6 +55,7 @@
 	HUBP_SF(HUBP0_3DLUT_FL_CONFIG, HUBP0_3DLUT_FL_FORMAT, mask_sh),\
 	HUBP_SF(HUBP0_3DLUT_FL_BIAS_SCALE, HUBP0_3DLUT_FL_BIAS, mask_sh),\
 	HUBP_SF(HUBP0_3DLUT_FL_BIAS_SCALE, HUBP0_3DLUT_FL_SCALE, mask_sh),\
+	HUBP_SF(HUBPREQ0_DST_Y_DELTA_DRQ_LIMIT, DST_Y_DELTA_DRQ_LIMIT, mask_sh),\
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_ENABLE, mask_sh),\
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_DONE, mask_sh),\
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_ADDRESSING_MODE, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
index 3e4d9b188b26..f2b98f1574ed 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
@@ -581,6 +581,7 @@
 		SRI_ARR(DCHUBP_VMPG_CONFIG, HUBP, id),                         \
 		SRI_ARR(UCLK_PSTATE_FORCE, HUBPREQ, id),                       \
 		SRI_ARR(HUBP_3DLUT_DLG_PARAM, CURSOR0_, id),                   \
+		SRI_ARR(DST_Y_DELTA_DRQ_LIMIT, HUBPREQ, id),               \
 		HUBP_3DLUT_FL_REG_LIST_DCN401(id)
 struct dcn42_resource_pool {
 	struct resource_pool base;
-- 
2.55.0

