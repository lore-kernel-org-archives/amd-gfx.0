Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C1CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCA310F76E;
	Tue, 13 Oct 2026 11:18:22 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B2910F770
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrRt+ZCVL/lKRIYsMDcHYi/vZ2jZivaBHEqYEplZZL4V9AKffPMLTTUVvHjk4lNfdDOim/X9Jsw1PLnp0GMH4cvlGdcE3kc4ONDFLt6t5XSFR3crNw52ntBGb5A+zP0FwoStjfOSTel8Fo/kaANqIVNfkX3S+qguZlVcQiOZKDtCgk3Zf8I3E3eXF1DSkqORt5BgQl27aUFVExJG8jinBXVGIIeNHObaH6eWJ3jenjYVMlYjF/N7zhjlSio9mOTYOIfc1t8CERnuIuJgK3tVO4mdKh+nr21/m0wad3vmiCZLQMItjBMY2o78Z1TdspB2uFp7hhb+SOBpH9G9dM2pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed4ytRUl91kXp6mCB/hofpD1otBXR3gthOOBYqKGY3o=;
 b=w+uKdiiHFUjHJbfzwybsvKOe37d8m7+5NeubarDjdksnfglp1ibEB4QTFFjwL7TETwQAhRYe4GWzuoV1SLBIm9G7lMwNbLO+t/OdK1bYp7FZ+ocyTn3PIweEFzum03NOvljCa0djCog/px8rnz2ybPujMYNOVGiSZb9k78pr4ywRFCsPWAU1h0IjmobzoV6RS+gelwZzGCDvTsDxDrcqJSCcfZjKO0S9CltIdw9YD0AA/0EyMazWAECjctMK4DzfPnMEbU1RCoNotG7z5lfzNBAGr0CHu1UGthwfJJ/TI75LbZrrcrwSbBz/gxOC+IBGJ7kobcBo7l2c6OiSS/FdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed4ytRUl91kXp6mCB/hofpD1otBXR3gthOOBYqKGY3o=;
 b=C/cdrtK8tE2uxupcBbD4QQNQpqC2uGKmmu6XjW4V6+iBOj+48mZ3f+WC8SAOjleD74B+Y1fAwNd8qULZt/XuZokgtsuBZNJTZ3241hX2/+yFN+tZJT1pzkWTCnIrIODHzSM3hHZtT32V56JcWfVbHTh46/ItOZDv+/4hl2d85Fk=
Received: from SJ0PR05CA0177.namprd05.prod.outlook.com (2603:10b6:a03:339::32)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Tue, 13 Oct
 2026 11:18:11 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::7d) by SJ0PR05CA0177.outlook.office365.com
 (2603:10b6:a03:339::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Tue, 13
 Oct 2026 11:18:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:18:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:47 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:17:39 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 13/30] drm/amd/display: Use picoseconds for line time on DCN6+
Date: Tue, 13 Oct 2026 19:08:00 +0800
Message-ID: <20261013111616.2267344-14-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 73662ec5-a54f-489c-643a-08df291baa90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|10067099003|18002099003|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: LtxuE4g4q5k/1QC90KCojWRjeJ/0qjrnSUlcVmWDUSLRK1/d3FLJ+I8NE4xWzErsrU6wTbwWgJkdw5guEy0Wv5n8mOMCCLvu4q/GPkHdQJal06sYJWnECXmMqryGz+s9nxfhS6viT8RZ+hBnwoBFQdCuxc5JSL1RqyCTjnA/1/kF02MFzz1jvEwBacoSPht1oOnjk/I/s+3UaUdG9ZaE8AB9R/yp31Cz3xkT3jmtvX0xhE3qKDuJCs3W5D8sAVJf0qykbm3O1vYaNanMXDKCqmdg6txZIrTZFD9zG9Pp0jRGuvy6gpo624VGT7D0PDo3nJv8zD9t3xbUB8JgakrUPbcjq8y3CvaKjZiKftpeEMLDrXOCNOghePU8Im3pocMO4rN6EmgUt1td47mu6Eh5jABa9Clhq2fKC0+Ix167P7a64kihDhmUAR3IzcbxAus3pLnyVxyNeY/co4ZsXYWMKHEo8yWmgmvy5a53nUqN1Ss+jJY3Yiz9hxybOwdoh1N85BD8j+d421Y80f+JNU9sQvJV2QFESG1hWk4yAANU1Ge/oMaEShTtrInHSzP6dfm5u9pAAPFXUcu7CUdhMY/QH61If1OEr7n+oefSir6pTHfS7VGw2E+UWKlH88qu5mnrSbVmYW3MnnXPEZTumJSnCLNaRT3/6BP3ty/k1bZrCFAWCjrHkRyULePx1C6ypqf1gPJbb2wws/wYSrOMyA+FHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: buG0WeTOshNmAKQ8Vk6BezM37fxoJPuTql22p+yjeJcH+p3SpnioSIljg80Ivhu56Kl02g2cH6DeVNrtK2Am4J1/9KAmSI3UbFK2KIG2/uPR1TtuDbFODdIVdjGZZyGguYeUz1faHyKotDM+zVQxyaHlUsRBxTmzWBNEAxfYcGT4LBMRaY6M6mQAdeLIJ3OilKqRCFjhNHrJTts/OnpjnKW7eCjjBlPVkT6VGaN74MGhuAo1qVi2ZLmelEMqnSNPMvkZltNXRBQJ1wqIQHc566JKVBoFqG8jAh0p2Sb63vomWcPVid81kIPG+Fgv5cyobqNk2Q/vhmFEa+tzlZxntfJsFr/DlDaCxpVpbuQfWPXWSlMrJhc5RDFKvmy7Qh3K+5AtDuAdQA+FJQM3aM8M24dY37EWMwaDqwTzir2KkkNmu9Mk+l1hcBeOd8vJIgLO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:18:11.1046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73662ec5-a54f-489c-643a-08df291baa90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
- Update to use picoseconds for line time in FAMS2 for DCN6+

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
index aeddd113b7a1..50b7779a6ce7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
@@ -700,8 +700,8 @@ static void dcn6_populate_fams2_programming(const struct dml2_core_internal_disp
 	base_programming->config.bits.is_drr = stream_descriptor->timing.drr_config.enabled;
 
 	/* from meta */
-	base_programming->otg_vline_time_ns =
-		(unsigned int)(stream_pstate_meta->otg_vline_time_us * 1000.0);
+	base_programming->otg_vline_time_ps =
+		(unsigned int)(stream_pstate_meta->otg_vline_time_us * 1000000.0);
 	base_programming->scheduling_delay_otg_vlines = (uint8_t)stream_pstate_meta->scheduling_delay_otg_vlines;
 	base_programming->contention_delay_otg_vlines = (uint8_t)stream_pstate_meta->contention_delay_otg_vlines;
 	base_programming->vline_int_ack_delay_otg_vlines = (uint8_t)stream_pstate_meta->vertical_interrupt_ack_delay_otg_vlines;
-- 
2.43.0

