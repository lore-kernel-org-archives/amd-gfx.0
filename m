Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976D7CA5FE0
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFFE10E6BD;
	Fri,  2 Oct 2026 19:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ZegCiDM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD6710E6BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUGiO5mTgIKYXOjXFcD478fE2UsnTCl6pPPT3Tdxk+twpYufeA0m8ksgBLfBMBz4e9JrT1jKIslkp0r7Cgdabjfj6JIakmpcZ2USavUKnPz7sa6lWaIDdXLDCEmc1NqqLl6vP0i9f85oKsc9ja9XtDz8tgbEFIx7ZOF4uwdGnKG7pfYA4TU6CnAoG6vQX5ABt4V1fhqIIogKBL6En73siT1ZhOrcXiaQEq0pqMqU80AP6GtTaetV50DZU3Y5G5jwuAfO6h4uXCPki00XhQRc/vHq1SlyQAue+BLXYZr+q4zuRxP5KcaQnN33rrSsQBUG7Kq/RbnEnQnU6o0A+NABEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exTsRKXum1hZZTsXv9ooWBn5JesdmUeb4arzrokk2C4=;
 b=tH2iWz4yNJYhpbzTaLyouNf05/nQNz5EuuTLHwQL+5BHnmNkAHCk0CvFQN8Gkme0uBIr5TU2aADG/qXQYvZzqQJw+0RsE33RnM+Vnq6L3LIQKtRJvz5lbGNPic2XtLk2D9a+ZZ/0lKy+IWnBFcV9J8VHX1ObJOrjlWy9kB//xtQZQMvQsFC9lc+KA6XDylqzCK0tvvNpCloYYg4kicPEB9mnLqZUwqp7X+P36qfYQMf3TiE8RM9Rui3vlmfkN3eYoyz0WURetp9I102t/pEN8iJhHBla9Vd1q0LSccB0kRg7DDE5wpMzaYPs/RIvY6sCcDaFoiZ2KApQPXmns/Gt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exTsRKXum1hZZTsXv9ooWBn5JesdmUeb4arzrokk2C4=;
 b=4ZegCiDMh+lgcHy+HobTpoGi4Fuago6qr9BEU5jbogPXz5HZKMOKJw27W7AcJ25Yd+tcCyhhWcG9tDkUE/v+ETgWY3UJlwzz+F0UO9gb8OxRizQcXpLRDAEJ7TsZyrH6JtvVBSqQABd6YS7/Po75XLwJWRQ7+ncisBLvgdZ9jfI=
Received: from CH2PR12CA0027.namprd12.prod.outlook.com (2603:10b6:610:57::37)
 by EA3PR12MB172729.namprd12.prod.outlook.com (2603:10b6:303:30a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:33:17 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::89) by CH2PR12CA0027.outlook.office365.com
 (2603:10b6:610:57::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:33:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:14 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:13 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 10/17] drm/amd/display: Assign alt wa bit in fams2 cmd
Date: Fri, 2 Oct 2026 15:32:33 -0400
Message-ID: <20261002193240.3441018-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|EA3PR12MB172729:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1c732d-66f8-418f-e8ad-08df20bc0225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|20052099010|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qADosMeqvIOVVvcFyeV/x5TfA48wyp4mf54nm72Lf2NKN7jgT267NTB2LbhulZ1GTl+gMB+yVGJ7WBKkOwpprVj5otQXPT4XkwTmGr88aEc/0fSX98MS/xwWjW7L/qyV5S9HUmKMwIuQZSAve+JuY66Ldj+F/GV4EuucBiV3UeQDX4Kp/C6SEOJozs+2yPQucujravjBMgAkCZSVNbwuvaRh1MyobFna6utCzERrjrNCwH59dhPMBpC2hxFNeTggGap2Y7H/a6t3JqIYUR+D6VYr040ZMofaj/yFj4NUi6QjrEV/kS17sZrVPj9R4tEiLocNvE8Qjhf0pWGQoyEXjoaHMmkNcgFdCIa7kKbvG/NiBO0y8dMU4/UfLYGD6Y8nVXkUWpKjWVuZb538DQmTNJdWka8CzeFBoEK5CoT8Idg/rofrWICIwx7bqOsd3ZfgDNcKVlX9I816GVzp4mtI21uK/AwUkRKU1v/QU1Qq/bRKCa7Gk8g0jNOG65Kw4fNd8IVgboLsxSsdtnpJ0oxdjismfPAQptN31ls/eWjZjD/xZ07hFDrVG2ksfr4fDKBevLHIRILvmfM/nAwEbq0CZNDrKa0WSnjCzlVb55PRxJys/80w/j3BcIag4wY5yA8G5EmnQDv/tyKL5bFDniE+khm9SxHWnJL9i/Rwyf8wp0/eDr2RwUxsFGwlVJlw/b92D6TCnoPMN9vyR4Z11vJMcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(20052099010)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FHD2mlj8EfWhLyppz5eKtTpmFEb66p8cEQTbO7BnokLgIHTQFKlP58fwJBG8eRRfwQ2DNC2zjJ5Xy2gvXmFkEAtsgdpGt08aJV4CxV0Ru28IkBUkflJkUZZJg3LGom8wkiFv1mrsUbmgLWGHvaPZ93aeJEJ9cQqTZ1MGtO4J0wiwF69VWv54ZlDFD2maj/cWKjkPfip6hU8TH9qSq8pvySC28ns7C9y56sqJ7TCYDHQHvNxDeWjHL+CcfbE93rnsxIqsFc8QojWk9G8WpZtcmit6xmqVe/TYo8pyAwbZZqZHojrUS85UoY05YdNOIQINpN2iUi2y2PLo+9qh6tCVpO88T4ZmgjcUCjJ9WosNhd69+XPIV0NaKTpBe5IIJ4BUi+pM1cvOHURua+juNlBlGVp6xlTYgxUQ1fnvB2txJHv9Z0gd+RZxzDz/aJMWPRxx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:17.1594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1c732d-66f8-418f-e8ad-08df20bc0225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB172729
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

[Description]
Assign the workaround bit to ensure it propagates to FW

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 37248ecc3c08..0485ff5217f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1949,6 +1949,7 @@ static void dc_dmub_srv_ib_based_fams2_update_config(struct dc *dc,
 		config->global.features.bits.enable_stall_recovery = dc->debug.fams2_config.bits.enable_stall_recovery;
 		config->global.features.bits.enable_offload_flip = dc->debug.fams2_config.bits.enable_offload_flip;
 		config->global.features.bits.enable_debug = dc->debug.fams2_config.bits.enable_debug;
+		config->global.features.bits.alternate_channel_workaround = dc->debug.fams2_config.bits.alternate_channel_workaround;
 
 		/* construct per-stream configs */
 		for (i = 0; i < context->bw_ctx.bw.dcn.fams2_global_config.num_streams; i++) {
-- 
2.34.1

