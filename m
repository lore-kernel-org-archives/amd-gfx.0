Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E15C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Nov 2022 07:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8953210E77A;
	Fri, 11 Nov 2022 07:32:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490AF10E752
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Nov 2022 07:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMKopJs1YViHh3Qy7LBP9eDsCIqeaKyjz856yDLOBCgwNxvlcfH2D9Md+EYc0NQ+72JW0aPSlEbBwtBKZ8Zc7oQSW8nEoc+T1eEURwDoSsto+Aq9sR5OqCc/SNus7oT+oyyhclHB0PGzu5ENVHqHQVIgbZLcJA2l87Y7ZOfcKA1GNZ1uUScT2KBpeFIhCDMBGzQIih0swXcvIYKATR2qJEOzXpBI3XgP8mziUelZQYcRbyE5iyxQZmTmvpJBPD0WOzUvYoiRurBcBrFV6d3oYkx/f2WSrf+pgYnokKzL0KPmyCXfYD95X73YUG3KE0+Af35vDB1vu4ia12nfMzWx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3InQv0ssfAbQIZ93/sb0tdR+kE2Yv+0EcidaqHAOzk=;
 b=kGrQxgVlNespOCjfFq03XXUEHQRatjfAivX2gb4CC/nbEHdWD6PCoR02azqAR7++DlWfkGgOMPz5EQcL6dKgroMKYnnz3PHnlCH2V/yn2GAM1ORaCC0DiH+MTEPJN3SFekP+GF8/EaS5bA/UNEqt+yd2HxTqIyxDVo1EOiqZhlHM1Yd0jGqDnmfQ0BcEkhiLrcD3V4ceKf8fQLWOyLhgazOyCcX1qJNCTpG2G4EHXXhQPlxYKG51nMdX41tVwulYRlPDeh1sE1jhcUjJbaw1czkCHtaYfS1JwlUmIvmigGe8nYk/8vRI+NsY1RuxR3bR2RQAQQLxEYrHkIKkejNv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3InQv0ssfAbQIZ93/sb0tdR+kE2Yv+0EcidaqHAOzk=;
 b=snu9qzqaKNHeZgGkRW/9bRJrkYYkiZmFwvvVZj5LF/8AE1/wWVsV248z7/bbgQaLy0GJAr1mZLU36/ZHnkjWDPCidhvAwYpLQyPcrI45wbADZn41jVilGw9x8ME/t1uUrqDuJnl1RZEhssXGXVa49An8fox+lfzz2GBGkezTnS8=
Received: from MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23) by
 DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12; Fri, 11 Nov 2022 07:32:02 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::e6) by MW2PR16CA0010.outlook.office365.com
 (2603:10b6:907::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Fri, 11 Nov 2022 07:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 07:32:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 01:32:00 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 11 Nov 2022 01:31:59 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Remove programming GCMC_VM_FB_LOCATION* on
 gfxhub_v3_0_3 in VF
Date: Fri, 11 Nov 2022 15:30:51 +0800
Message-ID: <20221111073050.3469773-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|DM8PR12MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afe483b-4c7b-4d81-5e0d-08dac3b6d32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luPuv/9w4j1UZ0NazVSZGu40hVa43uGWMN+8cGn7Fx55ZzzuTxkdtIaZYZoF1Uo3xtD0VIvmnzxC0M9/aOGA7C6fheY9Cm7yWk+GOULUVNrs6/v+uvSny8zZsnGtHo69Y/5YsZ8LkC+ZpmcyszHGEM1yVhCfs+PCEZ3oEmWioWw5lUutROfQWbOq1TEDwewVUjbFSbcboLjnirGlPbwinDREK49ZEr+XRZR8g/98RbtnrqrLSiuu+3NcdlAV5u0bgZ2+5Av2YjKTj1f5hsYIYZ8K64QnkdsYzzyVczpiJxHORV/Dn5Q9Qt6FAsS2c+glOxKjda4jMhFRDf1Q3EjwQxGiksUsqzeV9UbZbgH+nxSMaZjpvE+EkmhU8SZGk4xdqm+ShceXwojEFaIiFdy6RiQ6DrCwAQhXVoT3ZSmHpc3XLT0Uqx2u9JSvAN1XZf0fpHjz8d8di8DtET3lU7i2g9aQgZXiQ3E33MAs5W60QoGma9F9O8nyuS169oov4BK2v4Hqmx6XCs7BaIkdjEe+6geda6Do8M+A88rS1tXErH+FGMm4Jw7Dyj5RiHdF5ljcA/AhDniDn/TpTnkw9uheHQ8j8JEOz4QY0b+GmqmvdJWOTNV7SGk9/8BkhdeATNj+kzDroReYiLjE/2RCQDbVMioWRdo3RVj3IW/zWRTpwuYhEKa8QgmDm23R5mDb/V2cF2j2+hJceo6Q0KW5veyhW1XC8jgWY6kEjVZ9U9we50NiSZCDTomsHyF8CrR6RsjS6lp8tqgQZsDdv1YEAnEGqQZJJZ6C1KE9orPYv5sdpHAuNW2w+TpajjY+5XU67Md4ys+dnzb8xDLzLu+iBBe8IA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(47076005)(356005)(81166007)(86362001)(426003)(36860700001)(83380400001)(82740400003)(6636002)(40460700003)(110136005)(2616005)(336012)(478600001)(54906003)(316002)(1076003)(70206006)(70586007)(186003)(40480700001)(82310400005)(5660300002)(6666004)(41300700001)(4326008)(8676002)(26005)(8936002)(2906002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:32:01.9304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afe483b-4c7b-4d81-5e0d-08dac3b6d32c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
GCMC_VM related registers should be programmed by PSP on host side.
L1 and RLCG will block these regisers on VF.

[How]
Remove programming GCMC_VM_FB_LOCATION_BASE/TOP on gfxhub_v3_0_3 under SRIOV VF.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 716ae6f2aefe..080ff11ca305 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -357,18 +357,6 @@ static void gfxhub_v3_0_3_program_invalidation(struct amdgpu_device *adev)
 
 static int gfxhub_v3_0_3_gart_enable(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(GC, 0, regGCMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(GC, 0, regGCMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v3_0_3_init_gart_aperture_regs(adev);
 	gfxhub_v3_0_3_init_system_aperture_regs(adev);
-- 
2.25.1

