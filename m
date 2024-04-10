Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F805CD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85F610EA5C;
	Wed, 10 Apr 2024 21:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jA8vqjRH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E94610F201
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2+y+9odk3yjqvhTCimgaakhvjXyGaAH9zwZGZlJFobMaoVrrolANHvrCGj46uW/ut3HNoWviHUeOcbmmTusAYZGxjAtCA6pYOg/6RLDU/QmDOrzapGH2QNwgQ2SqF6Jz5cfcrP6vLFMdw/l5SIQ6jOcm6OnYtSUr2ctINgJA2aqFjRC8XmL4NSF9zjFyoT7dM4C7MXP7eNBw9ZRlQw5DVnKlW9x3a3vNu75PjWOJmpiWonMSgNlVJavUpSPtQ/vSwZyzezhJk99RyqQsL//A06rltdD0+a901NHa25C1J+RvJZyRirRZHR7kuBLnVC6OHCR08xWygWTzHM4yvEjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0zOCxubTCAEeB4Y12Sl8oz/TY8X3gR6zOiow30C9M4=;
 b=N3M5VjcreoEjKxTTMS5mFBTtjdTdaWKWsJSiEYwJeNfL/2agsfxk3u20SM2Zu03O2HU9vlHeYtpnqIXYe/+Oe3xJeCHPSJttlZ6TFk41VfmoKJ5Q9WsCXk549lrGZI3+YTeHNTQZRriMHssEmjXZTAxTFIgO+ql23fMSxjI3X8srNkxHF2IR1LEmiF6PlIiBnwGeGIdQH4ZCy7HmNcXvJGF6omwB2JeZIUtyGyY0N8gRvk7rTSodgiJfDjb6hrU+cKd7zKeNinlfZALDKtzyR3L+4/TOB0zGnJVpGXEV7KVekV9rx6/ah9ScXs0L/oAbbvghv5KPT31c5jla5ZwQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0zOCxubTCAEeB4Y12Sl8oz/TY8X3gR6zOiow30C9M4=;
 b=jA8vqjRHLc/Etixsb8K2erXurMJmpytVs4cEH/4bYItCyEHBWv95ghBEvukP4bZ9sD/t0dTw8cJXPfeECH9PAs/SPnrE4FeD4DYlC/WLkpPVaU75fuqJCYLuarYkH/5sBnIlZfqEeC/q0agiF4pWsKm/If+lwfNVN5YKtGRH1eA=
Received: from BN0PR04CA0069.namprd04.prod.outlook.com (2603:10b6:408:ea::14)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:06 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::6) by BN0PR04CA0069.outlook.office365.com
 (2603:10b6:408:ea::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 08/25] drm/amd/display: Enable Z10 flag for IPS FSM
Date: Wed, 10 Apr 2024 15:25:57 -0600
Message-ID: <20240410212726.1312989-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b00f050-1650-4e68-26e5-08dc59a51c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsuwU6xmuVDI4y3fKfpWdQJXFG3Gd/XgZg18AfNvNjuNLL8SAiQH+CCJks2nhc2kUAka/HuVLWIVjTs+bqj3FOWu/BdbjXJESe5zMIwyxVyd5ayVWVePl5iNlRDabRzr+vMV8dlX9HdWsvHRzyfXXSkc3bnp7SG6YoQHHL4exc94BgzvfcXg1uzyYzK3TSt4w8PuU+zodRIgwJKI9xnktEQe323xi804NOvwQqM3Di+x4HO67+EtREZaWpdD2O+BqQi4TQ+4altCu726MmrUv6Jb8/vmsMCX1/JVgrI21212Rslel2Bb1a9I/9ct8f7PwGOjqTVQVfA8WuiAt4976mTLwrQBWNXt83iHKzF9gI8dhdLMV3sLsnlOa1bzTD6aHXz47e15Z70nO812ONvh2wp+OrQVqrcN9rT4j1B3MYN4iP8ldNCZH5FkU2fUcKJKk7Y23aLr8CnG4ipuGN2tiugZBGONYBaViEROwJ0EJEw6EJlNSXjaaqInNZavzN2ZxWwJKZ/brKsf3+X5MUVLRi/JaOoX14aW77XUEmwCydTPCe0XZCgbrvmw6PvLrupn1WY+SuphL5suge0V3X0H8WAW6cfg7PPmn7uBoQHrQAWwy+CD1bnl2LFcgiNEjNqkbY/4uNmFtEh2aJH/cTn1ZlcSibomAROCnKNEsy1wYDOTaFWXqAsD8eQthU0f+8kG3maglMSSfUKcEakOqHnacCFEjUbIiwp5evp8kwpYnKmV5/AzojykIEkhbuaDfD4n
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:05.5109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b00f050-1650-4e68-26e5-08dc59a51c1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
IPS FSM requires Z10 flag to be enabled to do save and restore the
registers properly.

[how]
Enable Z10 and use the correct function to determine Z10 capability

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index cc1a44a890b5..b29d7d47552b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -758,7 +758,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	//must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
 	.enable_double_buffered_dsc_pg_support = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
-	.disable_z10 = true,
+	.disable_z10 = false,
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
 	.ips2_eval_delay_us = 2000,
@@ -1722,7 +1722,7 @@ static bool dcn351_validate_bandwidth(struct dc *dc,
 		return out;
 
 	DC_FP_START();
-	dcn351_decide_zstate_support(dc, context);
+	dcn35_decide_zstate_support(dc, context);
 	DC_FP_END();
 
 	return out;
-- 
2.43.0

