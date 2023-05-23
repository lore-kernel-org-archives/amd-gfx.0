Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73308C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 05:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66E310E3D2;
	Tue, 23 May 2023 05:03:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8683510E3D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 05:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9JbXjqwqoluhoVUtfcXSMs59nqvMAhCM0SACo1JwA+48SXyfcR7ZxttnYrkaAlYC/O42lqKaUzCcZSfjCu8hfTgh8LNrfN/9EqGTzr2Dc3ZF6EIQ0ZjawUqP80S/EprB5VgQ0Ut78P4F3oR6d82CsjwTDNPDQRCTBr6uMsUAphgOLVD5o0oEUgVDYw9S7aCfZNUo6eUOlmTxFebXi5aoxfCUCgqe829EAnNBJCgWd2FqsWZ3LiM2mkmRyGiGNRv48oz4eZ1bwDX71szaLnwPIFC9nu9V4ZLj9YG0JpG2TEdBxnLZL7ECecGUXzH/DXHn45iOBwedqIhEen4DJTrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awT0Mu24KHb/oriufjz3C9O/FHT4841fpxYv6Ep1O1E=;
 b=S/vfocacuG98xC6eMJXcx690E9YegGUeBQh4QabrC1JTnCn7b5PCFAOUfz9PO3kGEoD47AvYv6i/Y9jySEUeW+/ee7u3xpLZ5hGxGBl3zUtqH8ARgfDnXKwyw62fa6wyB7A+tdNwsleeGdpFU8R/Uu0AwRL3FhSp+hSGuAwntuJf7BNAhFmLspZXSL/S+PqkMVO3Q16leRSX0HdfrgG/MQRyCXE167OTqiVojfsa2vO+v47nUtNrI9wLtK7BPGq6CN4ajCf6pqy7oAQBagiFBFyFZGxJir5BDkcAhke8FVidjpIJdMSglU107LHi/icv1zceYKGcXFlqjKXMSr69bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awT0Mu24KHb/oriufjz3C9O/FHT4841fpxYv6Ep1O1E=;
 b=3+90HXN6+2ofu7HaSLxKmlOq68zP1P77CMjpblqWQe2sBCb+QVpiqqguz2g3uftNnArS9u9+g8jU+ZrEdyn1BmE23m/NP0m8NBnz8xzotnt7by2THk2OiYxVrx3Rxiy5JI4pTk3OrbcX9DVVzvASLcTVq97+4Q8Sme/A/IKs59w=
Received: from MW2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:907:1::33)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 05:03:15 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::c4) by MW2PR16CA0056.outlook.office365.com
 (2603:10b6:907:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 05:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 05:03:14 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 00:03:12 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: reverse mclk and fclk clocks levels for renoir
Date: Tue, 23 May 2023 13:02:30 +0800
Message-ID: <20230523050230.2564839-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e9f6bd-1744-41c8-1751-08db5b4b03d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jg6DTeaCJanhu1hKMB+eBiOUgypqqd6ZnweMGsIJq1ndU3HFAxfB0ATySoLu3E58nvOJkJIrH99yjJNIp+EtCoLJPV29hIo/e+MNODcvh84yQ9hSwA7QtNUau59f4vvs+0vCfc+El6esj5gFdf19zDFn7zLVRpoWvvW3T49qsulg0tGxSctKTh+seHcW2O+KhrCUBlkT8ZYbgeEumxaN/g2qUaGSbXFhX/Gx42195EnPbWaidwWlXtaGZGY/jSfUn3l7SYdNYLrL3nhvdOn3x2yebmoBH0Lb9fzmSp8A2shaui2cB5VFr3hjnRl83qriRC20dW2z49D0tR6CZhI4wMqi5wvn6NGJcBOIjHFf9fT8kG0X82ZHUqE9NOh7Fngmi3EHyTLLCmK81PCA9bURNPHUghmP8rwDz2RS7i9nL7ZrkWzhxrGWeNRdx/N9n6Go77sCx+3bMLGqkdO5Y82LqY6iwCqB8130o6SkExf6cam29fO+r+RmmCYYXJU5OZlc5Q9lXxuZGPtLC8Y9tEGcOllf2wGkaq3SSsvaJF9TshyPibHLZqKqB1iVE9fsYGYTVbrU4eyzMb/+A11zy+sCtjtVKKiiB9UzfQSaTO7DleppCU05JHWLDYFStw9fhyHTrbkDciEOkk944KmXX2lI3Be4I62wRQ17/JxDHOxhBFA+4OG15DU9BH8s+9wGslEGDLX+O7bnuNIRmjR+Pw1+AMR9wdilIMG4iBSF4WHrD7GNGmVD2lokQ3OWwaEJMBhQhaOUA7Tq83+HkSmlm5S9Hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(40460700003)(8676002)(8936002)(83380400001)(36860700001)(47076005)(2906002)(16526019)(36756003)(186003)(2616005)(336012)(356005)(426003)(82740400003)(81166007)(86362001)(82310400005)(40480700001)(1076003)(26005)(54906003)(316002)(6666004)(478600001)(6916009)(4326008)(70206006)(7696005)(70586007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 05:03:14.6688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e9f6bd-1744-41c8-1751-08db5b4b03d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch reverses the DPM clocks levels output of pp_dpm_mclk
and pp_dpm_fclk for renoir.

On dGPUs and older APUs we expose the levels from lowest clocks
to highest clocks. But for some APUs, the clocks levels are
given the reversed orders by PMFW. Like the memory DPM clocks
that are exposed by pp_dpm_mclk.

It's not intuitive that they are reversed on these APUs. All tools
and software that talks to the driver then has to know different ways
to interpret the data depending on the asic.

So we need to reverse them to expose the clocks levels from the
driver consistently.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 5cdc07165480..8a8ba25c9ad7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -494,7 +494,7 @@ static int renoir_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 static int renoir_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	SmuMetrics_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
@@ -594,7 +594,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	case SMU_VCLK:
 	case SMU_DCLK:
 		for (i = 0; i < count; i++) {
-			ret = renoir_get_dpm_clk_limited(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, idx, &value);
 			if (ret)
 				return ret;
 			if (!value)
-- 
2.34.1

