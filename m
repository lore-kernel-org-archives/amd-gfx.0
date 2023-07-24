Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478A5C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 02:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F7510E0BF;
	Mon, 24 Jul 2023 02:43:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859C610E0BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 02:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVtnU9hVDJNaQEoVctzBcDFX9Oodke14f5gyd3xjE202ShNNxIwA0A7u5nyUKF/ZiAxK6r0GgDVH+u93NZYyVt2mmsH4hU8TPTrTd4g1uTyU4pVK/rQaeHYS7ne6lZLePMzrXkeaR/wknVFHEW6g7VfCPZA4WjthGYASLS/YGIjozJy43i4FLWZo0GWRmFvZKc68BdxHCL5LXLQsm8BOY7MH8/VuLdrH7pwYC+4DwDwEE/4DIv2FHco7PCCicvnV4w+UeCRT/G0hZ9mcVO0/fHCp9eaYj6gBOegNi6dXnwIP2mlM1PZwYXfwSChskrfPchBzvyQ+DytfsVaBUw0A0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0nMiDBT1+TdjxRS9T+UiOrvxl1E4IxboORsJWJFQKU=;
 b=CfLjo6EWCO3diQ5iL5DbYlPGx24xmUKVmDXTN4wkxGyhf+4BJhjnMjNFWmsUWeihCf1O7hUwY7bHEBRapakBb3cYcb8mGvn8hPNZcAFDS36SocR2RiskNMqYlZy7+9Z3uJKsHYkAun4P6ZD5TYlim3du38tk4JfgWjOXDTOcAowqMCkEOEj3F9NvnH4j04UKAUav3LiAEsqCFZXg98sD81uAZupTs6FLNvx4TFo0pjG3Evj4ybNJPKaxEJUMvMdRg0u6qUZ2hHNaGELSOyQB6xiUjZ27GgEyahNM2GGbA94fK87vUKPSgdHkS8mD/XKnf+dtMEOcedUjoEgMAktj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0nMiDBT1+TdjxRS9T+UiOrvxl1E4IxboORsJWJFQKU=;
 b=fbuJiFpT/5MWtZtVdDnqjaHZsBHfiil9SMuqICrGqlRLEi2RRpQ6Fj/6GkZXxQIXDhjF8GlYG7ZbTQbB5jPwhDgWw3W+rN9BO3T+5tmN4gPnPj7+Ry7zq4pK9J/7O9Nv3z4vch+PMqo/rhabZjgYgKry0kCLunMLSPHbNqorxv0=
Received: from BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 02:43:00 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::69) by BN0PR03CA0047.outlook.office365.com
 (2603:10b6:408:e7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Mon, 24 Jul 2023 02:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 24 Jul 2023 02:43:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 21:42:53 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: disable the SMU13 OD feature support temporarily
Date: Mon, 24 Jul 2023 10:41:59 +0800
Message-ID: <20230724024159.501981-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d0b6eb-4292-450a-a770-08db8befb215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTttVbWBbrPZmyxKSFYriB2uD3b+quQGquW9+rrN+weuk8XNZnXh95W4meIDUmnPqfQQt2yBP2MDySADzfoQ4TiZ9x8ZBD1V5SY8xWaJne5ooXtX6UaRznw4bvrsFmDzg8PtISIxz27Ypa9Ht8ncw7fdHeUGnxRadruszEHAA9PnXMyJKw34NEpvP0fkm0jIkDxisoy2887lF7XLByaFa/gcf3K9hW/3oVX54/44oK1AZ2GZeTnrJTi3Y+4F3IVP3qJemx4qIZvHHXAM8RK5sCAgK8+3b2wRcQOwx2tG3bqalcJKMOtWi25MLCATOMN2eb8PrVtxFV89VnabHkW7OKDsvo2m+7Vbpu5NoGkKca36rpCQ0FC+blSl900zxJ1nykpeWp9Q023KsG9RfTcfbCvusFTBV+kEtPrUHDin5xwTF5UlOhDvZyXFiAknnJDqDHzVuo1iI8p+wV63PisPiJttG6KyOHyh1HaitAlAJ76Vv1upe2LBHH13fPp1In0PjAT1hxwqiZjWGWj+ksmsLj9N9LZ+pmr5dE4byjGUrenS+nARg9MQgXf3igCaNpJlmbGfv2EcgY28vG6ma98NZAKXasq0PC9Gk1fDTWzMP+NRyLRuTjdvB5jZkzvLH3DGk9WThhNPmmasmAptvqPfX5PV7Lsp3T5EwU6lcV0tawg29ZAan8cxJlh8RfBKCDlgl7nG1QXPdaoxdNyz0EVA7OwVB0szdbYa5kQDHgvqEbq6xDce2yE9YTWkcK5Bq9uDFAqQVwIhxW7WXKNccNUvoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(81166007)(40480700001)(36756003)(86362001)(82740400003)(40460700003)(356005)(54906003)(2906002)(478600001)(336012)(186003)(26005)(1076003)(7696005)(5660300002)(44832011)(8676002)(8936002)(316002)(41300700001)(70586007)(70206006)(6916009)(4326008)(16526019)(47076005)(2616005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 02:43:00.3796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d0b6eb-4292-450a-a770-08db8befb215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The existing OD interface cannot support the growing demand for more
OD features. We are in the transition to a new OD mechanism. So,
disable the SMU13 OD feature support temporarily. And this should be
reverted when the new OD mechanism online.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 9 +++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 60d2684478a0..a3e510981dc5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -348,9 +348,18 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
 		smu_baco->maco_support = true;
 
+	/*
+	 * We are in the transition to a new OD mechanism.
+	 * Disable the OD feature support for SMU13 temporarily.
+	 * TODO: get this reverted when new OD mechanism online
+	 */
+#if 0
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
 	    !overdrive_upperlimits->FeatureCtrlMask)
 		smu->od_enabled = false;
+#else
+		smu->od_enabled = false;
+#endif
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index ebb961f60316..44a3e2bf426b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -338,9 +338,13 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	if (smu_baco->platform_support && (BoardTable->HsrEnabled || BoardTable->VddqOffEnabled))
 		smu_baco->maco_support = true;
 
+#if 0
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
 	    !overdrive_upperlimits->FeatureCtrlMask)
 		smu->od_enabled = false;
+#else
+		smu->od_enabled = false;
+#endif
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
-- 
2.34.1

