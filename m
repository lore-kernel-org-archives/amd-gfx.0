Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106F8D6C2BB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 00:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AD710E385;
	Wed, 20 Nov 2024 00:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SkJUQtz7";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81EA310E385
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 00:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBZW71COTJs1HOMiGpIdZ+hOPmh/rTnN1Hc9RioV6XgYZhqioSJ/dQEX5DwnBqt31Gi2Vc1Cou6FnbDFUQFHw1FnMaLYhB9AZF7Kb03I2tRfi6iQUiYI3yFnBHJtHIR0GoJxsANiupxt60byHrwjvLofLrjMRFX3RJsuK9LyZsKuBDT5qnp/O7SG3rajTC7Prw+J2dKZtaR2ctRyLvGSlv0ARa5xx3q10u8kvwInBiQ1W7Y/LyQdDDYQW1DRgSnyZwrxCrYDk0Q8ontUxlTwuzRfFOGGRbX9nEt1AKQfl7nf/W/TCADh1GbGqg5cwS2EU+tsuVBstbxmOyzZ2J0N8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omXd5VlUArhC0Xrt1Fr5wroa5p9OVE7deaQLIErW41k=;
 b=wD2MXNNjX4dIo6o8X4F3ncdkb+ONcyD00WRFS/fFgv02lc/fNLuVzYXHNU81/6al+ctay61S4Fb+C/ZWGDYWzscPdEGDkMnboF5h2Z9O2v5LOh58vxaprKPLmXRU8sh1nGxxylfjMeCaES7BVdhDhzDgoaarddFaIvwyJmir2x/TD4fjaxXEOPixO2Nt0PkelFvbb++a3l0yW4i86PgnpjT+Gq2nkcKADbyU35idNrxzkDOhwtdcnpo/9p+y7CAlRoEB3Ois3b/ywfJXCrD2WFuJQYwKI/sW+pwSABqSFcC+Q9Q092QPsjfnuC5ViRplSYaSxN/elu8lrsBuMR2Beg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omXd5VlUArhC0Xrt1Fr5wroa5p9OVE7deaQLIErW41k=;
 b=SkJUQtz7NlmGk4mrBQq0VIZ2db5Ddn19pIbVaXbFZpgJmJGZE25Cu6ifiebQ5DbFWIIc08czjY7l+LMAJqP4ZQc95Y62Ybuwypzcy4sv2zqU2cMz0eWrh2L91oqh1Gm5imvkTdbZLSumw2MXd82EUt43eD/4AV3RlXvmC+fhX5g=
Received: from BN9PR03CA0091.namprd03.prod.outlook.com (2603:10b6:408:fd::6)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 00:34:39 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::c4) by BN9PR03CA0091.outlook.office365.com
 (2603:10b6:408:fd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Wed, 20 Nov 2024 00:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 00:34:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 18:34:37 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 9/9] drm/amd/display: 3.2.311
Date: Tue, 19 Nov 2024 17:28:37 -0700
Message-ID: <20241120003044.2160289-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120003044.2160289-1-alex.hung@amd.com>
References: <20241120003044.2160289-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2638ed-484e-43d4-9a86-08dd08fb1e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lCqBXDeiSiTqJer+fo5o1QwGVY6tHBEMwVyv47D/SbzlJvXn5VJQv1U7s8yL?=
 =?us-ascii?Q?nv85vLb0j3KYDiuZgmjHRMuMTuGXg2BGuZ0acGeUJnmBaWRkzdNC5MBRIG8S?=
 =?us-ascii?Q?haKSfzjhSrHr4m/N8ilTodbIFhcm0SSLmk7pyU0J2T23Dd80a3cTtky8mUut?=
 =?us-ascii?Q?HnOKYgSof177cmB4XzLDLD3a0O7j2A/4DVmcAKoo1W47wVoLCDQwxq5Mpn4U?=
 =?us-ascii?Q?dRTa71QlHgH4gFVUbGm/D+sgViOMoghdTfyBRmgV2+ccfj7aVEOcfapyDL7L?=
 =?us-ascii?Q?SziCsON67PJxYGPlbl/ZmjLonyIoPaN7EIEbNr7MnUy+ejUMtnVOP3x5wBdL?=
 =?us-ascii?Q?3482SsKTLbP0m1KICGPOOD8Y92tfLwSxcZvzQ8RS17K7tug9C8MFjqvktovk?=
 =?us-ascii?Q?1h81Pt6l+oyDYQQrVvI4ijw+P3OUPm7hM9DrvkCAMr9Na+akK/cITXUGOQ9/?=
 =?us-ascii?Q?QCijiyxJnmKluLk9sGy9GYFdHyTWRrkY4Zoci0p8cALNttz0h10zHJnAfsbU?=
 =?us-ascii?Q?iOlrninQOXMp60KG1x+MDtDn8kg47rHiCGdTw5HofGxSsX05Cwa7cwQrc2Hk?=
 =?us-ascii?Q?u07aZ9J7FOp8Mp/wqiRg+oUbZPX9YeBTOF1SjgXfRRDtJcMLrIMP3zVj+tCN?=
 =?us-ascii?Q?pe/hGoPJhuvg4KUeY//1/6lk5WXcBwlIfoe5YA3FZPugdDAk4ScECcV2vASI?=
 =?us-ascii?Q?CGQqIxCDVcqtm0sI0lZvbb/mH4ztT8GVu7PTLK6pbhgq48N9pwMsIkcsocti?=
 =?us-ascii?Q?be5cArgEhFdFHm0NRKPaF5WsMvhpZuYxgiBp0oIyjHDUdCzRU+xFCOmP960d?=
 =?us-ascii?Q?89pP1LF3SD9UEnYwa0PvTrfPYecEi5yB2dIv1YFO0K1vhCnQ+CyuKeWE7vOa?=
 =?us-ascii?Q?8XTuW1At6dTJ3+v/tXZRs/iBYmnHd7jHiTrWgTmPwp1TFjtn2OQXUdFT0nW8?=
 =?us-ascii?Q?UzlSzJ91u/d2zMOvcdEQf2irwBmLQZb1vy/DpOWGUVBzywhDqoLGgRd29/jr?=
 =?us-ascii?Q?64G1IIgwmCdR2Dg9Wy6RhrsW9o8dyvzIRpDljAMJFrdOb15udqaFwvfWsqLs?=
 =?us-ascii?Q?+FJJcjm69ApVGzYvr3kZ2Kzh8ZvJk/2KuKmC1h7WWcgaEjXqpWaaFhnhJ9xT?=
 =?us-ascii?Q?6jW4C2PdgRI2w8E2EIC+S/rJPBoPxbihaV5BEIPmoQ8IUkwofeZivM7MKg7p?=
 =?us-ascii?Q?d3NeamO8xVzOT8tRkZS+TlXxpWrswHXRvOzJ4Tr4UZikHUoS7z1jCRZGfmLF?=
 =?us-ascii?Q?cR17L3eQ0ViakP/veIbxu+Y/ZoRSrnTQGzimfwyvY4VgWfunW+LLpXYs9neh?=
 =?us-ascii?Q?JgRlRCVvKpJG3eN4ELfVLwVIdIglMWafHGCy5Oa9Q47S/WdRCWD0/tI8uOx9?=
 =?us-ascii?Q?bSYPmcLdxLnxHiEym0TMZyrLx4yayVrF+WEXWyFT3+KciP3OCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:34:39.0661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2638ed-484e-43d4-9a86-08dd08fb1e19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
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

This version brings along following fixes:
- Add hblank borrowing support
- Limit VTotal range to max hw cap minus fp
- Correct prefetch calculation
- Add option to retrieve detile buffer size
- Add support for custom recout_width in SPL
- Add disable_ips_in_dpms_off flag for IPS
- Enable EASF based on luma taps only
- Add a left edge pixel if in YCbCr422 or YCbCr420 and odm

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ec64061080fa..39ed52b0d006 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.310"
+#define DC_VER "3.2.311"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.43.0

