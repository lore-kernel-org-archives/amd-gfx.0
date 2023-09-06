Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F80EB8FB7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 10:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3FD10E5EC;
	Wed,  6 Sep 2023 10:11:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6F510E5E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 10:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDdtm0WE1X0hSpiFJdqAkOkbl1iJeqbYiu2YHfa6UDq9BaAhAI7gA2lG5ySqOmVLDNZKnE1F+fsQLQKiQawSiC7XdLcrWc3VD6iR4wLIA97HTPnyLavl2JvTSiCceUa+oRMn3ou3aiUDYzW9b+4UMtQsN/XNz3rd3qWVIRh2PCECeuo1MqFngxR5TYqxHhYyoLTSvFQ/GFx9stAkj5IYPTbELg8DldayDyAX2ogMYx5S+tg9b8Y5hBX6fcMks4RcIXQfdieG6zR1Hj8i6H6AtD/dDOOyPJpK+dNHgAsy5F20A4kMMnvz7w6B0VIgnFhqS4i35l3yx9cNo1W1PlxxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxnBxdPbkqbxqbJ/u2xq9K7pigKEwjhMOfPfpsnApOA=;
 b=hxFSCf2+QX0529SRsREcdA7CM4+3Us5Ll2WKUsjiILj0XcW4ksLr7wqceiJITuno0+fV+5XBrejap64r9HbUPKc1VavkLdOG1avXF+SlYt2pTw8BWC3CLJHEq2Giews0RZOqow7dxwYikfa33F1qGQQB1sElujg9jdAWDn9+6y8i/pZSlSWI0YnZyxEVzz4NGAQy85K2oAr/C6SHlxazGmFj6Yimntdd779FsMvHJAH+rV5NdrpMBsJYJ/8nuGKPcuMxz2aCctwgDO5GypxjZKWUMxiLfHfmG3Z8fcnEyvu3xJGB08xL0DZunYvlxwUJDfUQAvrYKX/odeJY5H29/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxnBxdPbkqbxqbJ/u2xq9K7pigKEwjhMOfPfpsnApOA=;
 b=r4rG/dED6HPAHSvzz+8Ir7hMSIiWNz+eqAufpvbA968zVIdT4KF0rFnMxV27zXi17UJRLNOXtt7lqXEvp9l9a3vd7mquDHWYH8NoadeGqBogAyX/ppxsfA61IGu5/CVKS8QctywkIIOkDb4FjTDjlNcmi8mIYV7wkj0/3IbvBcA=
Received: from MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::11)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 10:10:57 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::9e) by MW4P223CA0006.outlook.office365.com
 (2603:10b6:303:80::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 10:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 10:10:57 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 05:10:55 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: print more address info of UMC bad page
Date: Wed, 6 Sep 2023 18:10:16 +0800
Message-ID: <20230906101016.22726-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230906101016.22726-1-tao.zhou1@amd.com>
References: <20230906101016.22726-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CO6PR12MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee8dbb9-4426-4211-ded3-08dbaec19035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rptM4Gjd6RbJ1EofpccF7MZQ9poW+ZQqkh6nSUdBHijZrc4Hiy6YeTGJGry9lW/XCRvhZI7hy481UkNh1d2/EbYG23tixK6ZBw8KX4txRGe4xBTDQ5BFznk24jvwcw1XDFR7VqZjEH4Aay/oJq/fAy6YPy+S8SLQjdFphsUfP8qEcZ7/Vkeeu2JVF3WkyuGPGBzX2eg1jQRTI04z3TAp/mSHtvFVqOHhbmUwpSeCy5M+R5moEMu1eVp47/2Fh5tVVmVyQaiv1JC4q+PiSHcdIHv6aGsdebzpyf5liQAG5vs73XEnuarWuLY2Fpl0jFr6Cz0gECNyr86p8EdI1QBSsN+BSKHQlP4/Tx0lLZ4Cle43/9L4D2ZnjykZenX7E6tUNmGA43h8DPHOfRtHZlA0AdQpkKkqpkhLDRUQR/M0u0nCSPhVwMbFXs5vKtIMranVOPIQ1nYWh2aGgJ063N4iNyVljr2Kl1IqrKgSM/eOf60hBuaakfG04P13HioNCHRednGRQ1wXxxPN0It1zGBIlDpSt+buhfigV+iEl7OXqYLvgfcDamKD/5+fplOs9oJhMvUxvLOiP0gFeRsY6J8K6k48VIGL3HCTNCR+P/rJEu1hpExJL3qCtUNw/7ZhwvpAAhKyUAKnmH0rg8iwkupMu//Pe3nkS+ByNWJUYiszPneUOZQOZ2ZfKdy99TsxZ7GOHvgoIzksqKC+4hMc2lCB+/rHY8zAt4seuxeVNdMaQhvVF8Me+IFJtUQYPWvOwsBOrlCSmFiQ2GSrWiHg0U7u0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(47076005)(7696005)(6666004)(40480700001)(83380400001)(16526019)(26005)(40460700003)(1076003)(2616005)(426003)(336012)(110136005)(81166007)(6636002)(70206006)(70586007)(5660300002)(316002)(82740400003)(356005)(36756003)(41300700001)(86362001)(8936002)(4326008)(8676002)(2906002)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 10:10:57.3021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee8dbb9-4426-4211-ded3-08dbaec19035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
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

Print out row, column and bank value of UMC error address for UMC v12.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 5f056dd7691e..6fde85367272 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -173,7 +173,7 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 {
 	uint32_t channel_index, i;
 	uint64_t soc_pa, na, retired_page, column;
-	uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row;
+	uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row, row_xor;
 	uint32_t bank0, bank1, bank2, bank3, bank;
 
 	bank_hash0 = (err_addr >> UMC_V12_0_MCA_B0_BIT) & 0x1ULL;
@@ -228,17 +228,23 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	/* clear [C4] in soc physical address */
 	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
 
+	row_xor = row ^ (0x1ULL << 13);
 	/* loop for all possibilities of [C4 C3 C2] */
 	for (column = 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
 		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
 		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
-		dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+		/* include column bit 0 and 1 */
+		col &= 0x3;
+		col |= (column << 2);
+		dev_info(adev->dev, "Error Address(PA):0x%llx Row:0x%x Col:0x%x Bank:0x%x\n",
+			retired_page, row, col, bank);
 		amdgpu_umc_fill_error_record(err_data, err_addr,
 			retired_page, channel_index, umc_inst);
 
 		/* shift R13 bit */
 		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
-		dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+		dev_info(adev->dev, "Error Address(PA):0x%llx Row:0x%x Col:0x%x Bank:0x%x\n",
+			retired_page, row_xor, col, bank);
 		amdgpu_umc_fill_error_record(err_data, err_addr,
 			retired_page, channel_index, umc_inst);
 	}
-- 
2.35.1

