Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BF0CD11DD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 10:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFF911262F;
	Fri, 29 Mar 2024 10:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pz/BkEOU";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030E110E418
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 10:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKjzluLh0foS2bWpRn7Z4rIiXfH2y+hoQ/vICaEO9M4a+w6kqhCOMRwWk9GQ9Fdb2NMfUo0gmS23fHnJ4AaTaTyiAhAaeS70LerZiEsU6Ti+3VkVmiFC2H8uSRyBurCta6RYM7GHEjRdnpaVHjWE6i83+k20VKjtY4Lo7UpgMDj5zDXpdoTkU8ymcFnsYaql1hSTp1FBG36ZnpgsDFwow8cmpP2IdbC51jAHupyn6TXnGpfNgJHE74HZz5v18QDfGbNB6DrxHWIiJuV8x6KoPyGwoKbQH7yuk3o6aT4FYVBBfieDnZxL8xBjDguVVmCTseVZvIfX0s0ATXe9l3eXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc7UdcUVTLJVRTRY8weuIohIfZf7f7agvFfM9QMRwAo=;
 b=Acll9BCNxqcZt4t7gBCUGlZzqE/naI8tSSCt2ki0wGaw7OraU+rVFyAW4CHgyoIFo5aogFoN/gvZKVGfyUhY44A3dm+XaWJqGkfjnVNbgvVtCL/dCyxECygy3UlfrGymui5lu8+SIJ0P69hGKKcwCR9gnHLISFVdiEWhL8APqjuvhP3AgmN+R60bpF/v9c9pLm8OHSrKzYd6THPv15SLaMwQKmANNEh7JHRLc3fDpl6cBqlygcd518peY8YoSDKKkUqMPLiXfzdzAZ9YzJkzszzgj9i6kKotGgGQA0ZE9NQRLB5PhnEXcqNp2ZeJSz/KfZ4XQmfoVpAmYaqnR7cmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc7UdcUVTLJVRTRY8weuIohIfZf7f7agvFfM9QMRwAo=;
 b=pz/BkEOUqgQmkD6BF7l/Anf3F1HBQZIyonUlAbcTflVTB3/dPTXER0v7O739JpK8DaWq8BNBdNpxgVASi2swoGxB9A+H1A/zTuUsLuEqJlFz9MW74KsSU/pqo/ORVWWxN5huWbjFlRvAGbAUjXKk+gt26Dn6AmLxAE3XyR6aZjA=
Received: from BY5PR16CA0030.namprd16.prod.outlook.com (2603:10b6:a03:1a0::43)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 10:20:42 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::b5) by BY5PR16CA0030.outlook.office365.com
 (2603:10b6:a03:1a0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41 via Frontend
 Transport; Fri, 29 Mar 2024 10:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 10:20:42 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 05:20:39 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <richard.gong@amd.com>,
 <yifan1.zhang@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 2/8] HID: amd_sfh: Add a new interface for exporting HPD data
Date: Fri, 29 Mar 2024 18:17:44 +0800
Message-ID: <20240329101748.3961982-2-li.ma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b38b8c-eb19-4a0b-8c7a-08dc4fd9e374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYpfZDRh8AOvsTlROOxrz9nHWrHlxxqDiaYgAa/bGgYz8sA+6BKUyA+CKjXdbMR1aYztG8nzMGjqd67Q1uSl5uaWfY0RCncEJEu1jPoBTmSJijyqvEiKkYMnvpCyINnWQXnYOSryHUXquLum0lclqTiAPY+TeHy7EJxrFeXwgbX4uKCP7zP98oOaf6v4wHMnq8sBU2uocAix1KpxDhYMD3l51b0gsRiJj4q16aTSSs5xKqHpGw7mUkn/y0hqHhbYcvutnsJSje0wbGUSl8BCdA6csesI2P8lA5nZBGSxpRJFNU8o20MgxZivL71mbrvLiknCPIzzx9/PUUvM6FalUXft21HbQRySpMdJCzDfC6VmezcNU1Kkr5QNbRgCtc1oPuflCIORgfXjtPlc9HAWKabQBM15GXBI7gzVoxTILLkLGLJWG+rDWHKD5f/587Pa18HjneMUQDTxQl7Pya18L83LKoUQPVcGkCTrSF48CXPZRdfhtGOyBUoKv5yyMtNoqnSOha7aj10aAd6CIArEHPqSS4gJA033qPlZb/v3l5uiWZY492degdRAop9zl1zretXRI7JUNwBiIFEEvW+kLWg00EpkikiY7TTL3y9HwEjU2xt/bIYuSleqB8FOGQDzV68ypq81pU9CywoQ+GV3CDciRfRsug9jMeRQiThlk8XdHxh722FZlwcw5GqW50WFzWE+6+gzSl4D8vDCsQjMiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 10:20:42.1081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b38b8c-eb19-4a0b-8c7a-08dc4fd9e374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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

AMDSFH has information about the User presence information via the Human
Presence Detection (HPD) sensor which is part of the AMD sensor fusion hub.

Add a new interface to export this information, where other drivers like
PMF can use this information to enhance user experiences.

Link: https://lore.kernel.org/all/ad064333-48a4-4cfa-9428-69e8a7c44667@redhat.com/
Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit b5b0774d53bb81bddbf8c609b3f183d4af6e91da)
---
 drivers/hid/amd-sfh-hid/amd_sfh_common.h      |  5 ++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c | 14 ++++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 37 +++++++++++++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  1 +
 include/linux/amd-pmf-io.h                    | 46 +++++++++++++++++++
 5 files changed, 103 insertions(+)
 create mode 100644 include/linux/amd-pmf-io.h

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index 2643bb14fee2..cd57037bf217 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -37,6 +37,10 @@ struct amd_mp2_sensor_info {
 	dma_addr_t dma_address;
 };
 
+struct sfh_dev_status {
+	bool is_hpd_present;
+};
+
 struct amd_mp2_dev {
 	struct pci_dev *pdev;
 	struct amdtp_cl_data *cl_data;
@@ -47,6 +51,7 @@ struct amd_mp2_dev {
 	struct amd_input_data in_data;
 	/* mp2 active control status */
 	u32 mp2_acs;
+	struct sfh_dev_status dev_en;
 };
 
 struct amd_mp2_ops {
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index e9c6413af24a..0351b0fd394a 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -73,6 +73,12 @@ static int amd_sfh_hid_client_deinit(struct amd_mp2_dev *privdata)
 	int i, status;
 
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
+		switch (cl_data->sensor_idx[i]) {
+		case HPD_IDX:
+			privdata->dev_en.is_hpd_present = false;
+			break;
+		}
+
 		if (cl_data->sensor_sts[i] == SENSOR_ENABLED) {
 			privdata->mp2_ops->stop(privdata, cl_data->sensor_idx[i]);
 			status = amd_sfh_wait_for_response
@@ -178,6 +184,11 @@ static int amd_sfh1_1_hid_client_init(struct amd_mp2_dev *privdata)
 			rc = amdtp_hid_probe(i, cl_data);
 			if (rc)
 				goto cleanup;
+			switch (cl_data->sensor_idx[i]) {
+			case HPD_IDX:
+				privdata->dev_en.is_hpd_present = true;
+				break;
+			}
 		}
 		dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
 			cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
@@ -259,6 +270,7 @@ static void amd_mp2_pci_remove(void *privdata)
 {
 	struct amd_mp2_dev *mp2 = privdata;
 
+	sfh_deinit_emp2();
 	amd_sfh_hid_client_deinit(privdata);
 	mp2->mp2_ops->stop_all(mp2);
 	pci_intx(mp2->pdev, false);
@@ -311,12 +323,14 @@ int amd_sfh1_1_init(struct amd_mp2_dev *mp2)
 
 	rc = amd_sfh_irq_init(mp2);
 	if (rc) {
+		sfh_deinit_emp2();
 		dev_err(dev, "amd_sfh_irq_init failed\n");
 		return rc;
 	}
 
 	rc = amd_sfh1_1_hid_client_init(mp2);
 	if (rc) {
+		sfh_deinit_emp2();
 		dev_err(dev, "amd_sfh1_1_hid_client_init failed\n");
 		return rc;
 	}
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index 4f81ef2d4f56..197b828fc6a0 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -7,11 +7,14 @@
  *
  * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
  */
+#include <linux/amd-pmf-io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
 
 #include "amd_sfh_interface.h"
 
+static struct amd_mp2_dev *emp2;
+
 static int amd_sfh_wait_response(struct amd_mp2_dev *mp2, u8 sid, u32 cmd_id)
 {
 	struct sfh_cmd_response cmd_resp;
@@ -73,7 +76,41 @@ static struct amd_mp2_ops amd_sfh_ops = {
 	.response = amd_sfh_wait_response,
 };
 
+void sfh_deinit_emp2(void)
+{
+	emp2 = NULL;
+}
+
 void sfh_interface_init(struct amd_mp2_dev *mp2)
 {
 	mp2->mp2_ops = &amd_sfh_ops;
+	emp2 = mp2;
+}
+
+static int amd_sfh_hpd_info(u8 *user_present)
+{
+	struct hpd_status hpdstatus;
+
+	if (!user_present)
+		return -EINVAL;
+
+	if (!emp2 || !emp2->dev_en.is_hpd_present)
+		return -ENODEV;
+
+	hpdstatus.val = readl(emp2->mmio + AMD_C2P_MSG(4));
+	*user_present = hpdstatus.shpd.presence;
+
+	return 0;
+}
+
+int amd_get_sfh_info(struct amd_sfh_info *sfh_info, enum sfh_message_type op)
+{
+	if (sfh_info) {
+		switch (op) {
+		case MT_HPD:
+			return amd_sfh_hpd_info(&sfh_info->user_present);
+		}
+	}
+	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(amd_get_sfh_info);
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
index 75267b0fec70..2c211d28764d 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
@@ -165,6 +165,7 @@ struct hpd_status {
 };
 
 void sfh_interface_init(struct amd_mp2_dev *mp2);
+void sfh_deinit_emp2(void);
 void amd_sfh1_1_set_desc_ops(struct amd_mp2_ops *mp2_ops);
 int amd_sfh_float_to_int(u32 flt32_val);
 #endif
diff --git a/include/linux/amd-pmf-io.h b/include/linux/amd-pmf-io.h
new file mode 100644
index 000000000000..5b6d29d36922
--- /dev/null
+++ b/include/linux/amd-pmf-io.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Platform Management Framework Interface
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *          Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+ */
+
+#ifndef AMD_PMF_IO_H
+#define AMD_PMF_IO_H
+
+#include <linux/types.h>
+
+/**
+ * enum sfh_message_type - Query the SFH message type
+ * @MT_HPD: Message ID to know the Human presence info from MP2 FW
+ */
+enum sfh_message_type {
+	MT_HPD,
+};
+
+/**
+ * enum sfh_hpd_info - Query the Human presence information
+ * @SFH_NOT_DETECTED: Check the HPD connection information from MP2 FW
+ * @SFH_USER_PRESENT: Check if the user is present from HPD sensor
+ * @SFH_USER_AWAY: Check if the user is away from HPD sensor
+ */
+enum sfh_hpd_info {
+	SFH_NOT_DETECTED,
+	SFH_USER_PRESENT,
+	SFH_USER_AWAY,
+};
+
+/**
+ * struct amd_sfh_info - get HPD sensor info from MP2 FW
+ * @user_present: Populates the user presence information
+ */
+struct amd_sfh_info {
+	u8 user_present;
+};
+
+int amd_get_sfh_info(struct amd_sfh_info *sfh_info, enum sfh_message_type op);
+#endif
-- 
2.25.1

