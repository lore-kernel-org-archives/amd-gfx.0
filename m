Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AF2CAC5B9
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 08:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C5A10E537;
	Tue, 30 Sep 2025 08:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jhUn25Zs";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B838F10E524
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 08:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pouE8XxWLoKIi274/sPpO+GifOQZgp+Gt8gJXAhL+EI6VZBuQQFaE+50RghNXoMME6pgN6ka6tTHK6rpeE8umJ0Kw835DQeG0nPCx7lJVelL/XMVkdLyAYwIrvVrRiKL5Ol8GkxE8xt/LWU+vjmOWfpV7uKsHDQiYpf3jeYo8FynHm5ul8tIGu4Gay1gUD0sPmgO1BFRx5EZuYOhGwPq4of3CmWBcCn2gzWb7K8PCTRb7rGymDKZR/D9jX6xfqpckBblR3KLvGPKjhcma8fez/Z4YLtlhyky9rDBE/O7zyaONQaT6/Ove+z97hFjWed660mTHzYpKwyxq0gTu1Jk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXyFzzLQldmMtQ5cYAaBK7PdvCz+7DyU+Wk1YNQ44Mo=;
 b=UkeYgSyz8wgxoR0Pus2TI+Dal15ytBXEMBjPs3T6cy2xoE6eMohgZYjAnWRR6JDHXDwcHKeVzve6Yvz8UjRXjdrgOv+AY1Sn0/sn0Nr05HcT1zPAYRq9HaRDfzsHJ5ed2QxvYPa6EZ7AcUPJuYSOmSpgDQ1GYKA+l5K6rgKMuIDHUqZLq9Jc1Qq6+69GSguAFZcbsAyuYrSMFx6tiwE5wPdwd8iE2tjVq7d16WwWYfiySah8U6ZoE0VwGWBkgKaoTeb9EmJhZpjx8pxyJU+l/IF+M3RPRzE+Up7IuutYdPDV7iUwWH+lvEXMqpkW6zyZ/Xg2TEU8u27t92usysKoFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXyFzzLQldmMtQ5cYAaBK7PdvCz+7DyU+Wk1YNQ44Mo=;
 b=jhUn25Zsj4MKz7+eoUQs0hl7cTDzWPp264Z5ijkgSIFTSfqn41wtYCW/9EFEYooi1Vfvqn/PM+SmRuN78yPT3/u/7QAYHSAA10dWEfsNbPBN03E05a/4q8izcEmKOL2HkPfbmFhOmWDajUjWGHZ4jHKQDFZeJNGrwjgFyv9l9rU=
Received: from BLAPR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:36e::28)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Tue, 30 Sep
 2025 08:27:02 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::3c) by BLAPR05CA0013.outlook.office365.com
 (2603:10b6:208:36e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Tue,
 30 Sep 2025 08:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 08:27:01 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 01:26:51 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Add amdgpu drm ras ioctl for ras module
Date: Tue, 30 Sep 2025 16:25:25 +0800
Message-ID: <20250930082525.118197-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930082525.118197-1-YiPeng.Chai@amd.com>
References: <20250930082525.118197-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b80fc6-677f-4195-d0e0-08ddfffb2130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wla3t+Zeb242yR8elvSw6r+xxXirbK/oZdlGgP8jMEQOHr7vkzW8RndHpB+6?=
 =?us-ascii?Q?FJnx5LyrM05lW1AYm7E95yCBPnp4QSIWm6dnsU/4qiaDm7IM60+vPHVemSFy?=
 =?us-ascii?Q?OiNRoSUGGpmDz8IV5pM3PoOWC9350szzpHkAuHvkQ4EbMnwpWBoBXRxTMTPF?=
 =?us-ascii?Q?1U7M6je4nnrVx9pZc8lXk9g6VavCDDqJxoQAdvc2/X60cHOYhtI23np5njNu?=
 =?us-ascii?Q?36rULKJMu34sQzTs4bZoKEQI30BQj+NkBC7OL/N9ScWYLLLlauay8wq6JDgE?=
 =?us-ascii?Q?VYEu0YBqoj9J3sfgelrw6XE/eYZ2vt+jU3I5mkRWJT1ydhdWadLhCtoIWJ04?=
 =?us-ascii?Q?uGpC4Ur2OodbHLRfRe7vmA3PP8Dmdk2ufunUkIyrtfSBmqyXlS3nSYL3hIfM?=
 =?us-ascii?Q?ijj52osUXm1haVT19sHyEDxgKdgVIXaJB0fKnlMNl/1LMUTgp6TAxJ1ANHhz?=
 =?us-ascii?Q?U+F7qWEv2yQWTMVrSdNToztbZ9lGBcOxMvFxRBQ9bVowc1eRYgFK0xAl66Pg?=
 =?us-ascii?Q?jWHzBgroMBj/PXesCxlTQ6w+00kNYdgV571KyyNwSoyokZlM0jlEHSwR7kI1?=
 =?us-ascii?Q?KdRN9cluTuGyy9JdneA7FGRjoow97ndUTkcpKglJeO6N0V4ObscumoduPiTY?=
 =?us-ascii?Q?xQ3AI9weZidapuSpykhB4gun47aYe9gf2w3diaE4a3cFB1KqEcTvyGNGBMl3?=
 =?us-ascii?Q?mE1yEYsdYA/iPwbc2kxyb0c3OFyxk5VwfG7eAsR3XxoTTnfJinutLhkKvLih?=
 =?us-ascii?Q?qOfTM1JYCuewQWAipawfWubdLyVl9gl95GQUOgNqPGfZHumPg4fvKf3OjTnq?=
 =?us-ascii?Q?us4gZt7/YTaAaLVtWNjVgJBSPxpFExW8uCD+U1GkEbhFWHcOuiUpRujztpBK?=
 =?us-ascii?Q?GU+cXBf7m5zP7Bz2LbH3B5P+YzFPRHGWbm8XIi+mz6XpOsHemuHtovmkJos/?=
 =?us-ascii?Q?dTmiT74tVAInppQS23fW1n9RDtyscaurCaF9+GPWiFP3xSkRy/P44vCpvvrr?=
 =?us-ascii?Q?JDqaBQAITjjo2w6Wc/LAFUoW55SlelyrfpyCxw8Ut/UbTU2Ups/OTbP2F9ij?=
 =?us-ascii?Q?KYfUWW7UEpOurv0SJ9oErImXD9VhxJSnn/Md4/tCMFVr0nGa6akuNMQPHqp8?=
 =?us-ascii?Q?DckAY+tT7Uyrh0i+bskX+Uk258xPf+mRjMgchwkhq+jGM6jS6w6klkWEsr3D?=
 =?us-ascii?Q?vJxpQcJsUBRCeoWapIGkoUCcrQqkmvsmmrdTwd25SJsq1/xf/x+dr9hy4Wsv?=
 =?us-ascii?Q?/ALajZIXE1XvVs9V/Ml4g/wi13UIYADH94MzuLglyIfbX76H/zEa3nJdiwx8?=
 =?us-ascii?Q?HIR9DJpRrVshVLW8xaZoyM61OLb6/EsI4saI6zt7YFUWdxrGBo4v7fhTNxIF?=
 =?us-ascii?Q?AGFmNeewgzQRuQffcgboEdyu9nJCYRkDVHBlFhEPgAqxYSJY3CqHXZvEMeGI?=
 =?us-ascii?Q?6M3F7xjObJiaL3BB1HloV+O7c7htNpZh+C1Bpyu9B2//Muf1hE771r2EcXYj?=
 =?us-ascii?Q?yDoXOQrifHHLQCPwn1DbBG35LVuf1WfCyq0zfFDcMnEZOnHeikJVN/2/Bls/?=
 =?us-ascii?Q?ifk4icF0Lc2eKU14/J8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 08:27:01.4759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b80fc6-677f-4195-d0e0-08ddfffb2130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add amdgpu drm ras ioctl for ras module.

V2:
  Updated ras ioctl structure and description.

V3:
  Rename the ras command.

V4:
  Remove some variables.

V5:
  Add null pointer check.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 44 +++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h                 | 32 ++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a0df4cabb99..55cd2f75333e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -718,6 +718,9 @@ int amdgpu_cs_wait_ioctl(struct drm_device *dev, void *data, struct drm_file *fi
 int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
 
+int amdgpu_ras_mgr_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *filp);
+
 /* VRAM scratch page for HDP bug, default vram page */
 struct amdgpu_mem_scratch {
 	struct amdgpu_bo		*robj;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4905efa63ddc..f7038ba8571e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3057,6 +3057,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_RAS, amdgpu_ras_mgr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index 195ca51a96d5..882b8ab7c843 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -361,3 +361,47 @@ int amdgpu_ras_cmd_ioctl_handler(struct ras_core_context *ras_core,
 
 	return RAS_CMD__SUCCESS;
 }
+
+static int amdgpu_ras_get_caps(struct amdgpu_device *adev,
+			struct drm_amdgpu_ras *cmd)
+{
+	void __user *output_ptr = u64_to_user_ptr(cmd->output_buf_ptr);
+	struct drm_amdgpu_ras_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+
+	if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
+		caps.oam_id = adev->smuio.funcs->get_socket_id(adev);
+
+	if (output_ptr && (cmd->output_buf_size >= sizeof(caps)) &&
+	    !copy_to_user(output_ptr, &caps, sizeof(caps)))
+		return 0;
+
+	return -EINVAL;
+}
+
+int amdgpu_ras_mgr_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *filp)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct drm_amdgpu_ras *args = data;
+	int res = RAS_CMD__ERROR_INVALID_CMD;
+
+	if (!ras_mgr || !ras_mgr->ras_core || !args)
+		return -EPERM;
+
+	if (!ras_core_is_enabled(ras_mgr->ras_core))
+		return RAS_CMD__ERROR_ACCESS_DENIED;
+
+	switch (args->cmd_id) {
+	case AMDGPU_RAS_CMD_GET_CAPS:
+		res = amdgpu_ras_get_caps(adev, args);
+		break;
+	default:
+		res = RAS_CMD__ERROR_UKNOWN_CMD;
+		break;
+	}
+
+	return res;
+}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cd7402e36b6d..71771755eca8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,6 +59,9 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 
+/* amdgpu ras ioctls */
+#define DRM_AMDGPU_RAS			0x5d
+
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
 #define DRM_IOCTL_AMDGPU_CTX		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CTX, union drm_amdgpu_ctx)
@@ -79,6 +82,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_RAS   DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_RAS, struct drm_amdgpu_ras)
 
 /**
  * DOC: memory domains
@@ -1686,6 +1690,34 @@ struct drm_color_ctm_3x4 {
 	__u64 matrix[12];
 };
 
+/*
+ * Amdgpu ras command id
+ */
+
+/* Get amdgpu ras capabilities */
+#define AMDGPU_RAS_CMD_GET_CAPS         0x01
+
+/* Input structure for amdgpu ras ioctl */
+struct  drm_amdgpu_ras {
+	/* Amdgpu ras version */
+	__u32 version;
+	/* AMDGPU_RAS_CMD_* */
+	__u32 cmd_id;
+	/* Pointer to input parameter buffer */
+	__u64 input_buf_ptr;
+	/* Pointer to output buffer */
+	__u64 output_buf_ptr;
+	/* Output buffer size */
+	__u32 output_buf_size;
+	__u32 pad;
+};
+
+struct drm_amdgpu_ras_caps {
+	/* OAM ID */
+	__u32 oam_id;
+	__u32 pad;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

