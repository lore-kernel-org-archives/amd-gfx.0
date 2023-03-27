Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F6C77B60
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B668810E733;
	Mon, 27 Mar 2023 19:36:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A27110E71F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YczQRkSN3CuGR0YkaXfBCUPiv5HxYpd2R08RB5ZpHw8lR+b3PWC7beRE+Tlw8UAXgT4pP0AlXOWUWPkHpIYpRyqGE+BWHp6IQ1pOSYmpgE6SsNgx4FODwewKawYOxXt9Ffqi5ttzp3amJf7PI27Ju4KG9kPY0JLjum5TEAXk029LwAki90zz8xlUmV/L5fXu9CH3k6bvwamfIB6wqQtOrAlSgefGGDPr2ssYSsQ6or912eGntMviqjvIM0+vAlC2O4pmBRZjZsLS8NCOoecLxj50tfoSpZNL2NZNS/N9YBb2dA7m+FvobCp08FsGzs6TpT0oLxluyaFi3CfiysVr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgPmdnBL+LNfHoQsOeDWFzg40yourjr41n6AfZ6qRTA=;
 b=gd4iJL++XoIB1fPtFJWlg9Inenba5Kw+lWPWuzgudax+f0E53HPYg+cKjLrEeRLQdwRG1eREyE2M57gMXSgveu/XTbzSRlsVWd8vKwodWpbMSVUtF0qvW/J3cKQ3noFSaBtAlqPyb2my+HlMEt9qJR8e/Wm4KeW/1LUlrB6aAiZJ82ufI1B5xtgIluc+xNhME/0xI4ppb9MHvrdZmtOHN+MOSZi/PrEFeUrU6/yxQSsZUWa7J+kw694kudUOSXfl7pEkPrb3EmwTE1tgjLwPOUjbOGg5Ve7wVk7Aq4Zk5T1fPWrawqDVcuh4uGc30jZTE47kh+2kW6CVegCY6Hrt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgPmdnBL+LNfHoQsOeDWFzg40yourjr41n6AfZ6qRTA=;
 b=XeGFxXYeZk3BsydF6PFsd8LvAppfjag5JDGrg5rFak5JZ9LOA55UsI5KBMk+uBMiMN6N0gTOtwAE8C7nc0Q4pimFpjLvTMNjmVzwfCETsekJL0JFDevLCEgob3W4R562PFG2uC+iLIXxVU05zMqrfMOU3yBxZBAl7x5RdkqtqzE=
Received: from BL1PR13CA0383.namprd13.prod.outlook.com (2603:10b6:208:2c0::28)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 19:36:36 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5b) by BL1PR13CA0383.outlook.office365.com
 (2603:10b6:208:2c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/28] drm/amdgpu: make the WREG32_SOC15_xx macro to support
 multi GC
Date: Mon, 27 Mar 2023 15:35:57 -0400
Message-ID: <20230327193602.7901-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c30f81-8146-4714-b541-08db2efa9430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMGjbPgn9UJS19AIY0UhBFiEcuLu0d0PV3Wz6VkIPOUoBOgZupGIjXnv6OImTRBU9EXWEXgfTb/1zu+iuWMLM6x3b6Z20mMPRpwjNOrMaz4i2ps79P6REk5XDhr2fVWLSXDU/FuED2y0kE4RVsCDVmYzTISKllexisw7fTGt3FnPzfDe5tfc6bBGPeALtxYZ7LwO/78E5AuyiMhN6g8R//UBwVoSVTNk63HeP8yRh8GvOsgcHDJiKEODL82b1OMEpDlld+fAlF+35Y4U3G3dM7ov85POO4KivvyGwAzm0x6ukjRd+CWzlX3T9RoFZm+COq6qqOekK/WnUmizI16r2DnhfKl/3WUcxp6MpQOH9h70Mmqsw6Bcz4zQMhdylAZd3KEohP7CsmGMgR7kKmv5eBMxpxVkiACUINhzzOwj1JGuQ5Io1DW99Z+sbpZfc70QmEzOohHpYEWtJn3tN1fW9hL/lt5n1F6vMeipw8KCoN8e8loM7r6pwuLDLNffRHHy8jRZ80zK6CP4HPPSy0SZZYhBYyaOFVWXo4lnJXgfqKMPpvcsvnrPFdCbQ7l7HdwajxovvsyZvgz3l5U4yzcApVn1ix4jCfAlLWYxiBjuhFlqi6j5ISiGeeN1D2/beH52cUiBv0xZbqtPuUh0C/VRATfx+u+7B8sS4wbGg01TaYOXuYCYI5xFuw2Dq1Gd90x2yWXkmbSCulfZyDVFXBilfA47/n/9KrYATncmMOK/H4A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(4326008)(426003)(478600001)(8676002)(7696005)(1076003)(36860700001)(316002)(40460700003)(70586007)(6666004)(47076005)(41300700001)(54906003)(70206006)(16526019)(8936002)(6916009)(2616005)(83380400001)(186003)(336012)(356005)(26005)(40480700001)(36756003)(2906002)(5660300002)(82740400003)(86362001)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:36.5510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c30f81-8146-4714-b541-08db2efa9430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

To write regs on different GCDs, use the inst index.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 9fefd403e14f..3f6dac856d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -157,10 +157,10 @@
 	do {							\
 		uint32_t target_reg = adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
 		if (amdgpu_sriov_fullaccess(adev)) {    \
-			uint32_t r2 = adev->reg_offset[GC_HWIP][0][prefix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG2;	\
-			uint32_t r3 = adev->reg_offset[GC_HWIP][0][prefix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG3;	\
-			uint32_t grbm_cntl = adev->reg_offset[GC_HWIP][0][prefix##GRBM_GFX_CNTL_BASE_IDX] + prefix##GRBM_GFX_CNTL;   \
-			uint32_t grbm_idx = adev->reg_offset[GC_HWIP][0][prefix##GRBM_GFX_INDEX_BASE_IDX] + prefix##GRBM_GFX_INDEX;   \
+			uint32_t r2 = adev->reg_offset[GC_HWIP][inst][prefix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG2;	\
+			uint32_t r3 = adev->reg_offset[GC_HWIP][inst][prefix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG3;	\
+			uint32_t grbm_cntl = adev->reg_offset[GC_HWIP][inst][prefix##GRBM_GFX_CNTL_BASE_IDX] + prefix##GRBM_GFX_CNTL;   \
+			uint32_t grbm_idx = adev->reg_offset[GC_HWIP][inst][prefix##GRBM_GFX_INDEX_BASE_IDX] + prefix##GRBM_GFX_INDEX;   \
 			if (target_reg == grbm_cntl) \
 				WREG32(r2, value);	\
 			else if (target_reg == grbm_idx) \
@@ -176,13 +176,13 @@
 
 #define WREG32_SOC15_RLC(ip, inst, reg, value) \
 	do {							\
-		uint32_t target_reg = adev->reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg;\
+		uint32_t target_reg = adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
 		__WREG32_SOC15_RLC__(target_reg, value, AMDGPU_REGS_RLC, ip##_HWIP); \
 	} while (0)
 
 #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \
 	do {							\
-			uint32_t target_reg = adev->reg_offset[GC_HWIP][0][reg##_BASE_IDX] + reg;\
+			uint32_t target_reg = adev->reg_offset[GC_HWIP][inst][reg##_BASE_IDX] + reg;\
 			WREG32_RLC_EX(prefix, target_reg, value); \
 	} while (0)
 
-- 
2.39.2

