Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC36C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFBD310E63F;
	Tue,  6 May 2025 09:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vKuSKmuJ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8871B10E63F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:38:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyAu9sVFZwjxtyrvg0xVCLF4cHvJtoNyJEWvr+27zMkekjQB3IIZW5HL1A7vzwHSUgFxtLxeV18uhIjyecHXCzmfPxHychTxGvec6i0mQc659g2uIDyjsVBswWJ83HdYsvao0B5zcePnM3kfPcsdBOpdAXXqmKcNfyMo3zYqhPvhJGCLVIqzsis6UqP3FreNJRZtng9DlU7yPp0Y7dwp2i+zBxahPmI9EYIPDz/oYqerulB5Krno1eWh6JpjmEqX1jPJDFfqz6sp/M2iOkrr1mPITIZld8R6vgj5Qg2xOV9FYBsH188JqwRL5ei3jmPocCDmZtwLVUP0MQ9x4H4udA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qQTZSwSAqMqhFEwfJGWZoGbboqPOGIYpLIig5wnt4Q=;
 b=t59nmPO7S0yKD4HogLL2zE7hWftxylrJN68vXkShnF/nQvRBXNfgyTYbx5HjqCAtSPvRoXdMCf9VdKVCu+dcqPS2woZNvuq3ypi4vfeshqrVp/bO5DyP1x/SRJgEx5SFu5iP8Xuruw8/nvEZKJE60n5i+tDYkAWvLN60lYfTPfDihlGm6ODKQgLQ8W9DwMYnCLp0UKt6DvSSP/ywE/otBiQpR92k1MQufWJVYtvMMh+fv4k/+hYLf1CwiTwBYK2fA7eKKX7VMT+HyUVsPbjBtanpKDT3RPsKQ+bAh2qx8DT4N4soHzySleC88S2SVbkkvjVj1FTxFEgnt459f9Ihgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qQTZSwSAqMqhFEwfJGWZoGbboqPOGIYpLIig5wnt4Q=;
 b=vKuSKmuJoVFK0fflUaidGjTyA3eg19up5Ew4gHlQpMChOwHDOd08GC7VL+AnQ6rLk8sPHBmU6poVH7JDij21xARsFVBkOoxQanLiAU+CD+YZJ0McK5GQ9gO5wvrzLjZh8FPeoJWNLPYSD8yDwVN8msi1KJUtmoNa/hiwOrzH+dc=
Received: from DM6PR10CA0026.namprd10.prod.outlook.com (2603:10b6:5:60::39) by
 CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.31; Tue, 6 May 2025 09:38:20 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::9d) by DM6PR10CA0026.outlook.office365.com
 (2603:10b6:5:60::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 09:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 09:38:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 04:38:19 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 04:38:17 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v3 5/7] drm/amdgpu: remove cached gpu addr:
 amdgpu_firmware.fw_buf_mc
Date: Tue, 6 May 2025 17:36:27 +0800
Message-ID: <20250506093629.249792-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250506093629.249792-1-guoqing.zhang@amd.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c858337-0ed8-4328-446d-08dd8c81bcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OqgPlwmXHs7e7XXyX2dqqg+7xg2WCHYPpWZNdpnSSpfxXJwD/KdHs77Ywad7?=
 =?us-ascii?Q?PqDbHZCv5RcWoguw/1EZhJAVrjF8sxKOmLwxynvCuIBEKJn/2MMffcyJhxro?=
 =?us-ascii?Q?Aw+jlux6wDoTUW1q6R5iWeI8bGPJbcTXUwkcASjz7VBjW18HkIf5Jx8P1Rvn?=
 =?us-ascii?Q?S51TRFqEaBR/dM8gssfdzhRVqZTAACwwEnQvCU6hAn4GyHCkA5fFCzoT9sOT?=
 =?us-ascii?Q?/btulmzbtLJyiFk9n1Ek3T3sk64RcY3M1rwqo38EKuIBXSfPoNdUoX36ux55?=
 =?us-ascii?Q?1dufwJceqYrjiZQ+zG6bxcrC033uSH8nwv75u7nuJs7GMu09BOX40NcynaAH?=
 =?us-ascii?Q?9uVppGZfQMJCb6OpHSIrjbhO7QDPQIV8FNF+Zv3Q6vvIQURhdWjwL69OXQMb?=
 =?us-ascii?Q?sS+yntTfMRzgQ17lc3j1BhQWbgVOAbkxdsIovXDRocw8LK6+ym7JR5J7ZiHM?=
 =?us-ascii?Q?+hRqEN0nnRQyOxU3jIK17l0a75YZ7zFWwj9hBOD5HRTuJJQjB196JMBF/fOW?=
 =?us-ascii?Q?lm7/Y5ATNuB7N8gawmraRj1kx6ckQ5FaDZGWOvcUmsk1AdoOqMIsDENPHTQv?=
 =?us-ascii?Q?SRMQzKxFORz7j2MsTxF9qpvQSnvE8g2dVyTkzNwShm9p+iv6QmxWiS4M/4nT?=
 =?us-ascii?Q?eWNBQ2XgELOZSNJqo3zkP4ZLsSQiTQWauOqhKRMLKvoArXgFF+M0u9NgN6Lv?=
 =?us-ascii?Q?7VTs95YMPOhnHdy3Nsy+AO7UqgpovuWqIeRYyUL9li+K7v3KQYfqCyzm3GPB?=
 =?us-ascii?Q?eNF1zFJdcqc1wk101PiAd5jXphHmnXpQP4bKaV1C8TPgLg9ztLdh/avBC3Ps?=
 =?us-ascii?Q?rsfT7hPRsRczp6l/ooueX6fQeK73YKGbYkINjaX+16ESdNvrJzPd1Ga01kut?=
 =?us-ascii?Q?Ub0H6GylVpy46b90wCubF7tvNOcho7VfxrYMvROS4L11IppOJsBBbDTzDWTI?=
 =?us-ascii?Q?4/q/4vZzCt9wtmUq3W3llazHDYVaLhgMfU6vw7Fkd1FbOdpWAWdIBmF5fGsZ?=
 =?us-ascii?Q?S/HLWj+aIrQnft3WCVLcyplFCSFf6teeo5VEMMirZfJ6XcYM1BSdNvXXtKpi?=
 =?us-ascii?Q?plLiJWvy+QnjFCgWi40Xnz7phAUGF86zXGxGok2VAnr5uUc42ess9NDz40Wj?=
 =?us-ascii?Q?+z3bIuvrsScgGVP4uvruIB7ISeShxvRws9IWG0Y7vF4Pcy6ftPU/TuOtMcgU?=
 =?us-ascii?Q?iRPY0eUObmWOXcbCNKUN41XbUgK3Qp0kLbTz10Ap+9fYoB/A7ppj2S889Mea?=
 =?us-ascii?Q?JXML7e2Pjenog5Ge83r9V1mKtVvvcmoJb+v1cD122zbF05T1hScm0VdI0Wik?=
 =?us-ascii?Q?gPTF1KKFt7Q51GgT3+nHabXra/vl6UQzwjZVyYwWyhfazoVi1ZdmqZIG/ylJ?=
 =?us-ascii?Q?cfM6Mdd+5cFmEFJ0OiZxZ+9yX/kWZ3gpVCks37dt9GGxUcxzMG+ngVpnB8we?=
 =?us-ascii?Q?UxBMUKuEVNHcSqCM8cF4toKRxB29x4hEagat1YGicxZ8UC2hCyTKoHzyBg/B?=
 =?us-ascii?Q?zdJAQExGXq5PqfICQHzOtd/isxAxwkJysaro?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:38:20.1273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c858337-0ed8-4328-446d-08dd8c81bcc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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

