Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621EBCDB470
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 07:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D043810E9A2;
	Tue, 23 Jun 2026 07:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GUK0ZBVq";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 775AD10E9A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 07:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nwj75JGVHqvP7kYSTHNUMPG0C+b2xxDL7jkJdvWKdAV0vDX0SiAl4Fy0Ez68271GRWj2AavtRZR0WswQ0Q/JE3A4n3cjjGj3MfzSMtA7+W7aWF5UMKTW3VmvCK735o+E/hM+L6OGkd7RfdZo4IORxKeK16YJ23ZzkMuCj0bFq/SijypShQ6mmUCK8l31fspaFMrH5nYUDmKROsm99iV08pk9fel0ZUJxD3NLz3iUJFSO5OttcSoAVFlIXlXVcoL11mG06c4LZH8AEXzNXnJjcsy14ig0UXE7XOYKt4tz4NfF82c3FsiVZDee52tX6Uq3kBZ78p++iL3HGqk2nnq7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIm3S4+3aku0u0Vwvn9IQWbp1lhdZk8CTGQuvNw4Gk0=;
 b=FfO18At9/KMZoHaLMO7li7p/DZOj2ZDrvvoiMiFIK8aCuUzqSuQ8CkiZGpbkCv6H9Dh6jY6OIuZi/2P/4kJJgukEnGbNJ8F/OiOQDWnSqwuDMNpEauw3HqA/YbIyz5dk91E5EuME2iWxY5qPHb/cSzsMTEg+ZPKzXhVP3EL1vo+DyV7zAO9kVt4hIcodadwi4Ryur1yUwyDF1RttAY0twE2cfcZdqWlO2PsZMJK2bYKVFAA2fQUoTVWl5OdlCT9f0nT/wk6KKE93+7axEFjkDM81c/QVBC24Zph6HoywdXQQWyy59s4h5l4esLr9LfrZrkpoCWAXBaa1irANwf0mbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIm3S4+3aku0u0Vwvn9IQWbp1lhdZk8CTGQuvNw4Gk0=;
 b=GUK0ZBVqP9qWpC8n0pmglxDb5nfVlK72T0ZctZe9cpOmcZ+Byqty7LUszkeOYivcFD2/Aql1hsyCsZRFZWkbCpJ9oQsivGywhVr2b6+33HDyc6eHKlNwrmUO6jQ7rV+vLRw/YoPm4t6r5TE30iTDLXkjVLZKPAxEhGYRQxNxeKQ=
Received: from CH2PR19CA0010.namprd19.prod.outlook.com (2603:10b6:610:4d::20)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 23 Jun
 2026 07:41:26 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::23) by CH2PR19CA0010.outlook.office365.com
 (2603:10b6:610:4d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Tue,
 23 Jun 2026 07:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:41:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:41:25 -0500
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 00:38:21 -0700
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu: invoke pm_genpd_remove() before freeing
 genpd
Date: Tue, 23 Jun 2026 15:37:51 +0800
Message-ID: <5db799323a211d12937f69a1ba28d3c740bf2569.1782200200.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: ff36a1ba-2210-4cd1-aa4c-08ded0fad45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: g6bzRPKyR2zDk7Zn3vYiGCSAr3saHBFGY5P6fubEoAhktejyJRH/G7G8xqc5+KM//N58cEmi+GLqwvNspTKMID70BFDTG0hntE1C89DimQS8cXUH9Hcs81Yr6k0eJ6DzqCKZQkUK7lfwVEL5Sfy9rclihGRjhT2QGfdS0H6h2HPFalNGBH/xF6hKMRuTnfj+0nd5ThOLkK8T6N5JZNngkbiYdyWqMMSNcd3SFApMUBm25UqEqmADehi2MYkWY02A/2WVg2Dn640beDssgaE5MvGBMRsWuqSn/Ex/+wLMCpO6xTjq/PI2D17FM8UgQEO+528cIpjhDOFIff9hKEHb711k/4QQdUqdrrj9w/21sbw0e3Bz5gqBTGjA78W7hVbBQ3kFcG7TE6enV8lXWBrobfRqX9CGbVjbJOQpyS00WirS/zAwPh73H4NhZhjTCALKuOSp4iSULXf57ajkIndQsVxofOH0YKjE4Vnv0iawoNQ2uSP6MRnMliLIkWsZAYmSVVr9AUXvgJo171ez26Moa1Xj2NCM4pXp+BJXccj1XxI7Px6mJLEdc2rBOSpG1rM4C8DwPdsxiRdoRfYzwTNtO3TkweQSH/M1sjpDbsgMAUw2GztDitJHVCNP/j7AohNO2YBXlz6Nc6Rxb5Tu+Gk+VbF0ep6qD+2V9x8epEsDFq+MoGp41h24INEsFtLui/FFsLU50Q0xGe3ZSPN2czd8qQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f804jTsDumv3zGkYlgg3ikAt6FQZuqlJlTbTavkKwEiA0zgEnatAU+ifl3GnAY/7NlrZ/2NHX8632L0YcfFPz6unzOFRKN9sP8YOkqltIfPomJaLTZb//C8glUkdWolpG/I1MF/kzlS0izNMjuPCrJenO67Gqb/VKBfrSd9hcRHfh1MRQ4vFAVKBaW7vkQW7/RKmlKHBzhxaKzsZ3vM5VF9Y8TIcUWemdzWTJMJ0CED+ncF3p6oceEifZvhNvp0pNrhH8Kix5g4y5l8pPieukWqMDH3pNJL+gLR6wRFPif7RbIDrV6viSuEfEK59qIS0qcWcyslvJ+XnOFqEo2J+CrflqQp9jBQ1E0c9x7JA7Pde09RtXKEShCPsrWd/+sTNfv4rsaR0hbOgodhuXbmNW/gP6Raa1J6kM03TXWTrbB86LlsojqlkzDzo2Z3eJt7I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:41:25.6283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff36a1ba-2210-4cd1-aa4c-08ded0fad45e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Call pm_genpd_remove() to unregister from global list prior to releasing
acp_genpd memory, and clear the pointer after free.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index c1307dfccf92..b0db0834bfff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -559,7 +559,9 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 	mfd_remove_devices(adev->acp.parent);
 	kfree(adev->acp.i2s_pdata);
 	kfree(adev->acp.acp_res);
+	pm_genpd_remove(&adev->acp.acp_genpd->gpd);
 	kfree(adev->acp.acp_genpd);
+	adev->acp.acp_genpd = NULL;
 	kfree(adev->acp.acp_cell);
 
 	return 0;
-- 
2.34.1

