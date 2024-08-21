Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650E5C5320E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194B810E71C;
	Wed, 21 Aug 2024 22:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/DqfhvL";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC7010E710
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuLC6fKHzZbZ3R9rGOONUI59CjtXHsCfE0QeUjV1i4dl8/KKGeEkLvA2cFjbfMf63i+CiVrJsPk+TRglmqSYX5j7SF72EIuHGO8vTztzWU7e/VP0yF+U+YdDQ4sHvfwlvNGwuOS3VfP6HKpztNWdv7z2FkVzZwkbaxevS6ur60SZPpLUPvQk2etNXJ5X66ri4w5VLUnxSSh6sDz7tAOtpCFMlY3doQiYwW/hnM2Brm/HY92a+JeEB0LiePX4t2mH9LWfBX4jqIfodtHBiFI9B8RhQeiX+AaLKtG6jXS2PIixGEODVAYzsjfBqM4GWl4h3Fm0N1ReSdRVLag/LkasfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyBRqHgcG1Qf7Yuz+cIcxRtHTzmoyghUMFmeLAeQIV4=;
 b=Dovl1GxgIbrXMmTfWT+NhhjyoKPBSl/TL+EOymQ883iv1JyfpqQ7Ig2SJAlzTV8/GdNlb524+5XSY+zpxpjekR4qBYf17inHMvXWtGXXo6LGggb4gckbDUofmiI57w+alTbmUHTqJVDXg4jzxw8hwM47WS4V984IFRmTCCKvD9z5OIjldUkMxVKv1eVCXewSDdtrF65pKG3lxdx8l/YI/UqbtaahNUKrG7r80vyiHAAV0jCDIHTbnMuQ5nFwJdhzN/8DSsXWgRRWiBRczyyLsH4aZD2xGukJflLmjizIbChaBaPbIT513Jmn0qgx/h1a7IXgZCIZMIkNR7UD2z/kAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyBRqHgcG1Qf7Yuz+cIcxRtHTzmoyghUMFmeLAeQIV4=;
 b=E/DqfhvLvqy0okeDMU5g9dWezzD3v1+6uRavNK3BYJrfm71+nA9cSVkgTWInIl3SRyf+QWOnz+01cZ9w4OXsZPcaV45p4LY8ZSYl+SVfxAawgpsKbZ+LCI0ArEXFASiBvCkBSlc8aTsN7E8SDzDGAF084ZWwecqiT9eWt/uAMYA=
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 22:04:57 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::8d) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:57 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:54 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 15/16] drm/amd/display: 3.2.298
Date: Wed, 21 Aug 2024 18:01:57 -0400
Message-ID: <20240821220156.1498549-16-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: e55f61bf-0bce-4346-0688-08dcc22d4b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vtf7Dn9PXAKkIOfd/CjIE0+8Kxg1lqNUrUWyeOmGBItXzbyCTOCLAn4OOFaS?=
 =?us-ascii?Q?ve1EzzHNGFoHA/xPh6NxFFHs36fS2XBMXVga9nS1ZnmB9cfszT8Hczv4n3iB?=
 =?us-ascii?Q?OPfRujFvSi4aBKK14+E9oSKzrs6jsWI5NGEWFAWZGrFmqZBvfHIWn1jUPtoi?=
 =?us-ascii?Q?i6bDzQdjEyiJ+QRCQIizlDNaNQLBGU8s+esCRGQruIUI9fK9LyodVn1uqHC9?=
 =?us-ascii?Q?eQl9Q4ARyAeejjdZ/5DN12KqbstzZpczt36TNmKF9cZZkN/m5gPh+5+F7YyI?=
 =?us-ascii?Q?XW+FG6j81SdDLhGYRQvJHEkBtc5snjO/BLWsABGvkWRv3oykOKcmK9nPu5WY?=
 =?us-ascii?Q?REBblxZ0EOSxqjYvzhgIP8pzsuEj4B/7Wz2Ju1BWlYDrNYBBG9fXXOo424Ex?=
 =?us-ascii?Q?JC7+G9obldgyp14KA32fd4hpl6j3J+jUUyAb+h/u8F/kgK1MXnGHWIUHl/ib?=
 =?us-ascii?Q?2kpLYu9nMWAddcQLCB05uNM0kaiVWK4usK9pNSxnb1K7UdZqf4JTFbKlgb2G?=
 =?us-ascii?Q?QXyIMnBZbUGC5K0KRDJcVvMYhQ8wN/7i/Z+CSSVOCGzWki8k0ODnwK5p3t0o?=
 =?us-ascii?Q?gbvhltzGbyla3AG+AYCVEcNvWA0+KKZtfkmnaEP1KcifmHVsRDD7uTLT5izM?=
 =?us-ascii?Q?UuIYI/CiuZdt4j8Sa/tjzYX7Z02UWDsewTCjZarAL6G9tiSI4pKPoIcWV1rD?=
 =?us-ascii?Q?kV6kkqDcB+6DIpyXI+2NL8Jqn+S8VTYWtzCVtwBCOj2rUvFWu1Xpu4SyhBeG?=
 =?us-ascii?Q?+OmX5IIxae2MEVafYXHLYL0JDnGpTsTzmVRt0jCmwv4tm3+ph1CQsHZW/dlP?=
 =?us-ascii?Q?1dm07827LSWzmKJEWejmLaV43xiFo2jGbgMJuJfwfy2pU3tLTpcAjby3CYiD?=
 =?us-ascii?Q?GJ8Qm1BuoCq3VsR4xfW5uppeV0ipcJnYKpLAa0KNz+ZNScJk48bzTiuHyFQv?=
 =?us-ascii?Q?fo9FrkZFqCSWz9edUyo+8c5ORHCCxwMX5xCrVdAFR0Z8r6Wf5Qda1YpB6CZe?=
 =?us-ascii?Q?IJCWO3s8VwxgudHieS9v7HcRBn6bQJBuPctqOEP5zztnDO6pGgRGp9F2K57O?=
 =?us-ascii?Q?vxQc+cVNiIS4gCfPbKI1iS8bTjXK5Sol7xHP0nMjhpqnB+qjvh2jxMh8W+l6?=
 =?us-ascii?Q?PsA3twIVX5gC20XEl+FyFeUCfYT3msD7bOb8pmBkDSGfjlwJOtBp88gzyyci?=
 =?us-ascii?Q?wedE9jsslLFm8jxoABJgv9072C8wxVkMquBk8zXHN1xI73104SFCkPxcLbuK?=
 =?us-ascii?Q?WYG/0DaGBl2h4S1sJ1UGhhGOapa09aRSha/PAvRu32gJgfYyxhOtJVM1qrJ6?=
 =?us-ascii?Q?vm6jv7f2nOOOrDkWCOlbqAEM88qSspONno1JS97T6pWkImIt0r09lLqqAEO0?=
 =?us-ascii?Q?qMt2+eKMLQ/ImqLIr7+QVC/aa6zNK9uBn0yZ44pzmR3F9XIddE84T6vmtTkQ?=
 =?us-ascii?Q?VCPXoMJfV4SeNybSVGVPnKpHEguSr7HX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:57.4747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e55f61bf-0bce-4346-0688-08dcc22d4b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following fixes:
- Fix MS/MP mismatches in dml21 for dcn401
- Resolved Coverity issues
- Add back quality EASF and ISHARP and dc dependency changes
- Add sharpness support for windowed YUV420 video
- Add improvements for text display and HDR DWM and MPO
- Fix Synaptics Cascaded Panamera DSC Determination
- Allocate DCN35 clock table transfer buffers in GART
- Add Replay Low Refresh Rate parameters in dc type

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5bbc7d2daca6..663aa565fc8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.297"
+#define DC_VER "3.2.298"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

