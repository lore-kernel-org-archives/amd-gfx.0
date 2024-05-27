Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29366C25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 16:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF1D10E091;
	Mon, 27 May 2024 16:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SqezLUdw";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C01989317
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 16:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbGESzW385WKgqD3QQ2Bs54B8uEn2yphmncCINWr4GbBfKvgFdGMWKRZJctAtecq0Ok2Rko1Z40oz8Ku5AldJAFxEyY0Kncxoi9Kku9r1imeM9FEOg+HDASuIkrH9mE2XsJjppVra33ngoyKUsk1Fn4AecTp/daMcnAuK+phRYGX0A6GUOTV1Yje9PEDS0lSHrVifY0cXmLtTkae1KkigdcIQq3pXp29aK0Sdj9MXenqVeoA6PEW242MvcVSSgOzvZ8Y0bfzd9pP5wb0WSFKRFKS9hSPUobIdwuYrhcdDyenjLJ2KN2tsnP7MqLJQ8xwpPs9KHGTf4zM1h0OJ3/B2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HONggmRwVGHxrYjrGZWYSXaXbFQxFTtizaAPjJCEW8o=;
 b=YMv6STxif2A/j+44SMBagzpNG2s49GwYtcsiZqg9ipTIJIYyDMNaLxf7eRKAki6fjuJQkCgbdHzl5e3rKjU+HLsyIreMVOKEXDvdnWRelo5NRNM57ljB+U6NvYN5Za2QiIbLW4Zbo2zi9IEdGDGS7sYrdSmUvZUS3pPazY6svF0A0FXTZFy8aoTWi5god8RUi6oagyPeDRcVmX235LYBeGFZi1srEBq26Icy1Rkk1vea++feCn3LxLth4LaTymZoogQNT+V6IS2Vcsa+lYMVFS35zQ016vIcZfbGh+6vpuqIJ+W23IRPM7QeHA/QRWMbqK2kP9USMeAoX2iSjuJQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HONggmRwVGHxrYjrGZWYSXaXbFQxFTtizaAPjJCEW8o=;
 b=SqezLUdwB7FsWDdJA1PNVDtfqqHaAocZaQ2FzuNG/Ie6XRuKyvmWpICo01BZqTBj3L+G0oTY8891U/5QdtfKHvuaTM5lRm+uGGNiyLdMcA0GsjkNaoNbg63B1lgDGHr9+pX5oRtZZMSHa9pikZgb/zpU85b3l3jtxYKJ0ND8SsM=
Received: from SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::27)
 by PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Mon, 27 May
 2024 16:28:57 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::7f) by SA9P223CA0022.outlook.office365.com
 (2603:10b6:806:26::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 16:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 16:28:56 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 11:28:52 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>,
 <Shuzhou.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Add flags to distinguish vf/pf/pt mode
Date: Tue, 28 May 2024 00:28:39 +0800
Message-ID: <20240527162839.259865-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e61e4f1-fb6e-42bc-5d79-08dc7e6a1aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GLkhf9+V3EDxL3J3qo59JPd8+DOeT6LLr2qvaW0lZGnmgSNrgppzjXXzjRdQ?=
 =?us-ascii?Q?0emGl2F2+xBdyY6X2StKtz0O4FfgIojrxZmnyX3EU/YYty48UFVaB3av9OKO?=
 =?us-ascii?Q?9h3NyCZ86MmzAAtcV99F3iOnQ4jNV2I6jYIp8mZWaY2g1X5Lxr4ZGxbUpDN+?=
 =?us-ascii?Q?AKJmtTfkhBT6D315STjKuquQv2RDPykbMSvCUFvV9dKxuunuS6PCmyscFf6V?=
 =?us-ascii?Q?e4dNuqzuylCVUL3rf0p+E5U3C6AKO+cKDCCOH9oCM/jUAppAJgEJ7BzBkL6Y?=
 =?us-ascii?Q?Oi+jcCHs54d9z+cBihlFoyDjmGTAfBCUTx/1pXf3Gr6TK2j9QRnIm9JR6ydZ?=
 =?us-ascii?Q?bWDduFavtyQUsqoNeEAIvgttPzvuMkL2DvviAyQhz3Erzir8jsepQdGIQaS7?=
 =?us-ascii?Q?xIU0QhxJjjW9BXAFIxU06nPwNL37iXYE0nfBkJPp7bjGNEC+LczSac/vl3DI?=
 =?us-ascii?Q?vjWCCH+ovohorZ0LXRqB+YtstuDLrN+W7pccFt/y8YM9f4xc3QWRtfba/rSI?=
 =?us-ascii?Q?A97Ot3zq3EC6moA+4YKelxunHkNeFpPpyPsPOGcS8pgn5BcCVE2RQIgoIeVD?=
 =?us-ascii?Q?BtdZZd9uGzg5f/ydueEMfuxRXiXGrMHHIA6r1fCwIWCioOQ848pf2xeMBnoP?=
 =?us-ascii?Q?BZ1oAAxwF8/ZNpvTsNjq5OIxME8zR3FWggu6b1Lu6syJVHF2IunkK/Ne3HNT?=
 =?us-ascii?Q?20lZz0++kUQQ06tLkdekmG/cc6B/LO99cf7b6l79ppunVz0J+Gp+44XXWGJW?=
 =?us-ascii?Q?ipwlmDhkQ1scvfb5z1H5Obb7OpBKnUbfA0IGHqyfiypOI2Yt0T9X8g5xj963?=
 =?us-ascii?Q?zGCLcoCekP0rzQqBXYwXXam3Aa2j7LmS9tSd/Xrj/ERhcFF0C7oBKDxEprHZ?=
 =?us-ascii?Q?Pe+enma1fRYjSUJgDUswAk1lT1YywxGduK0mSRhfohPzbeCpnIXLKqefh+PB?=
 =?us-ascii?Q?VptRbkQOoTuL97XCvJ2PHte6RxHvpAYA898XEg/GiYgZ/8NIw3IFFsSSZIE2?=
 =?us-ascii?Q?WLIwquOyWNGdMeJa8fdAC7WSMbuXbtNtg0nJCArPZPHjgHdLo4LJUyoMgort?=
 =?us-ascii?Q?S+H7XqjnJ+S+iWqkh7lq7ioMNkAq0ab90IueLJpKUQnpJspd0/lS8CtvT1bs?=
 =?us-ascii?Q?p2X//MWKNpYaV8fsMGQ8dbBbS+N0bD3Gp4iv/U/U2o0mwrZrkQNGTyC3l31s?=
 =?us-ascii?Q?89RjdDUwiriImts2SYosVbnRpoUK1C7i7cx5egIYmJbB/c45AiCsgMo7jWKe?=
 =?us-ascii?Q?gTyPCj/T9OtemoP0jyUmVJKp7OPpx9R9A5zkXYqrtafrfWeiUrn76Y6WiIbB?=
 =?us-ascii?Q?Gg6XPE1Rnk7qgd2wtEYBGNv3H/HPkg9vLW9ys8NKvTByas8Wnlp5lkX6ECdn?=
 =?us-ascii?Q?DYpGb2g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 16:28:56.2670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e61e4f1-fb6e-42bc-5d79-08dc7e6a1aef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869
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

Add extra flag definition for ids_flag field to distinguish
between vf/pf/pt modes

v2: Updated kms driver minor version & removed pf check as default is 0

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  9 +++++++++
 include/uapi/drm/amdgpu_drm.h           | 10 ++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2da76fadf6ea..60d5758939ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -116,9 +116,10 @@
  * - 3.55.0 - Add AMDGPU_INFO_GPUVM_FAULT query
  * - 3.56.0 - Update IB start address and size alignment for decode and encode
  * - 3.57.0 - Compute tunneling on GFX10+
+ * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	57
+#define KMS_DRIVER_MINOR	58
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 66782be5917b..260cd0ad286d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -869,6 +869,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
 
+		if (amdgpu_passthrough(adev))
+			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_PT <<
+						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
+						AMDGPU_IDS_FLAGS_MODE_MASK;
+		else if (amdgpu_sriov_vf(adev))
+			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_VF <<
+						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
+						AMDGPU_IDS_FLAGS_MODE_MASK;
+
 		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 		vm_size -= AMDGPU_VA_RESERVED_TOP;
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 5b6c0055cfcf..ae3f4e275f20 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -754,6 +754,16 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_IDS_FLAGS_TMZ            0x4
 #define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD 0x8
 
+/*
+ *  Query h/w info: Flag identifying VF/PF/PT mode
+ *
+ */
+#define AMDGPU_IDS_FLAGS_MODE_MASK      0x300
+#define AMDGPU_IDS_FLAGS_MODE_SHIFT     0x8
+#define AMDGPU_IDS_FLAGS_MODE_PF        0x0
+#define AMDGPU_IDS_FLAGS_MODE_VF        0x1
+#define AMDGPU_IDS_FLAGS_MODE_PT        0x2
+
 /* indicate if acceleration can be working */
 #define AMDGPU_INFO_ACCEL_WORKING		0x00
 /* get the crtc_id from the mode object id? */
-- 
2.42.0

