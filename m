Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC36BCD54AC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 10:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17D510E385;
	Tue, 19 Sep 2023 10:09:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F6610E36D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 10:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8dPLj1vM7z0KwX8m1QWGBspasnMsCtU7kT1Uu+5WYSaQ7awzlh/EaWwFj4g5S30EGgtt4zLIrJEI5WZVq/K9fgejNNF60hkxmmjZYNbGdBEJV28fOLMFnDTXY0jXCB/1nOy/EL18+ilvO5F1If2Ud+MQEhKBq4PgpLeDchyILRNIRpwUVRYFBUOynt2UeSE8Px5ZimjwymDLsu3jTWrHgcEdoiI0Cyo+l9mygptpdUsCCq7u2PdC1D8U9O/A8HZpBFDcBA8hZtYgTfVeAo5mSBYUYEiZyJ2KcDzKKiuDbr0E7rvJ4qMCfaTfQJesWXtelAQRdM/UXrR3FWNUGGg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgHzXGsA+AUBep5eOSAw19g5LRXH+tYUnKomScM0j94=;
 b=InSvrzHnO4fjWI3I82rFV50A/oRUhwfbqsSxL/bA4UGp29Z7UyUxrNP6HL1YldxjwwV9tb5/fxg3ztamdTj25zORcMW5ctOGcXDGcSUKK6bJyu6quDO4YvqhYgJTSV8baKECTzWntRgvAjTEj7TwBy9/DnSe/Fk+g/aHQM7+mW+Aj2HH3V9XUoaKS88fn9NIC7iXCZ9aP4mtJmIebt+oXy6je41gjeqrC3QQV5hGlHT3yOSzqEuKaVfP1TJGAVw7c9InY1FOUsh+D3J7ItMXdYKu0HiqPDFkQrDKPb5lEY47k2mAyJ6qW0RCVFo2HEN2/ThCFS9a0DQYovYCTLU7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgHzXGsA+AUBep5eOSAw19g5LRXH+tYUnKomScM0j94=;
 b=cXXVZFKE0/9bQFpjN+/K2FhFLpqTAgSOu8fXcJTM2xgy0oaE2qZUVMBXFZLlalfaJfcncrV78GANgPcUHbIeXAnPki0h1uN96HNp8THlqt0NmoE8cGNyrYI0n1iRnX4hb564RjDQtC8OO9+WKJBhSoSRcPpJAiPdA8x8ArYSACc=
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 10:09:52 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::cd) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 10:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 10:09:51 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 05:09:47 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <candice.li@amd.com>, <kevinyang.wang@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix value of some UMC parameters for UMC v12
Date: Tue, 19 Sep 2023 18:09:35 +0800
Message-ID: <20230919100936.8810-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230919100936.8810-1-tao.zhou1@amd.com>
References: <20230919100936.8810-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee6298f-95cc-4644-19fa-08dbb8f8906c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHC/EeXTX/UImaGCbOtvpsrWPQJlXPoSYhvJBa8UDfaz2TdqviOr5XDuLuLGTf3Znlc/BppsJ+DjRKqEmCltb5Trtc800JEDpd+4QDFvlEGN3dJTsc3+qg1uGm7WDOpMMYdNrxDhbz7qhjh9OCGBH2A4gMcj9kIpkG5xsPu0lrWvdki7D04hh2Osh5JKrq91u1h1oUDG8Uq4q3/z8PqpgrN9WIfpYZe9thqwwQpfVfSVvWeA8BD90+bDdFKFVJ+tMJ3LGnDLAod53JNpYSG4lghJnBjELcpJLD74McIjjzLWrL2zXW0Vawsk7lI9czuPRVqWTnoGImAJBsqWcwjTWmAXJ/JHNP6syNo/h/S2pq/9a0YmnH2afwULZk3nM3e8ynxsszadhQ/Pj4HC9mwhhjPO8BSBZplR+0C8aNaJQj4XB0xo00KAcnVMijHkAktoPTmRk3VTni5Ss3PfQfwhM3YWOcPJ5fKTRIe7YRw+tdm52ZJYJ2kSWsmfxT0FcqaJd6pd5gBiwA176Aadd0vT4odmYgzq0I0OxtHMtfuYSmTzw9nisI1AGdqEWm56Rez9hDFSAfACwh3xRbzF5U3qSac4GJzBnK60I5zuBeR74/ZyjxLp5BKImXbx6BspbGb/QTU0NdZ3lxUFG4bMkk8Jhsdc/agPf1C6UbnPssr4J18mHk6NaSm+10D4O8+xf+Q0bWy4x4ND1Z81lEl+CXtY+S37QRH36VGFTtSEMYhtAL6glYY6cWO7gFp6cOlw90baQpJr5TF5q3fwLoLZxoqJ3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(7696005)(6666004)(478600001)(47076005)(83380400001)(26005)(16526019)(2616005)(1076003)(426003)(336012)(2906002)(70206006)(70586007)(316002)(6636002)(110136005)(4326008)(5660300002)(8936002)(41300700001)(8676002)(40460700003)(36860700001)(36756003)(86362001)(40480700001)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 10:09:51.5742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee6298f-95cc-4644-19fa-08dbb8f8906c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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

Prepare for bad page retirement.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index a5510412acd0..bae4a0d18190 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1497,12 +1497,14 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_second[0][0];
 		break;
 	case IP_VERSION(12, 0, 0):
-		adev->umc.max_ras_err_cnt_per_query = UMC_V12_0_TOTAL_CHANNEL_NUM(adev);
+		adev->umc.max_ras_err_cnt_per_query =
+			UMC_V12_0_TOTAL_CHANNEL_NUM(adev) * UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		adev->umc.channel_inst_num = UMC_V12_0_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.node_inst_num /= UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V12_0_PER_CHANNEL_OFFSET;
 		adev->umc.active_mask = adev->aid_mask;
+		adev->umc.retire_unit = UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		adev->umc.channel_idx_tbl = &umc_v12_0_channel_idx_tbl[0][0][0];
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 			adev->umc.ras = &umc_v12_0_ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index e3619d67ae3b..4885b9fff272 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -53,6 +53,8 @@
 
 /* one piece of normalized address is mapped to 8 pieces of physical address */
 #define UMC_V12_0_NA_MAP_PA_NUM        8
+/* R13 bit shift should be considered, double the number */
+#define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
 /* bank bits in MCA error address */
 #define UMC_V12_0_MCA_B0_BIT 6
 #define UMC_V12_0_MCA_B1_BIT 7
-- 
2.35.1

