Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387DDC47079
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39AE10E242;
	Wed,  3 Jan 2024 08:03:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F2410E248
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHPk1odfSXyvfkuNHu6FmcjOlXDKHWMaOq9BUlEuAvCeA5NVnu0tMcBVQFM6NFIYwsUNdcak1QYmRIlsYO0PzlacU4e5p8cJkalaV9oaKwnz3HWNyA8AzIoPBCPyPnoNkSMjj7LX2qIGnR30lh0FYPJQ0AFsSEjW1cBuvrPBNSu8DQWXUmeGa5c4FpPSwvOxHRUP27lf/5922lLfPrYrgunNPEbXVmoYYdnsdeUGaZuUXnMFUtV/OZKmrf1s4uLMrXRVFKEEvaWP3i+7fVxQKAu4SNljA6s8Efxr5Kwu5FqLYWvNBOjlua1WgQrRJ6mbg/uls0RDiABsre0IRMsUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wbql02lgoAkkNgcAja+NhkPRbG2SXL2OixTobQ2Lwk=;
 b=ewYTL/V17IgmLS5qXgTB/L/QAF7RZiM9YTyQrRgoEAZhxrgWDfxLvS884IANW0RcB7rSeo8yx1TCMUjh5wRDH3b6CA/Xvv/kJura70zqds8N97RU1fJQHmbDHzSn4ahDjgccD0ZpY0UEev1v+f9WrWTASlUGpGWzb6KeHZ071DrFSDJ0439y2M2YCCtBKFzy13M8vC9YmEG0WR4feW6Wv+Q4kraO4T42OBKPPPbzF6jx0zKImHjJ2kac/U/zesEqBJKal++MbTs0bKm4LnnfxTgt0xhkpYvwtw8Qx0qLV3Nrxgz2BK6Gyb8tYuspyHxVtbLU8j+sFCEbf89CZzl+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wbql02lgoAkkNgcAja+NhkPRbG2SXL2OixTobQ2Lwk=;
 b=dUzPShD8/9InX/Qx1wB4YfsabkVQEdu0S+AMlks/z+xoKpW3pSyn7rgAxUER2O1hXtIy1Fbj4PHFB3dIwD9kZvtvhSQlxy6To3rRE266XAa5ujigMOIwuDn5OX5h4LotOQ1SOELVt56mwhvq5qBTvIKY0E+m/263g9EUMN1wg8Q=
Received: from SJ0PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:33f::13)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:03:49 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::12) by SJ0PR05CA0038.outlook.office365.com
 (2603:10b6:a03:33f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:48 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:10 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/pm: add aca smu backend support for smu v13.0.6
Date: Wed, 3 Jan 2024 16:02:10 +0800
Message-ID: <20240103080220.2815115-5-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 25af1410-a314-490f-0918-08dc0c328475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcbesKEoKuFRnesIx/CIrBsGKQ+xWDDjR1IK86eGgdaezrAwlAzSoSRlEgAW0wNgOfOVfW+Qch0wXSvcem/DfqpMEvaAfykpeKOwZWTLCvLlZGpDp5LJ6JiNt4mfM64FvNWUAheVsHSiAIXsr0M5NdPCsetfNFcHR3g7um+Xa3sBfqQyo5X9JDc53BH3XkwcR2ThKRZVLpv428UJoN4VR3/U5Hn56mFcVmvvKTbkER0D+RDFkDK99i0xtITWs9EfCVGrdbKWBuqrFnRGM3fBSMSHLAkSYGU4KqKK491AIeG1iCmFJaVZSZz1YHfDoy/rKh3udjAenoVulHCT1+I0bC6vK2sge8UamYcdEF1DlHTlXMcsh9fDPkWorKT3EpF82Z5FlliEjMUvEI1Ua2W3012nOjRDV9Sv3g8CU8fdV+8emG4TrE7x3o1lGQNsjVpeadWb51vHyHNXjV9vYvbxK3WzO9udiena+UYbxYOjRPyRM3eW8hqrlaLEh39XBKQL/kD4JpnU2VUma80SiU8WZ6RQ7MeOZm+k8pQQ9WmzMzJ4rS7pj4GR3b7ie3PaDZb6F46p6GM/Kc4IyZQfGj7vYjSNQVvLwayPzFLQzXikxiDN78rYL2l+ZaBcGeYiNMyAKKxJa2cuiAZPoHtCXLR9Ixtik3qQolyFH28/U7rV/71siVbL7nG8x3f7Myf10VE5igK5lDk63v+KEYVfqOLpx/Y1/vY+cMwWOi2HEyvpwR8wCh6Nhnc2NKPlRjlsKJCW+EAZW6RjPCB0KgHlzLe9sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(426003)(16526019)(336012)(83380400001)(1076003)(26005)(36756003)(86362001)(81166007)(82740400003)(356005)(8676002)(47076005)(4326008)(41300700001)(5660300002)(8936002)(2616005)(7696005)(36860700001)(70586007)(70206006)(54906003)(316002)(6916009)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:48.8678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25af1410-a314-490f-0918-08dc0c328475
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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
index 4ebc6b421c2c..bed75af45369 100644
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
+	.max_ue_aca_count = 12,
+	.max_ce_aca_count = 12,
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

