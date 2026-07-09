Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2A8C44507
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F93410F712;
	Thu,  9 Jul 2026 21:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2HNRX9tl";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C08810F6F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMHJ/k3cRVYvniwajUeSzxOs1r7WIjH51BhzaUsMyl3KacTYqkPn927nm1J4mQcEXTpQPnHw5tojloIvsv7DLyL5ANXIZ/Q82gBEBdofHFCgTo4tOq4qnBuF+4aG8VJapcN/QIzLf8xtrrIcub93FB3lEKk5O90kmjLgE6i49xjS2ZPv+u53eViGejG0RZy4/EDA9dPkGsp4WWr78fTAVpXzOHGeBpZXCVOS3Xg6zZZNUF+z2UyoG9b8u3XYZXTMaj2AGWOgChrweIpIrEGvh7wDeJQJrMrNMzksCANf9DrQZDD8IK92ExMFfoFjp65kmemz8UmYUeZXBCGNE6r4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3fncNrTpXGkBWiCJtO2Md2HOvSVefyHeh9TjN0GVtY=;
 b=F55EZccP9JlPEijpQrkeilMm7PlwCleVcmxVvSLupRw9s3GEg/sS177Oi6ubX2w1pg+HCI0xQWQ9ObhBVnEQrmk48/q236Et1jbLTnMKa96fKfklUxpnc721/Sg5ACVWqjjvcfp+erNlRoIgnzuQpja3ReR6hgjoHGn9jrS2fUinlww8qUJfneKXqJA9FgNAuc4s/a3TXsme9eR+Q5013US/VbzpAA+QRUTYhja8ASRmZS3i/E5UBPa6SzDa5nGvINtAq8L9eOYLBSJxI4ozrSwz+u/aLRtaERkxnapyBjTJADqIWoQ8PDt2b3sR6l7US1McknsO9XOTnUskBNLBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3fncNrTpXGkBWiCJtO2Md2HOvSVefyHeh9TjN0GVtY=;
 b=2HNRX9tlJuXaRkZM8jTEXkj9y1Gvt2x0v//05GCkeKxn+wgR0U2mFDDsAwhBtxs2vpoSFCdQzv5le4BRGf+Jd7K0S6mAgQvV94piaVBSyPQKU38E790u4u2AThpr31TE/lEJyGIeZm2pP2ViDXvhCW3iN2UCfYiQ1eQrPsNNgvU=
Received: from MN0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:52d::9)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:39 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::3d) by MN0PR04CA0005.outlook.office365.com
 (2603:10b6:208:52d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:39 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:34 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 76/80] drm/amd/display: fix dcn42b det allocation order
Date: Thu, 9 Jul 2026 16:48:44 -0400
Message-ID: <20260709205936.5719-77-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f95bf24-9ff4-409c-4057-08deddfd6925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: W1HX0BZZC6eFfDQFbp9XhMZ7ZQ4OkHT899WD8+/VfqeEV4CgZZlaW7+vuX2cJDPFNJYyBS5DXPTLiQShLjFkDYclEIrzBJo/jW6QyEhUcjlIFszdfoBVD1+PYnAxe2F1vgzEUleCH+X6gqoo5cB/yQ6WH2ia4lvNlXI0wIpIyqRR5JEhR5QN9cPbm4FfPHX9CAsVG3ftS5g3CvHZ3JdO+33aCIvoM70Qh4+ws5luK2hUm0vRY89cQi7G9JJMq+adLvgDEHrv57pInDpMlUsqR4bZNlliFHFAEz5rF+OYeZPEDCxOHSe/N36naWaB3oRjKY3KcmtVatW06lKSfQ07A7NUYAf+0AK+JBqAzCvqCKMwVCBgvdbFgdm4+Mwp6ZduHO7pPHiUbAcoJHHHXWiSWeSgiR/vrMkro1S0GU9dNu2Vl7k+rknbJcf+bSUQ46LysJzapFh/aUd3HSuyI8OZMmXJ+Ciodc+VxokdWIsEJuCA3GwdSpSRR/q5u+cMV2tqtHCbYj0foQAzRZAtIB29QVZl0J8cmEE7zOIE6EvKFjRhx51v/qqLlPZ7geUxqNTjo0AE6MCQlgJdyCevqtDKHKu1wfSvV1O1Ja1BDX5INyOi0FFE9BdFbOLOG2RrWCAy7iH2MB2cig5onhMwKxSd8uvTsiriASD3mT/jKajauGc1i1GW5HgVbQNabry62aaPpOGHrKGqtXfn8sY7pFIokQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xbIuJDY7mv/ua2iRtXjZg36n2vAl4VjhMQHIvHTtuoHDgvHy8XHkWMx+jazjRmxwZ1ElVtFubAyuPumrg/tk/ntzeepOOUjy2AYpkUY1iRWDNHXZ7XZct6ZLPzZz+Cm9K0DwcPNOaZbR0QjTqvrBNIws/m5zs5UuTtz2C8qGAvhpvTOqZ3ATm0NdfR5wEIpoIErTy26664HoLtxkQzKY35TGl9jwMMPBsphmag3qMiTpCEBOBVQAGdc8IWE8R+9ob8rou7fRXvikwQe9w3piIRHFmlyUMfLztFA3GtUd5qWEcpeYwhqczM040zaNlKXnZLEE5JznsX3HZPkJ3iptsvVKh5N6F7PvfNwmJB6zWGyrGJ6855bliEYVd3AL22TqrQci9mLcJAFdwUQfjGCWQusbxT8xuEHa8OZ7/nLPq1HSGvYBnmX9ZFkzaExGc8h9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:39.3341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f95bf24-9ff4-409c-4057-08deddfd6925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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

set_pipe_unlock_order needs to be set to true for the pipes to be unlocked
in correct order to avoid det overallocation

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index c555be6e541d..343e10b4e096 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -2119,6 +2119,7 @@ static bool dcn42b_resource_construct(
 	dc->config.use_pipe_ctx_sync_logic = true;
 	dc->config.dc_mode_clk_limit_support = false;
 	dc->config.enable_windowed_mpo_odm = true;
+	dc->config.set_pipe_unlock_order = true; /* Need to ensure DET gets freed before allocating */
 	/* Use psp mailbox to enable assr */
 	dc->config.use_assr_psp_message = true;
 	/* dcn42 and afterward always support external panel replay */
-- 
2.55.0

