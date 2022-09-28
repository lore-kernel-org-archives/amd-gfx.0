Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BFDC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 14:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E41C10E2F6;
	Wed, 28 Sep 2022 14:50:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A71410E2F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 14:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT0r/xE7PloIg1aeVGq8MSwcwsCmSYnkpVF4vO3IUsSt7E7bMlXbq1CnOWZexEWlUITKub0LB7LTJI/ZvS5yfTzTztJnj7jLUlhb8mB3k8t2GGKggYXv2g1216b3Wmb9+dxIv9xnZv15xCn9x+Qze9AMhOOYdKAEHWQSpFD/Vciscyl6PzHhEPfR7JdBufYICHMJMmSSz8TPpDDYuhmIB8WBwA0FDaPT1hhS2d2miLpVtMcZMEDh0hMP3ZfHXI2dZ2AdvmNnmoHhaL2HnQ7M/sQkiiC2FWeDrdlyPZuKbEY01LZZ4Y+DIyRIxot28qMhg3v2gwjYBEyQqH/vMXPibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivJI+NLdg7rjsiNnJmAL4kZhwlYoPTbesiQ3nD9CwBo=;
 b=D8ThMFpuFYlLddMqQMTOUeuLXvvxz9jdNO7Fry6JSr9o92EF5h7YUn+ug7irezAhG2BED6MTvSTPl+mDnnzPgc7pE+I8SM8bCdyovVoKnv/mk3yz1Vite5ZEA111r7CDKL1ExRKufPmeZQsfiK6jaHHXR2xcoFFdpgJ8RwW4QtNvfyZuU/RSOq+RVoThuK192WbvSP2mNS0a68Axqep6svJTIt7fAQ8obby8OwpZfbstlxts0L9cxieRbPsNqSPiIoXFN3HyQR5TzLQhIbbwJC/Ha33xeGnU/uEcvvIax8e2MgpH79rLscRjJDhTmwStXg13teg50A2FpkXfmXioAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivJI+NLdg7rjsiNnJmAL4kZhwlYoPTbesiQ3nD9CwBo=;
 b=vtutxyg2SLgmCAGM0oPWBSCe1m8avJrgJZ6ynJaznPekoyz+Ugld5eebCWecW/ANTT28LQZFxf5Y6uK7XfHXtKBrz5/uBOt7zLkAbqNXFbKqkaT9U9x8hg7rP5xpl1vwIV2CdQVvWJk2Ym2qY+/H8BVL79CYLIaorF7jkSI5O5A=
Received: from BN9PR03CA0334.namprd03.prod.outlook.com (2603:10b6:408:f6::9)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 14:50:15 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::bf) by BN9PR03CA0334.outlook.office365.com
 (2603:10b6:408:f6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 14:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 14:50:14 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 09:50:13 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix mc_umc_status used uninitialized warning
Date: Wed, 28 Sep 2022 10:49:51 -0400
Message-ID: <20220928144951.89514-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 9513228e-9bc8-4234-9248-08daa160c0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6htOf5Awtzn0Ixh/ylL7sA0sASmadzLY8CagIFalFQDLM+SDaC7+mcm/AVrq1YU1swyCm7odrR+3rvnxiS4UeVb/NXsoLYadkMCthSJklA3aJJPzGPxoIi1JsxinCEkhNbVluNj0oG9zrJTp4qdHIy2z/3iERFovvC9FyfJihOoMzp8t1Id0YDksJ6MeEGic68rJKbbx6iQo6ZLqk2lqhxf/wZT5T6G0eRw5Oly4y2BrNA8e1NgUDxmfmAD3nR1dC3H4rxusHTzVVrSLtm8aeJM2bdX59ApPEohrwHrRi+fXs+qZ/AF0ZsW0IM9E6ICTvaY41PIVVopcNR9GVHZjhy+geSPF1uTnpmA9Gnn85+4Uv5g9sV8p4jGlwGKAGEDUj+GT9enMJlpOOuW2xb38ttVH1VzTZYRtiTci+FruCWtdeuoYgI6qjzh7/5QEfZq88VQk4FytH+Mfo0w/uqqb0TT1fqmoED72ER8VFf02t+GLSSxen9WqmaAbB+rgndfRsPNwgN5W4enSydEG2mFbsX6MFsh4H1AyJb3CEw5WeCL2qnd+uf/2NMdW5tmmRsAFGKdbnTnQFvUoGtfg9NdbTyduJYMqv6mSIGq1hBKtavIDwGMnGvLdUJZCfMniZq/kuc63ln6x8krWcmtcVUhxNO8YEcPgDh8wGr93EYzfzs8P2cW/TLom5WMzKzx44OUdCBEXo4kK5ORSaABGCyIjo1AcKlC0l54r1h+cYkY9VXBdRcb5JFJxoaxnKxsMVfD6hOKZWP1CBESR0QmP2uaqZINK8GP2NGI8/cuwWXmIeDcIB6FN3SeV+Aj27r4OwLUU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(356005)(478600001)(2616005)(5660300002)(426003)(41300700001)(316002)(6666004)(47076005)(81166007)(70586007)(6916009)(70206006)(54906003)(82310400005)(16526019)(82740400003)(2876002)(26005)(8676002)(83380400001)(2906002)(186003)(40480700001)(1076003)(36756003)(4326008)(36860700001)(336012)(40460700003)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 14:50:14.9981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9513228e-9bc8-4234-9248-08daa160c0d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
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
Cc: Leo Li <sunpeng.li@amd.com>, tao.zhou1@amd.com, Rodrigo.Siqueira@amd.com,
 stanley.yang@amd.com, harry.wentland@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

On ChromeOS clang build, the following warning is seen:

/mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:463:6: error: variable 'mc_umc_status' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (mca_addr == UMC_INVALID_ADDR) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:485:21: note: uninitialized use occurs here
        if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
                           ^~~~~~~~~~~~~
/mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1208:5: note: expanded from macro 'REG_GET_FIELD'
        (((value) & REG_FIELD_MASK(reg, field)) >> REG_FIELD_SHIFT(reg, field))
           ^~~~~
/mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:463:2: note: remove the 'if' if its condition is always true
        if (mca_addr == UMC_INVALID_ADDR) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:460:24: note: initialize the variable 'mc_umc_status' to silence this warning
        uint64_t mc_umc_status, mc_umc_addrt0;
                              ^
                               = 0
1 error generated.
make[5]: *** [/mnt/host/source/src/third_party/kernel/v5.15/scripts/Makefile.build:289: drivers/gpu/drm/amd/amdgpu/umc_v6_7.o] Error 1

Fix by initializing mc_umc_status = 0.

Fixes: d8e19e32945e ("drm/amdgpu: support to convert dedicated umc mca address")
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 2cc961534542..a0d19b768346 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -457,7 +457,7 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 {
 	uint32_t mc_umc_status_addr;
 	uint32_t channel_index;
-	uint64_t mc_umc_status, mc_umc_addrt0;
+	uint64_t mc_umc_status = 0, mc_umc_addrt0;
 	uint64_t err_addr, soc_pa, retired_page, column;
 
 	if (mca_addr == UMC_INVALID_ADDR) {
-- 
2.37.3

