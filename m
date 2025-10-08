Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B29CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17E310E8B6;
	Wed,  8 Oct 2025 18:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tInE+P97";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010016.outbound.protection.outlook.com
 [52.101.193.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED3E10E8B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO/XMRMfkCOOy8EvCZupT9pIJVICPQSAyfS3M8TbTfFoUcit+LRYARJE4URqXF/PRn5T0f04bU/btEro/DhjoGOwOQW0RaNcord+VW75LBUM8qk62TWg/T7HUv759bICWRjQqKzNlk+W/GfirVPy4vUAztaGZpCcfed/MCFaVldDJic27eH7GDCTIEkqBSriyZEff7VEE8u1hOmv3Iv7uTN9uX2AvO0SQZ7pMca1U3tTTK+a6H7d8vx2TDe8JXC1Y3ocbiMJCgUw+R8HP/jKybg1JVlB+e4JtFCOmpXgaHKC+RzuhjwKsUT+MwzU7k5ouFw7lZhTJa98BpZBy21GjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m42Tpufr1YC+9HuSeLxZs4t04CY4cqBj48Jr5kuUqf4=;
 b=rPq3lBEsY4+UztrXtHA6dA2lviWrHlvVIxxZXIaO+WUAYe6KcSALnKoNY+TUR3HMC+v72ywMdgGD3/WOmgB7n3z8oHiCcgipx0CSTEMs46scsm/I0BRo8PiR/3lZNDHXicaYzSYioOcp9HySyn5WD085Bugz5PTs7V51/qoSAnJ3e2mF4Y4X/5Z/CqNUBOpG3EnDBi/RbPGl6ONhnXxBndYEWWSUgmFhUJz/gFgvPdDZCHtXOXrZMzBT2pSpiu9QWIOXJx7B1FoGulEVZ6LYR1Tq05ufp/B2jtnTp5RHdds/qT4S6mDhEpEQMG28SMlxMXQjp8erfFt8zjPy6B/nbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m42Tpufr1YC+9HuSeLxZs4t04CY4cqBj48Jr5kuUqf4=;
 b=tInE+P97B6Cku0GzNENI/i9VVEfyjNmFFrA2RDu/nPpwdXJuUp7KoqTBC/dgqR3hUaGA2MhchVgcov54Rakbfyhxskr8ZNHTHiAML5PAmAF6YOCIY70WW2lbFiqX4u3teuIuC4rU6iovswgrbT2ZvHVEN7ooGqfVyE8RroKGS40=
Received: from BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:48:58 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::8f) by BYAPR07CA0086.outlook.office365.com
 (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 8 Oct 2025 18:48:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:40 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:40 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:39 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Harry VanZyllDeJong <hvanzyll@amd.com>, "Iswara
 Nagulendran" <iswara.nagulendran@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 01/22] drm/amd/display: fix duplicate aux command with AMD aux
 backlight
Date: Wed, 8 Oct 2025 14:46:55 -0400
Message-ID: <20251008184839.78916-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d93a7b5-274f-4c1b-5187-08de069b55db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/A/7q0l/agqMMJuaqL58Lqxt25e4cXPVnwmkPP/qg8vLkACOgcb072TQIKwx?=
 =?us-ascii?Q?JBWshd2Vje0elvSVU5kN5WLpMW+r9nN4viXDLpto7qpRgH9JjJVIR2cyz9g1?=
 =?us-ascii?Q?sZq8kwTYx/P4WP8KGhI0Qd3pImsCC+IeuzSq+nzfjWllNmooLCZ4KQdWJp6j?=
 =?us-ascii?Q?6yUAGrKWGgX2xNE2YTTNuWxZ2btGdlj0hEMXAKNhUGy87vaJ7DZW+QFbvGI+?=
 =?us-ascii?Q?VAzTrff8BDsKiofGdeozPT588r3HyPNnN9UaPkCvSK8QiPyV2lkNsaGnabX2?=
 =?us-ascii?Q?bxxStU//NmzJQgmAfAJ+rhe6iJsIxQoTRJjcy4bwMZiZkdNTyISGhJIML5H3?=
 =?us-ascii?Q?m3Kp+ARtNAcREKtJV2N/YEzNSmhaJsJ8pJgUicPhM30FizRoCC/I1jhNibcH?=
 =?us-ascii?Q?4yWYTsHsaG+RmjVca1oPBs1RPZ2nvmJzWKZ7bBRPLLrbDyl+yaYxFEk1pnDt?=
 =?us-ascii?Q?lK7YLCvHIp/B43n6/1u7MaSAINq4Fmr4SZiuEZbudCQwjiCZm8N6PAKm8aPJ?=
 =?us-ascii?Q?sGhtAifXtVvXxBRHioiwoEQF0tZTFws9OLLTtu9StZ3ecaVizPniBTcr4Xxz?=
 =?us-ascii?Q?wv4b9smQKNiRsseaX1huiKltD5I1nELwnQa29GhamLe9idAgDi7vcg/O74tF?=
 =?us-ascii?Q?Wn5Ab6MkTR5CXRje4uv/03TGWGxMAeOTLHe69SggYzEcn4nJboHxH5+4BUVi?=
 =?us-ascii?Q?CEiiYz47diIZnTGWdwpiHMxtj1Q4mQqjA70IRRUIGcNSDvfNcQQloeSh34yj?=
 =?us-ascii?Q?T06KBLroMHd7bJmBR3It334/Xrm9lY2wZTToUVz3Q7K/nRMfG4JWZGN2vYD3?=
 =?us-ascii?Q?CQ/bPxpDEpn0kuTf9IyoaKjXREdbrWiD0fp6jzT7lhCKTOlp+TQFA5x613+S?=
 =?us-ascii?Q?KsVNgrmJ5+SV8eFB2ed1XKPk37cad/FXYFzMMsmrGX+njgwb8osH83wVeQ1Y?=
 =?us-ascii?Q?4vGUjgDwd7xNdAF9z9RvojuxesqAMCGsromrss32c+I/iPqOQF06/l1baDdE?=
 =?us-ascii?Q?V4lu+SbHzoYifMTjiIiRhjjoa3oZAw9Sxwcqe9vASxenVsICg83hupEH8Xyd?=
 =?us-ascii?Q?Ii9t9a5SiNfvT+ILs0l2pzfEuWNO395QK6nxyW8SpHRQhki5XQHUkBn+kKCr?=
 =?us-ascii?Q?dtOTPUmMDEF/CU5yO3Zbrd4n5TdcZacy+FAXHjvDmvoTLEDWT1Q9L3wQrXqg?=
 =?us-ascii?Q?QlMWpQ1z1sQI8nbu4Vk1VUT2122SryC9tG+Q8BRRNQUiSdGnGoECTAo8hg1M?=
 =?us-ascii?Q?sGrT1cRlFeHwWkQNRTFtvl1J854B9T7qUegFEo+h4vf22b3C3xlih/3mRJ4h?=
 =?us-ascii?Q?lXOydmsGwi7vf5dp/umTSdjMW2wDPxMEAeXjj62wK0inSIwkQffmWdF61EwM?=
 =?us-ascii?Q?X3Ob3DSTzzPMF1HSNdIGxq9XixV5V/WOQ+jtt9aTK2dM3GQcIpU/iGcCTVcP?=
 =?us-ascii?Q?mtBon2WrF7aMEegLP/flikXEAi5yuDMeTQ9OEWlApkmo9AgQZZS7lekfnSF7?=
 =?us-ascii?Q?qzAqCglWis2ObKSlMhyak2koA23ZGlJp3SGr4WNFuUZhEyl989HkGsoFfVtl?=
 =?us-ascii?Q?y26+gzhjCWdlIKLTAN4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:48:56.1985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d93a7b5-274f-4c1b-5187-08de069b55db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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

From: Harry VanZyllDeJong <hvanzyll@amd.com>

when using AMD aux backlight control, we avoid sending backlight
update commands to DMUB firmware because it is controlled by aux commands
in driver.

Reviewed-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index b822f2dffff0..d1ecdb92b072 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -710,7 +710,8 @@ bool dcn31_set_backlight_level(struct pipe_ctx *pipe_ctx,
 			panel_cntl->inst,
 			panel_cntl->pwrseq_inst);
 
-	dmub_abm_set_backlight(dc, backlight_level_params, panel_cntl->inst);
+	if (backlight_level_params->control_type != BACKLIGHT_CONTROL_AMD_AUX)
+		dmub_abm_set_backlight(dc, backlight_level_params, panel_cntl->inst);
 
 	return true;
 }
-- 
2.51.0

