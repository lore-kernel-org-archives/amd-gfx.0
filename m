Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD27C432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8DE60527
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD8DE60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FFED6E0D4;
	Wed, 11 Aug 2021 08:33:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649D46E0D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 08:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLBHLpUNai61i/l7Xx91F+fbzs2SQzhD3LYWM1cqynpygmHxxIAnwHhJQiFwSE2wgzpU7M0f2Tbqe/gg7esGfneBdoVO6NNgIEICr+X84LBkCJg9ngwa6JM1FBESy51EeN4V6lsy/mkEF9eXHWCMUut6VUZuRTqO0Mrl6i5jN3ODHVvAeMv6ww4ZssOrSe/HYVp9eoVwzmXO3GMJ8s3o846ZM1TzygLqgH+bWbob4sSKL2+BXOWGIoxEubpvyO0es3QRVtt5PGybGtFtshTvUi0ln+YNEDnHJg4vKnjeIEuKPokuccQP6/24JbrH2Bg3GiCkJF4Tsnf1hxmN+9KF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+wqbwRMGKscoWsu3pi+/a7GXd1in0CLi2O84ZkNGfg=;
 b=dMDLSeJgsDUx12i8bpn292Lf+305E/C93r4cd7WLvM1nVDbqAK3gbtUwBhgszJS7SPVTw17pwD/HDYymC2U2PzGPxnypauaR+wXUolEo1U14rrAhRncbiRwixnPRMkciR2yInW6Pt/AL3f8dBlu8b534ajH4AEtEBrLMZZJP588UGXHzfDktk1OnQFv8LccVKUcQm8yM+0RJm9FUg+s8g7SW/aqleJvGrB4iAH9NPbjxM85t4vagqIChniwpNlPEQZJ1kA0EzceIE/tOb7EXrDigRS7GyHBUq/MGLmX9JfDSXuSpFateUFbB8JLhb8YyNHban4H1VXxmkZg3YguYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+wqbwRMGKscoWsu3pi+/a7GXd1in0CLi2O84ZkNGfg=;
 b=VqL1bBgn4BFOah/tGJYixs3+6NNOGlCfvqAijHJrA4uUP+H6/UjUfo0fjLp156kng5DnD12jQyR8u2E60OdvNJhlulIZxKwtoqZgWbGSp+J6PI2fzKxtcJ5zWTZRGZcMw5RBAQ3PFDdUzVLjDHajkz3furxBHcJVA6Ax8FpPWH8=
Received: from BN0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:408:e5::12)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 08:33:36 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::6f) by BN0PR02CA0037.outlook.office365.com
 (2603:10b6:408:e5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Wed, 11 Aug 2021 08:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 08:33:35 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 03:33:33 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <frank.min@amd.com>,
 <hawking.zhang@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: change smu msg's attribute to allow working
 under sriov
Date: Wed, 11 Aug 2021 16:33:21 +0800
Message-ID: <20210811083323.1084225-3-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811083323.1084225-1-kevin1.wang@amd.com>
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f5533e6-df19-4ec2-ab8c-08d95ca2b5ff
X-MS-TrafficTypeDiagnostic: CO6PR12MB5473:
X-Microsoft-Antispam-PRVS: <CO6PR12MB547338D9918800334F97088EA2F89@CO6PR12MB5473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLsDvcd2RgkM7xlS6q1rsgcIvyYoV6xwm3I/+rZnb8zzb7KD1Kny6S2N8Lw8Ugz4XCnxkgXCItISN2yar4dLL4d4n5028DOpr0mq1MM4TSZqq87V16iHowuzeunicyA6D/Fj7ASjuduxSur5O0r1Bb7GY/6jXYjDZyajPT92w2UHtjh84C+1pElx/90yxvu/ertTEeOZJRIfEpd2Zs6zmuPtq3orgwd/teXhUpOCMsPh8Ciywjh0Uw4MEAbTezUInGsGQuK7tzTQ5xkXKIkUWqTf6mNjdyQSuG0Am9CfGWb3EmcLIWEJPFZ/v77c4oB4QscdeXa+W8dfSv9Wy4bUt0hsn/4Y8gizvbK5P91bBSRQ17dLVLGsghu5k6aH7k87DHLfW5dIyu89Po6/PVAn7i9HnmnsqX8JbT5zo/rGlHY4DYyx6KBkgYXvs8g87/Y/VrT2yDglSGElKSYAoe+jTZ3IOgDlNxY/Zy44lArcoCKzwIOGXpIETlRzDZm7Z6T1XblYcIV+ZiYG30tqPfIS/FHWqufqpme5V9aJx9qG87z4mItNw9LPGGtZsrbo1cOfZR7b2QfwrKHgES6Lxg3THGmG36e57fN9vNje6VRxRu97+z5J5AI7T15OtsglPoMuyqJZ+aGRdOcLJAZG6olQNLZkzI6V4p+vOB31/XAKoarMbEUCYa7j+AIgEW1NcnADwXPxZv+A4cuI0E5lMNKuQ+YqGlpmy7f+jkf+olSdYTqSnhuW96tSprqULfOuWH+y+tosjLZxJCmfi1ycLD8w1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(36756003)(336012)(4326008)(426003)(47076005)(186003)(26005)(16526019)(7696005)(478600001)(8936002)(81166007)(34020700004)(82310400003)(8676002)(2906002)(54906003)(2616005)(86362001)(36860700001)(6666004)(1076003)(5660300002)(70206006)(6916009)(316002)(82740400003)(70586007)(356005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 08:33:35.7085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5533e6-df19-4ec2-ab8c-08d95ca2b5ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
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

the following message is allowed in sriov mode:
1. GetEnabledSmuFeaturesLow
2. GetEnabledSmuFeaturesHigh

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 97cc6fb9b22b..fd04391364ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -90,8 +90,8 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(GetDriverIfVersion,		     PPSMC_MSG_GetDriverIfVersion,		1),
 	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures,		0),
 	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures,		0),
-	MSG_MAP(GetEnabledSmuFeaturesLow,	     PPSMC_MSG_GetEnabledSmuFeaturesLow,	0),
-	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh,	0),
+	MSG_MAP(GetEnabledSmuFeaturesLow,	     PPSMC_MSG_GetEnabledSmuFeaturesLow,	1),
+	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
 	MSG_MAP(SetDriverDramAddrHigh,		     PPSMC_MSG_SetDriverDramAddrHigh,		1),
 	MSG_MAP(SetDriverDramAddrLow,		     PPSMC_MSG_SetDriverDramAddrLow,		1),
 	MSG_MAP(SetToolsDramAddrHigh,		     PPSMC_MSG_SetToolsDramAddrHigh,		0),
-- 
2.25.1

