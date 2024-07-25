Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04499C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFD210E8C3;
	Thu, 25 Jul 2024 18:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ktm2qN6D";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4CE10E8BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fltuhkxtt+v1OGLJQAJIBSJhkIS874VYM1EOF8sKBm91zWtQkFmgs906wGKzzTSVEL25XvDXQdgnqDwFvWVvCcCOOkdYbVoAnWZcqBqWSjqw0Wk2uEHPSVDRjghodIx8CbAJfX1vQy1sfadiNI1/gkcDnEe96F594gpVi5SqjYzBE+pKwp/LW4diaiePgVypO5X0JAIMXaZIjyxMttpug5sWmxaoTiG+h1fmSI8bw67hCLOBtA33PMhV1ypqn9NmiBARy6fAMxuU/my+lABa3jeagSIX6UuUDs+HzsUEVPjPei3lk7cdx3vtw4D4H7UKnUhYRplblwrbQ0sfCKpYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZcEBcEcAGdEEgaxqF70XjpzrP1VUAsHmPNA4x+fl80=;
 b=OcndMt9FkEF5iEbyY9wKgpWPNRQ6hRzfFp7JkeyNnBE0SLicsF3rF8ycsfT2V604DOfAAMzGA7xsydnF4lH0488SqWUl+TtLL7wiaE5J8I41MkFAVAPC7Pd1N00Bf/R8ijzYBgxGI1mmVJ0rRKMYCIJ74/wQu1Z+ox0i0VMEGFJN56FXhavFMV4uOwspLl8pzqwgh13VmAyeg6gthh1IfXhYdjkt3QhPoUPdqHZsw0QqtdwztHPSh+PPe6tFMx4aAfaY3FPeOK03AcY2a1+LoT95RW0qMuwN5FNj24Kw4Cq7goCGUJkIudHsCmAAsRP2bh/OY67ln3aTowva69Lt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZcEBcEcAGdEEgaxqF70XjpzrP1VUAsHmPNA4x+fl80=;
 b=Ktm2qN6D6mwMw11ILqbzq9lFtUF6vYhhjCMqLG4DGBhGHVWbqT82KtLvkDeGqDtSadkShKxIhIWuSebPOMvcWOCD9MMb+pKwbfZs+PJ7ke6XgB+FXFbSo3i1db0/e/IbZcTi2bX1fAzfstiIIeRdWLvvCje5UI2Jd06Yaf5cjxM=
Received: from CH2PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:4e::13)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 25 Jul
 2024 18:04:42 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::6e) by CH2PR02CA0003.outlook.office365.com
 (2603:10b6:610:4e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:42 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:38 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 38/39] drm/amd/display: Remove unused code
Date: Thu, 25 Jul 2024 12:01:22 -0600
Message-ID: <20240725180309.105968-39-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b42fda-507c-452d-7db2-08dcacd4422d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?okvDtDXHQJMK8YE2lxvfWEu7jiaJBSIkAYImKavYoLhi589uxZY5YuRZNfvN?=
 =?us-ascii?Q?tA7xTwKdy73RfHtUqr4/KU42TAlWE76VCixO4AZ2HQ0gpPOa5SyTMop5pM92?=
 =?us-ascii?Q?WsbfHsRhv2l+XZ/7cI7TQ8pwDXgLYF6odESSmet7Cc2gYM+GUUDErgQMwsmO?=
 =?us-ascii?Q?MicgAO1BNyvqf9WPjs82d9akV97Ky8uTPgqaF5mqb1KX6eeKj+PNjNKajzun?=
 =?us-ascii?Q?QNhkTATf12jdyfAj+H4loEr+l+q54gTL6h+i4T7BVD41yLMDNeIgdRnubmaj?=
 =?us-ascii?Q?O+lClkYKo1a/ZbgR8+V32E47bnKPPZFaPuOd4Vnu/MIhFvgv+5rkczadggnU?=
 =?us-ascii?Q?IEWe/bogmYQtfmy7Kh+uerArgxOnuqXE0FemgBk4/Py9QQtrrgBhFzD7+sQt?=
 =?us-ascii?Q?pNxFRh8GeeCQ6Gkn7/5mPwvxuAH+OWB7tkEguNY8I95Xbtnftw4E8fWu9tHi?=
 =?us-ascii?Q?Tcw0pbV/27AV0VwR0mJ4JMIePgHLIClPQLXoA+YC9XFYq1PWn2eKig1rQm7c?=
 =?us-ascii?Q?D6/zWeCFklPqfqwtm83i18nnu+pud0kcWOThzKIjAr0KGeRrqmNelzsGHDiT?=
 =?us-ascii?Q?k02pO++9sHOyY8G+747MhbCtELgZ/r8n9QRj8hr0qOQ33W1CQe39ymTTYLU5?=
 =?us-ascii?Q?+KfFUO2+jWJKqhEQ8qg9TdLq+Nvwn61BzPmn2rajUsYbCX1GSuwLCr09M+eA?=
 =?us-ascii?Q?jrsj8LQQ+fWO58CYBkSaC6k5MfhbBTxstqyGpmvkAsPam7VqLF08PXMcafPu?=
 =?us-ascii?Q?4CoaprFlK8n6TA8NCCbW1bFcJ4AweIitrVyJkahk51qWl1vxRxmoOyGOK6vI?=
 =?us-ascii?Q?KRBAULpLFR9H/vqVgv8erEBQeryt95SUwV5AqwBa91TDfeLGlimvHNLdBiDQ?=
 =?us-ascii?Q?wjB5TchsU0ptfgmdNI0oUryyNLCGicUc3ZznQO4c0cgH/c68yeTDjXpaQpKf?=
 =?us-ascii?Q?0gpcsgjyyV2gzteaRU4HxLXhdvFtwcW8l6lQ6uWLGtCQ41qqOIGaspPBQMFX?=
 =?us-ascii?Q?GdgTjxtNWcplWt8afPm2bGy2QhCHbErxrGj6yXZVRBRj6oYZI1W7vkY3a+v/?=
 =?us-ascii?Q?0ftR/ODPZz8EJBHoBdkJPccNkre4RQV9e7+v5tZEj1f82HfMKb+d6mWhWNCo?=
 =?us-ascii?Q?C8BBPYTrs6hgG6VSqsf1JAtlW9D36qASOXG24PH1UDj1H4EjVAA+1jABHk+3?=
 =?us-ascii?Q?iPNrVnyip5TizHIAKefvKeUX9RPV79aR1csjifrzSnHsXLn/DgU50PRyblTe?=
 =?us-ascii?Q?AJD+akIhr/1QalMkk+jwZ2khdzQpfPNbm1avUP7xBJK1iDMEFaJa/xlU2CW0?=
 =?us-ascii?Q?dRPy+I3RhL51/dk4O01dQey4/qaz2nElA73tWNMOGxuLpqYkGtjCUOyU131e?=
 =?us-ascii?Q?iHBcn/DBPtC/qeoXzk0sDyp3pyODC5iZ8Zyq2K7LlEfEB6MYMSw928aSBSxk?=
 =?us-ascii?Q?21rXjTzN7mTG8hc0Iln8XIqD9sY9TFen?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:42.0902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b42fda-507c-452d-7db2-08dcacd4422d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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

Remove function pointers that were never used.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
index 28da1dddf0a0..45262cba675e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
@@ -245,16 +245,6 @@ struct transform_funcs {
 	void (*set_cursor_attributes)(
 			struct transform *xfm_base,
 			const struct dc_cursor_attributes *attr);
-
-	bool (*transform_program_blnd_lut)(
-			struct transform *xfm,
-			const struct pwl_params *params);
-	bool (*transform_program_shaper_lut)(
-			struct transform *xfm,
-			const struct pwl_params *params);
-	bool (*transform_program_3dlut)(
-			struct transform *xfm,
-			struct tetrahedral_params *params);
 };
 
 const uint16_t *get_filter_2tap_16p(void);
-- 
2.43.0

