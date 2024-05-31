Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3726EC27C52
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6E010E3E8;
	Fri, 31 May 2024 16:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5VA0KxF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D30210E4F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7zMhKv7HicJ5UUu4Weo4xTe+kucYha1eyVfXJu3/72uy1ATXPW5mysG2xHuxLTpQGpMRG5FtN+8o+zY32QFCSzNqOixipJPG1Zr5YMejLq0TDPx82/dIipl/kaDIXJ7ULtwTl6DBrFFQ5Lt2oOXxUd/c5f9XdggkmbXq+KOC4b4mXNs2uDHYXzReI8wgChgOCWJt4itdY0B4SNmboyVCl2Mslv1VlWUrniPMJq53RKpXrpX2yMPT5Z7I44bpcb2K1ZN2r1GjFjzPK8YGcSkLGf2JVjYfLQ4+NRaXp/J9ffoFj4cGxndlm3/TI4tcmVuM48GR1Q01D4gzO6Tyzf4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wk9u1GgVK9Ux2VRoMVtshnIRBHocWwV8EGJUqh2yEI=;
 b=IlN9s4EgHEEagwpEvgH/LIJRaRyf+g+e8frPh+UpUinByu9HDi479p1jWBSDC3fXWu0PvN2oenJbuW3wChBoXmJNLFpVh39+OpV/Es/PNbuEuiQ5wO5bJQJpXYeoJ4RCiL0pXaJ8dG1p29cgpLj6MyF7XWdQPevypkz+bEAPmabz6ST0/+XUWyqh8B6OkJx2eXbcMY4PPLVaxqoaZ551/cRgsr8+ZDnZQ4KqempIGjRhiInQuzQxMvG+aRj9jZ/U89GYVSrRz63sWptf/yoNyqmB+tR4rNwx8qPtDioU2dFypQxi17bu8HQuanQ0Mr946wsLYioTbdauX4qGgyVGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wk9u1GgVK9Ux2VRoMVtshnIRBHocWwV8EGJUqh2yEI=;
 b=m5VA0KxFJHvL1deZvYGNHChATPM1xRxiJlzP2NSiJLQv4r0bwK5nTQz6KMoznY+nf2EQcY7dMe9PC8tvJs87zzI3hWsRpaR6vHrtC9PxJnhNfIdThDOUWUWBkCJ0m1AdFCo1b6r5ZxwWp5GryA11NKtTexEGa6sf5SwuoV96omg=
Received: from PH7PR10CA0022.namprd10.prod.outlook.com (2603:10b6:510:23d::6)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:52:54 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::34) by PH7PR10CA0022.outlook.office365.com
 (2603:10b6:510:23d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:53 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:48 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, "Sung
 joon Kim" <sungjoon.kim@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 29/32] drm/amd/display: Guard reading 3DLUT registers for
 dcn32/dcn35
Date: Fri, 31 May 2024 12:51:42 -0400
Message-ID: <20240531165145.1874966-30-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 10532e62-12ee-4548-f115-08dc81921d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BDGEr05UrlVSwwPk6/JBuB3FgvVfjevV3nQJ9fHJjjiRXpnebO9qYCLbVhsi?=
 =?us-ascii?Q?xfOXdV1s3DN/aGwK3oJc3T3069d8uJO0ANcOqohRKOSGKxiIwjreaTP490Bp?=
 =?us-ascii?Q?UbQQCO+Gm55WQdA/YBSmqGLkz04nNjuUuXD+3cG+htrzgLyvhqwQJQAgZjfi?=
 =?us-ascii?Q?z3/6Dg7Feugo5/vkYtyVTIYd1Z7zlluziatJFUh16/pX52lQdzJ9grlH3alu?=
 =?us-ascii?Q?pI4RQGveYNE4TYzGv6AJ3KHgaveAaWYGsepsExNT3t62ujIydd8IV04paDs7?=
 =?us-ascii?Q?tLXNXrB5utsQLVZhO9QGZj4NoZvs+4nt8516uAoin0akqH+ae3aZfz0b8G4l?=
 =?us-ascii?Q?526g1JHrOxnMOmqVDVC7R4oGnFeHfBwzPvDlmd3xghZmHowZ3JktIGH/Xvr8?=
 =?us-ascii?Q?oznrXzcU6sA1qjkV5McEMRwA4HIV5kCukKytWl0w31CRWOjeZAOxb8OT0xgr?=
 =?us-ascii?Q?2aFBPLFyMmK3auEmr/1YkDIWKAKcxzX4BIDmVFNyIuI5d4V9fPcHt8gPdfug?=
 =?us-ascii?Q?kLXOe6+vcPg2DdpmuFlVSR2BzHXvZ+0P22Ravq0nNWLuqdWgtf2p7MsM/an+?=
 =?us-ascii?Q?1WSPoleSbzDyC/knfJoecSnHL4pkOKS+NAONl0vMIUuKdTbmRi+2yk4FLVV/?=
 =?us-ascii?Q?J35ar9ct+VMkIAITOIN5cxMccVXdP8sIEzEGzwv3n/bScSJWA+zLL3glEeWN?=
 =?us-ascii?Q?CChBjpAQoSm2/W0gnqeVvqRXeqtcF461STvIG+fFkKQWLh3udHeMdnUokvqc?=
 =?us-ascii?Q?qS26JS4ynH+ykSASyGtZZdgr4j0paFDQvSL9NWa2pt32nnEJsz4zeLUeWH6f?=
 =?us-ascii?Q?G21dtycIJR1t0RzIM0bFyWH8aHDkeK44sZh1/JCYIyVz4AZA/n69rdWmqD4G?=
 =?us-ascii?Q?1aXUxQoii4V8DNg1HW1eiYy+fOgsreGW5pHQW76wErcytiRPqFUpwRrqBzKt?=
 =?us-ascii?Q?74VeOXJWcjECntlRBwzUAKyHemaFHwU+sa3B6umRFMBgF0ipDk5YX3TMD+20?=
 =?us-ascii?Q?DvtVTIxaAe1rH5PwxTdTXL9KwkwqWgCi0viaNtu+IuoY4xXfVGKKBA8DmuJf?=
 =?us-ascii?Q?Py1Phv+IHRRo5WIl34k/foxFOrEJzX8dmrVCBEEmrGZj/bPP9CNGbkZXEhu+?=
 =?us-ascii?Q?CXjTRObxAbTTBzF3O9kKYkuweptuybtMoUPcb4tHygtY2v4f2R5VNUoEgu3H?=
 =?us-ascii?Q?Zr/O6QB/q3CwvGUY4n/jFxL8gEAgR5EnaVj3bf2j0w9UZDs4Ozup/sTw1D2I?=
 =?us-ascii?Q?ivemqQYahinI1IB2tkKPI4F70xVZmuVK6DndrnRbgV/UHnftGuTTZ1cE8el5?=
 =?us-ascii?Q?C61TpkdqE+4M7708BtTKrwYG19RMssBZryBmS3vdYHIRqDjuWU0T+YmTlC6W?=
 =?us-ascii?Q?SyBMYI8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:53.8241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10532e62-12ee-4548-f115-08dc81921d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
3DLUT is not part of the DPP on DCN32/DCN35 ASIC and these registers
now exist in MCM state.

[How]
Add guards when reading DPP state based on whether the register has a
valid offset.

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index f8c0cee34080..7c05fa20078c 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -64,22 +64,23 @@ void dpp30_read_state(struct dpp *dpp_base, struct dcn_dpp_state *s)
 	}
 
 	// Shaper LUT (RAM), 3D LUT (mode, bit-depth, size)
-	REG_GET(CM_SHAPER_CONTROL,
-		CM_SHAPER_LUT_MODE, &s->shaper_lut_mode);
-	REG_GET(CM_3DLUT_MODE,
-		CM_3DLUT_MODE_CURRENT, &s->lut3d_mode);
-	REG_GET(CM_3DLUT_READ_WRITE_CONTROL,
-		CM_3DLUT_30BIT_EN, &s->lut3d_bit_depth);
-	REG_GET(CM_3DLUT_MODE,
-		CM_3DLUT_SIZE, &s->lut3d_size);
+	if (REG(CM_SHAPER_CONTROL))
+		REG_GET(CM_SHAPER_CONTROL, CM_SHAPER_LUT_MODE, &s->shaper_lut_mode);
+	if (REG(CM_3DLUT_MODE))
+		REG_GET(CM_3DLUT_MODE, CM_3DLUT_MODE_CURRENT, &s->lut3d_mode);
+	if (REG(CM_3DLUT_READ_WRITE_CONTROL))
+		REG_GET(CM_3DLUT_READ_WRITE_CONTROL, CM_3DLUT_30BIT_EN, &s->lut3d_bit_depth);
+	if (REG(CM_3DLUT_MODE))
+		REG_GET(CM_3DLUT_MODE, CM_3DLUT_SIZE, &s->lut3d_size);
 
 	// Blend/Out Gamma (RAM)
-	REG_GET(CM_BLNDGAM_CONTROL,
-		CM_BLNDGAM_MODE_CURRENT, &s->rgam_lut_mode);
-	if (s->rgam_lut_mode){
-		REG_GET(CM_BLNDGAM_CONTROL, CM_BLNDGAM_SELECT_CURRENT, &rgam_lut_mode);
-		if (!rgam_lut_mode)
-			s->rgam_lut_mode = LUT_RAM_A; // Otherwise, LUT_RAM_B
+	if (REG(CM_BLNDGAM_CONTROL)) {
+		REG_GET(CM_BLNDGAM_CONTROL, CM_BLNDGAM_MODE_CURRENT, &s->rgam_lut_mode);
+		if (s->rgam_lut_mode){
+			REG_GET(CM_BLNDGAM_CONTROL, CM_BLNDGAM_SELECT_CURRENT, &rgam_lut_mode);
+			if (!rgam_lut_mode)
+				s->rgam_lut_mode = LUT_RAM_A; // Otherwise, LUT_RAM_B
+		}
 	}
 }
 
-- 
2.34.1

