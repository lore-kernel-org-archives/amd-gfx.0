Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014A0C25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 06:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C8A10E980;
	Wed, 22 May 2024 06:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vb0Z5XbM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E5510E775
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj3uU9qWuqmbbQOelJobc/1oo9BkzEMcjYKruQ5rCDtwwrQUYxqjUCgbWfGqqx4eF0Fh5n4G69LTcj7F2d/SxXdiORb1w3ci7o2MNUkXAZLTOb+aU4ZiWuyoGF6dVhDU52ff6Mx8ygKZffW8kqy2/Oe40BrIhkj9MpozIhKmu9BIi94TAXuEqQaH1nHV2tvBoz+9As2pt/te3i5FXQovT7SgraOOEplLBttfFm0YZneZquaYP9VHcQQEnVRvYCFIFmcGL1Jb9N9ERq3CGWVGUOlszA6hOl9KSXZfdPI4CDvDvNMOIz9ny2hbYMsi+Y5MfnHajK3LJ46fBN7hDs5rLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH15Bd4C7O/SiRyh04E8DOLiFL+NGRNGQ0zZlJG91Gk=;
 b=kwnnFWLJSD02Ukf4Ajr56dgqABYEAlpCi7DLBdW+TFciFvOkDA6VrhFHerg+dJg6Aaps/DeOdcKxoNVeVDtC8U3PV6GWmcYMygrn3zVwxY3CQYuBYcqzJXJd0FVzcKZvjsMEn4j2GyTM48Nt1jh0bSwmQTzIpsC+ZMiCLSun4qE5Bl8GurFeMowTZ4bRjFE7lawQLBh50OoWvFVZzZCgDQYsDm0hvKmwBZzDBfizEViPSBFPMPrW+2SHAagvMAFfdrnCgnF8NCM/b2gHz7tSLoDpE60tqYhD1NHS01DLreF5m6NrdOF9B2XGRLwJcIY/b2HS31A4qOJquseDRcdqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH15Bd4C7O/SiRyh04E8DOLiFL+NGRNGQ0zZlJG91Gk=;
 b=vb0Z5XbMadAj2LE2VMOYXe9Gh4rPaV+tSbZZXZ25CNHfu2iVsZToAWeoHeORUrL5ncwibgpHnN4YTnKBG+0ET8Ofp9R6CaUAzbKIie9bxkknlQXA1d/xJsIKra+X7EWcJs04ywdvHZ+GDRVSAg9Ws7JIv2QH7ab075VDBJzRvwA=
Received: from MN2PR02CA0010.namprd02.prod.outlook.com (2603:10b6:208:fc::23)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 22 May
 2024 06:31:09 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::6f) by MN2PR02CA0010.outlook.office365.com
 (2603:10b6:208:fc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 06:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 06:31:05 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 01:31:04 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 4/6] HID: amd_sfh: Improve boot time when SFH is available
Date: Wed, 22 May 2024 14:29:15 +0800
Message-ID: <20240522062916.705147-4-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522062916.705147-1-li.ma@amd.com>
References: <20240522062916.705147-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 559ca1d7-f5e9-4b36-1fb0-08dc7a28c275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yXVKNa4Y+IY9Q4AvF+fE3aCfj6ZxYl/1v+h9JACegbI98/yBA08Et+4lFrjG?=
 =?us-ascii?Q?m8VlsCDb4k3S5BPtFdN+XcUL6uJcf3yx79lFOKHWE/fBsV0+2L9Yus4rsEGA?=
 =?us-ascii?Q?JZCKtEJO4Qy/zxvkGAtw8A9I+FrLmiKXyD1mxzS6Jbasu1joR2IFxvE7kTvb?=
 =?us-ascii?Q?IIAI3sRX8eamQ+s8jOlcgCVxS+/vnClsFi424ixcKdgieZ38uI4NWUdlbCL9?=
 =?us-ascii?Q?iILDosTnpAqTbPUbmFCFq+ZRR9EL09s3EMMrM61KuqrT6qRE75oSJzwcIPQ8?=
 =?us-ascii?Q?c48ysGVaXPaiIRFgcaBDDIJN0SO1psZ+JrClDoLvIhqI/SanGhECsQN+PtNE?=
 =?us-ascii?Q?mqhdoIGc8WWeT6eV48BloOUomaw5JD71rBkvTjMqUijRX3ap4IwekHn1lbbl?=
 =?us-ascii?Q?OdRU/HVpogHQbuaNbHnGH+KoNOtEFO7HdeaCax+ew8qDL2Kr4uDVwzGrmY71?=
 =?us-ascii?Q?yJOc8Z8KbWArDTITMgtVcDBlTHqM+/dOweYuXkedzBE4+JYMXzlcv6rUmVW5?=
 =?us-ascii?Q?fTcTOTCq9vPe1c+7xaSB/Bmjv6/V2XiyOO/OX/405BjYNrAolRPcd2HNx9H1?=
 =?us-ascii?Q?JpM6PfoC7rW5bbsbWlTIEBVitCGVcJ59nnqpBGmdGectygjeUx/fEysUBHHP?=
 =?us-ascii?Q?Kkm/ottQU/mmNQJIDdAD1ZVOhxOkIKkCAj0GMN7k+nQDDDAPUQ5yHM5aZQzZ?=
 =?us-ascii?Q?UBx/oRQVN5LggaXhYYdyZufLoDH1uKLu2QuIR+AMQivAjdo75GlYgPF+V/0X?=
 =?us-ascii?Q?nIt7Ehy1eKOGER8fCp4PIO3S1opGZSZmJAbQ1+jjENR4LU+IVEEPsAQpPfQM?=
 =?us-ascii?Q?FAYxXeqV0azVZonleoVPn/0iqd8kMxIAr4+69j3VV61AgwEbRWp6qonZOjJg?=
 =?us-ascii?Q?E2YmWy5fAWeHxW5RXZa0G9TQX5ijKCCfNtHReL7YnJ14ZEbRH5uhaB/c3//T?=
 =?us-ascii?Q?WkRfytVYmw1yVMv5mFW7YSmIIvccrETZZaTIweUzuSoagqUpkI3H+Bwq6z9a?=
 =?us-ascii?Q?aZrznKblgaTz0luv5JtaQnjcP823g3kxFY5bJSyji63OKlzLaCPvgWy8xKqn?=
 =?us-ascii?Q?QXFys0t9xDLLP+2Gv7kOErgOzh9yTIRIkF8Beqa/DR5oSPbsSM1o5rSO2LcR?=
 =?us-ascii?Q?1dbYR4HMH6dL6MvVg4KZMobqFMayxJuFLtpyJcd7y0gmQuF0Ve5HP5Ym4B3K?=
 =?us-ascii?Q?GmfTFrNI3ZCuqitA9Q4n1GFvk6J1W/FLtZOLubgEZVKshzb3fd4++uNQDhKL?=
 =?us-ascii?Q?5IjfH/HBplqbgejZNrIMlqe2fOW8s6hgNUXWKyFJGPU27TvY2G8azv+5jqTX?=
 =?us-ascii?Q?qR4q0fAFN+8tojx1JTTd1hsSLZGduym5QtqkljEnpc0f9ZWIsIpv2fH2rIkC?=
 =?us-ascii?Q?I3VDxLfmBIvUw94GflOj1NSa7Y2k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:31:05.9035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 559ca1d7-f5e9-4b36-1fb0-08dc7a28c275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

AMD SFH load takes longer time in initialization. Hence split and defer
initialization code to improve SFH module load time and boot time of the
system when SFH is available.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit 2105e8e00da4673266e217653292fef6acefde03)
---
 drivers/hid/amd-sfh-hid/amd_sfh_common.h |  2 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 75 ++++++++++++++++++++----
 2 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index a1950bc6e6ce..ef5551c1eec5 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -53,6 +53,8 @@ struct amd_mp2_dev {
 	/* mp2 active control status */
 	u32 mp2_acs;
 	struct sfh_dev_status dev_en;
+	struct work_struct work;
+	u8 init_done;
 };
 
 struct amd_mp2_ops {
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 8c1809c7d1f7..495ec1179ee5 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmi.h>
 #include <linux/interrupt.h>
@@ -329,6 +330,48 @@ static const struct dmi_system_id dmi_nodevs[] = {
 	{ }
 };
 
+static void sfh1_1_init_work(struct work_struct *work)
+{
+	struct amd_mp2_dev *mp2 = container_of(work, struct amd_mp2_dev, work);
+	struct pci_dev *pdev = mp2->pdev;
+	int rc;
+
+	rc = mp2->sfh1_1_ops->init(mp2);
+	if (rc) {
+		dev_err(&pdev->dev, "sfh1_1_init failed err %d\n", rc);
+		return;
+	}
+
+	amd_sfh_clear_intr(mp2);
+	mp2->init_done = 1;
+}
+
+static void sfh_init_work(struct work_struct *work)
+{
+	struct amd_mp2_dev *mp2 = container_of(work, struct amd_mp2_dev, work);
+	struct pci_dev *pdev = mp2->pdev;
+	int rc;
+
+	rc = amd_sfh_hid_client_init(mp2);
+	if (rc) {
+		amd_sfh_clear_intr(mp2);
+		dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
+		return;
+	}
+
+	amd_sfh_clear_intr(mp2);
+	mp2->init_done = 1;
+}
+
+static void amd_sfh_remove(struct pci_dev *pdev)
+{
+	struct amd_mp2_dev *mp2 = pci_get_drvdata(pdev);
+
+	flush_work(&mp2->work);
+	if (mp2->init_done)
+		mp2->mp2_ops->remove(mp2);
+}
+
 static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct amd_mp2_dev *privdata;
@@ -367,10 +410,12 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 
 	privdata->sfh1_1_ops = (const struct amd_sfh1_1_ops *)id->driver_data;
 	if (privdata->sfh1_1_ops) {
-		rc = privdata->sfh1_1_ops->init(privdata);
+		rc = devm_work_autocancel(&pdev->dev, &privdata->work, sfh1_1_init_work);
 		if (rc)
 			return rc;
-		goto init_done;
+
+		schedule_work(&privdata->work);
+		return 0;
 	}
 
 	mp2_select_ops(privdata);
@@ -381,33 +426,34 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		return rc;
 	}
 
-	rc = amd_sfh_hid_client_init(privdata);
+	rc = devm_work_autocancel(&pdev->dev, &privdata->work, sfh_init_work);
 	if (rc) {
 		amd_sfh_clear_intr(privdata);
-		if (rc != -EOPNOTSUPP)
-			dev_err(&pdev->dev, "amd_sfh_hid_client_init failed\n");
 		return rc;
 	}
 
-init_done:
-	amd_sfh_clear_intr(privdata);
-
-	return devm_add_action_or_reset(&pdev->dev, privdata->mp2_ops->remove, privdata);
+	schedule_work(&privdata->work);
+	return 0;
 }
 
 static void amd_sfh_shutdown(struct pci_dev *pdev)
 {
 	struct amd_mp2_dev *mp2 = pci_get_drvdata(pdev);
 
-	if (mp2 && mp2->mp2_ops)
-		mp2->mp2_ops->stop_all(mp2);
+	if (mp2) {
+		flush_work(&mp2->work);
+		if (mp2->init_done)
+			mp2->mp2_ops->stop_all(mp2);
+	}
 }
 
 static int __maybe_unused amd_mp2_pci_resume(struct device *dev)
 {
 	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
 
-	mp2->mp2_ops->resume(mp2);
+	flush_work(&mp2->work);
+	if (mp2->init_done)
+		mp2->mp2_ops->resume(mp2);
 
 	return 0;
 }
@@ -416,7 +462,9 @@ static int __maybe_unused amd_mp2_pci_suspend(struct device *dev)
 {
 	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
 
-	mp2->mp2_ops->suspend(mp2);
+	flush_work(&mp2->work);
+	if (mp2->init_done)
+		mp2->mp2_ops->suspend(mp2);
 
 	return 0;
 }
@@ -438,6 +486,7 @@ static struct pci_driver amd_mp2_pci_driver = {
 	.probe		= amd_mp2_pci_probe,
 	.driver.pm	= &amd_mp2_pm_ops,
 	.shutdown	= amd_sfh_shutdown,
+	.remove		= amd_sfh_remove,
 };
 module_pci_driver(amd_mp2_pci_driver);
 
-- 
2.25.1

