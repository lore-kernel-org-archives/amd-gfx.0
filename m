Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A26FE9A04A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C040B10E5FD;
	Wed, 18 Feb 2026 16:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgJfccSO";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E35810E604
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsknZQ9npJy3T+BnSsGy1zHh92Zmr1x6Yv+sCULjRZJvbvSMnoohoqHnB/hk+NqjHJaxtdV3cZm3HwvtejFRtCRE6gVBJDqSRq6Mb0vYJn2d4JbtodAJqXl9JytadhLaIl59x1QbEmnm2vgOKQxPACDKxNTTmwsZZiB9sxd2PfRgnoZAbY/1RXjBxNvSl95FWGZ+qyOPhTbiv1fBFgRg409TlaYTZrhAKW/ZTBU02jsqVzKaOGZfzix/fopw+uqZ2o+x7gFbOi9Humct7g/s1G6kUCKkblrAt218VxwWGU2a6fghM+MFwhesLYcPm5nwYzgfBkQiK02LhptdbfgOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HRAtwYk3Q5jMeST5DwaR6VHzA3vsJc5fbgSqMdo7EA=;
 b=Ti0iG5NUBRaLsNv1DHxSzYf81/SnSnCDI7VD9maD/qXuU8HK6Gad/XfFlbJ9xTm8zgMaSGNfCl1NuehtJWdlIIGMgh0V53Xar2pZWRGIdCU85HxzkhgrUsPEeDR24sOSEIvS7m4ly2ASzTL13OYRbFzorugcswq2AUaRFrxYVg5dcCh3+o8aC2VV4EMLxPoLHy1l3HM4rrZGAYhX7sKq6aWXTrV8YyUYXSuql9PGBNu2ThNUyz4U/Oe6D0YT9E9PDnb5T1MjC54YZnLFpla9kRoVe9No+4vdzW2bg3zZjH39qIH/UgVlG0ExLgd5XH+MscDyIzXgAv63vAOWpaFa+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HRAtwYk3Q5jMeST5DwaR6VHzA3vsJc5fbgSqMdo7EA=;
 b=lgJfccSOAELRp9ut5nuRB/Clwfh8nDItXgUuB07f76nTyhmrS0DuBz+WlK+wO4gDtqrGF2rgA+yhTXGqsiyCMczXZVJsnYdkFItLgvAhD8lKKlwjcNuSgZmgEmMhw8Phr4YR+r4FnXs7dUQ51K5/OxjWRzp3flKymXRcGaskShY=
Received: from SJ0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:a03:3a0::28)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:51:39 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::fd) by SJ0PR03CA0263.outlook.office365.com
 (2603:10b6:a03:3a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 16:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:23 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 08:51:23 -0800
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:23 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Aric
 Cyr" <aric.cyr@amd.com>
Subject: [PATCH 4/9] drm/amd/display: Silence type mismatch warning
Date: Wed, 18 Feb 2026 11:48:05 -0500
Message-ID: <20260218165116.155001-5-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
References: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4f8377-696d-4e32-3d49-08de6f0dfaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9iLiFFXWvXim3Z0z6H3xDlNd6GESpbCsFRf75NcEvzF6xS1m6ztZvwXkKUS9?=
 =?us-ascii?Q?fbW6Phw3QAxLcgjMeDrzdoTmWCH4vz6iO038Fgk/pNIcFGyTDdLsecULPPkk?=
 =?us-ascii?Q?Avn7LJ9ibUF3rrXUKV0ZanZLJwES1mwxGTdtk1auYpBxQYUvi+nWcfVPdq2p?=
 =?us-ascii?Q?lIeD4JQT0pXtyHs2DFuaiQ+4GzcKTk1gxvFiStEDoBCxEWEvVQiM+rjuVO0f?=
 =?us-ascii?Q?hK0Qh00L3MQ98UiM11rZ9hy9+GhsmA7slnXdZPn5UvT/ZHVa+QonXC5npNrX?=
 =?us-ascii?Q?xOUx6ySA0gSoHsYIFiCOpaLb7Ep5ld3tdn86NffdJOJSeUhEj1ZFGZQzMS/4?=
 =?us-ascii?Q?INld4FByr8mt6r6sD7cBbKQUhUWMaKwliR0+c35l5Jk7BxBGQOAUWC7rvclq?=
 =?us-ascii?Q?9gocOSV3PfUfJWR4qFa5s3NVtnGvXZiqfKTGpT81a+8kYwRJ77uG4pikZnS4?=
 =?us-ascii?Q?0quP/eqQsny5E+0Vx+Kg41PqAQ4NxDuWnsMZh5PdwE0XQeJm/C9/jf5RjWi9?=
 =?us-ascii?Q?h72d/GpeK/nBE3Eu7a3Yi1WcgnrefTEpNILxEid1R/IwcsShb4taCF9t0Aea?=
 =?us-ascii?Q?zUamJfC0/PDs0XrHkXucIq2WAvP0b89RxO7mZy/rJwAcE39mqP5EDMPWSmj8?=
 =?us-ascii?Q?7UUWpAqFz6UQrZ+IK4p6PPdzX/en9M4iMWsWAu8isW0nABUP9u1Fep05MF5c?=
 =?us-ascii?Q?TRMWBtFh9eVX0Lo8eGPI7g0L497gT9+OtI9NDI7wbGUB5JR2LNmugT1wEBME?=
 =?us-ascii?Q?KORxx/5XYalEqwSzGkp5alk7P19el8UTfJ8YJkIzkVYepz9i7/INaxZwxUCp?=
 =?us-ascii?Q?0i3hL6/zdYxXwYCKe+MX/GZowH3lAVVr0SfHP1jBfLdpraf9BfHPhZs8fVK+?=
 =?us-ascii?Q?BycDRkIq82eH15Tv+fBjb5SaffWtMrPRlRbID6FmAwfXTbsPCEezXQ84BB8P?=
 =?us-ascii?Q?ETxd3QkGLHAOMUkSfQ5u6E8pR/CZT+nPEQ3mnzz3/DF7V13Ix5RAdV0Mstrc?=
 =?us-ascii?Q?CVHFIygad0sLN/vIdly/TuxsVXKo34IJ2SrTzSjoIMLIvUCwpNAygLvtOuQb?=
 =?us-ascii?Q?xP51iBKBb0EvkQNEljOqb8+fdmd1+F3PU2ptMOqh8GdfZycHJ0oytGdyWAED?=
 =?us-ascii?Q?B35hBdkRiBidmPzEXkqfCe70W3sv+wVrBR59MWQYC7qyNf6XxqW/wBgMU68q?=
 =?us-ascii?Q?F7tUbYy8zRuwFbR6mVdhpLHzedKN5ceKJ7/a9dMLWxsHlLmALjkujplkSpkW?=
 =?us-ascii?Q?h1dJ1BbwFw7LXtJ/xTyGTTUZfqjC6SHwSUZcS14cN2B/AAJZAlMeqfM2byfs?=
 =?us-ascii?Q?prgA8KRlMLJq/YBSsHqhd0cWGOtCav0sFliuTWQuk8b6FTKNDYbxZlq3LURR?=
 =?us-ascii?Q?Zf0C98SiID5YTSq5MndPytHYFKJYWnQf2ad6ioVPZJlliEFQmEJMRFML2eU7?=
 =?us-ascii?Q?chz53tix1LpoS3lqzcb2rqAI/+B/SrotTRx6I77fP+j0iQofi4Kux66c84ON?=
 =?us-ascii?Q?7GvI/Wzd0t4iK7kcJzI2Ci7sJ8a92xG/CqE9d40mARRoBAQX2afhNaN1lznn?=
 =?us-ascii?Q?gIPC9XbJTZU2uoU1Q/hyQvNl89EIDbcAZCQC0HoI5xJa6lHnUIY4m4nbhkLj?=
 =?us-ascii?Q?OIfGcs8gwBOtdBlfwzO18yBySxoDvNanMT2qHCMhRQqkg9O05anOFizNjsVz?=
 =?us-ascii?Q?aAL0VQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6IrGito/Nugc+zpG3SaHIdetBB4LVvq8F3Arcy8g47EN/dCDAvaxb+s3720lzA67+wC0PPtoB7GogY1MVWdtTuhbapR16XIxby7pKZnFbRRF1nbGG2iyLZ0HIWLZ2HOPFFfpeDLpEHcllFSjMv1NqMNJRX6sIrSXTmzpw1F0pj8EgQFzzp4v2PWw4E9cqJszI8QmdEq9m3ghSfRmvFYjdShEx+GQzh4x1bkrt581tCicas2vYNfa2S10UdsmUs2bo+Z8TbAS5jBJnOFBBZ4I2akRe2AcmIRY8YmpdJTCE8t6izUszcNDzUnMQcQtse3JazB4/KwmVPD5b+5gmNHu61UljOSXLznN+8ncLxkwyOqsTyHMf/zJTkOO8qSLu0xEmwtfzmudLC1cNDUwy+J73w0kd8tZaB0nidBzYmcyd+3bdBSDLKquSteN+wmifAX7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:36.3323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4f8377-696d-4e32-3d49-08de6f0dfaae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why&How]
Resolve type mismatch warnings by ensuring loop counters and compared
values use matching unsigned types (size_t or int) in array iteration.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6f39b903947e..0421012803b8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3065,7 +3065,7 @@ struct surface_update_descriptor dc_check_update_surfaces_for_stream(
 {
 	if (stream_update)
 		stream_update->stream->update_flags.raw = 0;
-	for (size_t i = 0; i < surface_count; i++)
+	for (int i = 0; i < surface_count; i++)
 		updates[i].surface->update_flags.raw = 0;
 
 	return check_update_surfaces_for_stream(check_config, updates, surface_count, stream_update);
-- 
2.43.0

