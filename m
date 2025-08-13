Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EA0CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9785310E7E3;
	Wed, 13 Aug 2025 23:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2DJKQK1M";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0564910E7E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUU35p96okKctKAy05ThinrSXOK5I6i7uN+ujljQXYThzxo3jgMnwFvfVwSSu54fo0cupnolT5p/YFCxeCz524zVnD2Nc2FFmih2I+VEdsiXJH3QkEWh9nuXLjxDaFPROIZIhE/dBmFTGqH0XjOxTGYQrGqip2KAYJUrdKvhnfKfuCg91lIt2Zvb2WIjQl0DHJYffRcBOUBBLBS1WEJiqp25J1q339mtanUS3Qt/hIy4NpWzMdxC5KQ/3GQ2edvFY2TANY3QhGo0b+G3YvqqQ2v9fp2ISfgSanE9vrTNSXKTdHSeuISzBWQh7ikx+hu70LPQPB0FDKkPNd7z1q673A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7fNvJpoKftCqVUdyjdl+e8UBJW9vIbubb7FQ5EmFwA=;
 b=VWjlHygX8A2Fq9nAcDeXI+TZYTbEBU5mqA+W89AUJzA+KASyVSP5rKYCSVvPUvqF/KOL0BJno5Dw/yjNWDILl7YoUb2/Ge0UrKWtCYmudProvJN39Kv0JDEsyEOPJCcvCSNPMlI3QQvwszlaGzngxT/AGLbzJM5IW483a3GstWaaUcMP/Sxgd+OS9URQzfXRAjSGBxfNrYW7A23L/8vCYMAhSJUOkKlb+Ir5DD35/aGHGu5C/TuU2DkaoUjGFgMfRfN/W1V7DMaTssO65BRcpm/7mOxZsBMc4m1KxKJUwb9ZeK+TpRnDOy+EUaqZqr8HRmpfk15+it5kGpkYgIJiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7fNvJpoKftCqVUdyjdl+e8UBJW9vIbubb7FQ5EmFwA=;
 b=2DJKQK1M7UW2O5WSSH1vKXHrr88vEBB6jmz5UzQcgt/sm9/tZqIBLaZzn6YNHj+ef+xRQCOaWNenbYe5UrlRij1M2szIJ/bdnTnPC1fEPHc/Qw/T6csiztyFS8yg3E2JPnA2WkIGF/qqtxUVHLRxAVAtSaspSbl5KLr7kJmm8bY=
Received: from DM6PR02CA0112.namprd02.prod.outlook.com (2603:10b6:5:1b4::14)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 23:27:28 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::7a) by DM6PR02CA0112.outlook.office365.com
 (2603:10b6:5:1b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 23:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:27:28 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:27:25 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>
Subject: [PATCH 04/11] drm/amd/display: Delete unused functions
Date: Wed, 13 Aug 2025 17:18:12 -0600
Message-ID: <20250813232532.2661638-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 050efff4-3946-4920-b654-08dddac0f7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oSp67dcLipju/9SuJ3KgE8DcssjuJJtBB9kehK2200aAO5OReF83gCQuR1NT?=
 =?us-ascii?Q?tlyVX4BwXjNG02kh1yl6V8/wP3G9ci3MZHJGT4t26ZTTn2u5+TmvFrwmjfyj?=
 =?us-ascii?Q?HlhHyMm+mUh361S8r0vAZrBlTIMtFRpRYlrJqtIFUFKvMS7XDq0FrRV4SXgb?=
 =?us-ascii?Q?XlaJ2Ixiki9dcurhvDJqXIz+k2XoqnPi04Dmsq/Xs8OPkPD0M7qMU/ln4HNp?=
 =?us-ascii?Q?5Q7oRTUzx+W2udYr+pdBMWh4dqUwWj69XdoGGVk4lXPJzeyAGEMOJuk+0vya?=
 =?us-ascii?Q?rwAtTU4OCeAjw7fYPBBchIanZ5Wl0l8XIIxscoDsyIWQLhBgv/roUDT5ojQz?=
 =?us-ascii?Q?FQofnX1WzfoPfy8F+uhxj2LjY5+Et/Iah4Gs9qBPZghZDIJBVvQOy8z9QTHB?=
 =?us-ascii?Q?an0YPcUbp1U5qTkDpLVVI7wBe4XOBsuXM/LsynoP6ArANzIeIcFrD/I/OPGf?=
 =?us-ascii?Q?Vt5Dl8lhgR4FeM95R+brBVZgwDBNA+aGMG5h94qYC/RQWIedK/dhBqDlb3Xt?=
 =?us-ascii?Q?mftwm7JK280YTLKYp5+LqEx9+wL/FprmATMlmv3BiuISpw+lqon1N/D/ocJD?=
 =?us-ascii?Q?0uTRBKeS3/b/VSKxE3HqnckxTNvtW/mBp5DoDQALKiWqQyZjL+b9qZJ9ydLb?=
 =?us-ascii?Q?ce9Z13WGC+XrtMzjC2yiLhx897Vtdq+oHiKJg5KG7C8DHBUvMdnuE87978gl?=
 =?us-ascii?Q?1cGMXfuYYaoI3FBzHgkn4FkJJkBTrC12me3xMqwVjMozaPmu3ruETr8iHbVQ?=
 =?us-ascii?Q?7yCJnMAsmhi6aWgWEP1ZOR4/HHecBLOgxQx+J41xFrOt8sLXSWkObrLd5bpy?=
 =?us-ascii?Q?n/9fAI2xyyQZw/lcSg85O+mNPqBSOhEn/yAna5GzNLnw99+xGsWlDVlsSm3j?=
 =?us-ascii?Q?0Hr3pJDrVRBje91LsLHrsY/z4pbHZ20J9C3uKptzU+ZqFY6TpVmEhroWywsS?=
 =?us-ascii?Q?EzLoJzp8YFftws0ozy2T4GTYwwFeqcXVMwcgtbMPdURsW1lXEwx4VUVH65v2?=
 =?us-ascii?Q?OZ/g2MCXDRfOUk5GWew6PHtj5j7sA/dkHsCwQbfoxOyiLDJbC/A7s8kLevFp?=
 =?us-ascii?Q?UE3rHp4w/zkJu1+kJzQbUFKqcmnWLjbtfAVCt1ZVzXnGeWY7vpwjj4sgstXK?=
 =?us-ascii?Q?hpoCyb9RzX0eyQ/ZeMOs4WvPSiGXwjtgAIcCubnEcF5U8YV3yRaOd5f9xJL8?=
 =?us-ascii?Q?sYQ/LRJAzFbfknRPjXfkyRgbkYOOFZ3w8N4omZLrZJs5H3sp+kK66e2oHypE?=
 =?us-ascii?Q?qq6zft5FtljKflS0bhAN5gi2kusZ/4GvOXlhpK1gpdUNUd1Mh0dmp6RM1ri8?=
 =?us-ascii?Q?IE7hjoG2OD+QVm1HDK9Vld911LmfIySvKw3NVbeVz9fFVqqCKcT4fbKlhzYr?=
 =?us-ascii?Q?i8dHTQYQMLLvo/NJzaNYR3GyNa3iXDpXt6HPEFJtliexBhS2epVANe/72/Sz?=
 =?us-ascii?Q?rpv+Yg0TGZd3Pqq4bCKtqopB4tWvC8SvBcvUiMjmTm74JVE3tFKpFdTFXa3G?=
 =?us-ascii?Q?7NHeZXOIKKvugit7/yUpapoSkLaiFY8M6nl5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:27:28.1220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 050efff4-3946-4920-b654-08dddac0f7c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414
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

From: Clay King <clayking@amd.com>

[WHAT]
Removing unused code

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h       | 15 ---------------
 .../drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c    |  8 --------
 .../drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  5 -----
 3 files changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 14f0304e3eb9..22960ee03dee 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -1069,21 +1069,6 @@ struct mpc_funcs {
 	*/
 	void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_ID id, const enum MCM_LUT_XABLE xable,
 			bool lut_bank_a, int mpcc_id);
-	/**
-	* @program_3dlut_size:
-	*
-	* Program 3D LUT size.
-	*
-	* Parameters:
-	* - [in/out] mpc - MPC context.
-	* - [in] is_17x17x17 - is 3dlut 17x17x17
-	* - [in] mpcc_id
-	*
-	* Return:
-	*
-	* void
-	*/
-	void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
 
 	/**
 	 * @mcm:
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index f3fb3fe13757..e1a0308dee57 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -287,13 +287,6 @@ void mpc401_program_lut_read_write_control(struct mpc *mpc, const enum MCM_LUT_I
 	}
 }
 
-void mpc401_program_3dlut_size(struct mpc *mpc, bool is_17x17x17, int mpcc_id)
-{
-	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
-
-	REG_UPDATE(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_SIZE, is_17x17x17 ? 0 : 1);
-}
-
 void mpc_program_gamut_remap(
 	struct mpc *mpc,
 	unsigned int mpcc_id,
@@ -611,7 +604,6 @@ static const struct mpc_funcs dcn401_mpc_funcs = {
 	.populate_lut = mpc401_populate_lut,
 	.program_lut_read_write_control = mpc401_program_lut_read_write_control,
 	.program_lut_mode = mpc401_program_lut_mode,
-	.program_3dlut_size = mpc401_program_3dlut_size,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
index eb0c68d0b0c7..fdc42f8ab3ff 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
@@ -221,11 +221,6 @@ void mpc401_program_lut_read_write_control(
 		bool lut_bank_a,
 		int mpcc_id);
 
-void mpc401_program_3dlut_size(
-		struct mpc *mpc,
-		bool is_17x17x17,
-		int mpcc_id);
-
 void mpc401_set_gamut_remap(
 	struct mpc *mpc,
 	int mpcc_id,
-- 
2.43.0

