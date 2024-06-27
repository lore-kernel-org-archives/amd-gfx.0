Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A1CC3064D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F2610EB65;
	Thu, 27 Jun 2024 21:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OOapw9T8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA2B10EB64
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7vtHS0L7ENTF8QAhe2Ct/7SDmv6UsDW2FWfTDIie2Ka9zzuY6DR+XkWvFtTxzIzdgv1hWgpUCSKjmUP3oO8u1TKqE0avKaiFOCKwIgBjGBbGK7fTb8fAWK6+9OzVj6bnQcEON2dh7cCuNosO/zCY+U63cww/oAJFMOaP0FbCPfOAIeS0ORnDQbyH9QFIEXjVEeyLIbJqCZFi6Vsmd8i8VTLHFBr5WAHP5bzmY+XGbuBlL/XhzYL8clfbGeBZnZYeUwl3crYIwOw2U98oZaXZ+8xlyNKnCBfNvsqLtu4OTJferD0gHzltbnRMh70zn1XNnOdFyPuifp14j3IFJ5U1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6N2pSEn2PTqt0Pf/FTrUTn1XHf5PiRa75ZQe/16cJU=;
 b=lZDTeL73vKB0OwjiBEzqvtPPwr32pKjqs6rxiDusiBWQORkHHkL7XBxDSJuEskkG8KeHSukcOOjjxoHhtBEo30mCnHOEWZNXx41sm9sj1OdJyMhYaTAnlFLj2yqlMdAmyh5ewBGksu0YHeiVQeJTVmDGT/73kO1KZA+Ez/EiXuBEcdLKHZcyjhkYyzi/N0rB3tssMU7qCpmA5bPmANcrLR8k6aGw2RnXPATC+0KpcX6CGqFrSsEInJEgZSg+L+qXA4bFcOPIZL4Kv/hmwOXU0wbSIN3r81GD/AYMFclzb2JRuXu4yekDvPBiOQ8q7lIAlikmOMc8IP7O4RNKT9r8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6N2pSEn2PTqt0Pf/FTrUTn1XHf5PiRa75ZQe/16cJU=;
 b=OOapw9T8zVpIDf3/TmkgSwiO5L2RHflDYXHSzXM2ZKXxo2mrXE/Q0PwhblrTDvufy0aWQqSI5lHbi32YBPXHt2icwsRUTj5q2pfqy9Mahcc1EG/iSXN4dP0HPS5m2SbPc7VEVhwZqg8PHzUYCPu9Ve1Jgr/UbV1c6R2wBXCbYNw=
Received: from BN0PR04CA0198.namprd04.prod.outlook.com (2603:10b6:408:e9::23)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Thu, 27 Jun
 2024 21:14:43 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::1d) by BN0PR04CA0198.outlook.office365.com
 (2603:10b6:408:e9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:42 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:41 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Chaitanya Dhere
 <chaitanya.dhere@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>
Subject: [PATCH 20/26] drm/amd/display: Account for cursor prefetch BW in DML1
 mode support
Date: Thu, 27 Jun 2024 17:13:23 -0400
Message-ID: <20240627211329.26386-21-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: b19f8e19-6339-4974-2ff9-08dc96ee29fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Afor07/IPII5DG24SRKeJeii2DFlHpwTxQczW99h21JD7hRxLz9AXjfvCZSX?=
 =?us-ascii?Q?4AwHo2JH92SkCzfBd2boJt9Ct+kmwlaegufawf/MVQZ5fj03Loj/KiWuNTeZ?=
 =?us-ascii?Q?+sLl6jVzMZ/qvo7i4AmKCGqepJU6YwlhTGWttW8X8D3kPJfvZN1m53fZnb1S?=
 =?us-ascii?Q?jDyykphgTOiuFEQhpJ8+FDDbB0l40tn39fUWbcWv9qfOpgRBqc2bnH94+p8d?=
 =?us-ascii?Q?As1793AY+NqVtBOormolIHirC9/NZJii9m63NscnubVeHgUrgZwpsFUNeoZW?=
 =?us-ascii?Q?+Hx4kZghzm4qGhAlg+w7PIglZoi6jhML9AIfoMeSz9IiJ5rIF3x49fwz0qc+?=
 =?us-ascii?Q?Nd4L2B1y/0M+UCgC1O2FmEfQ9CPWktb3W4HBD/CBlOvOnz/pU7nrsh4SyQIC?=
 =?us-ascii?Q?JKWkur2i65e3U6UWlFIG/iWjsKsBH25k1eoNqM1k1J/XsZIApZ4lm4tqCHOY?=
 =?us-ascii?Q?2D2g5I4KgnqQ+bw4jeseI/sALSXp0Jake1rRDiKeeFqeuM6gm+vLW26xQjoB?=
 =?us-ascii?Q?C1UgOjjLW1ZLCQeTzu8C/SkLj1xuveh9xUXP4CLsdtkEf4estktHomPgPOra?=
 =?us-ascii?Q?yQnLxA4YD2KH9FnTdismKLRwcwe6tuG3DNfcO3aAqCz9zjnr2k4JMNhFMmA7?=
 =?us-ascii?Q?kWzYy+V/stJEvDpQrJNkZfQUMMaGXVpH+l79+O+uujT1aIFWrJ0qM38kOtHF?=
 =?us-ascii?Q?wQr6goN8Wh1+YKwwtOcthCd1ooKIZmvB/PAkWQ8Rc1JeLE84KBjXDpoAZZw7?=
 =?us-ascii?Q?OFBjjNEqB2uK83imGpZ15QkrsXbyPZtU/+vpwVXxz8Ltt1GBAXcESd9bLfLa?=
 =?us-ascii?Q?dz3oyo5xm9mU4zLHbnKKxsgQrbUlhl5j+XmkF56ONNNNHl4WisJ112bZRbF6?=
 =?us-ascii?Q?2Ht3c0nf8ayo+nXu64ALdCeiMJNy88QDkEVa5Nrn4PEimGhj98k7+BM2tBuc?=
 =?us-ascii?Q?mS+QxcVFjjKLkN9bcuGshG6r4RUYy3EMqjGZiXK52iAJRNKId4VJLNMU05uX?=
 =?us-ascii?Q?6atWhT6v2oSdSzw1RHzq5pJmmWmfgeHDIV1iwbnlMrXRWfI+/Ko3bfdrzEAS?=
 =?us-ascii?Q?0C8301J2Pt4iAp73IWudfZGgKOcrlPGnTsFqgzhH9DTPV2Dqe6bRKM7laSO3?=
 =?us-ascii?Q?QTCZAIs5fRYlW4rLAGJDisoYYPvmHuuzWw3gqjH4bbKC74TmRe7cjd54hziO?=
 =?us-ascii?Q?FQAU/BPn0RBnniXhKkMtVu4etKFRHkdfLc0mXeajTHvXUhGERxFP2EPEfZcj?=
 =?us-ascii?Q?uuECiCc0eAmqtR2VU1SIq8v2ez+MX3M9sbL3TH+N2pxZ7Do+0AZDk3h8EkKE?=
 =?us-ascii?Q?Za/LXit2FxPs3aaOYbQHxyqxN7/c6SQTXkHn3wKBZ7PiLec81cNxzA2BDXBd?=
 =?us-ascii?Q?UgrJM2balm1I8nU4xGYUxczrMEH1FFQItbRhC0281p+Th85wYUsm7DL7jZqX?=
 =?us-ascii?Q?05yQpcJHiWZR3jQeYWRZO+J28enk9KVL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:42.9046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b19f8e19-6339-4974-2ff9-08dc96ee29fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
We need to ensure to take into account cursor prefetch BW in
mode support or we may pass ModeQuery but fail an actual flip
which will cause a hang. Flip may fail because the cursor_pre_bw
is populated during mode programming (and mode programming is
never called prior to ModeQuery).

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 6c84b0fa40f4..0782a34689a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3364,6 +3364,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							&mode_lib->vba.UrgentBurstFactorLumaPre[k],
 							&mode_lib->vba.UrgentBurstFactorChromaPre[k],
 							&mode_lib->vba.NotUrgentLatencyHidingPre[k]);
+
+					v->cursor_bw_pre[k] = mode_lib->vba.NumberOfCursors[k] * mode_lib->vba.CursorWidth[k][0] * mode_lib->vba.CursorBPP[k][0] /
+							8.0 / (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * v->VRatioPreY[i][j][k];
 				}
 
 				{
-- 
2.34.1

