Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF67C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D2710E03E;
	Tue, 26 Apr 2022 18:28:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0165C10E03E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQOtfJXCDqXo6zsIZzGI7KCKFWBJ9d+W9ccpXx4ISUTBjQjrSFRMseozWmO3IJsWcQeyQJl1ON3orII+y2k7tOJzW8lr5HknN/5aVs5msIE4lqv9RnZ/hrzbNJvv0DUCl3PVoQq9v+zgZLfPk0iHiwEY4ZsamrwGOCkKtGQCSbVHehSrv1V7rNJQBwKsqYyAADqz4KYeP8nX+Z9QjurprltgHIjPjK/sZAGgY9PuiZ03d5XI+OAZeitV9VaeWmJv7JTF9hKFl4W0MA3dde7NY+Gnl5cQ2/l6jd61R9KwgPxqJDpam39RTtNaFADbrkikVSLQq+PI4vzdBg4g2Ed8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWPlJc2gKeZTBD08NUzI9Tc56EBe5xJlTqyuJyhCy1o=;
 b=QMmVafzMg8BERRNwD5m8Jn5zlkMSFxcvQ5eTnop1PhcH3RwSdQdhNabQPvMU4FhsUBbbKfJiReDFHrZ0PIM38PpnZWb6N9sHMJyDji3MqQGK7DaFCRooBFyoChHXyVLKW21gu+6HiWvE6SLEIWfZ1J2J4YkoUVVBAJtprU/G+NMfCp1avPoxFfK5erxKxB4INHx0H2N34slHE5J92a235vvHTBVJbIhzqtlF7USPctLTYgbObEfEf+jYWtCEmyn12nT+CfQO8I98HZYGPwxc1T5D5DGq33Uoz+e/fkpwCAW6xDuA4nuSi0csZuShrgjSDeyhiFr7jh1GvfbXG0xD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWPlJc2gKeZTBD08NUzI9Tc56EBe5xJlTqyuJyhCy1o=;
 b=BiA1r4/6DxCrUIaf5tCLiqKGCFTMHHL9FdjavaxSQyd+AYcEWRcMmb76dENhW1BYUJsxt5ysGew0flrdYLIwaFVrzcKx9wmPX3CDjj2Dx75pX6lkWbtIYaVGQ/wRPpCE71ZdqtPAfrwyLHOp2kU9V++Uill8qP6vpzkVLawn+hk=
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 18:28:33 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::da) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 18:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:28:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:28:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add helper to execute atomfirmware asic_init
Date: Tue, 26 Apr 2022 14:28:19 -0400
Message-ID: <20220426182820.3006877-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8411f070-8460-41f2-a4d6-08da27b291ee
X-MS-TrafficTypeDiagnostic: CH2PR12MB4101:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4101EDCBA1AD63918586A838F7FB9@CH2PR12MB4101.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMcv9Fwf/PszkODCcnzA+Y2SpWJPo7qP66TZchJf/3X2xKKy8GpaIWXSS6U8w1ecuBtKWHeAs3cMC9cDx2SchdJVNbrI9gRrHtH6kPq53oGEWM1bRKCVNilNDFbq2wJRoiaUS4nreSLoYje6sn/Zj74nVYob8fXNG8v9fN4frboBlXOP5iem00MquA3NGEwcqmU6KQjRmt21xD0ba9wni7q6/OYJ4Y1PNt4mzsUSuNkoD0hD4kS0T9yZMxF1Kmnc08m6Pt1N+VFjEDYVVKeLJ6EEh95+V6dWRlQGdhhOuVRNPsoDqabZmdQi0D+VnodyFbxw3SY7HbvObvW6WSkOL50J+dhFSD/kwUyJ68Hef8J4Ekeqjv4F5gyFPF4YS1RDmdvxe7BZDsuUzKr2zlGR6UJN93Hny1k3K+ZAc+EbRN51bTqlY8JmR84U/remnCs9X+x8pk9jgW5LsmWKUvREHWkJqq8OPjhYGYA0YpJ/w6fn8jP+yBl04HEu++frFHRZSbm5Xem0X02v5QCNGf3R7PMSJQYnSkfxg8RQr2d2cc6ksAhY5P9ht8fkgJqM7luBqMX0eH5SL4LXJF/aXJV2BM/ztTxXdH1pGx0E7WXDzgRzpM1YpRYLaoq4n7gG0ZFbgvcID6dO1ISmKCyrtyfWWpOJhNetL1n8ttCRPn3wD80E4c5BD1WB2vcCftbFcgM0HKU3cJzRTLqunkoLHD9A/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(5660300002)(8936002)(336012)(36756003)(426003)(26005)(4326008)(186003)(16526019)(36860700001)(8676002)(2906002)(1076003)(47076005)(2616005)(86362001)(508600001)(316002)(70586007)(70206006)(81166007)(6666004)(40460700003)(356005)(82310400005)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:28:33.1563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8411f070-8460-41f2-a4d6-08da27b291ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add helper function to execute atomfirmware asic_init
from the cmd table

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 64 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  1 +
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 4d4ddf026faf..d27323ccc5f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -731,3 +731,67 @@ int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
 
 	return fw_reserved_fb_size;
 }
+
+/*
+ * Helper function to execute asic_init table
+ *
+ * @adev: amdgpu_device pointer
+ * @fb_reset: flag to indicate whether fb is reset or not
+ *
+ * Return 0 if succeed, otherwise failed
+ */
+int amdgpu_atomfirmware_asic_init(struct amdgpu_device *adev, bool fb_reset)
+{
+	struct amdgpu_mode_info *mode_info = &adev->mode_info;
+	struct atom_context *ctx;
+	uint8_t frev, crev;
+	uint16_t data_offset;
+	uint32_t bootup_sclk_in10khz, bootup_mclk_in10khz;
+	struct asic_init_ps_allocation_v2_1 asic_init_ps_v2_1;
+	int index;
+
+	if (!mode_info)
+		return -EINVAL;
+
+	ctx = mode_info->atom_context;
+	if (!ctx)
+		return -EINVAL;
+
+	/* query bootup sclk/mclk from firmware_info table */
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    firmwareinfo);
+	if (amdgpu_atom_parse_data_header(ctx, index, NULL,
+				&frev, &crev, &data_offset)) {
+		union firmware_info *firmware_info =
+			(union firmware_info *)(ctx->bios +
+						data_offset);
+
+		bootup_sclk_in10khz =
+			le32_to_cpu(firmware_info->v31.bootup_sclk_in10khz);
+		bootup_mclk_in10khz =
+			le32_to_cpu(firmware_info->v31.bootup_mclk_in10khz);
+	} else {
+		return -EINVAL;
+	}
+
+	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
+                                            asic_init);
+	if (amdgpu_atom_parse_cmd_header(mode_info->atom_context, index, &frev, &crev)) {
+		if (frev == 2 && crev >= 1) {
+			memset(&asic_init_ps_v2_1, 0, sizeof(asic_init_ps_v2_1));
+			asic_init_ps_v2_1.param.engineparam.sclkfreqin10khz = bootup_sclk_in10khz;
+			asic_init_ps_v2_1.param.memparam.mclkfreqin10khz = bootup_mclk_in10khz;
+			asic_init_ps_v2_1.param.engineparam.engineflag = b3NORMAL_ENGINE_INIT;
+			if (!fb_reset)
+				asic_init_ps_v2_1.param.memparam.memflag = b3DRAM_SELF_REFRESH_EXIT;
+			else
+				asic_init_ps_v2_1.param.memparam.memflag = 0;
+		} else {
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	return amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, (uint32_t *)&asic_init_ps_v2_1);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index 751248b253de..c7eb2caec65a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -40,5 +40,6 @@ bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_device *adev, uint8_t* i2c_a
 bool amdgpu_atomfirmware_mem_training_supported(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_dynamic_boot_config_supported(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev);
+int amdgpu_atomfirmware_asic_init(struct amdgpu_device *adev, bool fb_reset);
 
 #endif
-- 
2.35.1

