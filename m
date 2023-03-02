Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C84C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 06:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87AD10E37E;
	Thu,  2 Mar 2023 06:43:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F47710E37E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 06:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azLvixKirVvxrvKDvV0z7k78y6GGMEUBp3gEvabSDdJXtOaPkMJ3XeCcEiqLwC8eKG8ffiOBLW2pKnPZ9pvpnKjeN2AXVHdBfzIqFlbdVc0H2A9DPad8a0V58EPrkILHzHrLe509b3Ef5nSfzJqeBQrYKXjvWvW1wzbNPvUvvi1UZ//HlXsFphFqFfoU6U8PHAzr4fR9gZECOFkKf6F4WCtPJkeAuhe6Hv3cmd3Gcgw1yBJM68XfE3IympEhVKCztdDgZMdvOAqqR+7F3LQkuws5r/C8zusQkJRgUlIk14H1xx37sjBNPTqrxXtU1yHnKWtEvn3udBhslTqRYAbB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hy6Ha7I+h/rmafnpNaZw7az2qEJXj7W/83RNTbv911w=;
 b=PGV3odoeh9qDJAFViEw8IRr3dfiyHP04vswFlQf16CFCdEQTM7wkSYMX6N8fW41HjaglIEpxgEvrgU5giit0juZzt0L+QiM4FShE8pxt0gL659EDHmqW9IKY8WUX2mgAv3O+fZ8yqo2jCKPs8WEc9DNlR8jXYagZs5lxQgYg7LyabpLrGsF9bMma3clK7YbqHIOK2mKqhHqdpnubsmnPo+k0lke59Po2Jdub/xXfQWHuEo2INruqeRISJf6CazcjDrLOjuAwg+uXON8CaV6cKnihoGdKvFAQrvDHGp6hC9IlVhMLKYripexp9kkLc86qGWddXraORBu0cufQlnYdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy6Ha7I+h/rmafnpNaZw7az2qEJXj7W/83RNTbv911w=;
 b=iFYtMg8yfh+D9MpeafAp1K25G2/82Pj6h/fDabaU+TWMDVOCGOhI4gwVZv+Cedr9fxna52Yc3JlzqmK1Wjt9SztUVstjihv61aeHdrSHO9+unQ1e/EjJO+CxF5nEzliRW4dAcRNdCh1Btyu97fdAH60wXyG1um9QIhSejjS4aJI=
Received: from DM6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:5:177::16)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Thu, 2 Mar
 2023 06:43:34 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::5c) by DM6PR02CA0039.outlook.office365.com
 (2603:10b6:5:177::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Thu, 2 Mar 2023 06:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 06:43:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 00:43:33 -0600
Received: from bob-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 2 Mar 2023 00:43:31 -0600
From: bobzhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Guchun.Chen@amd.com>,
 <Flora.Cui@amd.com>, <Yuliang.Shi@amd.com>, <majun@amd.com>
Subject: [PATCH] drm/amdgpu: remove unused variable
Date: Thu, 2 Mar 2023 14:43:30 +0800
Message-ID: <20230302064330.87355-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: a7dca647-d02b-4149-8118-08db1ae97187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0e/ZZA23EXQuxZS2FIKxwhW1rM6uyUcVVkk1exH9ySoXt3CneYhn+s6oQ1pR6TABQXI3z8csSsD+qsqj+5rrmE3EgjToG7vY3rVOhUXdPzviDXy2lq7k1ykJqWCag25z5H940UHFHZFgYZREcm/SXsIMM0upeQfxooQfb/waSNplNOs1WZLsRmmbpVyC5eDZO0bTfNVTksU0yWMZhfzCY5lDHEJm71BwxZLv8eRyLW8ZbRk23mOsrV7NaPynA+8Ns95wfe/rAmEzUT2DZNs2h8mBnC0VbvsFkBylc0Ezoc+GUs1jRYKDcsMSJQvECsNFBWIgkemWW/J7pSmae3I7cR82Oab2LW2m+5WJ3iBDmtMJjgSXBAm0Mc0XgOdMCK/NS+jTrPZfDSl6iy4KD30REUPjFkyzalRG3makeKoLxRL0vugPjUj0MkXAzUocAMz1vhGwxtqQM/v+oy1qNHDr1wNk/NVpyaGkd8J/rjWF4vyvmQwHsHM+1gC6JnGEujPYx8w2Q1vdpxyE6xa3ZlAZKQDqmdHKiATJ+q2WTfBp+HY3OtLcIdsJ7w3bn+nI/OKC2s5J3BfxshETnuHo4EQ0qJQoP4tfFCaQwjReuNSNzK2YhR9fqBOp6ab5GPuxg5nyX4KJKG6CO7ZOcnxED6L3So2o07o1cC4BF9CHs/FA+mDr7NAUYp9fCJXoG4vvxW4l/fL0ge3B1xHla3uVCOJQzmRClY9BXR6xjnOgGyvSsl5m/VP4ImzAZQm3qP5m07iIXkmsJYrL5aIeW+T0HfFBug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(7696005)(40460700003)(86362001)(478600001)(70206006)(26005)(41300700001)(70586007)(8676002)(356005)(110136005)(82310400005)(8936002)(4326008)(6636002)(186003)(5660300002)(316002)(2906002)(4744005)(36860700001)(83380400001)(82740400003)(2616005)(426003)(47076005)(1076003)(336012)(81166007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:43:33.6683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dca647-d02b-4149-8118-08db1ae97187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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
Cc: bobzhou <bob.zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

building with gcc and W=1 reports
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:7292:11: error:
unused variable 'tmp' [-Werror=unused-variable]
  uint32_t tmp;
           ^~~

tmp is not used so remove it.

Signed-off-by: bobzhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 073f5f23bc3b..516409989235 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7266,7 +7266,6 @@ static int gfx_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
-	uint32_t tmp;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-- 
2.34.1

