Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AE1C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 03:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A935310E43F;
	Mon, 10 Oct 2022 03:12:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A98ED10E435
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 03:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1qQeiyra68jIwy7PWNABpvtJpE/JRBy5Uni5JC9lyUBf+IWwe5LQ59WDVbKtc4hLOXTDbmKL5VgMfSxrSwvchEtBrsGc4xupWqlEs5S9uV87uHTf1wv0opTIKMQuYEe0fVvxWDzQDCcLkBKbPg9PEe3Hb8+poMFPDnTqe41pWF2BXuccpY7UG0A5q01ieWYzjIdsw5W6znmzWTIXFXwGKND2GxnUXV37ZFD3/JtxyGtKDp+DY6q5r/2itZbZWU1pY8TQoz8fJJ5kM+f76T8w1o9jqHthvS9zX4KUYVxqdpNom575z0udsIMTiPuTA1P84RcwhB1Oiug8LY/tml1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVn47HQA612ND0DDDEZCHaPEiOSFXOX63mR0nAIJ0QQ=;
 b=nwPxXVxOKxAIkr0SU+fM1LB9TzeLg52u+8UUWaianqX4wYT3d2OIXceJwn8SLf3jfXzoXeQXIpW2DCVmaQ6Yz+RQ5vnmeu8xq1jSrh52B3gAsopCC6eFEcLdO174+GkmXuvwweOh/Cve8rLPx4P1WthEK2wikzTUaS0nNom7rwk86iYx7S23clTXzHrhxELgibkivZDTlcdy2z/AcrBLDMiVctJz2kNM7oqj148s/sK1Zxc6n54HHk8l9gJtr8AZCJdy7i+LI6XrjzyUl3ADAic/mbH6OA/RidMbp4mp95byRr3iNfCBT5E1g9oPqMIYq9oSKzFp1KWFWdNIPwrcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVn47HQA612ND0DDDEZCHaPEiOSFXOX63mR0nAIJ0QQ=;
 b=WQV4sF+EQORBYie37NH7lCcPvJWmYp1LZ3x7dbATyFYGcloLIWVcRlBRBFWt0IJ7hQzUSSZR3R2YpaCcRh5KZB+WOKLHEjNG1gAea+UB4KjenhaoBavUMzalrXR6ndBbWgaXB1efkMK5BYOsW68fL7ILKiPGMljyxfDyAXsMPrM=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 03:12:43 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::a9) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.16 via Frontend
 Transport; Mon, 10 Oct 2022 03:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 03:12:42 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 9 Oct
 2022 22:12:39 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: define convert_error_address for umc v8.7
Date: Mon, 10 Oct 2022 11:12:12 +0800
Message-ID: <20221010031213.19258-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221010031213.19258-1-tao.zhou1@amd.com>
References: <20221010031213.19258-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: ad18256c-642e-445e-fd51-08daaa6d4c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDZAq8fz1L29tA96pccY8X1FB9QUKyrhggyij9+PJJ2Nq+oJJkbttGUZvuTC14FrFWmi3Dbmkrl/ZprFc3cuk8kJ38o70Cq6rrUp9NSL4RGMFY3afB6cl3+GigNLboYI7IzJ93ygHUb1+zsklw17xFSdPC0ugGHEjNlvJExEphr1K61jAJJnG75J8xucaaux14+ELrbQi0/RZo7zdOUCzBRWDTygfGb/aI4lWl1lBqHTfOeZ2DSHpzQHrgt+cglmj4NyhRUTM0PJHxZ7ugkgM0RE1BHe1+V7Ar/XzT6+SdkH71M+kBZUu5G/jYCYVqlDB+7Y75IwdlQLJWI/T8pSnyvXQt52V6qgzhhSr9tYKqj6I6WN4InYOgfzKOlPHtO9hAwNTWbK3tP0qZanIc5ZAXEu2ErwWGoieCzd/NpgB1/qM8ZRQid9zbw4GAACMcKaj1EXZXsjU8FNGIo4JDFQdTeK/eYpdzk8EtZXlZGJ5Hy1OZHCT24iuUdRmakLoTwDVpKJ8wsrh69hGFn8Ae+2he/0nLUkwqtrch0AF17hT+nlq1ODs4rnhVWaLVQqjUbubpjNQMWZKQ15nyl5DcK9LEL28s4kYf3C4TsVpBvMItogC1k4Njvs9ROYqgT3wsGGNOrSUypF4a57ZeCQmelu6G9up+oPzxspKwQu3NXuoroyxMloc/nDaBKiEJ1ZfNtFZ3hxknld4nTzdVC+U7G9T7pGbvVqutWNJf3ggr7pwDd4cJBQWH6JkiufR377gdQFAOfVpSlr2qMQ5hFVW5uVR/V4uMalXW/OfhTAdJ0I37gnkNq4RpNCY7IerkcVhTUb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(16526019)(1076003)(336012)(47076005)(426003)(186003)(356005)(81166007)(83380400001)(2616005)(82740400003)(36860700001)(5660300002)(41300700001)(2906002)(82310400005)(8936002)(40480700001)(4326008)(478600001)(8676002)(6666004)(70586007)(26005)(316002)(7696005)(40460700003)(70206006)(6636002)(110136005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 03:12:42.8704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad18256c-642e-445e-fd51-08daaa6d4c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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

So the code can be simplified.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 47 ++++++++++++++-------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index e2623685cb44..b717fdaa46e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -108,20 +108,35 @@ static void umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
+static void umc_v8_7_convert_error_address(struct amdgpu_device *adev,
+					struct ras_err_data *err_data, uint64_t err_addr,
+					uint32_t ch_inst, uint32_t umc_inst)
+{
+	uint64_t retired_page;
+	uint32_t channel_index;
+
+	channel_index =
+		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+
+	/* translate umc channel address to soc pa, 3 parts are included */
+	retired_page = ADDR_OF_4KB_BLOCK(err_addr) |
+			ADDR_OF_256B_BLOCK(channel_index) |
+			OFFSET_IN_256B_BLOCK(err_addr);
+
+	amdgpu_umc_fill_error_record(err_data, err_addr,
+				retired_page, channel_index, umc_inst);
+}
+
 static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
 					uint32_t ch_inst,
 					uint32_t umc_inst)
 {
-	uint64_t mc_umc_status, err_addr, retired_page;
-	uint32_t channel_index;
+	uint64_t mc_umc_status, err_addr;
 	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
-	channel_index =
-		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-
 	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 
 	if (mc_umc_status == 0)
@@ -137,13 +152,8 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 		err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
-		/* translate umc channel address to soc pa, 3 parts are included */
-		retired_page = ADDR_OF_4KB_BLOCK(err_addr) |
-				ADDR_OF_256B_BLOCK(channel_index) |
-				OFFSET_IN_256B_BLOCK(err_addr);
-
-		amdgpu_umc_fill_error_record(err_data, err_addr,
-					retired_page, channel_index, umc_inst);
+		umc_v8_7_convert_error_address(adev, err_data, err_addr,
+						ch_inst, umc_inst);
 	}
 }
 
@@ -320,14 +330,12 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 					 uint32_t umc_inst)
 {
 	uint32_t lsb, mc_umc_status_addr;
-	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
-	uint32_t channel_index = adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+	uint64_t mc_umc_status, err_addr, mc_umc_addrt0;
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0);
 	mc_umc_addrt0 =
 		SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_ADDRT0);
-
 	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
 
 	if (mc_umc_status == 0)
@@ -349,13 +357,8 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 		err_addr &= ~((0x1ULL << lsb) - 1);
 
-		/* translate umc channel address to soc pa, 3 parts are included */
-		retired_page = ADDR_OF_4KB_BLOCK(err_addr) |
-				ADDR_OF_256B_BLOCK(channel_index) |
-				OFFSET_IN_256B_BLOCK(err_addr);
-
-		amdgpu_umc_fill_error_record(err_data, err_addr,
-					retired_page, channel_index, umc_inst);
+		umc_v8_7_convert_error_address(adev, err_data, err_addr,
+								ch_inst, umc_inst);
 	}
 
 	/* clear umc status */
-- 
2.35.1

