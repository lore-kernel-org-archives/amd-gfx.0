Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48145C33CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6DC24671
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WGjJZ/yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6DC24671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9713D6E8CD;
	Wed, 15 Jan 2020 09:41:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384E789E23
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 09:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS2yIvNnowc9rw57maAlLst/HPoGG8EE8uV1y7uTRk3aensggQKyFUauRISoqxNwHhmimZ+L2oz0PtZmeConwaSlkWVcAFz3FjtF/sHPs7ACIQ4cE1YQ8B61FBLWYKAkifAxDAxNQWsWdwcUGtI0FRxceLtEpagIn5T2wcfmD0nfTuP/XpOikpUEmz48mgpNu5IW1oXe6+j6w2LxQlIE7L1I3Ow0OqcrM7QHsqDhlihpLfq03w1evjQLACmK1tKy19goS+myTyHc1JdrahPHq5LkEj0oUan6Y2Am9cPvebcI4yc0tDE7boMsSHoEbvV6RAc7XpGAZvNr4y9LguHW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOaLcpT4JmrlGXQkojs9kwu/e1bD4W7xEr/nTkDamYs=;
 b=Bt4rlfECnuZBCLTCLTtLHn8vvBCyB/PEhjm8Sy2HHuRiSLfZxlNWyxIwFRGM9EwxNdHO0MmFHqweCQs135uhqCTFElZWeS+0lsvWD0xlX4HzG+aXQ2ps7qxiZBPQi1J7WqIajp7K2DZSpVyz7rOtFH8Z5CFpStMoPiqRSEl8Hp7hpwQdvAgX/ZfUd63HoN+H1tBT5Im18hNgqmF+ljMCJSWIZvdiza6kkk4Lc4Tx+GPh1/v14YlyDMWyurlsAGCplMJKoMdJChQeO7dUlE9W8pDg8V5hfDXL4sayEGK9dYQbZvTu+PUnZpsEO0aj+77ylcbz5HskHE/ZnDoH4aOkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOaLcpT4JmrlGXQkojs9kwu/e1bD4W7xEr/nTkDamYs=;
 b=WGjJZ/ybL8iQgZJ9nNN5BQIsZx/Tt35kCE4DYKsZ+kgYYxgq+rBP/fDh6B3DZWMRT03oSODsxPGxKGFgPmFrorYN2jJEnSZlhMLcRdQV+knFHzN4Ko9+Ot0/HLPxWvzTxGOwKIH5NE4dJ9qconhIen4GXVmD/aAr3U12DYD4jzo=
Received: from DM3PR12CA0076.namprd12.prod.outlook.com (2603:10b6:0:57::20) by
 BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Wed, 15 Jan
 2020 09:41:32 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by DM3PR12CA0076.outlook.office365.com
 (2603:10b6:0:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Wed, 15 Jan 2020 09:41:32 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 09:41:32 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 03:41:32 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 15 Jan 2020 03:41:30 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add kiq version interface for RREG32
Date: Wed, 15 Jan 2020 17:41:21 +0800
Message-ID: <1579081282-659-2-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579081282-659-1-git-send-email-curry.gong@amd.com>
References: <1579081282-659-1-git-send-email-curry.gong@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(189003)(199004)(426003)(478600001)(86362001)(316002)(336012)(4326008)(70206006)(70586007)(2616005)(186003)(7696005)(6666004)(356004)(6916009)(36756003)(2906002)(8936002)(81156014)(26005)(81166006)(5660300002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4195; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c3f2baa-8dbc-4a4a-9726-08d7999f1ab9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4195:
X-Microsoft-Antispam-PRVS: <BY5PR12MB419514B14EECD1A251D850D19D370@BY5PR12MB4195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 02830F0362
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TKItYc8T/j55pJtEFPxWErenXFcIHxejt+rYVZDuFx+vZigOlSAfvQ+JKdxh8hBz4zF7tWlSj8Zj3xvorOyY9JFf7PdMwB1okt2yZmjoxhgYyGDS5p4xVIhNMm9QDyyHad7sYcKXXqn/AY6jXcpDHl+Zt4fmIKTRFdE/ShywwM9EYrvfsOOTuXk0TM06oKoXChR+25u5d4FWSUrMgIaBkH2b9TRMDo9ILg9r3g9JfluswEK7sTR/P7Jga3UEac3ceqmuhx1Xy5VccGYq5d1DVhCw781uZavAuyaa5VXi4GGYrmfq7ZloiB+SGTydhi75R9R/40GCMdoH3Akg35Nb7dzoWIKWD7OBdEwrbVToPdw5+YY+daj/xoaYkcho6enGsOEi6+8Aj6nI4B0Z1d4d1dmwPEXG9dhsMVG0ihpGYig0oGprS0DO+Q8TZRs96AE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 09:41:32.2594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3f2baa-8dbc-4a4a-9726-08d7999f1ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reading some registers by mmio will result in hang when GPU is in
"gfxoff" state.This problem can be solved by GPU in "ring command
packages" way.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 63eab0c..b4b00e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1016,10 +1016,14 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define AMDGPU_REGS_IDX       (1<<0)
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
+#define AMDGPU_REGS_KIQ       (1<<2)
 
 #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
+#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ)
+#define WREG32_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_KIQ)
+
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 963ea46..36c0f9d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -217,7 +217,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
+	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_rreg(adev, reg);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
@@ -295,7 +295,7 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		adev->last_mm_index = v;
 	}
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
+	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
