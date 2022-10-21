Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F1EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E72E10E61E;
	Fri, 21 Oct 2022 07:36:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3249510E614
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 07:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwJutWGGwxn7B3dRRhT0sftABFTNCHtfnOvCoZBbA2p/Up/fe9KOPNg+VjhUYyp4t/UMfcvgerGNnch0zR7pARcjd8x2t7xxaPppYzFm4Axwqlh7ACgWekudwp605Lzrd+VEDac2afFz96uQh0Lzn3XG5gqT53U9OPJzGBNWay3Ba3oRgEXi8qNAXi5Onuwu+SOIRHQh7HVda4Tb7/Wk6SKX0asuOgavUps6bJtALh5gpK8oibfpW4/8FsRC5237nEVhsaAlpTZ4DJG7ONMuD85W204arpMIX43sfsz1qT6WAxte+P2S0J82ki6/0LGZJJ292oALUQCRGEqQVarQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz6v/q4K4wHqs2Xw0NJ7st6Bxvxr4Wlq2lSTA7oZvy8=;
 b=AQNMUojvnb8YyPxnhLgS7cvKmy17ZJdx0Zc1K7PMJ8VAQDU8cPpFlhe85lILwuBQ5Sz7p/B8ST/CZ74buEahAWE7ozWLM8+CZYMXrDZcpnW6SJGjsmAGZwHQvbN8/BlzH87OWK5w5gsZ7Fx2f3T35JaUoNfuMghIO8dcN+3Tx4eLvvjEzPTdLu6TWSNqoA7SXQhkjRQa5+Pkc67UAtVY5CV0Mw0cuaca+jxBszlPWv9NNsHU04t7ayfBA3amHoV9W1clLIeM1Ip7ulPm0CD4CiIKbQZ+uUS6OTkjjDLAM+s3B60OI3osziERRFedis+07EOge8M5K/g9Hinvh9kjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz6v/q4K4wHqs2Xw0NJ7st6Bxvxr4Wlq2lSTA7oZvy8=;
 b=H6YVKGP5wYAs1dbMeNXXr9s2nduSjK0B+Y9S7UieI4/O+ZKsYY6KHLDqgLBuztRy9wi9QJ0rUk4ybf8eukvkRLxQa+/XR7XhQIak5fxLqyJindtZuzmxVCmX+08ifJ5zdZGZU0fVR0tBkNoy1f9Cj/8ycl1KEw1AOK9N87GS+tk=
Received: from BN9PR03CA0704.namprd03.prod.outlook.com (2603:10b6:408:ef::19)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 21 Oct
 2022 07:36:18 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::21) by BN9PR03CA0704.outlook.office365.com
 (2603:10b6:408:ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Fri, 21 Oct 2022 07:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 07:36:18 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 02:36:16 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: use page retirement API in MCA notifier
Date: Fri, 21 Oct 2022 15:36:03 +0800
Message-ID: <20221021073605.20352-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021073605.20352-1-tao.zhou1@amd.com>
References: <20221021073605.20352-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8e2471-7bdf-4ef1-08d9-08dab336f130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZ/oYaFbus09BAzyQ3psPzo1p7Dg4GGyDq5gzSXLLCqfJ47uWG1RDqVi2dByT33eLHcmqKTdKbsGURhNAI9Fr857wEVpkOB4ooxSMKMjWLta2hKuZNzpvugOXLumzX7Q1vHuaF4MlRKCP88uq8Iejst6z8VW0kz8H8r/ptlJRzEyjlqMiHWfcnvsHS1C1w781Ad8ztmRxocWL2vIzMGh2pmCODBVc/uINKpDLKSAP+869C47yO0IEOegu4wIF4KbpzYLqb3rvEur7qakDHZFBLs1tZAQD73qZSLT5JHRf75qtJF8aJzNyS5AN7rUDOYvO0xdeJ53aDhBpjUuB3Aa5xXv1r8cYiNTuDlvRJVeIJsC8gIl+CYHIaD7aEHykXuDkab/nAQL4IjEyUzs7lY+PwulaC63OzAL1cOestVIIH5oFpUiV/uWMHS8JpRg+BEOmMmVYvru1OsvgSQ0aDxv3a/0C6EM5K5E5m8wxCl5A9jpx7xADlSekrLo4NxhrUZZyRPU627NvpipnTdQHkMnLzl27I9NVgNRg3G+D++Rr+YShBl1I7WfR4KBuYsJaGqywIjnAbZQVeA3eEN9w4h2sJn2q48yMNyDy5m1mZgvqnsF0xc5PN6OSrz8MMpIwEdfJXc2uaAfVd0M2WvptuThw4GOZozJbahYlzM9AOan+2jff9Rf+kTYhIp9dlnV0Ac9e8UXi93qomiVwel/Yoh9FGmZss1UsM9mYMPDCy065LOdmX7hxnqg6GgxOrPsQvSHpFklcTisk7EtCvF897P9I5VqHRO8SHwEBhOlw989cLaq9+pB6dCeWZ85kzYoyHHl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(82740400003)(36756003)(70586007)(5660300002)(40460700003)(81166007)(356005)(426003)(8936002)(2906002)(41300700001)(4326008)(8676002)(70206006)(110136005)(316002)(40480700001)(36860700001)(6636002)(16526019)(336012)(86362001)(82310400005)(186003)(7696005)(47076005)(26005)(2616005)(1076003)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:36:18.1940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8e2471-7bdf-4ef1-08d9-08dab336f130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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

Make the code more readable.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 36 +++----------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 21a47f2bb87b..28463b47ce33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -36,7 +36,6 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
-#include "umc_v6_7.h"
 
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
@@ -2849,7 +2848,6 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	struct amdgpu_device *adev = NULL;
 	uint32_t gpu_id = 0;
 	uint32_t umc_inst = 0, ch_inst = 0;
-	struct ras_err_data err_data = {0, 0, 0, NULL};
 
 	/*
 	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
@@ -2888,38 +2886,10 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	dev_info(adev->dev, "Uncorrectable error detected in UMC inst: %d, chan_idx: %d",
 			     umc_inst, ch_inst);
 
-	err_data.err_addr =
-		kcalloc(adev->umc.max_ras_err_cnt_per_query,
-			sizeof(struct eeprom_table_record), GFP_KERNEL);
-	if (!err_data.err_addr) {
-		dev_warn(adev->dev,
-			"Failed to alloc memory for umc error record in mca notifier!\n");
-		return NOTIFY_DONE;
-	}
-
-	/*
-	 * Translate UMC channel address to Physical address
-	 */
-	switch (adev->ip_versions[UMC_HWIP][0]) {
-	case IP_VERSION(6, 7, 0):
-		umc_v6_7_convert_error_address(adev,
-				&err_data, m->addr, ch_inst, umc_inst);
-		break;
-	default:
-		dev_warn(adev->dev,
-			 "UMC address to Physical address translation is not supported\n");
-		kfree(err_data.err_addr);
+	if (!amdgpu_umc_page_retirement_mca(adev, m->addr, ch_inst, umc_inst))
+		return NOTIFY_OK;
+	else
 		return NOTIFY_DONE;
-	}
-
-	if (amdgpu_bad_page_threshold != 0) {
-		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
-						err_data.err_addr_cnt);
-		amdgpu_ras_save_bad_pages(adev);
-	}
-
-	kfree(err_data.err_addr);
-	return NOTIFY_OK;
 }
 
 static struct notifier_block amdgpu_bad_page_nb = {
-- 
2.35.1

