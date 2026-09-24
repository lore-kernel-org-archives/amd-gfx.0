Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609CFC98324
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0D110F730;
	Thu, 24 Sep 2026 18:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2hYCiUBY";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877F110F720
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyHYwKbPzYaVmjbPYSUWWiVahlMKbYjImAilWt89JdvU+2G7lJrqOpSqsu0gX9WfTZxTqfjYg4IGe6sUiwOQ7j5OrT2pX55yquaZHlq2w7anexiXyhJkdStTb+CngjUjb7QvOYznqER3vRneHkcO/KSPaA3CUEYiz5DbQ0egJ52srOt0gc59mJXsOiBT8RNt3C3RSDsil0gy6c1YTeop/Ei6spq0oSrydjczV7oO+D3Rc9DwM4TFftd32JkHwKs4eNK+Vu9GZ4h43ejgzpGWlKaItwmZiG+FAB2aIBV+B1DoFchpOQMPZZIRuRCzOi9FPb5fSjtuE1ujn1fdV32JiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNauPOHs1tF/vLO17j9nsZ31tys6Cyry91MmXHOvQw0=;
 b=WeBxnIxWbLCpY/LnEqMpfcxsguWulb52/oNWF18iN3tNbMfCjAysk/pkn+L0k8Bdhj78Nt4VeoEWIlfm37z37DT7gfYXhX2rkOJiVnN8IsA/K6yq4GubgWdSrfQj8KccWCiChDZlondRztLN+WZxY4BhGT+VzilxreNNAfisSmjtC8xMonk9iv5UhuDVg1PKL8FGjn8aNYd7/rwoAA7vYP0geZPV6+vw7CWTwyw8+qiQyZ5gP/gKWjb6DMqTN2CFOX7g6LMxnKzbPc1uDO8lbPc0+q/XIe/hy0nQeta/RLB9KwoJfJ/61zTfFm6D7N2BMeKHAsx6Q4rrnAkZs4Yl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNauPOHs1tF/vLO17j9nsZ31tys6Cyry91MmXHOvQw0=;
 b=2hYCiUBYEY+8zYORUs9XKGn9WGasVequma4thHclkKVmu5n8aoNvHLYMIoi5D5o8LoX/SE/D3j5DF90Vb0xKmym0iJHVhwWRbCT8cwofOjIHFrYUJRf0wviLGWAaKRdejIGEYBj8yTuP+P5UmbpmQrokbPoeXElfQL9J02OV3/s=
Received: from SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::33)
 by EAYPR12MB999155.namprd12.prod.outlook.com (2603:10b6:303:2be::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:21 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ae) by SJ0P220CA0022.outlook.office365.com
 (2603:10b6:a03:41b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:21 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:11 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 14/34] drm/amd/display: Enable DMUB HW cursor offload
Date: Thu, 24 Sep 2026 14:45:27 -0400
Message-ID: <20260924184824.596894-15-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|EAYPR12MB999155:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3b8fbb-77af-41b2-cf9f-08df1a6c20a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: JHe0pukM1OADhQDIa1pPp3yEDYk7hXfnl0Ltx8XQbN1UHUSNRncpsU58SZ+OrZFillrzlh6P1adyS8McvAgFLIb3ZYVoqNm6KdjvfD8SS/YEy9PLzeGM+fRlvygUHlZuAaYb4KH0XzLbz9nlPqboBcjCxEQkEhqlHhkLw/teezvNcyq7rawVwhSo/M20C8aY6kLsMCT+eeUvNf6sOvqHgPIPl/QJ7wg5YCgs2vzlgUp4ITlB7tF9CySBSfTyqwtc3eZDn03qEFdyp1RsGGPfriUroShnT54CL+kKF01pimLPUpVwcsaOMTi6Qy70+kBgMc8u+kAuWTY63JnTjdUfnprS+3l+fGY3Dr4W7IOUgDgaMxXxy23W+dgzk9ReZ4GYyNgs3wXCaJpdDkcqI9Eo+KC82SwWoN10BLITNK1Ve1l69Ae/u0OLalMe67aQaUAawBKubpliMqG/KPz6uaQIYCCg7qxW+ZnnnvuH+i2XdbluLXoruKgE88EWCpMMkHwNc0lDRELXYdjBhPnS78xdPtVQJVLtFm059MEmEUDvOibgGjj7/cqlbu3u1C0XEeTZuhedSFzmX1h9/g3EaTBFVTUKEHyB7Vpb2MGwPH704iIO0EGFO3ujCRqu78sbhGqGYwqtw+8X+Dj1utL5tyyn8CMaBYPvv9SirkSBgjsq9GyfqDOp8mXyWFIjLWV3Y0B1YHTHL6wAT/N4Q/ukRJ7omA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z+zIydKjuuWSjO+r8beOqeo6FnKgelrKb98f9dYWAEnqtY5NfOEsEjLxMeJBEyC7jgwF1W4dLDYoUUAMSS0gvYkQeodX7onMHQZ0bQ1B5ZtX+C6P5Su5bR/reaQKtUmMNioNQGd7rQtBc4c+YryWdo4/yqn53ihFpff15mS4/OqG/KWYgjDPcDNo1j4Y6LBAVCSTnTxBgzaaV/PYecAGt4cfoEMPl6QboBRibxenHtWOrSJXpUMZBowy2eNJvYgIfO6CLL1YxlP6OVF5lkD37gnC0BOBAGEGbKdgb5Da2OMk91NgoQfroIoXDqfoc588mUYlYaw/L51VLLcMKqstYYjcImb86TuoMhyPB3BqZnuvXpUr7DV+VwyxQRbhvn5k2GGm9IZ32H5HH59zNooWEIOSRm3CSgUOb3OTC/ujJU1OLsi92Ma87u40TPPSXbEZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:21.5566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3b8fbb-77af-41b2-cf9f-08df1a6c20a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999155
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

[why & how]
DCN60 supports cursor offload to DMU.

Request cursor offload in amdgpu_dm_init and initialize it after DMUB is up
(dc_dmub_srv_cursor_offload_init), which should be picked up by all the
ASICs that support cursor offload in the dcnX_resouce.c.

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c      | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 16d1278996f8..b6d7be0c15bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -723,6 +723,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
+	/* Enable cursor offload if the ASIC supports it. */
+	dc_dmub_srv_cursor_offload_init(adev->dm.dc);
+
 	/* GOP/vBIOS may leave an OPTC enabled for a display present at power-on
 	 * but no longer driven (e.g. an external DP unplugged at boot). Such a
 	 * dangling pipe keeps DCN out of idle and blocks s0i3. Power it down
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index d9af53f720f7..37248ecc3c08 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1250,9 +1250,16 @@ void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, con
 void dc_dmub_srv_cursor_offload_init(struct dc *dc)
 {
 	struct dmub_rb_cmd_cursor_offload_init *init;
-	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+	struct dc_dmub_srv *dc_dmub_srv;
 	union dmub_rb_cmd cmd;
 
+	if (!dc || !dc->ctx)
+		return;
+
+	dc_dmub_srv = dc->ctx->dmub_srv;
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return;
+
 	if (!dc->config.enable_cursor_offload)
 		return;
 
-- 
2.53.0

