Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC31C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD423112C81;
	Wed,  1 May 2024 07:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OaJ04eu6";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE89112F01
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfKGArF85ENMOrlLFc2oYI9FZA2SRpUf6kCbSUvVLb5H5PpdjSBPacZNCnCEuc8rEePdpx8b57PD+N7YRYfDxfnCTuXEQmiyE7y0oU/zu2H3x6jZO31M57APJxfwopNdSCC5dLwDJzK5Bx0TNJ4Tj0baOktT1q6rdJfMj/iLx0viv2aCa7XL+cUNvr2nwUtOnidxbYtQfE8GBy4xzyu1nVhWafRxazLGI012wTRpBNHC36lURNVdzsqXXmCTywroJ8jnBogCge2M+FegTelxvQ8KGrXX3kOkNulOlcdKvFS/zS+XxnFeGnGjr/v7gPfWobOeBRw2Mt3wBwMWuLwIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIWaxT5NC8AtWq5v9J6GcMNXHd/QktyfkesLlXzRHz0=;
 b=koC7DnFibtU079wlMsbskP58zUL1ZcPbVwP4kaecNeLlsprsCIy3GdjnpM9t61TOMlcLS9k6YmGTPMktWV57XzF2TAHb4Bj/OvKHWA98ncl/NjtJ4ig+3tSCjZRjKZxwi4O6V5wc4TLCGQiIyGivmsw9makBA5Dti2qqLGQbVALWUZRB3DHMnUm85+gSHCE4VDDfq53nvjnjUNd+nKVP6KK7B4+Qx3NLjc7+k1kX+8Gr+llGeKzA0hmJVGgrhjnamGGLmVAm4H0V7bZzBa8nmPwyD+bJzRwG1umyFO1Vj0KEj/0UC8lKwsN5ua/nRQqZsZ+PAZbPqY9HJR188ULgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIWaxT5NC8AtWq5v9J6GcMNXHd/QktyfkesLlXzRHz0=;
 b=OaJ04eu6EhqBhwCmNAZGobAj3ERVRswpqykmUVFxVsYCZ6r144y9dYKexP3C8HuXboLMajON39ysG/4vnNymedoCryzQSwGN71BxcCaqy+6xXVH/Be6HqTvkbedMdAYn2B/6b8Vs8Khg8DTg5/rplBjTxEMQ/4W281RBrD9Y+Ic=
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 07:17:11 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::2e) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Wed, 1 May 2024 07:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:17:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:07 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:04 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Revalla Hari Krishna
 <harikrishna.revalla@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 03/45] drm/amd/display: Refactor DCCG into component folder
Date: Wed, 1 May 2024 15:16:09 +0800
Message-ID: <20240501071651.3541919-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 124d2135-1e35-43df-7735-08dc69aeb7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU1YRWZvaDMwSW9EZ1JqWXVPQ3VwTUVIMU5Ka2ZSTW5BYlJWdyt4dnA3aXdF?=
 =?utf-8?B?Mytmbk1BM2N2ZjVTWE9PZUowbzEyY1dMVEkwcndvUFZzS0FSb3I1cDFsOFJz?=
 =?utf-8?B?dWkwTTl4ZEMxdmw4SzNmcDN5bThtTFNENENpOUZwc1VHZ3lPTkg4SkswMUwy?=
 =?utf-8?B?YzZtTW1nU0ZRdDNTaGVIRWpkdEpEQi9POWJGM3JodDAwekdhVEhjME81VTVP?=
 =?utf-8?B?S1FjOXNPZzZNNllBZ0hmYVZSWlNHdGovUEZYaU5PUDVXNXdDMnowOFVoZisr?=
 =?utf-8?B?ZTBGcGVLWFhaditGMittb1pwN3ZDeER6dEdjNVBMWlI2WnFvTG1wRHRTN2JH?=
 =?utf-8?B?enE3aXg1a1ZjVTl5YmRsZzlrbW9FMlhtMEpWaXY1bEE2dXNQWC9yS204Snhu?=
 =?utf-8?B?S3d6OWVqTnR2N0pQejhNUkFtck4rTVN1UDRFSm1WQjJYek9oQVc4a0d4bDBu?=
 =?utf-8?B?M3R3Wm1JbkRDMW1oQ3p5M2hUU2tsZjJhS0REdDV2bVUrcG9YYnFnb2RiaXNx?=
 =?utf-8?B?S3podDJCZWwvelBaM2tBcDJXNkxRNE02SW1ydS9rRTVxakR1K0hBdUhUdTVw?=
 =?utf-8?B?Q3MvcXU3bzNldDAyczkyWC82cWY2VE5uUTVMUUllL2pEbkxsSW1zWHFVYTJE?=
 =?utf-8?B?Qk9RRUZ2NXRpb2ZMRXgrdzhzSHhhU0ZrYU5JaHFvZmV0amdrb0Q4WDdMUVJo?=
 =?utf-8?B?VDIwU29xNGxaQisyLytTLzBrcGF6dmlBNXdpMTA1TVNhN2V0bTJIeFMyb2xG?=
 =?utf-8?B?TStZdDN2MTNrRGRJM3pLaCtOeXMzQ2JnWUNIOGRudkRkb3FLMm9XdjQ3Qkx3?=
 =?utf-8?B?RTZvTFlRQmdpY1IxdzhYQytOd1VBWjZtWTZGdW96R2g2QWlsUklTTk10amFD?=
 =?utf-8?B?dERJYVAvbnVwWkRjb0hyOHNOejl4ZC9UTHp4NVVZOTZIMWZwejlqK0dnNWxn?=
 =?utf-8?B?VFlxZFB2WmhiUUsvb1lZUmFkT2NnVXJjMi9kSGtPRzdOQTJSVHhZNFB1R3Iv?=
 =?utf-8?B?Z1FKYmE0UHFFTjlkRHphS0pLTzh4clg5U2podnZBNUorS1Q0TGpWcVhWSnRq?=
 =?utf-8?B?QjVOMkxHSHBUM3VQZlNLdFU0RWtFSEtvWTNLeWZNMG55Z2tKOGJuOHM1d3J5?=
 =?utf-8?B?RVB1QlIxNlBmbkdhK1RZWlg1Zk5XNER1VmVSUmtIYUVHSEN3dVpVV3B6dm5E?=
 =?utf-8?B?V3FVZU5HemdTTDNSR05IZkV6ZG5jQ2JqTUhXVHdmcFBnZk1lV000VFY4YUEx?=
 =?utf-8?B?U1BzQndNa0R5MTkxWFM0WDg0R1g0SEJmV21wKys0QW44UExGNEErU0FpSkUw?=
 =?utf-8?B?RU5acWlpSWNYVkwrbnk5bThETi9kSHAxcGdnNTd1emM3R25FdjdIcWhPL21N?=
 =?utf-8?B?YjA1V0x0cTZGQTltWmVieXk2a1JZQnF2RW9oekl0am9oOEloYXdQQTNHMEhM?=
 =?utf-8?B?SzczS0c5T0Y0K01YaGZwN0sva3FIbXcwMTFqU1kwbTArMGM5SWxNVWxEU20x?=
 =?utf-8?B?THlQRC9jUjlVM0R5MElGTkRDNlA2WXhzb2xvZ3lpSkIxRjc4K05VNGFxakhN?=
 =?utf-8?B?QTI1ck1tV09EeStmSWZpL1hmUjgyZFpVUzVJQjlJRE5BL09aSjYxd1RpbHhD?=
 =?utf-8?B?ekxzWUovZDR4MllNWEYwTzR1SlpkODM3WnIzSC9oQkFFN1NScE5jdFlxdjhv?=
 =?utf-8?B?ZEd0VnVSc25CYUJucVlmTG0yTXc0NnU1MDF5VGkxZk4wUEQ1a2kreTM1SENh?=
 =?utf-8?B?RTVHdjdxOHVQSmRkNHBtazdxcGhXVnlRMDZVTkR6YVdlaU9ML25qU2ZZOEFF?=
 =?utf-8?B?OEdCeVhWV1lCZXAzR0lkTEUvZ3lDNkRucTRqOEpRWWRyL3J2ZURoRVBHWFFC?=
 =?utf-8?Q?hlgi6ziGKr7fJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:10.8064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 124d2135-1e35-43df-7735-08dc69aeb7cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
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

From: Revalla Hari Krishna <harikrishna.revalla@amd.com>

[why]
cleaning up the code refactor requires dccg to be in its own component.

[how]
move all files under newly created dccg folder and fixing the
makefiles.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Revalla Hari Krishna <harikrishna.revalla@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |  1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 drivers/gpu/drm/amd/display/dc/dccg/Makefile  | 98 +++++++++++++++++++
 .../display/dc/{ => dccg}/dcn20/dcn20_dccg.c  |  0
 .../display/dc/{ => dccg}/dcn20/dcn20_dccg.h  |  0
 .../dc/{ => dccg}/dcn201/dcn201_dccg.c        |  0
 .../dc/{ => dccg}/dcn201/dcn201_dccg.h        |  0
 .../display/dc/{ => dccg}/dcn21/dcn21_dccg.c  |  0
 .../display/dc/{ => dccg}/dcn21/dcn21_dccg.h  |  0
 .../display/dc/{ => dccg}/dcn30/dcn30_dccg.c  |  0
 .../display/dc/{ => dccg}/dcn30/dcn30_dccg.h  |  0
 .../dc/{ => dccg}/dcn301/dcn301_dccg.c        |  0
 .../dc/{ => dccg}/dcn301/dcn301_dccg.h        |  0
 .../dc/{ => dccg}/dcn302/dcn302_dccg.h        |  0
 .../dc/{ => dccg}/dcn303/dcn303_dccg.h        |  0
 .../display/dc/{ => dccg}/dcn31/dcn31_dccg.c  |  0
 .../display/dc/{ => dccg}/dcn31/dcn31_dccg.h  |  0
 .../dc/{ => dccg}/dcn314/dcn314_dccg.c        |  0
 .../dc/{ => dccg}/dcn314/dcn314_dccg.h        |  0
 .../display/dc/{ => dccg}/dcn32/dcn32_dccg.c  |  0
 .../display/dc/{ => dccg}/dcn32/dcn32_dccg.h  |  0
 .../display/dc/{ => dccg}/dcn35/dcn35_dccg.c  |  0
 .../display/dc/{ => dccg}/dcn35/dcn35_dccg.h  |  0
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  1 -
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |  3 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |  2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |  3 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |  2 +-
 32 files changed, 108 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn20/dcn20_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn20/dcn20_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn201/dcn201_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn201/dcn201_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn21/dcn21_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn21/dcn21_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn30/dcn30_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn30/dcn30_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn301/dcn301_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn301/dcn301_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn302/dcn302_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn303/dcn303_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn31/dcn31_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn31/dcn31_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn314/dcn314_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn314/dcn314_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn32/dcn32_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn32/dcn32_dccg.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn35/dcn35_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn35/dcn35_dccg.h (100%)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 839e71aa7d0c..641073fd7e33 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -35,6 +35,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dsc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/optc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dpp
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hubbub
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dccg
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index f1b0b1f66fb0..e0c67f4b9063 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp hubbub
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp hubbub dccg
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/Makefile b/drivers/gpu/drm/amd/display/dc/dccg/Makefile
new file mode 100644
index 000000000000..bfdce98768f1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dccg/Makefile
@@ -0,0 +1,98 @@
+
+# Copyright 2022 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Makefile for the 'dccg' sub-component of DAL.
+#
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN
+###############################################################################
+
+DCCG_DCN20 = dcn20_dccg.o
+
+AMD_DAL_DCCG_DCN20 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn20/,$(DCCG_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN20)
+
+###############################################################################
+
+DCCG_DCN201 = dcn201_dccg.o
+
+AMD_DAL_DCCG_DCN201 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn201/,$(DCCG_DCN201))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN201)
+
+###############################################################################
+
+DCCG_DCN21 = dcn21_dccg.o
+
+AMD_DAL_DCCG_DCN21 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn21/,$(DCCG_DCN21))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN21)
+
+###############################################################################
+DCCG_DCN30 = dcn30_dccg.o
+
+AMD_DAL_DCCG_DCN30 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn30/,$(DCCG_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN30)
+
+###############################################################################
+DCCG_DCN301 = dcn301_dccg.o
+
+AMD_DAL_DCCG_DCN301 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn301/,$(DCCG_DCN301))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN301)
+
+###############################################################################
+
+DCCG_DCN31 = dcn31_dccg.o
+
+AMD_DAL_DCCG_DCN31 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn31/,$(DCCG_DCN31))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN31)
+
+###############################################################################
+
+DCCG_DCN314 = dcn314_dccg.o
+
+AMD_DAL_DCCG_DCN314 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn314/,$(DCCG_DCN314))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN314)
+
+###############################################################################
+
+DCCG_DCN32 = dcn32_dccg.o
+
+AMD_DAL_DCCG_DCN32 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn32/,$(DCCG_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN32)
+
+###############################################################################
+
+DCCG_DCN35 = dcn35_dccg.o
+
+AMD_DAL_DCCG_DCN35 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn35/,$(DCCG_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN35)
+
+###############################################################################
+endif
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn302/dcn302_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn302/dcn302_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn302/dcn302_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn303/dcn303_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn303/dcn303_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index c78f3b0ff4fb..33cbd871eb3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -3,7 +3,7 @@
 
 DCN20 = dcn20_hubp.o \
 		dcn20_mpc.o dcn20_opp.o dcn20_mmhubbub.o \
-		dcn20_stream_encoder.o dcn20_link_encoder.o dcn20_dccg.o \
+		dcn20_stream_encoder.o dcn20_link_encoder.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
 
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index ba688bce4951..7b7acadfccf7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -2,7 +2,7 @@
 # Copyright © 2021-2024 Advanced Micro Devices, Inc. All rights reserved.
 
 DCN201 = dcn201_mpc.o dcn201_hubp.o dcn201_opp.o \
-	dcn201_dccg.o dcn201_link_encoder.o
+	dcn201_link_encoder.o
 
 AMD_DAL_DCN201 = $(addprefix $(AMDDALPATH)/dc/dcn201/,$(DCN201))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 81d565d84ff0..720f1a463b89 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -2,7 +2,7 @@
 # Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
 DCN21 = dcn21_hubp.o \
-	 dcn21_link_encoder.o dcn21_dccg.o
+	 dcn21_link_encoder.o
 
 AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index 435979febb79..fb7471435c69 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -24,7 +24,6 @@
 #
 
 DCN30 := dcn30_hubp.o \
-	dcn30_dccg.o \
 	dcn30_mpc.o dcn30_vpg.o \
 	dcn30_afmt.o \
 	dcn30_dio_stream_encoder.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index bfda72fa4f42..fadf5e872e38 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -10,8 +10,7 @@
 #
 # Makefile for dcn30.
 
-DCN301 = dcn301_dccg.o \
-		dcn301_dio_link_encoder.o dcn301_panel_cntl.o
+DCN301 = dcn301_dio_link_encoder.o dcn301_panel_cntl.o
 
 AMD_DAL_DCN301 = $(addprefix $(AMDDALPATH)/dc/dcn301/,$(DCN301))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 9608c1f418ab..7daa2f038c97 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -11,7 +11,7 @@
 # Makefile for dcn31.
 
 DCN31 = dcn31_hubp.o \
-	dcn31_dccg.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
+	dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
 	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
 	dcn31_afmt.o dcn31_vpg.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
index b134ab05aa71..cac756c75b7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn314.
 
-DCN314 = dcn314_dio_stream_encoder.o dcn314_dccg.o
+DCN314 = dcn314_dio_stream_encoder.o
 
 AMD_DAL_DCN314 = $(addprefix $(AMDDALPATH)/dc/dcn314/,$(DCN314))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index 8a6bc529f376..dd3c4e70bce6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -10,8 +10,7 @@
 #
 # Makefile for dcn32.
 
-DCN32 = dcn32_dccg.o \
-		dcn32_mmhubbub.o dcn32_hubp.o dcn32_mpc.o \
+DCN32 = dcn32_mmhubbub.o dcn32_hubp.o dcn32_mpc.o \
 		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_resource_helpers.o \
 		dcn32_hpo_dp_link_encoder.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
index 09fd994ae158..eb70d5f4e90e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
@@ -11,7 +11,7 @@
 # Makefile for DCN35.
 
 DCN35 = dcn35_dio_stream_encoder.o \
-	dcn35_dio_link_encoder.o dcn35_dccg.o \
+	dcn35_dio_link_encoder.o \
 	dcn35_hubp.o \
 	dcn35_mmhubbub.o dcn35_opp.o dcn35_pg_cntl.o dcn35_dwb.o
 
-- 
2.34.1

