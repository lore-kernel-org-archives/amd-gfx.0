Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4A6C32772
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 06:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABA410F37D;
	Wed, 17 Aug 2022 06:20:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5C410F38C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 06:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5M+gsEx9SpE1aq5Dz+IuIAK3IgPjq593ChqbHLABzfjQ6wG9vqYz+rda0X+/ZxXeSp6z3ZKKBT8o9LmWHdnWD/xGEyLR9eiqEYtgGnCL+c8GLy5W7Ig1axcLk2462KpiHn3y/T0F4HeoLiWMRVwbTfZv8S8pxVu0ct/naUfNr2LFEGsZ03a/HfIwIEZAYFqF38uh+K7e/pHWIqOOb2ULrc4DtwvXjRdUxzZJMGBiXz1IaUgnRbJ6FSVrkuxRwFg3yZrbsxudY4qfR7f+/pBrXeMybICL39n6N3a7Eb9NVh5jl7BRydXwuWUi2h/o+8nVeKLD6lMCw+Zhaa1yygPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf1eWYpdi7lXxbN1Ot9Z+d8KslrKZeUoinbmKz1hqTo=;
 b=Z2XcWmLOYWYSlcrj9MB4T0SNP6/go0Jbzfd2T1qlRl6RNXlE3R9JV0IA7c3iVvAnm+Gtnz0grwFsttlv+HNn/vcbidIMz6+xmVhOeOJd75/TfhP+9LG8Oz2Z5nFf58LP+dsDt50FNFaYuaENMig+UwodaxZYU9gbmNDUIE1aAavaCL5IJilU531AXh8m0sAHRKbsmGGyNXBWwXOTX+8l9Gdi0ulKkPTBaeLDDQQuAvkucDST6bx2e/3XnqsG5Ow3qStdbIwHX6IdMEMtLrryzNKpWbxLPbMUZYo+1W5MVNFqyYCoh53Vyty9UMwuWPRj8LJXaCYwvZM9wwi0DbZlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf1eWYpdi7lXxbN1Ot9Z+d8KslrKZeUoinbmKz1hqTo=;
 b=QTrwKsHUZqcLR/nR9T+KKqBno2K0iv4u2Y/YgW3MBnE6lUmriwzDOeB9mr6N2BVmzXs2JyZKuP69NUCpHjZPbxpLYp7AEaVgLIL8kRe+sZxQfCufNFx14ZFJehGBE7UYXGoHYN8oz47ajRVr4dZ2dGMq/50Ffvj72LFolFoHx1Y=
Received: from DM6PR12CA0033.namprd12.prod.outlook.com (2603:10b6:5:1c0::46)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 06:19:50 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::6e) by DM6PR12CA0033.outlook.office365.com
 (2603:10b6:5:1c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Wed, 17 Aug 2022 06:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 06:19:49 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 17 Aug
 2022 01:19:45 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/2] drm/amdgpu: Move psp_xgmi_terminate call from
 amdgpu_xgmi_remove_device to psp_hw_fini
Date: Wed, 17 Aug 2022 14:18:53 +0800
Message-ID: <20220817061854.706010-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00ec3821-5564-4d9b-c8ef-08da80187d88
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9DPsGlcZWfO1o8Uz1BKn46QxU8+W7GVZiIULfoqTklXZLBN0dzLKLSLtPulw1nUBJfsHX/cHeBVWDkVH3MxK7AK/SPHxmA3+np0+10nBmTRcLW1atXR9De6c3UfaeDFDrmyCE18SNorEhANoWODOCIsJnZBPfmGkk5/WWeWtMGGCFUUKlSlvJlV0HOSoDj+tIJ9VSnjX7fg0EcRmN/0whztg7T9cA864zr7yaeW8GpU+AalcuPIuOqme8uwGlwFYEROv4prbkq37Px4xcHhZT6+heuIgxdbKLeSsitqPlG2AIfD2z4IWr6E3JTD2yM2ybuXemwe1OKe7fpCM5P1ACDDaubWfPrHzZonkU4KrEzelMaYIOc6eQcpXfHCDv140zUZlyb+Zb8pohNNVUrI7zeZhab6gMXom3InOJmCjIQBBUIwNZJjmIw98R5yxu3petTIwwQ/9MZXtNKNOZluv2t1OQ0yCy6VK26KmUWONAO0Zd+DhsDTx+spMnQXjMkrPEew8+6suyYZsJ+7h9Ci8S8ayi5vDV283fgi2tbjFfK7LHow5DkNq5XVn8jFT0qQ+Tzn292cnnGFHGPKf3Ffn/E4Qut+DQapeGswv3req4aAewGgwEwNJv4xZ4+Yx6qFNDs4pgFqd7V935Fhm6FTE5CQhXyvqDB6998Dc2lrVruG7y2ko0ZjWgliU2+fk8+hsq9eOwVxKjvk8uEyN6at8OJ82mkvw5CeMq2rzyrO+JDPISb6VzLmJJpg/j0e0YDbBB4CSCnSS6W56+g0hkMI0kFoZWeWA6fV1aT6X3s18SyYuS/EW14A1yw3GQFuZXmRyhQJ0qya+QrQ4nlc76YpVEkyh4HgZJXuXY4NF77khR0E/Tn7gIP6tkyj6HOZ+uMO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(36860700001)(356005)(83380400001)(4326008)(43170500006)(81166007)(2906002)(8676002)(8936002)(40480700001)(5660300002)(70586007)(70206006)(36756003)(54906003)(426003)(41300700001)(186003)(2616005)(1076003)(336012)(47076005)(82740400003)(16526019)(40460700003)(6916009)(7696005)(316002)(86362001)(82310400005)(6666004)(478600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 06:19:49.8939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ec3821-5564-4d9b-c8ef-08da80187d88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, yipechai@amd.com,
 Candice.Li@amd.com, John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V1:
The amdgpu_xgmi_remove_device function will send unload command
to psp through psp ring to terminate xgmi, but psp ring has been
destroyed in psp_hw_fini.

V2:
1. Change the commit title.
2. Restore amdgpu_xgmi_remove_device to its original calling location.
   Move psp_xgmi_terminate call from amdgpu_xgmi_remove_device to
   psp_hw_fini.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b067ce45d226..1036446abc30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2641,6 +2641,9 @@ static int psp_hw_fini(void *handle)
 		psp_rap_terminate(psp);
 		psp_dtm_terminate(psp);
 		psp_hdcp_terminate(psp);
+
+		if (adev->gmc.xgmi.num_physical_nodes > 1)
+			psp_xgmi_terminate(psp);
 	}
 
 	psp_asd_terminate(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 1b108d03e785..f2aebbf3fbe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -742,7 +742,7 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 		amdgpu_put_xgmi_hive(hive);
 	}
 
-	return psp_xgmi_terminate(&adev->psp);
+	return 0;
 }
 
 static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-- 
2.25.1

