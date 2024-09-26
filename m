Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACB9CCFA15
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 07:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A9F10EADA;
	Thu, 26 Sep 2024 07:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DMP668mH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50FA10EADA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 07:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSg2ocaSuBZjm3fYMA0nZ1d1P2edD6ySwLsRck4ILUqJiiY6WdVypOZOkWTuQiUgCw328UUeHoftkdLiK6xza5CDzVVfh8vpPO13ZEYDzlbeRq9zmOKTjqhbC5Sf6Sy9urPKMIg9iOoMX8tQNGdx8Y1Lz8mR/P2+y0wyOau8A0x/lll7SlD8mlSENR0ht5YncdGyCkvwMD8IEp+fpjJ8UL3skJ1XJW4wnEXME5RW1j2ubTWqUAZpG7UyrjrCSVOQ429Zbp5nGIU1BPpdHFQrEsX71Wv6Skm7zs0iPrvGWNFtqfpeR6W2EJtFPhQDR6TqZm1Iy2pS+pPRokRXOjTZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95kRRE992hGguMMREWdtcPF4bcPleqTlZG2wGvsj12A=;
 b=Dzo5G2VuuUOu24hF7f1eADRcquDqv4OhRA68g8bvzMEDbb479mh09XnRdZaxw2ocxyT1j+GZyF/qtEfyr+8NbCtv8+ep1FlQkYAsn+yYZ+q6wXM/236e/U08u4H4UelRa6hvSeV8pyMCaTdFuHLnxgTJzf1DdTg4O3MnNI50p+T2z/jE5yqw+amIcR6pNY2vRFx+qYOYl8BGrTdx9txKq8Ac5Evf2wTf+lqWyT62cIlYV8UntxGS0ZJQ2SaLHP5iKHdHxcTu7cV1KZN6C9pC63oenLgDinRb3FEbH4BdrLWlWvxRKampARrsYhFCTlfHUQrCfZ7Wc7xhXLuBW4JpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95kRRE992hGguMMREWdtcPF4bcPleqTlZG2wGvsj12A=;
 b=DMP668mHnRvyQzKmvtYOZWz9JfLbXO6lPTXp5MaLqghk6Hp04C65jZtiK83A2qS/HaG8GABUG5duGkM4X4Z2mRFbnp5lki65fgVtaXmDzr6Ne8BZQUH+oyBJI15Qf6ZK0K9UO83iqbb6nXH3C/pbB8atIjF/ALBXGzgpdpyUFRQ=
Received: from BN9PR03CA0775.namprd03.prod.outlook.com (2603:10b6:408:13a::30)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 07:48:03 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::e4) by BN9PR03CA0775.outlook.office365.com
 (2603:10b6:408:13a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Thu, 26 Sep 2024 07:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 07:48:03 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 02:47:39 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu/sdma5: implement ring reset callback for
 sdma5
Date: Thu, 26 Sep 2024 15:45:34 +0800
Message-ID: <20240926074536.22211-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926074536.22211-1-jiadong.zhu@amd.com>
References: <20240926074536.22211-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 59326013-866b-46d9-574d-08dcddff8d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9rVsvswG+xNcd5+tGKAFfwCGdWrWAqbtOlrdQZ7BovdQuY0PgTH/wHrZXYHo?=
 =?us-ascii?Q?phd9bhzSuLzGQXvmwusTViXUtKoeeL4USLbWBj14UPZ03GEr1PO4GGV9N65M?=
 =?us-ascii?Q?sylm0J0SQMQRLpfzNItEsIvutlqRFbZClwcOc0lBGkzIoHg0C0MhSGJjIKW7?=
 =?us-ascii?Q?2TCZ5qcBULZL6hKg5rfLTKbT0AHCNkMUf3+mFpjN15SIAstcQVNI/vJnEjKf?=
 =?us-ascii?Q?hsMkn84g/EgzvWBRp+cukmfbXGL2+cTeswT7qPFsKpTNoCDBCQcJhvSv2cBe?=
 =?us-ascii?Q?03deSHeLfenHm92BGvRrG8VHPuFOCYRniqytcGd88COevB0+FbQIQravYWz3?=
 =?us-ascii?Q?mmQ703UWDkBSDMH30EhjIw39qdCz+HhlHqkfgVORVFQAGZm6drkZrPYeJAjS?=
 =?us-ascii?Q?QtOE+EvFVYtZxDTglyZaLGL0Xt11bTBIGcAW0FHrzHbgpNrlmvqYoz/6dUnf?=
 =?us-ascii?Q?JIo8wmpHOWud0XwB37YP0757sTfRqOTchRuhPKfwCVMO2qs+0N3LAi1nXjFF?=
 =?us-ascii?Q?vO9UrKGkUVkwDZIeHw4S4bOvX7l0luyzu3RdHzvFVQqglzXRFVXtkJolmq7j?=
 =?us-ascii?Q?Ug8EE4YE889x0EYOZGUrdr/PlmNFsxcnXM8IUXPzqTYf3+DaZAlSarDqOti7?=
 =?us-ascii?Q?Hvjcu1DFVXbnnxVAEGr/Ju4PwPrdtZjBC6GHpEDTFVQjqNFLVwZVcR1xCCsa?=
 =?us-ascii?Q?VuhXjlmB8P91RwwZS7c1iBhOghQbvH4TlaJQo7UD/dOO0BS10wLo+Rf07QB/?=
 =?us-ascii?Q?jJwczZ/M/Wir1sFZzp4FKkE8xQJ1oJNnWVtXFYzBb0RUbEyfwt5+x8wTDAHw?=
 =?us-ascii?Q?3qyc9vG7NJ/tUzNlDwmnHstgSU6KvN1XT1YXmsZXheuLkr5iMF73WNrP3QQQ?=
 =?us-ascii?Q?c5KqFa7in0kagcIBjs29k4yinBQ2LWfQs867ECbv4HsA27zX6IDnHTU9+jSU?=
 =?us-ascii?Q?Rx75UJxPEZiItg02vZtahf/lYoUkMvwGWwm8H/7sZrZI8cSX4/nHJ6fwzmKZ?=
 =?us-ascii?Q?zcB1x/qQCyUpkE9SXmIcqPNuzlHxaRTuYkz4okuemAEVPlyegte8XzZYD7Pz?=
 =?us-ascii?Q?yMe3SfY+bl1l+I+UFTiVocr24f2xQHGpstMbeUmEbue33pGtb5Et7OqU0xSg?=
 =?us-ascii?Q?cM+0Qf+7jaixpedLp3lK8D3vll5bhW3RMCbf19DsG2knqN0fe2tOZxFhHqDH?=
 =?us-ascii?Q?+CerIo9eNXcictwrNEsMyG+IJMWRxFNGljj5HHknnhJ9jF9kEZTUX2TT80TF?=
 =?us-ascii?Q?IBxwhMIaD8PLMGhaxIeSsLzLfM0LN3bGqS6UaxapzEHHu0uM4aztaxLgv4yi?=
 =?us-ascii?Q?yIbtfgpW5b4ogpf2s2JR9iUdDy+7lOcKY7uQcyv5yNDxHHBa+GNz5vsu+xG3?=
 =?us-ascii?Q?NIeTKRPRbg4OqDqIVG8xrd4WtaAWQ+Vjxakrm6Td0LZDyy6FKI4yV2MjFDVu?=
 =?us-ascii?Q?VjeSH/M0o4ZEEXsy8/GhDmWzS6u2du49?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 07:48:03.5804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59326013-866b-46d9-574d-08dcddff8d47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma queue reset callback via MMIO.

v2: enter/exit safemode when sdma queue reset.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index e813da1e48aa..416273d917e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1555,6 +1555,93 @@ static int sdma_v5_0_soft_reset(void *handle)
 	return 0;
 }
 
+static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, j, r;
+	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (ring == &adev->sdma.instance[i].ring)
+			break;
+	}
+
+	if (i == adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	/* stop queue */
+	ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+
+	rb_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+
+	/* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
+	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+
+	for (j = 0; j < adev->usec_timeout; j++) {
+		freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+		if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
+			break;
+		udelay(1);
+	}
+
+	/* check sdma copy engine all idle if frozen not received*/
+	if (j == adev->usec_timeout) {
+		stat1_reg = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
+		if ((stat1_reg & 0x3FF) != 0x3FF) {
+			DRM_ERROR("cannot soft reset as sdma not idle\n");
+			r = -ETIMEDOUT;
+			goto err0;
+		}
+	}
+
+	f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+
+	cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
+	cntl = REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
+
+	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0 mmGRBM_SOFT_RESET.SOFT_RESET_SDMA0/1 = 1 */
+	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT));
+	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), preempt);
+
+	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i;
+
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+
+	udelay(50);
+
+	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i);
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+
+	/* unfreeze*/
+	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+
+	r = sdma_v5_0_gfx_resume_instance(adev, i, true);
+
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
+
 static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
@@ -1897,6 +1984,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
+	.reset = sdma_v5_0_reset_queue,
 };
 
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

