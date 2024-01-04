Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA62C4707C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1793910E41A;
	Thu,  4 Jan 2024 11:49:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836BC10E44A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTLgvjEOw4eXreFpTLvtsgrencSoxHuZyUOxKc2E9rqk+aU/W8+VEf7gF9uzNV4UV9QfKdLsjBmlUGjdL6i3Bcu3MG0eZ2NN24HhMUc8hIAjYAm1q3hGe+B18YxaA+VSSsiuydEKRBzMfbQIRrRxhOFWTbHjC1CFzaYsxzzujlrIv321QzzKckvRjAMX0Ieawdei/GV4BYwp0iTQcK3sJ7ma2XMKtwDa/ltKCnsdcXHY/TXLh3j9Fi4sTUfy1tE4mVVNy25KPx2pou2CwFxdxeZz413Fjun3bj8WoK38JX/MWMLttq5Yh73GROJdfiW9wHziCGdbucFj+Ph95Q4v1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGwCzYFEUT0CzPuDAkVIKUx715LpAFFPYVQ/u0Cmq18=;
 b=dkOKyP1QoV3Eax4vS23C7t5NVXxqpdbNI4HMt1LKUgvUxv9+H1XsAThxdq/pJS/Wu+4aH87wrzJ7hKG9dnIMtIZeQ8SpJH9A040oKE6ywC0hDJ1Ido2Exyk3+3twuD5ieWk2sR1CtMLGQjw59eWybfH85BT/D6nYpP3s9/UU/xf88+SvCKdZE4LhEOGayimeP7DM7wdvaCP74REf9+5o7rqmFseSWtsrElgFPMyQsXbInyWFv/9MjsP3Qj5PFOZZUu3NDsL1G4FybiXbWJSsn3rD4h70/XwcL2PIQ3OXvqSI4Ua5BGUd+TQXDdDHxhCYIISKJ/021WC9f1C8q/KOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGwCzYFEUT0CzPuDAkVIKUx715LpAFFPYVQ/u0Cmq18=;
 b=2bIFFptCEIuh5BlHYsNzLKoGoUzTnYDOleEyG+hvzlDDZzQ4lA9xe02Gx9LD7nWO2fj3Ikx9XJqWF/aTQjZjxwZYUFucL2iTMkZ6/ZST+yQeKEEpAASm1r0jhEcRO2FJ8NQA0gZvZqSxe9g94rcJ96eOUDCfG6S+y6yfeRNoMn4=
Received: from SJ0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:2c0::26)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 11:49:29 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::f1) by SJ0PR13CA0021.outlook.office365.com
 (2603:10b6:a03:2c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:28 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:26 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 04/12] drm/amd/pm: add aca smu backend support for smu
 v13.0.6
Date: Thu, 4 Jan 2024 19:48:50 +0800
Message-ID: <20240104114858.3475783-5-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: a9bf325f-dd7b-4e9d-f423-08dc0d1b3566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8LhGc7q0egWu01Rk6PZtEpwk8fg7WBkIHswNUefcKlfk/hpUrpX/vakrPhqvOeKmjb0nm1ggwFb0qvPhuS80DGBjI6XnnVzveGB6fRatJkWON95EmiIGg6Xhtn56fYbCQdtSuPtAMaBd2cxPVBiuhvgliGHn1IxtQ4P9YjYQzaBLF27mhs1OQ1Oo2ZLEws2GyqcrZ2s1tBz4AzSn/qCk/ubuOkuRKUD3eRZ6EWp6JCL28LMYOJG67HJ9cNdojsEcx3YDJiDHI3oavW1ALlbAnS3hkVfFAi7RMfp/hyf7LH6I+dTdt8EzvEL9QeOE/wd1cfbFjlTEViyNwHur2YyZXltQBz7J4h3qJ+TWD5SIjg1+7Vj46ew6mlX4ypdR7GcuYsUOippIIYweZN4ovOBSteDcKRU9dMZMe4TSecHtoyd7M9pOxCHbiaeeutR9lYWvnr4iLHCjBf345CgwoZMfvL+SY94yZbHa+Vy6SuPfjKumfZMcJMtFO/9Q2FDfhDf2+hhRYfR8sLDI6Et6svtTKWdxvpYLuthyqvq/F7Y0hHk11iRHReeSVdk/ECVw8BLSvPTEw7RiTd5avjC56q2xFH3qVw8jucURG3XlxIPIpVQxZErB144tFcy8oRp+5iYXsWEGRup6/G32FovWze9QSbLcJli/bsl29BtX+DfXt9bBoeLWC0E8QxywHF5iofJ8XNn26oj4zIwuvnT7GOJ9mYqj78p5uCs22aouUbqJz1xt0VO6qy7ib152gJoOBlEyCg1wlvNVGcxNy8/sx+HYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(336012)(82740400003)(356005)(81166007)(36756003)(40480700001)(40460700003)(86362001)(16526019)(426003)(26005)(1076003)(7696005)(6666004)(4326008)(54906003)(47076005)(478600001)(316002)(8676002)(8936002)(83380400001)(70206006)(6916009)(36860700001)(70586007)(2616005)(41300700001)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:28.8798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bf325f-dd7b-4e9d-f423-08dc0d1b3566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
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

add aca smu backend support for smu v13.0.6.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4ebc6b421c2c..c828957550a1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -45,6 +45,7 @@
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
 #include "amdgpu_mca.h"
+#include "amdgpu_aca.h"
 #include "smu_cmn.h"
 #include "mp/mp_13_0_6_offset.h"
 #include "mp/mp_13_0_6_sh_mask.h"
@@ -2855,6 +2856,143 @@ static const struct amdgpu_mca_smu_funcs smu_v13_0_6_mca_smu_funcs = {
 	.mca_get_valid_mca_count = mca_smu_get_valid_mca_count,
 };
 
+static int aca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_v13_0_6_mca_set_debug_mode(smu, enable);
+}
+
+static int smu_v13_0_6_get_valid_aca_count(struct smu_context *smu, enum aca_error_type type, u32 *count)
+{
+	uint32_t msg;
+	int ret;
+
+	if (!count)
+		return -EINVAL;
+
+	switch (type) {
+	case ACA_ERROR_TYPE_UE:
+		msg = SMU_MSG_QueryValidMcaCount;
+		break;
+	case ACA_ERROR_TYPE_CE:
+		msg = SMU_MSG_QueryValidMcaCeCount;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_send_smc_msg(smu, msg, count);
+	if (ret) {
+		*count = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev,
+				       enum aca_error_type type, u32 *count)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
+
+	switch (type) {
+	case ACA_ERROR_TYPE_UE:
+	case ACA_ERROR_TYPE_CE:
+		ret = smu_v13_0_6_get_valid_aca_count(smu, type, count);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int __smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_error_type type,
+				       int idx, int offset, u32 *val)
+{
+	uint32_t msg, param;
+
+	switch (type) {
+	case ACA_ERROR_TYPE_UE:
+		msg = SMU_MSG_McaBankDumpDW;
+		break;
+	case ACA_ERROR_TYPE_CE:
+		msg = SMU_MSG_McaBankCeDumpDW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	param = ((idx & 0xffff) << 16) | (offset & 0xfffc);
+
+	return smu_cmn_send_smc_msg_with_param(smu, msg, param, (uint32_t *)val);
+}
+
+static int smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_error_type type,
+				     int idx, int offset, u32 *val, int count)
+{
+	int ret, i;
+
+	if (!val)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++) {
+		ret = __smu_v13_0_6_aca_bank_dump(smu, type, idx, offset + (i << 2), &val[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int aca_bank_read_reg(struct amdgpu_device *adev, enum aca_error_type type,
+			     int idx, int reg_idx, u64 *val)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	u32 data[2] = {0, 0};
+	int ret;
+
+	if (!val || reg_idx >= ACA_REG_IDX_COUNT)
+		return -EINVAL;
+
+	ret = smu_v13_0_6_aca_bank_dump(smu, type, idx, reg_idx * 8, data, ARRAY_SIZE(data));
+	if (ret)
+		return ret;
+
+	*val = (u64)data[1] << 32 | data[0];
+
+	dev_dbg(adev->dev, "mca read bank reg: type:%s, index: %d, reg_idx: %d, val: 0x%016llx\n",
+		type == ACA_ERROR_TYPE_UE ? "UE" : "CE", idx, reg_idx, *val);
+
+	return 0;
+}
+
+static int aca_smu_get_valid_aca_bank(struct amdgpu_device *adev,
+				      enum aca_error_type type, int idx, struct aca_bank *bank)
+{
+	int i, ret, count;
+
+	count = min_t(int, 16, ARRAY_SIZE(bank->regs));
+	for (i = 0; i < count; i++) {
+		ret = aca_bank_read_reg(adev, type, idx, i, &bank->regs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct aca_smu_funcs smu_v13_0_6_aca_smu_funcs = {
+	.max_ue_bank_count = 12,
+	.max_ce_bank_count = 12,
+	.set_debug_mode = aca_smu_set_debug_mode,
+	.get_valid_aca_count = aca_smu_get_valid_aca_count,
+	.get_valid_aca_bank = aca_smu_get_valid_aca_bank,
+};
+
 static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
 					       enum pp_xgmi_plpd_mode mode)
 {
@@ -2967,4 +3105,5 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->smc_driver_if_version = SMU13_0_6_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
 	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
+	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
 }
-- 
2.34.1

