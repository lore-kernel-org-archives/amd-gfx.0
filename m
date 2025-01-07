Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B36E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3168810E718;
	Tue,  7 Jan 2025 15:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0hRiviF5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6602710E720
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUGQpGg/4/XArlD+AWyoqUCtAGasaaXBBbwl9v0JqV4kWL4OgDivxFP+kdF3/B+ME0zkt3Xhsf585m1uPFejHFhHXv8HIZwenwXei9Yzk9eNMd/RPHWEpYYH3iIYx4SJyA8498B9JjX/zslpOZb0v1TMAPIWcEtgv6IM5WRm4uhxxoU50+eh0Pflx1lT0hJMlBJKlfIoxP4bh1MfuN1ny2mIN2G5tdemZYjpM9I4CjLP743VAgzBzEG3A+A64/Hsp4nwHnsrzpWIDE/Gt+v0sigXUF/HnXKphmSAKcRGWBs5rdD2imkf9kRj0TtuovBAWlFSfzDbToHdPpShV1Fv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVAhDTXN+VQEgFQwUAeBnZ6IKS65LFC+yzcdZs2SIzk=;
 b=QoaOsaA++5AQ3835XRv/nX4kLZ4A+s9l3WRSaz6LzMxW7vHsJM6S+YcHV7qhVY6GRHFOZ7C3Omw/W2XbI+edeSfyoLuC8kUzNm/BD5Lxu7bO6TmyC6JwxFi7IIbNjm6dKidIXu5E18xZImgb4EZ9AmldABnpj3B7yclM4ZHBx2Y1cU2EP3GFCMEryi1sDlibRiQyEl4WHLbeKwFvNFMLvTPaLFoalz6l4iFapMZkC2XyIF9O6+VdmjMUf+190x1mVze0I1/AI9ao/Rmq4oc05INcly0fVu40rNx6R4KzyTuG5v7wqUgDX3b1LR2n2DvrozoZLPWF9I79RomIl2fzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVAhDTXN+VQEgFQwUAeBnZ6IKS65LFC+yzcdZs2SIzk=;
 b=0hRiviF5TQhz6XzqP0ZmiqSrv83UlE4VDw3wafJ+ajZyz0cU9sP+v3dcSMXUmC9SEoglAqU2OMceiGxvCXj84kdKbhHZVsOSH86xWXkB9B1D3h6Tppyd7gxLAfNfYswgXGCcsC78ItWZiLWTlYQoSApoAW4ZyrzreGhPwYUbvbM=
Received: from MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::20)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:29:19 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::46) by MW4P222CA0015.outlook.office365.com
 (2603:10b6:303:114::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 15:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:29:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:18 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:17 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:29:14 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>
Subject: [PATCH 04/24] drm/amd/display: [FW Promotion] Release 0.0.248.0
Date: Tue, 7 Jan 2025 23:28:35 +0800
Message-ID: <20250107152855.2953302-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: bc194372-a432-4cdc-1ee9-08dd2f300dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?glOybIrzO37iUBL5tKVq5LOCR14Yt8py+RZr8iCLvGX9g9a8avyhjiFvEFN5?=
 =?us-ascii?Q?kN99p55iUYUqhngUxt5x24C8NKPhsGhnCq/GP7WJWthQIFUlUuHLp5gYEuJh?=
 =?us-ascii?Q?RtWbMmCQrbvpBczrTpOCNKGgIcDBquB1JCIS3NVNR5jAEDpoecNQz9CWjz6u?=
 =?us-ascii?Q?bZZAi3UlYGpYiCX6Oti+YRrkbweSFqHhNhYZtZj9jSTDwvIDhUc+gaRNE8h5?=
 =?us-ascii?Q?ucwbLHuGmYMjrhcwCmuFEnn+qsa5CH68fVS1oPBLDFy+RrZpxHqEE8U8gwKC?=
 =?us-ascii?Q?alGSYQNiLNrDcKbx3PjoiKrzQBIbkP9yqd+k2g3jXcYTDEsBl+5oSRcVzTLJ?=
 =?us-ascii?Q?6yKsqdy4WvvNpndWysqdMbX59y6Tkh9UxEDaFco0K2hPjs1KgTMXyDcghOjR?=
 =?us-ascii?Q?l/R4VzZ2O5rilSNb3x5JilB+bAXxSvrP07tVoTykVhPcrGAre5pdjJSEAxlH?=
 =?us-ascii?Q?7HJYw6Cv3Boedh/ZNoQw7pkNFOM8VnqunKMaIsG833zZ0eMQPPX56Fx3qozJ?=
 =?us-ascii?Q?gYEAlR1GBLYKRyGa33kA1wyrGYgqDgGseYYM6ULOMma7N+Uhh1u5Qg5Vsonl?=
 =?us-ascii?Q?AQR+EZqEaavHZ24SVu+AZHawA8iw6W8COCZXbHQMO7pfD6Q55hsXEdXu+qdb?=
 =?us-ascii?Q?JGi4QkwJcUVGsVnVUp/STens4rEKs+bJGEwCHAqf3/Pz5/NwMpH9N3WD+gyc?=
 =?us-ascii?Q?BrscdWn13XpfaLfJyzkN9FSSs8c3klKb0L0pcd7XystHnQRul+e0xvwbo3Qy?=
 =?us-ascii?Q?IK05HjKtmiHP/Rq5Uk7dUSniIS1BaUFG/hnBirCg9tXJvfLgMZtVsslAnof5?=
 =?us-ascii?Q?hSsrDcCEkdh1GgVmmOTRY/gdK40k0y3LHatLpkwKwAe/Dy2JZPQTc5PsEa95?=
 =?us-ascii?Q?fwrbZoYfsl29NXUNKLT11EA1tQe8/DPU/WBnL8pbWola8l5MyXDt+G9q6F7K?=
 =?us-ascii?Q?uMrAXSc8WKQXWVe/ub6ASyAouEQQDEAk69OX1Boy2HEdkgvhpFHzxpwmFxMQ?=
 =?us-ascii?Q?3IZiNI+NQDohn22Cb1OD+2NyHF1uHkjMrALERp2iTHsvSHUNXOaHlkxBWrSR?=
 =?us-ascii?Q?vlUo3t4uEhYb7r/U8axpuaLu3FZnzPCf1X3JXppDDakXOWnTGbe0dkUnOJu5?=
 =?us-ascii?Q?EsWM0nhLpXqLP3LtG9zdeINIzM6wjB7DXESQvMUluhODUGlnJalglk9h91vQ?=
 =?us-ascii?Q?SlN+xNUwx7J4Jpy9+9vXYm7bF4ilHHV5p9fDFEsdwJycfhustojkuSGzZV2u?=
 =?us-ascii?Q?StHnJNWcGaNH7Yu6HFVhvznj8Q4jqDFN7GdRkal0rIHnUeCMksF1oewumngC?=
 =?us-ascii?Q?7f0JaJY1L9CUlDUxZflvOlf/hSopRNDqiK4kQ7n4+RQqFmJ7jniNmCwAWQud?=
 =?us-ascii?Q?ovZUcdVk4ok1iE+KDtCI4KtV/cCrL9kDGjJ9O4f/clUB7YFIYNejCt9YUULT?=
 =?us-ascii?Q?Qa8U66VVTMwAnfSFIIC3sTQzBQDlXFD5JtGcGYdgdFXiFngFzRAXpgiZlOdr?=
 =?us-ascii?Q?T7CoeiYD27+Jxhk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:29:19.0324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc194372-a432-4cdc-1ee9-08dd2f300dbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Refactoring some flags for replay

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 904309943ec0..d0fe324cb537 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -436,8 +436,13 @@ union replay_debug_flags {
 		 * @enable_coasting_vtotal_check: Enable Coasting_vtotal_check
 		 */
 		uint32_t enable_coasting_vtotal_check : 1;
+		/**
+		 * 0x2000 (bit 13)
+		 * @enable_visual_confirm_debug: Enable Visual Confirm Debug
+		 */
+		uint32_t enable_visual_confirm_debug : 1;
 
-		uint32_t reserved : 19;
+		uint32_t reserved : 18;
 	} bitfields;
 
 	uint32_t u32All;
@@ -446,7 +451,7 @@ union replay_debug_flags {
 /**
  * Flags record error state.
  */
-union replay_error_state_flags {
+union replay_visual_confirm_error_state_flags {
 	struct {
 		/**
 		 * 0x1 (bit 0) - Desync Error flag.
@@ -483,15 +488,11 @@ union replay_error_state_flags {
 		 * Reserved bit 6-7
 		 */
 		uint32_t reserved_6_7 : 2;
-		/**
-		 * 0x100 (bit 8) - DQE Only.
-		 */
-		uint32_t pass_low_hz : 1;
 
 		/**
 		 * Reserved bit 9-31
 		 */
-		uint32_t reserved_9_31 : 23;
+		uint32_t reserved_9_31 : 24;
 	} bitfields;
 
 	uint32_t u32All;
-- 
2.34.1

