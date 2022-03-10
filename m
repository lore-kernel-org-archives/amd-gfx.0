Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC30C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 06:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1074B10ECCE;
	Thu, 10 Mar 2022 06:12:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D8810ECD0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 06:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHvczq65CfkyQW+kWlIzJ1qlkUmqvISJXBfArBIyb/ZQ9b1Q7jo0Dz+aLXLGwfozsXyCyevpVzojgKylVxss/keElGBFoZA24B0FY5aypUS99i/Rf2ppGxlBpXzdSDSa7HqmzIjYQcNEmnWU7H6t7i6OUbEmjFo/IKjZvXLXJjc3DhYs84BuO1o+dK9NLgzhF5VRYjTQvZLTMUVfXRtP5JxjDMX3zVQMoWA7DHpP52exJdoVWAQNV4ZnWmTn6VVkx8Vhf5BgfmP8Lu6f47G8I/bOl4P577EAGzjWUTs+VNG8SnnRkaRHxjc5/toYf42jgCKQkOJzeXIjVftwiuTIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uI0iLykhBCvRTlfMj7Jy558UTIlhox6niGK9anl3tqA=;
 b=C5xwVlKFWrFX56VP9m9EDmkea4uYFhmC/PJs1ahXsbdFUhZPavB3IHufsuzQjGHwQWPWLUZ1DYlyQoXm9K1G0iczf4KO/JiA/ZZvzwM3d16Qje1VMJ7kXNyZm46jI92Y+VIaS+6sKcGtzFEv78vwtX+XC5kLYXRzwM04zT6uqAFhVm5+SiqyewMQ6heyQpUynNtM5Jst0E/OXLdW+dFagRElfoeIldA4E60VMLsOFNPkl3Qtb+4vuTlafQzRIFN1BjGaf69Oiw/hLFzxqdB0Tf29rrBrLKl/jiPcVPxo5FLZqmmZWFWBpElBJ00mSIc8aXuigFv9hpFggBkoLM3PHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI0iLykhBCvRTlfMj7Jy558UTIlhox6niGK9anl3tqA=;
 b=Xm5H9TSWKiA5LzoWwlNmRdZj/1ly1Myle9GUbErwjkVUJUVOfdKxnYv/6p0MJGvBdsS0MlZRqAR4ST527UFYvJevEufObgcHk6dPOdTxaBk06/ovq5JsK+21NxWZL7a4PRvrZoyWI0910lXTCKmXCwtqT5JA19p/YrtxO6pk6wM=
Received: from DM5PR04CA0031.namprd04.prod.outlook.com (2603:10b6:3:12b::17)
 by BYAPR12MB2854.namprd12.prod.outlook.com (2603:10b6:a03:135::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 06:12:26 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::85) by DM5PR04CA0031.outlook.office365.com
 (2603:10b6:3:12b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21 via Frontend
 Transport; Thu, 10 Mar 2022 06:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 06:12:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 00:12:25 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 00:12:24 -0600
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 10 Mar 2022 00:12:23 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: add sdma v5_2 soft reset
Date: Thu, 10 Mar 2022 14:11:54 +0800
Message-ID: <20220310061155.39292-4-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310061155.39292-1-Victor.Zhao@amd.com>
References: <20220310061155.39292-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e101928-d2ad-4dc5-b4fb-08da025cf2bf
X-MS-TrafficTypeDiagnostic: BYAPR12MB2854:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB285450F3CEEE9C1618210D4EFA0B9@BYAPR12MB2854.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlBpXHTc1JM5rJP/bFw7j4AknYEwTie+9ZXljEGuSayqoHQ5O5myzigIiFa6icDwSr/S63p1XoYPeQ+fQAYsXzP3q7MUk1ulMz4TfXOGXNSOUecqGjXRojxhI13LJRP4H0CFeVweeLdgwtDislkAuWypCetqlBM1aG+f6O63PL0LpqE2hmS/xDD3N5zFg84Ii2/tIy5OKJiSyj67xLd+zmj7wEHipHMMOFvRUe92uP7mAJesVE6TYvrEpLvWtEP51OjTbURBZW/57E4blYVsy5lA2WVhXzQn/XbZpkZgLovZe9Z+RZGP+lEK7GuPrJUEh72cgAzQXqukdqvRr1zqLNbodgG2FLpbQTeA4g0y9GqnZ7ZaGz7PjiQmYm0Fk2k/Td4zZHHplNBtz9+ianC9WedO0PxCwZbzOKRBcgDGEYOJh5xJ0c1wxDJyKCPsSJHah4kVQtX6hzD00h9CPNN4B72Wz4g+a2RAGV6jLu9uOUmU6hwKORmVeA3W+46Ojbtmk2MxpOdPZ1hC1IOEAPhKdk4iJdnIz0391coz61sBsEy2uKaCdtcALsMSNXFNfAGY3Frm6rzqSqX2F1TNbBCUQ9XZrv+9nR02g6y4+8WtItKXo0gaSzevJZdNL8stqqsKvWM1b2nHoBAzrlMTy+t7dG0ebVlJqMddSBHfEyFJ41GJtRxpAC3/hb7SbtrCYYCuJgQ57w+Av8ECsyQDDUV9iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(6916009)(36860700001)(82310400004)(36756003)(2616005)(316002)(1076003)(54906003)(426003)(336012)(186003)(26005)(81166007)(5660300002)(86362001)(2906002)(6666004)(356005)(7696005)(4326008)(8936002)(40460700003)(8676002)(508600001)(47076005)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 06:12:25.8149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e101928-d2ad-4dc5-b4fb-08da025cf2bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2854
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable sdma v5_2 soft reset

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 79 +++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 4d4d1aa51b8a..f9f978d8fe8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -806,6 +806,80 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool sdma_v5_2_check_soft_reset(void *handle, struct amdgpu_job *job)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (job) {
+		if (!strncmp(job->base.sched->name, "sdma", 4))
+			return true;
+		else
+			return false;
+	} else {
+		u32 tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
+
+		if (tmp == 0xffffffff)
+			return false;
+
+		if (tmp & GRBM_STATUS2__SDMA_BUSY_MASK)
+			return true;
+		else
+			return false;
+	}
+}
+
+static int sdma_v5_2_pre_soft_reset(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, j;
+	uint32_t tmp, f32_cntl;
+
+	for (i = 0; i < adev->sdma.num_instances; i++)
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), 0x10);
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		for (j = 0; j < 10; j++) {
+			tmp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+			DRM_DEBUG("SDMA%d_FREEZE=0x%x", i, tmp);
+			if (tmp & SDMA0_FREEZE__FROZEN_MASK) {
+				WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), 0);
+				break;
+			} else {
+				udelay(10);
+			}
+		}
+		if (j == 10) {
+			DRM_ERROR("SDMA%d_FREEZE frozen not set", i);
+			return -1;
+		}
+	}
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+	}
+
+	return 0;
+}
+
+static int sdma_v5_2_post_soft_reset(void *handle)
+{
+	int i;
+	uint32_t f32_cntl;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 0);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+	}
+
+	sdma_v5_2_gfx_resume(adev);
+	udelay(10);
+
+	return 0;
+}
+
 static int sdma_v5_2_soft_reset(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -831,7 +905,7 @@ static int sdma_v5_2_soft_reset(void *handle)
 		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
 		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
 
-		udelay(50);
+		mdelay(2);
 	}
 
 	return 0;
@@ -1655,6 +1729,9 @@ const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
 	.resume = sdma_v5_2_resume,
 	.is_idle = sdma_v5_2_is_idle,
 	.wait_for_idle = sdma_v5_2_wait_for_idle,
+	.pre_soft_reset = sdma_v5_2_pre_soft_reset,
+	.post_soft_reset = sdma_v5_2_post_soft_reset,
+	.check_soft_reset = sdma_v5_2_check_soft_reset,
 	.soft_reset = sdma_v5_2_soft_reset,
 	.set_clockgating_state = sdma_v5_2_set_clockgating_state,
 	.set_powergating_state = sdma_v5_2_set_powergating_state,
-- 
2.25.1

