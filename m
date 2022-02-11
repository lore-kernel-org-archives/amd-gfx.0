Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14851C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 05:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E4010E9DB;
	Fri, 11 Feb 2022 05:39:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D659A10E9DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 05:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrOACsRN/949FV4S2oH3QCdqc4WWNu84hkpfjCZhlXvhVjyyEzIADnCnZWY0JYQqrRZWum8bEQHzWcgNyq53S0y4N9OWQRNxW2DWmnW1yRa5mse6y2z7Afk4k86IIfpOU0hjsd2ankeUspIzskq7IXwC9u5w/YnGa+Smens3Q1s4UCl1d7GMAkqvrTAUQHKFsTxjOoWHjXeC06unWOOQlr6ZRRi/kS7eDGxvQNqPn5WW1Ns+vVbtOOuw47UuFi3iexwLZmUr10lDixc9GvsdpUSmA2YhSRcVSNlCezPxVvHG9t7+nZUxUOtWlspQQPjs8FS33ZCk888zqSoX7YIhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zicpxh0GoLJ73sV3QZCrmCnne8IqUfBdNnV6MPZCpVs=;
 b=V50gPWRvK19/aKndUXzymimVxq61Ka0UVFUr68fd0Fhkj8ufp6FcRfi4w3m8G3guneIJt6yNYfjP6J3ICs0vH4XeDGQyYXVh78Ciy/xqmHJqTmjgmzea4LBKWDCbe983NuFCTZxtPOHXTg+11PGimiMyt8XtPwTS/r8MJudLzNdaTZqn1RJFuOTjsEkTzXNKOM2Dk0E7MZHKaZXRd+wljIMiwBJ3DiDV2zUwO0x1sgCUGo+gzh6yebHtGCcGsAI9CCgmVdG9GTrSvul3e19m7H0Fvy1BDw50UK6AU8Q3uKvhOyhY3uOWKHDSpZtAF/7rUjTQlzW7KB6lExbNii48aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zicpxh0GoLJ73sV3QZCrmCnne8IqUfBdNnV6MPZCpVs=;
 b=DTQKp4njACmaCpV+GqfUKF5yHaZoejI8HNUY93yyDwc3J7dFliF0jOgOMCF4aaJ8cV4ahqvqE0U0VyCnhrtotzHgVdB4kIdY1ps9VATGyH3vGnaCj93tnnd90hmIEui4zzafyQgn/EzZp0ZGTc3d5seBhXDC6GOQjVALwTSisIk=
Received: from DM6PR14CA0041.namprd14.prod.outlook.com (2603:10b6:5:18f::18)
 by MW2PR12MB4666.namprd12.prod.outlook.com (2603:10b6:302:13::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 11 Feb
 2022 05:39:37 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::6) by DM6PR14CA0041.outlook.office365.com
 (2603:10b6:5:18f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Fri, 11 Feb 2022 05:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 05:39:37 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Feb 2022 23:39:34 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <pengju.zhou@amd.com>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case
Date: Fri, 11 Feb 2022 13:38:56 +0800
Message-ID: <20220211053856.31729-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38d82703-b146-44dd-ea0e-08d9ed20e451
X-MS-TrafficTypeDiagnostic: MW2PR12MB4666:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB4666EE573F8DFA6FCFFAD65EF1309@MW2PR12MB4666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDU21bIqqJK+RQefkXvOi+IaGmYZ/6ONKVpJzhL+dPmi6CWuLaF1hrU3datHLXK0GfbXciBb9ZFYSLAKprP+zJsx3OjTb7oaq9NTpgCBu9DmvVd1wJw8XGSDeO7tBl1oSj+/K3EIGGboLE4hy4EYkHRIFh698vR1QLYYmEZ7I6NMzH7Rub6gpaVp/q+FWhyZ7BETGSioWHTrIIf7ljdK2KgGYDih3Q4clohu2f53KYQ1LnJoYvYUnmVUTkfpHcfj41/EiC8diF4Zj1aEJXbR/vSE3mLNP+Ky4by92CpAqthkVTGGcsNaVt1FTQGsYfVyVaIBZS/mUkXujrAffTpw/M1R4uvWPt8/NbcLYBJN7uXdyfVY4vLNvUlMhHKxzzWC7uEUE+rRfosxPGevcy2ph/ri7KyOWm+PC85l2lyOTpU/hj6fb5gQWIFhkcjFfGCyqyRhCLgnK++LTvwyF+g3ruFACSkGGr3FYSJcZs9u/oB4UsOKViJ2XdrBsxDhNeCTO/sEnrqvNsMpFK1j41fxs81K308FfGdAtQUedi/3tMzX5gUHwHq7NprlXIbWRWAjfbeu2BqNMC6490nDu2QJAEpPOCN9ZHikDKrNZHGkSMJWyrmF7iS//N0N67SOmtcRRrzoi9kZqoolvUbOODFx+C/p4uXGIOC/F9gbktUEUaDavawhz5z53FUIKfkHAi6THlD9whLsINYOKh9S544B+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(40460700003)(426003)(336012)(82310400004)(47076005)(8936002)(86362001)(70586007)(83380400001)(2906002)(36860700001)(16526019)(44832011)(6666004)(4326008)(7696005)(36756003)(1076003)(5660300002)(6636002)(186003)(81166007)(26005)(508600001)(8676002)(356005)(2616005)(316002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 05:39:37.3695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d82703-b146-44dd-ea0e-08d9ed20e451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4666
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

rlcg legacy read is not available in SRIOV configration.
Otherwise, gmc_v9_0_flush_gpu_tlb will always complain
timeout and finally breaks driver load.

v2: bypass read in amdgpu_virt_get_rlcg_reg_access_flag (from Victor)

Fixes: 0dc4a7e75581("drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx9")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e1288901beb6..6668d7fa89e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -836,7 +836,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 		/* only in new version, AMDGPU_REGS_NO_KIQ and
 		 * AMDGPU_REGS_RLC are enabled simultaneously */
 		} else if ((acc_flags & AMDGPU_REGS_RLC) &&
-			   !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
+				!(acc_flags & AMDGPU_REGS_NO_KIQ) && write) {
 			*rlcg_flag = AMDGPU_RLCG_GC_WRITE_LEGACY;
 			ret = true;
 		}
@@ -940,7 +940,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	u32 rlcg_flag;
 
 	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
+		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
 		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag);
 		return;
 	}
@@ -957,7 +957,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	u32 rlcg_flag;
 
 	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
+		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
 
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
-- 
2.17.1

