Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F1C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AEB4112AE8;
	Tue, 12 Mar 2024 09:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XEqwjHG7";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A31112AE8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kED94p55AIgK9BWRcQvWGoDsVa2ibh38Lm0Y8uFJnjr+AXBx01H2nVZst9YaxyBrg3r2fOkY7+BI5aQDi70KaKvYe3Hn9lolk1cDJJNRUDKhWxh0uRAVwKvkH9a4pRxSYmLgPuFbp+7DUAsn05OpYv6/4+L1zlNz1PQMtyfD93AQU8hwQs/wRUrlZqCwXuyYCTXSqwiv3n3+orUXGZj29AY/FUU/C6A82c1QHM2MWbrS0kNCPZktiAdhxMwx7alxZHgrfYhpAFYTTpCieoUWbOBov7gFWOCEtQLtszip3MMZdTUuw0/+aVPPHQ47+6rKy+Bu1+cgz/Y8zfE46nzyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyBJCF77DCzvjeL+QcsyDm/zTiJdKDUMyG0qCPG+TDU=;
 b=dh4lIKPD0qVkrEYy6kUZ/cjLs174tpLElyLWzZ3071xw+U70sqCDTwe0pxq7JtB36edTDeRuAdIbU05Vl/CZIBfQK/Qqk0hmJuHzIOaoGzJ/nupY5ACbtCJghOzsigpIiHhy9Gmv+iNwAMUh87RYChK/yVxWSP0CnpoKZ/agGDDpkHm5oniGIeRaeTTFwYZf/sCvhbjvuBCO8BKH/6O/HhviPgvmQ5hizu50AZLHA/4Qmo/kVpbMRVTuv1ECC4GYB+JXuR4XkfwFlKLubE+6qJo3V9Q9WYA9T6J2NmK5J1z5gIaS7k9mN+FPpIG5P9KkjmZTz1VFPUwR4+UvwUZJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyBJCF77DCzvjeL+QcsyDm/zTiJdKDUMyG0qCPG+TDU=;
 b=XEqwjHG77+AuYYV0NqVFPRhIyiX8NwBOSj/NdjhNpyPIe9DruuaijXARgMcRWmAC37qz6skZQBb7YC15dvYlNVicb37o0iRFBi2ocd66rDAUaGzc6L9h7Qvv72+bSH3sWYQcZYgEbvOL6ip8tvJuxbilVr1sHLoyIgdOK3Mf3QM=
Received: from SJ0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:2c0::9)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:22:06 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::64) by SJ0PR13CA0004.outlook.office365.com
 (2603:10b6:a03:2c0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 02:22:04 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:00 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 11/43] drm/amd/display: Comments adjustments
Date: Tue, 12 Mar 2024 17:20:04 +0800
Message-ID: <20240312092036.3283319-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 54459b51-911d-40af-3348-08dc4275e28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y13LGfeTy1/Mwka76t6cznJNPrUa4DZI4USuPHsmWlkfIhdgx81m3Lz2zB8I8auNzBdoh9QDuvOuojX70StJUnPAdEm+S/GRaKUxQlxHXFEolknJzHuVL/Z7gJaiwCA+jwVYBFUbjXaI9UAU9lMUXZFHEy29KMC6HKiEYUOk9rnAV5WMOdB44GlyrdrIfyvmkvkPqbInBU7xMCuDnyIE0yl2IScV4nj7/9ULaUM21EK6ovJZGl25U/vD67Q0qy9b0Frywp9/h+CxnTt7Ubn3CRAxcHkTNlArQZODzOg4QatcTICxp6iEsfYxLMGft4Kmdneh7klffkbvcgqGAeo8BK+/NNfEiSFUowbH/UuG2T5mKT+6MWiyDr9wq3A2nt5cC3Zm7MKYuJx3OIABgJM4rBPJraaqry/caB78JYS0/SmijF4Z1cWX1VCktHlDLcisYWFKj9VmAfBZvI6eCDhyx1fx9XQeRbYXfY9qXjE7Nyf45fjVqLiiFPdvQErueRI/F/OZxiemqHHq66brrcP9Jy+p2p6A5euL6ZsUxih3R1pNcac4wZA0KpNp0QgH12Z4u2pun2FGyLs3yj7PWenDbKEo9PX2hsVmNYyZRMN+85RhXkOMaUEFGllxm1CCSiiLszLc+gf4HTnlkHyKLY57wmT/BfqYngnCbIUX6BQesSX6FLb3KxpQqsj03y4HyV4hnMWAq/tYRr9IKQP2T7rtar+rKjWzHC+MelYTzU2MCSbnv2qSF7d0wVhhb/bxssb9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:05.7560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54459b51-911d-40af-3348-08dc4275e28d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
This commit just drop some old comments and update a typo in another
one.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 2fb1d00ff965..ce3699f62602 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -75,7 +75,6 @@
 #include "dcn30/dcn30_dwb.h"
 #include "dcn30/dcn30_mmhubbub.h"
 
-// TODO: change include headers /amd/include/asic_reg after upstream
 #include "yellow_carp_offset.h"
 #include "dcn/dcn_3_1_2_offset.h"
 #include "dcn/dcn_3_1_2_sh_mask.h"
@@ -1771,7 +1770,7 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
 
-	// Disable fast_validate to set min dcfclk in alculate_wm_and_dlg
+	// Disable fast_validate to set min dcfclk in calculate_wm_and_dlg
 	if (pipe_cnt == 0)
 		fast_validate = false;
 
-- 
2.37.3

