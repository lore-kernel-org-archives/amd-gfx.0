Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A70C7EE2F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 16:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B10110E091;
	Fri, 18 Aug 2023 16:25:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9789810E091
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 16:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOmFe/3OYNjQPzcKCj6RzLwSqRfbCfqOGWWJ9yG3qBH7GFYxlOSO+idf3cfIVroRxvhoR6cG/PWJ9D/y5cTJmvQxyqNxYZihaQyweudsqVJz1VW0e2Vkg0SrsuKiX+DHmKNnzKB3X5N+B/UJebHxUG0V4mqb4fXoveYNwiJ/12xOAGeONZdzU68JYoDaVh4uyCLwnWeEffWPrOCcFKjSmvxhR0fgGGq2esiVaZt4sgvy5DMO4t3p+cDvpbpioONXNC89PREeycDl2P/LoK48hdYWUp6AQkpJJlpwD8KT2tuj0WQZaTm5s+IQqmNZ6l1UUHZXCQAuNK04hblOjqhylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXLaKXGI9Qz1gXbeufJ/o4bACb9CkK6aHDuHxtR4W/k=;
 b=aGfC4bGApzToB3f7thNSeCK2FqFLLRshdTems/bKJg1bdd6ePQ44qVWb45C5wUL3bcaRI81fP1+e6GD9PUQKFRCWvYAKep9+0/oMSbHZcrET0Rwwr5sFkZaa0+XKjBCv68c2QsMHhV8xMzUKAayK8VnCWEJFmOptoD9PfCXAm90qjzZvR5gnEvEqwnYT4tMHOQEab+so8HFWwcZuTCkFsvBaK3H6sXMLipNRzCZYLCtRmCb7qNJ12m6SEGZt8WoQphVcVfi5TyViiS+KaEpEd/6rLdrln8HXZGsAXHRZNDku0phqez0OTscbJESYSB7xxbRro0f7JkEhu2+C8lw3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXLaKXGI9Qz1gXbeufJ/o4bACb9CkK6aHDuHxtR4W/k=;
 b=TMZz3UK71l1IgcQQ2WBZgLqGC8yZmtnRXPC0P40ruP0qTCk44HpPxVaEafZoopkhQXnX0CwhGFRvaIznhlrfv8fWUlxV54VyhiWU/SFOAQKgDc4cq/QXStqSsa3pwVNN37FjCPRi1ZgjKX2DC38H/RloS8rAalpsYuFyt0/xVH0=
Received: from CY5PR17CA0004.namprd17.prod.outlook.com (2603:10b6:930:17::35)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:25:19 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::76) by CY5PR17CA0004.outlook.office365.com
 (2603:10b6:930:17::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 16:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 16:25:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 11:25:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix error flow in sensor fetching
Date: Fri, 18 Aug 2023 12:25:05 -0400
Message-ID: <20230818162505.1782006-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 973e4a5a-1db9-4e26-b4b3-08dba007b67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7bNppDcJ+Pl+R/pZKPNU/yrsEWwQ0ZUlOtorI9zo+hmEzELXcPHuG62hXsLR6tFiq9X83EcUGGVObvMbzaD/oV1GF+jTPItt0WBiVH7IudT2WO4sx8e+gFC5XAI8jYp/H7tK5ckNbpStjR6ZM7Qm1Phuck98B9wb61j9LmTFooZCvMas1/MD0b9mQJ4wnt7tqfcxt8kcLEDEGd+5icpouwHvODr7p5Skrom47MBuerXmKXFt8Y6g9CyyPvNXfLeuMG6yNfi4hYh2E5q/Dimyyeafg2n+rk/edmAdyRj+VIRMw6Itj3nmqdVOFq5AXI/e+lCnwnVFQWWp4XabC3tZGH9GoBKoO4fN4O/1lplPDAooRgIgYw20fAoE13YeDTEKy2ZOliuyYZUVeLc1GVEN/rgccItMaB22AFA2OSmKkiolqeF8lGIKxZ+hx8RJ14UHfk9dCFQ4gZtSnE/vEwxL9ZzE/8aRPjqAlDNJpVSQHsESF0pXL22YXGDKK+fk0Mf8Ft6h1t5wjYDoibhY0GiQqXb0QhofJQLVunWuFZW5OaRAP0ZLX4SC0pjI+7+dHd8dbr41iEaeo3sItWH8hqAgrX5jSHmtrcWWE+CTJs6XRTIFy2do0oXwPjn6Hz2w+UAyhlCpvtTXFSPWxa/lb2GDCgkG/8xSyQ3hq3+aqyMQXk8j2zSKpAu1EBRbnQEjJW+hzU/m6m2vHn8sCr8vqfVchCdIduyZBH90wc5TbkDpPukvw+PYrcxfpqiXkHUtSvHLqqvXfGTztFPaFXeWqZUcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(6666004)(7696005)(40460700003)(86362001)(16526019)(426003)(336012)(26005)(40480700001)(1076003)(83380400001)(36860700001)(47076005)(36756003)(81166007)(82740400003)(356005)(2616005)(2906002)(54906003)(316002)(6916009)(41300700001)(70206006)(70586007)(5660300002)(8676002)(4326008)(8936002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:25:18.8739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 973e4a5a-1db9-4e26-b4b3-08dba007b67b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sensor fetching functions should return an signed int to
handle errors properly.

Reported-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f03647fa3df6..a6697c266270 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1467,9 +1467,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	return -EINVAL;
 }
 
-static unsigned int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
-						    enum amd_pp_sensors sensor,
-						    void *query)
+static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
+					   enum amd_pp_sensors sensor,
+					   void *query)
 {
 	int r, size = sizeof(uint32_t);
 
@@ -2772,8 +2772,8 @@ static ssize_t amdgpu_hwmon_show_vddnb_label(struct device *dev,
 	return sysfs_emit(buf, "vddnb\n");
 }
 
-static unsigned int amdgpu_hwmon_get_power(struct device *dev,
-					   enum amd_pp_sensors sensor)
+static int amdgpu_hwmon_get_power(struct device *dev,
+				  enum amd_pp_sensors sensor)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	unsigned int uw;
@@ -2794,7 +2794,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	unsigned int val;
+	int val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_AVG_POWER);
 	if (val < 0)
@@ -2807,7 +2807,7 @@ static ssize_t amdgpu_hwmon_show_power_input(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	unsigned int val;
+	int val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER);
 	if (val < 0)
-- 
2.41.0

