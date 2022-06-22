Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7243CCCA47D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 10:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3CE210EB1C;
	Wed, 22 Jun 2022 10:07:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CA210EB3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 10:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0tCNrAB9GYP/5kX+6HpvZ3u9trg07ckP4u0GqfLBVFAe7ZQ8laof5houXgwQJ0oTlHRDb6wpNoVx1vUxArhxJfPvmAnPIOuc7g7VANkgWcIy9hXqdPXPzC1IS0J7nzhOr1pt13Tfoseajwxk72pRvC2LKWf89ogKpRsuQC6GAJTUct75NCAYADv6VvstCCK23pHmHHYMfebJmFD7nPWiyfug/Y8g0bL8JLWug/gwzGa2FchWzB2n0FSBYk2Fyif/TzULwr0UdT5dFgqMH0kCAQ1SX3BmyP7fI8jwPzNHnRX8mxwmA6yYa7BZqxvB2TsXxb1iuWaA4J3h3uDvzmEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7bLjivpOhn2QMNwB4gaAQQn7tYCkdG72CPIu4NBefE=;
 b=kDXMAGZdrM+F+bQwxaDj0xvELp6dUpdSFA9vwQFx6UtgEhSH8Ycm+ba7n1lVI4mpkqwB/bObEnIJz0QNKE2CL4G6TWIrfGFB5thPqF9j7R5XB5CqkKFEuEKhx+MDrAbQi3CeohqWLRMIqCoz+XI5WUFRM9njn46oRSysAMvONNCDsiwb92Lh45kAQq1kpYOtUK9t+QPm5RfKfcbiR/aFynrc9hJJXZOY4PBisKbTdRwtba9yLiR+Ej0K0jRriEBjByXybswkiAB/PcDalx3RKbQc4QTsTghCQYIbpNN/5sTsRS+hYRHybFLzksRq8xNBdZZwX9AFvbhbHON6nMh9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7bLjivpOhn2QMNwB4gaAQQn7tYCkdG72CPIu4NBefE=;
 b=NQdpA6sZJYey0EJNWVK5CCvRr26/xODed0Z5mqMI6mNozYS/IPSCIMdzuAYNItK36TU5j/ym6Z5fI+3ydDuUfavYfpDLHN3nS9M0FhHrCUjT21mvtAho6l0Dbi8TM0OdEHVcnigkHfYaj+VUhHEDXB5WUcbKScHrH11pdlHK5YQ=
Received: from DS7PR05CA0090.namprd05.prod.outlook.com (2603:10b6:8:56::13) by
 BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Wed, 22 Jun
 2022 10:07:44 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::da) by DS7PR05CA0090.outlook.office365.com
 (2603:10b6:8:56::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9 via Frontend
 Transport; Wed, 22 Jun 2022 10:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 10:07:43 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 05:07:42 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix amdgpu.vramlimit handling
Date: Wed, 22 Jun 2022 12:07:02 +0200
Message-ID: <20220622100703.303697-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35987caa-7acf-46ae-d222-08da54370c6c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4901:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4901C891AB708DC75D16B90E8DB29@BY5PR12MB4901.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/kyamYF4T0p44zJVbx7Vcd/Mo5dZpD+Msl3y7Bf5pN26H78gRtRDd/QhqtRIMsKw6u93TWjKetPPkt57rcDDnhh2rVYMpVToCcpdcqbGThrE1G/KN+WuirA8sqU7eJdkMrYLxNzqZuTeRmzKNOyK3EWbaP7zZraP/vgaJdxB32vbHFjAT6c+NsYsTu6FgDYwF90aO8Lu/3RrdVBWZGYRMEufTgHrT/+aeD82sceo5BBCKQpXW0fBUv11g3wEVbT4NPPp63ZbzxkeWCP1vS8YAyYFEYae2XnFd6GX76vC/PrUZHiGQS1MmAZREZCsVLBYTZvghMUfaLS8Gsb5ZuRPdVi1cj3N44yiXvZmNB0sVxHK8CKGcNjsuHzaM7thoV49NHIceE63s6O9yW8/OW9CND04gClL/xZNECw71xAnDTQcKiluX400coeCP3yiusdji6wdVXjM1MErBC9Dx5W5509xj+Eh2GajLiG7fpY/8YYedzrxlncG+SbSLkXk+D1xJE9+Gk2OBXYlzqsKEnEr9MERBxN3co3lcoLh0rWlBoD9RYvmPzZtGvKk2u9QW7TylzqETWeF2bvbc3G9tTk8u66AZi2AGXVCvUD7SGRlxQkzTXcAnwo5pTDAQ/YM2OUcSgJuCAGW83JxlRHq9g+2mP4D7q4Cgig98/kmQnb07f3a1HB3z/IVGsC0QBqszvZ5HC1cSww9W1fA/a3R9ZO6ZnPtd5wdH50lOkuglDCOnUNZJRzpOoT5vkfYFTFwPTXYAW0gpLYum76zrXFplKdRIGMD6XJTiGSsofloUl2fc0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(40470700004)(41300700001)(82310400005)(186003)(83380400001)(1076003)(81166007)(2616005)(16526019)(40480700001)(426003)(36860700001)(336012)(356005)(47076005)(82740400003)(70586007)(40460700003)(4326008)(36756003)(26005)(5660300002)(8676002)(2906002)(8936002)(7696005)(6916009)(316002)(70206006)(86362001)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 10:07:43.3645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35987caa-7acf-46ae-d222-08da54370c6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without this change amdgpu_ttm_training_data_block_init tries
to allocate at the end of the real amount of RAM, which
then fails like this if amdgpu.vramlimit=XXXX is used:

   [drm:amdgpu_ttm_init [amdgpu]] *ERROR* alloc c2p_bo failed(-12)!
   [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* sw_init of IP block <gmc_v10_0> failed -12
   amdgpu: amdgpu_device_ip_init failed
   amdgpu: Fatal error during GPU init

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index be0efaae79a9..952e99e6d07e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1621,9 +1621,9 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
 	memset(ctx, 0, sizeof(*ctx));
 
 	ctx->c2p_train_data_offset =
-		ALIGN((adev->gmc.mc_vram_size - adev->mman.discovery_tmr_size - SZ_1M), SZ_1M);
+		ALIGN((adev->gmc.real_vram_size - adev->mman.discovery_tmr_size - SZ_1M), SZ_1M);
 	ctx->p2c_train_data_offset =
-		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
+		(adev->gmc.real_vram_size - GDDR6_MEM_TRAINING_OFFSET);
 	ctx->train_data_size =
 		GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
 

base-commit: a81bcfc756bcaa9e8bb46262f910504fa5290aab
-- 
2.36.1

