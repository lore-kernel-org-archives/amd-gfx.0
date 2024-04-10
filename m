Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F51CD1297
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BCE10FD4F;
	Wed, 10 Apr 2024 21:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k405LRM3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D6110F948
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF+W72IKh7ICNpmrHCmURuY2hpmR3dSgtVg/5EIkbJNtSTatEq4PBhDlptN83oIh7Q5goZ/4vyPHS7JF8AaUuZhUCGYGLbcMypsjZSSK86p1817q/mdiDw3ecAEWOygrEPv7zFfk2oYan3jK7dYT1OhJdkGUtdc3tUZbzfm1UGW7534FZDqEy8Q965ww8s09NAhjubcdC7vMCQ8Kx+2ulkBLdD+KjYWuIkpDmj9Fk+lVTc2Iou6nq4k6AVqF5yhGEO5en8rLabfft9rMQJWcmTPheA4Vwn7+Oww8HL+QwrmnNFXm3R9PXW+Ite3h3O+Rxk4BQxQqWgRLGsnkhlEM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt068GEOesBNLTV+MxphkeIi5Uyyqi7l8OQLkbIWVuU=;
 b=JfTFXvjDbeDgCACX+4py0OiawcOifzxAMqZI0ZNmWxNkRS5LavckyqiSol4BpsifHRaolm2ojTGX+pA/Uc8w6bSouWOhNFtHQcXjnysSIfOysvJYqPPffon741gfEGptIu5FHdAXtT7h417ukTM0wYab8w812cxgEs+92IAUHeickDKK9jlfrFXkLzHxovTv2Y/bTNAjnTgFv4b8GEeoDIN+472sxxt7rg+AQA2jf/2B7kSfv18hFlKcF6bUEXL0erMYKXmjTlEssR42ER3n1vOl9CGPVdpgIvO9UIexxgkM6GIyxK3rZNq5Jy8GzJ6mup3ocP7I2aXKMHUi8M8jWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt068GEOesBNLTV+MxphkeIi5Uyyqi7l8OQLkbIWVuU=;
 b=k405LRM3Ib9hQYCKYLZHAxeWaUBceg5LvJm4UFNCj9LgZ9qCxLvWLuky+S8HQuHaASIC5peKDaPFEe/BNT/Uc8QhWpXwVUs6p8TAIVw5Bp85rddr3UhmQgoOZmKmVChaNT66gAlePLcdRNPyYOvXHH+KCXvf9KBloIVQT7ueH0A=
Received: from BN9PR03CA0145.namprd03.prod.outlook.com (2603:10b6:408:fe::30)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 21:28:23 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::c2) by BN9PR03CA0145.outlook.office365.com
 (2603:10b6:408:fe::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:22 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 20/25] drm/amd/display: Rework dcn10_stream_encoder header
Date: Wed, 10 Apr 2024 15:26:09 -0600
Message-ID: <20240410212726.1312989-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ee37a1-9f13-46f6-3bef-08dc59a5267a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cO8m8n+G8SUF7kP+DuxqruYp5kjlHrF/MAlpAP56iDrfd+55u5MMwg0SzkBZTLHJGP7Mji8JzR2HFn0y6Md706USnq6t2ZJgS6lJxLKFMTB+V4YQgA78JAjMhHs3DIyOjpmNtp5e7ip/RN9s+rjekGS7G6DU6/3SOPiQPpAAkGwiX9pjfRTXqOrviEhoCL7JkOokBzgIKnS81TPZZwusC3WrMQlVryRVi9uCtqX1P4kfauWlZgGV9u07enCrMlbm1rfmla7BIV0P9ARigaSiDUEMQvfVtg9oZFd8u1cXcqT17sRZ0UGgNYF6H87xuW+/yE7RIs1VTkKKHnVrODj3AiJ5Pn5Ef/jACq69/sI4g7+M4/yuOpMaFc1WSnMdqUvqYoKU0NEPzSBCk5k9NZmGfPy7R8gzYTxkG4In9KzPpfdEdlz0IwR96BPTZajZfnCNVhauJjbYTDd52AEyATaXUIgS3c46Ok/6KQsBCZ/ipAJzd8uoKdWotcqBm6nYwaiDF3XfGtF/WzvJyE6l6sLm6BGifV49aqoZ0U48RqSFGdsoqnMeQNaV/9suDlijzJeQHgwTYdWZBupsY/PB3bfmW9ZJmB0tGz4ExEfmsCsGO31ArjIaahK/bTi89K+ienloHJow+LiLzaDMY5f19QWD+7PwLIxQgJc5hHuwke5Pjr9bE//ovySgV/G6fkUH5fCAjtJUMH4xbJOua1zwXKQg8ROz5pT3eVm+mYiulemWbsTGkOQoB3yAo61Z1fBasuXO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:22.8069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ee37a1-9f13-46f6-3bef-08dc59a5267a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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

This commit remove some unused code and also rename one of the define.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_stream_encoder.h    | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index c429590f1298..1b96972b9d0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -127,7 +127,6 @@ struct dcn10_stream_enc_registers {
 	uint32_t AFMT_60958_1;
 	uint32_t AFMT_60958_2;
 	uint32_t DIG_FE_CNTL;
-	uint32_t DIG_FE_CNTL2;
 	uint32_t DIG_FIFO_STATUS;
 	uint32_t DP_MSE_RATE_CNTL;
 	uint32_t DP_MSE_RATE_UPDATE;
@@ -570,7 +569,7 @@ struct dcn10_stream_enc_registers {
 	type DP_SEC_GSP11_ENABLE;\
 	type DP_SEC_GSP11_LINE_NUM
 
-#define SE_REG_FIELD_LIST_DCN3_2(type) \
+#define SE_REG_FIELD_LIST_DCN3_1_COMMON(type) \
 	type DIG_FIFO_OUTPUT_PIXEL_MODE;\
 	type DP_PIXEL_PER_CYCLE_PROCESSING_MODE;\
 	type DIG_SYMCLK_FE_ON;\
@@ -599,7 +598,7 @@ struct dcn10_stream_encoder_shift {
 	uint8_t HDMI_ACP_SEND;
 	SE_REG_FIELD_LIST_DCN2_0(uint8_t);
 	SE_REG_FIELD_LIST_DCN3_0(uint8_t);
-	SE_REG_FIELD_LIST_DCN3_2(uint8_t);
+	SE_REG_FIELD_LIST_DCN3_1_COMMON(uint8_t);
 	SE_REG_FIELD_LIST_DCN3_5_COMMON(uint8_t);
 };
 
@@ -608,7 +607,7 @@ struct dcn10_stream_encoder_mask {
 	uint32_t HDMI_ACP_SEND;
 	SE_REG_FIELD_LIST_DCN2_0(uint32_t);
 	SE_REG_FIELD_LIST_DCN3_0(uint32_t);
-	SE_REG_FIELD_LIST_DCN3_2(uint32_t);
+	SE_REG_FIELD_LIST_DCN3_1_COMMON(uint32_t);
 	SE_REG_FIELD_LIST_DCN3_5_COMMON(uint32_t);
 };
 
@@ -667,9 +666,6 @@ void enc1_stream_encoder_send_immediate_sdp_message(
 void enc1_stream_encoder_stop_dp_info_packets(
 	struct stream_encoder *enc);
 
-void enc1_stream_encoder_reset_fifo(
-	struct stream_encoder *enc);
-
 void enc1_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc);
-- 
2.43.0

