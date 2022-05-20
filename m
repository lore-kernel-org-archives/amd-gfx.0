Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDA9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 13:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D2A10F105;
	Fri, 20 May 2022 13:49:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA88B10F105
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 13:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTevnz7dVYGctNK1m96VD9FNc5JvTs9OtyeWRsqaQDqloY6B0njVxurzor45ra1VeO1UrQ3dRpSsYQE6qKljn4E+kgIYo3cYi95Laq0tZ12qx0hDl7yQSPcochPN1G1sT6omWHxBuUV+FRKtpKJiqSh2+mq0Gr8ZlOi42/XrkNBzxlDpJwRU6O5E9KWQjs3GPEBcLjSjnzhzUeOWLoaqm1ZPkjRgkdBAwWQEsnfjdFQNCE10TcnAHN6RLk08d3bt9EtuX0HzQMYOJMH61o/BP/p7V3WxwFup4759BEEsWfHjs/L3VciucjzhOMb4NkPvooTHI7/ghqP9HfSvziWNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vawLwn7gtzwqPM7Lmft+1IHqUX5BYpENLOCMjK7dxic=;
 b=S1kWFW/w6W+9LfFxTPXGnWMEntneAHXvalGVh1EgUDTw3Kr/3fi7cCNtDk3Vq6epVLOa178YUWB7VB08+hy4GgbXt2SRxLUDOjCmwAl3DP63UR2M+qo4Pvxzpzac3f+gw4yg3lK4U5UnTb1TR/HT9AAbtnHhKfWNNiNm2yr7OQd5sRJsZ1azX2e99CEpPNwI6zvSEGz2w8nYyXZJolN12qAaLNArLDhM8koOlPacw6I/0f95kwaP972JtYhV+i5IFgc2roRccOun0yRPJrPuTfOgFJjNeJ3JU0wb/b3x6Zyg1ivQVURO40+ZaVbmsxvNYDc5nraphVXbT7BMLUHcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vawLwn7gtzwqPM7Lmft+1IHqUX5BYpENLOCMjK7dxic=;
 b=gFtktNSF67emJ0nZ8nwrvCkWI23TGZF/yTf+QPsgAEXVU1fc2t3udXFuJp7fc6YBEuBFMr9BSlIKGol/S7fPX1TiueIYUxdaOHMG+G+t42Wp0USf73cl5foNOn9+lPlORSnh5A7DfAlGrDglQCSJeou3eBD1LobEKt5FJL9hesU=
Received: from MWHPR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:301:4a::21) by MWHPR1201MB0142.namprd12.prod.outlook.com
 (2603:10b6:301:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 13:49:42 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::2a) by MWHPR1201CA0011.outlook.office365.com
 (2603:10b6:301:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27 via Frontend
 Transport; Fri, 20 May 2022 13:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 13:49:42 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 08:49:40 -0500
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Date: Fri, 20 May 2022 19:19:09 +0530
Message-ID: <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba43245c-574b-4576-c2ec-08da3a6797b9
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0142:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0142436100F0AD0B3756A3C6F8D39@MWHPR1201MB0142.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tC+kO/xwUhCwlrkpTPoFpjWD0Bg/6Uof4w8v6y78PwvwgmhGEL1NKK4uf1vF1DLX9NQ8N6syeG3nNTEDAnSz5XHHNM/nCm/pKv9P8sNt0GwKA9Mfl+fevUof1G1AtId9dDsxUCcJPtGRiE8nO9rHlxQZ7/9vbG5i8A8baDGmS7goZaatOcjPyi1tbOaJAya5n+9vL0/iJ+iJj2up16OTrpPWin9b6uXHBVGeFPtKJtUtB37YO1IlLCYUIRKOmTUWpW2f1/2AkX+bGaBdOgNm0nqgGqPIWm8dE+MNAxDroSoLv4G7/YqYOxhfjvZt/EKhExTdZxIVtm4b0DcGb7p4Z7bMpvip9d036An/lDRXXFwomEozizsMiHWQ5U2FXQkRwp1GrLeNWCf02fij6lWxZBnEKXLSdzMIJaJty4lVzanv15CHfanzEr0Ov2uYdgKz5HjrtDLfpsF+tOQeVj6j5GjXWhIAuGl3gmCiC6MMsT+KIjKo7ZIfh+/rL8xybK8LP7FcupNhsOZdC0YvaeNCaK+onvlxxiDr0ki7JBcEx6Q+kjPER6POzdKCLLmG23dTSKzFEfErz3f7T8EEmsKOlpP/u1MMJdevEUprLWNicwQIt7UcqCLw3SqV/7ybWiwmT7IZlGDkkpubWfHn3dIBFvB6cnqeEQK973H/SPedqNyoc8h46y20vOnTXr5u2W+fGLXgcFG02jzPfp1ZLEwM+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(6666004)(4326008)(7696005)(8676002)(70586007)(70206006)(5660300002)(86362001)(186003)(16526019)(1076003)(82310400005)(8936002)(2616005)(426003)(336012)(47076005)(316002)(26005)(356005)(40460700003)(6916009)(81166007)(54906003)(36756003)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 13:49:42.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba43245c-574b-4576-c2ec-08da3a6797b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0142
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added device coredump information:
- Kernel version
- Module
- Time
- VRAM status
- Guilty process name and PID
- GPU register dumps

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c79d9992b113..f28d9c563f74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1044,6 +1044,9 @@ struct amdgpu_device {
 	uint32_t                        *reset_dump_reg_list;
 	uint32_t			*reset_dump_reg_value;
 	int                             num_regs;
+	struct amdgpu_task_info         reset_context_task_info;
+	bool                            reset_context_vram_lost;
+	struct timespec64               reset_time;
 
 	struct amdgpu_reset_domain	*reset_domain;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 963c897a76e6..f9b710e741a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -32,6 +32,8 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/pci.h>
+#include <linux/devcoredump.h>
+#include <generated/utsrelease.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
 	return 0;
 }
 
+#ifdef CONFIG_DEV_COREDUMP
+static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
+		size_t count, void *data, size_t datalen)
+{
+	struct drm_printer p;
+	struct amdgpu_device *adev = data;
+	struct drm_print_iterator iter;
+	int i;
+
+	iter.data = buffer;
+	iter.offset = 0;
+	iter.start = offset;
+	iter.remain = count;
+
+	p = drm_coredump_printer(&iter);
+
+	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
+	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
+	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
+	drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, adev->reset_time.tv_nsec);
+	if (adev->reset_context_task_info.pid)
+		drm_printf(&p, "process_name: %s PID: %d\n",
+							adev->reset_context_task_info.process_name,
+							adev->reset_context_task_info.pid);
+
+	if (adev->reset_context_vram_lost)
+		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
+	if (adev->num_regs) {
+		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
+
+		for (i = 0; i < adev->num_regs; i++)
+			drm_printf(&p, "0x%08x: 0x%08x\n",
+					adev->reset_dump_reg_list[i],
+					adev->reset_dump_reg_value[i]);
+	}
+
+	return count - iter.remain;
+}
+
+static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+
+	ktime_get_ts64(&adev->reset_time);
+	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
+			amdgpu_devcoredump_read, NULL);
+}
+#endif
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					goto out;
 
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
+#ifdef CONFIG_DEV_COREDUMP
+				tmp_adev->reset_context_vram_lost = vram_lost;
+				tmp_adev->reset_context_task_info.pid = 0;
+				if (reset_context->job && reset_context->job->vm)
+					tmp_adev->reset_context_task_info =
+						reset_context->job->vm->task_info;
+				amdgpu_reset_capture_coredumpm(tmp_adev);
+#endif
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
 					amdgpu_inc_vram_lost(tmp_adev);
-- 
2.32.0

