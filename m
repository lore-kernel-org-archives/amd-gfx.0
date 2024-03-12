Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CEEC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766551129AE;
	Tue, 12 Mar 2024 09:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3tuyM1zO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECFC1129AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4gSJKnEInHpfBZFHK+z0HOVqF/g1fYSFXIAgQiUQ6KgxFg1noCdZPfANZtfj5OBgIdZrm7MjKimnI3XXcOZXCKh5uKGBHpjjQVL/RDggHKwEXpEgMJjXgeTLfqiMvC2rXju4s0mHbAFloCVrFSXoW47ew1WTfYCP4AxZuiFHUtXJFDzjBbKN//rGTkKePT7Yc8xZhDJMGyQty1y01tUhUZzh9EKKJzdzbtNmEuBNNO7OOR7l9R0HTiXMGD3wHCqzu+vuC037Ul4j5kt03ws+9SHQ3ld2TiBDEcdKmOAqvfaXKZldvWgQcHl00ksBkAMjCjHO250lR7t5TZWBtdSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R+hjmG/64ns3v3PzC/nT5tyKxw/bFXg92D96oC2ftc=;
 b=Ym6N04YE/uQB/pUty9YSIcUXqiTEltPZGATw4701iRQ50CWHHOWQssYtKz7kDDq0r0cK62Uftl9r97KuhnlEUI0BBoUJhTLGewU+93ttHU5OegiBVfLqw8qlSpqcATAVfSmvagGuE75vRfwMXlepCj3Cs9jnlar7DajDpWQMufK1l1M54iZ4/e3cxD9ZmWKmKhsH41eMxqnUJ8UmBMoqcvBeFFEBgE3PjFDvnQPYxkHQuGSbYA3XS9+Fku71Meo3jwixw/pk25QJVeCyKCEmGcCkwP/OOozD8aLKomcegTy0THY6/xHYBjIpmYBgWVbeUHjbpWJOpyHfNi9v8vPFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3R+hjmG/64ns3v3PzC/nT5tyKxw/bFXg92D96oC2ftc=;
 b=3tuyM1zOmzkDDeFeT5GVmd9D+7NPm0ca/ae25lm+kmAdhfAVqidRI8JUCTpgGsVqG6eW+VgKDYhbuNhcZtpAIz/CmaWWiv+5bQhpkdDdn+ip4CQD2NDzyeu1ZB+Gaps+VVU8fZXa0Lwk/hp1nXoidGakFAnoGHsPrQh0LTY4OLc=
Received: from BY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:1e0::11)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:21:37 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::d2) by BY5PR03CA0001.outlook.office365.com
 (2603:10b6:a03:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33 via Frontend
 Transport; Tue, 12 Mar 2024 09:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:21:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 02:21:35 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:21:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 07/43] drm/amd/display: Move define to the proper header
Date: Tue, 12 Mar 2024 17:20:00 +0800
Message-ID: <20240312092036.3283319-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8f6f4a-081f-4594-62ab-08dc4275d16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lh/RLvz0FliVmeysNqt4IYXVCYFaKfbPn4sVbnwgeyNz7x+2xYPb7INjoutFGaPKiMxfc+nkU2DkprXRoe0NjPifsFZgqTL8VziCs13MCkB8OhigQpZVkXUeMSoiiZ5VqN/mfSnr0dmd4E1GhhcElGqGLKKYQkH2T4OzIF2cVpROBXWBfpxbxPTNZpBmUwKoDrSOcCChU3rjm2kE4yECrtrGjjI3jozUCE7w7SdJGVL+HdK28y7nWEIZ2AXiAxMSLJYyAWXQCncJtWO+OrQqLJho24JrQKV751zRnaH12EjRebiG1pDYEFt9lyU3pbAY3tCC2nC8jNsEG2fBqgmTY5BrETTDr6+TPODjf6CvZB5WrWqStNgSbjqotSqBMPxsHI/+wYB8nVP2GBnh74ZPgdTSKixb803HFNt4qdMydBhQ1r23vqUCKKI/ZQRZbtWeZQCSM8zsZa+pf7RjJzpKOPjMTVK352/6Sq552S81AKWxOkUoOvF13os1iqcfuPA4incmaP5i2mM3RnL3ad9KB/UhT5KPgn1ZIbmaXoBSfX8VRvsx5SvgkctTMAY4jwB8z22GF+d0kvsJwUL0ZH19MfLE11MPegYYVRdPYszaDc3NBmhwBc6BEjJSRhxvXKCT/+bKgSKfpIQv//kRD1ZZeljS+tL+nHBZWD6r4i91xc5OHRLePSkdXRbsy6OHGdUpLzjtpcv+8c1i2IG4Saiir1W0DA643mozVO4tv/qvV63s/Z5YFfVALSVnUJ2SXY5r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:21:37.0575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8f6f4a-081f-4594-62ab-08dc4275d16d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
DCN3_16_MIN_COMPBUF_SIZE_KB is defined in the dcn316_resource.c file.
This header fit better in the dcn31_fpu.h together with similar defines.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h             | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index 8f9c8faed260..d2ae43a82ba5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -30,6 +30,7 @@
 #define DCN3_15_DEFAULT_DET_SIZE 192
 #define DCN3_15_MIN_COMPBUF_SIZE_KB 128
 #define DCN3_16_DEFAULT_DET_SIZE 192
+#define DCN3_16_MIN_COMPBUF_SIZE_KB 128
 
 void dcn31_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
 				  int pipe_cnt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index b9753d4606f8..83a71f1b933d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -125,7 +125,6 @@
 #include "link_enc_cfg.h"
 
 #define DCN3_16_MAX_DET_SIZE 384
-#define DCN3_16_MIN_COMPBUF_SIZE_KB 128
 #define DCN3_16_CRB_SEGMENT_SIZE_KB 64
 
 enum dcn31_clk_src_array_id {
-- 
2.37.3

