Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8270C4707B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AF710E252;
	Wed,  3 Jan 2024 08:03:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DF210E252
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7QHD+ol7qMnNtQ73eap1lXZkmFMMpahnXaJVgZMXU7yswBNs/3Cm0Lw5U5CMJnXKPM/X7eunGLi4sP+snzcYONx9X68DqOE2VIindpLyzYvEc3V8Hx4A2VNB5XBW3AHalCcXrzLPMemGT3zq6V8/egbxzc4O4mVo/HeptC1pk0mDs21MHR5bt9xF2BtGc9i74qnlHWAc8oYkJcmBYfw3Yttz26BmYAHBUCFmyf0TQCaqjIU08muyJKX4zpx3EQMAi/JZTxS+/bm86QSljUdNgCiorDzwzHlgFWS5Pp2ALA3XrjdmGbq+v31NVbcXxfMJms1MjQB7Z8+uxv+Hrq1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgtcSFIM58PElElWgO1PsMUCob1YF2UE2jXn5nrL+cc=;
 b=Mb5i1X6ZceechRJpY8wi8tA2EmkHMaydstD6Ifi9uC5jSeI1pDBRbtVItEe8cIM6UNE2qgm2eAmjYRFGsZIUg6N4Jg48pAYZ+MEd1pbqzMUd40E0vZTyEU11Mh8kHfIR9iBt+3kQVODGybqObkJ9PbiFjkBkuf+wFvFfws+xP7lhzRnpOUIQYJEK19NLXtkhEB35Le8tl2aofoQQjP5b4Ve881wPHQVzBBRp6FHsFo34cJpet4SwvW7UTQJoW/DTAi7kp3NKVTSJ7Wzzrr+GekLAz5OxtSO9JLM0yN1ASSz6fSStAvY0ie3Un9SSZXPbJHeLuY/2zMuxpJz6yHwyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgtcSFIM58PElElWgO1PsMUCob1YF2UE2jXn5nrL+cc=;
 b=z0N32xyQL9xD2r4OCw6z0RzEXTVSJ80IZ/oLpLz6k/kirkBjxcnOlmnlr4d4VuXnvb2VMrYhmUvWRES6ymk6FVLfLsgScNNzar93UkF72a3FB7MKrpYf/Bm1tu6vTz2pfB7lD7Jce9uVob7sXbDy5I3p7NoqcCMp5YKoCmH7AVU=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:03:53 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::d1) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:53 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:51 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amdgpu: add umc v12.0 ACA support
Date: Wed, 3 Jan 2024 16:02:13 +0800
Message-ID: <20240103080220.2815115-8-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103080220.2815115-1-kevinyang.wang@amd.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: d48fb285-21e3-4b7e-de32-08dc0c32874a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GXFYkGoiYgyOXSJJBEW1dly0c8VrUUGXJ1HTHWIXkMA8B+/CL+7WZ/HswEyBnhBbaHzdkljNW5WoePqf3gN5OYgBIKAWHlRZrNuRLoeiUVXRvubCIM9cgqaOY8ePPjO+zEUIpyXiqgeBtF2IX/PxIK6hRm7VQyu6WwRvOkMD7R2MYiu/cGL2pIi58IQVcrYMwm9IZdRWXymfxE33ecfSuO2NvZSJF8vJidKVJ7HBCLKl2L4c+QZ9gP7YCbSD7D7aVyNi0ZORPt+KRkHg4mrk7i+9uaBseLMaPWk0cA7vVggitkFfG8klt6T+uEvuNpeBU+hKDrhXPncKFzyZpuEBNnK6i48hgrrnh96DPPQkkZAISMDuOyossK/KS2aL1OoZ0JKbNs6I7LHMYJKtUDzvwMEEB8QimSyhtVLrhHkCD5HKxKTjv8P6SiZudQIH6o81uf4pl3GcrSs3EnR42dvwRO4UJlUt5SBnaYsr8K41Dykr/ayITl17klKZlpDT5kxBp2EDW/yN+q4LJbv78qybpSUtWVz1L6FU2FtEW35bgjvUkDcEEy/HNaTdKHb7P1hWEl+so8amwHE4Vko0Fw+S8f2VCRHz4XH29Kd1sxEYm6VdpJKkbMbOpNQSFLw8wZUZaC05PuXEjubSxrdzHWzfAeRonGecsdES927tBXh88CmsmoD9wAzZvfLe2MshMcI8Zfw6cG31SZjjcTfOxqflamJ7vev7UuRkG6u040bMs74KWR3LWSataOS3i/r9ZOMxnrytlwEbK2Ef3PLodNwqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(83380400001)(36756003)(41300700001)(478600001)(86362001)(8936002)(8676002)(4326008)(36860700001)(70206006)(70586007)(54906003)(6916009)(356005)(81166007)(47076005)(82740400003)(5660300002)(2906002)(316002)(2616005)(1076003)(26005)(426003)(336012)(16526019)(40460700003)(40480700001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:53.6246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d48fb285-21e3-4b7e-de32-08dc0c32874a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
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

add umc v12.0 ACA driver support

NOTE:
The bad page retirement feature will be re-implemented based on aca later.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 7458a218e89d..aa0ce6103dae 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -444,12 +444,72 @@ const struct amdgpu_ras_block_hw_ops umc_v12_0_ras_hw_ops = {
 	.query_ras_error_address = umc_v12_0_query_ras_error_address,
 };
 
+static int umc_v12_0_aca_bank_generate_report(struct aca_handle *handle, struct aca_bank *bank, enum aca_error_type type,
+					      struct aca_bank_report *report, void *data)
+{
+	struct amdgpu_device *adev = handle->adev;
+	u64 status;
+	int ret;
+
+	ret = aca_bank_info_decode(bank, &report->info);
+	if (ret)
+		return ret;
+
+	status = bank->regs[ACA_REG_IDX_STATUS];
+	switch (type) {
+	case ACA_ERROR_TYPE_UE:
+		if (umc_v12_0_is_uncorrectable_error(adev, status)) {
+			report->type = type;
+			report->count = 1;
+		}
+		break;
+	case ACA_ERROR_TYPE_CE:
+		if (umc_v12_0_is_correctable_error(adev, status)) {
+			report->type = type;
+			report->count = 1;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct aca_bank_ops umc_v12_0_aca_bank_ops = {
+	.aca_bank_generate_report = umc_v12_0_aca_bank_generate_report,
+};
+
+const struct aca_info umc_v12_0_aca_info = {
+	.hwip = ACA_HWIP_TYPE_UMC,
+	.mask = ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
+	.bank_ops = &umc_v12_0_aca_bank_ops,
+};
+
+static int umc_v12_0_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int ret;
+
+	ret = amdgpu_umc_ras_late_init(adev, ras_block);
+	if (ret)
+		return ret;
+
+	ret = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__UMC,
+				  &umc_v12_0_aca_info, NULL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
+		.ras_late_init = umc_v12_0_ras_late_init,
 	},
 	.err_cnt_init = umc_v12_0_err_cnt_init,
 	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v12_0_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v12_0_ecc_info_query_ras_error_address,
 };
+
-- 
2.34.1

