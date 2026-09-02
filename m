Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F80C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0C410EFDA;
	Wed,  2 Sep 2026 05:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rWpD3C6o";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D788C10EFDA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnZRLvseiIfZgG2LZxL/W5+iPO0u++sb8R+m15/65ysHoGT0FkUnoXPcpFTDzME7c1Iu/46wlWsSyzHImU1MmFRGUkJXwtxGQdqJVFgwXLcvw+rCepO+4PHHGVB9pZlAZA+EficJ1wFDIztpgYcrocRP9KAHbKa9yTnhuyjD4l7IwEPEzPw9bEE5PFXxD9BjKBZVRtbk4JCV23kSBcCX4RSendlCeYeqeOujNNDil1350XyOgF8RXQiZmiGicYIbYcSGiM39/je8Tq4zRvZQdTBuVKOOpA4yBTl1fUX3DzdG3ULxxDvSoz8TvSyzpoca5f73BgMsJyTWXVzYMmGx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVGGl1m8XaWNL7dZ3vX5YuChCXngMOACo0OcS+PanvQ=;
 b=MI+Rfr26KFsfAOGNZYuumQPNMVdUgBfOlVwM8I5yxkQRFXOJS29iRKFSiSABctYYjGAxr9QMbEOkJEBwQLBD0JBJzGFZpgT/aWecRJdlcOT9nUzfH3Y/6C3qqgupJo6vi5XQi+2NMThxSNQfixE7uVsKeaKuudodqogV4keKXge/Q8xvaSoeSrnqH3G/CMab7RYybh+k0NLII6UcmytpwEMf9p1mVC8+gc9XkIWoPBvSOlEJwXJG0fRfN0Cx6DOknCpa20x0DUSQOxZMsnGEFTCYzL2tLSkJx6KLjOHoe1J2BI+tcKeE87UuuWBMb06pa+YDoiLi6pLcePghFkUYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVGGl1m8XaWNL7dZ3vX5YuChCXngMOACo0OcS+PanvQ=;
 b=rWpD3C6oUZzeMgLEmNluwww3f8gI+7ueiyxiDUprhuW4lsKXUU8YXukZILTAyhgdWQleVpXRkzsZonuTx7ctpnG6WGVa21WcCsdl9xoEsUd/iNG/A3lRj8U23YQoJ2WfyeV5J69fP0BSeV7rIhgpmRNS5m2KmWXoFf9/FkWCCyM=
Received: from BN9PR03CA0847.namprd03.prod.outlook.com (2603:10b6:408:13d::12)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:08:43 +0000
Received: from LV8PEPF0000006A.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::9e) by BN9PR03CA0847.outlook.office365.com
 (2603:10b6:408:13d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 05:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000006A.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:08:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:08:43 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:08:34 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 29/40] drm/amd/display: Set DISPCLK per surface in DML
Date: Wed, 2 Sep 2026 12:58:51 +0800
Message-ID: <20260902050411.3473916-30-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006A:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ed82d7-133c-49bc-b47a-08df08b042ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: zLtLoehwo34fLTc/8X1fnBjh7h+3p58dvqrkx92l0OorHeAGDtq3BmD6ngqlyB1GPbLUSGCyBTZOGg5mIgbwxs343SntHROTAgft1849JQiZj+4Rvwu/3+QENM3jrYRFbj5PdAdTFY8ywBBlIr8fy4F6+K52ArPp+LPIjX8NFl3hOwRn9/GfIxyX7ZhDI/z982OetR/K6ej1G2CTGbfAeMFQmiX7L2bbuQq6qCymZm2KL4Ty2OwVdQusIoz4Z70gJRTkc4ftwRHzb34dp0wD8C9bBEkKMsd0/vHzJV4eb3srZUs2V66f3/35xpPGtTJDrr4cvcMcIEoltfp2mcGDzJ0FawZdV2ZUDBu3epQ+W5dkEtqvS8YSpjvGG524C92uRNCtl6FCnRqHXu2MuRNeucBKnjucWWoaEeY5Yzv8MpbjnBSsuGYr3nFCOjYtNCWI1AoHlM4etq3z5zbDwSRIPCJYt93lPipGFG9eTqg7GiZdsFd64jsJVdRS0vE1pZjdZ5gwBbdshCiH6CBstzRHEoZ7NZsttXRNdTo9e/3hg9BaKiTyz5Cuy8FKOdqSh2y2uCGfBs3nVjrogaRZQYPz/oh8G8NlIEjkjrPhWS+CJLevM0hXS/NPyDOOQZHQAeGsbXJxjexm2rTvlkjTgkBkrGlNoB4gTgyJ30GAcOu6EgFvMD3AGWY9aCsEcweJkuW2wGHjb+MZnoVmrdtbHwQbDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mT+JX6SPzpOQN8c8l9kUoD/1OWupTvmVPL/gowVej8vZoB6yMhr9cxM7ukyYoLi2DfItJvW7jdaRodFmeQDqjJJ8u0yJZP0eGog6IIYJXM73gDCWc8rvYZLm19wIj/PqPMX8y77AJdmqga+Pj9CUf5l7vyuP4rQGboxS4vPrt1+C6X0DxvjVdlg4vB0qN8/8BQPmngv4WkUFy05X6cYlsEWaDoHN78fgzC006n6HMNq9lGwGa6WKsxRduRmn1RlKoYbSTUyABw+0jeOcZu9RzwLNzElXkHMqhhpkLU5cp5IWdB+srsDvHN12SXj0wDwGHOXfuPpSuS3h4ajMHE0g/QOUaUrLgwLVK5i98xy4qszyTK5Mi/V0KDWf1c7RVAcv9lhqHYFWCrvLIqiRuvveWetYJd1BB91p47eNXwMQHJ3O4gqhSv5YdAdWjqsA6l6A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:08:43.5421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ed82d7-133c-49bc-b47a-08df08b042ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why & How]
Always set DISPCLK per surface.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn5_calcs_display_pipe.c     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_display_pipe.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_display_pipe.c
index 83098c1fa50b..d5ceb5d803f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_display_pipe.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_display_pipe.c
@@ -648,7 +648,7 @@ void dcn5_calculate_odm_mode(
 	*ODMMode = DecidedODMMode;
 	*TotalAvailablePipesSupport = success;
 	*NumberOfDPP = NumberOfDPPRequired;
-	*RequiredDISPCLKPerSurface = success ? DISPCLKRequired : 0;
+	*RequiredDISPCLKPerSurface = DISPCLKRequired;
 #ifdef __DML_VBA_DEBUG__
 	DML_LOG_VERBOSE("DML::%s: ODMMode = %d\n", __func__, *ODMMode);
 	DML_LOG_VERBOSE("DML::%s: NumberOfDPP = %d\n", __func__, *NumberOfDPP);
-- 
2.43.0

