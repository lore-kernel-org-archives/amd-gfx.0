Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9A2C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4ECC11391E;
	Wed, 24 Apr 2024 08:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xskMjsIx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1AD11391E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSTILG2YttN2WjGPgFthtkLRX2Ba0Yhpyoxf1zcsq598jlw/h25sdZlbYVPwOqa3IWFdkO2Gfk1pZsp0yPVv3oX4+gYuOXWuMpN/osX+6VfQUtYedhkf6QrYmSL/ydA5DsHk8fBDrwUSR4A34tuDV4BmuG6k+cpbMoQR9MytLRJZxIwnwMgBx+H26IWmFeZfsJS+HNn179Ai0g3u465ffUgqzZRk8e6OxBjoYgaG7hKyctfjiTYiG44joo43NT6cwrcJmpiKuMxFHDko/FGSPk2YBGpUiG1Il4iW07hqjN29Zh7NJfxgNONnTY50t2a0ndcOzukXHCkuTmQekp7elQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsXdcigvVnGR+BvBGSL8Y934GBdFjUuIGRkag65G+c0=;
 b=eqBS8+g8IHspo8u8/h+CYQaxJm+pamAcC3uMqORmh4IeyuHlK7odGXFj1hQYLGjLCnwciX7rfhkreoyNIv6/8X/EpfmHIAnL8p6rCSYOaUwDNH2IVpGVtrsZHoQGAVWQpLeBAoEbjSfmzomZ2ktkNnfO5ZKeVEmx/qOJ1V3ToMQmuW5FpPuO7oqPZEMRcCM019gUeVPeT2cp610I+vHKuLzzcv91jSH0zd9Bg0Y3rphm8S9KNBgeZUdMZo0zySIrDaVTMQ/qARbQCutQq5CtNTjLt/2irzafxeWVjZoE0P5s2mXrTVN5D4wSGX8QYa+VjJD6RN4wuAp3rCbAq5wvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsXdcigvVnGR+BvBGSL8Y934GBdFjUuIGRkag65G+c0=;
 b=xskMjsIxfSXsQxVGEBVTL7Yn88oLpzWtKFnfrT2jEcKs6n7N8LKZoD2xKlasnyRCaFKzyrghV6R6ztg7Tmy9f3EdvFy4QEOrFkZWFctKHNIEEt+jmGWR28u+MMIP0T1eWhW/dQLQ1eMC0BOIlrciyaT+sL2qKTCKZUxHy0vt9cM=
Received: from BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48) by
 IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:39:52 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::e9) by BL0PR01CA0035.outlook.office365.com
 (2603:10b6:208:71::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:39:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:39:51 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:39:42 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 09/46] drm/amd/display: ASSERT when failing to find index by
 plane/stream id
Date: Wed, 24 Apr 2024 16:31:25 +0800
Message-ID: <20240424083202.2647227-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d48c1f-6a0f-4699-4a51-08dc643a1c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JMS5Tm9lHDmmR6AMnCGv2owl0XjoVnGKygH3DALSZh3JC0wzd0NyT2Fx4bL/?=
 =?us-ascii?Q?pwbbFgfd6jdY7fbzO0ejdGx9qCGeWMbze5IxXcxmP4xw8eYiMfj/d9N50kiT?=
 =?us-ascii?Q?ADnH79PDd+jQaMByfmwpBk47da//sLsnq3FVqs2EC4GcwOs9F6aOjrrn16Hw?=
 =?us-ascii?Q?/V6nXT+TZ3sL8zb+ZYTntwALkDPOF336sqNypzGq/drknAF2Y6QdMVsUlecC?=
 =?us-ascii?Q?SucrHQx9E5p5IEOAJfqNeWc5xHwV/Vklepfexl29i6QXIVGyWnSOl5DwzH1u?=
 =?us-ascii?Q?0Lw2u+IkApbzQYmliyqClW4seEkG7q/N3e79aNvsres+LIKOzGLdpqtEf8aB?=
 =?us-ascii?Q?rzeXY3lzQ2NHxtbqMuJjQd6nBc8tC+8WvS/fc0WUEV9T9iOtoGpob3THNc8M?=
 =?us-ascii?Q?MuhWDAyM4VUr6xlUSOlDHh4EAmRXEAB2xxgEwbyhRFhv24wibExbY2G47ukL?=
 =?us-ascii?Q?mRM/0nEn99kRoNwcxeUKVpqrGNS6D8VOIicxl3u4fH1JlKb9x982qDIqqje4?=
 =?us-ascii?Q?kHhaVuGsvXYaHAC8bRkgE61/W1jSmzewkZ5L2SPh57yr1ViXVewMErluCBqw?=
 =?us-ascii?Q?Kkp5rx7YO9CQuOaSkRHNpnRLJADXjo2X0FFMt/kdfM66YT48mzy8RpVMM4ZE?=
 =?us-ascii?Q?yUqrahZL5vFKFotg9HiWpv6sNIstfSnq9iDX9A6Y1I0rYnnqw+VW8BjI5ueq?=
 =?us-ascii?Q?5hu31RXn/2/AE0wBVHSpeWznUBrSuHh2XnkS4K7OAFtbg/EYFni8BwFniYoh?=
 =?us-ascii?Q?pTlldmk+Wf5FOVlt9cxr+YxQqB44qYnFrCP2gtPV8rPtgYjgSPd5pA4+1cc9?=
 =?us-ascii?Q?A2UrMncWgrNDYJ8A/D45T6O0/gqkQ5ZzYWml0974Ppx/QPDNeTl13/iHtcdq?=
 =?us-ascii?Q?q4Lif91zHMribcA5SqIs5muAdDNf3wQWI4a43Uo35BTnDlZ66E0xlJvD/Os5?=
 =?us-ascii?Q?+ocpfBrYwTnx/Icq/+7ZEv6NdhHAb3N4zp17Aan/WVcV+n5oUxu0klnonwim?=
 =?us-ascii?Q?KrsfKyG7WW+fQye5Qi8OnyG2MIhBmnMsdNFvG4XrNrsxqLwAgM7LYBlaAeT4?=
 =?us-ascii?Q?J6w0zVito/rafEEznri2Z53b78lgvCX+c07PAqlh566V/SVR1lhZ3sCRHPRE?=
 =?us-ascii?Q?qnBqGbomjpeemqZv1/d/tAgqVUsB7INSWm+DZIgtpgfwvgYJriVxxI/ySngm?=
 =?us-ascii?Q?obTxbD6lblkqufJ2rJP6om5wsJcs2fUHd9AVrvmYOfFg1Y4Nn+OhhP3e651w?=
 =?us-ascii?Q?USFohWz1zZw9DyEqSCvFwV2Co6lHaXd1qB1U7VZyKIZmf2PPpewDR3+WX3cQ?=
 =?us-ascii?Q?i0iax7+RU/tx21CMz7VzaZoutFqk8R2ROau9qRcamwFEPeNneDfrkNApPdlb?=
 =?us-ascii?Q?msvRZZjSj8s+fJ6NDoB8H0O0nhxA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:39:52.5072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d48c1f-6a0f-4699-4a51-08dc643a1c4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
find_disp_cfg_idx_by_plane_id and find_disp_cfg_idx_by_stream_id returns
an array index and they return -1 when not found; however, -1 is not a
valid index number.

[HOW]
When this happens, call ASSERT(), and return a positive number (which is
fewer than callers' array size) instead.

This fixes 4 OVERRUN and 2 NEGATIVE_RETURNS issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index b82d56ed1ef4..a2ced0bc772c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -88,7 +88,8 @@ static int find_disp_cfg_idx_by_plane_id(struct dml2_dml_to_dc_pipe_mapping *map
 			return  i;
 	}
 
-	return -1;
+	ASSERT(false);
+	return __DML2_WRAPPER_MAX_STREAMS_PLANES__;
 }
 
 static int find_disp_cfg_idx_by_stream_id(struct dml2_dml_to_dc_pipe_mapping *mapping, unsigned int stream_id)
@@ -100,7 +101,8 @@ static int find_disp_cfg_idx_by_stream_id(struct dml2_dml_to_dc_pipe_mapping *ma
 			return  i;
 	}
 
-	return -1;
+	ASSERT(false);
+	return __DML2_WRAPPER_MAX_STREAMS_PLANES__;
 }
 
 // The master pipe of a stream is defined as the top pipe in odm slice 0
-- 
2.37.3

