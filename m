Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FEFCCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DE610E2CE;
	Wed,  5 Nov 2025 15:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bAJYlxz/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970AB10E2AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyNe/MyOwQy/on9/kxsf0g231Y2dOKEPQHafZt7aQnIl5RnbEe02E6CKBxAOOcQAwC8lP8T+pg324oi+bMN5mGYxbUxQiybQ8+f6pK05y7o1zSmMKvlbDIHWhsF0if1eiwMT+g8Hz0U7zl1Fc5qIdf5DNsIOh8BVY13XXCXAAiO6b2bc3E0RgkLOQsZh2Y13DP3uZnlxqeON7jTAoY9k4p8yH41zVpke5saCIl7vFALQ/qUhT1jse0v03HKM4vAJ2ziqX+cDRfyPqDK9rnOVzLmXhPkjhezZL/0v81HXlvigsAx8XzyGcoa4jG0fFPfY+2EVAgFBHCHiFZ/Ymd2CHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkp4UAMt1M1gZ20r/d+d/xiMSnaH22l9hRTjbS0SWTo=;
 b=cc2/pX89tYI4hJkjth+CWR9vGSB+vTgJZTsTLJEl6zRt59dYDOt/e6+nFFPZHGDcSV230BVBj3gohvQEj0CbZmxDAzBQKu6820au6uSLTWtaMN/td637R32KHfYpbiWBwuKcEwvoTLg/m3zZDnt6tYtm9/RYydqovSFLZCl7b6wfRonx7SUzXREgkCaswpWjZq4vjlWOFcXi/jg2aaSqaj2P2GYbDlOVqswOz8Jk15vv3CyjWS/xCD8G5YLK2YocpGqtDdT+V2pScGcyAnJtpsDCb3a9H4FXFxzfLz6Cx6LQP8BoNONgadLKCPOw0ayTinki/nLrMoMefB8ykXM8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkp4UAMt1M1gZ20r/d+d/xiMSnaH22l9hRTjbS0SWTo=;
 b=bAJYlxz/oihD2M8vcBPKoGn9TZ+1n8qeSvyvorRiLdOZNs24Swcy8u/GH3X4MJPkZi3H7Xvj6xi7cjJ1JVJtz4Pb/0z8qGAutPj5SqCH9TsYGzoVaOPRuF8sdce6QRVwlB9e5tVEFZiDYbv5K6U26bfvVgRrCHTCezQTsUw7Jd4=
Received: from BN1PR14CA0005.namprd14.prod.outlook.com (2603:10b6:408:e3::10)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Wed, 5 Nov
 2025 15:40:51 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::f7) by BN1PR14CA0005.outlook.office365.com
 (2603:10b6:408:e3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 15:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:40:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:51 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:51 -0800
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:50 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>
Subject: [PATCH 01/13] drm/amd/display: Only initialize LSDMA if it is
 supported in DMU
Date: Wed, 5 Nov 2025 10:36:16 -0500
Message-ID: <20251105154035.883188-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: b9facfc3-5edb-4a07-e093-08de1c81b34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d350Jps8gW1vk8G6sJLNruksxVoYJECg2fGCbHm8ftqB9A8Yb1ByZR50y/0C?=
 =?us-ascii?Q?akJDbWQ/e/iQ6EK0DSnyKe6ShFNgxMduopU/DK6hm+HxCiQvrMUrV9+cpYng?=
 =?us-ascii?Q?aYgDw64q4o/ISdDgf3SIej/3d2icfgpVhR1QGAbDk9nCRyiSLxDrTijVUXUH?=
 =?us-ascii?Q?3Xn7aL/ak0fLDrmQ7pqh29aMjICy3vol/yHnojTKeH0DXyPCmyJptslj8MdE?=
 =?us-ascii?Q?knrNZDKhzSl93KgSfbDMNGKwfO98hMW7gmZSZd02yDPW9fjPYJl8WrYsCYrI?=
 =?us-ascii?Q?/C+k6/vT0dQKg1EMDrWG4uyQJBRKDaKjnPBPzoba+TluI7ZEmuXHUVNFf5Tg?=
 =?us-ascii?Q?fTdUkwHTBfWkikuPDgCUzGdrc1u9qhX+5nyD35iMLKy1XDT0r8ErjXft5sdP?=
 =?us-ascii?Q?vr4u6GCKW+YSjtV23EwT3Cy1mk1xW+lQJ89WKIPXJew69ne5TEO9sCQASN1N?=
 =?us-ascii?Q?WSctxP3W4zbHr3cUDzICgIeeuPP/YidBjRLKHd+L/V+Qu7bBOTF85kGzPNSA?=
 =?us-ascii?Q?R+0jiRkmlg9pmeNSSSTg9dfh2f8KMAUhzQzDZovmAIBLbi7e8RwSE7QE+arE?=
 =?us-ascii?Q?ULgEvRIIt/kIC+kvr15quv2/RK9F7+Qa5pk+bY2Wb3pX+4f6l5gMYHm5dYef?=
 =?us-ascii?Q?pXbUSxHApWo91x86Qljxrm35qHD4Mi9ecWeDjzH3X1tpVklITRgFl/M2kw5V?=
 =?us-ascii?Q?CsT3qsz786sZGfl1lZICNaUSX5788T4KEmOyI93woy7ffinJ24Wj3ICkhMr1?=
 =?us-ascii?Q?WU3jqRicqUoZeuFPNR7bPRMs5wxGvBTLoA2SSB92B/95fMMmIbenvNpl9gDB?=
 =?us-ascii?Q?hG11lzFbZxXWo3akxwH8mB0pklrrFI3usmRtYlGmrDw0n+crQ+KhirkMQcK1?=
 =?us-ascii?Q?Eyo9r32mO0k0CX7lNzmTKWa9dhehEz7sz/7olKguDsTS2A0XrS+dyGvtaxcJ?=
 =?us-ascii?Q?wgLKH7HW3xqIS1f79ZAk0l2RlPiM8ggp0bi0GRAdGz6lBMR8ydSeDtc2RceX?=
 =?us-ascii?Q?/12Sskp/Lag6ZSkajaW7Lpz0fj5BgWkhT3psJLMv2LRHVmFENNJg0i3TtykE?=
 =?us-ascii?Q?FxCmH7+6PmGjhNO95bdCDYXINOLeO1LAnK+H2D9KaVQYxidxhIAl/DBYDNtW?=
 =?us-ascii?Q?Va1Np+nYA+WA6PZWIPVz+z2Rl6inIO+87Mgi7Mc7N9L6WuBMaXCZruJH0xvi?=
 =?us-ascii?Q?UllREFeBx4RoV2uNaFN0ExGKGh3NCAfTzCDmGHlTj1SST/zY/3mZ7w3pf/9K?=
 =?us-ascii?Q?sl5ZY5c7AoYXIgAY3608nvJV0+ZGqwCTeDIHAc6X1vDXenj/buhocKaobFXh?=
 =?us-ascii?Q?JAvQRa1TQHA6O0yFAJt7bNq28f2Kxzvfsh+WO9BxKS67EccpaeSL8aZz9RSV?=
 =?us-ascii?Q?Lvhogi0tMeJkSa2KUEiG6f88gQhc3JMTIA5uNmMWcNYsaNuDoJa2ub5XiAGg?=
 =?us-ascii?Q?sFyTguHn9yp2PEXE36jSeelOxfLpOmYF/BFRSYx0FrrL8rS/HMbBplXmxH2m?=
 =?us-ascii?Q?iue3HjSlS+Qph2ApE1pQ820bXjnqHq6rEs3PMaERw1iOPexx0YnIRYidm0TV?=
 =?us-ascii?Q?Y1MSx4PyBO/SOMJRHR0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:40:51.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9facfc3-5edb-4a07-e093-08de1c81b34e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

Need to check caps flag to determine whether LSDMA is supported in DMU

Reviewed-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 3 +++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index fffbf1983143..7b09af1cb306 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2084,6 +2084,9 @@ bool dmub_lsdma_init(struct dc_dmub_srv *dc_dmub_srv)
 	struct dmub_cmd_lsdma_data *lsdma_data = &cmd.lsdma.lsdma_data;
 	bool result;
 
+	if (!dc_dmub_srv->dmub->feature_caps.lsdma_support_in_dmu)
+		return false;
+
 	memset(&cmd, 0, sizeof(cmd));
 
 	cmd.cmd_common.header.type     = DMUB_CMD__LSDMA;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a0ffa046d8c2..067949d6eeb8 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -721,6 +721,7 @@ struct dmub_feature_caps {
 	uint8_t replay_supported;
 	uint8_t replay_reserved[3];
 	uint8_t abm_aux_backlight_support;
+	uint8_t lsdma_support_in_dmu;
 };
 
 struct dmub_visual_confirm_color {
-- 
2.43.0

