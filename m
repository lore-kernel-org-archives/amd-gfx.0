Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A7C47099
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31250613BA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31250613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5E96F482;
	Thu,  3 Jun 2021 14:13:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449376F47F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 14:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdr/yiNhtkSgtR+HXgf9Kqvt+13hhZNF/pSiKvDDyRFCAdPNm06eomuG1z8loyPTdndnhBs50upAfSebWDIyqyyxdufkY7jOYPJm4TSzicMZ12cQ8EYyyn5CEP7ns0ZSGaT2+paXegz/RySgtctY+NuLkfhAC+nRZ0l7T4qz3kZvwTdIISruA6KsM/cYQyW2kZalw7gyKm8uErhaWM6PO+UrP7R0rIhT/tsfz+ahrw2Rt+F1drAVWFZNLm/IVYZqemOKz4BHt5Lu5XJdZ0TX+oKIp944wMvjHfXj8cjHqOUNBV693SF/pm70SGwrNUO+IWeUxFqXcTm3DvQ2bSmDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HZ4fiu3XS0HIaiQx2lYuxeLhzTfCKMlLKll5L9mCM8=;
 b=bpXzOH+35Jwg0xo4DEU0iEOtFa5JoVVATR1kmiQOIOOacvqZbFQ5JRLdNizMfsp/YHHUoFMjBkpmoJ7s7LNEPM5b99kbiZmG3qqywihum8xx7jfUcdD5y600orJYSf3b/pwBtD+JcY+t5aeWrqogrJyrxf+piYA5kguxte+mccTZ7oNCQ/6zufpIGFQ8kYMqO366KT/VpIm+bkzRtRMaLNej1qoz9aRmMXBCi6YSgclfbdGAWJzv9OMUoISL9EILzHxm7esfb5NVnmXjgmedLuepByEEhgoCZxdcOGYVI39amd6atA2bC7ibsATBdbX5dmcU2dVlHX+nM7eXHWx43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HZ4fiu3XS0HIaiQx2lYuxeLhzTfCKMlLKll5L9mCM8=;
 b=jdpQXK69JoIhOmpELDEyJ1deMyZvAmhtNHaKDoLxBIK/vBu2feHucXsCbnMEI3xNLcGLoMgIHADIYmzbbcyfHw4PgSIp2tRUDvKrfkIhj51/BrJ7udJr8POsAHMCC7eH0TO0ST06kxQFsoMXrhxa0joZ0m0wQEuqOLS7rWFH/mg=
Received: from DM5PR10CA0021.namprd10.prod.outlook.com (2603:10b6:4:2::31) by
 BYAPR12MB4984.namprd12.prod.outlook.com (2603:10b6:a03:105::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
 2021 14:13:32 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::ac) by DM5PR10CA0021.outlook.office365.com
 (2603:10b6:4:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Thu, 3 Jun 2021 14:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 14:13:31 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 09:13:25 -0500
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: remove sriov vf mmhub system aperture and fb
 location programming
Date: Thu, 3 Jun 2021 10:13:03 -0400
Message-ID: <20210603141305.2542-3-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603141305.2542-1-zhigang.luo@amd.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caa81485-b241-4bc3-8e69-08d92699c466
X-MS-TrafficTypeDiagnostic: BYAPR12MB4984:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4984DA5A030B0BDE5F5D9CDCF13C9@BYAPR12MB4984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjFHec2xUKoVQJPCbCHBs4Ov7oB3I1PzSruQLyD2qTYI/ZfUITVJKkwkLYjXDweVczatl4hEdoL50mxEPLpXwfnMLkIkxVvW4MIlsLL357AxGOTR05xUQNpyQknz+p/60jfyXQIAaddJpSk00FpJPCE8jGmMBJPCV2KFmO2VJ9ryywHEuPArAeNOppmXHOtllAHyoI9cgjB9un8AUz8o5LUERuBUIcUi1JbhNdDlROdku1jpMf2FPzc/kvJNvnGhDHMFEEr/deK/bGqWXvfeG22HKyKBvdj3bdXDeKL+2Za6ntdwcNBbNPs6hnk1kxE4IKBBXJ7Dlp0Oee3OxdxLOWnFNX25CJ3GU/sGw4Y3KxInvFDzCG4MOxxSL2wFOHS5UO4asL2T4NiBlf+uNzkT6wSebKIW+5sYvpZ8UhmlUNzWWD2+xamv1JPAwS+AEYJQx5TGJ3L0nwSNAt9mR/2yMza3zr1kEaO0zExERIe+wKKyqMrZJTBOyDWHZWsdPd+LBDgga2SZRC1lj602diG2Wgr9PkCY2sGuToPuvF5y3/MKQI4sjYmNcgJz5nDltPL18S/qqUesVNKGimk4fHiCRUW9Ho+K0Qh7UdZI02vG9WBtFxrtNNI73U50QL5+8Rg2NDHtTQUK0lhozet2Q3Doe+Yz6yavEleQujyK93pr4HO9K8q5VeAf0m5PHD5Y6aPy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39850400004)(346002)(36840700001)(46966006)(356005)(336012)(1076003)(8936002)(2616005)(478600001)(47076005)(2906002)(7696005)(316002)(5660300002)(70586007)(36860700001)(82310400003)(82740400003)(8676002)(26005)(86362001)(36756003)(16526019)(186003)(83380400001)(4326008)(70206006)(6666004)(426003)(6916009)(44832011)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 14:13:31.5714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa81485-b241-4bc3-8e69-08d92699c466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4984
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

host driver programmed mmhub system aperture and fb location for vf, no
need to program in guest side.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 998e674f9369..f5f7181f9af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -111,6 +111,9 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
 	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
@@ -129,8 +132,6 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
 		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
-	if (amdgpu_sriov_vf(adev))
-		return;
 
 	/* Set default page address. */
 	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
@@ -331,18 +332,6 @@ static void mmhub_v1_7_program_invalidation(struct amdgpu_device *adev)
 
 static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	mmhub_v1_7_init_gart_aperture_regs(adev);
 	mmhub_v1_7_init_system_aperture_regs(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
