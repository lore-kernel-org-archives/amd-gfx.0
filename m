Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907D1C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 19:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295BA10E352;
	Thu, 23 Nov 2023 19:48:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDA610E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 19:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lb8NtninCcYQdtxtLUxzQft4KVvbDAfUPI/CjFqG1Pc7QebSHuaEcPTZNygvdZVTU9sTsCv1wbibtuvtikGEHHQeuOurihzL0ziOk5h4m74+nFxAVcQs8GQx3nAtsm21jTcqS9MV7QA0qH+VWvDPqUe5LEonM35GGus+gOqDuCFQgRHGVb4i1jxLI6/Au1NZvCNO4QNL4xBmEuXLfK03Fmm/bceBQXvU+w86Vt0oGJCvdFDSQ7pQk2WyyGcMchziiX/dJzLJRYYBfoWiuWMOv2fF+eS2Kk/7jgP6FLCcTJMqxGH1jPO0a45I6qN0raAVKSz2hN3ZvWoXPmC5E7TG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDCfm9ewYy93QmXbWBt0MOjLMqN/HpngFsYbOAeBnJI=;
 b=Omz+ouITTv0YeDsr7IWO19W7McGTj38zX0YQQjX9AbFM641QR8mqNeAueWmLqxwjFuI9VfFut5oWOxYeXRybWPeq9jjtjHiLvHiV09JaHJwdy4SO01+e/iOFf/jZ7lYeG6wRD0Ee9LDKN8DYELhvRgEAK2krYDYOIHbrn6R7q5axxQWgMTzvtazMC3FD4hINhFf6jMMYVPsYrmYH8uMfLsQfvQZJh6rxgf29T556yXYReJ7/ox15np/dF8fL9Yx7GrmEa+SpzPMv6W9x03yNlKmIgZp1XXJSvyCOtKr9Tmp0aHbS1gIdF+QbcXNPGD29zarke+DrSbl4uXxBAxklPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDCfm9ewYy93QmXbWBt0MOjLMqN/HpngFsYbOAeBnJI=;
 b=NpqmgBMx83RBtZI/eArRrLXIzAjr1Z4BA23DrXLW/CxD2OKiH9PqZ5J31VajVx5cQrshTE3K/+VrxfvkojaOii16kVwbLab4Es/yPbG+2aT78H1cBbO+POv8M5kRTXv5v1A5vCo4muhczZa21LHs7FwXhrk12YH8phxMzcpnCGk=
Received: from CYZPR14CA0041.namprd14.prod.outlook.com (2603:10b6:930:a0::11)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 19:48:33 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::a5) by CYZPR14CA0041.outlook.office365.com
 (2603:10b6:930:a0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Thu, 23 Nov 2023 19:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 19:48:32 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 13:48:32 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: SW part of MES event log enablement
Date: Thu, 23 Nov 2023 14:48:19 -0500
Message-ID: <20231123194819.1041850-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 5413a307-74b8-4548-2370-08dbec5d2cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JnnFtWY5AyLnU91PWmCqJjfjTVaFVOMvkNVDxGw+N6nXl2X9JK8zDi21XSMuMq5FVdbNT1RBt0zbOk2116wcV7HebgR+1C9h5sBbCBaQGuOkyIkS2/7NeXzJoM8m2OnakMJfLLDWim2u0Xm1mtr7Ur58idJhMGBPLkPTMGgR/LRjOHZxNI7a3+7JYJAfoc1u/rY/jIX9yd/K/qU+ArN8PARK/2jmAQV/z5Tw6RXmjh3yhpRiBwvlXQb5AQ6YDmG083GueSY4Pwra5qgD9dF+O8qHuELrl1GfDHydKFHdrQjd3op3CYyKPsybtFkN+KPu2sRJR8Lofnn11Egan8ciJhZkNrNvd0afm1j8z8tLfc+A0WkoacJfDRduQLPrDCBKzNL+QAxH0gnYJDEtg1z1MIfq7VGfzbcstfgGR3TJEh2o19ZtWFEypVsD+AnVRDV42cctDaZeJ9wTpY37sJU6oekmI4c595UqEnbD4boDCBn1Nw83djMh7elqCxApOYbR3Yk/AP1v52YmG6YZVD0wuqFX0Iag6MFioYE/Eon2Dj309HhgViI+4Iu0RLSQ4bWeF/DBxg/AERQ57qQKiy0IgHjbnAzt+QY9HBM3Wh8t97QvOxr/1fFuUP2K6AKG477UjoRUzbcZlkVN/3flZThiEfU9Tk5FadzUwgAFryTOVvBUa9iLLWePalcClrXbRHPy1tSxlZ/oURhTdMDE8itDTxXXwTw2IHzDfjXd4ZuO4L/JZ1W8zYb9c4iXgKeFyZtXAWQIJqwPbWEOpeittTz0nnnIuvpltvoz0bUTQwAmxA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40480700001)(16526019)(40460700003)(70586007)(6916009)(70206006)(82740400003)(81166007)(356005)(36756003)(86362001)(36860700001)(47076005)(336012)(426003)(26005)(1076003)(7696005)(6666004)(2616005)(478600001)(2906002)(316002)(4326008)(8676002)(8936002)(5660300002)(41300700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:48:32.9627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5413a307-74b8-4548-2370-08dbec5d2cce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is the generic SW part, prepare the event log buffer and dump it through debugfs

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     | 61 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |  5 ++
 4 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a53f436fa9f1..8b2cbeae99ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2140,6 +2140,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	amdgpu_debugfs_firmware_init(adev);
 	amdgpu_ta_if_debugfs_init(adev);
 
+	amdgpu_debugfs_mes_event_log_init(adev);
+
 #if defined(CONFIG_DRM_AMD_DC)
 	if (adev->dc_enabled)
 		dtn_debugfs_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index 371a6f0deb29..0425432d8659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -32,3 +32,5 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev);
 void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev);
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 45280fb0e00c..b4ba556dc733 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -97,6 +97,26 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &adev->mes.event_log_gpu_obj,
+				    &adev->mes.event_log_gpu_addr,
+				    &adev->mes.event_log_cpu_addr);
+	if (r) {
+		dev_warn(adev->dev, "failed to create MES event log buffer (%d)", r);
+		return r;
+	}
+
+	memset(adev->mes.event_log_cpu_addr, 0, PAGE_SIZE);
+
+	return  0;
+
+}
+
 static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
 {
 	bitmap_free(adev->mes.doorbell_bitmap);
@@ -181,8 +201,14 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	if (r)
 		goto error;
 
+	r = amdgpu_mes_event_log_init(adev);
+	if (r)
+		goto error_doorbell;
+
 	return 0;
 
+error_doorbell:
+	amdgpu_mes_doorbell_free(adev);
 error:
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
 	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
@@ -198,6 +224,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 void amdgpu_mes_fini(struct amdgpu_device *adev)
 {
+	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
+			      &adev->mes.event_log_gpu_addr,
+			      &adev->mes.event_log_cpu_addr);
+
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
 	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
 	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
@@ -1483,3 +1513,34 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	return r;
 }
+
+#if defined(CONFIG_DEBUG_FS)
+
+static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = m->private;
+	uint32_t *mem = (uint32_t *)(adev->mes.event_log_cpu_addr);
+
+	seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
+		     mem, PAGE_SIZE, false);
+
+	return 0;
+}
+
+
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);
+
+#endif
+
+void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev)
+{
+
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+
+	debugfs_create_file("amdgpu_mes_event_log", 0444, root,
+			    adev, &amdgpu_debugfs_mes_event_log_fops);
+
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a27b424ffe00..894b9b133000 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -133,6 +133,11 @@ struct amdgpu_mes {
 	uint32_t			num_mes_dbs;
 	unsigned long			*doorbell_bitmap;
 
+	/* MES event log buffer */
+	struct amdgpu_bo		*event_log_gpu_obj;
+	uint64_t                        event_log_gpu_addr;
+	void				*event_log_cpu_addr;
+
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
 };
-- 
2.34.1

