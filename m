Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4304FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 03:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28B810E32F;
	Tue,  8 Feb 2022 03:20:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EBD10E259
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 03:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXFEiTL/aJ1qoxPpkUx82201tHY3sI4o6kluGbH0Va0BiAnBOF1Q6aJGEKGNvFqA7A6TGOaMvbqEKc61+AjwBJs/ncps0UxynmHPTLrUhDsU/m8rhYkxIYieCB+3OMq/9Gl+0x1U/g0oCp9HLKAAKKudAR/9Lk6BRwMk0i2fAtTMtBfaWfERcHI4oPe9DYKrJfqdDNOxH24FwMe7w0cPmun7puvnBZjxtvGIQL8aojotWNcRtY1cYkDkQtIwgZys3rNV9FwmnEf/TpZsjXGe20Z0cZZUxfDzXAP/Gxju3XcvyHVU27c7luDjdixH10Z1+65c7V9kxNU1Fyjr/qscNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz5a/FHJEoZpDfdJ0xVMEzS2+hp/G0JseB2ZhxWNqlQ=;
 b=ERceNgEQzrf3hKbB4Ip5fintKEeP9VN6VMPLRr1AuQTZDXAHRm2GQ3maFyHr/spt0+nxjdi7DzbEW4YfURyZRTtMbsox8R11lr90Czvy4O/ZnX4669ZNzI7vK/S0ipoz3D+M98U9JsTv4tW/PC2X0Vso0xfI8mFrUNKRsZ2B8ev/r0s35aCsQdbmUUCUe6ZxR+d3dGFymRA9CqJtY6/WEtT+G4dIQKq2EgNMcosi1mxXBE7Q33bNGy0C/ZiFUgecXJB9n4ZrGc/U2DI/aMx8+plV4mSYHNRDlHYcoR/sLs6G7iB0LIQo2pZlHyw3O4oZmUO4KSn0Zu+281dPG/TZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz5a/FHJEoZpDfdJ0xVMEzS2+hp/G0JseB2ZhxWNqlQ=;
 b=iDon8iYG7YUmMwTGmZjlDkUG3AIxJHkiR0AiqylcgDMHTY2R+xI6YgKwXRdPbROAzC43eB2ZAn9J3hOv2p+SJ3Tw88nhQPfl/UGyyphmWvp29AbaYSxXH1yp4ac/74FS1jam2I/g19KqVNgHnrpUP0uWilyQ6XI/D8IkNlcx+Ds=
Received: from DM6PR17CA0005.namprd17.prod.outlook.com (2603:10b6:5:1b3::18)
 by DM6PR12MB3258.namprd12.prod.outlook.com (2603:10b6:5:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 03:20:39 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::87) by DM6PR17CA0005.outlook.office365.com
 (2603:10b6:5:1b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 03:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 03:20:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 21:20:37 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amd/pm: fulfill Sienna_Cichlid implementations for
 DriverSmuConfig setting
Date: Tue, 8 Feb 2022 11:20:07 +0800
Message-ID: <20220208032009.763982-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220208032009.763982-1-evan.quan@amd.com>
References: <20220208032009.763982-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c80cad-067e-4c7e-aa33-08d9eab1fb5f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3258:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB325851D8E10983A3460E77F4E42D9@DM6PR12MB3258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NedqWgdw/xaEkhdjViw00lKS0ohe2XlGAzN7xLO7/sSJIiszZx/CmdFs7eFL3x5Lh7gwyTyqRtfayRJTvxpc9tvTuTYJr56kkg8vwYicK6G7L+bgmD0GIuGQb4y16v4qn/4WTo4gtjXqQaQ2NDYJvOg/JsKVSAK9EEqian+oT9Ge3TexdhQRxojhpe27kbwFNrJ33FNA5ke7KFjzjKz7fZGA1jkfJ0bMakAWzAV+ff2XLKZcQB+ubBKKPrM9e8aLB+5tAhXUOeQQb2SeM1zsPZKsVHJcCjhfkHKkb+c6D1Xzh3gsblIw0do0KnMxiihtCBxWy0apJ6zoQUiDOLywP2cAsiK1yGhllZvGovXy0HNyM2pGYyCNcgKNY+e0Yklj3pvNuESj9enhdkbsSfJeJ34RURfa71QHAQaYXD9wbQqMOBpY05IW8o1V+8Ai9e3Kn2W7t7Ztcjynkz9s8klzmlJfhmdcWFctHZFhSShdYIK9cLh2jE+oOx5i3xq9ouuQnL0zjLIUo77pNbowwxBIjJKv17jUbDQ+/p5DvW3+ywc9emtEOWjNLHDFI3eOipThhle3ZvbgpRhkdISJj9/PV0LVuFxS8pdNRcuFefA4hcyEW0hOnJPLH+oyOk5ae9c/YRtEG2lOcPDaTh5DycSpXHv2awOVwUfucEzX9PkQBQXvxNSgZ4L85PoRAxJeuEeYwmWMOeanZSj9Y8OfPgOoEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(6666004)(44832011)(47076005)(7696005)(508600001)(8676002)(81166007)(40460700003)(36860700001)(86362001)(316002)(82310400004)(70206006)(4326008)(70586007)(356005)(1076003)(426003)(5660300002)(6916009)(336012)(186003)(26005)(16526019)(36756003)(8936002)(2616005)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 03:20:39.6003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c80cad-067e-4c7e-aa33-08d9eab1fb5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3258
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill the implementations for DriverSmuConfig setting on Sienna_Cichlid.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ic519c8d4fcfeefdda79ba9ed01b235824d76e40f
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 978c0ebe9d19..a7bb5358d4a4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3922,6 +3922,58 @@ static void sienna_cichlid_stb_init(struct smu_context *smu)
 
 }
 
+static int sienna_cichlid_get_default_config_table_settings(struct smu_context *smu,
+							    struct config_table_setting *table)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!table)
+		return -EINVAL;
+
+	table->gfxclk_average_tau = 10;
+	table->socclk_average_tau = 10;
+	table->fclk_average_tau = 10;
+	table->uclk_average_tau = 10;
+	table->gfx_activity_average_tau = 10;
+	table->mem_activity_average_tau = 10;
+	table->socket_power_average_tau = 100;
+	if (adev->asic_type != CHIP_SIENNA_CICHLID)
+		table->apu_socket_power_average_tau = 100;
+
+	return 0;
+}
+
+static int sienna_cichlid_set_config_table(struct smu_context *smu,
+					   struct config_table_setting *table)
+{
+	DriverSmuConfigExternal_t driver_smu_config_table;
+
+	if (!table)
+		return -EINVAL;
+
+	memset(&driver_smu_config_table,
+	       0,
+	       sizeof(driver_smu_config_table));
+	driver_smu_config_table.DriverSmuConfig.GfxclkAverageLpfTau =
+				table->gfxclk_average_tau;
+	driver_smu_config_table.DriverSmuConfig.FclkAverageLpfTau =
+				table->fclk_average_tau;
+	driver_smu_config_table.DriverSmuConfig.UclkAverageLpfTau =
+				table->uclk_average_tau;
+	driver_smu_config_table.DriverSmuConfig.GfxActivityLpfTau =
+				table->gfx_activity_average_tau;
+	driver_smu_config_table.DriverSmuConfig.UclkActivityLpfTau =
+				table->mem_activity_average_tau;
+	driver_smu_config_table.DriverSmuConfig.SocketPowerLpfTau =
+				table->socket_power_average_tau;
+
+	return smu_cmn_update_table(smu,
+				    SMU_TABLE_DRIVER_SMU_CONFIG,
+				    0,
+				    (void *)&driver_smu_config_table,
+				    true);
+}
+
 static int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
 					      void *buf,
 					      uint32_t size)
@@ -4036,6 +4088,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_mp1_state = sienna_cichlid_set_mp1_state,
 	.stb_collect_info = sienna_cichlid_stb_get_data_direct,
 	.get_ecc_info = sienna_cichlid_get_ecc_info,
+	.get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
+	.set_config_table = sienna_cichlid_set_config_table,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.29.0

