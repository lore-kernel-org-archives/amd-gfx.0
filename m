Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B427C5DF75
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6596910F6FC;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aIQT5UBa";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918CD10F6EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nlwv3edKLxLWyeBoVwrO0Rm/F1Sck1Y871ExWUoe6vtc2E6oN9341lN8b4JsI6nokf5WNvpek630WwLUzJLY1uCP8OmZaYRJ16XY3M20VEiLEWlCkSZwyojyNrsqpfjA1h2s8xIp6MXc+i5Z14Fe0t8U7xP9TbB0FWhpKursXLqvlRVZV1Cw7LeBTffDzdHl/HD4osp0xTXUMGII/+YtaPE4Cf67JY75+0UsYkugZ/ianXkL9N3ZarlZUmpyj2WGsND3LSfhDHMz7Ti5qMFR/BcG3t4PGr84NfcirO81UiWBZqQgwomXAvC2VW1kKobjPl8uNCTUADmpjIrBwhlgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCbfMM7YdXkF1Fq7ZpxYOjEbtfbwAGc+6gOsLQAqdNE=;
 b=oKeyejJci4dVduwVy3J2dtOXQsh2mMLMA/ufPJaQV54fBNKuw+oRLOTaa9q1vNqHaUhcr3U38F4JIKfAuyTOOmkyfUzTRLGBYTsTncABg7nUn4JlGVwG/CdsjpVo+lh53oef5iG961VUczXEvcZl5f1HsxlMLMH8W39lqyOqT0k4EGl/wpDWqjRtj2AQ+JHAWnA6G1PwJz/lgIaEJQW682gcdFD3GLqO4iO/zW6QWFv1xg6Hk27Oro65spMEZ1trv88BB81vz06n0q3zl0bbEUnFJLOkr2/BjChSNfIe+ydeaAYZucDRYRep+hezDO4+yWXoVu5f6x3dGWuZ+GDHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCbfMM7YdXkF1Fq7ZpxYOjEbtfbwAGc+6gOsLQAqdNE=;
 b=aIQT5UBaeAB0hxmOeUrzJQ9yR10iyQ+brHexfMTWUrs/3W96z5v14Q4hr4kn+pUQqjl/og6ElvvIHKKG3WGhjQ/+hm3j20zWMtacmT9HMqn0kme+MQsE3uBKvblQUP6WMsVlG5ktr5nL2St/x+zKLwRPEjYMRsMVtdgoRTbUidY=
Received: from BN9PR03CA0492.namprd03.prod.outlook.com (2603:10b6:408:130::17)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:20 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::40) by BN9PR03CA0492.outlook.office365.com
 (2603:10b6:408:130::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 035/109] drm/amdgpu: Make extra space in psp->cmd_buf_bo usable
Date: Fri, 14 Aug 2026 17:01:32 -0400
Message-ID: <20260814210246.3067612-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b83b01e-dd16-435f-06f3-08defa47781a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|56012099006|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I4dwlGozMU9t9njwaVvFyDxDs87Rasao/ph/2k6py47EvGV+/4z1j8dw1wBb17PHcXS8TBUPbc0UilHQAM1G213lc1dHQJiSW4OFAkd2ESXFnzJ6qj3dTDQmVFtkZhEZgjC1ivod9FQzVrEHJt0U5o9F2Z9h02qdtiCObTuqaVMSVPzqoBdYXh6htFwfga488qDYBXJyC6jok0Jr7RMqi8GAL2pGaQoME4iKL9JUaeAPWBnBptxh0MX6Anq1sbX3ifTdZ9Ak8SvU/T3ZPl4HY/qoTqyUfQndKHS2V8SrtuQRElHje50gypzHb4IefHR45Bqq8Q4r7bWCGxqicQ0fBZ/NaEL0TWplRG+4vGTGKZ7wF5qD+7IAFOdQjEvtzjqSt+TtaNocXuDVJH26BjF+xzyGDw3ulcz4wQOy3y+Ygi+qz0aYcfidI5yHdLn0jsV/w/ZYe0fJBptH4TBRYewYNkcVYF2q3E54MDMJBWvTIG2qRRlM/qsR2Ix2OsiEAQb5BkK+K5jZWlgTPCMZ7szn/Gx0OuaKETQ2LJJ0PfFTWxZbafCqvCDP0726WFCvzKqOab1kz4Zkxju6Sn01moVKLi3BzaVL2gfp3xnrCGqMHBXZS0PlB8KBZQ9wYzucbLYRnY5MxGzu2hJKZxmxQlH+ekVJ60a5HgBmEZKJ0HSpzsgmU7u+uf8s4rM3vIC+LgeusLimwJ3zkP48SlOyFZcVug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pJt1aFbFiRueVxuB/AqvCb2ATscA6m0iqnj+jXiCVUljiPsV+N9TOEHT9EPk1djKNeAXFt64lHIqx5V2T/Y5EAwDpG6ulwnpr1jeTdsliQkfgGHZGBwsJNKwtaUoQintgJFpvDqmKRuIBMfA5rnQS6rbwVLnAZhkG9/UyldEA8N5a4QzWm4bzUlKvfjKagY+8+euy6MBPXxHnZihM0/sN1kZ4RikOI1plxEAcyVgpTj3OV/nMYN10cKriXXoWd74HdYl1N5oCIqmzpoJx46NkrXd05EnxFPHc3MsRMgPfHgdoj6hElvx8dwIQ8BArSxMLkQzk41M0e9D5C3+gL8uTSmJVYbtyhzphIK2mh88qwIuiDeQDAhlXaw2tB9p11REQGk9GHzaF3EHrttnyHbYdvUMIDl1PUAu6tCbi2SwZou2iMMkrilsy+yfvOlfDEAf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:19.7362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b83b01e-dd16-435f-06f3-08defa47781a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
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

From: Felix Kuehling <felix.kuehling@amd.com>

Make space at the end of psp->cmd_buf_bo usable for extra data returned
from PSP commands.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 49 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  8 +--
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  6 +--
 3 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a77b87966fee9..d5998497b22e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -551,11 +551,15 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
 				      AMDGPU_GEM_DOMAIN_VRAM |
 				      AMDGPU_GEM_DOMAIN_GTT,
-				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
-				      (void **)&psp->cmd_buf_mem);
+				      &psp->cmd_resp_buf_bo, &psp->cmd_resp_buf_mc_addr,
+				      (void **)&psp->cmd_resp_buf_mem);
 	if (ret)
 		goto failed2;
 
+	/* Space for extended data in the tail of the cmd_buf allocation */
+	psp->cmd_ext_resp_mc_addr = psp->cmd_resp_buf_mc_addr + sizeof(struct psp_gfx_cmd_resp);
+	psp->cmd_ext_resp_mem = psp->cmd_resp_buf_mem + 1;
+
 	return 0;
 
 failed2:
@@ -594,8 +598,8 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
 			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
 			      &psp->fence_buf_mc_addr, &psp->fence_buf);
-	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
-			      (void **)&psp->cmd_buf_mem);
+	amdgpu_bo_free_kernel(&psp->cmd_resp_buf_bo, &psp->cmd_resp_buf_mc_addr,
+			      (void **)&psp->cmd_resp_buf_mem);
 
 	return 0;
 }
@@ -704,7 +708,7 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 
 static bool psp_err_warn(struct psp_context *psp)
 {
-	struct psp_gfx_cmd_resp *cmd = psp->cmd_buf_mem;
+	struct psp_gfx_cmd_resp *cmd = psp->cmd_resp_buf_mem;
 
 	/* This response indicates reg list is already loaded */
 	if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 2) &&
@@ -730,12 +734,12 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	if (psp->adev->no_hw_access)
 		return 0;
 
-	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
+	memset(psp->cmd_resp_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
 
-	memcpy(psp->cmd_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp));
+	memcpy(psp->cmd_resp_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp));
 
 	index = atomic_inc_return(&psp->fence_value);
-	ret = psp_ring_cmd_submit(psp, psp->cmd_buf_mc_addr, fence_mc_addr, index);
+	ret = psp_ring_cmd_submit(psp, psp->cmd_resp_buf_mc_addr, fence_mc_addr, index);
 	if (ret) {
 		atomic_dec(&psp->fence_value);
 		goto exit;
@@ -758,10 +762,11 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
 
 	/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command and PSP_ERR_UNKNOWN_COMMAND in SRIOV */
-	skip_unsupport = (psp->cmd_buf_mem->resp.status == TEE_ERROR_NOT_SUPPORTED ||
-		psp->cmd_buf_mem->resp.status == PSP_ERR_UNKNOWN_COMMAND) && amdgpu_sriov_vf(psp->adev);
+	skip_unsupport = (psp->cmd_resp_buf_mem->resp.status == TEE_ERROR_NOT_SUPPORTED ||
+			  psp->cmd_resp_buf_mem->resp.status == PSP_ERR_UNKNOWN_COMMAND) &&
+			 amdgpu_sriov_vf(psp->adev);
 
-	memcpy(&cmd->resp, &psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));
+	memcpy(&cmd->resp, &psp->cmd_resp_buf_mem->resp, sizeof(struct psp_gfx_resp));
 
 	/* In some cases, psp response status is not 0 even there is no
 	 * problem while the command is submitted. Some version of PSP FW
@@ -770,7 +775,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 * during psp initialization to avoid breaking hw_init and it doesn't
 	 * return -EINVAL.
 	 */
-	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
+	if (!skip_unsupport && (psp->cmd_resp_buf_mem->resp.status || !timeout) && !ras_intr) {
 		if (ucode)
 			dev_warn(psp->adev->dev,
 				 "failed to load ucode %s(0x%X) ",
@@ -779,9 +784,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
 			dev_warn(
 				psp->adev->dev,
 				"psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
-				psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id),
-				psp->cmd_buf_mem->cmd_id,
-				psp->cmd_buf_mem->resp.status);
+				psp_gfx_cmd_name(psp->cmd_resp_buf_mem->cmd_id),
+				psp->cmd_resp_buf_mem->cmd_id,
+				psp->cmd_resp_buf_mem->resp.status);
 		/* If any firmware (including CAP) load fails under SRIOV, it should
 		 * return failure to stop the VF from initializing.
 		 * Also return failure in case of timeout
@@ -793,8 +798,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
 
 	if (ucode) {
-		ucode->tmr_mc_addr_lo = psp->cmd_buf_mem->resp.fw_addr_lo;
-		ucode->tmr_mc_addr_hi = psp->cmd_buf_mem->resp.fw_addr_hi;
+		ucode->tmr_mc_addr_lo = psp->cmd_resp_buf_mem->resp.fw_addr_lo;
+		ucode->tmr_mc_addr_hi = psp->cmd_resp_buf_mem->resp.fw_addr_hi;
 	}
 
 exit:
@@ -870,7 +875,7 @@ static int psp_load_toc(struct psp_context *psp,
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
 	if (!ret)
-		*tmr_size = psp->cmd_buf_mem->resp.tmr_size;
+		*tmr_size = psp->cmd_resp_buf_mem->resp.tmr_size;
 
 	release_psp_cmd_buf(psp);
 
@@ -2264,7 +2269,7 @@ static int psp_ras_send_cmd(struct psp_context *psp,
 			memcpy(out, &ras_cmd->ras_status, sizeof(ras_cmd->ras_status));
 		break;
 	case TA_RAS_COMMAND__QUERY_ADDRESS:
-		if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
+		if (ret || ras_cmd->ras_status || psp->cmd_resp_buf_mem->resp.status)
 			ret = -EINVAL;
 		else if (out)
 			memcpy(out,
@@ -2935,10 +2940,12 @@ static void psp_update_gpu_addresses(struct amdgpu_device *adev)
 {
 	struct psp_context *psp = &adev->psp;
 
-	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
+	if (psp->cmd_resp_buf_bo && psp->cmd_resp_buf_mem) {
 		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
 		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
-		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
+		psp->cmd_resp_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_resp_buf_bo);
+		psp->cmd_ext_resp_mc_addr = psp->cmd_resp_buf_mc_addr +
+					    sizeof(struct psp_gfx_cmd_resp);
 	}
 	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
 		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index ea3658e2be6dd..e0ebce792021b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -434,9 +434,11 @@ struct psp_context {
 	void				*fence_buf;
 
 	/* cmd buffer */
-	struct amdgpu_bo		*cmd_buf_bo;
-	uint64_t			cmd_buf_mc_addr;
-	struct psp_gfx_cmd_resp		*cmd_buf_mem;
+	struct amdgpu_bo		*cmd_resp_buf_bo;
+	uint64_t			cmd_resp_buf_mc_addr;
+	struct psp_gfx_cmd_resp		*cmd_resp_buf_mem;
+	uint64_t			cmd_ext_resp_mc_addr;
+	void				*cmd_ext_resp_mem;
 
 	/* fence value associated with cmd buffer */
 	atomic_t			fence_value;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index a45fb22f7462f..c34af5c8e65ad 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -234,10 +234,10 @@ static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_core,
 		gpu_mem->mem_mc_addr = psp_ring->ring_mem_mc_addr;
 		gpu_mem->mem_cpu_addr = psp_ring->ring_mem;
 	} else if (mem_type == GPU_MEM_TYPE_RAS_PSP_CMD) {
-		gpu_mem->mem_bo = psp->cmd_buf_bo;
+		gpu_mem->mem_bo = psp->cmd_resp_buf_bo;
 		gpu_mem->mem_size = PSP_CMD_BUFFER_SIZE;
-		gpu_mem->mem_mc_addr = psp->cmd_buf_mc_addr;
-		gpu_mem->mem_cpu_addr = psp->cmd_buf_mem;
+		gpu_mem->mem_mc_addr = psp->cmd_resp_buf_mc_addr;
+		gpu_mem->mem_cpu_addr = psp->cmd_resp_buf_mem;
 	} else if (mem_type == GPU_MEM_TYPE_RAS_PSP_FENCE) {
 		gpu_mem->mem_bo = psp->fence_buf_bo;
 		gpu_mem->mem_size = PSP_FENCE_BUFFER_SIZE;
-- 
2.55.0

