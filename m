Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B041FC5DF6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE82A10F719;
	Fri, 14 Aug 2026 21:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EumJQ/9u";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D1F10F701
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9UyvqljoNcbPvp4wEnNpi7UsSQ6uB0usGRlfA7ZDcug1+w2FQ/C5MbOzfdshSSN9GgnVVIPyv4Q00UZA0FvoDdBv568FJtrP9SMN40CvMRQJ4HBXDIy9H7QHOs7in1teWckMUH52+F2R9wndlljKe6zIMfY+jzaFbwtyg+55uzeH/VdzLiEySH0xfQ79eVIGbqaNw0xv9ScjI0/Oq2Nd8+z+OQ2X1iI47x3NVwHViF99hEB0toHbCMAuezPCvlR4nVHBQYLpyvYjfXGm3zEuWVA05Aipl3AQLJ+rE2tymYN1ka+zEeJ6BxALR+w3XkXWQPuBWg6++irYknLs9CKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHAQ/K90NksLD7FPb9AfED3VRHsoSVq13zus1J87HOA=;
 b=vFcAZPB4IGtOVr3owwge1fTt8rDzXrGZjbECzRMTHfhgc25LLk2sHT4I0bQYYuqlbqFE+FL5BS7en0ZX78shaQttlEoWcr5PxR0uI+0qQ9kBtTiKxIyqw3w7Bzn2oJCMSdjdM12jC4M04Xe+7FUWRcaP9ugJP8Yk3eXQB734GRjmrGmqXrLA5ZGJ1uJ8bMYb0TzW3t+ysEGr3SVXK2zYhDdBaP5OjlRw0YV0Qcz6ovXEoeRPLT5TmDyHWcrKlcnjzpOJq7J3RlhGclv2EKCE6ESFb+nI26vT8N2/ipWu6deMjXqNVdvknlEmEj242Rry2RXCeXdcRO6ktxvP0YWZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHAQ/K90NksLD7FPb9AfED3VRHsoSVq13zus1J87HOA=;
 b=EumJQ/9u9/EV5qSt6FD66O+lqn29qN78rs/EZxLB78Ful1VExYfJsxg44WiD4hPsy9g21e0QBn+rgrlO15PdSwCQa55IWsrGWls+/n4RQuDaYnw28tBYU/RIH3l9yemqbtL1S0vzKo/TVHoPoP7OeNEuuF6ezcgSNEM8zHjvjX4=
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 21:03:41 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::29) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 063/109] drm/amd/pm: update RAS-specific interface to support
 multi-parameter
Date: Fri, 14 Aug 2026 17:02:00 -0400
Message-ID: <20260814210246.3067612-64-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ab750a-1121-48be-acb7-08defa4784f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|11063799006|3023799007|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: BwnhzIebhFuCZZfD3osyCof5MefnPlvdb+ueyEvAKr9R8tnHM8oTNSaZlEyqy0e6CGSRRLkUBrvMAYAVMiPDcOW+V3O1I+kN2NGaUHKtJcdstytefowhHt/H+kdzK400yHnmt+ZqUWquZTMS4cOFnsHoYqTo9G0sg/Drc8MHSFor143tnYZu0MQDU7q+NFRV1DyttalxRVPkTUz/MGs9iefiR1JvBvaP0unvC4IYnwOsfF1d0lu40gfL7WtdqocxF0cZ5xgOa8YAYz1LQva7DWwiWHGD6JtvkAtjjHV81JquoBgcsRpBglYwj+qDpxngKSqHnbtz/+KmnzneN+hojY1VtMJjyN2/9gPShcLS3fWXYhCZsdHR5BYPuI5zLKISOjZaqKj/c2/K7Hy1/MogOHtJUlyq2q9DQ5dg6Hl3ePX7EHiHcY2ZK9oVQE4YLbByFf0mAB9900fWo59p0rmDcKwDLJhhvdxC6+GfKz6MCJbcwjSdGzR00Lay4HG5qlqbhH5dqGcfujaobS3YmtJc/FhHrHmO/KjEMJYdd67CMRWIfL8qggIeEVRT+GoN0TmrUXy1ZFQc7rFhCLBKBnQItqRbvyi4d6CCkDp7ZoodEsEKti5Ja8D9TB5fyPegZ8/BfXL3Suk2+8pJ/dTeVA/f2B7xyZD0pRwHv/Z/ehGAlmnBP2BIqp/+t8N8MU3Gbzr56QWwSk2QeNADOBA5IRHHyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wo8H4Xgou6kPmZb1fg2lPQVwmkyHYTZXCsTd6iXFRSocljp7+TGmDarSh5hNt1VN0y7+/q0Pixo/fCMbMy8Gk5qFU3YyCs2ZnuGCnEJxOx03MCq3PhG4WtZ+0ZwlApYMueOBMim2RPGtUHRNf3bLoAlGABr9ruvcoPWhuvwiE4au1EsxG+zpQA+irTCAkpqtnqjihg609mM3F6NvpGyuy3Uc01QULpS+2QaNZt2cUl/Dc15Wi2vi8A7GyPync4adX3gvKHLe+JYDxH9++kTprxqpqxgipu7CdeBkR6RCfSh551AryjZI3vayahDCeoHLdCU0kz7EDYXnD9CzNU+onBpbNm2Poxc1U2frAHODVvgcnEON77TGt6c6rtOBrcP+S9kjYoV/x3V2NnWhhIwEBRxKlKzZgfMvRvx1RC/a5Tbx1PD+vFy+GNgiJXlXWKrx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:41.3036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ab750a-1121-48be-acb7-08defa4784f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Update the dedicated smu ras message interface to accept multiple
parameters on each call.

v2:
  Add input parameter validation.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 25 ++++++++++++++++---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 15 ++++++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  7 ++++--
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c  |  3 ++-
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    |  9 ++++---
 5 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cca32f74abf02..649fdc4471487 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -641,7 +641,8 @@ bool is_support_cclk_dpm(struct amdgpu_device *adev)
 }
 
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
-			    uint32_t param, uint32_t *read_arg)
+			const uint32_t *params, size_t num_params,
+			uint32_t *read_args, size_t num_read_args)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret = -EOPNOTSUPP;
@@ -649,12 +650,30 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type ms
 	if (!smu)
 		return ret;
 
-	if (smu->ppt_funcs && smu->ppt_funcs->ras_send_msg)
-		ret = smu->ppt_funcs->ras_send_msg(smu, msg, param, read_arg);
+	if (smu->ppt_funcs && smu->ppt_funcs->ras_send_msg) {
+		if (num_params && !params)
+			return -EINVAL;
+
+		if (num_read_args && !read_args)
+			return -EINVAL;
+
+		if (num_params > SMU_MSG_MAX_ARGS || num_read_args > SMU_MSG_MAX_ARGS)
+			return -EINVAL;
+
+		ret = smu->ppt_funcs->ras_send_msg(smu, msg,
+				params, num_params, read_args, num_read_args);
+	}
 
 	return ret;
 }
 
+int amdgpu_smu_ras_send_msg_legacy(struct amdgpu_device *adev,
+		enum smu_message_type msg, uint32_t param, uint32_t *read_arg)
+{
+	return amdgpu_smu_ras_send_msg(adev, msg, &param, 1,
+			read_arg, read_arg ? 1 : 0);
+}
+
 int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
 						enum smu_feature_mask mask)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 00d075cb86b84..b77723f04268d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1626,9 +1626,15 @@ struct pptable_funcs {
 	 * &param: Message parameter.
 	 * &read_arg: SMU response (optional).
 	 */
-	int (*ras_send_msg)(struct smu_context *smu,
-			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
+	int (*ras_send_msg)(struct smu_context *smu, enum smu_message_type msg,
+				const uint32_t *params, size_t num_params,
+				uint32_t *read_args, size_t num_read_args);
 
+	/**
+	 * @get_ras_smu_drv: Get RAS smu driver interface
+	 * Return: ras_smu_drv *
+	 */
+	int (*get_ras_smu_drv)(struct smu_context *smu, const struct ras_smu_drv **ras_smu_drv);
 	/**
 	 * @set_power_dep: Create or destroy a power dependency link
 	 * from an integrated xHCI controller to the GPU so that the GPU is
@@ -1985,7 +1991,10 @@ ssize_t smu_get_pm_policy_info(struct smu_context *smu,
 			       enum pp_pm_policy p_type, char *sysbuf);
 
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
-			    uint32_t param, uint32_t *readarg);
+			const uint32_t *params, size_t num_params,
+			uint32_t *read_args, size_t num_read_args);
+int amdgpu_smu_ras_send_msg_legacy(struct amdgpu_device *adev,
+		enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
 int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
 						enum smu_feature_mask mask);
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 39f5ed5da58f3..c31ee92d11ca4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3219,7 +3219,9 @@ static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
-static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_message_type msg, uint32_t param, uint32_t *read_arg)
+static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_message_type msg,
+			const uint32_t *params, size_t num_params,
+			uint32_t *read_args, size_t num_read_args)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
@@ -3240,7 +3242,8 @@ static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_message_ty
 	case SMU_MSG_GetTimestamp:
 	case SMU_MSG_GetBadPageIpid:
 	case SMU_MSG_EraseRasTable:
-		ret = smu_cmn_send_smc_msg_with_param(smu, msg, param, read_arg);
+		ret = smu_cmn_send_smc_msg_with_params(smu, msg,
+				params, num_params, read_args, num_read_args);
 		break;
 	default:
 		ret = -EPERM;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
index b2d9148a36f99..698a373005092 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
@@ -56,7 +56,8 @@ static int amdgpu_ras_send_mp1_msg(struct ras_core_context *ras_core,
 		return -EOPNOTSUPP;
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		ret = amdgpu_smu_ras_send_msg(adev, smu_msg, param, read_arg);
+		ret = amdgpu_smu_ras_send_msg_legacy(adev, smu_msg,
+				param, read_arg);
 		up_read(&adev->reset_domain->sem);
 	} else {
 		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index 3c4575a5d902d..bc89a2ad75ef1 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -53,7 +53,7 @@ static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_core,
 			SMU_MSG_QueryValidMcaCeCount : SMU_MSG_QueryValidMcaCount;
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		ret = amdgpu_smu_ras_send_msg(adev, smu_msg, 0, count);
+		ret = amdgpu_smu_ras_send_msg_legacy(adev, smu_msg, 0, count);
 		up_read(&adev->reset_domain->sem);
 	} else {
 		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
@@ -80,7 +80,8 @@ static int mp1_v13_0_dump_valid_bank(struct ras_core_context *ras_core,
 		offset = reg_idx * 8;
 		for (i = 0; i < ARRAY_SIZE(data); i++) {
 			param = ((idx & 0xffff) << 16) | ((offset + (i << 2)) & 0xfffc);
-			ret = amdgpu_smu_ras_send_msg(adev, smu_msg, param, &data[i]);
+			ret = amdgpu_smu_ras_send_msg_legacy(adev, smu_msg,
+					param, &data[i]);
 			if (ret) {
 				RAS_DEV_ERR(adev, "ACA failed to read register[%d], offset:0x%x\n",
 					reg_idx, offset);
@@ -105,7 +106,7 @@ static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
 	int ret = 0;
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		ret = amdgpu_smu_ras_send_msg(adev,
+		ret = amdgpu_smu_ras_send_msg_legacy(adev,
 			pmfw_eeprom_msgs[index], param, read_arg);
 		up_read(&adev->reset_domain->sem);
 	} else {
@@ -138,7 +139,7 @@ static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core, bool enab
 	int ret;
 	u32 smu_msg = SMU_MSG_ClearMcaOnRead;
 
-	ret = amdgpu_smu_ras_send_msg(adev, smu_msg,
+	ret = amdgpu_smu_ras_send_msg_legacy(adev, smu_msg,
 			enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK |
 			ClearMcaOnRead_CE_POLL_MASK, NULL);
 	return ret;
-- 
2.55.0

