Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DE5C28B28
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 21:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5721E10E1A7;
	Mon, 17 Mar 2025 21:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1bUDOTQD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611F410E1A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 21:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPuaZg1D8jwAvKaw5oD54Jap+e1rX+MbGXhi5qxd1A66DSTS+bkjMy/3WFjcxGwgRIPHLXOx3WWiupOPEQkGgbenZLjxHGyj8HCe9CZZtFUZvkuc+HABSHOVFyc3RESoXM4Lunh7ZcjtekKQFoQA+tFIuEVz0bLpxt6qaeWEelyUaIyh6GaUcStwDNcqOA+lm0qev4IKvs554DLhG8g2o5emHfrL3r1uBiQVDbA1oTR/FT3cDFCOQae7JxOVQYm5VVs0qzb9zO/g7SJ06hIWNrdhlCHkhDas/VIRYLvxc+Psb9cOMOZxToSRkzcSwiifijEKYZI/XWw4AwXE281ZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=778hYGHm5BbDTLX+62oHDaVu0X88u6djEChWzl3u01U=;
 b=VqnJEDnD2ftBqnfAZmSGnO/qoN6OIp6L5rgDt7bskzV67NBjW2JvdNU0aNyF5ar6NQdKwFpAvyUB6Y82tS+5yKqok4PiGEZMuk8act/PCstofan5KaMvPYiZZR//eRd0e09aStlUL5e4s6Zd6HEAV/II3yTVvEQSjP67rDQfqQefF/a92lwUYXQwRQ4a3hol8dSwC1qk5hR3FaVPFkS7+p5ztzqg9Jd3FV3HzBlOiTNtXZgQ08MplLzybNEYBkzVSu1/6muNa797elLyhhAVLzYUF6asFjoULI+Y/KwiGPgo5c2teSGMd0aXmCvqFnhIAgQciMHoz+HlajXLDg+CKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=778hYGHm5BbDTLX+62oHDaVu0X88u6djEChWzl3u01U=;
 b=1bUDOTQDGVipJIRQlOaQkhVVKts3TVQE35YaTTkeenwK8bRCrvf9P9Z0f+IKr3A0GzqbfSuVrhMORT3JxlSuCewn0Mke3mUXib9xYxOLFELCmSD/sSvqQbVe2UmFMUHFcDejOpxqF8uWjVuN/nmK3LE3+YjHIrOqFRk4opMEIXI=
Received: from SN1PR12CA0078.namprd12.prod.outlook.com (2603:10b6:802:20::49)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::605) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 21:29:34 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::e9) by SN1PR12CA0078.outlook.office365.com
 (2603:10b6:802:20::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 21:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 21:29:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 16:29:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <marek.olsak@amd.com>,
 <prike.liang@amd.com>, <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add UAPI to query if user queues are supported
Date: Mon, 17 Mar 2025 17:29:19 -0400
Message-ID: <20250317212919.1018717-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd807a3-ad59-4e98-834c-08dd659acf32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zFFs7Ewg0XteU3NZCJNANEEKeMJm5F0cRrpnaKiH4W1fJrUUUlFhABiNUJfK?=
 =?us-ascii?Q?1oX7ScXQO/RlcPJFc1c4Y7JIzAbxLCjyr9ZtNsm8GPT50xQa5h/RkpmEXyQu?=
 =?us-ascii?Q?vEM9lz+0GuwVqvVsOyoGlPB/kstGQlzM95cR76voNE1jAW4r1MkYieZ4GGrx?=
 =?us-ascii?Q?5Fybf9YOZRk2YSMc9UZ8E0WHoVmLaUgI4kKDpHDxWfHLtSOi0I7F6J1ch/cZ?=
 =?us-ascii?Q?e3lTUyRFYoDK7NhdavOTp8avnEoeZIfzb5DXfNrf0HUXDDlh5XJeWD9XnLke?=
 =?us-ascii?Q?zmqljfSY/dxKZZQZf+loMkVjMU4rid1Tul+Or2Y8Q7Ka0ywQGQNK86M3y8ZN?=
 =?us-ascii?Q?+XZg3CgSWZs2rnSe2cLe0icDzMFIqZ7TZrbyXZlUJQVc1XW9xrczn7ELJzA9?=
 =?us-ascii?Q?fj+csa9Eo6mnwJU1SfhIC06gQVlEyLfcKV4hsoIswxDJUFJ6y3AdE5KErvq7?=
 =?us-ascii?Q?7038I8Evn4a/nHLybvmYgh3WNvWwtOy7TJXS4KFSthLbq7a7xus6yILoNN5n?=
 =?us-ascii?Q?3+hAtyzCrEWMjMgT6XaOZhnqgJ3kDD7U3H5uCZgurOtva5WdT1acJpcbM0CZ?=
 =?us-ascii?Q?lTUOCeIgVyg8NYmCHkpcjR1SVzI142hlkNG9CoKf0xskdr3guVz9frr/TOJS?=
 =?us-ascii?Q?Eu2wNcpmN+p0RvjrDXpTujj+mNI5Iebium3kjfvafBY1NzdsBiEQr0gufJfK?=
 =?us-ascii?Q?KFYKc6W58PqEXwqEt8z52v3DESi7C0raIlCLCCcJkrxPpD0VNiPKzgXB3CAV?=
 =?us-ascii?Q?pwSwQmP0BMszcybbJz6Pe3pKVrYxURKTN1CkNk7qZ6tkudWGZNrhH5Yhub/l?=
 =?us-ascii?Q?YB/eH5rhhKERRFMSwXNcu818TpTvrhg/BEclkKMJKVap8kUYDk7lDHJESQoO?=
 =?us-ascii?Q?KYtjBeIEnV8CpYudGk0h6sTCqwqJ0BlzHEqt2iOlYo4AzANZgInBIFFspPL5?=
 =?us-ascii?Q?X1yMDc2/yKR+e2DuTKa80qjLWPqsmyVzRor73SuW31bXCFiFXzswPc0f1MP9?=
 =?us-ascii?Q?rqI5ojYyidBXLrx8F8irIaJy4/ub6Zh3ziIm5AhB0EhCXTTt5nOx2ZDl7BeR?=
 =?us-ascii?Q?Yf9UPzFw2MX8EEQdwOC1Z+NEH7k0fLexqAv2uOLA5uKYKQLe81Vpj8clOQeH?=
 =?us-ascii?Q?EyKvcE7HTiz/mT3mmK0toIGxUtmQ/8DZxWdcWOrDAOZp4BWAyjYv4tg5v25d?=
 =?us-ascii?Q?qCMHfwflKwaTYAJlworAFO9fz+jxzV1kTs1U1jDmHqnxYAETMw2N87ukWvZP?=
 =?us-ascii?Q?b94/Db7E7VTsQMF7Gf7t0+FBmuCXVcRbiHbNyMoAwTxrN7pv5hP/0y77fzvD?=
 =?us-ascii?Q?p2cn+LjgZjJmn/LbQKelAVAjnwewC+q5NCe584dStjfE+gVT9GPMxTB3ouRP?=
 =?us-ascii?Q?9nCuYwyJTwH4MFw77i7AQJH+THvkc1CRQyfAPUvGXYlhh1cdXFqi7369vFNE?=
 =?us-ascii?Q?bLDitsX6bNS8jAuMXxWxXU+ac0ECCN0BkiWCL8bbIk5RL4NSvX+n5EJfdL5d?=
 =?us-ascii?Q?UEyJ8Iqi73DbLj4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:29:33.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd807a3-ad59-4e98-834c-08dd659acf32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6
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

Add an INFO query to check if user queues are supported.

v2: switch to a mask of IPs (Marek)

Cc: marek.olsak@amd.com
Cc: prike.liang@amd.com
Cc: sunil.khatri@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3b7dfd56ccd0e..1d683c0487697 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1340,6 +1340,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_UQ_SUPPORTED: {
+		struct drm_amdgpu_info_uq_supported uq_supported = {};
+
+		if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
+			uq_supported.supported |= (1 << AMDGPU_HW_IP_GFX);
+		if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
+			uq_supported.supported |= (1 << AMDGPU_HW_IP_COMPUTE);
+		if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
+			uq_supported.supported |= (1 << AMDGPU_HW_IP_DMA);
+		ret = copy_to_user(out, &uq_supported,
+				   min((size_t)size, sizeof(uq_supported))) ? -EFAULT : 0;
+		return 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 5dbd9037afe75..4b64e91002c05 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1195,6 +1195,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query if user queues are supported */
+#define AMDGPU_INFO_UQ_SUPPORTED		0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1572,6 +1574,12 @@ struct drm_amdgpu_info_uq_metadata {
 	};
 };
 
+struct drm_amdgpu_info_uq_supported {
+	/** returns a mask for each IP type (1 << AMDGPU_HW_IP_*) */
+	__u32   supported;
+	__u32   pad;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.48.1

