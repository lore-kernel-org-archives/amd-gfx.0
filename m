Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B97EE87834
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3100C10E340;
	Tue,  3 Feb 2026 15:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RDyTJ8TG";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1649510E340
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkJSCg9x0dBkHZiiW8/AYoYx/nOTU/5mmRkW+ykvAIzMrPr37EWnGO89EG8wPfg1H667BxiznTt4lncg8/HT6hmPP2silcdhYyyvVGGq6jZbRmxnSrvner+Xq9cTa6h6WSjJKVnAHoe/a91fiOGFuHgh74DsR4zJESk/woHMYDSlZ24bq4bUy4kT8E2Ttp81m4TvFlH8mtnhDWjOmf26+C0eFPLMdpBLj+0KkcoKaZnQKrL0s8B5IYR+uqG0/h+APj/hN/Rq31f9OcDe5b1IIRDfNnBxbBw7AZPcMLGZHO0iyStXWPubOd6fmJlpPzalgNgDEW8uqshk3qa9D3Up8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyrMBRaE+SddzqBCvqTfpUFU3hbjg5s5aqfQ7UkfiHY=;
 b=khG+GauDAvGkwuJHb/XD4gzXJtv6K+hi4LntUO08updyE0gbrx6paj0QEsoiR2i+lnU1c++tUlr7UIe6T+7M44xxw2VkriiNKqlbM4YlBSIIB6aopflD5mECZ6yBBzGXxHOLRpWA3GbIpNEDo8/DGEoDeE5cIzF0+bIUzGkUddoDDheFZsjHNA5CQwBLazKrMFEaGR4nLsqWb02Bwn7yJiW9rHe1LxQ8QNNQBsYzF1clzOcok+OMF9UqS7hYRn1PrU0kgOj2geRZuuEb0Sjugl7eA+I+9OuvT58p0MDeN8LsKufoHxgtYmdSYpJrPPb21/iuTUiAlEMWDTOxs9oPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyrMBRaE+SddzqBCvqTfpUFU3hbjg5s5aqfQ7UkfiHY=;
 b=RDyTJ8TGCCwgKl0tYmqKl+xBlbmfyP8RIAYIQpdCK4Tvpmq6Ts0cdqIXLGFOLCetT4nozka4qiVwNpN9o5BOSfmKUmjxHBDMzwWy9xSDIx7OgYyn9gLTMihmMbaTmnk12LFHnCIHsdLsurAJhAYbgGU+RHXFRLjods33YMPunSk=
Received: from BYAPR11CA0105.namprd11.prod.outlook.com (2603:10b6:a03:f4::46)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:21 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::74) by BYAPR11CA0105.outlook.office365.com
 (2603:10b6:a03:f4::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 15:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:04 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:01 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, YiLing Chen <yi-lchen@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 03/16] drm/amd/display: set enable_legacy_fast_update to false
 for DCN36
Date: Tue, 3 Feb 2026 23:01:45 +0800
Message-ID: <20260203151229.3673042-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d50dd2-1bc5-4875-e6b7-08de6336c4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WXGdKqFPklZ+3kTGFjBiFeMYk+RoWe4MPjkh8FTH8jrvAsrE32yjmAzVbIJ1?=
 =?us-ascii?Q?QgMr4p4jfQ0XNrnx/3VB8VL3lVmqwqOL+iBecVPZ2w4v/ZG7S16tSQsUYv1l?=
 =?us-ascii?Q?lcaC/2Jst4DofY2riTmU9jFLcUTEzlbHQ4TFSZK0K0HqfULDhy06r8T97KvX?=
 =?us-ascii?Q?yf+poDWMkEd6pTOwSIMBXJUWw7Fn8TahWfV9MBjHZFNMbCT81KG28OUyjMwI?=
 =?us-ascii?Q?ldbtQeEYqunR+ega+qaDzShKOj80shgis0kTiQHgMCEIqeJToR23IaDoP98R?=
 =?us-ascii?Q?eHrHekikMmraTFl1R0/sXHJzunlcPN6SPAgFihkYBrfwXrKNqVxCcOTorfts?=
 =?us-ascii?Q?ORSycAkjJuJ1c9Vy6K7XU1ySXSX0Ux1WfhOxGcHsqnK6Cwv4Nw0gvMDcpigy?=
 =?us-ascii?Q?83VephjiJhKx2HD92slNxt2s36xSblZKgISin65Vm/BjGwmEsFtpYo2VYvhq?=
 =?us-ascii?Q?GAYEPxMvsw2HkSxUaBKXM9cM+57zfHlUKH7ES0KDi1lg31LsoTI5m9tTt6a1?=
 =?us-ascii?Q?5VLMPyva9MDxUlvtwU4DkvitmzH/MpZEnw8q32mMOKBY/q9Zwnzzowy7jnB6?=
 =?us-ascii?Q?08UdyEOzrA349HLcoRPKmK2WKTwEiyhMr6IxDj6T79vbS88BKpjEe7p8m+mG?=
 =?us-ascii?Q?wQmXwM3u/qYY2dfP0A1se7760eMtwki0hUOr7P6qjTnSbxklR1q2eYWRe3zh?=
 =?us-ascii?Q?Ljij6pYJd9mlvysd88s4abEbg8GAi6Qp6zVzrB+6f+THXvD16LbYJDaf7HNx?=
 =?us-ascii?Q?KOzinr8KArOT35qjyR5gPU3tVlBBb1A1Zxwc5txhmkKGgEzwpDz+ovplo8Ux?=
 =?us-ascii?Q?bxjJeQMpv8Jw4wZD1mexwD9vNiUGWpa2KjldTb2GZGH0QBRLA/HqBbKGvimW?=
 =?us-ascii?Q?EGS++erykZeHCAudO4Qc43tn58Fti9kIZ9HqDlBbR91LjLN1bJkQfTdvUOc/?=
 =?us-ascii?Q?yzhvwInjVPb7JC5Zm+SAmCfV3rLhguEWUSS9Izgjez18GsMvjnU5FxBO17ke?=
 =?us-ascii?Q?7NHm43LleLBZMeRHAEWpiHmLQaCOR/2AbeNp0j1p16qRMK0RVW9DNE/TQpzZ?=
 =?us-ascii?Q?YWz3N23IUvMONRjx05iA2jLX+LPhLeOMPLZxagtYddS5rfadzJCAgbXUHNTM?=
 =?us-ascii?Q?/gFWOvDOV3t0JT6sfoJoTKKvh+W68M4bHxrgFMa58u6FENPE9xxEayGlaUPG?=
 =?us-ascii?Q?FAQemvqQXlXCZX5V+WAhETj2L/sj7S/50zLm0H+4u0jVn2wGfwASQ/8Co9bA?=
 =?us-ascii?Q?UbJ5ZolOwdyjWUiMv7I4EB0CY7lW0t0K94F2+t3Xrli/LYNZHGxO2pvIKa3q?=
 =?us-ascii?Q?aQeA4V6TupruZcOpDd1JFyUkdRxI5YCe1uo/wnWuPsmJPl91uHQdMBOtNt8p?=
 =?us-ascii?Q?mtgcTiYhu2/hmd6jPZbbE69MkyjeXAn/qCbnJ3gW1y/5/i5STY7tINT1wRxc?=
 =?us-ascii?Q?wnAwZHMKSIGJMvxz2wGIs7vOcMpo/ChHWu5NQldEHEzo8AxGBYMhSs8N74QB?=
 =?us-ascii?Q?hAHLFEzEYzzSXtE/5c9rInPsrGNX6s98U4rncqbAvl+RLGE2L0FbqKZ0wa09?=
 =?us-ascii?Q?uOS1VtVSrmDbYKrC3qc6mP3jZ1wWTFz1Ku3MZMwvHJFfl7YopZOZ0Uj7HV1E?=
 =?us-ascii?Q?KDwKmor4Glva7tzHJcfRCucavUn2JOSBawb94b/D7lFqpkEJcSAw+1lOz1HH?=
 =?us-ascii?Q?rk1xxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b1U2N0h1Go2Rztykh22h8ay0Kwk6hF4E6XYBudv40atF0IciJqzAqTMDRVB0M5Al3/GlYeLKAN71QFm4Oqplt/86Mu7l0ORUP332CeqdZiV8yTv7+t5sK4zTHWjyWo97/qcXYwHeI6k5BLDrDXKlRjIfXcDmQt38ovoAxDZm8HpopYKAqhrtLeufXShDB5X9Gs+yJYtFxfUFjbHsiwoS26Pt3zvnVPolbTeKssX4efsqxt1dq1zDcdCwwiGMlVNWfFVqDoPYdtm4IbE6lbpqAaD3IrTY2Y9kpS2707rP1jERIv4W/ppDaWf7NyYg05grSIB20+CMT7DR8HQs5YiPO5cp+bPh4hKKKngcYlwkA/A+roqljneEbwYScm15FPVmqCJpdmBxqb6TenD7fepPnIOAjE2Jq+9zcQtGy/m7AFPNQu49iZ5WjXQBGQ81h3qB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:21.3225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d50dd2-1bc5-4875-e6b7-08de6336c4cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
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

From: YiLing Chen <yi-lchen@amd.com>

[Why/How]
Align the default value of the flag with DCN35/351.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: YiLing Chen <yi-lchen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 0ee16926db4e..1d8ca312fe1e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -775,7 +775,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 };
 
 static const struct dc_check_config config_defaults = {
-	.enable_legacy_fast_update = true,
+	.enable_legacy_fast_update = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.43.0

