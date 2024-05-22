Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A729C25B77
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 06:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44BE10E637;
	Wed, 22 May 2024 06:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T724nC5h";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19AC10E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG30FLZbC33DdiEww73Owyc/geYVwDjHY+B0uQQhozGykCDoazxRCDgxXXxZf2S7/lSX9aXPGU9gte5K1KISdRpsOFowAvsbZRErwldF0ZzbHWX4LFF5NoDuKuBRl/yXbHigN70609rV1j5i6srDO7NikoC2DAwjBkaRg8Co+wbIWdegs/38t4MgNayE/T/Pd4EUkAq0kzvAxARb7n3augxKSKjSC1UYnEKECYnUCDobzTTvR2u6zn6kpQE1vw4FuQ8+IiVoZQFA4WWThqgZBrTUzurPmkwsgm7OYqyM9QZ44f6IeE4/BPYwRjQMLjJPdlKMqNJ0MJ8VvJX0iN87RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdyRFGBjYgJmSfJavVFtnrTExPKV8mMMQBT5yBbDNtA=;
 b=P8HPPGaDLL/saQqRTTwfMqhEGOzb/RduRRvk/EhNVJegzVH7ptsMP1PYNrrJHGXjOW8kA4oz9iMvt6MJwBlELIKwcrGuJM7NL7Op6JsDQj5IvqUm7ANQX6ZWbxD9A1orI02PSk/vfNLlAVc1uByg2W2Uffz0YX9Wpt3Os1VpKnN7SoSJ7FwcaWt+zEg7ggoHYZVOBhtXFjudaNc3U/P4aHUm8K2gG1VIN8M/qJe5GlMyxS/mUNZGAx0PL4eU06ZoD+YLl6gdTRREiwsTIP7uah0+nEELLgrxpz6eoDrMyM7/ScH1bIkcozE6OWB6eLXq1u39ijHUxTpW1f5YcV9XhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdyRFGBjYgJmSfJavVFtnrTExPKV8mMMQBT5yBbDNtA=;
 b=T724nC5h/0urOZjlim4Cgn8NS2eA+sont9QFpg2zF9aJsTcqy+s6a0ILLtX4KYODlFD1OLwFPa6qVFOHvT2OzLmjruwa+R6wlGXWQNz+ZiMDV8fBXl5a1NiL+HwqKcKFwnp9ARdrJ778faep7fvskShTTl5+6SXZ4pClTymK46g=
Received: from MN2PR02CA0034.namprd02.prod.outlook.com (2603:10b6:208:fc::47)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 06:31:15 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::a3) by MN2PR02CA0034.outlook.office365.com
 (2603:10b6:208:fc::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 06:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 06:31:15 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 01:31:09 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 5/6] HID: amd_sfh: Extend MP2 register access to SFH
Date: Wed, 22 May 2024 14:29:16 +0800
Message-ID: <20240522062916.705147-5-li.ma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae31ee7-9754-48b5-0628-08dc7a28c7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cw0Cwcc7leF41/0GkH4iTZaIf+TDz3tNXvLtnEh4uyZz5SUvMengz6WCSjkm?=
 =?us-ascii?Q?DX4jRNYXMz5xcVxVZz1/PygRVmWX7VTqDgQfiN999VeHSHQssKJC418leLqT?=
 =?us-ascii?Q?7UQ8fBdlNW5SyVj3WE77DP4f+nXDWOWxMgjF7nJF/ydbkZiMtqKQ1WfUkf7P?=
 =?us-ascii?Q?Iiemf1fJbLZNlX/a24xK0d6LljTqaRJFyLW/4lhcKBRSBPGe8lYJwe3+/cK3?=
 =?us-ascii?Q?0iv28IiXpdzZ6dPMb8wjjD9sm8Z0pOxNXcL5tGW3g+HvbMzyRNikvAuqvnCl?=
 =?us-ascii?Q?IWg21xHFvreSQnQuD9tjSanq/xlrh9ykFMycIkZIp3OL9tQRSPX1yeyGUHWb?=
 =?us-ascii?Q?Jv+DhnLFmVZNykRfW0eMR0u0RGUaEA3WjYSTB15NAiit3rxYE1eA8+xjOktv?=
 =?us-ascii?Q?WN6yD7KFtVSDo06WCpEDCTXzhdA6aJUrt6oZRfyRjfEYmLjdluirJwkLGjdk?=
 =?us-ascii?Q?2TA4+0Qw5oN847ARlm9HUHgpo/w4sGAHSuuUTQoEbhwYIGyVLjD41F/YC5Ho?=
 =?us-ascii?Q?fSOsHiKCZkZ9ALu2aVpELpSIlwGKWX8p4z9U9CYgEcJTVpmCiit8TiKgvmpa?=
 =?us-ascii?Q?0DTF6FAxlBwyoelZbBPvl+OicMlwbovkOnBiKVNN10uYoZs10hyb5ozheUux?=
 =?us-ascii?Q?RMAjnd988fhKThyORwlArF0kdHsrOnfbI6PiMvmv5lvD52c+sm5IUp5ohyPe?=
 =?us-ascii?Q?+/knYuMgam6mETEBOswsA/xqOwNx9VGwARKIx48tGtF2bLMpOPCyOlzKJCW3?=
 =?us-ascii?Q?QL0BWCULkONBGII5Id4/YgqHH6ie0/BDfb4CYBJIZDBdhBrulvoX2OniH12u?=
 =?us-ascii?Q?5lIhrd+8z+HHCyc/c5CZuOLlreQG3QsvQn5nNnITwhNsv5g7/H3LO9GHjosA?=
 =?us-ascii?Q?HSksybO9pY04iS0jH+rp4hdAXGoa0gzWNT08baXup4ZM9Ukmtd4lNrevkRwj?=
 =?us-ascii?Q?El+3AGdHqrnoz4TP4eGTqcVozeODU7H4NloQg/NK74mLHbyY2RwFLfAhXkdC?=
 =?us-ascii?Q?TQiOpc7uM557RFS2rdX2+VnTpp/zrul7s5ZWSEYEPibAsaFonHd6FTPTEhwQ?=
 =?us-ascii?Q?DURTimOPVHLJAXdYmzX8SBV4QdT6mCxrLw4f2TGxOnekMk+HWhe0EEnq1Zeq?=
 =?us-ascii?Q?+lOP/Pe+cUqWcRicOW1RAReZv0U34L7bmZErtfeVZ1OhdCdH88GfUdQFNltJ?=
 =?us-ascii?Q?iRoQHyczLWT8Ef/TAN8428EkHGg74lInDe+slXch0cQBMLn1/YMLS2rgNQZb?=
 =?us-ascii?Q?XKk+AyYTRpVgPCSeAXqU5P+37m7b+/fTS+PlwJ6oPzzJ/xorzOKhdykKItab?=
 =?us-ascii?Q?Cc/EWIcCqLMUF/zBQMKtp0J+RNlwPAvypYsF1nJAY6ohgPF2FZrhXfhenxTG?=
 =?us-ascii?Q?7U0iYHJXO+anEHQiEf45gaD/gbgu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:31:15.0910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae31ee7-9754-48b5-0628-08dc7a28c7ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit 6296562f30b1caf4b5f44e0c89c8f5cbfdb14b4a)
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

