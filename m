Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7269BC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 03:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8FA10F913;
	Thu, 16 Jun 2022 03:22:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF7610F913
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 03:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBN29U+uKjJp1XoXVaE0nLwTPa9fmHHYq1xFk6ESPyyx90BDpH31mHjz9/WGUV2gdOH8LMQKADjxQWrEn8sTFk069CFRdYlccYPUuZoBIBQYCtuKKrUFPAAcDE0NV1mZTtmhu36AarjCGD9eOXBlK+uIoXshQZPgNvfZmTdd9kJ6n1EufKY1nQRA0lOZVi7ovdIvBJbJqVRbpAz3aAlckrCuI7cbFPMeU1kfuZl/O/u5wD5sVFKDrwGzw/It0reIDVRoTVANR5jgSUuQ6bZ7vBevijX97f8p7FsiaU40YmvcFq29KdpzOAwLSJdgX4HzLkk35mezKcA6fUXXJMiseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBZ0oQp+uFCNHnJOLe5EAiQ2G7kESMlLn0ifkUmcIXc=;
 b=Teyq73asBeSWMcSlvuUD7JD12lW6yiEtBD9T7lrTA5kqZcosZVSiYDYkCdnvadEav4ZB4cLdrdxrJnaHZet2t2RkoUjbA3f/1ErE/UMWLr+mchzIhUslykbpE6Nd/0pdq/+PwQTQXWz6DCPc442+G6aPd/FGo+via6MW/p6DM4vblbRao/UzQrt1KStvazgpnN5oLA3nW5npBqb5Rp7iCF6zfhg+lNIlK0cA4D00r78rIn4lyeeYR4FNNBYVczJf/fmGa0GVVoXPY/Ojqrbx+gkfnrG4n9K+tGrgJHbdl1nwmsAYoA25K8KSliJujW8S6dgZ7u2lpVrf0j3k0QKeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBZ0oQp+uFCNHnJOLe5EAiQ2G7kESMlLn0ifkUmcIXc=;
 b=UAsudnsPCTJy0Bnxooti4BRQxU0Caj74pIB2ZMfPu5mxLeJYkytAQ1n0mkZm5VS/Mrc3mxwmyyDUnNUwd0iOJDhXZPaMknM6Ssot+O/k7g2V9kY3sxtbRCrUVE+EDNNRVuLhypPsEXi63a5jJUzn20MTEZL5YeWXhMNMG5cPsPE=
Received: from MW4PR04CA0135.namprd04.prod.outlook.com (2603:10b6:303:84::20)
 by DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 03:22:35 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::df) by MW4PR04CA0135.outlook.office365.com
 (2603:10b6:303:84::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 03:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 03:22:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 22:22:33 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 15 Jun 2022 22:22:31 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>, <Evan.Quan@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu/pm: adjust EccInfo_t struct
Date: Thu, 16 Jun 2022 11:22:22 +0800
Message-ID: <20220616032222.9207-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6d4e757-29ed-4ccf-bc45-08da4f477509
X-MS-TrafficTypeDiagnostic: DM6PR12MB3241:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32418A6FA5F799BCF3BED5B79AAC9@DM6PR12MB3241.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNbJ9Da2OeEYFH9w23ZYerTZxbMi7RGB3t5xKPogIsC8f/zBknOHZzVTgp6psqdczHmrm58qieU8jbmShXKX92kX0wdG+R6ZDi1n7Rb+Q8AAagmjRDf+U3SjCDx5L2gROKy3UQNE3LZRn4tdMo0S5f6QCtkx25sso85nO8xojdenM+e/rSdA2T5i4a7rmPVGucKA8PHBZY9m4evvtLwvFRYT0tHU7OEkZvsLuugASTqtKgu1Uxh1XISocqBXEQ6SMqXTvveHOfHg0+3nj78N2EYZuxyEYLQjhT9vch8g956uBnMfkqrsTO9IAl8TQoe8ZxEuBcUjreHqBrHxRDio9hbOus9HbGAVIZwGPhFiSGZV9b7yogJoHD+yrVKJSEsWdhkBPln32vJjhCLcAjUC0fa8Cqx1Vtas7qIzTRnJi3HNrH56EHRYWn+ozpePWmmE7OvxJtRHwo1D1Sy/ZOwe62/QtFxtrMPDZdyErVrMlpDfeHinvPOfGSSRs+tTqPW5RpwxU3wgq/gAgmgh+DVYquWuSQHENPxAWSDtdjayunH0wLhwNyDAicSqWnfKkFNpBMw4INHclBsrMmQBKULJvoTDdKT7lM4tJaEMvMQ31BpqzrVSocwmjOsRVKfDRnIacSvEOzzhyloP5nKtulN2TQGhRsA0SgcJDEEy4vQCweEIc0cmauO+BNK0jj4M66Ts21eLjIZJnW3oOwY1qMoqVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(26005)(356005)(5660300002)(70586007)(70206006)(7696005)(4326008)(8676002)(8936002)(2616005)(36756003)(40460700003)(81166007)(86362001)(82310400005)(2906002)(47076005)(426003)(336012)(36860700001)(83380400001)(186003)(110136005)(6636002)(316002)(1076003)(508600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 03:22:34.9316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d4e757-29ed-4ccf-bc45-08da4f477509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3241
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The EccInfo_t struct in driver_if.h is as below in official release
verion 68.55.0
 typedef struct {
   uint64_t mca_umc_status;
   uint64_t mca_umc_addr;

   uint16_t ce_count_lo_chip;
   uint16_t ce_count_hi_chip;

   uint32_t eccPadding;

   uint64_t mca_ceumc_addr;
 } EccInfo_t;
It's different from the debug version druing develop print correctable
error address, so adjust EccInfo_t struct.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
index 6f92038470ec..7a6075daa7b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
@@ -521,12 +521,13 @@ typedef struct {
 typedef struct {
 	uint64_t mca_umc_status;
 	uint64_t mca_umc_addr;
-	uint64_t mca_ceumc_addr;
 
 	uint16_t ce_count_lo_chip;
 	uint16_t ce_count_hi_chip;
 
 	uint32_t eccPadding;
+
+	uint64_t mca_ceumc_addr;
 } EccInfo_V2_t;
 
 typedef struct {
-- 
2.17.1

