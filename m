Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B76C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 07:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D5710E36B;
	Tue, 30 Apr 2024 07:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G3CWZ4dS";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7039410E4CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 07:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNjV1W1aQ6s1kBWKnTFTW10TE5V2PBa5N97C+nPKUPh70ck3BLOG/ifmSZOq+7XrUZoyn7pi6PwwgubGpFbPmKDWfuMRZXqPiI5AVDWPmysE7hyxwgYyuGxxq45eTFjwaHVydk15v0o55bkdbiBL6Yyt3K+7IyIXwMVnNlNYtl7qd2nGgCyNXECriUm8PcIg0kqRnOwSVwUNaEssZOdUtJBgs05olUtV05EWyRLp3bG3YlPA7OAojXQAKt79p4SXdXu7pzdQIEAnLG+UOrwPEeuy1OF0suB5ffXDU9L3FkA0ttRtjgIwsrN5+yy4+S4XhTVZmVDWQHUq26sOG96LSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90ghHPLUToHOfblLHqW437P4vBBbIuDGJOxgoXpKJAU=;
 b=OhNy9XpZM/JhPzijJmFQYyexVEF57ZDKUsQ80uroFCH90tf8FZOM7nIfk7zrPZCy9v/qR6hqZvk0yXggO/h8Io5YFuLgddHEcrEEScbWS9UEShbjTFmfvD383wUcDC9AzQtBFq8fZlwJCGm+31Kky8aVqIIHrTOfwgcnif+QbD5y5IOAR5N6R5uB0DnlvL2hRWDApJ1QVe9lGKW/UBLZAdW2Owiel9P/sPPPykGyAz+jWhmffH/BAJSo9d9XrkHEjlFuOCNlCOSmPdEOZoM7c2mDSvI7zur68zAiJ6eWNa+4z6Ts/04c4LT7ooaRpV9lQE8j//yGjVXdygTfp4EAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ghHPLUToHOfblLHqW437P4vBBbIuDGJOxgoXpKJAU=;
 b=G3CWZ4dSYfo4XgmsxzZx+0N8EZzOHuqKF2OnAKEC3DRz6U/bz7Oyh36CCtBbg4/l+5eLEnAANHdD++bkL3UrfTSNLRoChsnDTYRxgGdEk80vMjNUKQMKPSOxcxeduN9BSL06T+5k0PPcpXJDk+D96oydFnEM8TGKU7ARA2Qrz0M=
Received: from BLAPR03CA0044.namprd03.prod.outlook.com (2603:10b6:208:32d::19)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 07:14:20 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::db) by BLAPR03CA0044.outlook.office365.com
 (2603:10b6:208:32d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 07:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 07:14:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 02:14:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 02:14:19 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 30 Apr 2024 02:14:12 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: fix the uninitialized scalar variable warning
Date: Tue, 30 Apr 2024 15:14:11 +0800
Message-ID: <20240430071411.2107891-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 12dbd420-7d52-487b-db6e-08dc68e527a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yaQ/A7Yo+Ny1pSgf9/R1/QL9U50Fc+HXvAqHcv3LweMkhzxh+q5btbxa7o/W?=
 =?us-ascii?Q?e+YX+BzJ00ahlYdmRNitbS3CtuMpq/Oq5dFASfC/H49hzXSpBtsVVxiRWVrB?=
 =?us-ascii?Q?9Sbf3o01cuq2La2zcBVUjiTpBDxgbQZ6D4o3inro3dH7TRxnW+Y6+JVb38Na?=
 =?us-ascii?Q?Ca8r2G3EGMCTKvtBK6fnwsqG/eePI6ks78pVIAMi5yPQlcKeJJLDXAhL+V5i?=
 =?us-ascii?Q?+sJgUDM8EIIBA3MfpFBDiq+6FAqy/vmUhlx0aVdRuyAs6p6m2IapzrliZ1yo?=
 =?us-ascii?Q?BeR9BTyLwNIdJvPSlbrFKr8IqO9TIMCuHjaUgZAsjSEbqQ1OJ5MBcUZsJm58?=
 =?us-ascii?Q?zIxdS3aWLfdOgpdJqzE7vHnaozIX9HVgvVu6OFHpvk/j/I5iQkVZTNMYjozv?=
 =?us-ascii?Q?/mT/Qwz7SzjtO9qC4cWKG+UoU8g7WfQwWs/iOzbkG2vrgPza2oVdaHrcuG6U?=
 =?us-ascii?Q?bKHbIHop+uUsllR6TxqMwsxbGgNU4I0k0isL7aMUc1683w0M4+nKYJA6l/hO?=
 =?us-ascii?Q?uP4+kK7+R+Huc6De/cCRYHRXKJotaxGPrvZqr8K8Y259oOEGzNZX1BvXKEke?=
 =?us-ascii?Q?3NhNtoA9JRIOV771nGT3xnFmBotgoxpB4/M0l3sWZav8C7TxcIB0jMFj74cL?=
 =?us-ascii?Q?xsbM3o6zCfIBVPd6TZGaYEwcRueZ6Stcs59HUKHvtBr5DwD0OEY9dcgkXXFe?=
 =?us-ascii?Q?SaAduPnH8z1chYd+1+IFQ0O383/jQyItqWaHkzdbg5ZEji6j4nzm75gj8VKM?=
 =?us-ascii?Q?dybQrn3/Ri20Rd+bKoRcbsRNQSd8j2MuZDskR52tqlt4gRmqvaqCoMk1jeDY?=
 =?us-ascii?Q?alpqaRMtargU29gjcqMNbAhJeWsxZvU1Qno4xCNbbZn/F3aWsBmMuvPJSgzP?=
 =?us-ascii?Q?M+XuM36N9rONhP8TzmKmVXX7IuniTQY23Z+oCersC8Ac31i3Ad3E2gf5/uRG?=
 =?us-ascii?Q?yKmI5/aNsptaMUfPJ/SI2yYek3uemC2d0ojdG6M+93t8zOd1NLtNV2zyi0DB?=
 =?us-ascii?Q?FttomT52vA751XWpTnVua0XkM8BT4buDFhY+H/fgCYqM41JHN4bDvoYpjeAN?=
 =?us-ascii?Q?z9h8DAjWjgcrzjmljKcTxJocLts+tLuZ0SGLF6kTTNK+4noncBp+ViRJZna2?=
 =?us-ascii?Q?v7NQSDwS7tiRI22qodLbKxbYRMQ403b8x/vjXoe6bzLrWu0tcHq5usixDCKM?=
 =?us-ascii?Q?jrh6OLJ0GLLPUrvCJrirZKpbBg3COdYFRRx1NiILQy3bWRKvdZrVDh9S0Q22?=
 =?us-ascii?Q?DTDotlmykzAXvLaMtH4mkbnR4n582/FTzwX49IboLGNY91v+ZvwWAYITlzg1?=
 =?us-ascii?Q?/EzAAjdb9aZ74dNg2lzBtWc5fZ/l1z6GvhYFVPv/n/Ao20kFdN13o2wIhwbh?=
 =?us-ascii?Q?uT+3qRIOccY/99WL4NVoix8PAUvL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 07:14:20.1173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dbd420-7d52-487b-db6e-08dc68e527a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

Fix warning for using uninitialized values
sclk_mask, mclk_mask and soc_mask.
v2:Set default variable to UMD PSTATE(Tim Huang)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 8908bbb3ff1f..36a49cfc22e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -835,10 +835,20 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 		ret = renoir_get_dpm_clk_limited(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max_freq, NULL);
+		 /* =  0: min_freq
+		  * =  1: UMD_PSTATE_CLK
+		  * >= 2: max_freq
+		  */
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq,
+							soft_max_level == 0 ? min_freq :
+							soft_max_level == 1 ? RENOIR_UMD_PSTATE_SOCCLK : max_freq,
+							NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min_freq, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq,
+							soft_min_level == 0 ? min_freq :
+							soft_min_level == 1 ? RENOIR_UMD_PSTATE_SOCCLK : max_freq,
+							NULL);
 		if (ret)
 			return ret;
 		break;
@@ -850,10 +860,21 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 		ret = renoir_get_dpm_clk_limited(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max_freq, NULL);
+		/* mclk levels are in reverse order
+		 * =  0: max_freq
+		 * =  1: UMD_PSTATE_CLK
+		 * >= 2: min_freq
+		 */
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq,
+							soft_max_level >= 2 ? min_freq :
+							soft_max_level == 1 ? RENOIR_UMD_PSTATE_FCLK : max_freq,
+							NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min_freq, NULL);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq,
+							soft_min_level >= 2  ? min_freq :
+							soft_min_level == 1 ? RENOIR_UMD_PSTATE_SOCCLK : max_freq,
+							NULL);
 		if (ret)
 			return ret;
 		break;
@@ -932,7 +953,8 @@ static int renoir_set_performance_level(struct smu_context *smu,
 					enum amd_dpm_forced_level level)
 {
 	int ret = 0;
-	uint32_t sclk_mask, mclk_mask, soc_mask;
+	/* default mask is UMD PSTATE CLK */
+	uint32_t sclk_mask = 1, mclk_mask = 1, soc_mask = 1;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-- 
2.25.1

