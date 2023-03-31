Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D98C761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617F210F33B;
	Fri, 31 Mar 2023 22:44:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E0110F339
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krn3ztdvOqXBt/NcMraAIVZtbf5mGVMuSe0DP35qlRtfoaORjLqn/wokE2z74JAcvJ2E1cmX5g20RapERH+jymVmcyFFS+VWWai3Lgd0JsBXDCDfqYsTMqlP0EK73Myl1JZY9z7Y6RSfuXQL7Z/FZNyBNzysodPOZtOCtRZeGEr8pc5jwEsY7w5qew7chnwscIMLneWcCwjf0szfY0xfcIay15/w4Wp3tL0t4diUcmB91WlCORs8Ilode8hsevhWZFWASyMsII36KO+A206flHfgm3ncPzPDPZ2O3LyppOl5CCPSIh8C3e5CtCPEgf7iK+o1j4DSnaWFeuXSuq6FAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq6pyg/fuv1TM1EHK1zjrrUgB65tJ30w2cbL2PB/vyM=;
 b=NLESDcyMD/ZV5F+XOPmCiYgJHiZIb0Nvs4LrFBPlphvxkoVdR8a1plgVIIhK0A0bWhLxraOOXyZAQqUVOc8gLjV0DdddVAU9H3PpOPcLYR6o1kbTFEpAdPCxiXczCl/6+ltCK5basJ7qS87Yj3Om7MtAakgs7HlCXBA4Unb8j2zkegmg2reuwQAb3zicTD5QO+psYW2Ul4Vpe2/dCTJOkAY2PSvMyiqsPuRQhZAkAvpW3yzqAirNNiOp2qHoehfoE81wRR2DAz5vIdGo0f0V12S+hRK1mnotMTZA3fXl7mJMwq10DA747Cx8DuLTjPFCRT0+yczvPa7MfZtGbvmGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq6pyg/fuv1TM1EHK1zjrrUgB65tJ30w2cbL2PB/vyM=;
 b=KeiZHHWzAC0hRW/VppjRSse6pUIzw9aIoKbmjXBS9JE7FikD+Al8lrAmab49hHhqElX85bPirPyfG5kslpuprKIe6m/sMEDqxYzohsCm2S6hcQ3JXK52KGk47hzdWHCnnQJM8f49S6T+vrV17PXiGY7LxZ9g+VQblBVmG6D3Zbw=
Received: from MW4PR04CA0380.namprd04.prod.outlook.com (2603:10b6:303:81::25)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Fri, 31 Mar 2023 22:44:44 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::22) by MW4PR04CA0380.outlook.office365.com
 (2603:10b6:303:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amdgpu: Add reset_ras_error_count for sdma v4_4_2
Date: Fri, 31 Mar 2023 18:44:19 -0400
Message-ID: <20230331224425.8755-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224425.8755-1-alexander.deucher@amd.com>
References: <20230331224425.8755-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 350f6f9b-4a45-451a-81c0-08db323985d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8RKZ99d89RkeAVkrts5v4hXs5Hu4XHgbwyyGmPhEwB4Y6wyJ3jtk9rZnBxFRnPLW+6COFCZu9NmDEV6nRqwMxDo+E7xzkm+SezscSlQEwLDoOXeqTvTTctWfKWLT0cW4hMyety5vJ1wxJoBkXOhWS6q6Z7GnV+byGznz4sScqjLEyEDRtU+3hQaOBN7Olk29r4chBOewNfRjsx2byPrsrcCF2uN+NUKR3ypGsD+CdZP0RMK/tMCjQT23Gv8N2WiQXldGHCtpUrefVZ/IqUeRSFZ0Nq2LHguIpl5KjxPbyd4SY7CGHyz4qzMOTd8Ck6XKEIPp0ppKtU//9orychBCZIDCS7/EGqe56iILLGuEMSAQwC+fyDq2dAl6IVvTPS3B+mPKzBHQua6nYQ8ZaI9hLA/onm9OMxRYQ8ESRQQRKjrfTD0xASi7mL/enMWVxNkW4lR5vIzfjTnmwRx6LJNUjoc94oTi3vy5ZokdzJeP3qqB97eY77bOL+gdKD6bU0BdhqVSzzCgIr92qHYqQ+BndXrT39ZcpmqrhqP6AyvbTHy6TbAX3SmoLkiuY5V0ALXRyrGPy87uOgr0Wq/hpBPex3aJ2xN0jYud+Xlv7fdaP2YtFFvlxkjHe2b6O4CKP7pLK5GFqwr3qnrD48Ia7Go/qIgcUm8wHsmBRxGl7sJZ34SaReq2tpk2LdMNhcC6drgpugj9dRvN5caLTCBeex4pfV6TBIhIsgHxsWVzasy3c8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(8676002)(47076005)(40460700003)(2616005)(36756003)(6666004)(356005)(82310400005)(186003)(336012)(40480700001)(16526019)(4326008)(83380400001)(26005)(70206006)(81166007)(36860700001)(70586007)(426003)(5660300002)(7696005)(478600001)(8936002)(1076003)(82740400003)(316002)(6916009)(2906002)(54906003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:44.1290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 350f6f9b-4a45-451a-81c0-08db323985d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add reset_ras_error_count callback for sdma
v4_4_2. It will be used to reset sdma ras error
count.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 925ca6218a5e..f0333822df78 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2135,3 +2135,26 @@ static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev,
 		dev_warn(adev->dev, "SDMA RAS is not supported\n");
 	}
 }
+
+static void sdma_v4_4_2_inst_reset_ras_error_count(struct amdgpu_device *adev,
+						   uint32_t sdma_inst)
+{
+	amdgpu_ras_inst_reset_ras_error_count(adev,
+					sdma_v4_2_2_ue_reg_list,
+					ARRAY_SIZE(sdma_v4_2_2_ue_reg_list),
+					sdma_inst);
+}
+
+static void sdma_v4_4_2_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	uint32_t inst_mask;
+	int i = 0;
+
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for_each_inst(i, inst_mask)
+			sdma_v4_4_2_inst_reset_ras_error_count(adev, i);
+	} else {
+		dev_warn(adev->dev, "SDMA RAS is not supported\n");
+	}
+}
-- 
2.39.2

