Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328D2C64EC7
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 20:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1E310E297;
	Mon, 20 Feb 2023 20:16:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDA710E297
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 20:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJlKeEuo1FcU7rJnHdQLggvBqpKy+SkYy0QyFcSh9btgM46Q1TC+aCJKVgC3gpqTWQDqoXrGiS3nw6SjICxHXECqQFxmAJG/iSnJztUR3sRMtx/VCY+QWGJWZvZj2OvjB/0zGrFkhH0Z2fuwDwOf/rSox5hjD4sCRsfiC2B+3HhgGzjmmatnbGtzaE7F8cYPV/K/ifApU+1/gcarDfQ6ZyYEGVZ9I2ouTXXwaxEAZoy/V3ud++le8PyK63AM69QlrI3FI7S/5dYnIyXzWvdIHG/bPoWLKsHtnqIv/FIwJ9o6tzvdK5JfQ5v07mJgA1ZsVB5ClMEuroUSiLSS76HG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlRfQBa4He5YHVPp5nUgfPq6VOlBxYHzD6qgi87BtJo=;
 b=g3lfr5t1fz3BvNA2QdLcwb/anylS3ZsSaRMbGsZ9svgdMnFyxAVkhy/CF4KrHCYeaCxx9GbroNSzFSNsRt965WlGhrzElLBMD4xyqoNURUjCQiULhmvokXOwwogvDfwB4dwWIPX6PBkCpdXD0kfay7UyR/DYR2kmIgqcfKYvabus4gULbK5wHckivGeK2ulBhWah/UHGo8B8XzxnEb52Q/l46CmWB06ZxGa0MmGV+zcPaagPO3AHt4NDTaXlsspblSagfuaVo1+SktJD3cqugwvZrUqcH0t/vMJIjiQfRK5ljVTs2ScNq8J/AX8v47TIEskZYYkhccUFeSr15PB+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlRfQBa4He5YHVPp5nUgfPq6VOlBxYHzD6qgi87BtJo=;
 b=cMy4YE08E1ia7ANbQurCgbAStWzQ+244kCLvF8CG+hOIO8rDWYDedMwg8Pau5vGqKCxkEbT3LcjYx9RfANeiFB8Ubq6yKixMP91BFc0rCBbt5YRVUjDFhYB2JGNIbZphiQQu4UaT1ND5tYcx3mnqB7/+fJhHxzPRuHDFS7UVAxI=
Received: from MW4PR04CA0076.namprd04.prod.outlook.com (2603:10b6:303:6b::21)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 20:16:48 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::e7) by MW4PR04CA0076.outlook.office365.com
 (2603:10b6:303:6b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 20:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Mon, 20 Feb 2023 20:16:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 14:16:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd: Don't always set s3 for dGPUs in all sleep modes
Date: Mon, 20 Feb 2023 14:16:18 -0600
Message-ID: <20230220201618.25962-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220201618.25962-1-mario.limonciello@amd.com>
References: <20230220201618.25962-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0dcc43-8ac6-4a45-4925-08db137f64ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKlo2uMdkztXJi5/vnMPZrqMGlMf0Mead01kbI2Bc2Ac+WSp5ahxA+a0L46blkTgGBAT9xIWBwcnarPnMrF5u5VVFUc/2RFBli1TWaaH7SbRLFdsXe/rPxPjXiJrHsideNRRvHcki+H4oPc8b2h1n4EHvUscMAM/PjiQdb/OAVzA3L+s0Ie5AJAZFd0r5oSF7DQ/mqT39JHkzItQYQe6fh+qC8ym/qWiyPrVTUc0XO2luhTlechssr8xLVc0n5yRYtVtd7Iw6gzNnssexg6eQJ+Ed5o53EBRi0Hci/vj0nuRE1jc8c0yhERqqxsXuYDcb1+12N43u5aTeAhl70v1uk03uyNsYj0QHLYlSVmqWtUAJwwDy/JcnvrSjbMAIg2GzQiviHgvXVf7t7w4tv8AwojAk9xBZd8uS3DI6j2Pvepp3/ippH/XkWgtk2jEezVx/dUzJSZpCsJGqrBcT1IqlWkrquPfzpiNM5fTQuYLr3P0Wh9C251ZDSGb0wOvkgRDQL4kf6fG49JO9FGgiX6WhINRf6sDoj7rp8eQRVV5tZPZJIpdB8WQ+zXw4AzbPWx1ZZC3Lzquz9zrpm7sAwCPT8gPmMBScSSwSTlUbkNmYM0xgKmqLfHlCiaUr9qb3SYDXAKKUf8ODoMMFFh5Oq1q8mia4Wx+bUFRcri60LfVjyWi1v9iMzXmSqjlQsSeIyAEjnJj+dFyIyUKUcDpUywnMiSP08/W9OK+5XxG73NbF1Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(2906002)(26005)(186003)(41300700001)(356005)(16526019)(82740400003)(4744005)(1076003)(6666004)(44832011)(81166007)(2616005)(5660300002)(8936002)(36860700001)(40460700003)(316002)(86362001)(70206006)(70586007)(8676002)(4326008)(6916009)(336012)(82310400005)(7696005)(478600001)(426003)(47076005)(40480700001)(83380400001)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 20:16:47.6607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0dcc43-8ac6-4a45-4925-08db137f64ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
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
Cc: Peter Kopec <pekopec@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dGPUs that will be using BACO or BOCO shouldn't be put into S3
when the system is being put into s2idle.

Cc: Peter Kopec <pekopec@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 25e902077caf..5c69116bc883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1038,8 +1038,13 @@ void amdgpu_acpi_detect(void)
  */
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
 {
-	return !(adev->flags & AMD_IS_APU) ||
-		(pm_suspend_target_state == PM_SUSPEND_MEM);
+	if (pm_suspend_target_state == PM_SUSPEND_MEM)
+		return true;
+	if (adev->flags & AMD_IS_APU)
+		return false;
+	return !amdgpu_device_supports_baco(&adev->ddev) &&
+		!amdgpu_device_supports_boco(&adev->ddev);
+
 }
 
 /**
-- 
2.34.1

