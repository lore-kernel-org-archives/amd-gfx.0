Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04C0EE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5A910EA57;
	Wed, 11 Sep 2024 16:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XgPCEsZk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BA510EA57
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqeyLBz6GfpplfaduCJ+9LmvwBqBvlRfcnDmDzdsNRy8jn/neEpRavyafGm8Z4VJbnVbGQNis/ocd1nPnnK1EWssyxVdaVzlW5wDxeThHCugSXGH3n7FE1FHTlfuiHmgy41JAb0zCQ03TxkHj4HaXdCdC+XAHPwZVpEhvfTeV9h8WQAF+6mqqb28O1auctrpxnxXXvkwX1rOGy8E9vhNe4eRDqu9szHjV7S/c8x25HIzL1SkJbQDF9N4GnaIniG74pvFb1oH5Mpwm6KdcOUBiXQbYgBXRmU/C7xnWZmopcMOfBI2oLzz6l9gFd9JJYaLHI5HSvRBWs+lrmzl0K4apA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB6LshiN+b3AlurH3V6w2mzYyDT0JWxNRx14zzn4qsM=;
 b=i0dkp5zUUTjCkd1HAb0pZhiHmyD4PSiy8MfFFwtnD1zciJ5I+ImVJBuArel8NKgmnpg41lvAE9995NWccCIcNMwwOlA90plZHITDnPBBHhaojrX2H7Gjz8BOjbCk4ewqsCzkYdEAbWewHi78TbloEAB4y0kNHv4DjigRao7myVypQgSy8rlTaxwWifD8KBmJbykmWR9x9k07jVCw8wfDJn5jIZcvHCt9/8qhQ/M4csjPUv28cDhZYIUSBsdNszvYcSU+ut4P/Ze4AWeFWgmO1sHhXamlVbDMtD89lg0yfqUnTx/PiBv2ri+dDOKrDxnnLP0EXJG4nLGQ+H50hKIeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB6LshiN+b3AlurH3V6w2mzYyDT0JWxNRx14zzn4qsM=;
 b=XgPCEsZkSWj0+nDHE+ilgs99cNkzxxaLcmNH+SE9iIpXbtJWNKJMPissrb7DedFub5Cb1U6bi3ZHvnkCN3ch+9Nh8vBrfNl8OGzWvTXnDzDHJPRzXrFpSYcKxSUug8Ykx+CB+OyPEP4vmZy+GTLqSyblk6ociSvGU1xfGaVv15s=
Received: from CH0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:610:74::22)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 16:24:39 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::53) by CH0PR04CA0077.outlook.office365.com
 (2603:10b6:610:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Wed, 11 Sep 2024 16:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:24:38 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:24:36 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, Samson Tam
 <samson.tam@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 13/23] drm/amd/display: Add fullscreen only sharpening policy
Date: Wed, 11 Sep 2024 10:20:55 -0600
Message-ID: <20240911162105.3567133-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d71565f-25ee-4339-582b-08dcd27e3bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F1KXfyB4dC8NecEFRm21ntJTR2fqcWLBF83HXhsz+7tE9f9k6N0x1eaW7/wa?=
 =?us-ascii?Q?TW5BjqRW11+mU3k3IY4E3C8GPwB2OQp+7tSHPIlBIqrh5LPyF6DwOjmpOpq9?=
 =?us-ascii?Q?HdprRZr2+BQIMcXOkNIm765XCnivJQB9Ty/yVYSSLdpnT97mFP+JXbsxfuHC?=
 =?us-ascii?Q?W2rkIE+S970ItR+0uNColQ+cJwb5/euUEB1Pc9R7bQAT60v7XalMkVGcM5BY?=
 =?us-ascii?Q?k9LrWZWQr78zv/i7bS4spS/xkMLfDZA5ZNib6pZEhGFSVjuKkcvNvWouIRYi?=
 =?us-ascii?Q?4usAVydhZYGgGFGSZqYc4HWB+1ajcKMpMQ2Kd1xcowoAHW4WxxGrOoS46KMP?=
 =?us-ascii?Q?yoUcV29cA3pkq+p/DNhtQ0XGKQrT0t4FqWjhgRA3iY8Wq74UQYYefYq1ebey?=
 =?us-ascii?Q?hzNRVQz2CSQ6t5N206V2KyMHH3IVqNZBKUFbz0/D5f+G+subTFa0YLtBFs6u?=
 =?us-ascii?Q?lCOVhwwCBcwBfCJRWiQqEN5qkBLGeYEsC7mC1VX6t2KB9CpCAiNYZIslitr9?=
 =?us-ascii?Q?wMujwI87X2boQvoFMWq01UjGvbnJyzpKRsME3r5g4IcIDWDyhleViYOmXG0i?=
 =?us-ascii?Q?SNc1gCrtcCSHSFGc1zJO+Xk3/sfP2stKzD+Lu8JeRXs7GGdmKwtmrmJMLXA4?=
 =?us-ascii?Q?j9kGMx7/XJ8WpHnwFY7WLVTkP1hMs/Aeyjp2dsZW2yLlH2ST3yg+dP7/nmY/?=
 =?us-ascii?Q?QmYhFHJurAeONLAyBk2nU91tbww8d9sbEaTeFIzyHsQ0G1vPmbAJPza6Zgfe?=
 =?us-ascii?Q?9gt5doq4mB1O5nDtUcOHg2ADVTt3DUZweRVvd5dKkQwQu0Gd+kDmmsZChvre?=
 =?us-ascii?Q?zhkckndAvMeLR/U27/8dDsiuZc0cnZOLGqHPVJmtVE0+OkDXTCKiwef+5C3e?=
 =?us-ascii?Q?vGZyoIz877lvFpLFRAQPEmuYUaV/oOZ14n0a8MNYpgdEWut/Dc4Fbe1zVxn3?=
 =?us-ascii?Q?3VypZLqHeWY6m5u5FUUbHUqFlkllBjknwEAlIVN86s7G3ewKEAkxS7NuwLcu?=
 =?us-ascii?Q?sen5WVbDVSDSVrbIAt9SQFuZnSeoF+h8m89IegQdMt3dLqeSPVZ6k71NSLS8?=
 =?us-ascii?Q?naoGPzeECFHVu+Ur+zCvCAqO5kcY2ilke59cxkRjPOY0ps5ECuW/A+66/MFJ?=
 =?us-ascii?Q?XmLX3Y/4tF15y/ioI3rFIbjTY+sxoujuPkv9IOm/ckxS8kbU6n57IBnkG/4+?=
 =?us-ascii?Q?OK0ItIMy5pby3W36bhE/TX35b8dceT0GGB398DYbWYW9yJlcmZbAo+7LpdTR?=
 =?us-ascii?Q?pZHAeU6onaEdY9TkEjRvdswx2anW0G6EEjaTcOjM6FXVxbND2F5sfddweDgW?=
 =?us-ascii?Q?gP2UCgJVWUGXALodXjruuMyuGsXeBmenk5G1FB0OBaJrWVItzcYsGZbbOAkr?=
 =?us-ascii?Q?Rjuik74HkMNebb550KQj6VVvcPqf7K7u+5hqNK4AEFQWJf3kx8qik1PPMd10?=
 =?us-ascii?Q?MG2DgYT8jZvy+eV+Xu7l1KbrGPEC5gXF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:24:38.9815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d71565f-25ee-4339-582b-08dcd27e3bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

[WHAT & HOW]
Disable sharpening if not in fullscreen if this policy is selected

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c       | 3 +++
 drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index f7a654b3a092..014e8a296f0c 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -853,6 +853,9 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 	else if ((spl_is_yuv420(spl_in->basic_in.format) && !fullscreen) &&
 		(spl_in->debug.sharpen_policy == SHARPEN_RGB_FULLSCREEN_YUV))
 		return enable_isharp;
+	else if (!spl_in->is_fullscreen &&
+			spl_in->debug.sharpen_policy == SHARPEN_FULLSCREEN_ALL)
+		return enable_isharp;
 
 	/*
 	 * Apply sharpness if supports horizontal taps 4,6 AND
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 425d4a282c7a..2a74ff5fdfdb 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -490,7 +490,8 @@ enum linear_light_scaling	{	// convert it in translation logic
 enum sharpen_policy {
 	SHARPEN_ALWAYS = 0,
 	SHARPEN_YUV = 1,
-	SHARPEN_RGB_FULLSCREEN_YUV = 2
+	SHARPEN_RGB_FULLSCREEN_YUV = 2,
+	SHARPEN_FULLSCREEN_ALL = 3
 };
 enum scale_to_sharpness_policy {
 	NO_SCALE_TO_SHARPNESS_ADJ = 0,
-- 
2.34.1

