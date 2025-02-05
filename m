Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFABC0219B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEF410E3B8;
	Wed,  5 Feb 2025 18:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I1GHNSfu";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52CE510E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWmouYdXhy3q/cKfSSxMfmsD6clGKv/6oUDZYzpaMj/7ee5tVVJABWXFC//UqqiLijy7cJY39iXr82ZcGCl3kdkVtrgXwtkjGa26wzAgx5TV8HzCXI9P8nXaUoBtbAtxYG4gOtsDgssncyGKCpffC11BsujpuXXwLMGdgcV2+4Umt2B6T1sgbHZco0tUrN8ain8iuqEFSnVDI0/G72zzfc4QUgJChHFUlM2OBiGUL36cbceU+9P8mzZY6xj74nfOc/jZakFuEyuCtfAYwxKKr9sCIFj+PokCMeMrXxod2qBFeQ04Cv+Y86ahbvOAgj+49VLHQZK56JneqAmbcnlQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRCsdWcDo5xQIgbujWF8esmSznB880M9bFPMxHlT6/w=;
 b=gROnm809cuigb1fk5E4/GGISVnFdPDCrpNhwKVJ2SZ6a4MYdWx6XuPhAO1eBhPs+/GwFUj62hzC//g5id+gXk1/KqQ87aB98aPt7BlAoGbEBafqFfBx0PfqjFQi9mmr0NzVZMpuiATCiAnQ40zEX2CRGAdxfXIKle+keVXbXX57orlpPfmCn5j6C0Wg1G2T+JFc7iPg67dy0wmdxaitaT/DQ99K8Zc+IQhBmQFkrWf+Dl8Rf48N+ADAbslZ73gLBRYvSHZxTfaleTwTzbPJBg78AtYOk1+SoIsmV4Rsyqu77hOlRHQdMwRsjsgjTcMNF8JTNuMgQhAF6hv3L9Bcsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRCsdWcDo5xQIgbujWF8esmSznB880M9bFPMxHlT6/w=;
 b=I1GHNSfuG4CJFxBHzHfFjDF/Auuv3FQ3iRLmwyeNCQIz5noaWi0VZXafNQipQmFB0pIqB8BORJ0bLNAo2BQJP1pj5ZhTXKUmDXvU/DbSxT8Cx2gThBn8cNMeo02YmGqB3ZF6Tr1NICpfWXLjwhhfZculmSeCOPtjNyFega04XEE=
Received: from MW2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:907:1::34)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 18:41:01 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::46) by MW2PR16CA0057.outlook.office365.com
 (2603:10b6:907:1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Wed,
 5 Feb 2025 18:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:41:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:59 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:59 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:40:59 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Navid Assadian <navid.assadian@amd.com>
Subject: [PATCH 06/14] drm/amd/display: remove TF check for LLS policy
Date: Wed, 5 Feb 2025 13:39:21 -0500
Message-ID: <20250205184036.2371098-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 01316796-3115-4108-2331-08dd4614a335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vRn9B0XpGEFb/54Td4xwHcyB1ok9EdFG2wct7TDj87VY409Tlz29XoZyWidj?=
 =?us-ascii?Q?bp7bcitZ+K7TDUQRqNZf1kbyAOFyxhDmQdGsSjC7EEHdIF9t14gz9N1ug4pr?=
 =?us-ascii?Q?s10gkXlqsM8MLIs6YOUjtfjw3juuQs7nhhGrGXDbfMF4dlQ6nn0ik59oJ/KB?=
 =?us-ascii?Q?v9VKdoDUWiiL5iXRlloSjIGhi3uj49vu8Rt0xpbfCDUb9oS6TGbrLsOtUyQT?=
 =?us-ascii?Q?awOsfEMovcGLebsq/ROcwxi5xqSwZiQO/Q/AryU68yRvjrZFIx58rAuxZnVD?=
 =?us-ascii?Q?Gdm96XoABtL7CoR/sH4Nwp0ZykAHk9fQzJthyYB8QuCyIDOLU1MR9kOkQ16k?=
 =?us-ascii?Q?S+WPRGSX5IUMGH2iodFuB7EMJvjrnPCmkM/ytr1aCefUysR9P/9MMncnByOy?=
 =?us-ascii?Q?NJQt60YaTi4QqF/fpQNupMRS8OwMFUXylNQrF1Q/aXIn2/g6HM1Cgd/TP2nF?=
 =?us-ascii?Q?VFoCLjL5Xoknxd0A9/YcxwDToSkUef0rvKboF346h8ed5kseSMoW2evgOZ3K?=
 =?us-ascii?Q?zZ7j3AGI3lWm7H9QPmCvC86tU/ZwBOgMqmA0pw50MCavpDCuZtTVEJywffZX?=
 =?us-ascii?Q?OViPrz6cll8BqURpFu4wdkxv1yWPqRfnmE/QDcm8hJ9gpbdsmKYVnA71+/ER?=
 =?us-ascii?Q?09+GSQri9Prvl/750NqWSRFBvDARwSo9qjo8b5eVCjggY1oDHBO86nZdeSn+?=
 =?us-ascii?Q?K8JMOsEeyjz1lEPRgZlh1wPWSoAo4gLEVt/DQITkGVTLB4bDRHVihNyB2hlL?=
 =?us-ascii?Q?GFSwGqdNyTiZ7siwmIJnk/LgkinZdqDgqqjlHNfrXcbCXhUL1D1s2pFetx2f?=
 =?us-ascii?Q?OB0XbeubxB669irxNp68usIWLIcSACzizElMfdox4hHAnDhT6K7DorF//SQN?=
 =?us-ascii?Q?BjaQCFziMnl9XcR2tYv5LUEl1+NvV4WXlARafZaaFrmvHxftNn95SjPuKsl7?=
 =?us-ascii?Q?yNL2clKx2BeF6ELDv3xm40hzCEeNWPNFBnA/rW3N/fCO8wBbCEkyCQaCYjtG?=
 =?us-ascii?Q?otTVr24ERCjtnGDWtLGwB3I9LZ8w/mQNicOqXE+9iNCjuLpyCJWTbWK/TiTy?=
 =?us-ascii?Q?t/T3/ozLlEXbcdsGVusmbBOHEQI7lJ9elWRu8hKHWMKu89jtg13oJPfeZzmJ?=
 =?us-ascii?Q?ggiIBKmqnq4JeVEgBODOLyGb9vPZ+/ZLnsFGsQPugcNHCXc9YX19EE8fpiLj?=
 =?us-ascii?Q?USBdDVSSZn7Dlj0ZhG3oyR4D0SGhxUMaW34sM/L5wQsP82JjqoTx0pzeeCgy?=
 =?us-ascii?Q?FxYUISvg1UYDONnPS1uqxqp6ptHKXz0SnLBEMiRV62NmBadH2PTZ85Nzvx5X?=
 =?us-ascii?Q?QGw6ecqsTKtYAdeLpr8uOtQ7RXKE6sz5tg1sZRyC2MEmUDF1ZnAMeveLDt3c?=
 =?us-ascii?Q?BP93refXjZdceLtwEUHx48WhBYR0OifD0ujbg46uWPCnGEVMbaC/qbV4qh+6?=
 =?us-ascii?Q?jT0upJthYQOPt+sjjRFVJK8JDlf5OO6r1EpXMVPpT0hFzWGG6w+yptaeArwN?=
 =?us-ascii?Q?a/wvcfbgGm0Y6go=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:41:00.6374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01316796-3115-4108-2331-08dd4614a335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
LLS policy not affected by TF.
Remove check in don't care case and use
 pixel format only.

Reviewed-by: Navid Assadian <navid.assadian@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 31 +++++---------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 38a9a0d68058..31495c9978b0 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -767,25 +767,13 @@ static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
 	return SCL_MODE_SCALING_420_YCBCR_ENABLE;
 }
 
-static bool spl_choose_lls_policy(enum spl_pixel_format format,
-	enum spl_transfer_func_type tf_type,
-	enum spl_transfer_func_predefined tf_predefined_type,
+static void spl_choose_lls_policy(enum spl_pixel_format format,
 	enum linear_light_scaling *lls_pref)
 {
-	if (spl_is_video_format(format)) {
+	if (spl_is_subsampled_format(format))
 		*lls_pref = LLS_PREF_NO;
-		if ((tf_type == SPL_TF_TYPE_PREDEFINED) ||
-			(tf_type == SPL_TF_TYPE_DISTRIBUTED_POINTS))
-			return true;
-	} else { /* RGB or YUV444 */
-		if ((tf_type == SPL_TF_TYPE_PREDEFINED) ||
-			(tf_type == SPL_TF_TYPE_BYPASS)) {
-			*lls_pref = LLS_PREF_YES;
-			return true;
-		}
-	}
-	*lls_pref = LLS_PREF_NO;
-	return false;
+	else /* RGB or YUV444 */
+		*lls_pref = LLS_PREF_YES;
 }
 
 /* Enable EASF ?*/
@@ -794,7 +782,6 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 	int vratio = 0;
 	int hratio = 0;
 	bool skip_easf = false;
-	bool lls_enable_easf = true;
 
 	if (spl_in->disable_easf)
 		skip_easf = true;
@@ -810,17 +797,13 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 		skip_easf = true;
 
 	/*
-	 * If lls_pref is LLS_PREF_DONT_CARE, then use pixel format and transfer
-	 *  function to determine whether to use LINEAR or NONLINEAR scaling
+	 * If lls_pref is LLS_PREF_DONT_CARE, then use pixel format
+	 *  to determine whether to use LINEAR or NONLINEAR scaling
 	 */
 	if (spl_in->lls_pref == LLS_PREF_DONT_CARE)
-		lls_enable_easf = spl_choose_lls_policy(spl_in->basic_in.format,
-			spl_in->basic_in.tf_type, spl_in->basic_in.tf_predefined_type,
+		spl_choose_lls_policy(spl_in->basic_in.format,
 			&spl_in->lls_pref);
 
-	if (!lls_enable_easf)
-		skip_easf = true;
-
 	/* Check for linear scaling or EASF preferred */
 	if (spl_in->lls_pref != LLS_PREF_YES && !spl_in->prefer_easf)
 		skip_easf = true;
-- 
2.48.1

