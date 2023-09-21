Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97879CD4934
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 04:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4C310E462;
	Thu, 21 Sep 2023 04:36:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC7B10E462
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 04:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc1K1bRgxQQkE00GYZn/wLrLG7pREcJaFexX4cCsC5EJqoUn90VyeSPEdBDAgsaJ9fj2bghXIj2XzXpQNzzY7JOZa6IrAefJdfi9kp4/PgMP80suEMPKeex4ekFzCVHJcfYKIgDMia0IG48mlwPlw7+PkRl8dqDwY5pg5rZysO/cuz8aO1NXgETUndiP3qxKnBxbjG8aihcaoDWVrNhhv+Rs0oleC1gZcZJWVCgfQXS5QONX7fQ6OKFByIeZaqhyoocFQbDhZYZcSx7tfwzp+KbSix8GYns+UegjrNO8Kl/DXX3cAK2gQbd+E/DK6WdPVy5UDogHIevbemG6FMFLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7v+PEGXEIAuaTLxTfpbtUuy3I+u52L5mNGk2EwQ78Q=;
 b=SMJvkrYX0kL1ptFcWUWLxNGL46O8tZsCsjSIDVdALbz9G6wvbqRI4cMEcmPKN25WPYp0rmoQSUD7F5irLvliSsuFF8oFxI1IOE/XO7di0g5qxmlp9CX5bhKX0t8UCzaTN8GM8OArK0F0bymTsxMSgWkWma6BQvdJKXYA7QHruIhbalUQMROxq2EyLaD+xpl/35obc6Y+UrIXyvuu+zjHNvEwI87hEpWXO4fpKXLacmUKD/DhSUMjTSUBHGcsNT+8D9ApHOXDS4G3lQXaj2VhDeaiS8rSzLws0t+QDRcNM9OreVzVfU7ql+3loScVswIraWUuH4wPt9fE4YJIwf6Wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7v+PEGXEIAuaTLxTfpbtUuy3I+u52L5mNGk2EwQ78Q=;
 b=BUp7rDDWGEgJDdEr/Ty92/RGjb68E0/LKpNmUXyeTTTSMuRcp44+pGsto6uYdTBzbhw+ajsHTzhiiT/K7ReElDFB+YT0yLba71a90S991iYRVrORt1K1ivnWZVSeja6mtJv2Uwdz9P1UzBcAyWE8qcejwkCAYqzLdA1L4uTY4ZA=
Received: from DS7PR03CA0144.namprd03.prod.outlook.com (2603:10b6:5:3b4::29)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 04:36:26 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::65) by DS7PR03CA0144.outlook.office365.com
 (2603:10b6:5:3b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 04:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 04:36:26 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 23:36:23 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Lijo.Lazar@amd.com>, <Le.Ma@amd.com>, <shiwu.zhang@amd.com>
Subject: [PATCH] drm/amdgpu:Expose physical id of device in XGMI hive
Date: Thu, 21 Sep 2023 12:35:51 +0800
Message-ID: <20230921043551.3903891-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d36622-dd1e-4764-d066-08dbba5c5119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smbA2YM9DZQdoJHq3+yHqtSurgqugVScOGlDjPmCcXg0y36hmO3IlMHYt6Qg3wUiXoWLMl1IruxS9OPcaORCkmVQeN/MKke99mdVBQou0hhk6rrz/Pci2a+viuyw0B0kqwazxXKppnh2J0hUfBFtlklpfA7cSCr5uCvnHpE2YMz880ONaMun1BfB71UHux878Y7tj2++ZQ3hMKBU7Paa0ZCIvuaNihqyLSWPZURl5Q6qBW12csbX0cGQEGklF4oQwBmvydqiZmKzsyx/C4zyH1v21YVjHAEUTsNxP7DaGECH8hHaxyRHJPhcECxkEbb7BMArHATrMNBtStobWgAqSSAQh+pKnXeTPtI1isb/XfYpgMwqrrTL6jRYeEX9yiPsg3BhXv6KhUuhkyOLZVa729g5GCx/ZQvx0ErPiexPIwaG8tfzRT+jPvOW3KUHmzEx/Q4s+MrBQomdsNNBy8+DKpNXaAiCJ/RQIC6yjJrgNKywfgAafNhDnWC2Zi1yx4QdvuFXC8MEQGDYXjriE+sDuQIxmHzGQr0lDxDOlFwtPYRsTrg0Nx86gOiKfso4OzBPtwMP/ocbjwuYuru61o8CZpxHXwaBPkDZPj/CU+HOq7xs74UvdiXyko3DFPgiSr2NSqvy/7JP1/a8vT0L7/gmS/e/33Wv2Rkn6a2uc1hMSPcNBaOq4x1izxqLv41LFPkZXosmjuxt97w7lYX2MA3KQBX0LJrW/J8EARo82xxlrC1XXAPWhibGwOoTuE0OwEAtzljc/cvhFDa29EzXlRS2Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(1800799009)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(6666004)(7696005)(478600001)(83380400001)(426003)(2616005)(16526019)(2906002)(26005)(47076005)(336012)(70206006)(54906003)(8936002)(70586007)(6636002)(316002)(110136005)(4326008)(8676002)(41300700001)(5660300002)(40460700003)(81166007)(36860700001)(1076003)(86362001)(36756003)(82740400003)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 04:36:26.2367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d36622-dd1e-4764-d066-08dbba5c5119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
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
Cc: Mangesh Gadre <Mangesh.Gadre@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This identifies the physical ordering of devices in the hive

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 061534e845a7..4cf38164d72c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -325,6 +325,17 @@ static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
 
 }
 
+static ssize_t amdgpu_xgmi_show_physical_id(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%llu\n", adev->gmc.xgmi.physical_node_id);
+
+}
+
 static ssize_t amdgpu_xgmi_show_num_hops(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -390,6 +401,7 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 
 
 static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, NULL);
+static DEVICE_ATTR(xgmi_physical_id, 0444, amdgpu_xgmi_show_physical_id, NULL);
 static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);
 static DEVICE_ATTR(xgmi_num_hops, S_IRUGO, amdgpu_xgmi_show_num_hops, NULL);
 static DEVICE_ATTR(xgmi_num_links, S_IRUGO, amdgpu_xgmi_show_num_links, NULL);
@@ -407,6 +419,12 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 		return ret;
 	}
 
+	ret = device_create_file(adev->dev, &dev_attr_xgmi_physical_id);
+	if (ret) {
+		dev_err(adev->dev, "XGMI: Failed to create device file xgmi_physical_id\n");
+		return ret;
+	}
+
 	/* Create xgmi error file */
 	ret = device_create_file(adev->dev, &dev_attr_xgmi_error);
 	if (ret)
@@ -448,6 +466,7 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 
 remove_file:
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
+	device_remove_file(adev->dev, &dev_attr_xgmi_physical_id);
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
 	device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
 	device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
@@ -463,6 +482,7 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 	memset(node, 0, sizeof(node));
 
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
+	device_remove_file(adev->dev, &dev_attr_xgmi_physical_id);
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
 	device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
 	device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
-- 
2.34.1

