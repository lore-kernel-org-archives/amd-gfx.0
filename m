Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3466C83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 06:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C48210E21C;
	Mon, 28 Aug 2023 06:40:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA4510E21B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 06:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im7mG+Ad0hsVgjHF3PpDGCL7/yFFFullrxuL+XIt1LYM7DQghVt2sDYkZ3tzzRUfel6jONrPoZLn1X8iwRk5FhcpoYsGoDUVKUz0+2av69LO93qkMfoKeuaj9ncFPpNEOxD7ne+pEcX+M4SYSeJyPUCqRpmkAkwfwfQaWR91ULTnHOCNlNShvjFJFlLds2Nod4il44XSd05Ca2GWRHEhDdOvjJpM4eMaRC47ESnmmUqQbXSTiWX1OjQEI2PWbVdzkJDa7tcv4f1LOCPAZDTwBj/u84WOHXWxN/YDsfvMMI94CEwGK0rYL3cT2YVdOyafxJVxY6BnVjnD7cbFeMArGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPLa8h9q8lLoVb7YfsXQXwGW1dFCiEGpCiHUsK1Xj/I=;
 b=WsiIzyQ35CJ4y/D9rZXkbLPJASX9QxHYQYRhXQYoXit3YL36N4wkQc+VTbtF9BhALw2qsmjTZduawpqtQRegfkDH3RpUhdMkACeTRoyVXSGHSo/qWPKgSYgJHdSeoxqKccPM3+HKYw+LzRuZfllUDR++NgHhrs0Bj+YNqCtQdhBPCbYACD7ZJ9ki0zMSp/jpIPf0uQ/HITnVMA6EllzGIVmj8gz+kCKahsc+dziiXzbKRU0ywRZE9Rnpa4y2okxi8jGJfnciWnNsgxkwwSIdhQiJwGVOp2YG9wKvUjkIRi4K4ySq+wrFKMpqYyTUuOewypAlZz9zac9bxqCxw7QmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPLa8h9q8lLoVb7YfsXQXwGW1dFCiEGpCiHUsK1Xj/I=;
 b=VyeP9KcjBn6mGth5duNiUjYvBZ2v20yMBhfRumHulaUG4c72XOYD/TVzUSNaCf6casVOC77rE2QzIlvHX/hrlx5cRZ5fx78GuBHoUSKXklJ1AYgYGaZpl6R1OXITFzN2JtzXVqjcPtqLDSw3CYrbS5nKaYB7yiB78nNofyktXW8=
Received: from CY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:930:8::43)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:40:27 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8:cafe::29) by CY5PR03CA0015.outlook.office365.com
 (2603:10b6:930:8::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 06:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 06:40:26 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 01:40:21 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: access RLC_SPM_MC_CNTL through MMIO in SRIOV
Date: Mon, 28 Aug 2023 14:39:26 +0800
Message-ID: <20230828063926.5240-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM4PR12MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e1bbd5-3a1b-4d64-d7df-08dba791aa2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bH7ACQIjcNkN6gQNhz1B8wTsqqhsSriIMqAs19CPasOJPtFN3lKIhtaLGbSRYRYVmCnMUUnuVKa/eRcJAFijj5wexOrA4gG32SHq+ohxeK/tHjhD0AYYyYhvds/dzAYUA/yZczY73N9mLBfdy0D7oCdQks8dk5hwaGpkGx3C748wY/dxl0jLV7F0Td7g3y8aGyE6PGRKQZWgSV/Gk2VpTx7ISNkxICkJxcdGlO0pq2qo9dNv5DZr9S0YvYieWcVEY6F+j7Rqjj+d3tV1T1QxwP4M5Xg2XKrG/PJWdlVwnzp8kLcqEj+0FsQbnTk9odACNg3XnFmmA6kZYlatgPNCZJkUBt2AcM6y3Omc7eFrz2P0Hm2kv/ZLkzxsKW1QhDow3lTxgwk3MzQMjFZgN1wr5FVJY2yTgYs26py8OCeWYHvaRRJBz1BY+qfh/0xWcDrVsjFShyGUDMO7ialkKb4x8ryAuXr0CxOtgT9XLNTOgWNOMYpCUs2MMTlwv/JoM4WDYxhSwQTUZY+f1b+wczCXHCpdlFhSTEFYVK0IXj/RIO675bxJr9av0uC4+i5JoXZnvmYXIVtd4RH/z3qjVKPUpbE0phxO6xUZ9Pj1ePHGxCx9E5e6Q3W9fKbooNqKJPFLoGwFJGwV0U8yUkqzM7KQsDnBK15arG5XtU9pYSesNgPW+pCKx0wEpZBHaa2eKlP/NM6iJcmuwPuLCP/keDFnUoJBZYMcsZNwepKheFSUMVgGUsM+jlU5+wP5z68oR23z9pkTJt+R+QJ0F88qzEB4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(8676002)(4326008)(2616005)(16526019)(316002)(26005)(70206006)(54906003)(41300700001)(70586007)(2906002)(6916009)(40480700001)(478600001)(1076003)(7696005)(40460700003)(47076005)(36860700001)(36756003)(83380400001)(336012)(426003)(81166007)(86362001)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:40:26.9412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e1bbd5-3a1b-4d64-d7df-08dba791aa2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, yifan.zha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Register RLC_SPM_MC_CNTL is not blocked by L1 policy, VF can
directly access it through MMIO.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 10 ++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 ++--------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0aee9c8288a2..65619f73f717 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7901,18 +7901,12 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 
 	/* not for *_SOC15 */
 	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
-	if (amdgpu_sriov_is_pp_one_vf(adev))
-		data = RREG32_NO_KIQ(reg);
-	else
-		data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
+	data = RREG32_NO_KIQ(reg);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
-	if (amdgpu_sriov_is_pp_one_vf(adev))
-		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
-	else
-		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+	WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned int vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b0c32521efdc..7f8c5c6fd36e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4989,18 +4989,12 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	amdgpu_gfx_off_ctrl(adev, false);
 
 	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
-	if (amdgpu_sriov_is_pp_one_vf(adev))
-		data = RREG32_NO_KIQ(reg);
-	else
-		data = RREG32(reg);
+	data = RREG32_NO_KIQ(reg);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
-	if (amdgpu_sriov_is_pp_one_vf(adev))
-		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
-	else
-		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
+	WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
 
 	amdgpu_gfx_off_ctrl(adev, true);
 }
-- 
2.35.1

