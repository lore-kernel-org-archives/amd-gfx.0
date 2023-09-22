Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F973E7D0C9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 05:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A533010E288;
	Fri, 22 Sep 2023 05:46:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5871E10E288
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 05:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhwBy5j5lu75irvC3XURkBs8+/H5z7cPWaqFPlqlgs5t0EnqdA4VPVJz0cgr2OgmT5IBn/BQAOaKtZ8x3/bNerfgUut0xRTzjgenPDQc4i1xAlpGsKvG03XESV+3o/CJq3aib5OtSYRiTM3GtWvVcnq1B5AdwKXTb0Jq9QiKyLP2PtrbtEojZax7yUn/WH4QkX2RvFnHWDEdTxBB5rieu6KmnmtEQuPXgPGZ7sQJHHMfKj1P2HjCAcq1/EqX9CRIXCQgSsLf5kDgFENZIjpkK7clFrjEFuytm4pf89u+8Uk4o0wmC5fE5nEbfnKqTcTeLpEPBkI917AvhSPk10lWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvpgxmpH0lSd3jliP8pbByn5+SRE4JkFPkC1GoMyfI8=;
 b=Rkr4ttoAP7WSPZc8IZ8RNuefJGorYinWinPQ57vAZTLoNFdr1Xl3wXEDjMIEJTAHVfF3DXHynSPLNI57qzl+7NB0+AepYOL6LTW36opLWsPnAXnYQ+Z+8EOr8OYQzCbf2DERKxVztcv8/GZkDBhi6upQRjVglDD7fFFofC3dcxvHXrMH74eHVPTVD8/blqjOjPIIpQAoTanF6yh6Eq7XEcFVCAKZv2z/N9wAvj1tyDdvL25HNw8ggsEVM/cZ4kfsaekN1CTgrHQGnM1RwetsQdiTWPxbGamTri/3Fx+Ez5ixrSbznlJlXoI8M548VQCUYtF7z5nifGkcXPPHpif5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvpgxmpH0lSd3jliP8pbByn5+SRE4JkFPkC1GoMyfI8=;
 b=FFp1zidScpAdAlnQxJoLeLycu5wCunfMnYJ9F7SYEWI1bKC+lpQpgZaofmP+g3XgD9aZzf9xQiTPpT7woPs6BW/UnyjJYD9nRAZBPsXwWTpcW9UfWr50KHBhQHs5+bW1qd2csphRIYqWw5FRwuRYlehGXOhVREgm/Jx3wOVgsI0=
Received: from MN2PR15CA0034.namprd15.prod.outlook.com (2603:10b6:208:1b4::47)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 05:46:20 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::cf) by MN2PR15CA0034.outlook.office365.com
 (2603:10b6:208:1b4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Fri, 22 Sep 2023 05:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 22 Sep 2023 05:46:20 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 00:46:16 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Lijo.Lazar@amd.com>, <Le.Ma@amd.com>, <shiwu.zhang@amd.com>,
 <ivlipski@amd.com>
Subject: [PATCH v2] drm/amdgpu:Expose physical id of device in XGMI hive
Date: Fri, 22 Sep 2023 13:45:55 +0800
Message-ID: <20230922054555.838605-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BN9PR12MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 537c2bc2-99a2-4ce5-0c05-08dbbb2f3f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPYhLf+X41oAbM7jdMswEGmEDFcaxktJbXej5xJ8Ivdl3hcr6BqrB5oeKa3ZtLEJPV25zlOrfbPQ5+SbvPc26p6+yzEor/hny2H4CdbSupfqq/ct7Ol2ZdU8R/pUwkc7XDoEpMwTs4ZcIxwIS0H1aJlkTJap3IpiUukjdT/15LKrORBUS3vCdHPbcLR4vGPGsVoyHXPugPOrkQvhy73Oz86kt/C5gUPggvTxqFqQ+5/rPl2Kfl6KwZrL8Whv38V0e3broA3gTx/lvx9/jvRRZvWBXI7XnDYyVjv+T3TO9qOyVFTDMEaQXu1bKjxGbwIo8HU5eWeQjbpLTRHiQqQfKkNpI5hpROVsjkCtf4C459f4a5zSgTvf1tmPnRirvCWtVx5UzP1m2vC98fNcaEhaBwBa3FNiZgb0aPZG6e45dwq07+ehxOJxXU+Vvghq1sd3B95LRJEwAq1w/RO8mFtvyP5qGCE4RehgH6xi/CKVa8zT/zktaoKFBOX1v+Dn6MFruBl9WQ3G4HKjihoHSh4fu74mMxpizOSfNH39z3B5AdSt57uNNH6d848JvGDZm4q5PLzbtkjkj2g4jY9Leb+chbvKV9TtxLkAKBctnJDEJUy3NNZ9h3u/AB8sl3ZBtvWaBObG0gXs8Bolg9T7unqqnsNMwgaAc0z8U3QDD8u9oWJReF2oezF5XGxRYU8K5/qpUThOG5wWuNHdX5CJnwZItaZovfmZZsWE0gpZypAvohVilAhhKLb4QKNgFcsRdSVFD78etvEZzyfViHe1y8WnRhEGh3yNyBTyQUgj468gZAzta29l7PyMqMD4WRkvv9+4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230921699003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(47076005)(40460700003)(478600001)(86362001)(41300700001)(36860700001)(5660300002)(110136005)(82740400003)(4326008)(8936002)(2906002)(8676002)(54906003)(6636002)(70586007)(70206006)(81166007)(316002)(83380400001)(36756003)(26005)(40480700001)(356005)(336012)(2616005)(1076003)(426003)(16526019)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 05:46:20.0034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537c2bc2-99a2-4ce5-0c05-08dbbb2f3f28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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
Cc: Mangesh Gadre <Mangesh.Gadre@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad Kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This identifies the physical ordering of devices in the hive

v2: fix compilation issue

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 061534e845a7..02770c632bac 100644
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
+	return sysfs_emit(buf, "%u\n", adev->gmc.xgmi.physical_node_id);
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

