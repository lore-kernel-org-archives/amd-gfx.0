Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1F9CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F088A10FBFF;
	Fri, 29 May 2026 09:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FxNBjOoe";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD4B10FC03
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dk8An0gXF6T/KeIAylGG7EbByEebaLYAOUjaYJpx3P3iX1aFy3isPJC/2E9/ia6stmO+9RC+Jt/ftFLQ8PIndaIas4m1uxJbMp1MgVfY69I9/P67QqucYS5eF1H09OfYwUlkZvO70iXpist/OxcQkPfltOta7G6IYju9Coiuj9e7Qki+mRl8T1+3ikcYdHqWY7TZXCZQG5v+RaFRAO7ZyEaL46zOZgh00Pgz5BUglz5fLyizNyDkciyO9Kx4mVgQJVegRaV1odYmRBszKBspkKPhcrCFPLgcouzYwUR9P90udDn8cbGPcAuyQp7AGDj8mGs3hI+dddBfDdvttr7zjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Dd9ujrSw/tjya4JAlkn8DNRb+DggZ5uLwDaAtbhxbo=;
 b=cXf4qL8lcdvbcVA4R06oYMvfZR9NaHCVd1yM4MqPRv5vFO8t1PETje7T+e8A7RWaC40aDvIMnq9emXqM0eX6IIBFMfsnM6MblwUrSK9TTvvBr87eAs/iuTIqjZS+LLqtPgUc9hRCumnrjeDf5vEjdkH//epKT8pybaJ5rM6bjW2BlTcpaa43AQLOr3oveOwR/4H/D3FczZc0Hw2L/B6oohIXS4Zjt5wTxwpN6oPWiXPDZEr20PQcFvyx21Bc/drm3sSYwHbnePoSOtYL2LsiOwnKnhv00IUJDUuf7ayRiK/pD9QULn1V6FNsVSr4hRQrnxX3bqCSeRmITC2Ak7XoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dd9ujrSw/tjya4JAlkn8DNRb+DggZ5uLwDaAtbhxbo=;
 b=FxNBjOoeAm2g5xBncMUzES7GNWYZLC0tzgKQcpD6Mb8XfJWpZDOf2NTKXEGWf6NqJrFgrKWx1UeckOO5UQtGjWT1Z9kqUBt+r6Oqci8iaGlGgBqRcFp/GGVNbfHEWcxrqdUOzTMknKSlg6wUJ4ZAIbrAMmEaZVMsDFdJCOBJN2c=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 09:43:05 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::55) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 09:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 09:43:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 04:43:02 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdxcp: Add more checks to amdxcp
Date: Fri, 29 May 2026 15:12:46 +0530
Message-ID: <20260529094246.1135225-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: ff822a26-bd23-4edb-0817-08debd66ae56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VqYySBjJdpVtzyDxrSYuHS5AhdsSIFj5t7ruuAFxDfNFLio82e/dXPcboqRXyrMqf67uoJNwVkm1CBtOcz371fHJAombSLm2si/bKy70lVGycR2KD5dNi/nA/kbqJfJtH/kv4hEq/GMR8B+W5y84JS/vx1xhzNQ80GU6DwsH+Isar8sVJgvreDKU/wrG8Yu1Atlil1lw5wGURsoTyBIqP7Re+V41xT8eF0m4BHo1TIPyaZajAPriLWt8A7GDtENmM3f9MGSMEcRaraYxdXZsh2DoRsYjMN+efmnu+RHLSD/4Oh1Gi426ZVE4fr4Ebrx8HsRJ72p0F5LEJJRTQr5sjuaBApILNLjZsFoyMcI8OMYViRkver/7/XH3sAFm3aSssnVz6QN+4PvkcRcjb0+Ti0aOjWhVVnnSAf7YMvvbJeW6JrNdxBALbkfWFc4EMhIpFpCkKOMRzZYtB6e3i4xYFzSffDGdNHC7U+Dy2f+kAgKL7Qceg39lqZzbw/UhXNHdoI3V5BiEfBhUKDEgkMevixFWX/0YtZuwBgJwnt1mdbLhi9DXoAXQQNYoWr2oJ0gJAWHNAYJtBKNjsyz63OcTV/BU4u92bX6qkdUC0T2E6uY5aISUxHrSBcibgICIlILQ5SUGTJ/ye6HSJ0v9IGJHfJ+twXwBQTrZLuq8O/RzZanYqBIywkqRzUNOmxlaiIVpJnf7JsSl2JCW2V8Qb07I7pA5WxRTMOabf9j1YFrTDgg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SpcWWl+shtqxYmAmmKOx/SqQ1PynJOW9mfCLgigf4CptMpay+t2KinsW4L44UqXZp1zKV6+7CzsssO5p6C01/be5C5X+swiJt/GE5mGKvObMH+mEBvcCgYNltx+/CP3KIxAMCVXHlguLSuWQHuxBNLC9XiNRmbUTUDsLS2SqPQxatC4SgcUH29gsDn+WTzmoC3yZPrqmfr+Z9PpINR9SIpgUMoEUgbFWPEdU9ST4dzrwsMDtAivAyaAfNycDK7l/w4VS/uV+RgnR6Md6Ci62ANrfRs82afhHQEUz1kSblp66O30+em0sgHdJkbtMVdHJZ0hcwL2aF67xNDU8HykiTM21yiAALAAEoAYBOCE86NNWykCGytamxgOxXe1S2v4BlLSUXcPpmGzOiv3vDfAz6SY9ICQlYVuP0cdh4eeM0jYjtcAhn20rISGoFBRSGOcE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:43:04.1930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff822a26-bd23-4edb-0817-08debd66ae56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890
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

Add NULL check to ddev argument and guard pdev_num against underflow.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index ae40f64369ab..a569163de047 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -44,7 +44,7 @@ static const struct drm_driver amdgpu_xcp_driver = {
 	.minor = 0,
 };
 
-static int8_t pdev_num;
+static u8 pdev_num;
 static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
 static DEFINE_MUTEX(xcp_mutex);
 
@@ -56,6 +56,10 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 	int ret, i;
 
 	static_assert(sizeof(dev_name) >= sizeof("amdgpu_xcp_") + 10);
+	if (!ddev)
+		return -EINVAL;
+
+	BUILD_BUG_ON(MAX_XCP_PLATFORM_DEVICE >= U8_MAX);
 
 	guard(mutex)(&xcp_mutex);
 
@@ -102,7 +106,7 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 }
 EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
 
-static void free_xcp_dev(int8_t index)
+static void free_xcp_dev(uint8_t index)
 {
 	if ((index < MAX_XCP_PLATFORM_DEVICE) && (xcp_dev[index])) {
 		struct platform_device *pdev = xcp_dev[index]->pdev;
@@ -111,17 +115,18 @@ static void free_xcp_dev(int8_t index)
 		platform_device_unregister(pdev);
 
 		xcp_dev[index] = NULL;
-		pdev_num--;
+		if (pdev_num > 0)
+			pdev_num--;
 	}
 }
 
 void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
 {
-	int8_t i;
+	uint8_t i;
 
 	guard(mutex)(&xcp_mutex);
 
-	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
+	for (i = 0; pdev_num && i < MAX_XCP_PLATFORM_DEVICE; i++) {
 		if ((xcp_dev[i]) && (&xcp_dev[i]->drm == ddev)) {
 			free_xcp_dev(i);
 			break;
@@ -132,7 +137,7 @@ EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
 
 void amdgpu_xcp_drv_release(void)
 {
-	int8_t i;
+	uint8_t i;
 
 	guard(mutex)(&xcp_mutex);
 
-- 
2.49.0

