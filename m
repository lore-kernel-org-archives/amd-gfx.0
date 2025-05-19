Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E9DC2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 19:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E719210E2D9;
	Mon, 19 May 2025 19:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rmqTFo9G";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF9510E2D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 19:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSEk+pFYnq+fJIe26PEas6BXfcDkK6WIid5Pwk3tKZd7KoaPAosF1bqSFTrgDkamFHPoNOLB7tIDioJs2VZWTmWlt6m0vvoQXk85llMUMZq/kH3HVwkRNsov85SJLQLutJXblNn4o/2v9z5+J74VfxHYHu2wkUJGmYushxNjPYI5BY826b3h5wfvmybUpa89JC7Wq02OBs1z3RjBbCXB4u+2NQgFemrzKgN+mukC+Enn+ubuWdiI/A0uj7Xw8xiiTC/QI1ssfLfBPj507h660R+CWInHCSeFXSm08iDAEUR1oZN4QxY98sC8XAGXKMlHJizMIJCAkaIx3gvcS5d0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enTIWFJSaUCGiZYWVaCUfEaMaqeWvcOf5NwiOW0kjgA=;
 b=YSdYfh4dDlAgeJK2DBGg0bPxZtOM2minnsRLiAPdPq706C8Li/RS+n9fXAcT7q36EarH0TMKOPWgwIuhBDTvilDTanRYZOvBwZvRn04o8J85KMbOgjXqFQljObFAd25j2bucVmPEryWNhOub+C+gJq/0T6fIym7cC5UOoTNNHjgsys7UbQO5z9EbBAZlV0HQD/2pxQ1Wouy9OlbJYwMhyotIeplDnnScV40d0EPyq7HAslx3NhcJmnyGv4cN3S4p75YEPP3EoXCT9xi8oc76AIeMOpyHZw0uvQ5M05bCyZuJrYgJlu2JXqOc9vmAbK17AerdLsYZq0o+NdQKemyImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enTIWFJSaUCGiZYWVaCUfEaMaqeWvcOf5NwiOW0kjgA=;
 b=rmqTFo9Giwwt5nVCRPxme5D97x+vz5N3v+TT4tMsXHAhwja0KSKirCYxx2e7GnqyEv2hghFHQbzUuz2EM5xzG1Jhrmdi+r1MJisx3a7xoaqGlUqKHcg/3TDKaEfdM+kHq4asfSNhsA62J1CmWNwYmDyfad7s1uKfQ05+w3Zj5Co=
Received: from BLAPR03CA0170.namprd03.prod.outlook.com (2603:10b6:208:32f::17)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 19:53:50 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::a6) by BLAPR03CA0170.outlook.office365.com
 (2603:10b6:208:32f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 19:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 19:53:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 14:53:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes: remove some unused functions
Date: Mon, 19 May 2025 15:53:28 -0400
Message-ID: <20250519195328.82276-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519195328.82276-1-alexander.deucher@amd.com>
References: <20250519195328.82276-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a9dbdc-037c-473b-4b0d-08dd970ee024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4i7mfKXHw0OdUzr0f8sscVwHUV07p1KRpCc84BD9jM41+07jp5x79QX0gxr+?=
 =?us-ascii?Q?IKIfjoiQnjqM6q/S4ixf79wo0KuaEnIEMWGkkpEe9XI8RGtrLr/cZHb8Q60z?=
 =?us-ascii?Q?ZAze1iBUYlYnOj8m2Oqs2IVAL0Ti05N43kUiUpoXOO5wA31dSqm+sI74rL0l?=
 =?us-ascii?Q?qzkOe7uEINzIllxE1XHaqYFQLkGgufmIbCqW4mGRGXcTRcV38Yotg1gDAaJf?=
 =?us-ascii?Q?oke+yLkMwRF4BkrPsC6RfXq9cw4FGMfCSI1uXugBZthFVAUaSl1ib1gzAU7s?=
 =?us-ascii?Q?2V+YfImjvdo0pJd1/BAifA743WKi1VG1qqo7M2DSXJWd9vKsYh/AIrPHmy9m?=
 =?us-ascii?Q?WuJ4PfmNbBDQySWgXvAEoz8Hj7q1QTtJmdFNQEi7Y5e5Cet2Z4bFcAfwwuD8?=
 =?us-ascii?Q?Azsg7MDlSmfRTk1qZwbPln8Td6vRHQBm7kXds2CMDsaqZz4WH8+GYYu1gM0l?=
 =?us-ascii?Q?Wv+0cLRx5+Nmh0gp/5C/aHik5nKdlO+N5JCS3NC72bh5cHjFo3ByH/g9IB1Y?=
 =?us-ascii?Q?fo5t5w343I6Rw1bCFcLmJgNbBADaf5jsCHwNyPhVjgv3L2a8jK0IWNvWVXxa?=
 =?us-ascii?Q?GiRu8fuquWYnVPLEh+mBqaztrgsz6m5nnFRD8IBjDQ4a485zj8PRhZNtKDoE?=
 =?us-ascii?Q?+kShBTolZOPxgG6eSQSCc2spx1nYwVINjTg4hFYPAUoH7w/7yNbmNaKMOdty?=
 =?us-ascii?Q?kdc0dTAeE6tpZkARIffaF6x31xzOih73OET3I177RFFYA9eGERe+8ljAenJG?=
 =?us-ascii?Q?nwCn2JCXjePJJQQ4YG58I0UEpRN71Lc/37sB5Q3t5jr9zQbxF0d5VKuJPenl?=
 =?us-ascii?Q?XoBJ1a3jeJV8B9P8qU5qav67GiYWXYZoihyou8sd+Wav2oQpvZMmyR4imISe?=
 =?us-ascii?Q?LNVDky3XgjGP49jNy5zc0Eq0WSh27V81dhDuEX0/nvQEGPTUz7cxq9QybKm9?=
 =?us-ascii?Q?5wO6oVZOHlHVKc/B5HY4VqaMefVG5Q/NYrqQgWhR0q2ZiklgA+kYQBBYfH3e?=
 =?us-ascii?Q?na/8oCB1CGC0d7J/lNF2UMFLOchwl7fnHLeq6TANOR2NyY5o26Y+BiEP3Fy6?=
 =?us-ascii?Q?5rX385A7CEy6D5+LG2059MpzJNiTNYp71te+WAvjYvsWObN3/A4eAKy1B9FX?=
 =?us-ascii?Q?wLN4SxRxhXhwbyOC1xhN3HdSFmbRncJJp1zlI7ZmiGauO5pnzO7vcZUdMK4N?=
 =?us-ascii?Q?OmvdgVDH17cLWwh0BVENGXJmIacLlqwxdcm+4pr+VtxzJAM1X5FoqALvQCpq?=
 =?us-ascii?Q?9N2hvhKaNQ6g8k8LdR+bNKD12Q7y2y8vX9j0I0+PawG23X0CocVzg2BB25V7?=
 =?us-ascii?Q?26Eu8IVO6/bhIkYqJRQzcaaKucx04Epmq/29yYiM+DrxVgUMdUHIwANbkF88?=
 =?us-ascii?Q?msTbhwl2/NqTHz59miFiICZe6JsRCof7Rbl/mj7IbAAtfzFy+w/OJCN+QBMG?=
 =?us-ascii?Q?UbzvJAwWHxBORCyLlrvQwZuHfzE82ONRV3tmqqK4acv2qpvfK8DwrrvBohnS?=
 =?us-ascii?Q?TEMWgatCNmAOAoJdOIMO5MXYlvBGzYgUNakM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:53:50.1845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a9dbdc-037c-473b-4b0d-08dd970ee024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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

Nothing uses them so remove them.  Leftover from
MES bring up.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 63 -------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 --
 2 files changed, 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index bf375687613a8..68d4ba631001f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -464,33 +464,6 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 	return r;
 }
 
-int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
-			uint32_t val, uint32_t mask)
-{
-	struct mes_misc_op_input op_input;
-	int r;
-
-	op_input.op = MES_MISC_OP_WRM_REG_WAIT;
-	op_input.wrm_reg.reg0 = reg;
-	op_input.wrm_reg.ref = val;
-	op_input.wrm_reg.mask = mask;
-
-	if (!adev->mes.funcs->misc_op) {
-		dev_err(adev->dev, "mes reg wait is not supported!\n");
-		r = -EINVAL;
-		goto error;
-	}
-
-	amdgpu_mes_lock(&adev->mes);
-	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
-	amdgpu_mes_unlock(&adev->mes);
-	if (r)
-		dev_err(adev->dev, "failed to reg_write_reg_wait\n");
-
-error:
-	return r;
-}
-
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
 				uint32_t spi_gdbg_per_vmid_cntl,
@@ -559,42 +532,6 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
 	return r;
 }
 
-#define DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(_eng)			\
-do {									\
-       if (id_offs < AMDGPU_MES_CTX_MAX_OFFS)				\
-		return offsetof(struct amdgpu_mes_ctx_meta_data,	\
-				_eng[ring->idx].slots[id_offs]);        \
-       else if (id_offs == AMDGPU_MES_CTX_RING_OFFS)			\
-		return offsetof(struct amdgpu_mes_ctx_meta_data,        \
-				_eng[ring->idx].ring);                  \
-       else if (id_offs == AMDGPU_MES_CTX_IB_OFFS)			\
-		return offsetof(struct amdgpu_mes_ctx_meta_data,        \
-				_eng[ring->idx].ib);                    \
-       else if (id_offs == AMDGPU_MES_CTX_PADDING_OFFS)			\
-		return offsetof(struct amdgpu_mes_ctx_meta_data,        \
-				_eng[ring->idx].padding);               \
-} while(0)
-
-int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs)
-{
-	switch (ring->funcs->type) {
-	case AMDGPU_RING_TYPE_GFX:
-		DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(gfx);
-		break;
-	case AMDGPU_RING_TYPE_COMPUTE:
-		DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(compute);
-		break;
-	case AMDGPU_RING_TYPE_SDMA:
-		DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(sdma);
-		break;
-	default:
-		break;
-	}
-
-	WARN_ON(1);
-	return -EINVAL;
-}
-
 uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *adev,
 						   enum amdgpu_mes_priority_level prio)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 84385bdf4a422..2b12d5691e0ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -373,8 +373,6 @@ struct amdgpu_mes_funcs {
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
 #define amdgpu_mes_kiq_hw_fini(adev) (adev)->mes.kiq_hw_fini((adev))
 
-int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs);
-
 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
@@ -396,8 +394,6 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		    uint32_t reg, uint32_t val);
-int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
-			uint32_t val, uint32_t mask);
 int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 				  uint32_t reg0, uint32_t reg1,
 				  uint32_t ref, uint32_t mask);
-- 
2.49.0

