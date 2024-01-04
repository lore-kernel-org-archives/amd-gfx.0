Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D588C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C3110E45C;
	Thu,  4 Jan 2024 11:49:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA4A10E468
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ+VA2jK+Vqn/Rj1HCZIRnXk1eTLQFlvWXPgs9Rr2Ml4lNckb6Ere/JzHOFlGBMyMWhw75BPOOXhSIsP63wZDQ5uzh1vrMT8vCdO3CuFkY4sZfxTLkehmVCncdwta+73FEMm5UCi9zlhuqmoi6iwhTJsAw2HojBH8e2rM7EHGrmFRFVzQwno/2DOj1tI5m4VdpXbS5tvmeEx5iFWUzW4gwvOUvcBD7s+0iGynDOSMGUmqMfzOc9KHTrFqIHZjmIXBiexCLlIIc0v2X/yzJUldu8UgkIkapoNLGRYC39r/hh1s3gABbRckCTt8QtLGKyqWXiK0yueadj3LcbFxmcbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOK2L1QqtoCkF8gvoM9OdCKfmax8QT0iey7SnhOFD+A=;
 b=d1T2jn8Z0L3WJK2A2xbVsbDMvkf15lUwTJkQiRbhVfo5ObHAva7H8eL4eM6DeMItL0gGeS2BvNVdFhoJa3ib70Db4hYM9dzwIyVwjky5bmS7YAJZT6ivWKII00WEH0usgW0ZJknE3Iflvh4gJ1SWRcJkfWwKHlB7fPUjtjU22bmaWCux694xLay3hvScaezWPaxD0eZQ6LNLBxOWOj1uQGVNTIQupLV2iUfgYfpWIj4y4EvIf8jeoOM5KxgsJ8y2k+/SDOpWKSn+kfloZqdjMk75+Q1XHiPWnQayawzTe0TvAi80A4vI9r8LjmmJaCP6ombGg4soZlZTnxOU4SKJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOK2L1QqtoCkF8gvoM9OdCKfmax8QT0iey7SnhOFD+A=;
 b=foVLV8bNgme7OBfhWCBOs8uehKDxFmP6jG+/DxvZBK6sE7Pz04nYr4cpPfF5WzIG7L7Ihm0w16MJrM7VOq8uCW4nuzXYQH3Q131DZoyx17plW404wJoPUYJRgU7G7chYqMthIYvRAFOjPrdloLi/5fF0B/LNflIu2Aaxl5oHZ0U=
Received: from SJ0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:a03:39e::8)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 11:49:38 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::71) by SJ0PR03CA0273.outlook.office365.com
 (2603:10b6:a03:39e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:37 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:35 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 09/12] drm/amdgpu: add sdma v4.4.2 ACA support
Date: Thu, 4 Jan 2024 19:48:55 +0800
Message-ID: <20240104114858.3475783-10-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104114858.3475783-1-kevinyang.wang@amd.com>
References: <20240104114858.3475783-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bdad6a-b01d-4bce-2cd7-08dc0d1b3aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3t7HYwuWiRClu66kW86n5778g4UtNUS97msKd9v+xZTk/taNz310ov3c0LDKibsqLC+SSNoaSHAzrhVBNIfVnxgJwWoh814b7RwHt6rXdxFCGrMcO7jrKyOD4WKCLhElpVfFRcvK7aghNTD3XcrkibAlOXQJeOZXmvqAs1rMP0KUX8gDKyOWptbgJbQelTjzqzTFTcR+uZVcCFz3bfGlvkAPNjcWTjZxf4rwBncdStRvA+WqREu1FiqTvHBMhIm7KAsw9r/X98DTCQQWkAKTmi2G67a++lAAdqhA8t3A5nOzQatLKaPbFM8wG0RjH5+5n6vVJNW3I+vK0Me5rjr8x0h9w4nmRe/cFQ4rSj6hGrIbIGWOlcOOSDPu+c7TykD0/tQ1Fu7F8QqzsEu3MmPWADxaek2yfAfu4i6P4qjgof1ral6nBZRCWO2LhY9kHpUUZu5QomexMI7s7KIXByxfV7nCcnsHk+k376sw4hHASyD/uNMOfJJ81tnCGZCX0m1RYTezMygmfxEE/CUIs0Z1TsPTKGyc75bN2/himxT1ZXPikcqwFoTIPbQ+EMFM4PzB8YfwyonJ906BTm9Yn4OArxgaspowTdY4h3TSDBIoFjpp8FNgVMGDapII/XeTeRJtxMG6rhZr5wxXKQokaPs3IuISVLnPcvJAUQIRx/a2WF+E7qYkeAZg54TvKgDBkzjmF5S9HEySXi1+rUl5f3/+ETpPo7fikRv2XbAIBLsHS7W1grslF71jInsC7GoMEr1VYnIiCeLjRvxyFAjCp7G2Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(4326008)(40480700001)(5660300002)(2906002)(8676002)(40460700003)(8936002)(316002)(54906003)(6916009)(70586007)(70206006)(7696005)(41300700001)(47076005)(478600001)(82740400003)(6666004)(336012)(16526019)(1076003)(2616005)(426003)(36756003)(26005)(356005)(83380400001)(86362001)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:37.7180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bdad6a-b01d-4bce-2cd7-08dc0d1b3aa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
add sdma v4.4.2 ACA driver support

v2:
use macro to define smn address value.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 82 ++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 2d688dca26be..8e2366c6717d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -45,6 +45,8 @@
 
 MODULE_FIRMWARE("amdgpu/sdma_4_4_2.bin");
 
+#define mmSMNAID_AID0_MCA_SMU 0x03b30400
+
 #define WREG32_SDMA(instance, offset, value) \
 	WREG32(sdma_v4_4_2_get_reg_offset(adev, (instance), (offset)), value)
 #define RREG32_SDMA(instance, offset) \
@@ -2204,9 +2206,89 @@ static const struct amdgpu_ras_block_hw_ops sdma_v4_4_2_ras_hw_ops = {
 	.reset_ras_error_count = sdma_v4_4_2_reset_ras_error_count,
 };
 
+static int sdma_v4_4_2_aca_bank_generate_report(struct aca_handle *handle,
+						struct aca_bank *bank, enum aca_error_type type,
+						struct aca_bank_report *report, void *data)
+{
+	u64 status, misc0;
+	int ret;
+
+	status = bank->regs[ACA_REG_IDX_STATUS];
+	if ((type == ACA_ERROR_TYPE_UE &&
+	     ACA_REG__STATUS__ERRORCODEEXT(status) == ACA_EXTERROR_CODE_FAULT) ||
+	    (type == ACA_ERROR_TYPE_CE &&
+	     ACA_REG__STATUS__ERRORCODEEXT(status) == ACA_EXTERROR_CODE_CE)) {
+
+		ret = aca_bank_info_decode(bank, &report->info);
+		if (ret)
+			return ret;
+
+		misc0 = bank->regs[ACA_REG_IDX_MISC0];
+		report->count = ACA_REG__MISC0__ERRCNT(misc0);
+		report->type = type;
+	}
+
+	return 0;
+}
+
+/* CODE_SDMA0 - CODE_SDMA4, reference to smu driver if header file */
+static int sdma_v4_4_2_err_codes[] = { 33, 34, 35, 36 };
+
+static bool sdma_v4_4_2_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					  enum aca_error_type type, void *data)
+{
+	u32 instlo;
+
+	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+	instlo &= GENMASK(31, 1);
+
+	if (instlo != mmSMNAID_AID0_MCA_SMU)
+		return false;
+
+	if (aca_bank_check_error_codes(handle->adev, bank,
+				       sdma_v4_4_2_err_codes,
+				       ARRAY_SIZE(sdma_v4_4_2_err_codes)))
+		return false;
+
+	return true;
+}
+
+static const struct aca_bank_ops sdma_v4_4_2_aca_bank_ops = {
+	.aca_bank_generate_report = sdma_v4_4_2_aca_bank_generate_report,
+	.aca_bank_is_valid = sdma_v4_4_2_aca_bank_is_valid,
+};
+
+static const struct aca_info sdma_v4_4_2_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK,
+	.bank_ops = &sdma_v4_4_2_aca_bank_ops,
+};
+
+static int sdma_v4_4_2_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
+				&sdma_v4_4_2_aca_info, NULL);
+	if (r)
+		goto late_fini;
+
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+
+	return r;
+}
+
 static struct amdgpu_sdma_ras sdma_v4_4_2_ras = {
 	.ras_block = {
 		.hw_ops = &sdma_v4_4_2_ras_hw_ops,
+		.ras_late_init = sdma_v4_4_2_ras_late_init,
 	},
 };
 
-- 
2.34.1

