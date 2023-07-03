Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8257EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jul 2023 08:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1B910E1E3;
	Mon,  3 Jul 2023 08:56:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486EE10E1E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jul 2023 08:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KChnYvX64veysRGxOiEyLcIKzGfNF7dwnsIpARmPgHOkW3vbBMuvx/IENIWpcIMLivQol5T8ut274nUFDdhL7xIXUPsK8m/Hpnf3YL07mZjSG9RfhSKd4rWm0kDX3v8KZnpeQsnkVjmkpNHqZQysmbS48Isgs/lMzTimMuSn8I6pi9qf3+TGabgNWXsiR9unAL+mGPqIEiu0LcZFESNHILxAumkeWzNyIBhBOgNB78/nwdC/iUUo5IKsv0bBe20e/J/z+XDHnbIf7i8u6ps2vlGbycaIKU/ArM64raO+YW0ExSooYNE+Jb/GuUfXO7wUp1r47sbdVl7EOU9l+5Fqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rynRKSni7o6UEH+PQC5BV1JSZN4hv8ASq1R8QxBPIA=;
 b=hrFJgkmluRsQrTDXcMc5J5Zos3RUOHdVXIpV0gTRlmvZ+s+pLLI3sUV86yNx1R3Z2n7KBTQb/2KS3JyJyvFvs+T+AFEyEjm8SdWRoI9Pr45GM2uNw6Xt5FukHbAk3Hmuy+s8pv5jOAnEwSCkjSvNB4vW5kySfL5maeK3Ka+SG9Dg7QDM1nXg2qH0/TxcbCO/Sxus+UctduHB3vXd08sg3oJtnXLmxOTmQJSrtqCaazbSzotaBEPVMzwhA6gr789Xb1E4q81Vn/MQAYf4R6aQ1GCZxybPfv4HpbKvQaLWQG34pWnAjvb0Zo/B71GQ348yZVV6pySbkbHwOn9ajoXHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rynRKSni7o6UEH+PQC5BV1JSZN4hv8ASq1R8QxBPIA=;
 b=tkIkud5z2N5uyDw7ohTS9ZeV6hVRONNhiLSKcp2DlzxupNdC/E7YY1dcIC8Q6RO3SD0haTlU23WoCkBz+5RFuJ0wCShiPur81r4QeInneFV8OBApinaMc+qckPkQ3m8S9SmM3G0eHPbxG0OtB9c7RGKoOdV2X/IfhqyQBdspEhQ=
Received: from DM6PR07CA0045.namprd07.prod.outlook.com (2603:10b6:5:74::22) by
 CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:56:09 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::e5) by DM6PR07CA0045.outlook.office365.com
 (2603:10b6:5:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Mon, 3 Jul 2023 08:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Mon, 3 Jul 2023 08:56:09 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 3 Jul 2023 03:56:07 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Thomas Chai <YiPeng.Chai@amd.com>, Candice Li
 <Candice.Li@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Issue ras enable_feature for gfx ip only
Date: Mon, 3 Jul 2023 16:55:31 +0800
Message-ID: <20230703085531.11563-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703085531.11563-1-Hawking.Zhang@amd.com>
References: <20230703085531.11563-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cd01f3-1ee0-4382-1358-08db7ba3587a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfPrCaDht71rZVzp/RKayc8Sv1SDIMtBtli7t+01fL795zfkHNl1nJWqdPLxz0uBXyz15bygnU5B1t1Tzm+oXyg3rVR5p1bC6VbD3kCWsHb0B4U8DYoicRL2J2Lp7G1IhYqH6TKY5vP0l6x+aw7Gvb8jZWpKXmTvIQKS9y+t7aoba7GgMYGY/w16zFGM5oGg1Tf6WCMjVmqosI3jWkZ7YrXjMHKnKqMfIeu9+nco3YX98xxaQmQIgo2Sxnn5uzEhBgyGKSBpzykCJFvc5w6YYGZsp7+l2sVuh51gfi/IgC9NF+Vf2LiUtvqPQ32tBwyWGG6ooSgyPpowv30yziqteLqCSTRajnDwTThOYSU2sRrM42EicgI+GwHwevbxWTHj7X6lAnk7bK6OGsAYs8OrHryc0caEGxK7YBeU1w4M2JjKq0zVZmiD95KMBJC0jq2ggdr7R13hyPchDN7ul03o5nv84dg5Ds2xWUXxCVfBVpDVjATNu1nFTUFNvXCR5XBhz/kNkArKFyr8mkc6+n1PcEUZmJTtimteMe4mAOb+RJZEeHcrVdWQ1SUP95oycOLdq8yi4z4SDqtPkqqiSnDE/C0F7AG3zBe9t7ahXevqkyb1faqTqARhdlbkjnZgimOl+JAfvwPVtBQDI15LzasXB2/7X7M1Lc0bG72WtE1nAm5f2nDeWKtLtcYjeEJB3GB+qY82Jsj5F3PKMXbcA9y31VWl6KIF8nBDlSrd4ojK9tTFaBAJ608rZ1SqxVqlHHnNgpzvyZmRzLYugEeiZiE3mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(336012)(40460700003)(41300700001)(7696005)(82310400005)(6666004)(16526019)(82740400003)(2616005)(81166007)(356005)(83380400001)(1076003)(26005)(186003)(426003)(47076005)(36860700001)(40480700001)(110136005)(86362001)(478600001)(316002)(2906002)(36756003)(4326008)(70586007)(70206006)(6636002)(8936002)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 08:56:09.6557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cd01f3-1ee0-4382-1358-08db7ba3587a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For non-GFX IP blocks, set up ras obj if ras feature
is allowed. For GFX IP blocks, force issue ras
enable_feature command to firmware and only set up ras
obj if ras feature is allowed

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 30 +++++++++----------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8524365761b6..2e9154bbec64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -761,16 +761,6 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_check_feature_allowed(struct amdgpu_device *adev,
-		struct ras_common_if *head)
-{
-	if (amdgpu_ras_is_feature_allowed(adev, head) ||
-		amdgpu_ras_is_poison_mode_supported(adev))
-		return 1;
-	else
-		return 0;
-}
-
 /* wrapper of psp_ras_enable_features */
 int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 		struct ras_common_if *head, bool enable)
@@ -782,7 +772,16 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	if (!con)
 		return -EINVAL;
 
-	if (head->block == AMDGPU_RAS_BLOCK__GFX) {
+	/* Do not enable ras feature if it is not allowed */
+	if (enable &&
+	    head->block != AMDGPU_RAS_BLOCK__GFX &&
+	    !amdgpu_ras_is_feature_allowed(adev, head))
+		goto out;
+
+	/* Only enable gfx ras feature from host side */
+	if (head->block == AMDGPU_RAS_BLOCK__GFX &&
+	    !amdgpu_sriov_vf(adev) &&
+	    !amdgpu_ras_intr_triggered()) {
 		info = kzalloc(sizeof(union ta_ras_cmd_input), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
@@ -798,16 +797,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 				.error_type = amdgpu_ras_error_to_ta(head->type),
 			};
 		}
-	}
 
-	/* Do not enable if it is not allowed. */
-	if (enable && !amdgpu_ras_check_feature_allowed(adev, head))
-		goto out;
-
-	/* Only enable ras feature operation handle on host side */
-	if (head->block == AMDGPU_RAS_BLOCK__GFX &&
-		!amdgpu_sriov_vf(adev) &&
-		!amdgpu_ras_intr_triggered()) {
 		ret = psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
 			dev_err(adev->dev, "ras %s %s failed poison:%d ret:%d\n",
-- 
2.17.1

