Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF8CCD11DD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 10:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB434112635;
	Fri, 29 Mar 2024 10:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SCyQpvmj";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA59A112637
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 10:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKapShWTNnn1uSaSfRKVomq/MZyguWqUbJLCR9/KY9rDsvLISrSozZF1JFQ5oUBUG6Ot9IR/fTnsIdMHDBXZi3okeEACHTMtFDU2OveKZcOHT3wJaD1SVamrrNTh2rdYCGywXHWiH0joQNjLkHPUUzsUbkJuZ60rxxR+h+WFfJz/WjXLkyVsg1D0VdY18Ih6IsFe50S15xfqak92hHeSc+qitBvad0HWFb84Q7bB7ecGiVfZL7YAX/vxs60/jp+3+i2hks+xyN29ml1XMz9/DfxxwW9lKOQTL+m0BM05QNYp1OXvV95ANqAbPfm+H4hsU8w9VFF4O3BnW46TLfpPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SvEqTYbZ2cPE33xh6cIqiIaypB5uNNm3F2GbKja2bg=;
 b=ZZlY8OXDWrfYS2MMpi/kzLdtkrU7JiYqzUhUUwQclSB/Wr2m/LLZLGnfFOeBpfTNdyMgelSlB8LFSEDP2i3I/XXJjPO+N9DfmhILLearNygEk47sNkz9/rCkOPWGyVW83R429+PdGcTio87L7EVhOYI9Q+r4PuRPHrVIM5J9Ogdr0spw0IIt8hHfdpxwYTcHmf3CQMQNYXM/fWFGGEG9lj000N4lzZov6ji87UzWsB/tpm/8yohUpblmbwnB9IjWZGOX4LEj/FgoJyOTKrQRWMVJAh3PlLrIpmHZNY7qXNbTPhWG0Yyp9QqBpx+YZrXbk9/CNhChJ4oENzCgJbUs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SvEqTYbZ2cPE33xh6cIqiIaypB5uNNm3F2GbKja2bg=;
 b=SCyQpvmjUsXI68ffZOn65eZSWDonCj/x2I8FLDcwr+00NuqhKI/DjN197uBqrsjJGfWBP7mjKL9hQoMCOCiuMAmPpL/eYnOVNsZy1llfx6KJrc9WCg+M/3nNMzmoW/cFpsDwSyrPlez5j0n1BWjFum56Ux2ajgfnp0Ngmluxhjg=
Received: from BYAPR02CA0023.namprd02.prod.outlook.com (2603:10b6:a02:ee::36)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 10:21:03 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::c9) by BYAPR02CA0023.outlook.office365.com
 (2603:10b6:a02:ee::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 10:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 10:21:02 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 05:21:00 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <richard.gong@amd.com>,
 <yifan1.zhang@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 8/8] HID: amd_sfh: Extend MP2 register access to SFH
Date: Fri, 29 Mar 2024 18:17:50 +0800
Message-ID: <20240329101748.3961982-8-li.ma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: fc421887-257e-4e0b-55c6-08dc4fd9efc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBRDlqhGK4qrtyKs3ckrf8AWgNG7akZRI11cimL+GksP4jpa/E23STsxZEHYKT2lDlKRjJk7k4WrAYVl2qdKkCfk5TO508hywS+g87iORA6Tm/QxZ7ydZbOyhHTbYtzzjPbPMJNXuVhVSta4oY66/8cAnKJ9b6UEvWnVeMxWyb+/gukxFz9RQTCCnokZ0HCt3kcP+H9PzSD8/Blz7rCL4kHssiWe+Lfrx8U2XgHMdxoI3J3h71fAdl8Z7Ig9TiccacctngWuHUKcaHVfdlqQn47hg3jiWMIJreX0TgZgNRdj5nYA2szauyUNXMTGxg7cVsUgbVHdp4nxLGFUp1t+xVJdA8V8Vljc3m+8qU+1rLXlwOXO7dqkXNz5KyiNOiAY+HnsYBwdA02xzY+zWjKHNwP/vloKdA5ZPhsePlueexq860/XiNFxfNDW4/qnQ1RPwEIVWGFbhZd/UVQrZwYjB76uEP1b8Y0pratxogg1ko/B8GUPFYZ6J7M9SP3vZLULFXOhxXWor+FNvB+8TsMqg+xmWEu8NpCz8TKkTXp04gWj2dj9Uq5VT8+U6vDJlqWVoMvPXDiFYoGQTPGZPkNq1rfxWO5AR216hZ2RIqx5nmKGwqt5WmwIJiUXL5QWtmwnyJJEdxhYBrNBdw0chBwWeezeSa6cxgXUa+/hFP0EQDpOm+2nkLmmr6Vs9Bdn5gSdbfl2judZ1gwGSAI2FGrHjxx70xnQab5/0mg43umU1KPpPCtXQgGqqoNOPMhzjWkr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 10:21:02.7531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc421887-257e-4e0b-55c6-08dc4fd9efc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
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

Various MP2 register sets are supported by newer processors. Therefore,
extend MP2 register access to SFH.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
(cherry picked from commit 92e38c2b7ea7c7ef77a55cce3c312b9377761990)
---
 drivers/hid/amd-sfh-hid/amd_sfh_common.h           | 14 ++++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |  9 ++++++---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |  2 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |  4 ++--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c | 10 +++++-----
 5 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index ef5551c1eec5..e5620d7db569 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -19,6 +19,9 @@
 #define AMD_C2P_MSG(regno) (0x10500 + ((regno) * 4))
 #define AMD_P2C_MSG(regno) (0x10680 + ((regno) * 4))
 
+#define AMD_C2P_MSG_V1(regno) (0x10900 + ((regno) * 4))
+#define AMD_P2C_MSG_V1(regno) (0x10500 + ((regno) * 4))
+
 #define SENSOR_ENABLED			4
 #define SENSOR_DISABLED			5
 
@@ -55,6 +58,7 @@ struct amd_mp2_dev {
 	struct sfh_dev_status dev_en;
 	struct work_struct work;
 	u8 init_done;
+	u8 rver;
 };
 
 struct amd_mp2_ops {
@@ -81,4 +85,14 @@ void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata);
 int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata);
 void amd_sfh_clear_intr(struct amd_mp2_dev *privdata);
 int amd_sfh_irq_init(struct amd_mp2_dev *privdata);
+
+static inline u64 amd_get_c2p_val(struct amd_mp2_dev *mp2, u32 idx)
+{
+	return mp2->rver == 1 ? AMD_C2P_MSG_V1(idx) :  AMD_C2P_MSG(idx);
+}
+
+static inline u64 amd_get_p2c_val(struct amd_mp2_dev *mp2, u32 idx)
+{
+	return mp2->rver == 1 ? AMD_P2C_MSG_V1(idx) :  AMD_P2C_MSG(idx);
+}
 #endif
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 495ec1179ee5..9e97c26c4482 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -99,9 +99,9 @@ static void amd_stop_all_sensor_v2(struct amd_mp2_dev *privdata)
 
 void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata)
 {
-	if (readl(privdata->mmio + AMD_P2C_MSG(4))) {
-		writel(0, privdata->mmio + AMD_P2C_MSG(4));
-		writel(0xf, privdata->mmio + AMD_P2C_MSG(5));
+	if (readl(privdata->mmio + amd_get_p2c_val(privdata, 4))) {
+		writel(0, privdata->mmio + amd_get_p2c_val(privdata, 4));
+		writel(0xf, privdata->mmio + amd_get_p2c_val(privdata, 5));
 	}
 }
 
@@ -410,6 +410,9 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 
 	privdata->sfh1_1_ops = (const struct amd_sfh1_1_ops *)id->driver_data;
 	if (privdata->sfh1_1_ops) {
+		if (boot_cpu_data.x86 >= 0x1A)
+			privdata->rver = 1;
+
 		rc = devm_work_autocancel(&pdev->dev, &privdata->work, sfh1_1_init_work);
 		if (rc)
 			return rc;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index 33fbdde8aff0..c8916afefa62 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -251,7 +251,7 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 		break;
 	case HPD_IDX:
 		get_common_inputs(&hpd_input.common_property, report_id);
-		hpdstatus.val = readl(mp2->mmio + AMD_C2P_MSG(4));
+		hpdstatus.val = readl(mp2->mmio + amd_get_c2p_val(mp2, 4));
 		hpd_input.human_presence = hpdstatus.shpd.presence;
 		report_size = sizeof(hpd_input);
 		memcpy(input_report, &hpd_input, sizeof(hpd_input));
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index 9dbe6f4cb294..5b24d5f63701 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -172,7 +172,7 @@ static int amd_sfh1_1_hid_client_init(struct amd_mp2_dev *privdata)
 		if (rc)
 			goto cleanup;
 
-		writel(0, privdata->mmio + AMD_P2C_MSG(0));
+		writel(0, privdata->mmio + amd_get_p2c_val(privdata, 0));
 		mp2_ops->start(privdata, info);
 		status = amd_sfh_wait_for_response
 				(privdata, cl_data->sensor_idx[i], ENABLE_SENSOR);
@@ -298,7 +298,7 @@ static void amd_sfh_set_ops(struct amd_mp2_dev *mp2)
 
 int amd_sfh1_1_init(struct amd_mp2_dev *mp2)
 {
-	u32 phy_base = readl(mp2->mmio + AMD_C2P_MSG(22));
+	u32 phy_base = readl(mp2->mmio + amd_get_c2p_val(mp2, 22));
 	struct device *dev = &mp2->pdev->dev;
 	struct sfh_base_info binfo;
 	int rc;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index ae36312bc236..2de2668a0277 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -20,7 +20,7 @@ static int amd_sfh_wait_response(struct amd_mp2_dev *mp2, u8 sid, u32 cmd_id)
 	struct sfh_cmd_response cmd_resp;
 
 	/* Get response with status within a max of 10000 ms timeout */
-	if (!readl_poll_timeout(mp2->mmio + AMD_P2C_MSG(0), cmd_resp.resp,
+	if (!readl_poll_timeout(mp2->mmio + amd_get_p2c_val(mp2, 0), cmd_resp.resp,
 				(cmd_resp.response.response == 0 &&
 				cmd_resp.response.cmd_id == cmd_id && (sid == 0xff ||
 				cmd_resp.response.sensor_id == sid)), 500, 10000000))
@@ -39,7 +39,7 @@ static void amd_start_sensor(struct amd_mp2_dev *privdata, struct amd_mp2_sensor
 	cmd_base.cmd.sub_cmd_value = 1;
 	cmd_base.cmd.sensor_id = info.sensor_idx;
 
-	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG(0));
+	writel(cmd_base.ul, privdata->mmio + amd_get_c2p_val(privdata, 0));
 }
 
 static void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx)
@@ -52,8 +52,8 @@ static void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx)
 	cmd_base.cmd.sub_cmd_value = 1;
 	cmd_base.cmd.sensor_id = sensor_idx;
 
-	writeq(0x0, privdata->mmio + AMD_C2P_MSG(1));
-	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG(0));
+	writeq(0x0, privdata->mmio + amd_get_c2p_val(privdata, 1));
+	writel(cmd_base.ul, privdata->mmio + amd_get_c2p_val(privdata, 0));
 }
 
 static void amd_stop_all_sensor(struct amd_mp2_dev *privdata)
@@ -66,7 +66,7 @@ static void amd_stop_all_sensor(struct amd_mp2_dev *privdata)
 	/* 0xf indicates all sensors */
 	cmd_base.cmd.sensor_id = 0xf;
 
-	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG(0));
+	writel(cmd_base.ul, privdata->mmio + amd_get_c2p_val(privdata, 0));
 }
 
 static struct amd_mp2_ops amd_sfh_ops = {
-- 
2.25.1

