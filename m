Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B610ACD1296
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B3E10F948;
	Wed, 10 Apr 2024 21:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UexujUqa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D1310EA5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2mB72rx2loY0g10JRozQQZTpweJ9LOJkmKalBrzGujkpPcMQZpvzRmWAOXMXAn3TP2I0pibdSlDdxL3N2Y+1Brk3OAmikH930w8KvpCrH3ulq9e++U3WpTLXNSkiFkGVw3R9OD/ZMiWDB2A9Awaf3UPOSOdOH6mvD2xN0yXTAQ5m0kh3zxRYC6pu31nLmMfe4vdQv3F/NYe982l5o9Zm5gqrS9k60PRf7Ja25LHv79f4he+ufPdEI8+UKlCfxcO8fwktHO22z+df4IFUIggOa+cpMiBgCEwMZkfX7XwhVTRp1Wafk3hODeT8Xd6DM8mZarwyGLCOjluV+Cv2dYHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrIZJGcHl880Cz2bHS6w//W1I3IytuNPlMN2hay22XY=;
 b=E+B3M7QNi+1S7x5tkoAZt6S1hODrHuESdnp8aT1DUBaFLzat1arwnqOeHRT1P5V3W1c1v1dtYAq75GMY1Lu6Bz71Fg94Dx7+sXTWv99YtAkiaP/qKetXkV8DrSsKiQk/mmzI6o2oRJeb3roz+HWCnx7C3NN0fwGVNULufmgAqYNBH/0Umq5DdrG9BmlsE7JFAsvbrWlWRDKPbcr4a8J8k2GTl8Ph/0FTT21E0v3SpOLgVXO3IKmrvW7sp+U7wzk1gDrt035cNPCSchsPAe4zQHi55Jr9ECwf8lNapevoZAcZUw4M57zBYILxb5V7LEedIZYgw2N9bNLG+GnuEMS1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrIZJGcHl880Cz2bHS6w//W1I3IytuNPlMN2hay22XY=;
 b=UexujUqaNdDc/4k7RcI/Qt2Kq1Aa86R8Txygm6ZWqdNpkNNLNOn9PbV9j8P6fl74OGEDXzmnCA1B7j9nXzg8rm0zlNxbuKB3cK3N2Hqkafgzl+5afTNqNKNSgjpci9+lfNP1RoNHbnao9c1blfNdvidV/aXoRW/bfzqJ9is+0R4=
Received: from BN9PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:fb::27)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:17 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::a6) by BN9PR03CA0052.outlook.office365.com
 (2603:10b6:408:fb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:16 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:12 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Mikita Lipski
 <mikita.lipski@amd.com>
Subject: [PATCH 14/25] drm/amd/display: Fix PSR command version passed
Date: Wed, 10 Apr 2024 15:26:03 -0600
Message-ID: <20240410212726.1312989-15-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2f9be8-3bc5-45c9-69e2-08dc59a522d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBFia2ZPAja+OZLbquhneImr/CCz0WeSmsm5HQymbtisfCL/6Mjc/jqMx0AxM+8WdQPGoN/PAuNKlgKbQS9MGcw9cSwxoMWsubRq81ykxtHdi0yXIKVaw1c/voctBzvtle9DlkdBBeZge5+wGNMYb4qgM73/fkB6WnDS7RwqsCLo8GOXvxbC8Nzpmh6ZiU1EqBjiX7ivJ0L4TaO2JpmRqDLqtCMn1VTYnj9MIx8meZrPviRtsmFDE0Ab3SZWYHMLvw1I/UiofAm0YS17vhYmwOZPezrKFdAKh6qxuQIoje9SzgZ29uMi7Sj2H4EKH5TJJmQIkAY2391ihHBJaXtNgAzCqNTBcOuXXuZF72d8FgnMPLvLOa3/QFEKYm4W9xKRH+tuMC9Yqb0mAdxsZD513fGOkrcTJy5ULOGlrMl9D12AFojIki3ukA8pP9exH1d4/2J2xc0szlIn3ZZly50V+OHGSHnI9JmnWI2abORMZyk3QsJjm6qjrxCAHKGip+aPgsfQ9dyAtOIRFj3Yjsz5XhG6U+UxPcFBC6mxNMkmmYtx9niizPekCcYPemTndvY0yxaRY+6IRIpJklnobD7f8YzciIH3bzD56H19xpvXHGE44ubi0lUFkV7P2leys3bgyDlPuj6TBO1LvOKvhjUEgQir5SfG4KTjT1Tgl3Qt3u4CFLiEiCyXnk0o80tLv7+gYQG6w6Wn4umqG+F4wsNnG9Z2uNH9yo3uJlxIU2KD7+iXSuhBD1ysY8ehxztid8NJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:16.7092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2f9be8-3bc5-45c9-69e2-08dc59a522d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Driver was passing a wrong command version which to DMCUB which caused
the DMCUB to treat it as 0, so it wouldn't support dual eDP and would
override the panel index to 0 instead of choosing between 0/1.

[how]
Use DMUB_CMD_PSR_CONTROL_VERSION_1 instead of PSR_VERSION_1.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 01c75b66e8f1..8eefba757da4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3446,6 +3446,7 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 		if (srf_updates[i].surface->flip_immediate)
 			continue;
 
+		update_dirty_rect->cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
 		update_dirty_rect->dirty_rect_count = flip_addr->dirty_rect_count;
 		memcpy(update_dirty_rect->src_dirty_rects, flip_addr->dirty_rects,
 				sizeof(flip_addr->dirty_rects));
-- 
2.43.0

