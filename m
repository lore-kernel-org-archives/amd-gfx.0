Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A0AC47077
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0B010E457;
	Thu,  4 Jan 2024 11:49:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCDD10E460
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwApOjbkZnqVH//xVZlDMZAENUCe+G6Nlh60niZWa1n7NX0uv+lwQyxyw1S+3s0+Jw1PaltRQvsVJuI57aMyQ1fqXbNyATWmsOEMQ3G1rv3cHxmGS0RvF6lGKTiAXCC+A++QagXc40EKatFb1qeGZAK3axbt6nF2Up3aGf+dvqFBtmi8ad/ggJ1XDJcMq8ifnmGGQqfzqGFuYSWJvGK8BUU4l6lvc+dr8u7dmYch9/j7/ChJIoSNo7d0PvJ1MP86FWfHkEspNqL4ImaPnYNMNVpaF55k0q0pRtBmD/123GDTsNXEx6xLEPxIeUi8nmd0f1+MgiI+cBYwxMOoaMOAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iB9/MSiw5GyEr4H5Pq//yVAv0hqe4p3PcgJYfVTY68=;
 b=j48M9hTLhy/wuoiKQV5zEs0ws25Va4xT93TB39g0V60WM+tWGcfbE4bmL5ebNq58hvdIrvo0AYjz2j6lhPEt9cICFHG6IUTFflPdEBaUBDVmpcFt4KEw9IlR3Vcc/ZCmHj0u9XZkTJsmXrpjeHrh0NsES9mSXkd/e+g9BXEHX1FIcp7HxynkpLmckpSVlkO2qbBOmq6owAmW+5XetETE+5qeMCEouyYuHvLm7T71kLqAc7yoUThKMRw5O0VIFGULUGyebRIyETeobUvjFjPyQ2DQZVGRmXyV3+v55iLxfu4TtaLPmYC4Klql2atu+iNpaxuiPBBygUg5J6i2Ay+XhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iB9/MSiw5GyEr4H5Pq//yVAv0hqe4p3PcgJYfVTY68=;
 b=ny5e4zLpDrMRL8MyT7gLVg1h9H3l1NLLmSiPfq1Tb6vFqJtyPgfGpwlVE5JXwMr31o64AScmSShD2TICW+ABShNhxqWqM5oUzdqgjrHsMsH9BUC5QFDq7pG6r0Rn27yKArPXRz+7R3NDJ8w+n2oQumwyJcydCXTxKStoxt9V0ts=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 11:49:40 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::72) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:37 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 10/12] drm/amdgpu: add mmhub v1.8 ACA support
Date: Thu, 4 Jan 2024 19:48:56 +0800
Message-ID: <20240104114858.3475783-11-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 86420b35-30ba-4746-694c-08dc0d1b3c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmePzfSvHTg70JyTgZkhLLzuBv4fPfaT4nPIQMkpRhxG29KmMId38tmlICLptjDOSFuEy6iSy6YTP89M15V7yhbguuAQs8HtzcXgNtWVQ4Bmj3jsKgYBWQYVajw1MNNMAgJGUD7iB0HgRBUdPRSzkC76E29vhy4ZUHY6mG8xzb75co0OtcbejE4SNefWI+0wDibIrnzXG78G/f/wDxBcqN+g+uwHIWsEqOT6vcQ/jRYLNzrAEUbjvG6aBhUmqe+uOF+mNyoSuXz4o4MRJPG96jhKt3skafIp2mM89dJ6tgatoPB3GkUCSqg2wjFHng9L6gEvC66YUnWJjJ82RGRuDwLWV3lzMgUkfHLvQycUqgIroCyljmvee5f9GmfKoSXy/WPGhTv1SeIZzMd/pWMHsNonqv+kLe3SshNHnLhDA9+Epk13gsHMWsf6wdVWLtLinhz9gRhMtbBtIBQwkmn/3w9PgqxLrjpHEeMRu/UsOPaR3Liw0E6lPOCrnyF+JW+wwd6bf4x8eNwbhu7162uPOaJ8aLxsfpehtFkbS5yQMWDyeUvtXqU/vaIaJ5FrQrqt6WgtpUIRF31bTcJGgIqL2NnwQo9E1RYk6VEmeEEvPqnrI7P8ySC23TAlmVHAzyoD1xpX6/g7Al1XyIdf5hmuewq7DqPqvUcp9C1VkUTRDIBbescSbuQOAOKbb4n6QEDfZ+9GGdELgvyLmpYKBSuBj+Jcb6HsJ2sXBM/LgeSlTqjPg1YsDXNybI8RKm0f2wJgkid4kLAVy5uAwTX3DulUxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(81166007)(356005)(82740400003)(36756003)(40460700003)(40480700001)(86362001)(16526019)(2616005)(1076003)(26005)(83380400001)(426003)(66574015)(70586007)(70206006)(316002)(8676002)(8936002)(6666004)(6916009)(7696005)(54906003)(478600001)(47076005)(36860700001)(336012)(2906002)(41300700001)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:40.4211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86420b35-30ba-4746-694c-08dc0d1b3c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915
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
add mmhub v1.8 ACA driver support

v2:
use macro to define smn address value.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 88 +++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index fb53aacdcba2..c1681a7b75a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -33,6 +33,7 @@
 
 #define regVM_L2_CNTL3_DEFAULT	0x80100007
 #define regVM_L2_CNTL4_DEFAULT	0x000000c1
+#define mmSMNAID_AID0_MCA_SMU 0x03b30400
 
 static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
 {
@@ -705,8 +706,95 @@ static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops = {
 	.reset_ras_error_count = mmhub_v1_8_reset_ras_error_count,
 };
 
+static int mmhub_v1_8_aca_bank_generate_report(struct aca_handle *handle,
+					       struct aca_bank *bank, enum aca_error_type type,
+					       struct aca_bank_report *report, void *data)
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
+/* reference to smu driver if header file */
+static int mmhub_v1_8_err_codes[] = {
+	0, 1, 2, 3, 4, /* CODE_DAGB0 - 4 */
+	5, 6, 7, 8, 9, /* CODE_EA0 - 4 */
+	10, /* CODE_UTCL2_ROUTER */
+	11, /* CODE_VML2 */
+	12, /* CODE_VML2_WALKER */
+	13, /* CODE_MMCANE */
+};
+
+static bool mmhub_v1_8_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					 enum aca_error_type type, void *data)
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
+				       mmhub_v1_8_err_codes,
+				       ARRAY_SIZE(mmhub_v1_8_err_codes)))
+		return false;
+
+	return true;
+}
+
+static const struct aca_bank_ops mmhub_v1_8_aca_bank_ops = {
+	.aca_bank_generate_report = mmhub_v1_8_aca_bank_generate_report,
+	.aca_bank_is_valid = mmhub_v1_8_aca_bank_is_valid,
+};
+
+static const struct aca_info mmhub_v1_8_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK,
+	.bank_ops = &mmhub_v1_8_aca_bank_ops,
+};
+
+static int mmhub_v1_8_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__MMHUB,
+				&mmhub_v1_8_aca_info, NULL);
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
 struct amdgpu_mmhub_ras mmhub_v1_8_ras = {
 	.ras_block = {
 		.hw_ops = &mmhub_v1_8_ras_hw_ops,
+		.ras_late_init = mmhub_v1_8_ras_late_init,
 	},
 };
-- 
2.34.1

