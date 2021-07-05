Return-Path: <SRS0=ZRVW=L5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F85C07E99
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 10:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2E1613E7
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 10:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2E1613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BFDD898B6;
	Mon,  5 Jul 2021 10:24:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909DE898B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jul 2021 10:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkI2yXl4j14a+3tRoxdBlxXuYdx8mw2Fl5CrRhpQMSu6uI7sfNvBkCk9dhO+cSzYAhYCvXEOeIV9xggb509b9DPTuvaSYuA11GsQvJZ0nHORyG0DjWqLqzlpEYZKup7ssKpvqZo8dW5PV1JMTSmqXNSl2mtksk12l+pbeptXUQj88baEFwc1jw/1rFM7m8XYhd82hIao67rdmBjBpqxMo1euzaIwvT4Syz+TKjFwZWp9KXhYEyUEZvuZtXGCfcDBEIJ3+SrjKP96SL/7tVKT0nYbwxEbfPneZwmg4t3SMWgkW4357B2V3cDhkUIUDz0nZwhMXAoufZXkpc/9UikXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0mmGVHogNiPmjP6h4M/P/DR/XR2EGmae0cXKDeAjbI=;
 b=el6Q7dhAEKXTN8afRP7KRuvpbH9MexP0fu9t2hA7/HDLsgO8K+W4o2bxZyXMjKIzKAF2klKg3v++R8bn7009pVDXSmufjd8IWOkxHPwrFqDqpoxOotf1+QfTv2MbYru3sTpSy4HiYzoaLutaYAhGwomBdwIUEVpOJwSQ+u+BmscXZ7mvilfHP0DhXDAO+MT8VUPT1rNbN0SxT6NK9NY/VG612+VacPU/8ja9hvtTUjV+2664dxWh+y4DuuvFXQmGpfqmrILLknXm+FU523j06/7PeYNbDaVHAS6s+SD1HQZa58xu+VW1vEIQ+r0KWAf0YPOaJZD2DKI0qlOK3CD4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0mmGVHogNiPmjP6h4M/P/DR/XR2EGmae0cXKDeAjbI=;
 b=BMC5inY9RMNXrCmmaW+gM5QM+lZofAM+0ztpv1z3zVptIalqtR01NPHzHlrxmmhPdRbwsfAJs9Ir9ASo0SIZJWe15kuS8RwzuJYvjDPNKK5GD7tgGIRpSe78RuYMyiK8A1Mj5+mfY5qzioa5lQFBMyALozHlYUv+Tqw43Kw2W94=
Received: from BN6PR20CA0056.namprd20.prod.outlook.com (2603:10b6:404:151::18)
 by BN6PR12MB1236.namprd12.prod.outlook.com (2603:10b6:404:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 10:24:03 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::e6) by BN6PR20CA0056.outlook.office365.com
 (2603:10b6:404:151::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.25 via Frontend
 Transport; Mon, 5 Jul 2021 10:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 10:24:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 5 Jul 2021
 05:24:03 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 5 Jul 2021 05:24:02 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] SWDEV-291099 - Use a percise function name
Date: Mon, 5 Jul 2021 18:24:00 +0800
Message-ID: <20210705102400.5406-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4c8ebc6-63c3-4601-464a-08d93f9f0341
X-MS-TrafficTypeDiagnostic: BN6PR12MB1236:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1236EF5FFFAAF453B21CE16DFF1C9@BN6PR12MB1236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CO0HBPicMPtz+9M7l7TZlpBUxLsnW1th3Xx2tRtQ6sBcaix98R7SSyyeAmh/JLnT7nqj/myK9MTbQBWlbqTxRXMyY1iPX6aDPZiMuh7V4rVYvx9AfJg0tt1HcL1Bf5goPxStM6XHBeaw4k2YmVurM5fkzlcHfLKWGw9tLg+aBpBW3hJs3eXo4KA7a63vlr8FwEiQCh66+VNiuTqUc4FD2eY1ONEFSiTYZKqhhonT1b4DYq51ZmgXdkI5dLMnPKazXjQDrj+A9fwTSYf6n4gGBU+jfm2IjjLLY2Y0M5llmrZBcKM0s/w2xqg9xaWkwUjjPAHAcoV2J4vlp4lYEU3xxNUY9Du2ocpqLPDJAtFneeG3xFdXPaE+4PRG8a3YBfkvdfVglrrOmE8USsAWswY44+V1i8z8rYG5tH1xCk1MG0WzNt9g/avxO+WBx4YVF3kLUCgvRXKratp2+qX+SAdBLB+47FUm4sMdrAEejCloxFU342Se4N1wuSCv6LnoNXt7YLpNI2bFWsx+FIVcuprRZidB/+sR+Q48AYYoAj85ro2kHcRaijQIgtx4B7B6mjWWLZ7qgSn2duhaLxhLATHj/s2Fr7RYdZLbn4R42ZJiawr1it58mcSKLz1GCqmoCNnsLIHqsHE2fC6KvADZxA9gyfhiMA/QHRjQKgXI32dYF9vpUeD5b7QnakK7Z1SwWlTBLChBF6OivUVsbx/VjCBOGxdSyDaxLRh1XYM9/d4YZBI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(82740400003)(478600001)(70586007)(47076005)(356005)(2906002)(83380400001)(86362001)(316002)(36756003)(82310400003)(81166007)(426003)(2616005)(5660300002)(26005)(4326008)(7696005)(336012)(8676002)(8936002)(6916009)(186003)(1076003)(70206006)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 10:24:03.6065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c8ebc6-63c3-4601-464a-08d93f9f0341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1236
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
Cc: Roy Sun <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The callback functions are used for SRIOV read/write instead
of just for rlcg read/write

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eb1f3f42e00b..aa94ad0e9973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -508,7 +508,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0, 0);
+			return adev->gfx.rlc.funcs->sriov_wreg(adev, reg, v, 0, 0);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 7a4775ab6804..00afd0dcae86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
-	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
-	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip);
+	void (*sriov_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
+	u32 (*sriov_rreg)(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 705fa3027199..c9b68a8611d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8269,8 +8269,8 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
 	.reset = gfx_v10_0_rlc_reset,
 	.start = gfx_v10_0_rlc_start,
 	.update_spm_vmid = gfx_v10_0_update_spm_vmid,
-	.rlcg_wreg = gfx_v10_rlcg_wreg,
-	.rlcg_rreg = gfx_v10_rlcg_rreg,
+	.sriov_wreg = gfx_v10_rlcg_wreg,
+	.sriov_rreg = gfx_v10_rlcg_rreg,
 	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 044076ec1d03..1c9b8b37fd3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5131,7 +5131,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.reset = gfx_v9_0_rlc_reset,
 	.start = gfx_v9_0_rlc_start,
 	.update_spm_vmid = gfx_v9_0_update_spm_vmid,
-	.rlcg_wreg = gfx_v9_0_rlcg_wreg,
+	.sriov_wreg = gfx_v9_0_rlcg_wreg,
 	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 0eeb5e073be8..8a9ca87d8663 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -28,13 +28,13 @@
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
 #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_wreg) ? \
-	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_wreg) ? \
+	 adev->gfx.rlc.funcs->sriov_wreg(adev, reg, value, flag, hwip) : \
 	 WREG32(reg, value))
 
 #define __RREG32_SOC15_RLC__(reg, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_rreg) ? \
-	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_rreg) ? \
+	 adev->gfx.rlc.funcs->sriov_rreg(adev, reg, flag, hwip) : \
 	 RREG32(reg))
 
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
