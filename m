Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10248C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EC12054F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0utx9sNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EC12054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F376E103;
	Tue, 11 Aug 2020 06:30:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589A46E101
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 06:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhGzkUwyuZVbN0PhlbhSHKzMabVaSP1sEwF046iQEJjXEcF4Y16TlVfnhZFyzWAWyTZovbMUXipBTXo+LzKtYT7FN8yGGJkVX1wC8376d4WLwRr3WnoIxXVk3GAMx/uUoArUgNrx+C01H//89Eom6XFHuSzDt6BTymP101zjCjEFDlr09bjqcOTJh/qLhR2jQtzFptssu+Zq0V3BWDpub+fbfA3MJKGTMMgrBdpDcO8OSI54g7y84eV+ihg9loZ3tFYECXNOZ2hqkSTUzw0CWjcfXkEmkGTKTpz6TNQac50YejKb4HTSCWNLb/J8unWlqrz9MQ6K2Zfb4PzrpOBtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S4zKxYtjiTWGss3vRe7hOfY3Rlo2TtGEJHaQIcD5ls=;
 b=BtucCw6l/o+EclMK1NiXneK2BB8+o/O5QdmvnBdBjUnCKq3fY8eqxgFiPMVhFzAjhf6NGIvGgQWAo7LaIP8aYvZf5kjBqlVDXW0nTuaAt25f5fk+z+WzA3GXZdvYxTw46eP05NUk6R6bOAGHDz/dEttHaMhy0EcSdEAajSwgQVacOpFy2e+WZPRymgGp+GUcpzFZAZ58RmhnL1kYJLnW3voFpoTCRfuNsSnyo3Jnt76IlT/GbJ6E8PoOWBfFUd1w2jymxRHEIdPu5R0vzEZbWEqDVIpn0WkZCL68acYIyLwCuoIPl5CZRSmlNdYV3nCROwuWBr654RNtyvZ2vGfMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S4zKxYtjiTWGss3vRe7hOfY3Rlo2TtGEJHaQIcD5ls=;
 b=0utx9sNfaUA3nHoDaPPQ0pyZ1w1Ft7b/wcC2oUvH/RWehrgkIqTctKwpYXuhKA9FHeR6VmwFidFM38uUAg8FE2JgbgnUCJ+GsnIIDDjRz6FSaE7WdN75zv1dxeDgl5q0ctSs4x4980iAzf7xehObb1VyfX16TYq42F60iZP+KoU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16)
 by CY4PR12MB1319.namprd12.prod.outlook.com (2603:10b6:903:41::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.21; Tue, 11 Aug
 2020 06:30:27 +0000
Received: from CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f]) by CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f%3]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 06:30:27 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test
Date: Tue, 11 Aug 2020 14:30:07 +0800
Message-Id: <20200811063007.7785-3-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811063007.7785-1-Wenhui.Sheng@amd.com>
References: <20200811063007.7785-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To CY4PR12MB1814.namprd12.prod.outlook.com
 (2603:10b6:903:125::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.5 via Frontend Transport; Tue, 11 Aug 2020 06:30:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f013905-9ea9-4b77-d14e-08d83dc00920
X-MS-TrafficTypeDiagnostic: CY4PR12MB1319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1319A74FD122B07089BCE39E8C450@CY4PR12MB1319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgdE81ILnbZpksvnilVjOtgAA4IYMNWYxVcgkUrWWAptFQuy8ZCq7z0ZY8qN4DsF6Re2kTiUvVo53gWINjzKq0lvMsC1ICsJMlZnKa59MpHNeIBm2O5KnaxvV6pv9M4uJhubK/JfaU+owO1mpxh8GJn/L0ooMEeWNvcg8soog+13ovWugCXBzFm+Ik+kI50c032xDKFpuh7r5F6kgN1/NUDukigvBWRK9x0hlMpyWL9YGH1t9u8wVqJO3/YC3+76cFuZOi9BMSMYUN8vlwk/c25F1XeqfAkAo/YE22rb8HmnjZ1mWWCWu75fhNhjQZqKH0AzvFMq4pTxaPsf8EbkgJ+iznjibHObIVy9igOCaMbmSlF0SRKfVpGJkpJShBhf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1814.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(316002)(54906003)(52116002)(5660300002)(4326008)(6916009)(1076003)(6486002)(86362001)(8676002)(2906002)(8936002)(36756003)(26005)(7696005)(16526019)(83380400001)(186003)(66556008)(6666004)(956004)(66476007)(66946007)(478600001)(2616005)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WIJWLPRyLfk2yduT6wNe9xhb/Gr2X/v5NYppDs4QzYC+m3isiZ6z3GGecGjW48TTF+PED3mn084sKKjHhJ+hoZ7XD5PqLnXDaUZgXwH7Po8D4t24PV1PJwkAKO9jkKck5I0iWuFYj9YDYSJvuyW7bX0H7Ohw8NK4LI7Ik+Tr0ALsqfM073KpdwKFzn+tYRcrdvPmMt2gRIaIMLqcjqn+drxlwW0+EaLGpm1R+fg8Hz7FAKDnE/1OU47e4ozHOcXQGCfEesVVsmZLrCshmXm9lamzcB5j/9hQtTm/wBd5yPwpv6m2ze7L0WZXois/GjF5tKJHYjM7chWK732SxzYxsGSKS0nBWpmzuZSAkE409XgfZvdtSThtUc9zIbdcCKAhJft+wOq6eJceZmy6ycU2iZtodOjM1Tm6Fl0N+CqLxopn7A/ZHcfkvwJdjtAzM77h+IUpXttRg3U1F9e0WMPaQIEFx7r6aB0Z1uWw5jsvsp2lsuTXVx2fLIM71Nvdq8ymlSNirCPClyOSyh1fdoSvUN0fynGbAlJ70sPhsCg36iITHC1pyHE7/mPqkj3B6/WKFyQfwV+JZlxlNH/TYcikKqMq9vSLJM+0ozSfoh+Nr0YTZxvAhw+5WZTCe/s681o5R2BXXKLNjES7j3LbcU8YxA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f013905-9ea9-4b77-d14e-08d83dc00920
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 06:30:27.1245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuF7gbqqwRMbap+kD/BBY7XdP/MtqgVVNrAYL4WM8w9t3/X8Hkd8gLzZ/7uTrLAK63b/RsYhYgWGghvau8iHLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1319
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
Cc: John Clements <John.Clements@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 Guchun Chen <Guchun.Chen@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After amdgpu driver loading successfully, we can use
RAP debugfs interface <debugfs_dir>/dri/xxx/rap_test
to trigger RAP test.

Currently only L0 validate test is supported.

v2: refine amdgpu_rap.h

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c     | 127 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h     |  30 +++++
 4 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 0ba396e9d7e4..dec1927ca75d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -55,7 +55,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
 	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
-	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
+	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3a4b31b1c4f2..0af249a1e35b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -34,6 +34,7 @@
 #include "amdgpu_pm.h"
 #include "amdgpu_dm_debugfs.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_rap.h"
 
 /**
  * amdgpu_debugfs_add_files - Add simple debugfs entries
@@ -1623,6 +1624,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	amdgpu_debugfs_autodump_init(adev);
 
+	amdgpu_rap_debugfs_init(adev);
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
new file mode 100644
index 000000000000..87cbc9011b2d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+ *
+ */
+#include <linux/debugfs.h>
+#include <linux/pm_runtime.h>
+
+#include "amdgpu.h"
+#include "amdgpu_rap.h"
+
+/**
+ * DOC: AMDGPU RAP debugfs test interface
+ *
+ * how to use?
+ * echo opcode > <debugfs_dir>/dri/xxx/rap_test
+ *
+ * opcode:
+ * currently, only 2 is supported by Linux host driver,
+ * opcode 2 stands for TA_CMD_RAP__VALIDATE_L0, used to
+ * trigger L0 policy validation, you can refer more detail
+ * from header file ta_rap_if.h
+ *
+ */
+static ssize_t amdgpu_rap_debugfs_write(struct file *f, const char __user *buf,
+		size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct ta_rap_shared_memory *rap_shared_mem;
+	struct ta_rap_cmd_output_data *rap_cmd_output;
+	struct drm_device *dev = adev->ddev;
+	uint32_t op;
+	int ret;
+
+	if (*pos || size != 2)
+		return -EINVAL;
+
+	ret = kstrtouint_from_user(buf, size, *pos, &op);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_get_sync(dev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
+		return ret;
+	}
+
+	/* make sure gfx core is on, RAP TA cann't handle
+	 * GFX OFF case currently.
+	 */
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	switch (op) {
+	case 2:
+		ret = psp_rap_invoke(&adev->psp, op);
+
+		if (ret == TA_RAP_STATUS__SUCCESS) {
+			dev_info(adev->dev, "RAP L0 validate test success.\n");
+		} else {
+			rap_shared_mem = (struct ta_rap_shared_memory *)
+					 adev->psp.rap_context.rap_shared_buf;
+			rap_cmd_output = &(rap_shared_mem->rap_out_message.output);
+
+			dev_info(adev->dev, "RAP test failed, the output is:\n");
+			dev_info(adev->dev, "\tlast_subsection: 0x%08x.\n",
+				 rap_cmd_output->last_subsection);
+			dev_info(adev->dev, "\tnum_total_validate: 0x%08x.\n",
+				 rap_cmd_output->num_total_validate);
+			dev_info(adev->dev, "\tnum_valid: 0x%08x.\n",
+				 rap_cmd_output->num_valid);
+			dev_info(adev->dev, "\tlast_validate_addr: 0x%08x.\n",
+				 rap_cmd_output->last_validate_addr);
+			dev_info(adev->dev, "\tlast_validate_val: 0x%08x.\n",
+				 rap_cmd_output->last_validate_val);
+			dev_info(adev->dev, "\tlast_validate_val_exptd: 0x%08x.\n",
+				 rap_cmd_output->last_validate_val_exptd);
+		}
+		break;
+	default:
+		dev_info(adev->dev, "Unsupported op id: %d, ", op);
+		dev_info(adev->dev, "Only support op 2(L0 validate test).\n");
+	}
+
+	amdgpu_gfx_off_ctrl(adev, true);
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
+	return size;
+}
+
+static const struct file_operations amdgpu_rap_debugfs_ops = {
+	.owner = THIS_MODULE,
+	.read = NULL,
+	.write = amdgpu_rap_debugfs_write,
+	.llseek = default_llseek
+};
+
+void amdgpu_rap_debugfs_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev->ddev->primary;
+
+	if (!adev->psp.rap_context.rap_initialized)
+		return;
+
+	debugfs_create_file("rap_test", S_IWUSR, minor->debugfs_root,
+				adev, &amdgpu_rap_debugfs_ops);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h
new file mode 100644
index 000000000000..ec6d7632d3a0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+ *
+ */
+#ifndef _AMDGPU_RAP_H
+#define _AMDGPU_RAP_H
+
+#include "amdgpu.h"
+
+void amdgpu_rap_debugfs_init(struct amdgpu_device *adev);
+#endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
