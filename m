Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44567ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5068B10E393;
	Tue, 30 Aug 2022 18:40:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8485C89A1A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBioSNM+hE2ZE/byzDHsCkISoae6uX6RvoNldHbR+h8YkABVTuIJcBWLfI7fqCXvdj072RHbj+FTsAYBZbTBtDeThZOvFWUBCVp6TZVdPrEr9qcuAp7timJkYOjHQD77mcM6fwJv5pauWi7Nywjr3UWYut6p7ndVsiYnWKOgOJXKiudYwwrXFdUAlHduE3ltWaWh3ezoPfzKVnFj4sF7RxN3j6t7pw68hVT5aHDy0rnxNfBHUzONmgSUWpGhJHXkBd09aikX7QBac3x6FykBHrRVe2U/3GhPzpOUI0hlKmSwnXuIJ11NHR3Qm3N1BQDdXYCb/SLEWqiUNs4T7YuCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tr0hzICoEW/NNUxbZr6xoJEkfXZwAHmv8T15v9CADpQ=;
 b=JrjVtxqRWUQkVLHSa3DALoP3DVioX9s9b2ttKmQRjLwMFHz4Q1w6CFXxQU60KvLMgB5k0jeOM0/3gSrQd4AAxXPIdy4acw9DCnOBfhvxMpq6aoCNEaaItM0cXaGIawVPuKiLSFcaufiDlt+xOwiwpqbXH/q/+37DgxdlZQ0D/DD8+Jn7MHMgW1kMhAmGncgCzQhz2y8UWC4AgAsl/beTsNo4m/alhFqZVwFoUWsish1S9LjabFjK3AD7i98UKIDsDNEfXjB1UvF1pgwuNYwrFzoYhUpa34mevUJicX1Ii+ePO7L6LygEbINkrI28HI6WPbi2KCmnYWqqA4Mw0WTteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr0hzICoEW/NNUxbZr6xoJEkfXZwAHmv8T15v9CADpQ=;
 b=2p3zRX9IpmWA9NznKXo5tAejQi2tTTBcYGqGvWpBUMxAMjU/clijERUgdZG7DjFsoLRqsPY8jrpxA2pfgfy27s0rpWp+VN5UdnUFue4hiVF3JHrOREDJq196ULLVL68Q6YEFusIeDczJWw/VjukfHxMlQKFjdVXk8nnQd/+jiqg=
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by BN9PR12MB5162.namprd12.prod.outlook.com (2603:10b6:408:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 18:40:36 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::38) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/19] drm/amdgpu: Skip the VRAM base offset on SRIOV
Date: Tue, 30 Aug 2022 14:40:04 -0400
Message-ID: <20220830184012.1825313-11-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: be240d78-5f1c-4c99-3f20-08da8ab720bb
X-MS-TrafficTypeDiagnostic: BN9PR12MB5162:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocG4G3J2UMHBoP8XacsutTV8t2nFOhShMK0RoGRpgQCXDWXeTRU9hu6dcD27+kfC42+SBX96iG7UacpW8DznRXkN8qFVEZJs4i4mnH/K7rtZ7FCKcUwoqTkfS4IDw7DatEmvcr8zLUii9q98cWuTMezyrBUcjRoPKaLPWIpyDj8yYsQf5YeS6WW0JTEQGeP1E8vOwneSsnNgvH81/ZauQkoLpMOuhbJCBMEnn8gvQrvSiK1udHdzz6LlQtMzqeO1uy7vD+W/VFDmsHfOHjO5syV/tY+jhUOMjS2oasqHlmA/HzwgvywOHebMdY18DgUDoQGOOTztqD+2m9M+GWWyWjS07jc5x+pqq4TCkx8OVAeRVbKnzR/g3DqE1w+HuIhcanFHD7Ng/PyvA2rbvD+rWpNw1dJO5kvd2SdYpZFO2wGQ0ZeVwoxK8wIs4nkP+rRCW7UCpglMSYioOLruUTiA2bb5cFdVBa1+xln9BKKOlDP4EKsfNZ/Cx6mrGB8tL9SmZjMFS1QBUqMvDWN/kLrq2DfwNE7AxA+TkLS6q6PNKxJz1fvaiV2+cpCtdWsxtwmVMZJXKMg/2DhsypC834TPfxhCClBB/I+N8trmZlfoozpYv1dYDWdqSiP1EMAeWNTeOwrA7Fbc+p4gYo8JTJOqiBS5dDryYAxRY1t+hDdDuTpCtwcpbhuJaj0F6cqWLxp/6nKBLwXJBIYkTxK+0WhdL6Evs+mwmAVUDo82WlTfR1ngTOKkFD0HomDrYZW1oKpKIsRE3b1IG7uaE+reTCl2RJeQkCl9b4LYlkcrP+yyE+jEYmnzbEr2rqQtGDuXKGsq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(316002)(70586007)(70206006)(8676002)(4326008)(36860700001)(86362001)(356005)(36756003)(83380400001)(16526019)(336012)(26005)(7696005)(478600001)(6666004)(41300700001)(6916009)(82310400005)(54906003)(40460700003)(40480700001)(2906002)(47076005)(186003)(1076003)(2616005)(426003)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:35.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be240d78-5f1c-4c99-3f20-08da8ab720bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5162
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
As VF cannot read MMMC_VM_FB_OFFSET with L1 Policy(read 0xffffffff).
It leads to driver get the incorrect vram base offset.

[How]
Since SR-IOV is dGPU only, skip reading this register and set the
fb_offest to 0.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 592729cb0f48..846ccb6cf07d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -649,7 +649,10 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_gart_location(adev, mc);
 
 	/* base offset of vram pages */
-	adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
+	if (amdgpu_sriov_vf(adev))
+		adev->vm_manager.vram_base_offset = 0;
+	else
+		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
 }
 
 /**
-- 
2.37.1

