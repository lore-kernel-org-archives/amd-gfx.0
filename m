Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB35EC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3639B10F6EB;
	Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4F34e9d";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AB510F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nyb/2+pTgZRNBWeUaGs1ssREmFQffkOBVC8axrZrYQeXhiEnMMDXxH5JguKwP2/pNIdaJdU56G4qbkuPLVZ0/pb8SBaOC5FCi66T0Lt7Q4DsI5z6SXfFP3HDsUt+NqtaCURmGKH+TBz9o0XNZkUMmEm3eYhT2x4XHbLdSg78O5AccO4BeSgd1hbtHfaGzDVZmvQfIu8IMP5zhwuxzaZDtiWV9dXLmKLbVeXXw1WcJLpibE9q9nZAa4U1l56ZeY3P0PMAmkVIrVHol3e84T9H+CzMt2OHuMoj/t8jH37yJYU7yNTF27LmzGX+CMfPeGEfITvDgqfPVYOhn9aV+GhrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYljQHj8fQjitF6XzF1u6nkNwV04modEQjx/newNUTM=;
 b=Lq0hYcNL1XxdNxDRg1sJqLtO3UuZqRgPgzyrKWRscGRZ4jvX3cwqduGLCwsOih0UZS8cURqCFFa/K4rbpIe7+PX6p3qQuaSrmj7cxhsmCA3Jj8GT0U4hojF7rtVu51qTHGde2JENPG1//3t+Tx1NjLGBkwaBrLbjsVCQxPz8z+KN2jcKkv4dBi8RU8z/X1GTQZvPXDlwEKG+HCMZ5E9RGJ+sEv42L4mZJbz0eGaN9TpouOX6kMnh0Y8QB3FRgjQT/C0vg8Xt+MkgZIyrQbpIhXLCVZB3fk2NQuGPYEuYRp9wVjD850GIU6Iws/ZjWcUirxDHeaVgzHtr7gJCP+/11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYljQHj8fQjitF6XzF1u6nkNwV04modEQjx/newNUTM=;
 b=P4F34e9d4LMC3j89kFsM04+mW6NBOKAPq33CQ34Die6ACBfZKCVntFysP5jYvMHodsmTyST46hNNAG3yQ6ZrWek4CF6AYgvGFyMzyM9azWuZ6Ipy6fMcKk8ctlVK8gLsjXRVVypOXBd2/7j8hSV42rhEvEwsqJ7iIlLbufW/Ohs=
Received: from BLAPR03CA0115.namprd03.prod.outlook.com (2603:10b6:208:32a::30)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 21:02:34 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::2e) by BLAPR03CA0115.outlook.office365.com
 (2603:10b6:208:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:34 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:19 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 George Zhang <george.zhang@amd.com>
Subject: [PATCH 56/80] drm/amd/display: remove unused dcn42 socbb values
Date: Thu, 9 Jul 2026 16:48:24 -0400
Message-ID: <20260709205936.5719-57-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 671ddb21-ad64-4bbc-1523-08deddfd660b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wZ+jBJ3bOeuMiqSbgr8K+yJaZzo0eXqSHf4Ht7JMv7t76wWS0ha/bYnqNSFPJbICJh57x5SS8zxj7Cayfde4WSlY5yHYDRl1N6clijexiwbuda6Xu8zVSm92NnnE6M6CRSrhrCo6xKsICqgI8Sxh25csAFOR8kYSuA1jxYQ+5E+qgYOpHjFQF1jjviv9bLHYocXbvRkSrXUilheUjL8bnFQQ467R1uKkQH2Eej/lvloSndFW9xliA9x8Ipd9hFeuWn37GYKoYgVFFyQ/u49bCOD9a9bJqZe4TjsJ1pQ8wzO/XFBhTNp/dWokw2H9oNanoSER20y49L5y31cSEprBLtts8ip3/O2sQ/e2Qhubrf7N/1wQoJYHGyVsj0/95LAFVyHBiCkMmOg3NDmgccDQLNSpWyZrOjsotRRJyr8l7fFtAfBGZgCXrzTbWemjmriRK8Yzia/7ejz7ZJkJni1wf33of6qP0/IIaJY7qJtZMT98wudGMh7nVs/6P5jQqKomZ7BuTLEL2Q2JHlBN2xiN3CTBNq+EMduS+4eQZs+E+gBTBEQCfTTydXf9Ot1cWUtuNpwDj7zmHY387WKiJqntH8Hnyc0wVVwu4inPmDyAQmHyvhBrBVTvfBG6koTbvRSI8OTPHFSpIcWaKMeLsEEYi6KDkF0Z/RmR5Jecd7nMMw5y+wH1rzIb5idqRnREB/zyxgnaTPVNXxse9tiiM2BZNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zqvj6zZ99VLq4mf2k55gofuYkf91g2JaqUWwGbS6aR47AoQdr2OS0D6C34MW/ZptEIZxg70Ci5FHSESSlWsKJV7PGMN53JKfqW6sSMf1tG10XwqRyK8MNCSqGOPVakTqUoxUACMkRRk61FT2BZxKU1wgXWKkqDC4AjJ4ZASE2GTPHbpUkbBAVTMOcxPDmFlKFW2BgsDp/vLM4ohkakvVvcxPunjPBrq3/ehqMKcJRNWeWfQp0kyUg0Vk3DTHhzDArVmk7qmNPQFti1O8ui6CsR/RXrv9DnLn+jrWOhingUCSzcke8eEIllsbNEyfmhcE0OZ8GX24RkOjryQ/T+ji0kPPUflXKylqFZoDAWP9AskFtDgzp6Hi280FmCyClvxXTfhTF1HOq0Q+yFWDS8XyEKTvRlKWEMAg5+0RGVp0aiV1cVtyNDpcvHAneyIYCjrM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:34.1300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 671ddb21-ad64-4bbc-1523-08deddfd660b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

These values should be unset for dcn42

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h       | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index 040d89f6de35..51cae3efe310 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -205,7 +205,6 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 	.xtalclk_mhz = 24,
 	.pcie_refclk_mhz = 100,
 	.dchub_refclk_mhz = 50,
-	.mall_allocated_for_dcn_mbytes = 0,
 	.max_outstanding_reqs = 256,
 	.fabric_datapath_to_dcn_data_return_bytes = 32,
 	.return_bus_width_bytes = 64,
@@ -216,11 +215,6 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 	.phy_downspread_percent = 0.38,
 	.dcn_downspread_percent = 0.38,
 	.dispclk_dppclk_vco_speed_mhz = 3000,
-	.do_urgent_latency_adjustment = 0,
-	.mem_word_bytes = 32,
-	.num_dcc_mcaches = 8,
-	.mcache_size_bytes = 2048,
-	.mcache_line_size_bytes = 32,
 	.max_fclk_for_uclk_dpm_khz = 2200 * 1000,
 };
 
-- 
2.55.0

