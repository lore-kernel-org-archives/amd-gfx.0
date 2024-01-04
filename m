Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C93C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012D810E410;
	Thu,  4 Jan 2024 11:49:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913D310E410
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyF9dWolvO9VZAQM2dI8Plr/GBoC+VurDFjd8tX9+Fo0bxRFi1tFGcY4GeV0ulBhYdMeILQc3QIFVsoAPtBWviA5o65b9vejflBYhUqmOqeltTluVh3abyLMMyhm128iqEseUUcjIiX6SQhdRWwIFyIQcitfCV9l6u8t755WSmM1QkVtSRpy9KGe0GmUPucb1mMI4h0Yd/y2LFGjxFGJTxRFqUb+56YgfIkDx+/Pju5lay6wxnCCx0Wh6pt9+0Nx620FIEmKzJYy0vUozQwDbdpJykQ3KwFOJFx8yDG4j1HR82Uv0FbfY9htY9JyyohYc6wzbJkGGHpzW1ZCtY7vGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp9ICiQrCDXEnkW0rOu/hrJ9eG+Tt6ABiq0GISDdqkw=;
 b=BnFJU0hO5/B1Eo/7EhR2NeS1pX+GD7bASLqTThHfu5u8x2DMJqXlo1NxVQGrcjC6y5Nl4OPWHMmLyGD8EELla+MFeqrpxDj1decyycekUbHRP6QQkSCrXIl/UgKZsIWp3jDZF4MbLjm0CLEvw6M36qyK+N2sdC0JBZjPtyFsGZDlIfruvV+b2C0s4lOBNrjvI+qXaKDRrLLPe/yOmhXfu3vGwGK5r/+GvZnnCx1c+EhdpF5n1uOLlOU37NV/0tn8FkU2SdlTvVH1EVcwcNtHy10hCF5ukJ0Rz/lcVz5ad+9HrrJc1FxpjxOyKzeVapXddpx77ycrzFVZSBHC9UQmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp9ICiQrCDXEnkW0rOu/hrJ9eG+Tt6ABiq0GISDdqkw=;
 b=O7fNXNq4/IiT07mjYqQpVCUhzY5bTt7LG8riY8CoXCuN1bGy1feI8GgUAyLtWouGeWc4uyq/TKAOVkCz4SXTIjyLIT9WbdbBoGARLpHmqAl28yjpk2cVgGD+iXFuGATc7PkarKEBctN7rSoAxcZ6ec0t9SZ7lOWIW9pC3P8QTY4=
Received: from BYAPR08CA0019.namprd08.prod.outlook.com (2603:10b6:a03:100::32)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 11:49:23 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::67) by BYAPR08CA0019.outlook.office365.com
 (2603:10b6:a03:100::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:23 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:20 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 01/12] drm/amdgpu: implement RAS ACA driver framework
Date: Thu, 4 Jan 2024 19:48:47 +0800
Message-ID: <20240104114858.3475783-2-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: e67d1f06-587e-4082-621f-08dc0d1b31f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4qnIm0yNKtCwuMun7DCLwCatV9feS/F4eT2U1x/rKrqiDoLcIrGSl9IRogudfkIGaKDByaE7eJakAVfaSGG2uoRAsYgK1RsdfAvVAJUf/9Kasra4YspRwlxXsnVrNwc4xqUPiF5YWL4Sr7M1IzrrjBrWfr7FfdjEtef6VLmQ+MYDglrrnQbXkrVk+rTC6m4lXgVcZoADVVuK+0GEmE4I3Qxg1K5nPUATgdPWnCh0Vy9czcWt+Wv32YnNyS6OSWArc5coRfnImdtVG9Bx9/xgPd5FQ8f8Me4UuYy3In/4UFENEnT4VsFLyqhtkNY4pHv5CUy5/5tDdtuQx4mKV6a9v5VqigpzmVfetkoE3XLhUx3CpMlWgGRRwMxmuKZAbody5cuwvWCHHz1ZeejiuICbVQjOPpj8GKJdPEUICDcbXiR3vA2Er48bqA82lGQ/hL2keHC8YhJfFtSJxRNqhecpQoQMbfhFCtaseHtTmaZLIBEItIBruxQpY9K7nJAGynG8LedoX20ssx6ZSYICaypPG1hOXueueexBfNdSgVePqZhO6CwRT1nM/xKh32Z5Ffj1lrNLYL3GBa0+cI4uGLJ+69V+sz3TkOG7tWxhrkJ1lblhW8rGgivq336mRslXgS6VNgB2q6Yo/fmDqG3vWhrtu4yWQxHLx3RoOxf7r7AiBXVAgdHXHYgqvfaNtWMhPFnGCiJ7JimhczZmE2UgLDIMiqDPVRaQOnkg/+1/8uEoM+aNqg2dQWnFF07WV8FGL/22kU2uJz8xuPgxRDEjMTfzIS+SBk4W+xmJYFDAes2Zbg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(40460700003)(6666004)(7696005)(40480700001)(66899024)(81166007)(54906003)(316002)(5660300002)(8936002)(356005)(8676002)(36860700001)(47076005)(82740400003)(30864003)(2906002)(4326008)(336012)(426003)(86362001)(83380400001)(478600001)(26005)(1076003)(41300700001)(36756003)(70206006)(70586007)(16526019)(6916009)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:23.1230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67d1f06-587e-4082-621f-08dc0d1b31f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
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
implement new RAS ACA driver code framework.

v2:
- rename aca_bank_set to aca_banks.
- rename aca_source_xxx to aca_handle_xxx

v3:
- Optimize some function implementation details. (from Hawking's suggestion)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c    | 665 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h    | 196 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
 6 files changed, 873 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 260e32ef7bae..4c989da4d2f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -80,7 +80,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o
+	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9da14436a373..eb182225f548 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_smuio.h"
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
+#include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
@@ -1047,6 +1048,9 @@ struct amdgpu_device {
 	/* MCA */
 	struct amdgpu_mca               mca;
 
+	/* ACA */
+	struct amdgpu_aca		aca;
+
 	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
 	uint32_t		        harvest_ip_mask;
 	int				num_ip_blocks;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
new file mode 100644
index 000000000000..756b40bde38b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -0,0 +1,665 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/list.h>
+#include "amdgpu.h"
+#include "amdgpu_aca.h"
+#include "amdgpu_ras.h"
+
+#define ACA_BANK_HWID(type, hwid, mcatype) [ACA_HWIP_TYPE_##type] = {hwid, mcatype}
+
+typedef int bank_handler_t(struct aca_handle *handle, struct aca_bank *bank, enum aca_error_type type, void *data);
+
+struct aca_banks {
+	int nr_banks;
+	struct list_head list;
+};
+
+struct aca_hwip {
+	int hwid;
+	int mcatype;
+};
+
+static struct aca_hwip aca_hwid_mcatypes[ACA_HWIP_TYPE_COUNT] = {
+	ACA_BANK_HWID(SMU,	0x01,	0x01),
+	ACA_BANK_HWID(PCS_XGMI, 0x50,	0x00),
+	ACA_BANK_HWID(UMC,	0x96,	0x00),
+};
+
+static void aca_banks_init(struct aca_banks *banks)
+{
+	if (!banks)
+		return;
+
+	memset(banks, 0, sizeof(*banks));
+	INIT_LIST_HEAD(&banks->list);
+}
+
+static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank *bank)
+{
+	struct aca_bank_node *node;
+
+	if (!bank)
+		return -EINVAL;
+
+	node = kvzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	memcpy(&node->bank, bank, sizeof(*bank));
+
+	INIT_LIST_HEAD(&node->node);
+	list_add_tail(&node->node, &banks->list);
+
+	banks->nr_banks++;
+
+	return 0;
+}
+
+static void aca_banks_release(struct aca_banks *banks)
+{
+	struct aca_bank_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, &banks->list, node) {
+		list_del(&node->node);
+		kvfree(node);
+	}
+}
+
+static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum aca_error_type type, u32 *count)
+{
+	struct amdgpu_aca *aca = &adev->aca;
+	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
+
+	if (!count)
+		return -EINVAL;
+
+	if (!smu_funcs || !smu_funcs->get_valid_aca_count)
+		return -EOPNOTSUPP;
+
+	return smu_funcs->get_valid_aca_count(adev, type, count);
+}
+
+static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_error_type type,
+				       int start, int count,
+				       struct aca_banks *banks)
+{
+	struct amdgpu_aca *aca = &adev->aca;
+	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
+	struct aca_bank bank;
+	int i, max_count, ret;
+
+	if (!count)
+		return 0;
+
+	if (!smu_funcs || !smu_funcs->get_valid_aca_bank)
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case ACA_ERROR_TYPE_UE:
+		max_count = smu_funcs->max_ue_bank_count;
+		break;
+	case ACA_ERROR_TYPE_CE:
+		max_count = smu_funcs->max_ce_bank_count;
+		break;
+	case ACA_ERROR_TYPE_DEFERRED:
+	default:
+		return -EINVAL;
+	}
+
+	if (start + count >= max_count)
+		return -EINVAL;
+
+	count = min_t(int, count, max_count);
+	for (i = 0; i < count; i++) {
+		memset(&bank, 0, sizeof(bank));
+		ret = smu_funcs->get_valid_aca_bank(adev, type, start + i, &bank);
+		if (ret)
+			return ret;
+
+		ret = aca_banks_add_bank(banks, &bank);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type type)
+{
+
+	struct aca_hwip *hwip;
+	int hwid, mcatype;
+	u64 ipid;
+
+	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
+		return -EINVAL;
+
+	hwip = &aca_hwid_mcatypes[type];
+	if (!hwip->hwid)
+		return false;
+
+	ipid = bank->regs[ACA_REG_IDX_IPID];
+	hwid = ACA_REG__IPID__HARDWAREID(ipid);
+	mcatype = ACA_REG__IPID__MCATYPE(ipid);
+
+	return hwip->hwid == hwid && hwip->mcatype == mcatype;
+}
+
+static bool aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank, enum aca_error_type type)
+{
+	const struct aca_bank_ops *bank_ops = handle->bank_ops;
+
+	if (!aca_bank_hwip_is_matched(bank, handle->hwip))
+		return false;
+
+	if (!bank_ops->aca_bank_is_valid)
+		return true;
+
+	return bank_ops->aca_bank_is_valid(handle, bank, type, handle->data);
+}
+
+static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_bank_info *info)
+{
+	struct aca_bank_error *bank_error;
+
+	bank_error = kvzalloc(sizeof(*bank_error), GFP_KERNEL);
+	if (!bank_error)
+		return NULL;
+
+	INIT_LIST_HEAD(&bank_error->node);
+	memcpy(&bank_error->info, info, sizeof(*info));
+
+	mutex_lock(&aerr->lock);
+	list_add_tail(&bank_error->node, &aerr->list);
+	mutex_unlock(&aerr->lock);
+
+	return bank_error;
+}
+
+static struct aca_bank_error *find_bank_error(struct aca_error *aerr, struct aca_bank_info *info)
+{
+	struct aca_bank_error *bank_error = NULL;
+	struct aca_bank_info *tmp_info;
+	bool found = false;
+
+	mutex_lock(&aerr->lock);
+	list_for_each_entry(bank_error, &aerr->list, node) {
+		tmp_info = &bank_error->info;
+		if (tmp_info->socket_id == info->socket_id &&
+		    tmp_info->die_id == info->die_id) {
+			found = true;
+			goto out_unlock;
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&aerr->lock);
+
+	return found ? bank_error : NULL;
+}
+
+static void aca_bank_error_remove(struct aca_error *aerr, struct aca_bank_error *bank_error)
+{
+	if (!aerr || !bank_error)
+		return;
+
+	list_del(&bank_error->node);
+	aerr->nr_errors--;
+
+	kvfree(bank_error);
+}
+
+static struct aca_bank_error *get_bank_error(struct aca_error *aerr, struct aca_bank_info *info)
+{
+	struct aca_bank_error *bank_error;
+
+	if (!aerr || !info)
+		return NULL;
+
+	bank_error = find_bank_error(aerr, info);
+	if (bank_error)
+		return bank_error;
+
+	return new_bank_error(aerr, info);
+}
+
+static int aca_log_errors(struct aca_handle *handle, enum aca_error_type type,
+				struct aca_bank_report *report)
+{
+	struct aca_error_cache *error_cache = &handle->error_cache;
+	struct aca_bank_error *bank_error;
+	struct aca_error *aerr;
+
+	if (!handle || !report)
+		return -EINVAL;
+
+	if (!report->count)
+		return 0;
+
+	aerr = &error_cache->errors[type];
+	bank_error = get_bank_error(aerr, &report->info);
+	if (!bank_error)
+		return -ENOMEM;
+
+	bank_error->count += report->count;
+
+	return 0;
+}
+
+static int aca_generate_bank_report(struct aca_handle *handle, struct aca_bank *bank,
+				    enum aca_error_type type, struct aca_bank_report *report)
+{
+	const struct aca_bank_ops *bank_ops = handle->bank_ops;
+
+	if (!bank || !report)
+		return -EINVAL;
+
+	if (!bank_ops->aca_bank_generate_report)
+		return -EOPNOTSUPP;
+
+	memset(report, 0, sizeof(*report));
+	return bank_ops->aca_bank_generate_report(handle, bank, type,
+						  report, handle->data);
+}
+
+static int handler_aca_log_bank_error(struct aca_handle *handle, struct aca_bank *bank,
+				      enum aca_error_type type, void *data)
+{
+	struct aca_bank_report report;
+	int ret;
+
+	ret = aca_generate_bank_report(handle, bank, type, &report);
+	if (ret)
+		return ret;
+
+	if (!report.count)
+		return 0;
+
+	ret = aca_log_errors(handle, type, &report);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_bank *bank,
+			     enum aca_error_type type, bank_handler_t handler, void *data)
+{
+	struct aca_handle *handle;
+	int ret;
+
+	if (list_empty(&mgr->list))
+		return 0;
+
+	list_for_each_entry(handle, &mgr->list, node) {
+		if (!aca_bank_is_valid(handle, bank, type))
+			continue;
+
+		ret = handler(handle, bank, type, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_banks *banks,
+			      enum aca_error_type type, bank_handler_t handler, void *data)
+{
+	struct aca_bank_node *node;
+	struct aca_bank *bank;
+	int ret;
+
+	if (!mgr || !banks)
+		return -EINVAL;
+
+	/* pre check to avoid unnecessary operations */
+	if (list_empty(&mgr->list) || list_empty(&banks->list))
+		return 0;
+
+	list_for_each_entry(node, &banks->list, node) {
+		bank = &node->bank;
+
+		ret = aca_dispatch_bank(mgr, bank, type, handler, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int aca_banks_update(struct amdgpu_device *adev, enum aca_error_type type,
+			    bank_handler_t handler, void *data)
+{
+	struct amdgpu_aca *aca = &adev->aca;
+	struct aca_banks banks;
+	u32 count = 0;
+	int ret;
+
+	if (list_empty(&aca->mgr.list))
+		return 0;
+
+	ret = aca_smu_get_valid_aca_count(adev, type, &count);
+	if (ret)
+		return ret;
+
+	if (!count)
+		return 0;
+
+	aca_banks_init(&banks);
+
+	ret = aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks);
+	if (ret)
+		goto err_release_banks;
+
+	if (list_empty(&banks.list)) {
+		ret = 0;
+		goto err_release_banks;
+	}
+
+	ret = aca_dispatch_banks(&aca->mgr, &banks, type,
+				 handler, data);
+	if (ret)
+		goto err_release_banks;
+
+err_release_banks:
+	aca_banks_release(&banks);
+
+	return ret;
+}
+
+static int aca_log_aca_error_data(struct aca_bank_error *bank_error, enum aca_error_type type, struct ras_err_data *err_data)
+{
+	struct aca_bank_info *info;
+	struct amdgpu_smuio_mcm_config_info mcm_info;
+
+	if (!bank_error->count)
+		return 0;
+
+	info = &bank_error->info;
+	mcm_info.die_id = info->die_id;
+	mcm_info.socket_id = info->socket_id;
+
+	switch (type) {
+	case ACA_ERROR_TYPE_UE:
+		amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, bank_error->count);
+		break;
+	case ACA_ERROR_TYPE_CE:
+		amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, bank_error->count);
+		break;
+	case ACA_ERROR_TYPE_DEFERRED:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int aca_log_aca_error(struct aca_handle *handle, enum aca_error_type type, struct ras_err_data *err_data)
+{
+	struct aca_error_cache *error_cache = &handle->error_cache;
+	struct aca_error *aerr = &error_cache->errors[type];
+	struct aca_bank_error *bank_error, *tmp;
+
+	mutex_lock(&aerr->lock);
+
+	if (list_empty(&aerr->list))
+		goto out_unlock;
+
+	list_for_each_entry_safe(bank_error, tmp, &aerr->list, node) {
+		aca_log_aca_error_data(bank_error, type, err_data);
+		aca_bank_error_remove(aerr, bank_error);
+	}
+
+out_unlock:
+	mutex_unlock(&aerr->lock);
+
+	return 0;
+}
+
+static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle, enum aca_error_type type,
+				struct ras_err_data *err_data)
+{
+	int ret;
+
+	/* udpate aca bank to aca source error_cache first */
+	ret = aca_banks_update(adev, type, handler_aca_log_bank_error, NULL);
+	if (ret)
+		return ret;
+
+	return aca_log_aca_error(handle, type, err_data);
+}
+
+static bool aca_handle_is_valid(struct aca_handle *handle)
+{
+	if (!handle->mask || !list_empty(&handle->node))
+		return false;
+
+	return true;
+}
+
+int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
+			      enum aca_error_type type, void *data)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+
+	if (!handle || !err_data)
+		return -EINVAL;
+
+	if (aca_handle_is_valid(handle))
+		return -EOPNOTSUPP;
+
+	if (!(BIT(type) & handle->mask))
+		return  0;
+
+	return __aca_get_error_data(adev, handle, type, err_data);
+}
+
+static void aca_error_init(struct aca_error *aerr, enum aca_error_type type)
+{
+	mutex_init(&aerr->lock);
+	INIT_LIST_HEAD(&aerr->list);
+	aerr->type = type;
+	aerr->nr_errors = 0;
+}
+
+static void aca_init_error_cache(struct aca_handle *handle)
+{
+	struct aca_error_cache *error_cache = &handle->error_cache;
+	int type;
+
+	for (type = ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type++)
+		aca_error_init(&error_cache->errors[type], type);
+}
+
+static void aca_error_fini(struct aca_error *aerr)
+{
+	struct aca_bank_error *bank_error, *tmp;
+
+	mutex_lock(&aerr->lock);
+	list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
+		aca_bank_error_remove(aerr, bank_error);
+
+	mutex_destroy(&aerr->lock);
+}
+
+static void aca_fini_error_cache(struct aca_handle *handle)
+{
+	struct aca_error_cache *error_cache = &handle->error_cache;
+	int type;
+
+	for (type = ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type++)
+		aca_error_fini(&error_cache->errors[type]);
+}
+
+static int add_aca_handle(struct amdgpu_device *adev, struct aca_handle_manager *mgr, struct aca_handle *handle,
+			  const char *name, const struct aca_info *ras_info, void *data)
+{
+	memset(handle, 0, sizeof(*handle));
+
+	handle->adev = adev;
+	handle->mgr = mgr;
+	handle->name = name;
+	handle->hwip = ras_info->hwip;
+	handle->mask = ras_info->mask;
+	handle->bank_ops = ras_info->bank_ops;
+	handle->data = data;
+	aca_init_error_cache(handle);
+
+	INIT_LIST_HEAD(&handle->node);
+	list_add_tail(&handle->node, &mgr->list);
+	mgr->nr_handles++;
+
+	return 0;
+}
+
+int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
+			  const char *name, const struct aca_info *ras_info, void *data)
+{
+	struct amdgpu_aca *aca = &adev->aca;
+
+	return add_aca_handle(adev, &aca->mgr, handle, name, ras_info, data);
+}
+
+static void remove_aca(struct aca_handle *handle)
+{
+	struct aca_handle_manager *mgr = handle->mgr;
+
+	aca_fini_error_cache(handle);
+	list_del(&handle->node);
+	mgr->nr_handles--;
+}
+
+void amdgpu_aca_remove_handle(struct aca_handle *handle)
+{
+	if (!handle || list_empty(&handle->node))
+		return;
+
+	remove_aca(handle);
+}
+
+static int aca_manager_init(struct aca_handle_manager *mgr)
+{
+	INIT_LIST_HEAD(&mgr->list);
+	mgr->nr_handles = 0;
+
+	return 0;
+}
+
+static void aca_manager_fini(struct aca_handle_manager *mgr)
+{
+	struct aca_handle *handle, *tmp;
+
+	list_for_each_entry_safe(handle, tmp, &mgr->list, node)
+		remove_aca(handle);
+}
+
+int amdgpu_aca_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_aca *aca = &adev->aca;
+	int ret;
+
+	ret = aca_manager_init(&aca->mgr);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void amdgpu_aca_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_aca *aca = &adev->aca;
+
+	aca_manager_fini(&aca->mgr);
+}
+
+void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca_smu_funcs *smu_funcs)
+{
+	struct amdgpu_aca *aca = &adev->aca;
+
+	WARN_ON(aca->smu_funcs);
+	aca->smu_funcs = smu_funcs;
+}
+
+int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info *info)
+{
+	u64 ipid;
+	u32 instidhi, instidlo;
+
+	if (!bank || !info)
+		return -EINVAL;
+
+	ipid = bank->regs[ACA_REG_IDX_IPID];
+	info->hwid = ACA_REG__IPID__HARDWAREID(ipid);
+	info->mcatype = ACA_REG__IPID__MCATYPE(ipid);
+	/*
+	 * Unfied DieID Format: SAASS. A:AID, S:Socket.
+	 * Unfied DieID[4:4] = InstanceId[0:0]
+	 * Unfied DieID[0:3] = InstanceIdHi[0:3]
+	 */
+	instidhi = ACA_REG__IPID__INSTANCEIDHI(ipid);
+	instidlo = ACA_REG__IPID__INSTANCEIDLO(ipid);
+	info->die_id = ((instidhi >> 2) & 0x03);
+	info->socket_id = ((instidlo & 0x1) << 2) | (instidhi & 0x03);
+
+	return 0;
+}
+
+static int aca_bank_get_error_code(struct amdgpu_device *adev, struct aca_bank *bank)
+{
+	int error_code;
+
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+		if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >= 0x00555600) {
+			error_code = ACA_REG__SYND__ERRORINFORMATION(bank->regs[ACA_REG_IDX_SYND]);
+			return error_code & 0xff;
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* NOTE: the true error code is encoded in status.errorcode[0:7] */
+	error_code = ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
+
+	return error_code & 0xff;
+}
+
+int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank, int *err_codes, int size)
+{
+	int i, error_code;
+
+	if (!bank || !err_codes)
+		return -EINVAL;
+
+	error_code = aca_bank_get_error_code(adev, bank);
+	for (i = 0; i < size; i++) {
+		if (err_codes[i] == error_code)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
new file mode 100644
index 000000000000..8cf520403548
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -0,0 +1,196 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_ACA_H__
+#define __AMDGPU_ACA_H__
+
+#include <linux/list.h>
+
+#define ACA_MAX_REGS_COUNT	(16)
+
+#define ACA_REG_FIELD(x, h, l)			(((x) & GENMASK_ULL(h, l)) >> l)
+#define ACA_REG__STATUS__VAL(x)			ACA_REG_FIELD(x, 63, 63)
+#define ACA_REG__STATUS__OVERFLOW(x)		ACA_REG_FIELD(x, 62, 62)
+#define ACA_REG__STATUS__UC(x)			ACA_REG_FIELD(x, 61, 61)
+#define ACA_REG__STATUS__EN(x)			ACA_REG_FIELD(x, 60, 60)
+#define ACA_REG__STATUS__MISCV(x)		ACA_REG_FIELD(x, 59, 59)
+#define ACA_REG__STATUS__ADDRV(x)		ACA_REG_FIELD(x, 58, 58)
+#define ACA_REG__STATUS__PCC(x)			ACA_REG_FIELD(x, 57, 57)
+#define ACA_REG__STATUS__ERRCOREIDVAL(x)	ACA_REG_FIELD(x, 56, 56)
+#define ACA_REG__STATUS__TCC(x)			ACA_REG_FIELD(x, 55, 55)
+#define ACA_REG__STATUS__SYNDV(x)		ACA_REG_FIELD(x, 53, 53)
+#define ACA_REG__STATUS__CECC(x)		ACA_REG_FIELD(x, 46, 46)
+#define ACA_REG__STATUS__UECC(x)		ACA_REG_FIELD(x, 45, 45)
+#define ACA_REG__STATUS__DEFERRED(x)		ACA_REG_FIELD(x, 44, 44)
+#define ACA_REG__STATUS__POISON(x)		ACA_REG_FIELD(x, 43, 43)
+#define ACA_REG__STATUS__SCRUB(x)		ACA_REG_FIELD(x, 40, 40)
+#define ACA_REG__STATUS__ERRCOREID(x)		ACA_REG_FIELD(x, 37, 32)
+#define ACA_REG__STATUS__ADDRLSB(x)		ACA_REG_FIELD(x, 29, 24)
+#define ACA_REG__STATUS__ERRORCODEEXT(x)	ACA_REG_FIELD(x, 21, 16)
+#define ACA_REG__STATUS__ERRORCODE(x)		ACA_REG_FIELD(x, 15, 0)
+
+#define ACA_REG__IPID__MCATYPE(x)		ACA_REG_FIELD(x, 63, 48)
+#define ACA_REG__IPID__INSTANCEIDHI(x)		ACA_REG_FIELD(x, 47, 44)
+#define ACA_REG__IPID__HARDWAREID(x)		ACA_REG_FIELD(x, 43, 32)
+#define ACA_REG__IPID__INSTANCEIDLO(x)		ACA_REG_FIELD(x, 31, 0)
+
+#define ACA_REG__MISC0__VALID(x)		ACA_REG_FIELD(x, 63, 63)
+#define ACA_REG__MISC0__OVRFLW(x)		ACA_REG_FIELD(x, 48, 48)
+#define ACA_REG__MISC0__ERRCNT(x)		ACA_REG_FIELD(x, 43, 32)
+
+#define ACA_REG__SYND__ERRORINFORMATION(x)	ACA_REG_FIELD(x, 17, 0)
+
+/* NOTE: The following codes refers to the smu header file */
+#define ACA_EXTERROR_CODE_CE			0x3a
+#define ACA_EXTERROR_CODE_FAULT			0x3b
+
+#define ACA_ERROR_UE_MASK		BIT_MASK(ACA_ERROR_TYPE_UE)
+#define ACA_ERROR_CE_MASK		BIT_MASK(ACA_ERROR_TYPE_CE)
+#define ACA_ERROR_DEFERRED_MASK		BIT_MASK(ACA_ERROR_TYPE_DEFERRED)
+
+enum aca_reg_idx {
+	ACA_REG_IDX_CTL			= 0,
+	ACA_REG_IDX_STATUS		= 1,
+	ACA_REG_IDX_ADDR		= 2,
+	ACA_REG_IDX_MISC0		= 3,
+	ACA_REG_IDX_CONFG		= 4,
+	ACA_REG_IDX_IPID		= 5,
+	ACA_REG_IDX_SYND		= 6,
+	ACA_REG_IDX_DESTAT		= 8,
+	ACA_REG_IDX_DEADDR		= 9,
+	ACA_REG_IDX_CTL_MASK		= 10,
+	ACA_REG_IDX_COUNT		= 16,
+};
+
+enum aca_hwip_type {
+	ACA_HWIP_TYPE_UNKNOW = -1,
+	ACA_HWIP_TYPE_PSP = 0,
+	ACA_HWIP_TYPE_UMC,
+	ACA_HWIP_TYPE_SMU,
+	ACA_HWIP_TYPE_PCS_XGMI,
+	ACA_HWIP_TYPE_COUNT,
+};
+
+enum aca_error_type {
+	ACA_ERROR_TYPE_INVALID = -1,
+	ACA_ERROR_TYPE_UE = 0,
+	ACA_ERROR_TYPE_CE,
+	ACA_ERROR_TYPE_DEFERRED,
+	ACA_ERROR_TYPE_COUNT
+};
+
+struct aca_bank {
+	u64 regs[ACA_MAX_REGS_COUNT];
+};
+
+struct aca_bank_node {
+	struct aca_bank bank;
+	struct list_head node;
+};
+
+struct aca_bank_info {
+	int die_id;
+	int socket_id;
+	int hwid;
+	int mcatype;
+};
+
+struct aca_bank_report {
+	enum aca_error_type type;
+	struct aca_bank_info info;
+	u64 count;
+};
+
+struct aca_bank_error {
+	struct list_head node;
+	struct aca_bank_info info;
+	u64 count;
+};
+
+struct aca_error {
+	struct list_head list;
+	struct mutex lock;
+	enum aca_error_type type;
+	int nr_errors;
+};
+
+struct aca_handle_manager {
+	struct list_head list;
+	int nr_handles;
+};
+
+struct aca_error_cache {
+	struct aca_error errors[ACA_ERROR_TYPE_COUNT];
+};
+
+struct aca_handle {
+	struct list_head node;
+	enum aca_hwip_type hwip;
+	struct amdgpu_device *adev;
+	struct aca_handle_manager *mgr;
+	struct aca_error_cache error_cache;
+	const struct aca_bank_ops *bank_ops;
+	const char *name;
+	u32 mask;
+	void *data;
+};
+
+struct aca_bank_ops {
+	int (*aca_bank_generate_report)(struct aca_handle *handle, struct aca_bank *bank, enum aca_error_type type,
+					struct aca_bank_report *report, void *data);
+	bool (*aca_bank_is_valid)(struct aca_handle *handle, struct aca_bank *bank, enum aca_error_type type,
+				  void *data);
+};
+
+struct aca_smu_funcs {
+	int max_ue_bank_count;
+	int max_ce_bank_count;
+	int (*set_debug_mode)(struct amdgpu_device *adev, bool enable);
+	int (*get_valid_aca_count)(struct amdgpu_device *adev, enum aca_error_type type, u32 *count);
+	int (*get_valid_aca_bank)(struct amdgpu_device *adev, enum aca_error_type type, int idx, struct aca_bank *bank);
+};
+
+struct amdgpu_aca {
+	struct aca_handle_manager mgr;
+	const struct aca_smu_funcs *smu_funcs;
+};
+
+struct aca_info {
+	enum aca_hwip_type hwip;
+	const struct aca_bank_ops *bank_ops;
+	u32 mask;
+};
+
+int amdgpu_aca_init(struct amdgpu_device *adev);
+void amdgpu_aca_fini(struct amdgpu_device *adev);
+void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca_smu_funcs *smu_funcs);
+
+int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info *info);
+int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank, int *err_codes, int size);
+
+int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
+			  const char *name, const struct aca_info *aca_info, void *data);
+void amdgpu_aca_remove_handle(struct aca_handle *handle);
+int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
+				     enum aca_error_type type, void *data);
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a39c9fea55c4..7d5e5059cc85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4023,6 +4023,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_get_pcie_info(adev);
 
+	r = amdgpu_aca_init(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
@@ -4427,6 +4431,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	amdgpu_reset_fini(adev);
 
+	amdgpu_aca_fini(adev);
+
 	/* free i2c buses */
 	if (!amdgpu_device_has_dc_support(adev))
 		amdgpu_i2c_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 76fb85628716..c36faf353b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -29,6 +29,7 @@
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 #include "amdgpu_smuio.h"
+#include "amdgpu_aca.h"
 
 struct amdgpu_iv_entry;
 
-- 
2.34.1

