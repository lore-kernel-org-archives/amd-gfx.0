Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23D1C7EE25
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 06:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C01B10E58C;
	Thu,  8 Jun 2023 06:51:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E42BA10E58C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 06:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWkC3L7r7Tu0w89VUhGSGsTptOZJ3QouN3Oo0L4QWcftsG0mkfLeNaV+9wLJBidwrTIc6RtsL0o8s3v6VKFYuDIXrD7sU3e3M4YeNHhyYABlmgIbNWy2XNSp30bSm7ZW1PiCj6z/b0gVv/W2Am+gWzsY5V29nUsHTE0qhxWA6/YiquFn/Mo5XPgf28YqLMxnGMPWMVzLhc5XGj3X/M2TGWDtGITQrNzL9isiGFBz7wyS58+m+rq2vNLLxCtHd2RzDP7Ny1F0PU6Vi6OWIeUbw/PPVXnsX/73cZec8H9WnYGc5zq91/IeySogYU53VBFBQfQBNE06PCj1wayeBAvY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw+/1Fow+zfknCT6N1dCq4JPQPvQHg7dsz+LRQaCbtE=;
 b=WLieG7iAOoyJdlqHBMDg9/dWZAQ0IcZw0e8JRohgJ0A2mjO/nf2Filh8GD158iNUZyk1/tY4pyz6866CLj3DDynFdZSD9ah6x6A966GW5/Ol2czhsP5c/bVSUNFGaoSyBqCG8URH9+QnjwiGTdl7TIjweb+qre+Df9/DIE4wsYvzTsCSPrqLKtvmnSNtcaM6dj9W37aAyd0onOmYs+LEm0V6m57R1h/lGlCjWfPYPX66Q+OLkzYXdpmFYzAsXz16SDjDxDiEOmn+6Up+NF43914aBlcSj/h3uKaW3LMdG+jac4ak7hiC9LUSUHH6Tfd03T+4gGgyN8lqotcBXdBKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw+/1Fow+zfknCT6N1dCq4JPQPvQHg7dsz+LRQaCbtE=;
 b=JgNg40mrZJZPhpi2T2K0vZCbb//Xu+iddQLOLRUKeTcbeKt9thMDKUXnQHFAHv0ZsfmcCqG5kKlWes7hS2qHlGZLzY/Qi7DWqhpJNHtsU3rrF3AzaoNCQw7aO/HsFa3zrO+I/R5Vf87UufJ3qz+UucmP4JWdXhEk0NLOf7Cmw5c=
Received: from BN9PR03CA0199.namprd03.prod.outlook.com (2603:10b6:408:f9::24)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 06:51:47 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::86) by BN9PR03CA0199.outlook.office365.com
 (2603:10b6:408:f9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Thu, 8 Jun 2023 06:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 8 Jun 2023 06:51:46 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 01:51:45 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: expose num_hops and num_links xgmi info through
 dev attr
Date: Thu, 8 Jun 2023 14:51:28 +0800
Message-ID: <20230608065128.27922-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1993c3-4473-4f87-bd05-08db67ecd3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqrmp7BOYby5YoaUIAyvi320zcNDDDy02z2p+NNC8EO1ZInt6iwUSkM/aK/CsiPSVVrQdqHtQdDMmkjGWaVey1cw5SVUTabHuEq3JXOX5SmsJyRBe/UsX86xp2fZxxUX/4W5dwJUa6zcmo6hi3K/0iy97x9J4p41kwWDwDvfKCiD15M7N2MxjncH+LKiSEuuPglTN6TJIS8D5LeAazp7WgxSON3Z10Rs3wLQudR0sh7o/5bM06MKcBoWDrbiiun96zJSUa3I5GedVO4m6sjWB2FAERcS4nnT1iwuu+M7vt443NVpRHeFMQ0mLfWao10ka7Xd1RChs9ZboKZZUyEmFik/Pf9VZIg2jV5jcrhjZ35n50CO4u1r76rDKFVnQHD/0FJyCQiGAuasVKQ2W+4QOE46o44vXLjVq6NuTkG0PyhtvafKZRakwmVUkYoJGQ9xJ83r9x6QTAji/vDwzrlnhC1IJd3utvG6GnulG/QB2tbA5cagZAzS8hOrh1UBrFOJG2+VKEXKjVRtpTNUrC57LjWDqYGd+V7O4IwEjsCsGRPPkyPCMaXDrszj8dihEuJV6q5k01Wn6TDNIw4myAQRrTSKgaTW7vBqGP2M2j7PScYMaZ5YEj8wifnj6QuztMfyW/vSKiOqZ8qLFsSyxrkYC5pe3xKoe7dxhAZiEyvDnJNmVsotTXKJvWlSxc6i56BrRGzHCiHB9BDQh7o7C7eYHSXZ7D6nf5E8linQdFUqpq1wURFKXjmu1uY5RQRhS9Rx9XNh0PieHZz3TnmkNjuC9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(44832011)(40460700003)(5660300002)(356005)(81166007)(82740400003)(186003)(16526019)(82310400005)(1076003)(26005)(336012)(426003)(2616005)(47076005)(40480700001)(478600001)(2906002)(6666004)(86362001)(7696005)(36756003)(70206006)(70586007)(6916009)(8676002)(8936002)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:51:46.7776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1993c3-4473-4f87-bd05-08db67ecd3e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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

Add these two dev attrs for xgmi info details which is helpful for
developers checking the xgmi topology by catting the sys file directly.

Take 4 cards with xgmi connection as an example, get the num_hops for each
device or node through xmig_hive_info dir like,
cat /sys/bus/pci/devices/0000:41:00.0/xgmi_hive_info/node1/num_hops
will return "00 41 41 41" where "00" stands for the hops to node1 itself
and "41" is the hops in hex format to every other node in the same hive.
There are node1/node2/node3/node4 representing 4 cards in the hive.

The same for num_links dev attr.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Acked-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 44822dd98e5e..9c0fc23ed5b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -331,6 +331,36 @@ static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
 
 }
 
+static ssize_t amdgpu_xgmi_show_num_hops(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
+	int i;
+	for (i=0; i < top->num_nodes; i++) {
+		sprintf(buf + 3*i, "%02x ", top->nodes[i].num_hops);
+	}
+
+	return sysfs_emit(buf, "%s\n", buf);
+}
+
+static ssize_t amdgpu_xgmi_show_num_links(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
+	int i;
+	for (i=0; i < top->num_nodes; i++) {
+		sprintf(buf + 3*i, "%02x ", top->nodes[i].num_links);
+	}
+
+	return sysfs_emit(buf, "%s\n", buf);
+}
+
 #define AMDGPU_XGMI_SET_FICAA(o)	((o) | 0x456801)
 static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 				      struct device_attribute *attr,
@@ -367,6 +397,8 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 
 static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, NULL);
 static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);
+static DEVICE_ATTR(xgmi_num_hops, S_IRUGO, amdgpu_xgmi_show_num_hops, NULL);
+static DEVICE_ATTR(xgmi_num_links, S_IRUGO, amdgpu_xgmi_show_num_links, NULL);
 
 static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 					 struct amdgpu_hive_info *hive)
@@ -386,6 +418,15 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 	if (ret)
 		pr_err("failed to create xgmi_error\n");
 
+	/* Create xgmi num hops file */
+	ret = device_create_file(adev->dev, &dev_attr_xgmi_num_hops);
+	if (ret)
+		pr_err("failed to create xgmi_num_hops\n");
+
+	/* Create xgmi num links file */
+	ret = device_create_file(adev->dev, &dev_attr_xgmi_num_links);
+	if (ret)
+		pr_err("failed to create xgmi_num_links\n");
 
 	/* Create sysfs link to hive info folder on the first device */
 	if (hive->kobj.parent != (&adev->dev->kobj)) {
@@ -413,6 +454,9 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 
 remove_file:
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
+	device_remove_file(adev->dev, &dev_attr_xgmi_error);
+	device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
+	device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
 
 success:
 	return ret;
@@ -426,6 +470,8 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
+	device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
+	device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
 
 	if (hive->kobj.parent != (&adev->dev->kobj))
 		sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
-- 
2.17.1

