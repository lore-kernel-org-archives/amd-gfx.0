Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083CFCA5523
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 09:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FDAF10E490;
	Wed, 13 Sep 2023 09:32:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0D810E490
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 09:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWCYLjPyhgTKGKOjJY90CyUqItF24tBWocHcHmWX+Og4V+PlvxL8vp1276welyDHcMpmGkv4UtIX+qjYH611tGuRDdTNXgLP9BtMnkKNwhES0cs00z0pzaQFVAYoBomdCfdMYew0Htw+NnQnYn/kFjsUcJPM8vzDXF3QzSeDDBKYOw9zPFqKEk3s46ZIB2I1ADgyYFqI7Ap1Nv4agl1m6FUkNMCFyndIM4hU3Mzzn0+VfcaC7v9YRLXWr01ftHvf9fGNE7CM1tyN1SUAg9RMCFIJITPsppMAI82FranPe/EXo328vpLlbbDPGSwvig4Y2DLViW0VeQjxjOQ/VyLAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW8sIr68yic9iy0EXyZAythYgPN8lUqC5VYsZ3llozs=;
 b=OPwkYAp2D7OxbAKLpwB6g2+GATDgFm/rVy4QU75BmrGmOaY0bMqkDcmFuvmVmY1R9y2tfFH3Qp99p19uRt1ijBqFO8akYpQh+3lSeF8EJa6Y9zTyylHp9KzhYgWcrz1+a4hAAHPU7ja3S2kd72qdnwyZSj9FCLkBf1yrRhL5scnR7yPv0kTkdfezNVX8DPA13y0CMCornpREGEhqtKvoKvj6C6wV9NG/GJ+I2fi1jHl/mn7GIZ7lWryrnntrCYOM/ffCzrI3jJFXbbOCAcr+m00Ck07dsinqjNcNy9QzBSN7Fn1KCrrq7oJYa43xYHuLayUu2QBr0lo6WNEUS3uCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW8sIr68yic9iy0EXyZAythYgPN8lUqC5VYsZ3llozs=;
 b=Ozu8RM3YQ3hKrguVBYbIeDo2SdFx40dX9VJ+pUWTz1UXVmtlvwYI9pCkkC3v69vyVlYtbTgeDM/VKda1/2TvGrB5/ATQ5QT6BNam9VXqJebmOKkUt8eKBZK39pb7bWoST/vDBd1d5TaHabXbTF3hwWMe/I0TXCePDWvdfB04SxA=
Received: from DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 09:32:30 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::9c) by DS7PR03CA0263.outlook.office365.com
 (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38 via Frontend
 Transport; Wed, 13 Sep 2023 09:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 09:32:30 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 04:32:17 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd/pm: add smu_13_0_6 mca dump support
Date: Wed, 13 Sep 2023 17:32:00 +0800
Message-ID: <20230913093200.312429-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913093200.312429-1-kevinyang.wang@amd.com>
References: <20230913093200.312429-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cecc3d-a679-414f-6728-08dbb43c59f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ghgdvaXeFJVlIffZdb41WiPqv2iHrw1tlXRYxo9QjrY/mG7cITq+JePv7Rsh9fyft/Sd0sODaWWa1/km66lIMu5OIV9hPTO8uDfDDG74bHmluzdwzThu8SHRNN0BQFMqBpyxUUu9GlRviWKniBWHdvRESf7QvYfHekhQhFBfuccNNhZO+KgF/qElrCeGHCQ9i6YykVlJBmMGWC0ZjeoBjlmDeOlFToB+H/JRFJVdlwb85vsz4U5fB7sYGiDO6d7dPpsIpGZs3yjfFnTdqahDZPE7BHkHLDvmb1i7uJxF44m0OSy4a/iqGgMezDTuzCLzxZ6DqzFuOR2SBErohMyBCzWop74jIAx0XG5pDHDpOKDfee10YKk74Dr5JpYTBaTqk5pMaXboH3U+96SHo6EZs3YjOiyiEVK9aCvjroLssZ1OP4ERVf7sHwHrVnuMTq7CTL97pNsOuaanLZDB1+ENL/4uu0t1sLvcetfOnu0oFcZVXfPjpfLD1rzOvZTOSk+QXPoF9K7yaZi+6tqCERsTmSpF9onS+831Wkk3mM0kL6OIkKh5j9MXldTQqEqdgHKIoyNVwRkVWhc7ZrjlccE0tLrgbWISTSnJ17EnLr3L/GX5sqbDKJEAk41UcEMyJVY6osUDpK29tO0r1FJTzhYeHzctTmnDIuUrlCbxfk470Kzf/s/c1DffcV4xdIVekPwu7ipuJEVPDXWbCtyMdZPgvLz/J9cpn6ROkpmF0W4OqynLnVUXI40nAFHF7NMKy0KLjwvU0ZPkOOJdWNe1TC1rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(7696005)(6666004)(83380400001)(86362001)(82740400003)(356005)(81166007)(47076005)(36756003)(2616005)(36860700001)(336012)(426003)(1076003)(40480700001)(16526019)(26005)(70586007)(6916009)(316002)(41300700001)(30864003)(4326008)(8676002)(54906003)(70206006)(2906002)(478600001)(5660300002)(8936002)(19627235002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:32:30.2633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cecc3d-a679-414f-6728-08dbb43c59f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
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
Cc: alexander.deucher@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
implement smu_v13_0_6 mca bank interface.

v2:
- remove unnecessary lock
- move MCMP1_* macros to mp_13_0_6_sh_mask.h file

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../include/asic_reg/mp/mp_13_0_6_sh_mask.h   |  28 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 515 ++++++++++++++++++
 2 files changed, 543 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h
index 780d9824d5ed..2684e396f548 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h
@@ -670,5 +670,33 @@
 #define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK                                                           0x00000001L
 #define MP1_FIRMWARE_FLAGS__RESERVED_MASK                                                                     0xFFFFFFFEL
 
+//MCMP1_IPIDT0
+#define MCMP1_IPIDT0__InstanceIdLo__SHIFT                                                                     0x0
+#define MCMP1_IPIDT0__HardwareID__SHIFT                                                                       0x20
+#define MCMP1_IPIDT0__InstanceIdHi__SHIFT                                                                     0x2c
+#define MCMP1_IPIDT0__McaType__SHIFT                                                                          0x30
+
+#define MCMP1_IPIDT0__InstanceIdLo_MASK                                                                       0x00000000FFFFFFFFL
+#define MCMP1_IPIDT0__HardwareID_MASK                                                                         0x00000FFF00000000L
+#define MCMP1_IPIDT0__InstanceIdHi_MASK                                                                       0x0000F00000000000L
+#define MCMP1_IPIDT0__McaType_MASK                                                                            0xFFFF000000000000L
+
+//MCMP1_STATUST0
+#define MCMP1_STATUST0__ErrorCode__SHIFT                                                                      0x0
+#define MCMP1_STATUST0__ErrorCodeExt__SHIFT                                                                   0x10
+#define MCMP1_STATUST0__PCC__SHIFT                                                                            0x39
+#define MCMP1_STATUST0__UC__SHIFT                                                                             0x3d
+#define MCMP1_STATUST0__Val__SHIFT                                                                            0x3f
+
+#define MCMP1_STATUST0__ErrorCode_MASK                                                                        0x000000000000FFFFL
+#define MCMP1_STATUST0__ErrorCodeExt_MASK                                                                     0x00000000003F0000L
+#define MCMP1_STATUST0__PCC_MASK                                                                              0x0200000000000000L
+#define MCMP1_STATUST0__UC_MASK                                                                               0x2000000000000000L
+#define MCMP1_STATUST0__Val_MASK                                                                              0x8000000000000000L
+
+//MCMP1_MISC0T0
+#define MCMP1_MISC0T0__ErrCnt__SHIFT                                                                          0x20
+
+#define MCMP1_MISC0T0__ErrCnt_MASK                                                                            0x00000FFF00000000L
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6be8299494ea..a53a459239f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -44,6 +44,7 @@
 #include "amdgpu_xgmi.h"
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
+#include "amdgpu_mca.h"
 #include "smu_cmn.h"
 #include "mp/mp_13_0_6_offset.h"
 #include "mp/mp_13_0_6_sh_mask.h"
@@ -91,6 +92,34 @@
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
 #define LINK_SPEED_MAX				4
 
+#define MCA_BANK_IPID(_ip, _hwid, _type) \
+	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
+
+enum mca_reg_idx {
+	MCA_REG_IDX_CONTROL		= 0,
+	MCA_REG_IDX_STATUS		= 1,
+	MCA_REG_IDX_ADDR		= 2,
+	MCA_REG_IDX_MISC0		= 3,
+	MCA_REG_IDX_CONFIG		= 4,
+	MCA_REG_IDX_IPID		= 5,
+	MCA_REG_IDX_SYND		= 6,
+	MCA_REG_IDX_COUNT		= 16,
+};
+
+struct mca_bank_ipid {
+	enum amdgpu_mca_ip ip;
+	uint16_t hwid;
+	uint16_t mcatype;
+};
+
+struct mca_ras_info {
+	enum amdgpu_ras_block blkid;
+	enum amdgpu_mca_ip ip;
+	int *err_code_array;
+	int err_code_count;
+	int (*get_err_count)(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev, enum amdgpu_mca_error_type type, int idx, uint32_t *count);
+};
+
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -2211,6 +2240,491 @@ static int smu_v13_0_6_post_init(struct smu_context *smu)
 	return 0;
 }
 
+static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	return smu_v13_0_6_mca_set_debug_mode(smu, enable);
+}
+
+static int smu_v13_0_6_get_valid_mca_count(struct smu_context *smu, enum amdgpu_mca_error_type type, uint32_t *count)
+{
+	uint32_t msg;
+	int ret;
+
+	if (!count)
+		return -EINVAL;
+
+	switch(type) {
+	case AMDGPU_MCA_ERROR_TYPE_UE:
+		msg = SMU_MSG_QueryValidMcaCount;
+		break;
+	case AMDGPU_MCA_ERROR_TYPE_CE:
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
+static int __smu_v13_0_6_mca_dump_bank(struct smu_context *smu, enum amdgpu_mca_error_type type, int idx, int offset, uint32_t *val)
+{
+	uint32_t msg, param;
+
+	switch(type) {
+	case AMDGPU_MCA_ERROR_TYPE_UE:
+		msg = SMU_MSG_McaBankDumpDW;
+		break;
+	case AMDGPU_MCA_ERROR_TYPE_CE:
+		msg = SMU_MSG_McaBankCeDumpDW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	param = ((idx & 0xffff) << 16) | (offset & 0xfffc);
+
+	return smu_cmn_send_smc_msg_with_param(smu, msg, param, val);
+}
+
+static int smu_v13_0_6_mca_dump_bank(struct smu_context *smu, enum amdgpu_mca_error_type type, int idx, int offset, uint32_t *val, int count)
+{
+	int ret, i;
+
+	if (!val)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++) {
+		ret = __smu_v13_0_6_mca_dump_bank(smu, type, idx, offset + (i << 2), &val[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct mca_bank_ipid smu_v13_0_6_mca_ipid_table[AMDGPU_MCA_IP_COUNT] = {
+	MCA_BANK_IPID(UMC, 0x96, 0x0),
+	MCA_BANK_IPID(SMU, 0x01, 0x1),
+	MCA_BANK_IPID(MP5, 0x01, 0x2),
+};
+
+static void mca_bank_entry_info_decode(struct mca_bank_entry *entry, struct mca_bank_info *info)
+{
+	uint64_t ipid = entry->regs[MCA_REG_IDX_IPID];
+	uint32_t insthi;
+
+	/* NOTE: All MCA IPID register share the same format,
+	 * so the driver can share the MCMP1 register header file.
+	 * */
+
+	info->hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
+	info->mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
+
+	insthi = REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi);
+	info->aid = ((insthi >> 2) & 0x03);
+	info->socket_id = insthi & 0x03;
+}
+
+static int mca_bank_read_reg(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, int idx, int reg_idx, uint64_t *val)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	uint32_t data[2] = {0, 0};
+	int ret;
+
+	if (!val || reg_idx >= MCA_REG_IDX_COUNT)
+		return -EINVAL;
+
+	ret = smu_v13_0_6_mca_dump_bank(smu, type, idx, reg_idx * 8, data, ARRAY_SIZE(data));
+	if (ret)
+		return ret;
+
+	*val = (uint64_t)data[1] << 32 | data[0];
+
+	dev_dbg(adev->dev, "mca read bank reg: type:%s, index: %d, reg_idx: %d, val: 0x%016llx\n",
+		type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE", idx, reg_idx, *val);
+
+	return 0;
+}
+
+static int mca_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, int idx, struct mca_bank_entry *entry)
+{
+	int i, ret;
+
+	/* NOTE: populated all mca register by default */
+	for (i = 0; i < ARRAY_SIZE(entry->regs); i++) {
+		ret = mca_bank_read_reg(adev, type, idx, i, &entry->regs[i]);
+		if (ret)
+			return ret;
+	}
+
+	if (ret)
+		return ret;
+
+	entry->idx = idx;
+	entry->type = type;
+
+	mca_bank_entry_info_decode(entry, &entry->info);
+
+	return 0;
+}
+
+static int mca_decode_mca_ipid(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, int idx, int *ip)
+{
+	const struct mca_bank_ipid *ipid;
+	uint64_t val;
+	uint16_t hwid, mcatype;
+	int i, ret;
+
+	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_IPID, &val);
+	if (ret)
+		return ret;
+
+	hwid = REG_GET_FIELD(val, MCMP1_IPIDT0, HardwareID);
+	mcatype = REG_GET_FIELD(val, MCMP1_IPIDT0, McaType);
+
+	if (hwid) {
+		for (i = 0; i < ARRAY_SIZE(smu_v13_0_6_mca_ipid_table); i++) {
+			ipid = &smu_v13_0_6_mca_ipid_table[i];
+
+			if (!ipid->hwid)
+				continue;
+
+			if (ipid->hwid == hwid && ipid->mcatype == mcatype) {
+				*ip = i;
+				return 0;
+			}
+		}
+	}
+
+	*ip = AMDGPU_MCA_IP_UNKNOW;
+
+	return 0;
+}
+
+static int mca_normal_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev, enum amdgpu_mca_error_type type, int idx, uint32_t *count)
+{
+	uint64_t status0;
+	int ret;
+
+	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_STATUS, &status0);
+	if (ret)
+		return ret;
+
+	if (REG_GET_FIELD(status0, MCMP1_STATUST0, Val))
+		*count = 1;
+	else
+		*count = 0;
+
+	return 0;
+}
+
+static bool mca_smu_check_error_code(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras, uint32_t errcode)
+{
+	int i;
+
+	if (!mca_ras->err_code_count || !mca_ras->err_code_array)
+		return true;
+
+	for (i = 0; i < mca_ras->err_code_count; i++) {
+		if (errcode == mca_ras->err_code_array[i])
+			return true;
+	}
+
+	return false;
+}
+
+static int mca_mp5_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev, enum amdgpu_mca_error_type type, int idx, uint32_t *count)
+{
+	uint64_t status0 = 0, misc0 = 0;
+	uint32_t errcode;
+	int ret;
+
+	if (mca_ras->ip != AMDGPU_MCA_IP_MP5)
+		return -EINVAL;
+
+	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_STATUS, &status0);
+	if (ret)
+		return ret;
+
+	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
+		*count = 0;
+		return 0;
+	}
+
+	errcode = REG_GET_FIELD(status0, MCMP1_STATUST0, ErrorCode);
+	if (!mca_smu_check_error_code(adev, mca_ras, errcode))
+		return 0;
+
+	if (type == AMDGPU_MCA_ERROR_TYPE_UE &&
+	    REG_GET_FIELD(status0, MCMP1_STATUST0, UC) == 1 &&
+	    REG_GET_FIELD(status0, MCMP1_STATUST0, PCC) == 1) {
+		if (count)
+			*count = 1;
+		return 0;
+	}
+
+	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_MISC0, &misc0);
+	if (ret)
+		return ret;
+
+	if (count)
+		*count = REG_GET_FIELD(misc0, MCMP1_MISC0T0, ErrCnt);
+
+	return 0;
+}
+
+static int mca_smu_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev, enum amdgpu_mca_error_type type, int idx, uint32_t *count)
+{
+	uint64_t status0 = 0, misc0 = 0;
+	uint32_t errcode;
+	int ret;
+
+	if (mca_ras->ip != AMDGPU_MCA_IP_SMU)
+		return -EINVAL;
+
+	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_STATUS, &status0);
+	if (ret)
+		return ret;
+
+	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
+		*count = 0;
+		return 0;
+	}
+
+	errcode = REG_GET_FIELD(status0, MCMP1_STATUST0, ErrorCode);
+	if (!mca_smu_check_error_code(adev, mca_ras, errcode))
+		return 0;
+
+	if (type == AMDGPU_MCA_ERROR_TYPE_UE &&
+	    REG_GET_FIELD(status0, MCMP1_STATUST0, UC) == 1 &&
+	    REG_GET_FIELD(status0, MCMP1_STATUST0, PCC) == 1) {
+		if (count)
+			*count = 1;
+		return 0;
+	}
+
+	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_MISC0, &misc0);
+	if (ret)
+		return ret;
+
+	if (count)
+		*count = REG_GET_FIELD(misc0, MCMP1_MISC0T0, ErrCnt);
+
+	return 0;
+}
+
+static int sdma_err_codes[] = { CODE_SDMA0, CODE_SDMA1, CODE_SDMA2, CODE_SDMA3 };
+static int mmhub_err_codes[] = {
+	CODE_DAGB0, CODE_DAGB0 + 1, CODE_DAGB0 + 2, CODE_DAGB0 + 3, CODE_DAGB0 + 4, /* DAGB0-4 */
+	CODE_EA0, CODE_EA0 + 1, CODE_EA0 + 2, CODE_EA0 + 3, CODE_EA0 + 4,	/* MMEA0-4*/
+	CODE_VML2, CODE_VML2_WALKER, CODE_MMCANE,
+};
+
+static const struct mca_ras_info mca_ras_table[] = {
+	{
+		.blkid = AMDGPU_RAS_BLOCK__UMC,
+		.ip = AMDGPU_MCA_IP_UMC,
+		.get_err_count = mca_normal_mca_get_err_count,
+	}, {
+		.blkid = AMDGPU_RAS_BLOCK__GFX,
+		.ip = AMDGPU_MCA_IP_MP5,
+		.get_err_count = mca_mp5_mca_get_err_count,
+	}, {
+		.blkid = AMDGPU_RAS_BLOCK__SDMA,
+		.ip = AMDGPU_MCA_IP_SMU,
+		.err_code_array = sdma_err_codes,
+		.err_code_count = ARRAY_SIZE(sdma_err_codes),
+		.get_err_count = mca_smu_mca_get_err_count,
+	}, {
+		.blkid = AMDGPU_RAS_BLOCK__MMHUB,
+		.ip = AMDGPU_MCA_IP_SMU,
+		.err_code_array = mmhub_err_codes,
+		.err_code_count = ARRAY_SIZE(mmhub_err_codes),
+		.get_err_count = mca_smu_mca_get_err_count,
+	},
+};
+
+static const struct mca_ras_info *mca_get_mca_ras_info(struct amdgpu_device *adev, enum amdgpu_ras_block blkid)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mca_ras_table); i++) {
+		if (mca_ras_table[i].blkid == blkid)
+			return &mca_ras_table[i];
+	}
+
+	return NULL;
+}
+
+static int mca_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
+
+	switch (type) {
+	case AMDGPU_MCA_ERROR_TYPE_UE:
+	case AMDGPU_MCA_ERROR_TYPE_CE:
+		ret = smu_v13_0_6_get_valid_mca_count(smu, type, count);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static bool mca_bank_is_valid(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras, enum amdgpu_mca_error_type type, int idx)
+{
+	int ret, ip = AMDGPU_MCA_IP_UNKNOW;
+
+	ret = mca_decode_mca_ipid(adev, type, idx, &ip);
+	if (ret)
+		return false;
+
+	if (ip == AMDGPU_MCA_IP_UNKNOW)
+		return false;
+
+	return ip == mca_ras->ip;
+}
+
+static int mca_get_valid_mca_idx(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras, enum amdgpu_mca_error_type type,
+				 uint32_t mca_cnt, int *idx_array, int idx_array_size)
+{
+	int i, idx_cnt = 0;
+
+	for (i = 0; i < mca_cnt; i++) {
+		if (!mca_bank_is_valid(adev, mca_ras, type, i))
+			continue;
+
+		if (idx_array) {
+			if (idx_cnt < idx_array_size)
+				idx_array[idx_cnt] = i;
+			else
+				return -EINVAL;
+		}
+
+		idx_cnt++;
+	}
+
+	return idx_cnt;
+}
+
+static int __mca_smu_get_error_count(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras, enum amdgpu_mca_error_type type, uint32_t *count)
+{
+	uint32_t result, mca_cnt, total = 0;
+	int idx_array[16];
+	int i, ret, idx_cnt = 0;
+
+	ret = mca_get_valid_mca_count(adev, type, &mca_cnt);
+	if (ret)
+		return ret;
+
+	/* if valid mca bank count is 0, the driver can return 0 directly */
+	if (!mca_cnt) {
+		*count = 0;
+		return 0;
+	}
+
+	if (!mca_ras->get_err_count)
+		return -EINVAL;
+
+	idx_cnt = mca_get_valid_mca_idx(adev, mca_ras, type, mca_cnt, idx_array, ARRAY_SIZE(idx_array));
+	if (idx_cnt < 0)
+		return -EINVAL;
+
+	for (i = 0; i < idx_cnt; i++) {
+		result = 0;
+		ret = mca_ras->get_err_count(mca_ras, adev, type, idx_array[i], &result);
+		if (ret)
+			return ret;
+
+		total += result;
+	}
+
+	*count = total;
+
+	return 0;
+}
+
+static int mca_smu_get_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, uint32_t *count)
+{
+	const struct mca_ras_info *mca_ras;
+
+	if (!count)
+		return -EINVAL;
+
+	mca_ras = mca_get_mca_ras_info(adev, blk);
+	if (!mca_ras)
+		return -ENOTSUPP;
+
+	return __mca_smu_get_error_count(adev, mca_ras, type, count);
+}
+
+static int __mca_smu_get_ras_mca_idx_array(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras, enum amdgpu_mca_error_type type, int *idx_array, int *idx_array_size)
+{
+	uint32_t mca_cnt = 0;
+	int ret, idx_cnt = 0;
+
+	ret = mca_get_valid_mca_count(adev, type, &mca_cnt);
+	if (ret)
+		return ret;
+
+	/* if valid mca bank count is 0, the driver can return 0 directly */
+	if (!mca_cnt) {
+		*idx_array_size = 0;
+		return 0;
+	}
+
+	idx_cnt = mca_get_valid_mca_idx(adev, mca_ras, type, mca_cnt, idx_array, *idx_array_size);
+	if (idx_cnt < 0)
+		return -EINVAL;
+
+	*idx_array_size = idx_cnt;
+
+	return 0;
+}
+
+static int mca_smu_get_ras_mca_idx_array(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, int *idx_array, int *idx_array_size)
+{
+	const struct mca_ras_info *mca_ras;
+
+	mca_ras = mca_get_mca_ras_info(adev, blk);
+	if (!mca_ras)
+		return -ENOTSUPP;
+
+	return __mca_smu_get_ras_mca_idx_array(adev, mca_ras, type, idx_array, idx_array_size);
+}
+
+static int mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, int idx, struct mca_bank_entry *entry)
+{
+	return mca_get_mca_entry(adev, type, idx,entry);
+}
+
+static int mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
+{
+	return mca_get_valid_mca_count(adev, type, count);
+}
+
+static const struct amdgpu_mca_smu_funcs smu_v13_0_6_mca_smu_funcs = {
+	.max_ue_count = 12,
+	.max_ce_count = 12,
+	.mca_set_debug_mode = mca_smu_set_debug_mode,
+	.mca_get_error_count = mca_smu_get_error_count,
+	.mca_get_mca_entry = mca_smu_get_mca_entry,
+	.mca_get_valid_mca_count = mca_smu_get_valid_mca_count,
+	.mca_get_ras_mca_idx_array = mca_smu_get_ras_mca_idx_array,
+};
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -2276,4 +2790,5 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v13_0_6_table_map;
 	smu->smc_driver_if_version = SMU13_0_6_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
+	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
 }
-- 
2.34.1

