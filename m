Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9176C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 19:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C249410E339;
	Thu, 23 Nov 2023 19:12:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4F010E339
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 19:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCeTQIBXewfqrnpM25SN1mkwOxMe56/8H57nQ0cSsumFKBWfKRna/doB9UTvvFwDe1D2WmKP5lW2j1ZmEBnGWtExJZ2GU6v+CcEbfQrCaHsv+btuAr7tPg6s6tmcxPeynbmoyc0jLYaq/CDlXScCbJw+KFwNXXPoZZYBOD5WQBjSiuCIxuPuBbRzhbV1+/F134nXk5z3cYbYSDQv570q5ztzV1JZbyhJz6A128nriVWdvqYPnePcgW4/0G3A1jZF/vqWfmFmOeOslIv92Xcgn9i9Cw70ONiHWHGcck7YjEU1k9Ygqfgq6/Mt6sF0vdFFE0QsGEXwtr/0SnAjPLrEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Eehc1JCWk0kRgxQ2gvc7VQhPDT8P1BpTeSMH4HAkRg=;
 b=ktJeB5HReEXyFCfsnnJ7VT8JWh6DOPcvpd/qFOuBk8cwarCTBa7bEzT0Sl9frwhxyQqisluLTsFn3eYw4FB0DqnepDsI41DS1fy9j+Ri4+OgqAy2k7bM6/6Iu/5PM7U0qoPGH1P4p5MmhMaL5IBB5SAknKr3q1qDoym+a6zS0j+MI9LKClqbX0AkEnFiu25jG+Xh59xaHz5wDzRNXS0IlNBowncZKiqp2GSsWGhOHtG5qxWzUgeWvH3E2fWmH9iDRzC5+K3y7aXYOLR67davS9pgxjdqxKcfI5ul2ICrO5mVZh3Z7TqJslAtK5wQIRt6zg+QD28RN2kGqAR82qvChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Eehc1JCWk0kRgxQ2gvc7VQhPDT8P1BpTeSMH4HAkRg=;
 b=VYNhEpB1Mb0mHCp4GAzuIdAv85diUHa2WS7o+R37Sdcujb4V40RvVQWw6+P3rhNMf2CoBvs1Qm2/MwecsKHJ4jI0iIPnAEbpQUqJYvNsfdR7V9KkTlGJSTKQX73m3L4TDp8aD/QHhCKbIysFfqUBeVMUz5q9c+eVafeQI5GhqS0=
Received: from PH7PR17CA0063.namprd17.prod.outlook.com (2603:10b6:510:325::27)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 19:12:51 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::99) by PH7PR17CA0063.outlook.office365.com
 (2603:10b6:510:325::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Thu, 23 Nov 2023 19:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 19:12:50 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 13:12:50 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: SW part of MES event log enablement
Date: Thu, 23 Nov 2023 14:12:15 -0500
Message-ID: <20231123191215.1041677-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d44dcc-1c5d-4a5f-39cb-08dbec582ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMvlyyE6BCZzZKxvTpHJr30xWGyBXW+ttP4qgAPdYarUF2UeyzZrbrIZCEfdhMqT+fcrBltg7hubd08DUrBwNg5Tn8n5QnQ1bUk0FRHSt+gEWOk1pZ2hwt/vbfGow2+Zdzgq6CkQejGzGOdoa3GJ/Gegd6Y7BIJ9BoTgud7lHnzWN+bKvcH1N47TDmsJk3LhEWt4z9URjOGCGaHJm3/SKHUko7+BLliZDsqcpNIMoOuzfdkyWMiirPoJb3hcN+d+K0ovh3Voudt9CiBxHasllqOfIRiujyhKOKM8gDFRi/VeIYmfld05/6FOIWbHsTAwYRuYDDooZFsFNo6h6BbNBxeAesHzcmMKjI5DfgI2Ix2wFM4Cx0MDhHNtOnm1QBr1p7F6MYvsSGgGdXi5DLad8NvQq9UDyjqFN5QaN5o2TJ7UhXUhREtz7t8rOQs83lfi7ceeQ+cF8PzQ6a4mukAllgMFIsVqkFNeU85uHlg3eU4+TieRjOtSVkWnnJ0DjNRYoDGQOvRXgC7TocXM8KpGn8yopkfU7mqEzsHMflc/9U5jGnsNPftZRoqDp69P40dqSot26oyBQWssXP4G1mf++LVCZK0afBI50/+lcmm8uMp3guMe8obeYinua/BizFuWgPbJOgWoEgh4NkkhWgbmro+Umq12ThdW78CB+l9MrHHywWkz/xG/r5jfdGyZ9Gp1DoFWzs5Yvt0n0S8oRqKEedVoOA8yamqRGE04GY7jqDegLjZmbHgOaqeXIddJx5piioOEvhjnkK6/qQSUCbFUSAd/G0g9EwQNr/enihHn45k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(6916009)(70206006)(70586007)(316002)(6666004)(36860700001)(16526019)(81166007)(82740400003)(426003)(36756003)(356005)(336012)(1076003)(47076005)(478600001)(86362001)(2616005)(26005)(7696005)(5660300002)(40480700001)(2906002)(41300700001)(8676002)(4326008)(8936002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:12:50.8768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d44dcc-1c5d-4a5f-39cb-08dbec582ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
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
index 45280fb0e00c..b7af24d7db0e 100644
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
@@ -181,6 +201,12 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	if (r)
 		goto error;
 
+	r = amdgpu_mes_event_log_init(adev);
+	if (r) {
+		amdgpu_mes_doorbell_free(adev);
+		goto error;
+	}
+
 	return 0;
 
 error:
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

