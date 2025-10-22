Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5B5CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618F910E709;
	Wed, 22 Oct 2025 07:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4mtU8DN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010064.outbound.protection.outlook.com
 [40.93.198.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1DAC10E708
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QA4SiV2LE6o5PyuVPVYMZrvxzHS316d/5H1kESkPt9HZwbmr/ttRX6o0PQRXk5i0snSnnagQS/y0RrmVZna/FrfW0XLblQiN/s/oeZH+EYjjhekv34WcrKH5eVAjP6o1t01dq/nBIZC6G/sTq+v2VA31Q1/08AIqZVZpUyoWragy8rLMdnZdJ00HCUJ6iI0Xg6mcA9Pay6aBqIGmbsZrvrGG7oZlOYaZqAlAIXb+HClwBnsYp9qfsm1xJ4j9bsVbsB9jQMsLzT2LdsKcNdGw3O3JRPt20WbxH2kNbRiklwLr2fZsqaEnV9WWfdiL2+U4Q2DhGEwXgh/IxwaQUBExvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDT5xvT9MFBm/2yKheTvBR4cSyo9PSV1PlEEXVGxjrY=;
 b=RG2vpP1m+NNszyabXfSsgYg2PpkJcA+8+Aa6PHbyfiAoNFR3wWi6Bdjp5lSNfkmakXHdxj1dJFlJei39z/MrORxM+icbs/WBwPCieS6NLew9IU9nL+JMP9Vfk9Md5q47JOHuI6yMdazHWNFOvUnZM+rTzmk1kEUB/YTEeOknXYa0qLfjkDlUr3OyjiYAQC/mnLZoeGWklGV4uFBZzg6IamMX2k6SkvpctZ6Yu5m+PBm5YvTE2nu3uZrxp4wDxmweugH6W4oAd+6rW4mNLSl6IENHsHpzFhTw5WvQw/rRyJH5zgviF8EoZ+d2m5FxXyW8Plp+n49XYMx0UgA+9epjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDT5xvT9MFBm/2yKheTvBR4cSyo9PSV1PlEEXVGxjrY=;
 b=C4mtU8DNpNTDOSilnYJEC5t6kne5XOvFgUJ/rWp4Fbqzdtz5m68ueJC00D5ulLgNjeVzs8dSpchfPBn3/7rV9OgrrJbv3orscR49Aj9YOCzLKLtfsUWfkDe8C4Gwamsjv9iI/+Z8C/unW1Hbl0BMcO/MWkrTGm85OR5NWeH0n7g=
Received: from DM6PR02CA0138.namprd02.prod.outlook.com (2603:10b6:5:1b4::40)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:35:34 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a) by DM6PR02CA0138.outlook.office365.com
 (2603:10b6:5:1b4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:35:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:20 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Oct
 2025 02:35:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:35:17 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 20/20] drm/amd/display: Promote DC to 3.2.356
Date: Wed, 22 Oct 2025 15:30:32 +0800
Message-ID: <20251022073332.666119-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cf1bf8-277a-41f2-e5be-08de113d965f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cv68JzKZE+NzNA5Tbqnp8jZIpXnENiU821EdMwvr1UQGHfnbKniuyue9vbxo?=
 =?us-ascii?Q?pSGXVf3+i6ft5tLmQVny/xVQBHIci/30cV6VXhx2toyrQCGhJ6LWWOnUfim8?=
 =?us-ascii?Q?P2ycGxRCtdKNqfd63SK5X4pHVJvo/5X37aOIIZ0U53Neor3uIjdVJCDuMPkJ?=
 =?us-ascii?Q?Otyv5390YLW/ZoCk25qx4ExXdgSfQ7vvM7bfCSu6skAjaT7yJhB4VIj4eAc7?=
 =?us-ascii?Q?uINBOzfcQ/84vT6EU1R3IFaiweCjJupvabFq0iiGEM1DTulBJ05QMre/qI00?=
 =?us-ascii?Q?it59aFq7UDiYF9acGneyVF2gmgKGLFORKrLSkSOdH4gMsSkVuwN7YKGxuGb8?=
 =?us-ascii?Q?scE92tkCFWn6sMTapLCtBRMDXCMVs1sgM8r4OkZIoojCFT1xzGxyTTfBrTft?=
 =?us-ascii?Q?o2UGhyYoExW0kfo4/EMHQwvWILfd4981pGQBUNlXL6RTMmbEdBzJxn+x3OHw?=
 =?us-ascii?Q?OkeLm2gKznCfBdvVekuNk3S4xytwvwJJ2Ia9nk4bJ3IpOT0rZvIvuEUDxw08?=
 =?us-ascii?Q?qi+mdOwlTZnPLbMOxnpBfx2Vs7fUcWBTNnfue6IuOwhocIVMRLIJsPnJjATd?=
 =?us-ascii?Q?hMqAf03wt5qKL5vpGI8NSUaNjsuklsKIHwqbUQq3jhle/JdtiujTZaeIDqkk?=
 =?us-ascii?Q?F5XoCqbrlrzyhXnA/eT5xa+0LsEwFB5BRQSzAgQLReeYIBUYuzTap5fMmIFa?=
 =?us-ascii?Q?LckgU/K7phvOLXVC03g+Ra2E6PKQjH5052/paBOov5NlgXagMe1EI8bEEgOK?=
 =?us-ascii?Q?ppu8KCyUtq3Vy4rDmLRSXNpsrZInbPo3SigYIucSFDkLvZkS9ayRhcmVIIC1?=
 =?us-ascii?Q?bMwBkyW3TJ4q3jUGhpJxtZf29VAJVpCAnHKRTF9GJZQnpxEJgDzeFoxyXRM4?=
 =?us-ascii?Q?PebzUmOEqGII5jMp/zOsLLrtOframOGtd0bQCrjBe1aQZSs6R8DJp+1mXDO+?=
 =?us-ascii?Q?kN16QIG1SGMF5IRibWP64IA7P1dv/f0PWlqpYVfs3W5NsuZVR4Ljcc5NyD1N?=
 =?us-ascii?Q?iMNVWhAM4uWOIuNR9jrN76FNK/c3v0Xq46fcAJnvmf4o4GZ8B70dJNswxcbr?=
 =?us-ascii?Q?Vyf5FdeF9vW6AEzdqVbXh053qszLh8fdiGzAnT3UAVSKia6P9W+E3O8rWHfi?=
 =?us-ascii?Q?dODJJz1TnwTVR8S57B2cJoldhK4h4K0f9UsdAHGmm06oieMX0iP5eCa13oq3?=
 =?us-ascii?Q?zOdA2pTkaK3KlzLy6DKLjg4QyNB9A75xWe9ZmBMKfVrfwp2sINsCJHz6MYic?=
 =?us-ascii?Q?PI4dx/HIc6RE+chYjr8Xn1T2rlvM9qb7oqtOTjhDHmOmTyhADWjtAMILaqkM?=
 =?us-ascii?Q?iZTyhg+yb1a4xUy3xqknDnRstdN3lG7cXPTLp4/wLu5J28iuGD7+OnkUfbZx?=
 =?us-ascii?Q?D1sz1gaNbKzSiA19PksNgzwfKL/MNyYB2JtssIlv+ohksogWwsvI864F8T6v?=
 =?us-ascii?Q?hzo8B2QixsZqjT3mSmXW6Hj1daZyMb4KNJmDPFweH+FjtI9HrBds1UxrBKlb?=
 =?us-ascii?Q?E1apZvYKhKsXUluEgiYKZjVw3XdOwScQUfmVLJiRUUCR2Sx5HJyyuSpLQL3k?=
 =?us-ascii?Q?ZW9e+vj9PN84pbi7z1HtINR9fOpVgJ4gvviuyLay?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:35:34.6113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cf1bf8-277a-41f2-e5be-08de113d965f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following update:

- Fix incorrect return of vblank enable on unconfigured crtc
- Add HDR workaround for a specific eDP
- Make observers const-correct
- Add lock descriptor to check_update
- Update cursor offload assignments
- Add dc interface to log pre os firmware information
- Init dispclk from bootup clock for DCN315
- Remove dc param from check_update
- Update link encoder assignment
- Add more DC HW state info to underflow logging
- Rename dml2 to dml2_0 folder
- Fix notification of vtotal to DMU for cursor offload
- Fix wrong index for DCN401 cursor offload
- Add opp count validation to dml2.1
- Fix DMUB reset sequence for DCN32
- Bump minimum for frame_warn_limit

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 811098b5d7e4..75c7339bfb5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.355"
+#define DC_VER "3.2.356"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

