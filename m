Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023ABC33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 11:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF9424676
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 11:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n/9Lhs5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF9424676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FB66E37F;
	Tue, 14 Jan 2020 11:43:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF036E37F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 11:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggw1IJlY+5cs619nE4Ya5o70n6F2sPdulj9J9n0HVv7F3w9N2NMaMGY/mueecQOJR4w3hKUSvTS2Cmpd8wgu5v67YKExOsTFChh5HHWTTP+JGKcLI/rMZbERUnzwQmwbzzIExvaHfw6xNTX05cYH+SScVT0acRhTh3eWlGs+f6jfDtj5W94xqp/JFw/1MYx+9mKJAG27gA1lpVRLHH82Gj1NsZBBI/toFC6zwCGbM+N85GEDvelhQfWQFaixTjqeHKQfq5OAm00IKNDbD9DvR4mXDkfOtwzgJpU4VR2tsADUsKJuTm98d61D5sRKN4K4N8WVEo37ClrxCd74UKMVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGeIkhZJiv7YHQr8q9hfCKCQDgtJoXXHpGgHmcnGbNQ=;
 b=QfGiJhrsgv4YZKF8nuXdyP6PhkIVONPq6dpNWl3Gs5fMZCL5ilLXpCHq4+Cvn6pBjX0NHxjb2K0PGDJp+ZESmOhrL3IqHL+GXk0Gk2AWhUkNTX0Lwg8Gs+d5DV0dc7mkjDVYJD1++J1hCKSiKado+/ulTS/qDLCLzjaydj+e9Iv8RPEkWWGKQsNe14USxS+fa7or8y3RzUctZIBOGMD7gbsK3+p6yc+l0qaCXLbgrAqNMHKFJG/q9G22jEWBztu70ovkar0YFDEE46LymOFHYvMgoiVm+9rLq43vgTFmAGjkHl37Z5zrgG1RXb1SUJ0pCESzdRWF6Axq0A+PgeQ80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGeIkhZJiv7YHQr8q9hfCKCQDgtJoXXHpGgHmcnGbNQ=;
 b=n/9Lhs5APRmQyi0kjcqZ9WTFAr67UL5/U3aIJxa1Tbwm9KOQBnzqJAvXK/Vj4Ovb6yioA9ZVX8YCcOIpYKkvSsbAU5vCNL9CFQXiBGqBLNYRri1807Nzt98Vvf3DuRhzb07OxJ5gJIf1UgDa7Yy+Dhf6djuywLUwc4d3g/QOA1U=
Received: from BN4PR12CA0001.namprd12.prod.outlook.com (2603:10b6:403:2::11)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Tue, 14 Jan
 2020 11:43:23 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by BN4PR12CA0001.outlook.office365.com
 (2603:10b6:403:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Tue, 14 Jan 2020 11:43:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 11:43:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 05:31:40 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 05:31:40 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 05:31:39 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add kiq version interface for RREG32
Date: Tue, 14 Jan 2020 19:31:34 +0800
Message-ID: <1579001495-20729-2-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579001495-20729-1-git-send-email-curry.gong@amd.com>
References: <1579001495-20729-1-git-send-email-curry.gong@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(428003)(199004)(189003)(316002)(6666004)(2616005)(8936002)(5660300002)(8676002)(81156014)(81166006)(356004)(426003)(336012)(2906002)(6916009)(70586007)(7696005)(70206006)(186003)(26005)(86362001)(4326008)(36756003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8865fda3-08df-4a37-d72f-08d798e6f5ce
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:
X-Microsoft-Antispam-PRVS: <MW2PR12MB257276AD9811FDD646F238639D340@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 028256169F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10aLbiS6R+cvvoeaVgpPtBx6Cer9/juQgDVjrIkTYXNICTi2Hr7SFhDuBwZo/DnJSEGgPVYcluba4leif1xDuoxuqGhPwNNdA3HWjY1cKlTCVt1dkQSWpYTd+DW5hAqxsoTsyBkOLIa26cyTknJYQovT/5e7pgmGYV9m/anNL+SCA9lYUp58mPuQRrgXEY9Bh56bU+WIIdSTmTaWtaFcqRn4vQNinIxLGWx5gQPHgKXby87dF+JiXGxK60dQnXuoUBf/ac8xOQij9wWU95gFOkIlPSpZlRbeqq4fZYdaipsf4tEfsUlViuW3DohKLi7pDm9fMp3mqSOdDzvZH17U1BzAj6OOnhL8X7QxZ5LjjW+feL9OnINi20si2y/xuVVYWPzJUJ6uKWBA2v7r8/NrmxZx8qD7zmWtRhiKu1IM8LXNYQo5DXB6s+HMDXKwIQ4l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 11:43:22.9647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8865fda3-08df-4a37-d72f-08d798e6f5ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
"gfxoff" state.

This problem can be solved by GPU in "ring command packages" way.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 32bb883..90f148a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1016,10 +1016,13 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
 
 #define AMDGPU_REGS_IDX       (1<<0)
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
+#define AMDGPU_REGS_KIQ       (1<<2)
 
 #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
+#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ)
+
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1d076c0..1fceeb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -264,7 +264,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
+	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_rreg(adev, reg);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
