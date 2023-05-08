Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D95C77B75
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 10:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA9810E1EE;
	Mon,  8 May 2023 10:20:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C7110E1EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 10:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJCZZJ3/kM9neP5mLAG5rMowQd3omuCLo+YUO2r1Abc4mKtxSLJsLxavbV36ipO49cs30V10kJ2HajMhj0+138fpM+eiHn3bvgQPuca3jUneww2EYF8/YQljp8cDY0FYXRCYe3MazFComPS+nSZCeR52waAxWZWw3ecCIM5WAxpwqBreztHaP5Z9EbQ+YGN9BqUw9PnAZACveVhqhXRk7sEiflH9e9w/Q479xuOtlA49E/cxBqf1yjFsi6vdxx+5q4b5YujVK9PyF3Ouu5rh2XZFe8HSQqvfUMhdlMsKAlLoah2lBKQGMg6vGFpFxcUEp04mwaYkz16YKp7AL9xNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9lii9ev3s/zSrXHsHfDJFdAcoGm0nxuv5PTjKovSSg=;
 b=RgWzzmUx4I+Cqqg4IZh2rZKUSNRwbkp/dopEDVaRUvnaVsRHME0pzk5wmUIcgRcMZIu5u/qXR7hJtcul0BK5Hza/W1YseOAOokiO2WXRaRU2Bw7yls82zr9HxvuODzVcM7kVh5MTpvnoRQfD84wCmBHnyHw8PBpkHqqzVStgWqZ7IgvZrVJu/1hMUiFTxqmOtBQOy0rmUZJiwHSYlLrZJUZUodcNa9FYpW8HzT9fvfG9b8QV6A95u84lbkOTB7YlxsW7/yMuSfLxBNX9socp6g3oUd6KbtiLPVLXfxJaBPsLjTJBJ8GQHmqLd4aDUBoXQu9UZWER7RukAYwplDlSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9lii9ev3s/zSrXHsHfDJFdAcoGm0nxuv5PTjKovSSg=;
 b=z3FLJSkciQZBoRjSUTmeZbMfOe+E6W1htzlZw+SzHt97e1HYo8vk0wQbWgJTrJhYkrUo3osbN4Wk6BRmJWE/qe0ISlbkSkK55cFTGv1gbHcIiUIdlTBkMcSQxY/ekecLxUEUGbSeTREwCBEeHRwjflCOmgdfOhSLlMeuaJKiRyk=
Received: from DM6PR08CA0050.namprd08.prod.outlook.com (2603:10b6:5:1e0::24)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 10:20:07 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::74) by DM6PR08CA0050.outlook.office365.com
 (2603:10b6:5:1e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 10:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Mon, 8 May 2023 10:20:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 05:19:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 05:19:35 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Mon, 8 May 2023 05:19:32 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Date: Mon, 8 May 2023 06:19:30 -0400
Message-ID: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 500bcd85-d777-4996-dde8-08db4fadcbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQ4PMsXusH2Fzy4NjW5Yop+8DRZLyKlzEm1uGZWpPh6ZxN86ZMg0N9qrOVEv2IG6EaO5jj0KEaVU1ibFNdOpLQa5mVnVYZn/P1WuJJeOon9HmglU8BO1C5v8YUHEMoIxKKgz/JxnZtSdeVBsR5qxljKrFBoOxQs0spYBZ43fhBk8wSlwXnEbm6UIQ/tmCHKrxwlqDHiA9IF2nzZnC+uh3pHXbl8pAua0AgcsAgQYf/FpxC/BN6mPon390he5uUVRW6EF8kSAT8cDUAlHsBSZZ5ZQs+ZZkB7M3n2aqtqwxfYnwsJUp+Ow9XCfZ2DguVKxizqIPjCJvta+h7VQ0fH6uD2UmB9/X2VdBbuHh29bmwZ6CiA6D1br/ktAxd37LTPFOsukix2LsP5MdAb5FwS4fr4lptkltPjGzuXgJgaTB6QrtUpNgj+P5vbdkxvHhQvbcbrRGP/lBnYKDkQQSei4wcU9Bwd8L1TRepNAG0/Ueq0UgiD/e8igbrC2jy4ePUj4f9eZCO3BIPMayONsZ/zZebwpfBc8H5RjeG3Jyq26Y/0pc+WDFTWxhdNMZ4CiGpSGYF0+0PuBdZZFdbVihM7S5szCTGY1kR+Q3KxqXgPLPPRQzwe6yfKNPgB3y8jkzttdJmggG34SAhFnEyUJhmQOSxriek9Jeglfmn9+dg5uLQTaq9A8iFcngVX7vljDMUA3RpLjvKy53mptVzgz0SIE72mRa3cUuwno+4iyMNtBVrY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6916009)(4326008)(70586007)(478600001)(7696005)(70206006)(316002)(54906003)(86362001)(36756003)(47076005)(336012)(83380400001)(36860700001)(26005)(1076003)(2616005)(426003)(5660300002)(8676002)(356005)(41300700001)(2906002)(8936002)(82310400005)(40480700001)(82740400003)(186003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 10:20:07.0462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500bcd85-d777-4996-dde8-08db4fadcbdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
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
Cc: HaoPing.Liu@amd.com, Horatio Zhang <Hongkun.Zhang@amd.com>,
 feifei.xu@amd.com, tao.zhou1@amd.com, Sonny.Jiang@amd.com,
 Mario.Limonciello@amd.com, Leo.Liu@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During the suspend, the jpeg_v4_0_hw_init function will
use the amdgpu_irq_put to disable the irq of jpeg.inst, but it
was not enabled during the resume process, which resulted in a
call trace during the GPU reset process.

[   50.497562] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
[   50.497619] RSP: 0018:ffffaa2400fcfcb0 EFLAGS: 00010246
[   50.497620] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   50.497621] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   50.497621] RBP: ffffaa2400fcfcd0 R08: 0000000000000000 R09: 0000000000000000
[   50.497622] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99b2105242d8
[   50.497622] R13: 0000000000000000 R14: ffff99b210500000 R15: ffff99b210500000
[   50.497623] FS:  0000000000000000(0000) GS:ffff99b518480000(0000) knlGS:0000000000000000
[   50.497623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.497624] CR2: 00007f9d32aa91e8 CR3: 00000001ba210000 CR4: 0000000000750ee0
[   50.497624] PKRU: 55555554
[   50.497625] Call Trace:
[   50.497625]  <TASK>
[   50.497627]  jpeg_v4_0_hw_fini+0x43/0xc0 [amdgpu]
[   50.497693]  jpeg_v4_0_suspend+0x13/0x30 [amdgpu]
[   50.497751]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
[   50.497802]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
[   50.497854]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
[   50.497905]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
[   50.498005]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
[   50.498060]  process_one_work+0x21f/0x400
[   50.498063]  worker_thread+0x200/0x3f0
[   50.498064]  ? process_one_work+0x400/0x400
[   50.498065]  kthread+0xee/0x120
[   50.498067]  ? kthread_complete_and_exit+0x20/0x20
[   50.498068]  ret_from_fork+0x22/0x30

Fixes: 86e8255f941e ("drm/amdgpu: add JPEG 4.0 RAS poison consumption handling")
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 77e1e64aa1d1..b5c14a166063 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -66,6 +66,13 @@ static int jpeg_v4_0_early_init(void *handle)
 	return 0;
 }
 
+static int jpeg_v4_0_late_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_irq_get(adev, &adev->jpeg.inst->irq, 0);
+}
+
 /**
  * jpeg_v4_0_sw_init - sw init for JPEG block
  *
@@ -696,7 +703,7 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.name = "jpeg_v4_0",
 	.early_init = jpeg_v4_0_early_init,
-	.late_init = NULL,
+	.late_init = jpeg_v4_0_late_init,
 	.sw_init = jpeg_v4_0_sw_init,
 	.sw_fini = jpeg_v4_0_sw_fini,
 	.hw_init = jpeg_v4_0_hw_init,
-- 
2.34.1

