Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3408ECDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 12:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBD910E4D1;
	Thu, 19 Oct 2023 12:51:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E35110E4D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 12:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUbk7F6IhlV8x21rxmxsKl7nfy7833120ZJc5vCOFbvK5X2nyPzqv8Wrlk7m/Ay4cxgaZRiDiVRqhPnSNzM3g93w2QJ+LCsHirqJ5g+PHI9qoKvMdUsld1HAKFdnwSqihhRbLU2w7x2+ojiwrGSbdZT2sdzTFVPfYv1JYbUwUqDCrZjzNbScazCN85iYZOVH4ua4yEA20ECVTltXHErN0kYYbxIx8tziMlZdlHBPFnZjT6FMjkzLFf9byY+Aq35ocQcUkk9uD1RcxcJvGbl0fen5x/nBiM6qUR3jyMgmqWSFh4BJs3gxHrtqNitAR9WApzcD8ifRelv/Rau4w4uPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZtGE1VFfnRP2FtQWz4ZCLeZJXZrkyBeI9h+/1pQs/E=;
 b=firzSM3fn68ZaefIW2ZmEQidZDPIgE9dblskYqrsluByDUszgiZ/5UQiE2v2s++rxBVgDOHWpQ8Azezb8jP2JC7BNWzLlfrETl9JMYMIro70YL3uppumty0Ye0wyU/vsOWZG4hOL0tLCEXnmBj1HyN3VBJmCXHkxeUo4o/7mKnBNMi3udthXtS6Lhds7Kmaya8mz4gp4McfvVXS7v+SylJr+/mTEpFqvXFk7HZGrfFWMvHLaJo4wku81jBJx0Hi348EVGyM0RGM/b95HbFnu7vpUUN9HQxAUDXx193fUYu+sw5xq5iH3ZKBGE9r+8vKIrHwUrLRnNQaRM5C4Q22i5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZtGE1VFfnRP2FtQWz4ZCLeZJXZrkyBeI9h+/1pQs/E=;
 b=BhEToPScg/8T4cckoDc772uPTU06+rIlsUrsLhHdxs0S6NdsadeUApvTyp5UERSMuDuglRuuIT38X/3zd63+WIxizaQoSSMGSMe3KQo0jqNaRjTvS/sWpu7BkJAHuszAl7FPrqjwFfpMqVhjvkJZwgmxZ4kJ9V2kY3nUHNV3mwQ=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 12:51:36 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::2d) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 12:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Thu, 19 Oct 2023 12:51:36 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 07:51:34 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: refine ras error kernel log print
Date: Thu, 19 Oct 2023 20:51:15 +0800
Message-ID: <20231019125115.1110473-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e09e29-aac7-4825-2833-08dbd0a2214f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egiFFGjYA8KAh3iDoRkb6e2GmFuRbUghTRdsPRGd5XyVeiolkoHPPWSIvHXNr9qRvNmFwVg0VMie2kA5VqrxZLoZIf4sBdVIaeXozCkSdDpl7tBuU11XIu6Ux73DiOhb59UxyB51bBaWM+tf8M1Y7OXEE9pYR4UCgzopvj/TpyR02GL1BHmBLDAf9XKveGHcWPxrBvwd0cu4/jt0lR/m5I0U5V6O07EO4PkcE5JD+IFxp+edEe/w6+ty4243cNGSASVVTpAzxh35KxwmoC0mZk7oqFPcbtPKFta+r+dMjIgANpiEsp3/uIWAtBo0RQ3QhuBsJJ00gAj7fX31wFQU3YirhWZwJ1lZtD3XWQmRM8U+SEdbndlSPTEfS9fqkh12EcFxoIWz7a/C76gO26KOSIQF6WbCjBlAEKGRIlqseEraNQQYDZ66+FMLkVCV+sVi4b+Qwmc7ttskhxow2FxN5EovxMyfrjNGlzIu36J1Ju2o97as4ZZPBRdDFRDaz9sC6Kpb/XC2CsLMo+ZOE10AwLD1OlkGPxtf8z18Yd4yoYETEHEDNFebzYBC3QfEo8ztOtVGhsFh0SWxNH0XyCQrvaCDm6G6I2asbmqW9D+EnO1me3x1dP6UdpZq7x6eZBdf4uS/JxxUbvT1pEsYGVWwDyZjIvPJpGThGfIPuy3H/NFVu3SmI/rgRzs92ecZcp/q4CTTiqkG1AucDaDV746t79RsVsU3TKKwtBC2j11CXt+EBMqv6noHaq37SftXNpjaSZRmXf4nD8frHSTrQiRejg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(36756003)(40460700003)(16526019)(54906003)(2616005)(6916009)(86362001)(81166007)(26005)(82740400003)(356005)(426003)(316002)(336012)(83380400001)(1076003)(8936002)(6666004)(7696005)(478600001)(5660300002)(70586007)(2906002)(47076005)(8676002)(70206006)(41300700001)(36860700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:51:36.3609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e09e29-aac7-4825-2833-08dbd0a2214f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

refine ras error kernel log to avoid user-ridden ambiguity.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5b831ba0ebb3..cebc19d810e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1034,10 +1034,11 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 	struct ras_err_info *err_info;
 
 	if (is_ue)
-		dev_info(adev->dev, "%ld uncorrectable hardware errors detected in %s block\n",
+		dev_info(adev->dev, "%ld uncorrectable hardware errors detected in total in %s block\n",
 			 ras_mgr->err_data.ue_count, blk_name);
 	else
-		dev_info(adev->dev, "%ld correctable hardware errors detected in %s block\n",
+		dev_info(adev->dev, "%ld correctable hardware errors detected in total in %s block, "
+			 "no user action is needed.\n",
 			 ras_mgr->err_data.ce_count, blk_name);
 
 	for_each_ras_error(err_node, err_data) {
@@ -1045,14 +1046,15 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 		mcm_info = &err_info->mcm_info;
 		if (is_ue && err_info->ue_count) {
 			dev_info(adev->dev, "socket: %d, die: %d "
-				 "%lld uncorrectable hardware errors detected in %s block\n",
+				 "new %lld uncorrectable hardware errors detected in %s block\n",
 				 mcm_info->socket_id,
 				 mcm_info->die_id,
 				 err_info->ue_count,
 				 blk_name);
 		} else if (!is_ue && err_info->ce_count) {
 			dev_info(adev->dev, "socket: %d, die: %d "
-				 "%lld correctable hardware errors detected in %s block\n",
+				 "new %lld correctable hardware errors detected in %s block, "
+				 "no user action is needed.\n",
 				 mcm_info->socket_id,
 				 mcm_info->die_id,
 				 err_info->ce_count,
-- 
2.34.1

