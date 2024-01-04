Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC63C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3886F10E45A;
	Thu,  4 Jan 2024 11:49:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675B610E465
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwMABs/lFn6T0Y29tYGoM1fnBljIJNBc5U3m6ZV7urVRrpzxItcTo78FH6smxmwlVaJSTUhYRHxcdQBjaGUJ5VE/RKU+Dnye8Eiw9bPAITGEIJoTVpgksGaZxnwbvpddij4IJs9vIPR8dfYkRtFxlctc9T98mZyQAwJQ9qkgeboC/ie28GtGK3g3lyoGmt3L/fb6as5yBcwNIlCEQ1lbBGOwn+u3TxxrzDD0Imr/nZJS6Rp6wzqUjFPriOMBFWoGCa9gXjR0mgUbUnuHOKQRZ1uhyHBHkw1SA21sQKSWhJuv5W/sc5d+1AkAv1rZge3xgEHgl8Tx3lXdEGcM6vTwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssqwePiTbPuQnG+XHh0PrbzwaCQ4CVGOvHkl8mIU3DQ=;
 b=SBqY+SBVp1Vbe1qTwa0GgEfknAKNfcaTOX4lwSBkXS6hp+cddSm4xrU9VDATqTJuv8IucTJV89kBo34oyY7DWG8AP9ZvvLAccxm99r04bpD6uMUAwmalusuIhHceP0f1jCDLTaLf7ZHiXHwbOb4XEEqkyDfnteAc2l9bA29OzeX4Q0zkbszHDtdB3ESrbN1qV9Jcin1eipnOpHayX8CLLLiNuw8G3xK8hSFovFK5Wp3G1IPIfuw/hLcqZdA8U4tQKQAQogr8BCmzOFjpImbXmY9AQef4NTEcavFihuV/57EC/WBxjmcNbsaeBjQbKEfIxMxVr2HoNks8DerhLrZYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssqwePiTbPuQnG+XHh0PrbzwaCQ4CVGOvHkl8mIU3DQ=;
 b=xseYZpMqj8PE0gO/+Z3n2585qtJP1UzTtlpYC2UBEi/qM4r6PXY+wXvCpQvGsypN+pnxsAv6E/DiejWsz9AMlRCf6OX8hRwLhcMr/+iU8SC3Bi0U1hFCzgZtlJpgRZkKCKoloji93XtTXymeH8Iqr4VqjnCWjkK0CrGgNVXtuo4=
Received: from SJ0PR03CA0272.namprd03.prod.outlook.com (2603:10b6:a03:39e::7)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 11:49:37 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f6) by SJ0PR03CA0272.outlook.office365.com
 (2603:10b6:a03:39e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:36 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:33 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 08/12] drm/amdgpu: add gfx v9.4.3 ACA support
Date: Thu, 4 Jan 2024 19:48:54 +0800
Message-ID: <20240104114858.3475783-9-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff55fa7-d22e-4ba9-4ac1-08dc0d1b39c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJCV76NfrbC8bwTTeaUmTwbxkQR0fyMBtFsIg8KmwqOIzWgWhrO+VeOb5CsIFIbls756fJ2VVqSgRs4YhX/M/R9RLsKSfW5HWsc9S6orzET6FqQls864nGfWUYAsH6wvPLCZAr5ELDaTO0jmSBhljcN4pj+yHpijnPoVFaZ54xtAKvXpwfFA+KLvSimhg9FU4QUBEtXAowTEqnEX54PCoiyZHFVholv0zreyKPHiGq2i5J9+PZgmWcGwiKbwVRxB82nJdpCiEVSlB1aOQMsD4XHkV8frqMl0e7upE6x2ftCRqfr0/lIGI+nrcfqArRfRo1of34DCIOkwm7djDz4DJraMkhS67Ihw0eD59LJnoLV9nIxavECNKuG8Cdlp2pZl5BCX9++1W0hqsXMxzIvkjCt4Ru+1YLx/XFVpZSgnMC1q+UEj0IgfWLmYb22L78TeZ35l4fkClkN3MutqcEIgNZs0XrrQSKLNcnlvCQZhfxwj3EAG+MLpkfdP6K9I6ld0zV7HOAIovsisS3khi7VqvD/IXLRGRtGMepT9RiA0qWW0ft89VGSNTkcQPudfBgt7JEkVDYLi8lDmB8AwLdCbIz312CfveNi+iysm4OJOOmNYUjjveFWjBaBcjGhnIH4BXhr3+ypCGZJWOn+WSI4yvNYm1979zjYphQrMqqR/7QfOt/uBZWf8AySWagmIh5uEQqRG2jKEW0OcxXcioig04Ekzcqe+HWpJGmPcwzYyz9aFlY/R07TpU+HeRUGAIod3y+6xgt/DgHas5tQnGRq00w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(2616005)(40480700001)(1076003)(41300700001)(2906002)(82740400003)(5660300002)(478600001)(47076005)(36860700001)(36756003)(7696005)(26005)(86362001)(40460700003)(16526019)(4326008)(336012)(426003)(6666004)(83380400001)(6916009)(70586007)(70206006)(54906003)(81166007)(8676002)(8936002)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:36.2336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff55fa7-d22e-4ba9-4ac1-08dc0d1b39c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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
add gfx v9.4.3 ACA driver support

v2:
use macro to define smn address value.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 89 +++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 131cddbdda0d..4e4f3db3c33c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -38,6 +38,7 @@
 
 #include "gfx_v9_4_3.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_aca.h"
 
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
@@ -48,6 +49,10 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 #define GOLDEN_GB_ADDR_CONFIG 0x2a114042
 #define CP_HQD_PERSISTENT_STATE_DEFAULT 0xbe05301
 
+#define mmSMNAID_XCD0_MCA_SMU 0x36430400	/* SMN AID XCD0 */
+#define mmSMNAID_XCD1_MCA_SMU 0x38430400	/* SMN AID XCD1 */
+#define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
+
 struct amdgpu_gfx_ras gfx_v9_4_3_ras;
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
@@ -675,6 +680,67 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
 };
 
+static int gfx_v9_4_3_aca_bank_generate_report(struct aca_handle *handle,
+					       struct aca_bank *bank, enum aca_error_type type,
+					       struct aca_bank_report *report, void *data)
+{
+	u64 status, misc0;
+	u32 instlo;
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
+		/* NOTE: overwrite info.die_id with xcd id for gfx */
+		instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+		instlo &= GENMASK(31, 1);
+		report->info.die_id = instlo == mmSMNAID_XCD0_MCA_SMU ? 0 : 1;
+
+		misc0 = bank->regs[ACA_REG_IDX_MISC0];
+		report->count = ACA_REG__MISC0__ERRCNT(misc0);
+		report->type = type;
+	}
+
+	return 0;
+}
+
+static bool gfx_v9_4_3_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					 enum aca_error_type type, void *data)
+{
+	u32 instlo;
+
+	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+	instlo &= GENMASK(31, 1);
+	switch (instlo) {
+	case mmSMNAID_XCD0_MCA_SMU:
+	case mmSMNAID_XCD1_MCA_SMU:
+	case mmSMNXCD_XCD0_MCA_SMU:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static const struct aca_bank_ops gfx_v9_4_3_aca_bank_ops = {
+	.aca_bank_generate_report = gfx_v9_4_3_aca_bank_generate_report,
+	.aca_bank_is_valid = gfx_v9_4_3_aca_bank_is_valid,
+};
+
+static const struct aca_info gfx_v9_4_3_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
+	.bank_ops = &gfx_v9_4_3_aca_bank_ops,
+};
+
 static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
 {
 	u32 gb_addr_config;
@@ -4242,9 +4308,32 @@ struct amdgpu_ras_block_hw_ops  gfx_v9_4_3_ras_ops = {
 	.reset_ras_error_count = &gfx_v9_4_3_reset_ras_error_count,
 };
 
+static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__GFX,
+				&gfx_v9_4_3_aca_info,
+				NULL);
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
 struct amdgpu_gfx_ras gfx_v9_4_3_ras = {
 	.ras_block = {
 		.hw_ops = &gfx_v9_4_3_ras_ops,
+		.ras_late_init = &gfx_v9_4_3_ras_late_init,
 	},
 	.enable_watchdog_timer = &gfx_v9_4_3_enable_watchdog_timer,
 };
-- 
2.34.1

