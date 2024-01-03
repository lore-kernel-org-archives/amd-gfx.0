Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B33C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B6D10E253;
	Wed,  3 Jan 2024 08:04:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DC410E254
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc4fX/2jCNpGYBfO0hOL14vgfw0kgWEA11zp4A92G6FXMGI/DmKadaa6bN0055y2xzHHiXH+M/FuSb4L0EmJ217ovAKfNMwHJdf37Uk/Fj0IEWxfrWjL9+SpLZzOkNGABldhRCDnV827aEwComKvXzPqPXVRw5m9eO0Bp2UubNrgzPFde4Sv3O7ZODbS5Lhiz4xXIWei5OZBY9lHKrmPEiuj0c5Q+11K6i5jg5rDddXV7onLPygHVql77N73OQI/EcDhYH73hRU0YnyO4mzaEDYtNLZfCIf0gEkiZ7EF5XVfBdGUXfVHOY24OZO9MTeRjAvdn0Xl7cEUt5wcoygx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y94uGvCtdvpdhFnAhsgsZ2YtwaNXWqxi7TyW5iYKlAU=;
 b=GipoGZpicBdlW61NTlzimwCo9Z1NIUUD/s3A4A6feajKM5w7NMvec/VIHteG/1VQQLlVJG9kVz42yyqW18tsoTkm8wqom5Awyx58cstNGYh9dZl+eqwb+QxffzpI9aYjNK8xrMc141zdBlRqG1+Jm70Cg9qbgJ5lpUYZq2F9NnuOSV0RRFBN2leaUi+lqz+SNuWxzXCjOmQRRZ/FIsDGpJLdvA5TYx2Saud8iv4eCp1pE+9H7DztBFgNYb0c3mi8+xSQnqIwYhF3gLEWWoR20k4lmpJ8MIO+3nAPTBcaWe6PiTIDlC2y80fpOnyuIfVXm8pyWdnZIhmkKhOGvvxeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y94uGvCtdvpdhFnAhsgsZ2YtwaNXWqxi7TyW5iYKlAU=;
 b=WMm2MxS+a0MQTC0MHFJGNwNrSj08AZer5qBFMlsmUMbUIUAMGTYk/Hethfxnvyuq+ilCucb4B/imN1CHnLM71RgftG7kQeQUPoxlj2JDkFcvb85Gh/wCe1UuBVJ6RC+FLOXwKuLie0QdH4WaqFoVkPB7VKTTEV0W628sbv5Owq4=
Received: from SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:03:59 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::b9) by SJ0PR13CA0114.outlook.office365.com
 (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:59 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:57 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amdgpu: add mmhub v1.8 ACA support
Date: Wed, 3 Jan 2024 16:02:16 +0800
Message-ID: <20240103080220.2815115-11-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: b60439f5-537c-4903-51d2-08dc0c328aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBXPUri5SWP5fqbNj9AR/eNqe4rfhSnoZpVke7tQ15sxtc8f8SFzUUAepoeT5ZadyUNm0v0AWjuMPRMd6a2KCtAvmu2c5oLA2ZN2oGmzcOsrRlrB+a2s7qdE0/JjF7aI4sSboR5kYSexlrwBBPWyrB6PlMU+kouF2ao89soT2YBV0dfwyIkdBd2eZB8velWRzUw1IZI8R3VVvFOkDpFMazcQ3V6p2DI875LKO4rFtEeXQTH7m35gC1jPi6NDBFMkUlCBLUjh4I5UBmVTZOmu0rtMKfTR5HQg5KzUaWwP6ZBfgozO3TDEdaSrjPXc0ZAeqP+v6FATtbdTfu/24RwzjjYiRvQm2nZ5Y6TmwD5RWYSNUJie8q6L4iDVyiB/s0xy394hz6HQEq6eiX9OROp4fxPSnTPY9yEDQrnoV9J/XILEJcTI7nRtmtXCXQpwu/bDEF6Mgsabi+E9cZK1Ye4/OxjkL/g7RmJn0K8gR68loz1cCLkMFY26rUrgYJVaK06sa8DUJjgMlaFbAoip+dhUSe2ig+L73FbtFoIFqKbP3gx621FOwMFGa8JhdP/ya8gd4JMK2H5JBlOlaVXGR98PbExesoRYBaPaNXn0/8nzBwIkMPeZz3i8JusdTLtwiUvz9PnpGEIwtoFVUXN4c+bUqQ/vtkSkgZxNly6+zia94YSUMDkW55tySneeAx+1/eNO1mJ4bYIACAQrSjEvjt9tYVsIquAbCzrYFoir9sbYC07LWbAk0r+EKEmze31JsgUczWivigAQ/3g2io3YbCPSBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(7696005)(4326008)(2906002)(5660300002)(6916009)(70206006)(54906003)(6666004)(8936002)(8676002)(478600001)(316002)(70586007)(41300700001)(356005)(81166007)(40480700001)(47076005)(40460700003)(36860700001)(36756003)(82740400003)(86362001)(83380400001)(26005)(1076003)(336012)(426003)(2616005)(66574015)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:59.2808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60439f5-537c-4903-51d2-08dc0c328aac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
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

add mmhub v1.8 ACA driver support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 87 +++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index fb53aacdcba2..a0a4a2f3227f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -705,8 +705,95 @@ static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops = {
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
+	if (instlo != 0x03b30400)
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

