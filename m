Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76136C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 15:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E0310E258;
	Fri, 17 Dec 2021 15:31:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F68210E258
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 15:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knfX3PL+BZ0NeIhh7p0lisXb5Y2BULuVZdXZmjJsA7zbp4QBnUlUD6kecOolovVOivnmpDiLj6mkia54fpSJTtv4yItNRxYXu05w1fMm5tw6g11CoE9KMx0C+3w5oy6jfaoYEIT8lk7k92a0WkvzytpkEZjsccxtUEdg6sD8VKFvgdNjZ424zUm/HgYyp8y97q3VeWvi3hOJqgywnr8IoinV2VAlviFH6lc2jhgTh3Ep23fAJpZ5f/j5odR7Yj137oNrfAdYhUp/w/pYezP8dbgn2IcOOc7BYwmC6rpDtGU8FTqDDar9pqsVif9Y3UeRsTLtK/EY3z6139YYhDUdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GH85uefVlfXL5+VZVB+7KMtVRAvqv6eXYsBnXL9gcc=;
 b=O7t+jaDM1YSlbcDdC1V1+JhOswMAcG42E1ZtgZecH/OfGVaRLatl3mQbqpozrBDGrJsF4hxgxVz+cTkqPJBgYFRUNpKBzfMRLoTwE9edbewnrt+tKuF5DX3VR1NFfyu2DgNqfJiMNvNj/pRg4e2uDXSd8O3NeUw9b5RHPRitmdxqIQMa/14YQkcDcbH8/FHtS5wVDlPjL0zDEsFCcaFFFHg8TWtvh16gtnX3uhptEe7f4awUJGX1cuGHBL4Au9gCzYdh+xuSc8T6L+0c2ZJpYNa88TzgmUAte1TFYdr3sXf4NDrVEgJ/P8k5qQpRNU+kAdhTl7Q8h1REuOBu8rDGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GH85uefVlfXL5+VZVB+7KMtVRAvqv6eXYsBnXL9gcc=;
 b=Rmx40s7XSwckdJUyd+Sha+kEki3goYokpFyqGWt1eNkH2xlT+bZB6F4jO0AChylA1nNMenWrg7HW3rGchKJnsSZTu21fRPmRy8Tw8QmoXyWvpG/Xuv2lE/lsCuOQ3kwCsWS5tF21fXqEsbSECCMQk3L8bWjoylrID/a1yBJpK7k=
Received: from DM6PR04CA0029.namprd04.prod.outlook.com (2603:10b6:5:334::34)
 by DM6PR12MB4928.namprd12.prod.outlook.com (2603:10b6:5:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 15:31:43 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::cb) by DM6PR04CA0029.outlook.office365.com
 (2603:10b6:5:334::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 15:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 15:31:42 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 09:31:41 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64
 characters
Date: Fri, 17 Dec 2021 10:31:28 -0500
Message-ID: <20211217153131.321226-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d96c754-7a63-4cff-27ac-08d9c1725403
X-MS-TrafficTypeDiagnostic: DM6PR12MB4928:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB492899C07D96F4426CF1F7A585789@DM6PR12MB4928.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfbsrMNqgxm7Fk2hka9z+HwmWcBR93gmWRVgRbGN4P0g5MlMbP/Wspl/UhAAF8QqEDMEsUVGrPU4ybVU1hNnroHqVIQjv6uLDlD6TZYJSHMLrFQ37sDDwUH5w6xSlBRLAbV+P3uQtD0XU1EiZXe2KGD6aYl/YVKQ0CEAc8i6OX/dzTfhZA0dNShPjPsUBgp/daapdf/mxuTNJJKEzwymT/gGH9JX3pXuO+vZIrKHmIzLAcx/fUd0gIBK0pfrkIMN+hSv3mcoqRtUu82U+jZitPapgs6AtlfAgIja3oHc2VE6fKl5wYMlCdPMOOyryzJk/QkBFH7H4Pq6hmg70ScHaXcXgmL64VsXNe7WCsnWJVRo0r7gvbWq/5K9Go3Z3TN5FO2rY4L5xMIFoYmc/juXRGMsu8gb7FPGepkgQGYgjeRogxrV4UlMFuEUAZPLGeEOKEyQ+/qktrqd2LRlGsQoe5fkyq4wsXgt5+splNEhGFJKzwrcGtA6Rc5CIdcTPGyFmm5rwcEcDgxZkEcOpCK9njiVFHZHDPZ7M84DVlVPsiZlQzNhbWNwagPtiIYfbz0Z5uOh5bbErf9uKhtRxjX4LK9Uhmf10c9nPFl10tAvfu90qf8mCNlGTmFJgooaV9CX02A03AcRnFQ8jnzBqQmp4rZtFod9wDDzNy3c4ubbcZupeVCj3hehjrvIStuHiwF7SVbI+1MQyE/VJ7cEcHC/alQLhAGuw24jZeAwqcVjyrqGI3BNPFcBFaufBEf67dD/6S/myd0sjeqRZ71nBOUDnk4CiyuLCI0Y0V2NzWopc2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(16526019)(6666004)(8676002)(186003)(7696005)(2616005)(336012)(426003)(356005)(82310400004)(36860700001)(83380400001)(508600001)(44832011)(316002)(4326008)(86362001)(26005)(5660300002)(2906002)(36756003)(1076003)(70206006)(8936002)(40460700001)(81166007)(70586007)(6916009)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:31:42.8780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d96c754-7a63-4cff-27ac-08d9c1725403
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4928
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Having seen at least 1 42-character product_name, bump the number up to
64, and put that definition into amdgpu.h to make future adjustments
simpler.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 12 +++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e701dedce344..4e6737e4c36c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -813,6 +813,7 @@ struct amd_powerplay {
 
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
+#define PRODUCT_NAME_LEN 64
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
@@ -1083,7 +1084,7 @@ struct amdgpu_device {
 
 	/* Chip product information */
 	char				product_number[16];
-	char				product_name[32];
+	char				product_name[PRODUCT_NAME_LEN];
 	char				serial[20];
 
 	atomic_t			throttling_logging_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 7709caeb233d..5ed24701f9cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -88,7 +88,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
-	unsigned char buff[34];
+	unsigned char buff[PRODUCT_NAME_LEN+2];
 	u32 addrptr;
 	int size, len;
 
@@ -131,12 +131,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	}
 
 	len = size;
-	/* Product name should only be 32 characters. Any more,
-	 * and something could be wrong. Cap it at 32 to be safe
-	 */
-	if (len >= sizeof(adev->product_name)) {
-		DRM_WARN("FRU Product Number is larger than 32 characters. This is likely a mistake");
-		len = sizeof(adev->product_name) - 1;
+	if (len >= PRODUCT_NAME_LEN) {
+		DRM_WARN("FRU Product Name is larger than %d characters. This is likely a mistake",
+				PRODUCT_NAME_LEN);
+		len = PRODUCT_NAME_LEN - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
 	memcpy(adev->product_name, &buff[2], len);
-- 
2.25.1

