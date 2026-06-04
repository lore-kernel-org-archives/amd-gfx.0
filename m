Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A9BCD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9354F11283D;
	Thu,  4 Jun 2026 14:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xo9/kyYK";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C9C11283D
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QT7iesGf2byymoURVX3fdTYtSYrvE+g+ZsGUyAuyqMh/Wh7FJciZCEKd+WZVxjA8tupdT4gA+f7XX6JgAdnP39deBsB9mbOWqT4O/RTHEwpuhNmGljADDsswUrqVhqJSWVCKjtGiIV06CJjsOrqukOnztp4+kfWU7atR4p/+ZKOV+L2cK5p45VBwk2yU+VpRNyBwNiH/WH/p/EjTW+z4/Cn3xD7FbIodM68E/21yfOoPZa2KH+GhvQI4wYH5ty/5HmCC8MboP0oPmet1t9PgMC9iLWMciAOPfwSDHagJzFBdd7EW6KZwhKemVAQAlX/nZn5u4MHBPFDW/JN2H+7WXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5am+/tEJ9AXJ5cfChpjLin6reXQC5WPFIKM941Knvs=;
 b=BSYUqfkOKe/PYFYXRcMZIbVzKybzQri4Ytw+Zhxwe5p8hEyjPFrWJZo+uKzUkg91iE0AoZ2ijsGc4JSypD+tYYaZFmUTsxamkHLdoDewgWSRRjdoeEAwZ3EaaKOpnqz1XHzGdLCBWKdOoXUbbvLTBkFaUL1We7iE85KZD5ObZ8hcewKobKp3cLqXX8MNwcU2R4NtlBaglz0yqZhrE96+Uak1njBVILnC0boJpgnXADVso7PKM0b+K/a7mcZCOa/6yjOAqm6ZQcleM05q3w9saV3+Lh4wa7/fdRSJ/UJlIvvTYPi7yvSxtKOLnAYN8z3pDx4K1Jw+hMz6/GTUEWSnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5am+/tEJ9AXJ5cfChpjLin6reXQC5WPFIKM941Knvs=;
 b=Xo9/kyYKJfzEkQH8Rm7OdhYzwrhmmoC610VFZZ5M620Vvzqiz7obXjsIt/U2SN1r1tLcK2HbNPnSssJgOcqf9DOEnv0rHyb54M63o/ZbmO6LybAesz00eoA8+jzAfRERdCC038blvH+/vtZozlXnmPhNRTtRDHFVj+t5rfdIjiQ=
Received: from BL1P223CA0044.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::17)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:54:53 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::7b) by BL1P223CA0044.outlook.office365.com
 (2603:10b6:208:5b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:54:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:48 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:47 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 05/24] drm/amd/display: Fix writeback format loop and variable
 init
Date: Thu, 4 Jun 2026 10:51:59 -0400
Message-ID: <20260604145428.809959-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f86f6f4-6a48-4f6d-7823-08dec2493c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Zr8aJ9GO5zbFSpbN1Enh4HFtpc/I90NVm4ZX0nt+Zoam8sLOiOvI9N0k01MN+tZp39qocSlA+xL+no4yDRMAZcSRFGZfu2dR7iHbRja1RZzOwIeQGKpvzlVvV7Euj6WD7lCmh7Dr0KO9RA7BmahmndPgOlvyLhHznp2fMu+H0Wd96x0L+XMEoznQuOVu7YtDsFjS2xNWNiYq6VIoelEPDGbaC+xtW03X8GSUqw16PnYR7EucDz9PsBOMZkZ94zcHbSK4iJKyG27puuq8GKUUOvAC8VrdYlx7gEDo4YxXJFb37rqk06uH8YTjOnUerWh+8K15rRE2Cd6i7qJhPsi9LzvJdzOBG6UF259mti0+iZAUeQAFwgDgifEx1/JbUSQVe9L2gMQQugIm7AMjnW/KEI+EGW+RGMHpYao3Kez+C8lJyfpWVIWiuw8C923xHw1eX8f2TcxfqpIJSMM6Ib2SRZw0pTNZ7H8O0mZkukcy6YdCoDq0f8blV9x/bEpJIn9xmstbi9pOAqwxzBrWbgD+ADOI7Is5F0qVVLc1zVxNZlPafsf07aFoC2oLyHkrCytJSCIQwlRtgqpMfEw9Jk7ar5ti/bZfaHURuVG/fEV/JVgY5isksX+RLR16MKXqeoVPdkMoFvvDkTtZ3mEq7E7Q+GXhpEAOG5lRc8JDAzblHh12K4TqIXiTvVNE+t9B+4t/SSLFnnQIqRcwUh2KFpLHIFoBy11IFCV7CNRAKgx6BYU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LtMWmIWT7iAJuq+Svt4Ef2FgnuNjY46su87B/5qsYppBC+kD+J5OxeozvGDmN35elJdUovMlvUHTUg4LqE8bSUeVDJxxAdBvqz5gypUURdyn/kAeLbrsDxKxFjVd2nYpbKHsnD8sOukhqXMEF/y5Kq+uIyAUsBcvQ1FUKFTTgmswGaAAZw1/UUNhsngu4bCjBRMWs+I0IEk50lh/QjAO+6vorqxG9eN4F73slgkdoSfTQyHLmWW+KD9KlMhrl2jgR/skCwUqKMPqspXf9YJnosD49mBhuOW8xGPlC2qVcmltfcMHojYtoDgSvUxDCtXLmJiuRyGkCcGY4XAhGhLoa/zhdWqPZgAZcxUhjCDVXW4dAs6IeUzdiULbjXRpGMPMkN7VvYNEXdmxuTXjj7IdKuwXOA6d7rvZBvHcjmf7U7K1KzJpKQNMjZOr4Odi1NCg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:54:53.4767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f86f6f4-6a48-4f6d-7823-08dec2493c69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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
1. Use ARRAY_SIZE() instead of manual sizeof division for the
   format array iteration. Add a break statement to exit the loop
   early once a matching format is found.
2. Remove redundant zero initialization of res since all paths
   assign before use.

Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 110f0173eee6..ead3d0bb052f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -59,9 +59,11 @@ static int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 		return -EINVAL;
 	}
 
-	for (i = 0; i < sizeof(amdgpu_dm_wb_formats) / sizeof(u32); i++) {
-		if (fb->format->format == amdgpu_dm_wb_formats[i])
+	for (i = 0; i < ARRAY_SIZE(amdgpu_dm_wb_formats); i++) {
+		if (fb->format->format == amdgpu_dm_wb_formats[i]) {
 			found = true;
+			break;
+		}
 	}
 
 	if (!found) {
@@ -187,7 +189,7 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 {
 	struct dc *dc = dm->dc;
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
-	int res = 0;
+	int res;
 
 	wbcon->link = link;
 
-- 
2.54.0

