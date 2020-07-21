Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45342C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A87520714
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S8QWdUUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A87520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DA16E4B1;
	Tue, 21 Jul 2020 10:29:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044E26E4B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 10:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf9jEhiy2rvum1EDbfU1A97hO4oUSPO51hBaf+8PuLnmfVxrb+qJPIwMETUvvBGMYdgxUpnZyw35vxh6V5RDG08MEKDKIHxApnvuWbmzDox/96Qe2GqsiNisF6JYOgTr6pidXZitwGoPiaV0UU6rk7GufyQ3wWKLVFX5/L/H3qLYRxirT0CtgvuA6jNvAMoj90/Kk/9nqE0jQ25de2ihqY9shEL5kAVTjbjCn8AqRttsTgSgFB9RSwh4oI5cH0niU0GoUKYnQWMkvwZQ8ydEzF70UGewd2iP+e1Kr5qBA33g7yAEUj7m+gOJ65XsGXzPFAk2+ddaGa/yreJI11SgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wramnzfhfV22qShfni5FmW0LEUowvlm3Wx1F5l9vlfI=;
 b=Z3y0iT6nAL7R3OqNSijTeAVN/cWSogTmpQbrR8HfJq0YnrGUpjX1R4oNY+D+/Qz+JtGMS0EGDdb/dzUxvS4eRq0v/lkIGHsp6HciDAqwOOnJY/DiY8lGuBCkZ6eRpERuctjC7PmYO/WDcqhu70hjI4lA/FzBW8s5s6+Bai/NfXRh8VDGraM68oBGdXd2zUMSyVxRq3PZdVjRbAUevpWSDLpL/AnbpVf8z0ivl4vV7BwWePkimBHmXw6a/JPeS0nHDMGiaGjrVBS0Q7u9V3Mx7/USDLQINKuSgFZMLMN1zM3SjHPYNm3SnEXzF467IXz0KhZZ1PbJW6pttHR4Yna/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wramnzfhfV22qShfni5FmW0LEUowvlm3Wx1F5l9vlfI=;
 b=S8QWdUUsFDQKs6Vfoqqa0GiNVLZ3zHp8g09E4CNIrBBbepZxUO4jP8VsdNovy7jI5A6mKaj5wDYukg2FWbuiyDKdnzeieH2ggsERnBHJCj4qF4axrvLt4UzN0C2GWln1FreBGhmZ/kR4EoFn7ZvseFMVbGEjmYxfxHCDjjjpW0s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 10:29:38 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3216.020; Tue, 21 Jul 2020
 10:29:38 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: abstract set_vm_fault_masks function to
 refine the programming
Date: Tue, 21 Jul 2020 18:29:16 +0800
Message-Id: <1595327359-120379-3-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
References: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (58.247.170.245) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 10:29:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b8e54fa-3a2d-4dfd-a6ee-08d82d60f880
X-MS-TrafficTypeDiagnostic: MN2PR12MB4144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB414465384AEAD2DF1249143AEC780@MN2PR12MB4144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3E8at1HAEZAlu1Yb8CUR0CyLzn6U2cidqJDZdekqU7keJ0hVEQc9zJcaRrfgRtv68OUl2Kx/hFgZRZUPYpVfvPddq8DcADPDYpzAETh/kSY+6+v5lKum84mv8JMZ0Fp0TQpSywI67DQfodL7bNH9hRooex9hyxyNoFmOkCkBggB7iPh4CIxHH/sg+ldqTXIkSFg5gl+1yF9sK8J1yORv1m/ZjLh2uyJ2iw9M2xrv8pcXp7u+AFNfra4g8HB/BkbmklaIes2RILf/sBV1ZtDqKhteHx14NvfLv0ka+83l3v8B5Q0Ass6X0Z7HkuzDgvgvncTQpckAJ83I4fyHMl4xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(956004)(2616005)(7696005)(26005)(478600001)(16526019)(186003)(4326008)(52116002)(6486002)(6666004)(2906002)(66476007)(66556008)(36756003)(83380400001)(5660300002)(86362001)(66946007)(8676002)(6916009)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6WrnnYCrF+0DAv9r/HUQTRAIqvFCHavfgyd4mjv/88Gu47Th7yV012e3zhrgvjwlY/3za2uQMLWrjHvGo1/+DRcZ/CgyzutnCGtoicBEK6ua1EzW3Y1mmodAKzgJ8HFeiLypldQydy4rHIdz2Jmj3flV344LiY7ZKcGXmBuBW0/jlaeemuXfCi8YcJ5U0PYV+U+kcV5A5pptrntInYh5SVnSz5/6luA5c8krMJda5zXxiPaENpxE3kwyyIhhyzcMcOCHALG3nZIDvlWq9FuHFiC9Qi0O7E6AhrpkWTnqAVuUwLwSH11UJBeqiOg3moI9f3CBGcpT2i6h4n0QuLxuYfaoSyskiCHlUjapF/NRUTVffkdkzAj39JFYpelJ1yT5weaBeak+7eyWuSWuB6M4YTOHLEi+5jWlbl/vjl2YIvbk7R2ZvoKC9EVdKO+yHG8TGI/P3WfKFJyIq31XfUCZwIi9+bRoGcBO2kLtkQwkgq+ZdKlQFL4dNEGQrOUGlgtI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8e54fa-3a2d-4dfd-a6ee-08d82d60f880
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 10:29:38.5294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oi2Hxl2Zd7Wib/DfK7mxk4EY3p/aGd4WRM0YWZsvtJcyLlfIiEtVvwHODLlVh4vhSS3UyKMhGLX095l6Q7eW4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add set_vm_fault_masks helper to amdgpu_gmc to refine the
original programming.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 20 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 53 +++------------------------------
 3 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 34cbd6f..21d2c85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -411,3 +411,23 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 		break;
 	}
 }
+
+void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
+				   bool enable)
+{
+	struct amdgpu_vmhub *hub;
+	u32 tmp, reg, i;
+
+	hub = &adev->vmhub[hub_type];
+	for (i = 0; i < 16; i++) {
+		reg = hub->vm_context0_cntl + hub->ctx_distance * i;
+
+		tmp = RREG32(reg);
+		if (enable)
+			tmp |= hub->vm_cntx_cntl_vm_fault;
+		else
+			tmp &= ~hub->vm_cntx_cntl_vm_fault;
+
+		WREG32(reg, tmp);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e11c21a..1785a0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -291,4 +291,8 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
 
 extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
 
+extern void
+amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
+			      bool enable);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ec90c62..e6c8526 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -62,63 +62,18 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *src, unsigned type,
 				   enum amdgpu_interrupt_state state)
 {
-	struct amdgpu_vmhub *hub;
-	u32 tmp, reg, bits[AMDGPU_MAX_VMHUBS], i;
-
-	bits[AMDGPU_GFXHUB_0] = GCVM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		GCVM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		GCVM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		GCVM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
-
-	bits[AMDGPU_MMHUB_0] = MMVM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		MMVM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		MMVM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		MMVM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		MMVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		MMVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
-		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
-
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 		/* MM HUB */
-		hub = &adev->vmhub[AMDGPU_MMHUB_0];
-		for (i = 0; i < 16; i++) {
-			reg = hub->vm_context0_cntl + hub->ctx_distance * i;
-			tmp = RREG32(reg);
-			tmp &= ~bits[AMDGPU_MMHUB_0];
-			WREG32(reg, tmp);
-		}
-
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, false);
 		/* GFX HUB */
-		hub = &adev->vmhub[AMDGPU_GFXHUB_0];
-		for (i = 0; i < 16; i++) {
-			reg = hub->vm_context0_cntl + hub->ctx_distance * i;
-			tmp = RREG32(reg);
-			tmp &= ~bits[AMDGPU_GFXHUB_0];
-			WREG32(reg, tmp);
-		}
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		/* MM HUB */
-		hub = &adev->vmhub[AMDGPU_MMHUB_0];
-		for (i = 0; i < 16; i++) {
-			reg = hub->vm_context0_cntl + hub->ctx_distance * i;
-			tmp = RREG32(reg);
-			tmp |= bits[AMDGPU_MMHUB_0];
-			WREG32(reg, tmp);
-		}
-
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, true);
 		/* GFX HUB */
-		hub = &adev->vmhub[AMDGPU_GFXHUB_0];
-		for (i = 0; i < 16; i++) {
-			reg = hub->vm_context0_cntl + hub->ctx_distance * i;
-			tmp = RREG32(reg);
-			tmp |= bits[AMDGPU_GFXHUB_0];
-			WREG32(reg, tmp);
-		}
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
 		break;
 	default:
 		break;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
