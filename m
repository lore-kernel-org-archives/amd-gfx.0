Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CC8C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D251910E249;
	Wed,  3 Jan 2024 08:03:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E1C10E249
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzDXcUJWT+xg24y9FOhPwzD5OaPWb5si4zv43kVZAbuDUxizZL8ulz1JAccKsNFsUAC+3aEdpIQOz4pQkpYJFIL1c2e34lMfg38xNj4ejE2v6oR4hb/zPewd9OOAzCr4yI1Y1YWLPwD8Oq7R0gNRwJdcPhR/31EzLrhAAZn/x1610Jpjw3Pd6pZgid2ndTIqRQeNGWwtOTAV0vDeqfUqegC4Jb0YmsLPPdi8O8E3bm4HsREUg9pEgoSBiOzL1ev9bhgfHKOXtnqZeIbtIdmqBrLCoYvyihcpAjt+JEzWaC4fAo/UPkk8i977WRGkHdXzvoWG3iFqWfQtM5o0Cy1n0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq8a0HA2YkLZGvXQoxHPuBAn/YbUHipL/7TK9lCzxk8=;
 b=d4HVsvsOP/kMENURUPMfJ2ZwvbrBOp+PJo2dkD6jbXxwe/TZtyPkV1WIANyMzYivRIz0U5vwTKvK4LVDZqzTTE328x7IvBhYCqpSL1AADD2ADcH8x0yVbzjdnccOExKGzMNO9TvMyOLRFy37FzwfhUbfp5sFURPwlu/EGpZyhUfxuQaw6H31RVrBo/WlNLu8uQ7pyv2oD2NgmqJBEthwX4aMSpDO92dmx5kSfanym4Cp2cFWuIamTW74ostZ3VP5OSK1ieqmCAb9Z+2YKGHKBjo1QwR3MKGk/iWx35LHylsspmKgERJRMe4Q+l8roqfcm03XXqb8RcJkrpGvxzmW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq8a0HA2YkLZGvXQoxHPuBAn/YbUHipL/7TK9lCzxk8=;
 b=snsrAHiliLwW5URkvg/pxboKmpBGUE9F/1hFleRA4CXDg1WpO6vIo8UxNaTmLHNBcvzvS+F0dkhMgnj404l6JSs5HkR5dlKyr8xLl9ERyGv8feoV/2w4jwJWDnLH3P3XYgkbihCQa/PmURA9/1uVgfuBxv0yUhJu9BU1mVRdVKA=
Received: from BYAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:a02:a8::33)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:03:56 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::96) by BYAPR03CA0020.outlook.office365.com
 (2603:10b6:a02:a8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:55 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:53 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amdgpu: add gfx v9.4.3 ACA support
Date: Wed, 3 Jan 2024 16:02:14 +0800
Message-ID: <20240103080220.2815115-9-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 32dc4544-b25d-43ab-f9e5-08dc0c328870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ma94WJ2H1UTI/YQj+YtJeO8lO2N1u/bJs2onDRyx4Y5MvOCSEBQOoif1f7iZNeNfL/a9JG7xQVbwSCBzqB1bn6p0q6HtCnmS1agAvrIykUPTAq1lPkqeibtralVin0J2yV3xRUxZHqHnr3G4uqa8thyRQmwMmCqxca75gdodeFqtikmQIPXl1r0vV1Uojs/aze+HIqsWsY+TW9Jvswl2GBLyW7Ya3HGEVQymgk2uGVkEVFiVdqOkWV43u0jFq/D/3e+g6rVjuHalgJ74a7pxbQr1bQve5Skx/6oZMLx05J2OHWYgplKdH5q72MqbSzCPH0b0sGIfjoFkF4OO9/WPVPfy3op1BbKyPGuPX8HKNkI84wjH5uzG1PPOGtEKy+I7tzbF0QRhv1Dimk1/4D1YlS2OuVKW4bn0YJj96GudDW6QTn9R8jT1ADhhnmfo8KR/LQ8ahEd92RynrSHcXXj06A5pf4IJ4pFkQV9KlnAI+T4AlaQ5aXDIJ3ncNmy917Z0mfnlDtkc5zDr0InSlliDpQzYcuxewD+a2gggVuUEs0NdJUFfPXGY1t/9l5lRpXJhjVOdu7LhpFLigdDAvkywtn5L9Ku9Xsdj+97LwrE12AMY2paBVbn01QD7JnkJ1EdlWOl816+AoG5RRjkXw6WwpAWtObXpshZLmWXHkziC/PnwBtdJd6MWr/QlCkmhuitbt0WJDSaqiD7xNT6okScJv/17Yqg120MUEykHh4FwKqqqjUblj3SrsJODujDCPo6fXjkxUjreUg35ctLkwRbrSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(4326008)(2906002)(8676002)(8936002)(83380400001)(16526019)(426003)(336012)(26005)(5660300002)(1076003)(81166007)(2616005)(356005)(36860700001)(478600001)(7696005)(40460700003)(6666004)(40480700001)(47076005)(82740400003)(41300700001)(36756003)(70206006)(6916009)(70586007)(86362001)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:55.5521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dc4544-b25d-43ab-f9e5-08dc0c328870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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

add gfx v9.4.3 ACA driver support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 85 +++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 131cddbdda0d..18b8e4dbe9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -38,6 +38,7 @@
 
 #include "gfx_v9_4_3.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_aca.h"
 
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
@@ -675,6 +676,67 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
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
+		report->info.die_id = instlo == 0x36430400 ? 0 : 1;
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
+	case 0x36430400: /* SMNAID XCD 0 */
+	case 0x38430400: /* SMNAID XCD 1 */
+	case 0x40430400: /* SMNXCD XCD 0, NOTE: FIXME: fix this error later */
+		return true;
+	default:
+		return false;
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
@@ -4242,9 +4304,32 @@ struct amdgpu_ras_block_hw_ops  gfx_v9_4_3_ras_ops = {
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

