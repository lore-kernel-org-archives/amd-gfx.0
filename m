Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412A9D2594B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 07:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC9F10E206;
	Tue, 27 Jan 2026 07:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cy/UJwfn";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B1110E206
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 07:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHBDocGKSUHe+dTWtMC6Ao36rqSkSO+XvQR/T+J+u3p/SaR4391K/WFmRIDBbLZbukUBPAqyjzAO/k5NHb6sTUp6bzdfmJFwNwUzbhMHs0lNVsE7Baqj9qJZvxuJp9nqG4IHCyWLpLWOmIZDe7/vM3HJLzO893i9aeYhQLMln73yahiQfzvthdEmoVGDP0WvceRomhsgM3w2ugK+6n/aDcGN/h2LQJAa40kiNY2lv6WxyWv4wccoEoZFH4JV6rdI8pQlLXhA4i2poY9UfLz0UBxDIqpClmOMmRcNZ7ArrJzPVKAcnUHRngnmI7d2mm1dFTMlLe8YzZiZbsTEZdNWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOhd+aTUec296cG+ZJ3XXpdxb+0fLwFasVnw7e6GbCw=;
 b=HujRuzpPYjl+UaF288tvyiEjXP0d/pkoahHDF0Jd5uQcbzID1HQ6bvCohpNm0EuQymUH+0jIdEyBLk+Jnxaf1XeV9lYBPfOeNDdupUsNpm7xbwQ+wfSjdfnURRow6brZOV6+r3PGvVxPhHCK9ulHb8qJqm9mDSdLmFtQtEfZkGHIfBchrn9LkfH/XDCkegv/g/ezdtBFrzLUHZU1viRldpd8bal8ii5jTPReK2ai20TT+KnRozQEvBoVGlaTYjsN4NGHhLD+d8NG0MgMoOQmUaPdwAj0sVQkJhIvWR975n/CnOeRZ4mJNt1MHaOHwWLMBDPK3UJn3mtHd/69ag/2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOhd+aTUec296cG+ZJ3XXpdxb+0fLwFasVnw7e6GbCw=;
 b=cy/UJwfnhQnnMxuiNmS2hyv0IcskD56S12z50jC0JiC60PU8gy6PEqWVMZ62ohrch+D9ipd2CvvPrykUI3VPbY21fCxXGk16OITakGK/cOdknhKfzbo7GTeaAkO/RjGFDbb8GNlNqpuenGOZ5isxkAUfEMZcv6itb5BWLAkC3H8=
Received: from BN0PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:141::11)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 07:18:25 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::8) by BN0PR07CA0029.outlook.office365.com
 (2603:10b6:408:141::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 07:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 27 Jan 2026 07:18:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 01:18:24 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 26 Jan 2026 23:18:13 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 2/6] drm/amdgpu: Add CU mask support for MQD properties
Date: Tue, 27 Jan 2026 15:17:24 +0800
Message-ID: <20260127071800.2395621-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
References: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e51081-14d5-4c15-dc04-08de5d7442df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lJq8dBZnhXAWJXM30bML14s2s53r7l2cAQNixEg487Ww2q3GQvM07gS4MM6Y?=
 =?us-ascii?Q?M0V9riyup8Xjga3Vy/8xff/Jvv/rdzNNgkvLSPopkyvEtFjPpeW8+ZphSCqU?=
 =?us-ascii?Q?zgZ4dtfzXrtkoXe5CoQD5jZrBj8TBq0RcOeqXEBZ2zp1QTjz6v0ROT9dw69L?=
 =?us-ascii?Q?AifLcAlkv7E668MBFgelMOUZSXEd0ZPJ6rAx5/nawdzAIjA9/+NleshGSno5?=
 =?us-ascii?Q?uxgsfb4pytZELQhUzADQLNwGwoXNfO2hx8wVK0DIJCjXfFWjUCAdYrw5bQ4R?=
 =?us-ascii?Q?1r+lgRx/Lj2Y4OJp8qWBQ7diI/8BaNJEnigdjnWjmqOyneycr1Q/PeNmzdla?=
 =?us-ascii?Q?eJFqr07zKu1yIj8vBLd0MmxWKi9Z2+gzNEgNVx2UMzH8tuMnTYw2yg6m7hZQ?=
 =?us-ascii?Q?512UbsaB8D6zVb4/vm7/mcBLgprtnCf7ykkEmCInh4vLJuiQrx0JLYdEHEcV?=
 =?us-ascii?Q?a8d5gThqKNj66SyXqfhkdq+wvqwmTtrR5X6eiwh4h3iFAj0zwYEedSwECZ+8?=
 =?us-ascii?Q?IisYE/tC9C/xLZaPbxABSVtZwSfj50x7YdI9NR6rjjivFSQTE/5qSSpCiiRK?=
 =?us-ascii?Q?YwcOYPr1NJr6Q8OsRPwr5KaPn1NWJxl7rLO0zGbfVynEXDpxkImOzDEi4Owd?=
 =?us-ascii?Q?mFefulOWKkcpUUpceDJV3lsivF8dFMf/vg3C/NPgZqq+UaXPcIeLJaHhd+SM?=
 =?us-ascii?Q?UpEjlamSjneozwZjhy/2IBAI0eT5PPPKIPhGOqQbDzN59GdC3zSxPEK+XYc2?=
 =?us-ascii?Q?R1jEPtkSTAguSLzwqTS5ASMefI17wD+B/qskNs+rgeXsBUTNU08Qdv7viEf2?=
 =?us-ascii?Q?F4yOzkF+Fon8ncSB4unRcd2f/0WDRv0tx97fFSWErafKj7HK3X1hgTY806ab?=
 =?us-ascii?Q?jx9+alQHEUVecqaOtYOEvbLyArr8tUHAztM83+ty1r8vZfsU6KVwWSxZt5FK?=
 =?us-ascii?Q?YXMETkd/Lcu/VL7kodSwrG9pSzcfgZIY8wlhqsJXVGkIO+niGW6KGNi8oNag?=
 =?us-ascii?Q?335doRmenrO9d2LeOCKGmJbdOtlsQRL13rWsF4ZHqTMMOD9YWjsIZvd9+yxa?=
 =?us-ascii?Q?BZmggmaZxsSfriWY5zFKoYVrGELSfzbbcnQPp6XB9RdK75bmyGNl6/3gYuyg?=
 =?us-ascii?Q?p1L3Qqb1cC2+AjpqloHgqLBNpmkJo/gtW/qjcCjmzSR0sguOUA5rSlnAHIU4?=
 =?us-ascii?Q?vzTNUz2moFlog+AZzAwt2RJA2TDaMmRfVZdgxWb/a893ZOzoDE0wFY4zQSoo?=
 =?us-ascii?Q?MjDxami8dUP2JqPWTxrrFntt+xb3kGDH5teJEP1G8wwyTe3O71BnCFkT8947?=
 =?us-ascii?Q?SxKFeAeTjHD9s9mfV2q3oO8hVFxOBCaGyE5tMkdPpwqN2o2sWiC6rvyoQsAD?=
 =?us-ascii?Q?DWOU0Hgn7R5GhTx5/7SaRGHSuFSaOXdCNjmIALxBPzr3IPN6JZw+9ExsNCDG?=
 =?us-ascii?Q?S87lGbDDZoHz2Fpxd10jkvHQZUQBn8RiQ8szDePyQxmGUsTAIghHTaeXyp+s?=
 =?us-ascii?Q?dFR/j4rsYsIsJ1YzB0IDh1ELiTEeQ88Iu7JntYJncdQoiVdj4DGiEJ7qKGZX?=
 =?us-ascii?Q?2kM67E7QR/2yuUZBDS6qtxMXQfXNL6ETUde07bsCtXsiFNP2i17rgwmuVsrH?=
 =?us-ascii?Q?Ewe/lvnr4LFCHtqCENVa1kZZbRjfnA7Y6HE3gkrrZ0+enS24PnRFQ4asm7gw?=
 =?us-ascii?Q?50cUeA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:18:25.2340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e51081-14d5-4c15-dc04-08de5d7442df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

Add new fields to the amdgpu_mqd_prop structure to track CU (Compute Unit)
mask information, including the mask itself, count, flags, and a flag to
indicate if user-specified CU masking is active.

v2: Create a generic function amdgpu_gfx_mqd_symmetrically_map_cu_mask()

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 10 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 49 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 3 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 11a36c132905..a8f4f73fa0ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -789,6 +789,12 @@ struct amd_powerplay {
 					  (rid == 0x01) || \
 					  (rid == 0x10))))
 
+enum amdgpu_mqd_update_flag {
+       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
+       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
+       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
+};
+
 struct amdgpu_mqd_prop {
 	uint64_t mqd_gpu_addr;
 	uint64_t hqd_base_gpu_addr;
@@ -809,6 +815,10 @@ struct amdgpu_mqd_prop {
 	uint64_t fence_address;
 	bool tmz_queue;
 	bool kernel_queue;
+	uint32_t *cu_mask;
+	uint32_t cu_mask_count;
+	uint32_t cu_flags;
+	bool is_user_cu_masked;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6abe5103a78d..73e6988cb703 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -501,6 +501,55 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 			      &ring->mqd_ptr);
 }
 
+void amdgpu_gfx_mqd_symmetrically_map_cu_mask(struct amdgpu_device *adev, const uint32_t *cu_mask,
+					      uint32_t cu_mask_count, uint32_t *se_mask)
+{
+	struct amdgpu_cu_info *cu_info = &adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
+	uint32_t cu_per_sh[8][4] = {0};
+	int i, se, sh, cu, cu_bitmap_sh_mul;
+	int xcc_inst = ffs(adev->gfx.xcc_mask) - 1;
+	bool wgp_mode_req = amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 0, 0);
+	int cu_inc = wgp_mode_req ? 2 : 1;
+	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
+	int num_xcc, inc, inst = 0;
+
+	if (xcc_inst < 0)
+		xcc_inst = 0;
+
+	num_xcc = hweight16(adev->gfx.xcc_mask);
+	if (!num_xcc)
+		num_xcc = 1;
+
+	inc = cu_inc * num_xcc;
+
+	cu_bitmap_sh_mul = 2;
+
+	for (se = 0; se < gfx_info->max_shader_engines; se++)
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++)
+			cu_per_sh[se][sh] = hweight32(
+				cu_info->bitmap[xcc_inst][se % 4][sh + (se / 4) *
+				cu_bitmap_sh_mul]);
+
+	for (i = 0; i < gfx_info->max_shader_engines; i++)
+		se_mask[i] = 0;
+
+	i = inst;
+	for (cu = 0; cu < 16; cu += cu_inc) {
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++) {
+			for (se = 0; se < gfx_info->max_shader_engines; se++) {
+				if (cu_per_sh[se][sh] > cu) {
+					if ((i / 32) < cu_mask_count && (cu_mask[i / 32] & (1 << (i % 32))))
+						se_mask[se] |= en_mask << (cu + sh * 16);
+					i += inc;
+					if (i >= cu_mask_count * 32)
+						return;
+				}
+			}
+		}
+	}
+}
+
 int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 585cc8e81bb2..720ed3a2c78c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -583,6 +583,8 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			   unsigned mqd_size, int xcc_id);
 void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id);
+void amdgpu_gfx_mqd_symmetrically_map_cu_mask(struct amdgpu_device *adev, const uint32_t *cu_mask,
+					      uint32_t cu_mask_count, uint32_t *se_mask);
 int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id);
-- 
2.49.0

