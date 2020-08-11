Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF94C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81606206C3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OEGwqhrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81606206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69EF989B96;
	Tue, 11 Aug 2020 03:04:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754E889B95
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 03:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7pwDitFd1gJGDy85XOxL8UIaT8GyOx55VTO+upWj1T3Anvotikk5Zjx7tc65iF1mUSvxkyHWw88k5HgIiL/cYdb1ZP3mhfRY0qXa4jX4FUTWN5VLUSkBccBW/tgF5soyNhuBRtcTcmUkuGCmXCrCD0KsXiZJSvik5xgx6WRiJvV1KKEZsF9zvBCpE2RYxfLvnnCyXWENMPq2lfzkG95AIpm5r5fBhZjiXpDXKJCZaxncpQumV6gUfdWbmNJHAgN+yCN1FjdCxDX6SB0sXFfBSrYxXWYpSMnF5iGaU7PMHHN7h68WGyLRhQQ8Xl+AU0yBGYxDtYWkm06HpZcDnNcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUHG6g6gLT0wLIhayuC+2BkL68grQkyyoRybrAPuZTo=;
 b=eCDJbshI3BD8QZN9OS9lNk2iX126TwbhX4Yxr4ZZNhneD0ue7ELlK8+EEYK/0pYPqqj3CcRtTsYD1zE/BEgfBJFErO1Qkm3qhz4LWzVPxLNJDDeB7CV/9Q0TSlkR8GcvN6tMm6tmTDV8oUrNH/O4aAmDLUHH1I2Jd7vl3lsX3Sr/a7iytKbBdtf4mQxQEIWyWkdtz7fPfW2LgXQUOYzE6KVvFN8m7eUgP8/dgtgjHMpE9jLrlDVozAY2UsdyA+UrWfsUGclwWamprq0Vaz4vhplRQ8hToEXUpSiIQtQ0lBiADunVrzlAhoW0RCYIKJxlHA30YGD/j3zGE0IGoqxAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUHG6g6gLT0wLIhayuC+2BkL68grQkyyoRybrAPuZTo=;
 b=OEGwqhrPR9sqGKPS9EkdxK7/AyA6thUpJs1VPBa1vhbD7M6eSstpXqo5erjPVYSgzVr9nO8bwvCrJqe5juvIVZ6KPDP+es9LEC3jSY7Xk6u238p31XXFvkxyEUX4KBXQuOJeZf1RehDFdIkidLBkj4WxcyMoRmEK/a9VVjkfHXo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16)
 by CY4PR12MB1942.namprd12.prod.outlook.com (2603:10b6:903:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 03:04:08 +0000
Received: from CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f]) by CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f%3]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 03:04:08 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test
Date: Tue, 11 Aug 2020 11:03:45 +0800
Message-Id: <20200811030345.7334-3-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811030345.7334-1-Wenhui.Sheng@amd.com>
References: <20200811030345.7334-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To CY4PR12MB1814.namprd12.prod.outlook.com
 (2603:10b6:903:125::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK2PR03CA0057.apcprd03.prod.outlook.com (2603:1096:202:17::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.5 via Frontend Transport; Tue, 11 Aug 2020 03:04:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7625b63-9421-4ced-946b-08d83da336a0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1942E1E83AC31CDBA3B698508C450@CY4PR12MB1942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5F5Xi6XXX3swbpm/rNWJpePgVq4wAm3RoVlbeq+c/CUvb03llJr+vpYnu+2Lnr6RtWKGbAd2jcfOAU4Joyk4pxwGHy1WmY37NLWurColq/Xe5Pv9mSFjRyzR8b8SBfvT4fRAmreTe8yf+oP2eujWrFSax6uP5bsyJkkNcxUaQ6+pdWMMEiQYElurM2wniWOxPRj62hiHqzBCT4SWO4M63jlJZSmV3Q2tsCa8SyoeUXxXM9nxvjwT4Un4sMGv2k+MebBM7bP95G7tDUMigm4mvXiSdTmCS4wzxojFl8CCVnIWdz+Y56Pd/427cv6cbmSDEKtLhpkl9y0+QE9zcx6Sq273P4SQTQTv98jwpmoLYtK5FPDU0BpUX+EPjl9ecwTP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1814.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(7696005)(26005)(52116002)(186003)(54906003)(316002)(1076003)(16526019)(956004)(83380400001)(6486002)(6666004)(36756003)(2616005)(478600001)(5660300002)(2906002)(6916009)(8676002)(4326008)(86362001)(8936002)(66946007)(66476007)(66556008)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wb5okyJupZu6yDahfsb5sOLoxUTG8stj+wGWDWwxr93lz6UFOtpITLVv0pXg/4X/9aE95vjOhnf9pmyMU1CvwydLfbxy+EMyLUjS5j9SoFyeUEMsdpHnUWC2W+UdBG3j7de9bGMjhIRytqlnb0NIfW7BLxTwtKK/Lw7ZfZrxBDtLhki0fzrurYF9fbr8capfeeILJn+LAHhK28av/z/1gw/gy/1NE073S7WzKHFY8UMdfMAtwCtx3SEAxTxvJORXHfsZPc9LmHsoWJ/9dKU7FKJXYax9M54MQyEjPPmjOe9zzU+CCxCutK8rGVxUv2p5VV/bhoUM5YFMvZ7TaRZKNJCJfCXPgCmq/R+Y+3CmZsMIW+Q08vI0St7+m+P2S/dU84QU95MPq9FXhN7CzglbzAZlRZqvG3Ctp8ai7I2h+nWUdzk7TY6HR2t5fiKLz6VsJVD8TYsoTqqNxbDPmQY7aisy+QzvyXBCZxjE+wyOa50zVP6RhVHshvTjK4p0yRTAGCTUntBIs7vAr8sF47kbi+9kfAWSuj0dDWUVU7NY+gZII7HFhXRyVe3P96MtYCLuG46i+PSy74D0ipdk3KfygjXIN2Yk4I1I4bsqQll/LGdQoaUy9ygD7BPksFHEQZNGwTLcwWK6cJQ8y1UAwoTzQQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7625b63-9421-4ced-946b-08d83da336a0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:04:08.0811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u51P0BWlL41jggGqtsJzNkXfdc5YE0juwj2KQgKmkKuYj2l3hIp+KNuh0Tt9QQLwqt8YEfozuoTUKzALBWI3sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1942
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
 Hawking Zhang <Hawking.Zhang@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h     |  28 +++++
 4 files changed, 159 insertions(+), 1 deletion(-)
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
index 000000000000..46b2607a7bd1
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
+	debugfs_create_file("rap_test", S_IWUGO | S_IRUGO, minor->debugfs_root,
+				adev, &amdgpu_rap_debugfs_ops);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h
new file mode 100644
index 000000000000..4a23d30fab62
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h
@@ -0,0 +1,28 @@
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
+void amdgpu_rap_debugfs_init(struct amdgpu_device *adev);
+#endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
