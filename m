Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD432ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C590710E387;
	Tue, 30 Aug 2022 18:40:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1281888784
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4GQQzfYFFVIZDEDIF2VFa9u503q2PkZW55EkSbvfQCIMSCzXY9N7bfa6+te1r8+MvbmEJlk6LcjuyBNXgz18MBxeiJDEynx99ffMxkdc/NI70sY2tuyARF7pYj+TUU9Wam6ksuCNAhMChlO2brrV/ePMZcNBTIvxYld3NeuqeKzRkTmMOcDVSpCj08dBRbMmJQ6AmxiOXzv1PzztUJfREM5p8TavY6vJAJw+4DK+YVL3HLwSgnRrz3QPwOtG5ojlJ25fx6Z/sIenE3Ktky9HGjCD3EJYewCV6zjyesBvJ40F4qb0gzWACiWnZz9SqrqYnzF2PDWpVZOPnCuAJEN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHJ3ePxWnWFPBKo7+Ywmh/FMChhkfkjn8jmr5VVhGVQ=;
 b=mPZek9sGJQq5ZDWw6/yH7eGlx0O4ch9vpFGwqpLZF2fIODmVwXqoGDNag0vJJMeFbAy0JHRB32bhCCFk85cxfPv4boz6VJGqZQ/tQOGeOwhcFtH8PYI5BAyBvCpzWOtB3zNzaSG4UKJlH59Zc4vMH25d98MmrEpRBbZFSygRiSGTFvkq6TXI2jNjduy4xG6QZ+AFlVgtmGdXj8iyoIKakdnjypfclUD6iqe1tIB3rcw2XC/bQLYotbdiEMt6zc0Xoww/4/HyoGW7DonyJs7hyYbLEp7UPaEYl2Rwzq5I8/4LM2hEMxKhCMJZT2mIhF7yeOt2a1fMzQ2zZyQ5olNS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHJ3ePxWnWFPBKo7+Ywmh/FMChhkfkjn8jmr5VVhGVQ=;
 b=TwYz2DYJZOEv28OSY4lKqKM3hdKkdDSIB/alq0M0kcQyw+ne90/ia4rBcIREmPwIaIzcEPp6trey1hZ6kCsAdMjvQJVSYlUJv9A0rH4mY8DYhsy3y9t+7VG8TEYlFVTAXqepLbOicmRBNby3OSusga7j+awd5QqB/O2yiqcVerk=
Received: from DM6PR02CA0068.namprd02.prod.outlook.com (2603:10b6:5:177::45)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 18:40:34 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::94) by DM6PR02CA0068.outlook.office365.com
 (2603:10b6:5:177::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/19] drm/amdgpu: Use PSP program IH_RB_CNTL registers under
 SRIOV
Date: Tue, 30 Aug 2022 14:40:01 -0400
Message-ID: <20220830184012.1825313-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27eeec00-4f31-4dc1-7342-08da8ab71ffa
X-MS-TrafficTypeDiagnostic: CY8PR12MB7634:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHkF+Lvc5tCmhGovfgy4WGx6RKmP1oH/ekGo8N16nyxlFOqzvQ14TmNhWG0sJj7MOIAIiKSxIXHrJhS+1P9RRWBHTBneNshBhcICbu3t6ihtaVDWs7MNA85YzN6mooj6z0FRarjPBtwEl2EQwYX/45YE0qLFtu/4ZLgMjx6a0J9bASHPDqIbvlCWHWuQzwfU6QQxyJxFmNqiFjlescZ4rhRgtFrwSLrQ3gJNoWUDb7rrCgSZqL3hferHHfEiQQXOSowKWZupPT/mHd8Nk/DXTSo92B7Vtxla1Miy+bGkVqa1MnyrzeA4USjw8p/Oew/Df4nZDz5XzuypHPzTcm8qn2VjQKBlYo3oo2YxrLRH4vPrQSZwvoMrGUVXO5LRtOtAQxa9vXKyd5kpFynhcRKqGVWEj7EZjayUyFqcjJUnGA6Vy8g953xMjZAiB9kvdOyLy+oBQk9Gw9OpjKutwrjmWOEcTnXC/dR0PBHDqKVB83do9vSqSbA+LpfrrFvwYgxwedKBHLpADBhHBFLgK2OQv4iMFJ6nyVDL2PJgk1WXZygzh12QzqYz2Y6olcVwRCcrjkY+4JnVIGdFCqfVp/jiL10HMWQ1uFtF6OgOpv9HMBuWVQjaOvuybE4INnHLN0NvzQacPrn0SN47Fskm8tQA6BuQ/0NRCq2N3mj1Q9IMu7rDlIfHpX+lgtV25OD4W6b3nSt/pL4efr3R/5+cIUvFlqGPJXZ+YdYDXfvA9KCuPMW8apMWFcGTYeQeGedAg46V2BkYxVvS9Jy1g4cPhILYb6ooZBRiL/4wdqWKfJugQTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(40470700004)(36840700001)(46966006)(26005)(82310400005)(356005)(81166007)(1076003)(36756003)(316002)(82740400003)(54906003)(40480700001)(6916009)(8936002)(7696005)(8676002)(41300700001)(70586007)(4326008)(40460700003)(70206006)(6666004)(2906002)(16526019)(47076005)(36860700001)(83380400001)(86362001)(426003)(5660300002)(478600001)(336012)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:34.5252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eeec00-4f31-4dc1-7342-08da8ab71ffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yifan Zha <Yifan.Zha@amd.com>,
 Horace Chen <horace.chen@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zha <Yifan.Zha@amd.com>

[Why]
With L1 Policy applied, IH_RB_CNTL/RING cannot be accessed by VF.

[How]
Use PSP program IH_RB_CNTL in VF.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 085e613f3646..7cd79a3844b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -105,7 +105,13 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 				   RB_USED_INT_THRESHOLD, threshold);
 
-	WREG32_SOC15(OSSSYS, 0, regIH_RB_CNTL_RING1, ih_rb_cntl);
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl))
+			return;
+	} else {
+		WREG32_SOC15(OSSSYS, 0, regIH_RB_CNTL_RING1, ih_rb_cntl);
+	}
+
 	WREG32_SOC15(OSSSYS, 0, regIH_CNTL2, ih_cntl);
 }
 
@@ -132,7 +138,13 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-	WREG32(ih_regs->ih_rb_cntl, tmp);
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+			return -ETIMEDOUT;
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
 
 	if (enable) {
 		ih->enabled = true;
@@ -242,7 +254,15 @@ static int ih_v6_0_enable_ring(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
 	}
-	WREG32(ih_regs->ih_rb_cntl, tmp);
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		WREG32(ih_regs->ih_rb_cntl, tmp);
+	}
 
 	if (ih == &adev->irq.ih) {
 		/* set the ih ring 0 writeback address whether it's enabled or not */
-- 
2.37.1

