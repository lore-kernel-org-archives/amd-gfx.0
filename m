Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105E8C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 08:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A0B112B95;
	Thu,  2 Jun 2022 08:16:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2653112B93
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 08:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K16j8mUb/iSI0lMihN7/o3AsijhcmjbNTVJLiFvo+pMJ85JPgSWd/hDKifv4rXmyDuomRc0ld2OZ9UOGT+XjVujrWaDQhubmfcvB4+HTnyba3d843Qh5wgmExWlEP0KpctcDpfSmSnDbNh4xh+5lNh9NPnbQxhMa7y9lVJni5aypBdstPIUbLWxfPMM7Gb7iTUfI99dm9myFF89PVZozoSC++BZKnn4V8dVFi5uTMMsX3oxSdhUgHNi8ypagcISdpJ7mOtEwLeJabEobl+ODp3yoE0TI0+d7P1/g0Z1plD6O3G93JTpe738OdxQlScLrPcEIg7AI9vzlXHmuacNmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SN1W2Q39kSF2yKGSTzxkGUWfioVigPaNiiendvyD0WI=;
 b=f6+RpbsPQOACkGefpqociEgW4hm9uP3fCxamsokrqPbyp5KE4//9IV9RK2Ke8Qvmu3Kma+jwWcdC9uSh/m0aC7vPWerjNZFKCPFFLdde4Kk+Fn59IhGCQRVv24+jwSz2EJRTA26D6TQ5jeozPMLzhi2G4xTkLvhvERVIW2t6vXu9Lz/12YdkbjIlPhPfCq1c5iBhsFf6aJ4jCz45TEe1LQzXYPOGdeC6JesAoxypw+gaUk14RLPvwxXIpt+vJmgnfWb2h8v9kL6/o2RVVddeukM70+O0hrFPkDrkRLT4vE0i1Wr+2wNrUg16ZcR+18KI8vgfniA/5KD0F5nsWK+GMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN1W2Q39kSF2yKGSTzxkGUWfioVigPaNiiendvyD0WI=;
 b=uFvxUJpVgYVZJ1z4WOiE8iEQ+rmJpLd+KcSaKXXhUb/kI33nLkwZlW/jgzONiS70GzRgmpUBz8QoFfAZBgXSDKsy3KsP3vxCp22bJ0Z8tJzHXP1hz8yhSDz+HK+tFFJNnc/XBiu9t61FNomZrsTnLKXIkhj82ms6YmvOI3jHwtg=
Received: from MW4PR04CA0269.namprd04.prod.outlook.com (2603:10b6:303:88::34)
 by DM6PR12MB3148.namprd12.prod.outlook.com (2603:10b6:5:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Thu, 2 Jun
 2022 08:16:06 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::1d) by MW4PR04CA0269.outlook.office365.com
 (2603:10b6:303:88::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 08:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 08:16:05 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 03:16:02 -0500
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/amdgpu: adding device coredump support
Date: Thu, 2 Jun 2022 13:45:38 +0530
Message-ID: <20220602081538.1652842-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220602081538.1652842-1-Amaranath.Somalapuram@amd.com>
References: <20220602081538.1652842-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bb98a1b-ebf5-4a44-e687-08da447023f8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3148:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31485B10D0693DF77D38EF5AF8DE9@DM6PR12MB3148.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdpZ4T4SAYzvQMe2HQEXnSWU+7fMyd/JjajGY3vppbsF+BvYbJot/Cp2VgsOMMoGeMD6uP3dD/uYI5i4ZQeBP0I0p/ZnIMXjjhdP3N0QS95BzQ/UEZWbshDZTlViMz30GxeCdZpdj1gg1ZsL/pKsFr9iZK5Wm6rpoaDqxrTorp2jaSneqPEEnNTfuDx8/TSZU8apd3vwWWWnqcWNBm8blFQafUsieJTQNUqnQj9ITNW6gHZNw85ovynUbIF6XpI2DBKgvoO/400jIAXtizMBc3+cOYy6hIoaOBvgKeKNLWQa4JEZUIn5EoKzl+1fRDGzl0B7Efc73sZsoBg7nmzkw6LJ6hBwRnGs7d8w4WUG8LPdeAa/lKxIXgb7eVUFLArM3BzoWNaCFywneqJB2PDK+6OZJ6ChczvPtFtXn6pydC0zvAImM9Xu37AGTe9c3TPsaqKLyg3RwcbSzDKgPPr31rl3mUk6BVm7/NV6f8w+MQZkCMUqjqERzJJwaF86Isx0/fWRfxpktpD5YkoHnV0i0FZHwuFbbC0dbTgGpUhk4HxYyeInqNLa6s5yiXzelKxz+A/o2rpkrVSm+/UehJJUFeCDQHNJZkKpY7Z8nEIVw3Rmlbl7x4SByKKOj72sMaWZyuAqTGSrc35D9o7FFtPYxVJN5rURaVTa5vXEFlaPdomEk+EHB4ryLSrnWZQw5SCPpQhqHMUv5t7Pw36LreZ5EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6916009)(2616005)(16526019)(186003)(47076005)(5660300002)(8936002)(7696005)(1076003)(336012)(26005)(40460700003)(36860700001)(426003)(81166007)(70206006)(356005)(2906002)(86362001)(82310400005)(70586007)(6666004)(4326008)(316002)(8676002)(36756003)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 08:16:05.4699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb98a1b-ebf5-4a44-e687-08da447023f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3148
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
v1 -> v2: Variable name change
v1 -> v2: NULL check
v1 -> v2: Code alignment
v1 -> v2: Adding dummy amdgpu_devcoredump_free
v1 -> v2: memset reset_task_info to zero
v2 -> v3: add CONFIG_DEV_COREDUMP for variables
v2 -> v3: remove NULL check on amdgpu_devcoredump_read

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 64 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c79d9992b113..1bfbaf65d414 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1044,6 +1044,11 @@ struct amdgpu_device {
 	uint32_t                        *reset_dump_reg_list;
 	uint32_t			*reset_dump_reg_value;
 	int                             num_regs;
+#ifdef CONFIG_DEV_COREDUMP
+	struct amdgpu_task_info         reset_task_info;
+	bool                            reset_vram_lost;
+	struct timespec64               reset_time;
+#endif
 
 	struct amdgpu_reset_domain	*reset_domain;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 89c6db03e84b..f1def74aaad0 100644
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
@@ -4734,6 +4736,59 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
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
+	if (adev->reset_task_info.pid)
+		drm_printf(&p, "process_name: %s PID: %d\n",
+			   adev->reset_task_info.process_name,
+			   adev->reset_task_info.pid);
+
+	if (adev->reset_vram_lost)
+		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
+	if (adev->num_regs) {
+		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
+
+		for (i = 0; i < adev->num_regs; i++)
+			drm_printf(&p, "0x%08x: 0x%08x\n",
+				   adev->reset_dump_reg_list[i],
+				   adev->reset_dump_reg_value[i]);
+	}
+
+	return count - iter.remain;
+}
+
+static void amdgpu_devcoredump_free(void *data)
+{
+}
+
+static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+
+	ktime_get_ts64(&adev->reset_time);
+	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
+		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
+}
+#endif
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4818,6 +4873,15 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					goto out;
 
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
+#ifdef CONFIG_DEV_COREDUMP
+				tmp_adev->reset_vram_lost = vram_lost;
+				memset(&tmp_adev->reset_task_info, 0,
+						sizeof(tmp_adev->reset_task_info));
+				if (reset_context->job && reset_context->job->vm)
+					tmp_adev->reset_task_info =
+						reset_context->job->vm->task_info;
+				amdgpu_reset_capture_coredumpm(tmp_adev);
+#endif
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
 					amdgpu_inc_vram_lost(tmp_adev);
-- 
2.32.0

