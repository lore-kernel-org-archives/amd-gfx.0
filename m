Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F8CD597A9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 21:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D512B10E668;
	Tue, 12 Nov 2024 21:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HwDIzRqT";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08D610E660
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fep5tz+mBQHb2Y53HgPuNUazQSuJ8LieaDEj47NEPmP/esH7azuF3SIhgBUxNdrT+8em4uMBYbk4QGmSbtt9ZHryUNSmWQbHb1/4V1aNfaa+JyQQQWLamWv9556ECkgXhEv0uNxCBSx+QGbf4WQCeNcIfc5q7YsbmrL5u8tFlW5OFFriMvAKRP31XsXkvZlqVjQ8HFryG4JsSboHzbJPXtfcIhetu8ute50nx1lIraBsDD1RAR/lkU3QfSGnAMiapQax4yPlK1mvX9zPvWZTYYc0Wc19E+lO3OlmotMfOPTZ01PYDpKyGV8urqffdnZulzmU/S3veO4BWGbE6RTItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwUAO2ehEAL8xh5btlx4hVji5ql1nEWikT084SAYUlk=;
 b=XRfObvSsdIevKgDxhYHMOC5St5V+HrSbpyiHIPvejMinWUsjnouQaLl8MjUwEGWU9o+BNdKFyp4TNf81TPcYU/UvAM8Jok/OXhxrjf9hsJD3rzgIHeemVcCZzez0kNk02n9QDRmW13vr1A29Q8zGJThyeuVlUaMf6mgHv0vnYD6BJbdNR/tQ7dXg0dJst9FAfWl89SdG6g5L/vmpRxTnWkTJbSJLdjpcteK8Pe7UBBMz625XTht1MzKUOOEYm09Godf9E9gUiPq3/PFcpHqpn8JFlQub1xlg7ULxdFk6U5Z22UYJcq9wyUg0Qh/dHCldSeS+5lsEegRDrnHS38Vu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwUAO2ehEAL8xh5btlx4hVji5ql1nEWikT084SAYUlk=;
 b=HwDIzRqTibLgQBnbIIDqsKIAu0fBv4/gRfaog8HMTSNGBnWKkU3wMonc3IgJ5uoUnDUKUVRjc+grBXbqibGmb1saq8N/nQSZFZpKHtu58mbT9Wz9+KEP20jhsnQ0SbZV+sRffOjdIPo3aE1lm9r9GgTDV/TaV/mXp5Xw5nVez4s=
Received: from BN0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:408:e7::17)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 21:37:32 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::6f) by BN0PR03CA0042.outlook.office365.com
 (2603:10b6:408:e7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 21:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 21:37:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 15:37:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, <harry.wentland@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amd/display: add clear_tiling hubp callbacks
Date: Tue, 12 Nov 2024 16:37:12 -0500
Message-ID: <20241112213716.49355-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112213716.49355-1-alexander.deucher@amd.com>
References: <20241112213716.49355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c64ca4-e446-4907-7d1d-08dd0362373c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?64LpbomPKXX7O7mqgM42IgbOXJayvxqlrRDhP1ckTmTiXWMMBZpAdVAVBNdi?=
 =?us-ascii?Q?cokvTto8Ha1OYBopRJgxUxua+QMgP1q35kNgsOIFFx0UfWM8gV9RFbwKbTCl?=
 =?us-ascii?Q?Exx2mMnlIdwkPHzOnHRuhI0424sxBVcYyu9JQQuS5xbhJvSMDl6kvCxhdVla?=
 =?us-ascii?Q?Q2rZ1uJX8Gz7cnPEvuxCbvAaIa1OGEp5X1+R7ZuFUDLIUwIAJyxnLgA8ssvQ?=
 =?us-ascii?Q?yH7HzmkGEbib9ZYD8rKzt+d4GNM4uoHCDLxeIBK8dvmocoytlzGiKlGj/vG7?=
 =?us-ascii?Q?lTPLUEn5N700egjUfj4zPmhiXmRgRjNklH71IXJ7Ze8Uep74BAqr1zOEc2Nq?=
 =?us-ascii?Q?FfBWt84sIt9Vonr1PAM4uEqBwliP+aP0hoWvuaV5o+mCDGCLCsXc1pN3HYss?=
 =?us-ascii?Q?zPKM7b99mWAJRG94TJdK8LBhzPjWqMiV5x/Cpl3eqkOI6yyjs6Cd8NZP7QmJ?=
 =?us-ascii?Q?+roAtk4ou0i9OwFLhwnTfMCBPcbQpDpUS+0cm091YYh/oD00mXAqhYlqgs5h?=
 =?us-ascii?Q?Xl6KolmqgA2O4iSf2/qM1clO6QF/vqt+xdl2ETrGinqja+2PEDOkgcPaDcMD?=
 =?us-ascii?Q?+sMvuy6WP8iEwJnNfcvyt1NBd6KFJA+7XxBLfUskZbqWzCAd0z6htCw7dC+f?=
 =?us-ascii?Q?/BOIW1j/SAl3ShAm0LzIc+iqV6LLzDAILi/q9P1Ib/IlvWV8t9bccckt3zPY?=
 =?us-ascii?Q?LEzBTSwngXziUv3eO9tH4HRd1NGVPolRNaRT1PqgGPceQ7Zlnt/uV5b4xwnk?=
 =?us-ascii?Q?ywm6J4RE3Pag1YsFbUP+AGTcy5T5chXX3FgE6UEN76iuPRiqmrehsQWoOGDK?=
 =?us-ascii?Q?onfwivIMe/BWcvUnPZR0o9dpFCAYc3Rq1zQDeFxJ08QacJ6rXDFXvzgx8uwa?=
 =?us-ascii?Q?g1VMQITaXpRo20erNjFzVUGkgoRDZBV60+RsZ0qAFuGHmaA68Sw6hZhczIeF?=
 =?us-ascii?Q?Gv1e6AwfcDxa/lbMSWMGxF8O6pIVH56q9cuZMYV1j+XkcXLguIGSYbgIo3/Y?=
 =?us-ascii?Q?SBV6VrSV3sKn0TW0MK9z0sNmsr71ehxFU38AyMsZ7sEkEKLyP6FlJl5scN4t?=
 =?us-ascii?Q?fx77vkx2Qmcjr9Jdt2OyqeWuu+CmsN3tUpxc15/GAeIesQ85Xr5of2ltQiqy?=
 =?us-ascii?Q?HfNYFv+1/N1uWq0y4ZloDpcrz4yj5pPQG96R87RKnsQqSQFcYPTsmwJGHPYA?=
 =?us-ascii?Q?Y/MmoN4SBq5gTxxVGmSVE6jevnesSjBhD+B2jVzdP3bWuN1vT2lW5NJEkmvl?=
 =?us-ascii?Q?YPeOcntBhpTZiJddPC3YPULABMyRRNJ1QkZwaS2tpuuf/3Qk6K5eXFKCzWLf?=
 =?us-ascii?Q?osJavkM2uR2PWYAa4EDOuFn+tSvzo/tqneyl1AyDlcqkPV20a1Z1EbJwby0c?=
 =?us-ascii?Q?LCoCRswgBhsjmx3zXgKVqYx5bo1Y1uDJM2rmU0n1teNEGiBDSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:37:32.2836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c64ca4-e446-4907-7d1d-08dd0362373c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

This adds clear_tiling callbacks to the hubp structure that
will be used for drm panic support to clear the tiling on
a display.  hubp3 support from Jocelyn's original patch
and the rest from me.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---
 .../drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c  | 15 +++++++++++++++
 .../drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h  |  2 ++
 .../drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c  | 15 +++++++++++++++
 .../drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h  |  2 ++
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c    |  1 +
 .../drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c  |  1 +
 .../drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c  | 17 +++++++++++++++++
 .../drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h  |  2 ++
 .../drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c  |  1 +
 .../drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c  |  3 ++-
 .../drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c  |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c    | 15 ++++++++++++++-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h    |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h    |  1 +
 14 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 22ac2b7e49ae..f0ba944553df 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -518,6 +518,20 @@ bool hubp1_program_surface_flip_and_addr(
 	return true;
 }
 
+void hubp1_clear_tiling(struct hubp *hubp)
+{
+	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
+
+	REG_UPDATE_4(DCSURF_SURFACE_CONTROL,
+		     PRIMARY_SURFACE_DCC_EN, 0,
+		     PRIMARY_SURFACE_DCC_IND_64B_BLK, 0,
+		     SECONDARY_SURFACE_DCC_EN, 0,
+		     SECONDARY_SURFACE_DCC_IND_64B_BLK, 0);
+}
+
 void hubp1_dcc_control(struct hubp *hubp, bool enable,
 		enum hubp_ind_block_size independent_64b_blks)
 {
@@ -1363,6 +1377,7 @@ static const struct hubp_funcs dcn10_hubp_funcs = {
 	.hubp_disable_control =  hubp1_disable_control,
 	.hubp_get_underflow_status = hubp1_get_underflow_status,
 	.hubp_init = hubp1_init,
+	.hubp_clear_tiling = hubp1_clear_tiling,
 
 	.dmdata_set_attributes = NULL,
 	.dmdata_load = NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index 69119b2fdce2..631350cd4f2e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -794,4 +794,6 @@ void hubp1_soft_reset(struct hubp *hubp, bool reset);
 
 void hubp1_set_flip_int(struct hubp *hubp);
 
+void hubp1_clear_tiling(struct hubp *hubp);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 0637e4c552d8..200194544bf0 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -406,6 +406,20 @@ void hubp2_program_rotation(
 				H_MIRROR_EN, mirror);
 }
 
+void hubp2_clear_tiling(struct hubp *hubp)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
+
+	REG_UPDATE_4(DCSURF_SURFACE_CONTROL,
+		     PRIMARY_SURFACE_DCC_EN, 0,
+		     PRIMARY_SURFACE_DCC_IND_64B_BLK, 0,
+		     SECONDARY_SURFACE_DCC_EN, 0,
+		     SECONDARY_SURFACE_DCC_IND_64B_BLK, 0);
+}
+
 void hubp2_dcc_control(struct hubp *hubp, bool enable,
 		enum hubp_ind_block_size independent_64b_blks)
 {
@@ -1676,6 +1690,7 @@ static struct hubp_funcs dcn20_hubp_funcs = {
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_soft_reset = hubp1_soft_reset,
 	.hubp_set_flip_int = hubp1_set_flip_int,
+	.hubp_clear_tiling = hubp2_clear_tiling,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index 18e194507e36..7fd9240868c3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -409,6 +409,8 @@ void hubp2_read_state_common(struct hubp *hubp);
 
 void hubp2_read_state(struct hubp *hubp);
 
+void hubp2_clear_tiling(struct hubp *hubp);
+
 #endif /* __DC_MEM_INPUT_DCN20_H__ */
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
index cd2bfcc51276..d910e4a54c34 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
@@ -131,6 +131,7 @@ static struct hubp_funcs dcn201_hubp_funcs = {
 	.hubp_clear_underflow = hubp1_clear_underflow,
 	.hubp_set_flip_control_surface_gsl = hubp2_set_flip_control_surface_gsl,
 	.hubp_init = hubp1_init,
+	.hubp_clear_tiling = hubp1_clear_tiling,
 };
 
 bool dcn201_hubp_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
index e13d69a22c1c..edbdb8c88d5c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
@@ -837,6 +837,7 @@ static struct hubp_funcs dcn21_hubp_funcs = {
 	.hubp_init = hubp21_init,
 	.validate_dml_output = hubp21_validate_dml_output,
 	.hubp_set_flip_int = hubp1_set_flip_int,
+	.hubp_clear_tiling = hubp1_clear_tiling,
 };
 
 bool hubp21_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 60a64d290352..3b16c3cda2c3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -334,6 +334,22 @@ void hubp3_program_tiling(
 
 }
 
+void hubp3_clear_tiling(struct hubp *hubp)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
+
+	REG_UPDATE_6(DCSURF_SURFACE_CONTROL,
+		PRIMARY_SURFACE_DCC_EN, 0,
+		PRIMARY_SURFACE_DCC_IND_BLK, 0,
+		PRIMARY_SURFACE_DCC_IND_BLK_C, 0,
+		SECONDARY_SURFACE_DCC_EN, 0,
+		SECONDARY_SURFACE_DCC_IND_BLK, 0,
+		SECONDARY_SURFACE_DCC_IND_BLK_C, 0);
+}
+
 void hubp3_dcc_control(struct hubp *hubp, bool enable,
 		enum hubp_ind_block_size blk_size)
 {
@@ -512,6 +528,7 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_soft_reset = hubp1_soft_reset,
 	.hubp_set_flip_int = hubp1_set_flip_int,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp3_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
index b010531a7fe8..cfb01bf340a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
@@ -297,6 +297,8 @@ void hubp3_read_state(struct hubp *hubp);
 
 void hubp3_init(struct hubp *hubp);
 
+void hubp3_clear_tiling(struct hubp *hubp);
+
 #endif /* __DC_HUBP_DCN30_H__ */
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index 8394e8c06919..46b804ed05fb 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -96,6 +96,7 @@ static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp31_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
index ca5b4b28a664..8b5bd73b8094 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -201,7 +201,8 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_update_force_cursor_pstate_disallow = hubp32_update_force_cursor_pstate_disallow,
 	.phantom_hubp_post_enable = hubp32_phantom_hubp_post_enable,
 	.hubp_update_mall_sel = hubp32_update_mall_sel,
-	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering
+	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp32_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index d1f05b82b3dd..eb62042dfafc 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -216,6 +216,7 @@ static struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank_value,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp35_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index b1ebf5053b4f..2d2ec8562e78 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -508,6 +508,18 @@ bool hubp401_program_surface_flip_and_addr(
 	return true;
 }
 
+void hubp401_clear_tiling(struct hubp *hubp)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
+
+	REG_UPDATE_2(DCSURF_SURFACE_CONTROL,
+		     PRIMARY_SURFACE_DCC_EN, 0,
+		     SECONDARY_SURFACE_DCC_EN, 0);
+}
+
 void hubp401_dcc_control(struct hubp *hubp,
 		struct dc_plane_dcc_param *dcc)
 {
@@ -1004,7 +1016,8 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_program_3dlut_fl_width = hubp401_program_3dlut_fl_width,
 	.hubp_program_3dlut_fl_tmz_protected = hubp401_program_3dlut_fl_tmz_protected,
 	.hubp_program_3dlut_fl_crossbar = hubp401_program_3dlut_fl_crossbar,
-	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done
+	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done,
+	.hubp_clear_tiling = hubp2_clear_tiling,
 };
 
 bool hubp401_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index e52fdb5b0cd0..92041d7e0569 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -340,4 +340,6 @@ int hubp401_get_3dlut_fl_done(struct hubp *hubp);
 
 void hubp401_set_unbounded_requesting(struct hubp *hubp, bool enable);
 
+void hubp401_clear_tiling(struct hubp *hubp);
+
 #endif /* __DC_HUBP_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 16580d624278..d0878fc0cc94 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -275,6 +275,7 @@ struct hubp_funcs {
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
 	int (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
+	void (*hubp_clear_tiling)(struct hubp *hubp);
 };
 
 #endif
-- 
2.47.0

