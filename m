Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4170C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 08:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11EF10EB95;
	Tue, 18 Oct 2022 08:32:58 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6474010EB95
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 08:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtPDFC2EcSgy0vLfuqXnTiBuVRgyIvRHVgy74x6s3iUVnGid4JHEvkYrm4HQ30H/hAClMmsLvj2GL6V/h0+2NJYl4DapwxwjkfKgEes9WFBXH1GELfKaOF4jRqeCmjcjHbAAQUTcnz5yCZ4P8kAh/ptvPKgiW23/rFcA66BpCyj3U1E06Y3ald0AOQ4pJZWlM++F2MX5CPhKaIcPXEvtPSynh+/8D3yP3sXPIaXi1lSOrVHnZMydsCk8nMv3oS3dH2xDaFo7FDx1c7nQYNmjSmjv9z1Uj4hBPTb+6bEzFEr6pz5sG5/N9OSS1+HRx0J0ryijJ7QrAE517rPEX/yKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz6v/q4K4wHqs2Xw0NJ7st6Bxvxr4Wlq2lSTA7oZvy8=;
 b=hAMB8maa5dFWPTnnHweQqNxVwbyBzXgcTcdi5NyW/krGg1HL3jqldZPTirqFAxchOwQyl4X1NQgd3GsEBcLjbwWL6siR0licGihFFRNaQpErkeYtL+6I8/DTcbKj/1Nl+IuDKRt3rcP4/fL2htdPOf6WhI8v7zZpmhjT1MA8i0hZPG2YvNCbPNnIS1sF8bVU84Nex3EJuF4kFvrSC27+LWQVCHcXk2yKX7VpCZAGCFFuxqJhgqA5s64OI/+vUMoHgmxqCvPBhF4aYCNR4yoBtZF1przc68/YZcr8KwpVL6BgiXSAr/vE8OLFZ0YpdlokwlBU/i2oTfjccHG9zyBg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz6v/q4K4wHqs2Xw0NJ7st6Bxvxr4Wlq2lSTA7oZvy8=;
 b=CfGNT79C20eDGIu7S/Bmd20zySgoKAJ3T4QgAXXs8cevkvAXJ8zDFCu11a2QnRV8/MOJv8uanM5nAef0cmIqm8c78nsTXFBBJyDf+BQFeNywrMqvrGnr1jfu+hEoUVp26jqwtcS0Vrr9mcRwrfICqgiYCeOVyN40kUSXJAKvdVs=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 08:32:53 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::6e) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Tue, 18 Oct 2022 08:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 08:32:52 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 03:32:43 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: use page retirement API in MCA notifier
Date: Tue, 18 Oct 2022 16:31:58 +0800
Message-ID: <20221018083200.15597-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018083200.15597-1-tao.zhou1@amd.com>
References: <20221018083200.15597-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fe0f96-4965-409b-bae8-08dab0e35922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgceoEbXxdQ9hHHNMt9IWtTmVIykzjtP6eoCkUoFGvkeOsdbLhEpGnainU2yc0zhf/XG1m6tF6w/A3kBYVfiUZ7+QVs4TEjBu4gCTU+3vyuSoDrhHAqcvRROjYohqLeibVTDaRN5WMWPnfeU7NcvQqZFVDU+Ll9ay0QXKwM98uSMPkU6wDkX5/7S9gL5YFkzJ4TFZjLbgD5Z73qi5eNZkwMIInTfAQxYdv+2XYyZfaoZNmG340y6XbZauqmvvWmi07f1ai2cOWvR7n4DHvK5UqjUR2qbie6/H1xD2O1/kEaRmlDqUMGGq72Iqa6C2ZwHLIpupnNGychEOxotYbwG05agpMibYNUSxjv7iDX0GQAXuNjkGqatpwNPURzu59i0Ta71LHsyioEwM4T0tnGwLgygjioNqpQDTi0IqMhhhxdFdExniLg8lVDLnn2rJhGv3G6L3mwKcNhYvRBgeMc9+cGVJarwbBLhmpuuaDeH8+kKa4Bif98FIZJh/MEmi71VtbhRo7jUewKYcQ2h+jKDExwhflGxz61OKQLIHmPnGRzPejijF6o7EaPAn4p5r2ZGSmnjKh3Vwf1yJvbn3j+dJNDpTBoeoyOXofHfj5c1QcUgh8orRa1zCTs7cITXqrqd2Kuh15KgIz+AADziwQmh0m8VSIm8ZaRWnr/uv9So2NzY6nCTiMSzIAXZMZX4/+qU7AUYJLiCpw5C+zGV8wSu+drq/VtBo6z0atHN5wxutwHAN6wGNUYW5/DYxBX/gU6e3fOYWftnNqVU+OjjBI18HkcTJ0FMiov5SBtZ0DF6pM0xv+fd4Ed/i1N6/fMVUXRt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(47076005)(356005)(426003)(336012)(186003)(2906002)(83380400001)(1076003)(16526019)(82740400003)(40460700003)(86362001)(36756003)(81166007)(82310400005)(36860700001)(40480700001)(478600001)(6636002)(110136005)(41300700001)(2616005)(7696005)(316002)(8936002)(5660300002)(26005)(6666004)(70586007)(8676002)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 08:32:52.4140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fe0f96-4965-409b-bae8-08dab0e35922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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

