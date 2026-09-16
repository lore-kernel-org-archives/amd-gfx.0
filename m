Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FC9C88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C33E10ED12;
	Wed, 16 Sep 2026 17:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJ17tOdx";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B9E10ECDF
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+0AUnazQnG8lgpObfyCCincVC4ojwl870TNZhtrtx83jzC/1FLWhRxASk7H0MjBpwHvJ/5jr8uJicrkfZBC9k2XviUL6Q3pHuwV+0Qa1pti/R/L19kZWOanlNIKxESwAfGrNwiiODWZ3oLKjgbhxZveJ2fKBjBh4/fq5iNQpMN3VlGxIxIwx3IxneOWYaxJ0kkOkOYuDLEgserPzIshXB2G+gBNwZlZ92RzS/RBHKF3MRRs4XxB70VOofPCj4xmG3rUmNV3uPSZVNE2/uZPlEWku4GFJ7bJHVwPJZxpAY+U1I19vOyUwdKhFsN4OCs9ncVbb5qGhr6uWch2XdhZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rHIcfSm12zDL/Ee8PEIw+e3pfD9dcijH8pt/hn+BHA=;
 b=dDoyhldutSbC9v9ebgH6SexIiJdWkAptrUpemVVRx2CqQgUgZKsidQskkMMoLQFfQuwo5/pfTY+b/fT19JnVpX+CPv1SY99aHUMwTqNQjtBf6Ydj9Ngpm/y2Ib+fIeu7GWguiAOP+I5kCyKlD3ozeAccXOiupUZLK5k+7JfIdBiApBakUcASRbEQt47VAoa9H0CTI7GLBD4G6Z3s9pCfSQox3/Kqv8qBs1s6xwuUcgW8JaemzIv5CyYjAS+WrI9SAC86Q9mUxZ+LiYgv/gJbmass+h2u0tA1gX1ujEFt+9r7o/Y7/DZPoI0JM/vLG2lepAB6cl968d3hDkhlpL4keA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rHIcfSm12zDL/Ee8PEIw+e3pfD9dcijH8pt/hn+BHA=;
 b=AJ17tOdxrkNZ5aDRRigPD//n02yiaoxXCzEoxYGUQGym0HwdDJrl3KmcTx3vRXeuOyzmoGYDfGWGBRVMQZ5c9OVbeZi3vjWUzEM4cg1tyTuFVTh65DR+nscBzS8Zudz4/4BGjCz6hbopGrimaa6JWCFOByQcIlxjN96BTuSyeW4=
Received: from CH5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::13)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:53:10 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::81) by CH5P220CA0007.outlook.office365.com
 (2603:10b6:610:1ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:10 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:59 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <alvin.lee2@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 59/64] drm/amd/display: Remove DCN6 DCFCLK num assert
Date: Wed, 16 Sep 2026 13:52:14 -0400
Message-ID: <20260916175301.368306-60-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c61acf-0e97-4515-34b2-08df141b5f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: AqlFK5vnM+EQKa8qJ4mMCtLNZLI4OjncJ6pQQFinJpeVsyqhZM0qX2ZW+FiOZ8pjzj2Uo1kW/E7eoZaUGyKk0mXCmsQP3yYlxMMJIJV0E4WT3Dj/pQZ6qqn7ZT6ISIrZOtLiMgyl9tSQPwA735IldUvWsvqDuZ6QByIGzdrtbEQ6UXvNh1LjFAv4S/1Rn1hD3H+Lzno5rPRxcP7zWbHtG2rVx2xlTAOOBhmJ0DIDW+wlLZJlrxlrAxoBLqNZ1H54uMggLUmmF0Peq0XvZNDK3tzwEpOYUAAnnhq9o20uzK/pVaxLwNlE0r2fv/eCC38srH4PX6ayUSAGG4MqKy9T+5GTy2+OtaG5SNlj0gOllYzZqFSTc1PeVqzox/RUVJ6kLsfd7DFu1R0valxQ5x58Vu69N8sQlQP2Wax7ZkMkCGHi9bgept2moHtEIrpi2Z8mtJeynoh+DgHAiyGD6y3SO0VV1kLpXkDC006HpWbh+GU7zYtzP+Jj2Slq6aS9oGhFi7zwxs/ZokB3RSrpyzhzUH/IDUoqi0s721rWzn+nNTpWVzbiEJifSdU9Vzr6Z2mgm8v/w+ZGDYhjZofw5v6wuF5xgDMaGBRZA2quhudOEL7daOjgwJPfA62YtxL2R29eehTZeIEHEEC/09Bqo3U0d0UUVq6ExK7RA8ulydSLoUCzQe/FukalKwF3o4/SzCI2nHJm0e32yvelpsDZKDHf+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eC/N3P5SUhNFQr53WRv3g60hS5S08Wx1Dw98ABQ6k5MCkFQqRxe0Yo/ZbA3P65lI8Sj6A5kembE2WgrWjDhfQlFAHTZzT3GzQZG6x7dMesI7IE612X9NM2PGeTStTAMm1I5OQiFKH43b5Rfysys3cMYUmGilTFLjHvXVXQFve8Mpj01bOYGFyGJnwgs8UL0AayEltNIymRXsykNApuaYrouXlVxeXmq6uuNInnBA8HZMzAbT0oqifM/OfBXSMhGQctETEK4uBBZdx+rLUBDPr6HR/5EEPNx+24l+meHNxxSQofmnPbFx3rBs9kyxT5IQr1rablj+DLh4F8hGkmy1o9g0xOib1AjzA8gJsQDcW5XhMhv/76WXPNkWKGNxSzAtD/m/mWG2sFmFPwqeicOagi2ky+EYVIP4PiM7qe678KOmA3EKEADHDxMHT7aWP3iR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:10.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c61acf-0e97-4515-34b2-08df141b5f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
There can be more than 2 DCFCLK values for DCN6, so the assert is not
applicable.

Remove it.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c  | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
index c69a0c44eccc..9fce6b472aa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
@@ -288,8 +288,6 @@ static void dcn6_copy_utm_qos_model(struct utm_qos_model *dest, struct utm_qos_m
 static void dcn6_initialize_from_soc_bb(struct dml2_utm_soc_bb *utm_soc_bb,
 		const struct dml2_soc_bb *soc_bb)
 {
-	DML_ASSERT_MSG(soc_bb->clk_table.dcfclk.num_clk_values == 2, "soc_bb must provide min and max dcfclk values!\n");
-
 	/* initialize based on soc bb */
 	utm_soc_bb->max_dispclk_khz = soc_bb->clk_table.dispclk.clk_values_khz[soc_bb->clk_table.dispclk.num_clk_values - 1];
 	utm_soc_bb->max_dppclk_khz = soc_bb->clk_table.dppclk.clk_values_khz[soc_bb->clk_table.dppclk.num_clk_values - 1];
-- 
2.55.0

