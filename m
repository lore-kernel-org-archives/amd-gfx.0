Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635ECC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 09:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C592810EA80;
	Thu, 26 May 2022 09:49:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B639310EA80
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 09:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2GjUyfVxLsHia0b6AplifxSraReLvAaLDKAxPTKAqyDCAon0VOPT3at2fOay/VEOzNf6MYZkkaW1Q+keZC2PyavYB8SB151znvALqB7cvrjGjBSoKWhj0H3R7997oce/bOctgOl6W2O9O4Q12p/kQelAfdnVyIKKKYWwa0SZIskv2Tdfkbjil+tuANTgV288RqJyi0eIdOnl0c6ezGgulqDtPsBhXfJ9G857+tlFEf+2kvadDZueli3oa4iRRvoxQR+/xvn7FvV1ajdJeXKgnyZ4Jc+1xDpEXmBRN2QMZ9dISQuiSwcYOrqdOR6+hNTHdZlCJ75or5NEMs4k0IgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F94V4xUaW4/3PxEE1TStqXBCKjGp6+L/LHKHyXKUc9g=;
 b=JicJ+ADUZ4sJq7lUz8Z1w2rTJGAM9tTuuV+dwVLj/3i/y4prAOaXNFreLyHAS3A6UTJKGMrc3soep0nRGhNnJZXj/ib5p0ox/l6+9+1l+n3VH1+bnggzJnNEpn9g+SdT7F2l3U8TSvOb/NAS5gdR3MFfb4OGxKZBMmZ5DZkW2y2RvkNzJ1mc8rL8TityWkng1cWjkGhCC62xvJAdR5bfpahnXTEnDZd+1PDcE4/lBwkhd0WynNo+1b5OCxQ+DQXLO/yvbwmyfwuQCeTu4A5odmb3NLRkaI6ddf/Ms5kxoUBSADOylQ3NsdISNGozHNj2oF+CUrqLCGTQ/As0HjvmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F94V4xUaW4/3PxEE1TStqXBCKjGp6+L/LHKHyXKUc9g=;
 b=B4hRrMYBX3t1m+EaTK7LSN4gMy+NCQVmLupDd2BAUJJrfMj2UhtKLleLfOajltOD+8Ov08aPPdUe60JFWP7rNFuAO2Z0tcTZO/jKIjLne89pwb7lSjmhtTfDe3kL8TVpuQWFjEmc/25oZgtFDyq/fEYbpf1Z5F+AmrWFg2EDLco=
Received: from BN9PR03CA0485.namprd03.prod.outlook.com (2603:10b6:408:130::10)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 09:49:12 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::47) by BN9PR03CA0485.outlook.office365.com
 (2603:10b6:408:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 09:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 09:49:12 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 04:49:10 -0500
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: adding device coredump support
Date: Thu, 26 May 2022 15:18:39 +0530
Message-ID: <20220526094839.36709-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
References: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c19059-253a-40a2-76ee-08da3efcfcf6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51849E2A1ED4965E631E4272F8D99@DM4PR12MB5184.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZh/MuPMXWlk+Mfqivc1RJvB0+832TDInf8nhkQMIG/Orz8QR2yx5OY2sgkVOIDuVSY7s4X+zD4wAB9NyjtbvSQyg6JEGHwijmdPbaWjBu/igUzHm9hnWQwSNW+M6zQ2szz33iXleal34TxoBGX6JnY3nc+tjoVwDcmdL4fXFO9l3BCfehfKu6Iz7orSrBvnS+lteCOoTh8MWLvktFQBkx9JjqOAAU7+gu3KEP3dOrxuYLV85+YMku6Q+jO5HbQfJqEAVpJPTFIdQ+sUefC4P2zcgavvVqMOl61IxOo0rJDLW427vcgxZXCSAMoNw6JV5nRn8wl/w4a8jLTnSlxB0EowKoWdUdhraEr/8iPSXqKlkwhItNHoXOv2tNcZTvLfZN4NUNjRFpmaGNtARTYFqLrolkwxMs3uIKWFFv7Tucm7t3HychinWccHlXhSx+6mk6W1wizRsemuF2jgWkUhgXJNVjQ04GKbk9Ejgt3IR2ILwnDbeqBTXDPxZRG6oyZKii8y5M0RN09wFVaq/n7C+kgpyiCLKaYdHjLMCHQ/VwRnNwEfuRsM3tq+1h1PKZ+bJNHsBbspVPWxsNj86rmme6SthKDPP48kfNHhhDhlyCxQct7Aw17CF1Y3A4JT5J7/YnU8GzyvBCpUB5JQI6Ae92KzlOwSc4022cxayqqwBqeHSCSpX1Jovj4A4YQgToRctBmvLqQFp6S4j8YtwDOijg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(2616005)(1076003)(82310400005)(336012)(70586007)(26005)(8676002)(47076005)(426003)(86362001)(54906003)(6916009)(316002)(16526019)(186003)(70206006)(4326008)(356005)(508600001)(7696005)(6666004)(36860700001)(2906002)(81166007)(8936002)(40460700003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 09:49:12.2412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c19059-253a-40a2-76ee-08da3efcfcf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
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

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 67 ++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c79d9992b113..25a7b2c74928 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1044,6 +1044,9 @@ struct amdgpu_device {
 	uint32_t                        *reset_dump_reg_list;
 	uint32_t			*reset_dump_reg_value;
 	int                             num_regs;
+	struct amdgpu_task_info         reset_task_info;
+	bool                            reset_vram_lost;
+	struct timespec64               reset_time;
 
 	struct amdgpu_reset_domain	*reset_domain;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 866b4980a6fa..ca97afe5be63 100644
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
@@ -4734,6 +4736,62 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
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
+	if (adev == NULL)
+		return 0;
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
+			amdgpu_devcoredump_read, amdgpu_devcoredump_free);
+}
+#endif
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4818,6 +4876,15 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
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

