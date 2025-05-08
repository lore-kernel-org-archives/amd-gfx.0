Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1287BC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB6910E2A9;
	Thu,  8 May 2025 05:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cktwYOy8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB0F110E31F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR/IsitVxOB0eWDQZDCrmHD1BYI/cc21fOUbF3y72pGzg0pjs44C5P3DweMbZ07rwznHcZivcAJWHhNE509+Zz+jKwjuGyjthMqAZ8Q+chRTLkRkaRU1Mg1QPrA8yXHdvLgjeaZuE85T+TCquycvcbRbJWZekk4szTM4OgU7+aJP12yAWaFYoNBIYzl113Tt6UUDr5Bp+ZJeeu3+ddre4cZJRQ1gqouZSDl1SBdonzb45H3SH40qe7fsRrWRZ7pns1NIQYJfLik9uuth/GALebLzpI0GEZaXrE63xAEh/hWOlL4+cqjfirI3k+P4hJpv9G/BjkV8z4aGMdeIU3D6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qQTZSwSAqMqhFEwfJGWZoGbboqPOGIYpLIig5wnt4Q=;
 b=op+EcrDD92xVam9HSZINlaVzXjsTakjk4srBX4ueD7OQGeOXx6EA3h6t4vkwsz3+q8TC/47Utmpbz+4nZjKuGjYj4Jfb5W4NPmNHiSqW9nKGA8t+Ti5OemRK21z3XE4rvh0t84Yg/J7LZzu/0JrFzkRIIKNEzOwSd0XEOL9GkVWlDW3V9BW6Ez4Po5qkKPJhBsIJNTKeZhKjc6S+HXM3qUmyoI6nSjhq5yEMJzCHvQAvtlz1ek32NIZ+V+A7kSePFFuYQgv2QidkH0jiQckwFb80/JgP99PoTKaJay3Q4QpLcdT+VMXIk5jsVPsYZDqJjYZ51MU2BXtUvbQVvO5MYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qQTZSwSAqMqhFEwfJGWZoGbboqPOGIYpLIig5wnt4Q=;
 b=cktwYOy8ss+mL3k2Geg4Kmi1ZqaRGgnL4SWAbQABLm2cp8lAgzSyCCz6L6zhyW7bZP3rjvz9wLTLpkfB9e2wuIGexENhRgPHf0HxjCp21AC8lF55bkFz97lh/PiyVP12aE0PeZ821xlIpNyaxhkVxRp0Qkdarx7XDZus0JNvPnA=
Received: from PH8P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::26)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.37; Thu, 8 May
 2025 05:10:10 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::73) by PH8P221CA0047.outlook.office365.com
 (2603:10b6:510:346::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Thu,
 8 May 2025 05:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:10:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:09 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:10:07 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v4 4/7] drm/amdgpu: remove cached gpu addr:
 amdgpu_firmware.fw_buf_mc
Date: Thu, 8 May 2025 13:09:23 +0800
Message-ID: <20250508050926.228674-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508050926.228674-1-guoqing.zhang@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1417cb-824e-4225-8a9c-08dd8dee9af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o/iqXZWZXYuzfQyl7T67JH+CxHGhw6DPwii8Gb6bHpEj1J3KJ6YzkxpeYDI/?=
 =?us-ascii?Q?n3hTVFgNa0uEmwABZtl7c/4EPKZ23huch3WwFhYITkM8h/uA5QNmXe9Du2Sw?=
 =?us-ascii?Q?Zw9uPxDUEse49WRdcEJTvMzFOVVVwFbXlznv8NWmoqIk64XPLU4AgDjas3qb?=
 =?us-ascii?Q?RyeJcvhddNE5piBGsa9evWCEiTINYPDSeNYsCQ8BNPaxm0ZZpFT3ELuJtvu0?=
 =?us-ascii?Q?7ibvdAX4rvyZEqX0CjnzGAF19hc3vtbsHnh/E1NN/l4If1pS8lbmjMonw3cU?=
 =?us-ascii?Q?XLihW9iTr/Lv86hnaLQMhkhHuR8p/kkN2CAA5cpPXZyWwS2zAcysjVnHxAss?=
 =?us-ascii?Q?PKfsmkvTv1fYXWDMlrbMJqNkyJU7HlDn3RRrf2po00V6d+QL2Gw6YtyBEFXZ?=
 =?us-ascii?Q?mjw01mSeo0TYHBrzBA7J9k9VzUUHb5HYKiae5K+ADI1K5ixJyU1uHhgs9feZ?=
 =?us-ascii?Q?TKqBr5q1iwBh9rsndxZgGszXGdHPTUsjpSLuhAeE3sGvMXrmadUvPbnRRb4W?=
 =?us-ascii?Q?ttavjXR2OZGcTvNvU23nQSAZG4OSux2DIrj+GqF6fiZDchPNVj6nUnArh1XL?=
 =?us-ascii?Q?QiOCwE5alODLZlQ0gV5QZu7eHe4ymX9traSE9TW0QAbTW5qPbhrqTf87dBV8?=
 =?us-ascii?Q?2OLyynRJZyy26JglxIEB7wQdbWCmjWOwqc5/Evnt6tRbLV81Va3MKycldj+J?=
 =?us-ascii?Q?yDFisWv7rzkhKcexuaCXI8wWQG43qliB6ko7RyqkrahHpJrQy/H6Xx2k7CEu?=
 =?us-ascii?Q?teZiim6aWZWPlCZk+ViaD4831NNdo3dmdIn6WddfPi9ZataRbTHh9RNSdvnE?=
 =?us-ascii?Q?RgAGSE+RLGIm+DPMKOGri4o3IKVUr2edO3qNhjwYqbP18+KCYg+1MbFz8XFT?=
 =?us-ascii?Q?5R3f7OCsDTX9IHfAuzVvVi8FCIdgtAQiCS2Vyp5zPMtLt3KTl4ucSJVk88Nq?=
 =?us-ascii?Q?M5zFfRn3ei2wnehyeLaWS93pgEey/+FLLrp+OFv5ezAaJEFTZnWJU211kCy8?=
 =?us-ascii?Q?2V5masJ6D/8eY1NrXXK/ZY6w6sd6Y2gMglPqf1SUQ2wIpktSPQwfnLwjSG+g?=
 =?us-ascii?Q?3kPr8Xtr63KEOw/auSCt9R4sdT+jfKJUISN/NPj8ZdN/Aw0v6Uwu8n/aBPVW?=
 =?us-ascii?Q?9pr90P29vAh/uPouyCNXB+0RY389t4xj9Ri+s+oZfam+TzYT0zq91x9Nsh+u?=
 =?us-ascii?Q?WIrOwVmj3/jU5y6gSLVVCNABzU9D00Pn38qO2dsvu+3ix1NXrrj8RuP4ETB9?=
 =?us-ascii?Q?g7CCfA99OSHyXrzDpY9r/Uzmgeoq1tJERYpPFFc/uro1uS2uryyTq/5Vf8PK?=
 =?us-ascii?Q?I99wYz34rSk8fa8ZEeWqA4zU1UuZ1zIv5CjP6f8vi8CXWTGe0KvQV6QNcGKQ?=
 =?us-ascii?Q?DhH9Sez6jcB8/FpMpDSODu0Z8tnPBN/7MrNXDoo+wXxFWHJ6PqRglswHQUDB?=
 =?us-ascii?Q?zyEHK6ccHPxVMYCrDtk+zbciVMsgLQPZweF+jV+BJBdZsBhxbV1dm2RVf6JK?=
 =?us-ascii?Q?0aa4f4Id9ONcpGQ8d2tdwNnpG5TA6KQBqvMJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:10:09.7209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1417cb-824e-4225-8a9c-08dd8dee9af4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489
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

When pdb0 enabled, the cached gpu addr is not compatible with SMU and
PSP. It always need to be updated. Remove the cached gpu addr and use
local variable instead.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 -
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index f3b56c219e7e..0ffa6c315158 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1111,7 +1111,7 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 			(amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
 			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 			&adev->firmware.fw_buf,
-			&adev->firmware.fw_buf_mc,
+			NULL,
 			&adev->firmware.fw_buf_ptr);
 		if (!adev->firmware.fw_buf) {
 			dev_err(adev->dev, "failed to create kernel buffer for firmware.fw_buf\n");
@@ -1126,13 +1126,13 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 void amdgpu_ucode_free_bo(struct amdgpu_device *adev)
 {
 	amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
-		&adev->firmware.fw_buf_mc,
+		NULL,
 		&adev->firmware.fw_buf_ptr);
 }
 
 int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 {
-	uint64_t fw_offset = 0;
+	uint64_t fw_offset = 0, fw_buf_mc;
 	int i;
 	struct amdgpu_firmware_info *ucode = NULL;
 
@@ -1152,20 +1152,19 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
 	}
 
-	if (adev->firmware.fw_buf)
-		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
+	fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
 
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
 		if (ucode->fw) {
-			amdgpu_ucode_init_single_fw(adev, ucode, adev->firmware.fw_buf_mc + fw_offset,
+			amdgpu_ucode_init_single_fw(adev, ucode, fw_buf_mc + fw_offset,
 						    adev->firmware.fw_buf_ptr + fw_offset);
 			if (i == AMDGPU_UCODE_ID_CP_MEC1 &&
 			    adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				const struct gfx_firmware_header_v1_0 *cp_hdr;
 
 				cp_hdr = (const struct gfx_firmware_header_v1_0 *)ucode->fw->data;
-				amdgpu_ucode_patch_jt(ucode,  adev->firmware.fw_buf_mc + fw_offset,
+				amdgpu_ucode_patch_jt(ucode,  fw_buf_mc + fw_offset,
 						    adev->firmware.fw_buf_ptr + fw_offset);
 				fw_offset += ALIGN(le32_to_cpu(cp_hdr->jt_size) << 2, PAGE_SIZE);
 			}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4eedd92f000b..47825c82a3ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -599,7 +599,6 @@ struct amdgpu_firmware {
 	const struct firmware *gpu_info_fw;
 
 	void *fw_buf_ptr;
-	uint64_t fw_buf_mc;
 };
 
 void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr);
-- 
2.43.5

