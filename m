Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224EBCDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 09:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF80E10E46C;
	Thu, 12 Oct 2023 09:01:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4D210E46F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 09:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXaHj/tZIfQmgkpjQwZ/rfkM2ihZ1+9V8YY/mZeQJFYS3l8YwHE+TTVde47p304w/MpAX68lDnyeiuwaNsdA09h40tt3OiqsKafs3o2+b62+ZbjdpBF66c939/lY6WSOpd8+41Ei/yaAo0dpUVQDee/H6y7VopqZFJhIwfTXlwQUHoZg+WORlIE3G0xyJnbAdSlk2LlMpPGK/H91Gq7c4T0hb2cBoRCO82EH1fHpBQLFtsmsSUGyvFaoNR7iarxp6PMAcng6J7jWXvbI28igI+i3QRbwNCfiUABTEC9VqpAONV+Bqk7fZ9TJgHZk6+gdKhqu96umkXf6mTbQeOs4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl+iJcJvKxq7XRBvJDW94jqpT1HEIs1/no36mSLezls=;
 b=NYRRvhrzEJARDLqGwnuFKxSp+8BN5N+x+nTLW1MByrGEm/IAh2atz7roBVh3DOJq14SCVg6qHhMwG/oeZFPEaTcvr4uxrh3kN6MXfwFyJFR2CRbmbWB7KaD9HcEDFqgptlLuhD4I8qJnNRP3F7OuKar2B93kdMJMjOuL4jjWnsARJ9caL4AHejXT1WC+W0PlxaEDRAY1k4A4b6fwBxqjfYZ2Wi0v7kOKC4Ivr97C5Gl8QjBScECAoUGcui7/zOPxCkEx5RBvNZVjWgUC/NmwjMWexAOWvVWvTwzMpe8pGg4lLG55DQpc9R/tOO1yZU6kEGbN1VU8iZAhQgRJ0euJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl+iJcJvKxq7XRBvJDW94jqpT1HEIs1/no36mSLezls=;
 b=3iwExaI9aBGWe1ugVx0T68BTER1MPKMaFcp3u+o7Hg7MT1Acb1fCh2ak3ouaMT3Y44vc2TVSz9q5U1IOUC8GkM8DUf+CmcIrReHVjfqsNNQfegV1eixTiwYCvhlSPBxIOe/EQ9WmMV+xRODh8bWK3/UpkDfYJGKvz8YcxMcGBMA=
Received: from DM5PR07CA0052.namprd07.prod.outlook.com (2603:10b6:4:ad::17) by
 PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 09:01:13 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::c1) by DM5PR07CA0052.outlook.office365.com
 (2603:10b6:4:ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Thu, 12 Oct 2023 09:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 09:01:13 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 04:01:10 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <stanley.yang@amd.com>,
 <hawking.zhang@amd.com>, <candice.li@amd.com>, <yipeng.chai@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions
Date: Thu, 12 Oct 2023 17:00:33 +0800
Message-ID: <20231012090034.31055-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231012090034.31055-1-tao.zhou1@amd.com>
References: <20231012090034.31055-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b568d9-f071-479b-5003-08dbcb01c942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wn9i6E/+BJTmMwjqoPFiuQVNHFX81naOdKWwYGmiN2yrizrDwX8xtKUfv6FniIreHa9uC4nKKd2jSMZ0LWExfyZiAmVZugvVKErnzHx00rwE7lgLbPXKQ6ofngGN5chow0fDOVBVnBI/K5+ySaynwzoDC5htKuqM7dw3n0Ga9urzXIX5sAwhUyFRhezothVgBC57Ny9fUK2MFjq0ycZ3g3IwBVVdw+f7Sn4HiLM0EfkbHejiWQVC4mE1qIN3/0WbL//QcPycb8waVOIZs49vL1eMM6uhSBbqe6LY3c3QYZQIIP3V/PmdPM8DANiKIZ+D/F7o+A78Yc+cdfkvpPV5OcibmZeocv2p823XkL0xyHoPZAC5aa71RR+P11pv20lS9S7kSG3z/WI4BloajrTEa2jSeCWYoMd/5SA7/5R6m2YgdCfiwfq4SOJj7l1Tq8LZQDalRLMGfYgkK8sNcRUe96Aemzmz5vr6DPXfWI70Of01fVBSNO3xsWlk1lNcRLO2autTHVXA8fCQVM58bZG1CfsixKwKzVHh1OjFHKswUMlCzBUE2sfDQB6AcxBEu2TbRoFKAO8u5OL8a/TOc5crzrrNczeo5Fy4VAy2XCdXyC8/n0FpPSe+FApCKjWJz5hXgu8lusPI3uGasn6m5m9bd21xNThIMgd/MzNK0dwq6wBvMwcsRZQ85Ix1UQWBVaBTO6458HB0mqNU6LkpEk/0bZhmcmvlj1IRDlnyqfCERe/EeebksyxRESNYwEolmDNGmc1RdNcxnOMUXCQhIAG7IQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(26005)(16526019)(336012)(426003)(2616005)(81166007)(82740400003)(1076003)(356005)(41300700001)(5660300002)(8936002)(8676002)(4326008)(86362001)(2906002)(316002)(6636002)(36756003)(70206006)(70586007)(110136005)(6666004)(7696005)(478600001)(47076005)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:01:13.3935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b568d9-f071-479b-5003-08dbcb01c942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW is responsible for RAS error reset in some conditions, driver can
skip the operation.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 91ed4fd96ee1..6dddb0423411 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1105,11 +1105,18 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
 	if (!block_obj || !block_obj->hw_ops)
 		return 0;
 
-	if (!amdgpu_ras_is_supported(adev, block))
+	/* skip ras error reset in gpu reset */
+	if (amdgpu_in_reset(adev) &&
+	    mca_funcs && mca_funcs->mca_set_debug_mode)
+		return 0;
+
+	if (!amdgpu_ras_is_supported(adev, block) ||
+	    !amdgpu_ras_get_mca_debug_mode(adev))
 		return 0;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
@@ -1122,6 +1129,7 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
 	if (!block_obj || !block_obj->hw_ops) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
@@ -1129,7 +1137,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		return 0;
 	}
 
-	if (!amdgpu_ras_is_supported(adev, block))
+	/* skip ras error reset in gpu reset */
+	if (amdgpu_in_reset(adev) &&
+	    mca_funcs && mca_funcs->mca_set_debug_mode)
+		return 0;
+
+	if (!amdgpu_ras_is_supported(adev, block) ||
+	    !amdgpu_ras_get_mca_debug_mode(adev))
 		return 0;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
-- 
2.35.1

