Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E03CC64EC7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 04:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D5210E1FD;
	Tue, 28 Feb 2023 04:43:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCFC10E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 04:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDun5c0zvaVx12xGmhRw7NJjMOjT5XKkpe4n801DlyHetHGkcMV25AhhSo8NKnCMW8gccw55a4YD3qN5LrpYwlofnFQl741PyECII1YKnYcwSptF/rgpq3Uq5bIvFxnohVLpH1wLvsx8V6JuxH6VlrNFd5OEm0nh9ybPdtTLQk1w83DiqZ4uBsqNaLqv8wqWmEhg4eDIRtP97MnkBhHlrAIU7FLTIohxkT0PeYhAZvBT8gLRGxnndenef+awCv5JfjbrP1WeSmyPNtcDgJ9uPTMbXEGRvFWTcKi5fB8ZQ9oElx93NL4nn/y7VGBQ0LzoQvzrxWrAnxDf0qJg0FPC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb7n5v2TE7C98RNd0l4nGtlQFA/viQ7iHqlQZbz7AR8=;
 b=kOpv6P6PCPIoW8j9Dg2Vy7pwenFuqRiH2Gbuji0VvqhxIKww8clQurJ7fjWOfXbZ8GvUVuwnszZKe57WaYLJtaV0xcmptlCOOVzpGmMtkRs/aZYq4gmtUhXn2ZKdtDTz/NAiA7/iURYqHHC+FLcPV8kAaa/lGJTPYiYi4uE6ov0PYshTiQMvJiD86E8ot5kcmpTBhaEzVML2MvCwnDyh6nG9IeZMoI4smOwWtSGkUunESbOhZyn5+dzhEZT+s70x5ftj9NgvckCA3arrUyPIfbHjK9JHbikgMDAv/NKFC0AkOel1Ye6zj7n4fZubRUHdlGN8o5HNPmuFAT7ZJuXsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb7n5v2TE7C98RNd0l4nGtlQFA/viQ7iHqlQZbz7AR8=;
 b=HPz/up7FwVj/KsC0C6h7VTVnXsFCHFkHJtledk8nwj6eNxIyUyXVRh6OAFzGS2qtuojiyr+W0bQrLPuYrfZtcy4LQ47xQE215GBrsXgin3EuhJ7LP0Ph9t75zEo9Hghr2Djmz9KvwRPiB5YrSp4YM4IEvBFrTaU7UrPv2qQVSYM=
Received: from BN9PR03CA0407.namprd03.prod.outlook.com (2603:10b6:408:111::22)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 04:43:27 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::b2) by BN9PR03CA0407.outlook.office365.com
 (2603:10b6:408:111::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Tue, 28 Feb 2023 04:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.14 via Frontend Transport; Tue, 28 Feb 2023 04:43:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 22:43:23 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amd: Allow dGPUs that support BACO to use smart
 suspend
Date: Mon, 27 Feb 2023 22:43:02 -0600
Message-ID: <20230228044304.27940-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228044304.27940-1-mario.limonciello@amd.com>
References: <20230228044304.27940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 1036e6a1-3d63-4956-128d-08db1946551b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61K3ED8g7wlD8fSj3Ov5LzwV5XQuE7pDwlIXaHjfXmtLryMb/ofJSSpJYs9sPuCLiUO6oBeEjWnsna9F7wndGIbEK6bXxfJ3Ls7mkaEkVEmMqfhpGObzGkyT51m58mk6i+/dpYrQ9YrdwFt7gYqYEUTK4a3jvw39zE++d1nK/JyOSxP7eXS5mOiPTFDdqE+e/0H0sjpJuGX6qS0PxaJ9Bg49Kaz0r30VrqoIlzTbFRhsDetreEm9HDSfGBrIaNiUEUHC9UVUEpityDE3CFFFEdMliBXZqLDUcH642rtdHP1LmQS59z5dMvRs5rYuRuoB5PaBUG++u76dYpzFgO24ptK5lWpx98KDEDD37vlNujoxD9gZy8xNsW2wyczFhjiX8VxRtkCHtjVCZjijARTYZnEP7wFScQHt1smWShANTnTeTn45ASN5zeQYPZXKQ39lpGKk0jbsdJk8v2rLMedfPvVwhQRTGOSTAaPHi2ADaYtOHd+NZ+9My3mZhxoFmps/ZmsqYpHWLp53kcQKoG/pVlE+9pYmX6/sy5ayfRKz3erqM0R+UR6GFhYXlY16VTFqlw/yX0nLXBPM6SnK3iL6vMQO4sjIvAAWEvYu4I2s/GttqT3dk8k+xKRiBcaTzIpTVwm4ricx7zWFOCW1y2rMeXjBehOt3vGKw//xkLRDzwHwc16S8GV3IXwXFo5fAhaVLVBVNzeF5jA54Uxn7ISJ47ZRjbVXwiQN9xlSVfiRt94=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(47076005)(426003)(336012)(36756003)(40460700003)(54906003)(316002)(86362001)(356005)(81166007)(40480700001)(36860700001)(70586007)(82740400003)(82310400005)(1076003)(186003)(6666004)(83380400001)(26005)(16526019)(2616005)(8936002)(7696005)(2906002)(5660300002)(478600001)(4326008)(41300700001)(6916009)(8676002)(15650500001)(70206006)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:43:26.8831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1036e6a1-3d63-4956-128d-08db1946551b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
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

If a dGPU is already runtime suspended using BACO, there is no point
to waking it up to run regular suspend callbacks.

Cc: Peter Kopec <pekopec@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Simplify prepare call
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 32 ++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e11f83bd1653..750984517192 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2190,8 +2190,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		/* only need to skip on ATPX */
 		if (amdgpu_device_supports_px(ddev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
-		/* we want direct complete for BOCO */
-		if (amdgpu_device_supports_boco(ddev))
+		/* we want direct complete for BOCO and for BACO */
+		if (amdgpu_device_supports_boco(ddev) ||
+		    amdgpu_device_supports_baco(ddev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
@@ -2384,25 +2385,24 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 	return;
 }
 
+/**
+ * amdgpu_pmops_prepare
+ *
+ * @dev: device pointer
+ *
+ * Run the "prepare" PM operation. For devices supporting
+ * BOCO or BACO use DPM_FLAG_SMART_PREPARE to skip rest of
+ * suspend process.
+ *
+ */
 static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	/* Return a positive number here so
-	 * DPM_FLAG_SMART_SUSPEND works properly
-	 */
-	if (amdgpu_device_supports_boco(drm_dev))
-		return pm_runtime_suspended(dev);
-
-	/* if we will not support s3 or s2i for the device
-	 *  then skip suspend
-	 */
-	if (!amdgpu_acpi_is_s0ix_active(adev) &&
-	    !amdgpu_acpi_is_s3_active(adev))
-		return 1;
+	if (!dev_pm_test_driver_flags(drm_dev->dev, DPM_FLAG_SMART_PREPARE))
+		return 0;
 
-	return 0;
+	return pm_runtime_suspended(dev);
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
-- 
2.34.1

