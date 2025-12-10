Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B334ED3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FE610E68F;
	Wed, 10 Dec 2025 07:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iXbcsslm";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4003810E68F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/auraxEIkJrCMmv7qbj+8cOeWNmfcZXkjDo/BiBLARjvDDJZkdcH63FbvdFW1xX+vvCzm2uqET2czasf8LHaXmP6wUcR6UEc1nfgLxSkA2htsWZVfgs1Onk6D2fJ0SBHiwtewFp98cJVbkiN5ayu/54K3kMw2qkKi6OBJBH0KlOjLlOFk4D5MXMBLe4DochU8w81X1fN5A5tmtdNKg/PKzPErqp+/z24VP0VhN724U0Uqb87BTk6ZuELCtlUMmWTELCXLZv3IZANb90X0gELyKAcj48S1Ma6Jn82C7b5B71C3gm23HJrwwZTHauI/wc5Ox8w6VbS2HvGnmnQqfY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbAGG0BG3Yfj+1ixE+7JxJkBoe8svr8DnH39u3xXqUA=;
 b=HwwgA6feiPRLUhO5K0qZO25S5e/i93rdPwbg5A4v86TV3mvUspWTQh2gbJ8PZeDXHdPbbaRcX0wyckgA6uyEF2iM5Zdvq90YfXmCo4ZCiUJyoLMh8T/wxQf1amvUKuOfcqyWpNQAc1Hhxvm4pW8OprIim7Yfs6b+H8A8Vi3hWWbwAgClPcR3w2RLXUMVRGTG9mgsjTD64yHetnph8orBZuTqWQFbHzv5Jn+uJ3TPAFXblzDLGHUV9TDtDbvc7P+Uh87iJHKdC1it0gZJZB6WbqvhrWprOMCiFge5fRtVhlIVVNA4CvW7YfK27ewpP2uhqomYpdh4YrvXhfEUgNURLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbAGG0BG3Yfj+1ixE+7JxJkBoe8svr8DnH39u3xXqUA=;
 b=iXbcsslm1iPhA7rJZlJFoRq6ndXgXvMBuibMtXGBReJJZ0egl4l9vJUhO3Ht5cPp9FY0yyRvRXRCoBRGfF/v16JUD+H7mbwcbPbaqnt1lUDBIPEadimkBiq3Eo2IJNshuAzF5OWOp4la6/gN0FsSrpj3V0k7zcpup/Z2EsKFnKY=
Received: from MN2PR15CA0040.namprd15.prod.outlook.com (2603:10b6:208:237::9)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 07:40:42 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::68) by MN2PR15CA0040.outlook.office365.com
 (2603:10b6:208:237::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 07:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:40:41 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:40:39 -0600
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <emily.deng@amd.com>, <lijo.lazar@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH v4] drm/amdgpu: fix mes packet params issue when flush hdp.
Date: Wed, 10 Dec 2025 15:40:25 +0800
Message-ID: <20251210074026.1495081-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: 01837ab6-c4d1-4015-1125-08de37bf6b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NyEO4YiQt5SLSOaBwJhpQtQ8DrxoKaibatKd8F/AnuNAZs2fAC1TqVJ+Tfdf?=
 =?us-ascii?Q?OAKzeBw4Y6hkSnNBZwJnEg0mEHLE9KG6qxzHVWYcsQOqzArP7d/My2hJt3LH?=
 =?us-ascii?Q?rDH+B2EcVKz4jFavyVI3aeydezKyZZVv4wLcddim0E0tJfsVvLCjdzmwP04B?=
 =?us-ascii?Q?x0cSfOhRKXvPZ0lzFe6o16eSCYPML2AqqOPP9nBGn/L5C1oPfEVRt7LnH+qo?=
 =?us-ascii?Q?zfRhXYzwIK5uxnOfxOIWr+3fCaXemCzqj+sNS1gOswFU7Xfc26kd53wcZTzs?=
 =?us-ascii?Q?v2pGk3gFtreG7X6ij27J1ICigxk/URKNhNl2qIFVKBKqzkJv4A8NVm3VGK2O?=
 =?us-ascii?Q?48t5pZXuT4czQNPwG+XxUe67zDM0mRNtpBGKMzOh//4og7TFps9PXhLonJgu?=
 =?us-ascii?Q?KFmVMHNVwqASoTFa6uQYYNEqprQ5B2b1sTFfBSWwJ4NYPE42nKCpi3gsg88l?=
 =?us-ascii?Q?nvQWwV/HuAgq2q59W+/+esY3MTsDVaRSW/8Snq24G6v25Bj175avLiTndxQY?=
 =?us-ascii?Q?1Zxs1ci8SnhvsiIub3Jj/LqJFVgx684tHICVIckmu7bu04ZCwnVSAZehz0UH?=
 =?us-ascii?Q?MOnGumJxaelek7LnUkCDrNdvEdeIzXM0cZM7jMo4ALL5QS6jc8O+0Y8fduAq?=
 =?us-ascii?Q?fKmBkuxYnFeVuPBU5HLsAfD9XT4wHwObAm6jcotOVuv9rSiOFqrnDeS2bkym?=
 =?us-ascii?Q?S0V6mATBvur8bjcVmObOypT3tFSzpDtEEbORNCEZGNuVYeI5t7miYvWh+Tw3?=
 =?us-ascii?Q?d/Z6yknCz1D9TwevaDYVYgbUJk+nErWxuzPMfJ/x67fjZ8NB3rb5CbrKUyuR?=
 =?us-ascii?Q?QKaMMoJ0dBNiThArShIA+gz0b5wNnAxRon2ga/HzsRhYI3I0Pflz0aJbF1cn?=
 =?us-ascii?Q?Fu52FYS97P48RUsZ/Uu5E1bJxRMixOx++TDjeeNoDKYPWG0N8xRpTafCTU+b?=
 =?us-ascii?Q?iZoHvpq42Ys+OhaK1t0iuukQXGi9djb5Fz+8zql684kocCwb4hnaRs1pNNo2?=
 =?us-ascii?Q?l7OH1jS8EY6xeB6xEdWKosdDdiJ2z7smeVZ1IMgHXGIUlvs0YZoJ/yjkccOq?=
 =?us-ascii?Q?U1wD99GrwuNgQnjWM/K+MVm+UoBshHDXNCrmF3V1TPFnTqWH9hbtdCRQYD3g?=
 =?us-ascii?Q?rO7ZeASxbBrsqzIocLqibNjPvMP+nfEomBBHn9CoQVOwQrLr8RguRzBxb+en?=
 =?us-ascii?Q?3I5D/AgfAbjVQuzk1m6t5l3Wg9h0MPHZBWsNvC90foxb4srZK7CzxbPYct+y?=
 =?us-ascii?Q?M9706vbrtxsq6Tls9mSCRBjM4VDjh+fip6/gn2sz7PLL9fLQRAAa5T2MqYGE?=
 =?us-ascii?Q?J22VFXcvn0+7kOusCMdXQEHFRki7uixbDg/cY5fqBBB00FWOQXSX5mdluBp3?=
 =?us-ascii?Q?asZVOu1Yq1bip9OxANABUALSU1O8wrcs0Z7QIhc5aRp+H1SyPEtYEN2HukWu?=
 =?us-ascii?Q?1H3ctRFZ3vM97P+cJ68cr3iyc4MVKR79NCfbiwkgd1MTCyExPs/lZ0L1sPTp?=
 =?us-ascii?Q?YCbTXhmYfi6WEV+1XdJHfXVaxbSoUZPPmIzb5QdbrGxEpcklVt9h19kKBQBW?=
 =?us-ascii?Q?Sfs2V1/+C2cTUZh/+RU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:40:41.6132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01837ab6-c4d1-4015-1125-08de37bf6b96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511
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

v4:
use amdgpu_gfx_get_ref_mask to get ref_and_mask for
gfx9 through gfx12.

v3:
Unify the get_ref_and_mask function in amdgpu_gfx_funcs,
to support both GFX11 and earlier generations

v2:
place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
since this function only assigns the cp entry.

v1:
both gfx ring and mes ring use cp0 to flush hdp, cause conflict.

use function get_ref_and_mask to assign the cp entry.
reassign mes to use cp8 instead.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 34 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 21 +++------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 21 +++------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 21 +++------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 59 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 59 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 21 +++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 21 +++------
 10 files changed, 160 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1ffbd416a8ad..cf0f5b3bbfa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1197,6 +1197,40 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
 }
 
+void amdgpu_gfx_get_ref_mask(struct amdgpu_ring *ring,
+		uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = ring->adev->nbio.hdp_flush_reg;
+
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_GFX:
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
+		*reg_mem_engine = 1; /* pfp */
+		break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+		*reg_mem_engine = 0;
+		break;
+	case AMDGPU_RING_TYPE_MES:
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8;
+		*reg_mem_engine = 0;
+		break;
+	case AMDGPU_RING_TYPE_KIQ:
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp9;
+		*reg_mem_engine = 0;
+		break;
+	default:
+		DRM_ERROR("%s:unsupported ring type %d\n", __func__, ring->funcs->type);
+		return;
+	}
+}
+
 int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
 {
 	signed long r, cnt = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index efd61a1ccc66..e7718485eae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
 				     int num_xccs_per_xcp);
 	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
 	int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
+	void (*get_ref_and_mask)(struct amdgpu_ring *ring,
+				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
 };
 
 struct sq_work {
@@ -615,6 +617,8 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
+void amdgpu_gfx_get_ref_mask(struct amdgpu_ring *ring,
+		uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
 int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 895b841b9626..77d25317973e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 
 int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
 {
-	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
+	uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
+	struct amdgpu_ring *mes_ring;
+	uint32_t ref_and_mask = 0, reg_mem_engine = 0;
 
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "mes hdp flush is not supported.\n");
+		return -EINVAL;
+	}
+
+	mes_ring = &adev->mes.ring[0];
 	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
 	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
-	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
+
+	adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask, &reg_mem_engine);
 
 	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
 					     ref_and_mask, ref_and_mask, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index aaed24f7e716..57ed8bf6b78a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4575,6 +4575,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
 	.init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
 	.update_perfmon_mgcg = &gfx_v10_0_update_perfmon_mgcg,
+	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
 };
 
 static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
@@ -8614,25 +8615,13 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v10_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f4d4dd5dd07b..11c866d7a49b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1081,6 +1081,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
+	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
@@ -5833,25 +5834,13 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f9cae6666697..fc8e28d7921c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -938,6 +938,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
+	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
@@ -4389,25 +4390,13 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 66a4e4998106..29a6378cbf04 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2068,23 +2068,15 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	u32 ref_and_mask;
-	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
+	int usepfp;
+	struct amdgpu_device *adev = ring->adev;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
-			break;
-		default:
-			return;
-		}
-	} else {
-		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &usepfp);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
 				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
@@ -4075,12 +4067,49 @@ static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
 	cik_srbm_select(adev, me, pipe, q, vm);
 }
 
+/**
+ * gfx_v7_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v7_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
+		*reg_mem_engine = 1;
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v7_0_select_se_sh,
 	.read_wave_data = &gfx_v7_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
-	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
+	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q,
+	.get_ref_and_mask = &gfx_v7_0_get_ref_and_mask,
 };
 
 static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5d6e8e0601cb..0fd17fdf2cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5211,13 +5211,49 @@ static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id
 		start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
 }
 
+/**
+ * gfx_v8_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v8_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	if (!ring || !ref_and_mask || !reg_mem_engine) {
+		DRM_INFO("%s:invalid params\n", __func__);
+		return;
+	}
+
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
+		*reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
+	}
+}
 
 static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v8_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v8_0_select_se_sh,
 	.read_wave_data = &gfx_v8_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
-	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
+	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q,
+	.get_ref_and_mask = &gfx_v8_0_get_ref_and_mask,
 };
 
 static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block)
@@ -6000,25 +6036,14 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 static void gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	u32 ref_and_mask, reg_mem_engine;
+	struct amdgpu_device *adev = ring->adev;
 
-	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
-	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
-		reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
 				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e6187be27385..9e31a27a1a7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2004,6 +2004,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
         .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
         .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
         .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
+	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
 };
 
 const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops = {
@@ -5380,25 +5381,13 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v9_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 89253df5ffc8..d428ab2a4313 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -848,6 +848,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
 	.get_xccs_per_xcp = &gfx_v9_4_3_get_xccs_per_xcp,
+	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
 };
 
 static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
@@ -2818,25 +2819,13 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
-		reg_mem_engine = 1; /* pfp */
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
 	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v9_4_3_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),
-- 
2.48.1

