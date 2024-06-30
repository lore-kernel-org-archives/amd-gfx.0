Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFF6C3065A
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7636F10E05A;
	Sun, 30 Jun 2024 14:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v9iOKmWV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1979810E05A
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO0pjvzfFjOZalbs1V1zzGPvun2qRXOhnWfQcQfrkRzaTurexNkvd/NQEJiZddWQJy9BrK28n3t1hP5YNYoyZog8cUkR1+nJEJFz0EZ0Y7pVbrIZBso6F9+WUbDtjJc0Rq0FrmP3suQ+wtxbPN1HC/T4er9eAcrpIGXWPzBDIzhahUkllcBJAlLG36aCGwNe5I6NkRFiuX00l7xF4u7zFvagj9ZahC2FPno5lVj7mbm7VOs0w9MNdp2bdzkwifrG9y7j22tV5011RWUsXzcR60YdSYe//kCOm4c+8naHpks1gpGHyaW/LTqUGmO+6tfEOwyv6MHz8hyuqykYlEG9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U/ykrpMuZt/8a2OuOnU1nMZFlf1PIAWnQbaPoInF/U=;
 b=iqZGLuEC0DRxFNkaqbq5+nS/3vwZTKeYWXveV/JjHcamyYFtf80H0/0p6w3CWe++1CpaAua+z03CSAEjLK7AAPb/RpFR3N+GrppllAcv6PHozNFknDf9bDoB5ZWlrQp2BoLGXmonJez3QqPNJtnGaIJlVPxSb0bdacWCrH/c3YmQSlPqd4teMQ37Hjd1N7rnFon9itw45ZuxUk7JaDXwiOvLR+4lhZQDnN5X8dCVbuq0T2rVgNmnKMTJjztDXPAkOV2e1/43PAq2jbTIs2OznGS8ywZ7eL33OFRxtckPnCnQS1PNJiB6bOADnSKNdG1yjPx+b8ylQUNzqpisVwhugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U/ykrpMuZt/8a2OuOnU1nMZFlf1PIAWnQbaPoInF/U=;
 b=v9iOKmWVkGMggR+WjQNVXMHK3AQrb1A9pxLTZ4tRSSmbW++Pkz/D5L3+1n5P5yZEE0at5Sc5zxCbF3wEtG4LXxIIIiO/qw89CzthO6bGCS3nvy5Pfot7tQzVmuutWDavs0SUmbBE4BcfYLGeyahubkX0xVaVFQkcFlkVGh+eUaw=
Received: from PH8PR20CA0023.namprd20.prod.outlook.com (2603:10b6:510:23c::29)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:40:52 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::70) by PH8PR20CA0023.outlook.office365.com
 (2603:10b6:510:23c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:40:52 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:40:49 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>, Li Ma
 <li.ma@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>, "Veerabadhran
 Gopalakrishnan" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: add GC IP v11.5.2 soc21 support
Date: Sun, 30 Jun 2024 22:38:33 +0800
Message-ID: <20240630143836.2015991-4-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630143836.2015991-1-Tim.Huang@amd.com>
References: <20240630143836.2015991-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: eea64104-464b-4e34-baa8-08dc9912a45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XBQ4ZyF80RVxZDJ+47kO+t9VqOHlO4zDM2G0emGlBHYsA2u/4+gTwfDd5xXn?=
 =?us-ascii?Q?tBiu7C1FobgWA86kg4/LymJKIsgga6Gu6tlnoDz/qLO/1g32lGTnJhdBHs8K?=
 =?us-ascii?Q?+SB+yOwof7rWqiTsdjr9zoz3scz610Xf596aXDxDUgb9qTYYxp/Ydt4uq3P9?=
 =?us-ascii?Q?Iqcv06JT+W+r+5AK0zAaAZHSqo/BhR7p4qGhdLXvHNtEa8J+SBP3lvaJgFf0?=
 =?us-ascii?Q?vAdq8wpA9fRP6+Gg2O2rin2FDjrmALdQAnKO2lloaXw3jWA/XvasQUGt4DRM?=
 =?us-ascii?Q?/G8g+ZAvI2VBD5C8Am8KlV/P5V98AfNLBExVzPRrSz0qwX1sRj9rFrne9fC3?=
 =?us-ascii?Q?3kuqN+VbDN4tpKTf8dKR8ivfI0AVRYN2y4X9pxuXpoR3Y+x9NFmHj1vQbb9p?=
 =?us-ascii?Q?Th44TgTHj7jX7S2G0uPKSYhW0dITNyCcq76NXL92TH+idNkUHkbfg33JcV8R?=
 =?us-ascii?Q?oIY3vH5gY9OsSo7/QQy636iICsL5gO8lsbFXhlW/Kftysq9ut74JrYHg0nsg?=
 =?us-ascii?Q?Tba0w8hBi5J4ivfEGahnp6KJtFvaim6dT2kmQxqa/CxY6cOy/0KMTJieMpVo?=
 =?us-ascii?Q?qq6v3Fp53FlvXEL7XPi2CH9GU5ORRdxtxbay32doo3bvAnG/E1ofuDLaD/ON?=
 =?us-ascii?Q?6SF7v6uhu3e8itWe9TW2uhFEb+k7v56PA26re5xTXYGER8fRSc3yQGDTQV/Y?=
 =?us-ascii?Q?J3Ju6XSh19tmB20bYeTl7U53YFbiQJUXwqEYAPJzdzbq036isxr/2GkiSjwr?=
 =?us-ascii?Q?i3ko1v2Drd+0QR8vruOQAgsUHcuOfqfOonJ/SQhlJzwfACQa09z7wna8dq+o?=
 =?us-ascii?Q?LPFYDrxqO5qpn/Ggzv0+SDyY1ebZ1EbYOivQscsGPbFx/NMLTaZU7tE9mv5c?=
 =?us-ascii?Q?B5PoIaVu3NirNG47aRMtVng8dQN9FmfkGuOhg0IeaoBlLuKyMKzKQ47jm/ap?=
 =?us-ascii?Q?Bp531/L7ntA87jO/Wy27EsvpKm9h8k0xz50uwSCDvbrOFsVzmRgnpugAcyAy?=
 =?us-ascii?Q?PbU9uR/rCK/nZ9e+8SrdklxQdhgzyG4BUE9QhdiJP83AQhopVBXrDSjItUa3?=
 =?us-ascii?Q?wAS5CTrd6mg5Z1q3KY+AbD9P/vv1eQ58bI5kbfo0lP3OONDZ8pZLdR2OleIp?=
 =?us-ascii?Q?oDjKXwYKFwNXMkUksv0JGIz08ozR9TtpE70XySB6JSdY4lfDEyDojnWs/nhz?=
 =?us-ascii?Q?zBjI0PYNH3VtlL5reYcv+774/9SUynFHg+uydexjjlPv9mX+knGRjO/45v1q?=
 =?us-ascii?Q?6tUTIwj0NiT0X6Y5zohkZMT1W1IoO4KU4iO2TnnuUkyXg6pDVVe03bHpSyVX?=
 =?us-ascii?Q?lxmcRD7ZD+WoSTROihiNEQoydCN68jDhZfxU+sDMK5yet+DbGa/CCCmykzDI?=
 =?us-ascii?Q?4YIOr9cUKho+8VMkXbtGBaLxOGBTIibZeKjpI/f8De2YRtGOwEN9h6O8G5SI?=
 =?us-ascii?Q?X/2aDV1MDumoXkm3GnNA668bEjayoeLz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:40:52.4831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea64104-464b-4e34-baa8-08dc9912a45c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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

Add CG and PG flags for GFX IP v11.5.2 and
PG flags for VCN IP v4.0.5.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 15845ecca7c7..b04c763015d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -752,6 +752,32 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0xc1;
 		break;
+	case IP_VERSION(11, 5, 2):
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK	|
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS	|
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_DS |
+			AMD_CG_SUPPORT_HDP_SD |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_GFX_PG;
+		adev->external_rev_id = adev->rev_id + 0x40;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.43.0

