Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10425C27C7A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 11:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F70E10E449;
	Thu, 17 Aug 2023 11:08:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 875A310E449
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 11:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlelwOjhXi8Gb6Fe3z3lUA8BY0c7e7V8BaB3OZwMplc7SP4/sA6c1Ztvm6s7HL989f6W9LK6DtYKlaWniL/sbO8AyFjNROOYHgMiExl/e96Sza+HiQdgUBjnQnQj2OaKcXJGKpRGkLt70HVWlr8drLBxyYuAXPzq9aOrF+vg4xjxgcUfLTgoIdut0HS5JkA7uwZHYmyrDEqjiY1YEpsbTs0EOJkgWO0+cYRnzHls8V18adEFNLyhkKZ3z3FzPiuhLe33AiZY0i/cnLU66Aqnu/cFPiA9lNNRcC0HQUtK1OwfmyaZ2govRqCwr8yxDvldb9aNOuX7CPGboQdaf+uCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFwz0Yd1Yw+4wXZwY8Ig2UU2xJGYGkWDuokjx+bBMa4=;
 b=YcwnTVfuf4dfdVqw3O/gHXMHND0/v6BJTvTwfxhruUCcECIM9HxuX9sb3vNLMAcxvVyCe56LheUHsPHmJUo4K9esYjgltcHEZ9xi90FDgCAvvfC8zmujR/qxyJRksAohDaOQceFQj6MtWXjZiPIALR9w+yghkVBYBPLSYL3P2q8Y2djCSx3JEloLb1hQwSZf9eubN8zm7SKax3Tv3CTfoO6gNhsXV7FOByLHxPzCUkOzpNvlR2TQ4rMVH748MGvbbRbSpz0Q7wHK7GCpwHhKZO8yYwLoCBCt2eiQy3IswkCZl1D/TGrHVjbb+P75Fc7n9oVOyLrCjWi2oNMjADAw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFwz0Yd1Yw+4wXZwY8Ig2UU2xJGYGkWDuokjx+bBMa4=;
 b=EQzNM2NnzkPbUENmWLnSrvh+IsbjJJJm1RFSN51bMI3cKuG27+miK9BWMNm8ZeCJ+Wk3cv4+kSeGM+hSokzDKHtXOlYusYbqqelrGETzRW4qIGZ0fxw2cRSCQYC1wMzlwu+gTqC+4DkOk4w4oWun3OCICeBC1iTVRuj25hddKWo=
Received: from SJ0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:a03:2ef::32)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Thu, 17 Aug 2023 11:08:23 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::47) by SJ0PR03CA0207.outlook.office365.com
 (2603:10b6:a03:2ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 11:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 11:08:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 06:08:21 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via
 Frontend Transport; Thu, 17 Aug 2023 06:08:18 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: use correct method to get clock under SRIOV
Date: Thu, 17 Aug 2023 19:08:16 +0800
Message-ID: <20230817110816.2837-1-horace.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 30651521-7631-435f-c724-08db9f1245a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +soonZ1wfT0Qu4ggg9U27nUXBI1XrqZya8HLSxxWU5ikNY3mgPRriSJ7yWmSPqJHqYkc2YMbPVjeDW/PzHoGLCmnFeauFqXsjpYuFC1H8HsVdclhVB2Nyw3HhpkgJx/wgkcgT603YRTCX8+abFTJBv/9iepWNPqZvmnMmZpqLinhBGj5OxzpBvV4Ybb3C/Jb+OfE3hii3GTk9Ih9KEotHFXAQpEbyB/CLLGzvL0mbDvlIX/2W1wOiPFvziKDcKJG5jz1SHyPOfcLiRn7E0mkXgoscj1mq9+xWy5ZrKCEHiVyBf12+8YPk+dX6gFxU4sflEc4HZx3jBUDUmVAE2jcM5Dnd/7+UHbD6MRzCWBBcmShAZzS4u/qJX+CsubbRrxUZQHyhBG6NVOKn03wJaDjJMKbCXfllG0Rx4Z/BAFMEJoxrspMnX0Jf3sfYrIUZtpmwR4pPf2GnuJ7eITdokMf0sUMSW3ApKxrQ/f4w+k8KRtTXC9/uM7MROkOcwfauTgUlKvFcYPzKRujRrY39RJXO+Iqwu1JMbTLcVLiQSnKcd2Yq3XHe6C6+ZwApsyZIa1VxKYb+oSrQbaK8RiJYP/Yao9vzakQdCnpxQEoqJ2f9fI9gfpv49d3aJiMTXGkQ+zwPK7jMDw+8raJRlI9KXMm0kgOnDKK+H4LhKrDHYR1RSMG8u0PKm7VT8PRMCDdaitKTwXl2tRAvq20wt0/zHAkV3LZtLaLiBsDZATeAIEbgyw6RwlXWpOxFyusAVbWmf4pIOsJ4FpD3xwZUtGEoh867g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(6916009)(40480700001)(40460700003)(70206006)(81166007)(54906003)(316002)(82740400003)(70586007)(356005)(478600001)(2906002)(41300700001)(8676002)(83380400001)(8936002)(4326008)(5660300002)(47076005)(336012)(7696005)(1076003)(26005)(36860700001)(44832011)(426003)(2616005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 11:08:22.8633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30651521-7631-435f-c724-08db9f1245a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <leo.liiu@amd.com>, Deucher
 Alexander <Alexander.Deucher@amd.com>, Haijun Chang <HaiJun.Chang@amd.com>,
 horace.chen@amd.com, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[What]
Current SRIOV still using adev->clock.default_XX which gets from
atomfirmware. But these fields are abandoned in atomfirmware long ago.
Which may cause function to return a 0 value.

[How]
We don't need to check whether SR-IOV. For SR-IOV one-vf-mode,
pm is enabled and VF is able to read dpm clock
from pmfw, so we can use dpm clock interface directly. For
multi-VF mode, VF pm is disabled, so driver can just react as pm
disabled. One-vf-mode is introduced from GFX9 so it shall not have
any backward compatibility issue.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index df633e9ce920..cdf6087706aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -442,9 +442,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 			mem_info->local_mem_size_public,
 			mem_info->local_mem_size_private);
 
-	if (amdgpu_sriov_vf(adev))
-		mem_info->mem_clk_max = adev->clock.default_mclk / 100;
-	else if (adev->pm.dpm_enabled) {
+	if (adev->pm.dpm_enabled) {
 		if (amdgpu_emu_mode == 1)
 			mem_info->mem_clk_max = 0;
 		else
@@ -463,9 +461,7 @@ uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev)
 uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev)
 {
 	/* the sclk is in quantas of 10kHz */
-	if (amdgpu_sriov_vf(adev))
-		return adev->clock.default_sclk / 100;
-	else if (adev->pm.dpm_enabled)
+	if (adev->pm.dpm_enabled)
 		return amdgpu_dpm_get_sclk(adev, false) / 100;
 	else
 		return 100;
-- 
2.34.1

