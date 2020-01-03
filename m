Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB9BC2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBE021734
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pXnDwA+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBE021734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22DC6E1B5;
	Fri,  3 Jan 2020 09:48:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141B56E1B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqMbVu/VOdGzAMZa0t0M7+K7m4lWj6gzyQmHPywCpLRssl7MyYFVsOe70NkxxWsmcT48w5R+wmayqUIkXen7TLriFAE8dBVAFlyP11bcdcWr8aRHE0BTv1UVOZZKsvxNr0Fybjl0j69tAtHHd6+YZS4DBwY5Jc1qDzr43AmU5Iv31AuKvyHH3KzMzMRlWhJLnU91pFfNpls9yDYMFOXtll6lM05pZws87CTOviAY18OG0w58U/LBxdBy85VD657RLwoasUCk3Ug8tj1FYBKvM2rkqZqq67uICXwc9mz3jCrIKTbCmr5ksfs9GlfxDRKbqB24QA5T/ulkUs6RkrMzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DakIbdJ/I+B6NdgKKLFdAZyEZskd3ExBjfnulbw7GT8=;
 b=XVX1B68SULK7fOlmdf0aq0jKVVlBPILU2xNyba4UTM6Dr+ao0OcG1hSmEkNdTPoOyLQZXQ9a/0L1ka9Hja1VK9YPnMPl7GtPl0FLwB1VdGTT6dtweeqBQUbz6SMD2UjpobGFscHF65QTfEk50ipupIhvCzX0iSPEUSpDuE1KYDgVHh4Tk4nV20QO/aFYcDAXXSiH/93wLCpxON7NCds7iMEdA7RFBdS9tqd9k7EE6xO3gx/IAXUR5ieSMygXc3fhDC+5UhxHHLZbiV6b1cr+PxpYKRalbusLpKsj8hByZ6Df6VyIXaxykI0Q0LtkedG9mU4OI5aAXVe8WerodNqJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DakIbdJ/I+B6NdgKKLFdAZyEZskd3ExBjfnulbw7GT8=;
 b=pXnDwA+dqtCFDUqRnFy48gBaCWeHngDexRMo17UfEB5Ukb8kRW2vvUBj9quZjn9R2O+Y86LqjIiNeP5XUkEgdKfE5vDpa7O1GyaHd6EYJRcvi850pwgK4cZC0qRoGmoDfolnrFAchno+EIMVkKRxq3jaIWH4kSoniR2w03xl8yw=
Received: from BN6PR12CA0027.namprd12.prod.outlook.com (2603:10b6:405:70::13)
 by CY4PR12MB1605.namprd12.prod.outlook.com (2603:10b6:910:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10; Fri, 3 Jan
 2020 09:48:37 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::201) by BN6PR12CA0027.outlook.office365.com
 (2603:10b6:405:70::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend
 Transport; Fri, 3 Jan 2020 09:48:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Fri, 3 Jan 2020 09:48:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 03:48:36 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 03:48:36 -0600
Received: from guest.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 3 Jan 2020 03:48:29 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Leo.Liu@amd.com>, 
 <Frank.Min@amd.com>
Subject: [PATCH 5/5] drm/amd/amdgpu: L1 Policy(5/5) - removed IH_CHICKEN from
 VF
Date: Fri, 3 Jan 2020 17:47:44 +0800
Message-ID: <20200103094744.2127-5-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103094744.2127-1-Jane.Jian@amd.com>
References: <20200103094744.2127-1-Jane.Jian@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(428003)(189003)(199004)(186003)(8676002)(2906002)(2616005)(426003)(54906003)(110136005)(81156014)(81166006)(7696005)(8936002)(6636002)(5660300002)(1076003)(316002)(26005)(36756003)(336012)(356004)(6666004)(86362001)(70206006)(478600001)(70586007)(4326008)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1605; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d174794-a07b-417e-e70f-08d790321b0c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1605:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1605F122BA981F11BBB3644BFF230@CY4PR12MB1605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VlKB2ivyXM/MhRwTD+b2Zcv455NzUgw5rbeYwWPp5U1O5ET/D+DVdZeTu8qUXabaOknBRKO2aF7/z7Lc681L8DjJDyAjkfrGw5a9pqAXXrh0q1LCAAJ/qtMBzC866L91G6vV+kWqSr0elv2LN6BPV/PdBMqD0T4Zp+erch+zliMWgfAs/O75+TZ9E9n0Ija0+LJ0Qay0JQeKoWHpjfdnlPrhhzOniyZIYsHgBN3FM4nMPogS4bXb5pCRLEWJiwP1ANRduIihQvyEqZb1rKBwNHHWqPotCpwLa17R6medcUC5OWtW8Hb0a7IjGywyVckgtfhNI5hbsGbE0m5H93wkx+id3lEIUlJELXdKffE4Gjr8vZE3TfsdW554OPQXH9OEf3sdjnVXRzR/hTsnBo4L4tH2Ga3xzJA53yTwriuQo7D0CKIgqLTTlxWvKNld05fFQrRlA2bSDk+6AvQQvu1imCqr0Mqcy5cvh/a48nuE7JJg6TNXAONDohSPVUNnlLL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 09:48:37.2390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d174794-a07b-417e-e70f-08d790321b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1605
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
Cc: Zhigang Luo <zhigang.luo@amd.com>, Jane Jian <jane.jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhigang Luo <zhigang.luo@amd.com>

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Jane Jian <jane.jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 5cb7e231de5f..d9e331084ea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -234,16 +234,9 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI, (ih->gpu_addr >> 40) & 0xff);
 
 	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
-	ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
 	ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
-	if (adev->irq.ih.use_bus_addr) {
-		ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
-	} else {
-		ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN, MC_SPACE_FBPA_ENABLE, 1);
-	}
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
-
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
 			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
@@ -253,10 +246,19 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	}
 
-	if ((adev->asic_type == CHIP_ARCTURUS
-		&& adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
-		|| adev->asic_type == CHIP_RENOIR)
+	if ((adev->asic_type == CHIP_ARCTURUS &&
+	     adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) ||
+	    adev->asic_type == CHIP_RENOIR) {
+		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
+		if (adev->irq.ih.use_bus_addr) {
+			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
+						   MC_SPACE_GPA_ENABLE, 1);
+		} else {
+			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
+						   MC_SPACE_FBPA_ENABLE, 1);
+		}
 		WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
+	}
 
 	/* set the writeback address whether it's enabled or not */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
