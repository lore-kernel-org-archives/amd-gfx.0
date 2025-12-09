Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A51FD3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3ED310E4D9;
	Tue,  9 Dec 2025 08:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uhi8OmDP";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B656310E4D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMZxgFN5aCKtaQYzHsCMGRNri0x4TssCRRiWOK5Gp5bGu9LoUha0iqc+zwx1NO26tjKEzpNJr3PoyGtZkgso/e6I8XMjUhBPaUe5G6LmS6l3+fFRHha+iyXuuu5xszZquuaZzzTmOIXTYG4rnoEWPG8RcClBUZJcgaIzH/V5uJ85bGOyMjD7Xwpu6Y3rAx9rnvKrI6RcR0dFV7eXlmNtpbKvIQNSATis+hzusZ8uZvCihQX2m5MZRR9AmPphRXUEmlJ8DfJ1joDA9G6O2yyuLUNHng3+dp9RBLqlQKF3DNCMNrmFwcFRDfQWOKsyD+t0p9tYYM1Cyoe0cN/lxhKStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yz8wJLTpcW/KrFOCDC0CrNxyhQjwwdtlXfrvlz7SVxM=;
 b=cgxEPlIS3HCvOQkT1BlVA3EsyhojKDo8g2Ud/lcmgzS6nICHPse+C3HqijM3xQyvWkzAZGgkPkM9+5m55qj8Lzvpml+xQI2NVZDpScbcxUG27vXhJr/I3/cVu0tJXvKU0a4eYwEe/+qouRxmFZ95d+8nAftJdOuNsSyFmwCUdSn5VXV7mxi7irUjAtE5XsBs3pqUKRCLsrv2qOWezq4t2fK+zzHsFPJR4qP+TNMv7S/3JLnDq9WPWzatZTtcEy8DUw/2GxOuBVj/OfTffv9SFruldwr6juN9wk9SUEthmQ+Q5uvm86hKb1udaZ0Z2mp2NBICLIXiKfUzvPyOHIPHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz8wJLTpcW/KrFOCDC0CrNxyhQjwwdtlXfrvlz7SVxM=;
 b=uhi8OmDP1a/5FIPFumPMFm43v0Pu4EwSyULUFjGsnMOeeOb0dvBCzB3uIuxaaIsPtaT5gMybP0fZUKoy6xsk1OOZq+c2OD5lqoglTlurHYCOyvCyUvZdQhQsByO0nKu8l/Re9WI2BaH3f6groCWvo/N3iLeFM4QZKk4Dtq+BG4s=
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by DS2PR12MB9751.namprd12.prod.outlook.com (2603:10b6:8:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:58:25 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:58:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:24 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:58:20 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 11/15] drm/amd/display: DPP low mem pwr related adjustment
 -Part I
Date: Tue, 9 Dec 2025 16:55:14 +0800
Message-ID: <20251209085702.293682-12-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS2PR12MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: d13350d4-eca7-4b35-3a84-08de37011cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v+6ipHkIiFwZDED2zoRyEojDhbMzSfCfzl3EJr3DbMlvzg3gsBZ3xUM338zy?=
 =?us-ascii?Q?YXE7kLhoLkIrnxXYVKNaQ+X7Gp/LzyVF3+y/HktLTPsEqxr/JdrF6qx4k5Gz?=
 =?us-ascii?Q?8NWrpBrx3KKRNPD/FROAdqMZ/riCBP3V8edxXqFrrRXx70NAF1CVm5AqVPGw?=
 =?us-ascii?Q?ABsOfppfiOqMLyUGCGqDCXc34oL0m+FA/uCgn2HtSK7k29+wHpqRuIU7jXDc?=
 =?us-ascii?Q?jIp8E0RI/M3/ub8eKisNWcHRNFVTNKgQe7jgObYkxrdvV2DcYONjZL1yWM9c?=
 =?us-ascii?Q?yLoWGPhZ159YWVEYW6AGQb6h2ced7lYk439uwp3MlzGd2Q5kTR+ptT5aq1rV?=
 =?us-ascii?Q?iL2CpdE98Hos1GQJnZVJTTXqEvCVH86QtBbXjAbFb7iGP2Ti6okwkvRSqJ9x?=
 =?us-ascii?Q?JWQqwr0lvOA+ea/3QSI/EYT5w4fSBapaNYWdGTDwu6iYq5UQy/gddaabF72S?=
 =?us-ascii?Q?zh4GYq10ORLybM5vSGt4JjncQwAC2Ophutl5t7j+arOXOebG/ir7D6ODBhz2?=
 =?us-ascii?Q?Kz4reJuksJmaLjBKDntliJRzHuwgJYQxR6IuHWkeLhBm7o1wmc8xvHnVlfFj?=
 =?us-ascii?Q?XdsiFeimcllCw60Rqc8E0TnkttQ3D7HpZOh68GDcq2tgnS2WKbcQwBfo6UvY?=
 =?us-ascii?Q?HToXJILBDsd4Axxf7+GOYDLFlc5DGezGV+9gGNNdjrW9//bgdqdMM7nAVHGX?=
 =?us-ascii?Q?vDUOuLKn46Rl5W+k4qDThjgf/c4TOEamIiL0NcG2MCrEkr9UB+Iecvj3iYta?=
 =?us-ascii?Q?Y0Vj46Y5SAfRhRQGYvIpRkaqAlSklmI6KWT6ZMpny2RcMo2tcGkdYXP9TldG?=
 =?us-ascii?Q?SGnNgs/I1LuHMWeq6otMhlLEAWm0iKvBA3Z3wtpG49FI7Q5BMIgsdwmyS6ct?=
 =?us-ascii?Q?KEUt54/G3eZDVjCNZq3wkpeGVAC+J0qLLiZZsBHJIaBg+B7l59pB8gGtrTCY?=
 =?us-ascii?Q?gHgCAsSdC54O/CPs1kXBfFRK3OtgdUA0sqcRUtkKaLVA0qqr34OVakRqzdCI?=
 =?us-ascii?Q?SP0TV3ccucCgB5QwuFE7ZIVz7gWwMYTlzwe0F60BhmhgxX4rJw2EaW90dmmV?=
 =?us-ascii?Q?tm6tlXVe6hES5ImZHuFiHbGQDt2Ru/FsNe39JsEqmdFIHEls5J724rz+8WQK?=
 =?us-ascii?Q?95W6O1A1HNFTufX47lsKsvu4jCVOiLNnAjLnrtqpAtPasoAhD3p1hBnz47Ww?=
 =?us-ascii?Q?SVo9fSKqnbcbWmZ39Uwezjpg/glGaEZE1xey0PI/uesU4XiZAGAfbKtRDRJU?=
 =?us-ascii?Q?7+3rTSt9KshyQBWroVKeCMDMn1gaIB6t9QsL/RahBB4ZhK3QWYzSIvSfsKkW?=
 =?us-ascii?Q?6Qsv1X3kI3yG/35vE5PBDUm4m0wcU7L7pwdFIiw19dfpgl8ffp5lMDd4Vvjz?=
 =?us-ascii?Q?wc4MC1/N8DVlfwdBTRUYePWWQkhC6rF5gxVzPmwo4r4wOhXUXoi3NGbhtphE?=
 =?us-ascii?Q?BeAtAOMPMBmB19ZdsmZ4OjSDZpcvJvmkuFP6pQMkIdfRfETWXlYm5kMpwuAo?=
 =?us-ascii?Q?Xck1vjT8WSToo1R+gBtCwvSQsV9lApJfVNrLKCVXgw+02PNwfcaPivbogYBt?=
 =?us-ascii?Q?RYkPyfbMdUvI6SFRuiQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:24.8640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13350d4-eca7-4b35-3a84-08de37011cbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9751
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Default low pwr mem state get chagned.
SW needs to wake mem up first
also need to put back to LS again after use: will do in Part II.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   9 ++
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 102 +++++++++---------
 .../dc/resource/dcn401/dcn401_resource.h      |   1 +
 4 files changed, 60 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
index b12f34345a58..890d04b1ddaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
@@ -545,6 +545,7 @@
 	type SCL_COEF_RAM_SELECT_CURRENT; \
 	type LUT_MEM_PWR_FORCE; \
 	type LUT_MEM_PWR_STATE; \
+	type LUT_MEM_PWR_DIS; \
 	type CM_GAMUT_REMAP_MODE; \
 	type CM_GAMUT_REMAP_C11; \
 	type CM_GAMUT_REMAP_C12; \
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index 5f6b431ec398..58b9f1cd0825 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -41,6 +41,7 @@
 	TF_SF(CM0_CM_BIAS_Y_G_CB_B, CM_BIAS_CB_B, mask_sh),\
 	TF_SF(CM0_CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_DIS, mask_sh),\
 	TF_SF(CM0_CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_FORCE, mask_sh),\
+	TF_SF(CM0_CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_DIS, mask_sh),\
 	TF_SF(CNVC_CFG0_PRE_DEGAM, PRE_DEGAM_MODE, mask_sh),\
 	TF_SF(CNVC_CFG0_PRE_DEGAM, PRE_DEGAM_SELECT, mask_sh),\
 	TF_SF(CM0_CM_GAMCOR_CONTROL, CM_GAMCOR_MODE, mask_sh),\
@@ -208,6 +209,7 @@
 	TF_SF(CM_CUR0_CURSOR0_CONTROL, CUR0_ROM_EN, mask_sh),\
 	TF_SF(DSCL0_OBUF_MEM_PWR_CTRL, OBUF_MEM_PWR_FORCE, mask_sh),\
 	TF_SF(DSCL0_DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, mask_sh),\
+	TF_SF(DSCL0_DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_DIS, mask_sh),\
 	TF_SF(DSCL0_DSCL_MEM_PWR_STATUS, LUT_MEM_PWR_STATE, mask_sh),\
 	TF_SF(DSCL0_DSCL_SC_MODE, SCL_SC_MATRIX_MODE, mask_sh),\
 	TF_SF(DSCL0_DSCL_SC_MODE, SCL_SC_LTONL_EN, mask_sh),\
@@ -336,6 +338,9 @@
 	TF_SF(DSCL0_DSCL_SC_MATRIX_C2C3, SCL_SC_MATRIX_C2, mask_sh),\
 	TF_SF(DSCL0_DSCL_SC_MATRIX_C2C3, SCL_SC_MATRIX_C3, mask_sh),\
 	TF_SF(DSCL0_ISHARP_DELTA_CTRL, ISHARP_DELTA_LUT_HOST_SELECT, mask_sh),\
+	TF_SF(DSCL0_ISHARP_DELTA_LUT_MEM_PWR_CTRL, ISHARP_DELTA_LUT_MEM_PWR_DIS, mask_sh),\
+	TF_SF(DSCL0_ISHARP_DELTA_LUT_MEM_PWR_CTRL, ISHARP_DELTA_LUT_MEM_PWR_FORCE, mask_sh),\
+	TF_SF(DSCL0_ISHARP_DELTA_LUT_MEM_PWR_CTRL, ISHARP_DELTA_LUT_MEM_PWR_STATE, mask_sh),\
 	TF_SF(DSCL0_ISHARP_DELTA_DATA, ISHARP_DELTA_DATA, mask_sh),\
 	TF_SF(DSCL0_ISHARP_DELTA_INDEX, ISHARP_DELTA_INDEX, mask_sh),\
 	TF_SF(DSCL0_ISHARP_MODE, ISHARP_EN, mask_sh),\
@@ -558,6 +563,9 @@
 	type ISHARP_DELTA_LUT_SELECT;	\
 	type ISHARP_DELTA_LUT_SELECT_CURRENT;	\
 	type ISHARP_DELTA_LUT_HOST_SELECT;	\
+	type ISHARP_DELTA_LUT_MEM_PWR_DIS;	\
+	type ISHARP_DELTA_LUT_MEM_PWR_FORCE;\
+	type ISHARP_DELTA_LUT_MEM_PWR_STATE;\
 	type ISHARP_DELTA_DATA;	\
 	type ISHARP_DELTA_INDEX; \
 	type ISHARP_NLDELTA_SCLIP_EN_P;	\
@@ -629,6 +637,7 @@
 	uint32_t DSCL_SC_MATRIX_C0C1; \
 	uint32_t DSCL_SC_MATRIX_C2C3; \
 	uint32_t ISHARP_MODE; \
+	uint32_t ISHARP_DELTA_LUT_MEM_PWR_CTRL; \
 	uint32_t ISHARP_NOISEDET_THRESHOLD; \
 	uint32_t ISHARP_NOISE_GAIN_PWL; \
 	uint32_t ISHARP_LBA_PWL_SEG0; \
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 6df3419f825f..a62c4733ed3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -966,62 +966,57 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 		ISHARP_FMT_NORM, scl_data->dscl_prog_data.isharp_fmt.norm);
 
 	/* Skip remaining register programming if ISHARP is disabled */
-	if (!scl_data->dscl_prog_data.isharp_en) {
-		PERF_TRACE();
-		return;
-	}
-
-	/* ISHARP_NOISEDET_THRESHOLD */
-	REG_SET_2(ISHARP_NOISEDET_THRESHOLD, 0,
-		ISHARP_NOISEDET_UTHRE, scl_data->dscl_prog_data.isharp_noise_det.uthreshold,
-		ISHARP_NOISEDET_DTHRE, scl_data->dscl_prog_data.isharp_noise_det.dthreshold);
-
-	/* ISHARP_NOISE_GAIN_PWL */
-	REG_SET_3(ISHARP_NOISE_GAIN_PWL, 0,
-		ISHARP_NOISEDET_PWL_START_IN, scl_data->dscl_prog_data.isharp_noise_det.pwl_start_in,
-		ISHARP_NOISEDET_PWL_END_IN, scl_data->dscl_prog_data.isharp_noise_det.pwl_end_in,
-		ISHARP_NOISEDET_PWL_SLOPE, scl_data->dscl_prog_data.isharp_noise_det.pwl_slope);
-
-	/* ISHARP_LBA: IN_SEG, BASE_SEG, SLOPE_SEG */
-	REG_SET_3(ISHARP_LBA_PWL_SEG0, 0,
-		ISHARP_LBA_PWL_IN_SEG0, scl_data->dscl_prog_data.isharp_lba.in_seg[0],
-		ISHARP_LBA_PWL_BASE_SEG0, scl_data->dscl_prog_data.isharp_lba.base_seg[0],
-		ISHARP_LBA_PWL_SLOPE_SEG0, scl_data->dscl_prog_data.isharp_lba.slope_seg[0]);
-	REG_SET_3(ISHARP_LBA_PWL_SEG1, 0,
-		ISHARP_LBA_PWL_IN_SEG1, scl_data->dscl_prog_data.isharp_lba.in_seg[1],
-		ISHARP_LBA_PWL_BASE_SEG1, scl_data->dscl_prog_data.isharp_lba.base_seg[1],
-		ISHARP_LBA_PWL_SLOPE_SEG1, scl_data->dscl_prog_data.isharp_lba.slope_seg[1]);
-	REG_SET_3(ISHARP_LBA_PWL_SEG2, 0,
-		ISHARP_LBA_PWL_IN_SEG2, scl_data->dscl_prog_data.isharp_lba.in_seg[2],
-		ISHARP_LBA_PWL_BASE_SEG2, scl_data->dscl_prog_data.isharp_lba.base_seg[2],
-		ISHARP_LBA_PWL_SLOPE_SEG2, scl_data->dscl_prog_data.isharp_lba.slope_seg[2]);
-	REG_SET_3(ISHARP_LBA_PWL_SEG3, 0,
-		ISHARP_LBA_PWL_IN_SEG3, scl_data->dscl_prog_data.isharp_lba.in_seg[3],
-		ISHARP_LBA_PWL_BASE_SEG3, scl_data->dscl_prog_data.isharp_lba.base_seg[3],
-		ISHARP_LBA_PWL_SLOPE_SEG3, scl_data->dscl_prog_data.isharp_lba.slope_seg[3]);
-	REG_SET_3(ISHARP_LBA_PWL_SEG4, 0,
-		ISHARP_LBA_PWL_IN_SEG4, scl_data->dscl_prog_data.isharp_lba.in_seg[4],
-		ISHARP_LBA_PWL_BASE_SEG4, scl_data->dscl_prog_data.isharp_lba.base_seg[4],
-		ISHARP_LBA_PWL_SLOPE_SEG4, scl_data->dscl_prog_data.isharp_lba.slope_seg[4]);
-	REG_SET_2(ISHARP_LBA_PWL_SEG5, 0,
-		ISHARP_LBA_PWL_IN_SEG5, scl_data->dscl_prog_data.isharp_lba.in_seg[5],
-		ISHARP_LBA_PWL_BASE_SEG5, scl_data->dscl_prog_data.isharp_lba.base_seg[5]);
-
-	/* ISHARP_DELTA_LUT */
-	if (!program_isharp_1dlut)
-		dpp401_dscl_set_isharp_filter(dpp, scl_data->dscl_prog_data.isharp_delta);
+	if (scl_data->dscl_prog_data.isharp_en) {
+		/* ISHARP_NOISEDET_THRESHOLD */
+		REG_SET_2(ISHARP_NOISEDET_THRESHOLD, 0,
+			ISHARP_NOISEDET_UTHRE, scl_data->dscl_prog_data.isharp_noise_det.uthreshold,
+			ISHARP_NOISEDET_DTHRE, scl_data->dscl_prog_data.isharp_noise_det.dthreshold);
+
+		/* ISHARP_NOISE_GAIN_PWL */
+		REG_SET_3(ISHARP_NOISE_GAIN_PWL, 0,
+			ISHARP_NOISEDET_PWL_START_IN, scl_data->dscl_prog_data.isharp_noise_det.pwl_start_in,
+			ISHARP_NOISEDET_PWL_END_IN, scl_data->dscl_prog_data.isharp_noise_det.pwl_end_in,
+			ISHARP_NOISEDET_PWL_SLOPE, scl_data->dscl_prog_data.isharp_noise_det.pwl_slope);
+
+		/* ISHARP_LBA: IN_SEG, BASE_SEG, SLOPE_SEG */
+		REG_SET_3(ISHARP_LBA_PWL_SEG0, 0,
+			ISHARP_LBA_PWL_IN_SEG0, scl_data->dscl_prog_data.isharp_lba.in_seg[0],
+			ISHARP_LBA_PWL_BASE_SEG0, scl_data->dscl_prog_data.isharp_lba.base_seg[0],
+			ISHARP_LBA_PWL_SLOPE_SEG0, scl_data->dscl_prog_data.isharp_lba.slope_seg[0]);
+		REG_SET_3(ISHARP_LBA_PWL_SEG1, 0,
+			ISHARP_LBA_PWL_IN_SEG1, scl_data->dscl_prog_data.isharp_lba.in_seg[1],
+			ISHARP_LBA_PWL_BASE_SEG1, scl_data->dscl_prog_data.isharp_lba.base_seg[1],
+			ISHARP_LBA_PWL_SLOPE_SEG1, scl_data->dscl_prog_data.isharp_lba.slope_seg[1]);
+		REG_SET_3(ISHARP_LBA_PWL_SEG2, 0,
+			ISHARP_LBA_PWL_IN_SEG2, scl_data->dscl_prog_data.isharp_lba.in_seg[2],
+			ISHARP_LBA_PWL_BASE_SEG2, scl_data->dscl_prog_data.isharp_lba.base_seg[2],
+			ISHARP_LBA_PWL_SLOPE_SEG2, scl_data->dscl_prog_data.isharp_lba.slope_seg[2]);
+		REG_SET_3(ISHARP_LBA_PWL_SEG3, 0,
+			ISHARP_LBA_PWL_IN_SEG3, scl_data->dscl_prog_data.isharp_lba.in_seg[3],
+			ISHARP_LBA_PWL_BASE_SEG3, scl_data->dscl_prog_data.isharp_lba.base_seg[3],
+			ISHARP_LBA_PWL_SLOPE_SEG3, scl_data->dscl_prog_data.isharp_lba.slope_seg[3]);
+		REG_SET_3(ISHARP_LBA_PWL_SEG4, 0,
+			ISHARP_LBA_PWL_IN_SEG4, scl_data->dscl_prog_data.isharp_lba.in_seg[4],
+			ISHARP_LBA_PWL_BASE_SEG4, scl_data->dscl_prog_data.isharp_lba.base_seg[4],
+			ISHARP_LBA_PWL_SLOPE_SEG4, scl_data->dscl_prog_data.isharp_lba.slope_seg[4]);
+		REG_SET_2(ISHARP_LBA_PWL_SEG5, 0,
+			ISHARP_LBA_PWL_IN_SEG5, scl_data->dscl_prog_data.isharp_lba.in_seg[5],
+			ISHARP_LBA_PWL_BASE_SEG5, scl_data->dscl_prog_data.isharp_lba.base_seg[5]);
 
-	/* ISHARP_NLDELTA_SOFT_CLIP */
-	REG_SET_6(ISHARP_NLDELTA_SOFT_CLIP, 0,
-		ISHARP_NLDELTA_SCLIP_EN_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.enable_p,
-		ISHARP_NLDELTA_SCLIP_PIVOT_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.pivot_p,
-		ISHARP_NLDELTA_SCLIP_SLOPE_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.slope_p,
-		ISHARP_NLDELTA_SCLIP_EN_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.enable_n,
-		ISHARP_NLDELTA_SCLIP_PIVOT_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.pivot_n,
-		ISHARP_NLDELTA_SCLIP_SLOPE_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.slope_n);
+		/* ISHARP_DELTA_LUT */
+		if (!program_isharp_1dlut)
+			dpp401_dscl_set_isharp_filter(dpp, scl_data->dscl_prog_data.isharp_delta);
+
+		/* ISHARP_NLDELTA_SOFT_CLIP */
+		REG_SET_6(ISHARP_NLDELTA_SOFT_CLIP, 0,
+			ISHARP_NLDELTA_SCLIP_EN_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.enable_p,
+			ISHARP_NLDELTA_SCLIP_PIVOT_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.pivot_p,
+			ISHARP_NLDELTA_SCLIP_SLOPE_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.slope_p,
+			ISHARP_NLDELTA_SCLIP_EN_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.enable_n,
+			ISHARP_NLDELTA_SCLIP_PIVOT_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.pivot_n,
+			ISHARP_NLDELTA_SCLIP_SLOPE_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.slope_n);
 
 	/* Blur and Scale Coefficients - SCL_COEF_RAM_TAP_SELECT */
-	if (scl_data->dscl_prog_data.isharp_en) {
 		if (scl_data->dscl_prog_data.filter_blur_scale_v) {
 			dpp401_dscl_set_scaler_filter(
 				dpp, scl_data->taps.v_taps,
@@ -1037,6 +1032,7 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 			*bs_coeffs_updated = true;
 		}
 	}
+
 	PERF_TRACE();
 } // dpp401_dscl_program_isharp
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index e1fa2e80a15a..406246a9867e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -394,6 +394,7 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SRI_ARR(DSCL_SC_MATRIX_C0C1, DSCL, id),                                  \
 	SRI_ARR(DSCL_SC_MATRIX_C2C3, DSCL, id),                                  \
 	SRI_ARR(ISHARP_MODE, DSCL, id),                                          \
+	SRI_ARR(ISHARP_DELTA_LUT_MEM_PWR_CTRL, DSCL, id),                                          \
 	SRI_ARR(ISHARP_NOISEDET_THRESHOLD, DSCL, id),                            \
 	SRI_ARR(ISHARP_NOISE_GAIN_PWL, DSCL, id),                                \
 	SRI_ARR(ISHARP_LBA_PWL_SEG0, DSCL, id),                                  \
-- 
2.43.0

