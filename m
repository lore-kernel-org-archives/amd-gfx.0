Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9ACC6FD1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 10:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DA4112631;
	Fri, 29 Mar 2024 10:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A02DO3S2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F39112631
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 10:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ubj7xOcstu/IY3DjHYjxu5gLcbWrV032pJayaDEksTifMgSf061h7R+eWoVFU1AV2C4rCv8hmZdMv3MAeAKcJJB7h9Xm1s1A56kiu7M2hxmx15QeDEA/O8sqem+ymbuNhzJUYL2FYulj4bpz2xj41Ou26QIvSDwtrFThIIzBxGrAujMMD3cxTyYH64SHubegBC39ZKi67z8QmSkR29YjMtVdGyq/M9fZEfQ61lMCrOKU+PZoBoQq2iOn8k0Aa7auiOC4lzZ7V/aiQ/bP/dApQIIx83p8HQTCNXJkCPuGbzaa3+ZWE0zSKTOsPqfvL9Mb4mqX+YCNS+rqzYlvlhb/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J43OW5YfnBKEkllfyW59Yii40FlrCpJO3nPeccdnBgw=;
 b=Je1Rp9OM+GorVMIkQat1Vr5MkF7pApEJJCRs96TdjHODXQdfS/jmt9qNhEPVEA6Xva18Va8C8mc5qyxrmJudUpDywBpS9zD3h+OedFxh/A129EtIgV8wAyZIKLws6FzombJQ7Wm6o02jKskMUc0hXMoCZZPR7ZotZFJa4L96mDI8kkEDK0IF09eQ50LDYzHU9Y2VdbwBJ8+RkwR+jKRHEP//tEZeg6KFdiIY7pACWZvfi39f/RnmPwq1VrhaKHetxFH9wKfRsF6iN0DtC7lgeuOjdk7fJlMpM9f+30Hd8gbohbVZFNY6GRpYpD6XFcYAPJGi1Obvz7Ttug7nHsYsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J43OW5YfnBKEkllfyW59Yii40FlrCpJO3nPeccdnBgw=;
 b=A02DO3S2QrlT14ITtMaELgBrKCp5AVG3vVfvx4CLf13wgi6NUecDApow6OrHfEwTCi98ytMGCIry+uRFv10t5TwU4rAuuutMjbSFSWmly5F1Bl53qcYPQhkOQoUGmMsz8oTWp9ZdPaJkhxd21hFV1zRSSYsrqXq9U/4vNmqmlWk=
Received: from BY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:a03:1b8::15)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 10:21:00 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::90) by BY5PR17CA0002.outlook.office365.com
 (2603:10b6:a03:1b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Fri, 29 Mar 2024 10:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 10:20:59 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 05:20:57 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <richard.gong@amd.com>,
 <yifan1.zhang@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 7/8] HID: amd_sfh: Improve boot time when SFH is available
Date: Fri, 29 Mar 2024 18:17:49 +0800
Message-ID: <20240329101748.3961982-7-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329101748.3961982-1-li.ma@amd.com>
References: <20240329101748.3961982-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: d6eb3a52-4d6c-4969-91ae-08dc4fd9ee10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZmGJPoN/ydowokzycfIR8fN8zE9T+e8XuYnb7wVZGACOOzOego2Wuj3IzMh4GXxpJFPhTo+vPFWTTFc68y80l54DkuOjO7u5brO7ytveFk0r3CPhplgs1xsLo3BIMTPyLm5MkAkGAsnAkEmAYWR68UinqHhyg3AB6OEgiETTHADix9+NnZwxy1ml2Barq0cOprLSj22NoyV9ggo8ogTdoeWZEAepkMLeHtHnupr0SRDUwvISL4gNjJ0+suflipeI87oEd+jb331Lcm+TUrnhrG2SfCKDU3IQvm3gjTZL32pwHsDfqY7c4eI/1r5jPnDL+0cYnwXDDIgpLOVigUCGtoSn9yMJh0035Czw1q39CQNWLmMP/BhoMWchvxvl5YI/qJaz/FlB+pzTUo1bmHVAgfd+RYWrC6q3qwZU4qgjX1iW5GzVieNMIndCAu27JhWF3JDVlY5a4TiVE0TDE2vg4V/iyQO2ZmrEcgyDmpjN8YffiyWRcFdgOemM7BKzgEE4QCtrD/3LLtk2an0PlsL8BhUGQbOJnxMVcap3HXlxUsk6fEGqxI4mSeZ4vOzmcqDU7OuwPkoqOvlMUiWz98ONsOZeG853ALNkMmqJqhjK4UmnD0MfFprG/x1Vz7eAvDJbGukpyjOUi5D27mflts+X4+mVWJytFBet9Pb1IyHBH1FdNQ7pscZzZXpHiaNT/MGA3RWxUhPwoYAagOIE3LgBxY5GhoA7WVDSggYpQ1GNLJBoa247xl1rLKBPeVHhUny
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 10:20:59.8922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6eb3a52-4d6c-4969-91ae-08dc4fd9ee10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
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
(cherry picked from commit 4bd00ad0eabb67239ea833b8c461bf6970352839)
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

