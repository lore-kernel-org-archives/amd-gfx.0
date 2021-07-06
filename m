Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278FBC07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 04:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6A461976
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 04:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6A461976
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3FE8996F;
	Tue,  6 Jul 2021 04:28:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA188996F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 04:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzaBLGiSW1lSrHmJ/yoNYyRgtStYX+QmO8cC8L9U9Igq7W6JfQW10OaxoCVTgRdTd7eXb/IcIggzvyOguj0GJq7kJbtaOf79NmFPBhzOEYBsXbb5j5m1x7OyeNyxxVEKlV0sMgxl4ekI9+n5eBWpbu/FKOXkxf+47kZtsYaVbrnAQSUEp5q0qoSAvVoNf7IMsRwHW4ObcDUj6BlpxN/SRAufZ4Iaoqqb9JHi6mS0kpLGwiF7us/V4TMeQ5B+cxN3Y6pS6r9g/O7ntmOn2ERMG9rzeavTDtwbJKAxGLZxB8aRvs8TgLeFHWLgdIrakLMC66/FdnVtaB9GUixSKoUBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0mmGVHogNiPmjP6h4M/P/DR/XR2EGmae0cXKDeAjbI=;
 b=V6NXBRHYXGrOKqV1LuJ+oUKFLGIeEnVkJMH0VU93NO90cXbegQIZGfwrn4RcTtQse2LHjoT8z/UVVD+nESij8lx1335kIFTQdYIqJQ4bfezuppZJvtogP3PZQraooTfUOOtlLnlOZpZZ1hZfKvrqQ9ouz02iI/P5MO/9t+urUUu4JcGnHn5A/khHRx+kc7sLfYEABKsdsZuandCLw1NPWBJ7P0I6m1UE/f6Wl+bCmF87gwkmyaDZn2UU/VBHaXvUwT7MpFWs9BRo9RPtjhAPIlMWo8VheOrKQ38Ya0C/BQhVIgMIhFKNCoPqD9KtV81UmzIR7CsY3ToOT3zLQW2vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0mmGVHogNiPmjP6h4M/P/DR/XR2EGmae0cXKDeAjbI=;
 b=klhySVht4r2SOY8sQfZl8DtpGShNpIAurCDAQbQS7WS2Q+4r9sigJMp4PacUTF0XXeR3/+H7pb/swLYs1qGQacNi7G7iaEUdNXatP/w5TcRnPBCoHIMkbu4M7OOSfppQZ5os1rPmzRsInewFgJBmMgdfjhNnEHkLHRZ3qEGiXxU=
Received: from BN9PR03CA0075.namprd03.prod.outlook.com (2603:10b6:408:fc::20)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Tue, 6 Jul
 2021 04:28:17 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::54) by BN9PR03CA0075.outlook.office365.com
 (2603:10b6:408:fc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Tue, 6 Jul 2021 04:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 04:28:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 5 Jul 2021
 23:28:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 5 Jul 2021
 21:28:16 -0700
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 5 Jul 2021 23:28:15 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use a precise function name
Date: Tue, 6 Jul 2021 12:28:12 +0800
Message-ID: <20210706042812.12908-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38a342e6-93b3-4ce0-097f-08d940367a00
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28609BAA550EB399C4B877C6FF1B9@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyGvkxCpU80OvZoHwKtd9T3ePPQz7xYdS/S6GuvSTduPHEhK8MpPDZ5jZReiBff1atrWqEPV+/mGVPOdvapJoh8Vdzo7Ph8omw37+ZQXF6NrfKXtykWm7732oSKIZTf/cEZkic4VeH8pwug9kU4VFxTr00fVHDS8kfd99p1TxHXpSvJYGo/GHC4G+EljHcHWijLqylHZCp1LPRNMqI1OTYZPpjQZJvo3+5aIZ6pniSVgBiVUsbxAPiu0Tvmzemwz/octuFR1nzqG8BDiJ/n/8kUUszCI/l/IYquUZtSltjlFd6giijeqJuNbiiQhSeUaegRqj8M+lwbqD2UT+Y751jZEZ3oexe619zImLsAEmQ+iHvDvGpvHJXE0E6SaAglMFAxouvQpgps77WEimGRekNJpz2Iwgl9b/zkoOMrkuHHzk/YY8/ntiJGh5ELIU3OmzUwlVd977Th3fDNkWKBgerYrgVRGSovvETsU+WudohN4hzy4MqhT5m8J3ztSObD4nvj5gYAySQuw/0fqzFbrQba2Vnb7/2BpLsRqxdwMiDn5D0+eWSVQRH4Qia/oZexSjFKoSjTMmLLFv9jg+mCHBhvzvUcwApzKBXI99stG/WFWpBlCam/PUp+2NwnwJxja7hwJmI7zkBtYl3wr4HkZHIpGlQeiYtGtucP4A44F2oAiCMoIbPrEYsPp4btKgXeiD4wZp3aLt3cEWjPzJ9FGuHbEKbrZ6btJqkCss5J5yqY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(1076003)(47076005)(7696005)(82740400003)(2906002)(8676002)(83380400001)(70586007)(2616005)(4326008)(81166007)(336012)(5660300002)(316002)(6666004)(6916009)(36860700001)(82310400003)(26005)(186003)(478600001)(86362001)(70206006)(8936002)(426003)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 04:28:16.8340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a342e6-93b3-4ce0-097f-08d940367a00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
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
