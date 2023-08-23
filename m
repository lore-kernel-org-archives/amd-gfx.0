Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1EBEE49AF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 07:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484D610E254;
	Wed, 23 Aug 2023 07:16:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE93B10E254
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 07:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5MuGlz64NTTZBR/o6d5KwuvtY1xPofWnC03TNelZ0OShMQ08KrKGEZm7CN8/FTOpysRoB70hnvVEvPZnQKu3FncRudDVlUOkPAILLsm/Yc+ftuFGKdXdyDFpXupJpTr2wlphhe7fhKu9lGVU6vkxz2924wNv0JKBhadHwYlQ7L8Np5dMJ31CZRIOFnCL4bVBPCUzEYNcfnt0ivjzoTtfXB3dllIxN7iLTTehj4Y8JUbAacaAs2XM+CFw5OPe40d82kpOS6/1MXhLiBKVRLt2I/2WMCZjkOfrIoMHyikN57VNk8JZ46rxarkikJwo8KPlYvE3D3wZbJNv23MlwxfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/IgcxRKMK1BYigvRY6DUgELutRwzRB7d4M2LOgTJRk=;
 b=nAK2FRfIzQ0gSNZcE4ok3bltXhFzZ83k64G8f8zLeg0kYYE07JfNC2HrMHlsUksouXtlM4Z32cupY7TRX8E10BcoBknASQUOhqlSRUHWTwmj4lu3PDQnJjIQ+itpSDfi+j5BErQX3H3Lxf20a7XfqysPwALJ1tIS9+IbJFhKGnQf9st9pcqsjaem64JhdRtMgJjyf2OxhgqU3ZOMy4Ad86S5VSvQj9BBl7PlHh8HWmboF0VlQJZXV4P/Ooq2lj/AALuyuF+/bnOwbJ3y8tXTwf2+cm3hE+zuchGljnmoaYZ9dNoEzSBaPTrIlaTJGHaWe8CAstzWJJZm9qM8RCMvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/IgcxRKMK1BYigvRY6DUgELutRwzRB7d4M2LOgTJRk=;
 b=hqtum3bdmqrLqlsuVXAzHByAewy+BdXiciubgCxzCLUqolZ6vwIlVYjmy//82+BhDWgICGzW8LQFCw/QIzOZ3bEyhbkqggf8elBz5puFVkUwbiN0u2JzF+3LROZaJdH4/lWudqItajlOZNLCDzuh58DgZlM8x3HmOwuh8U1uMuM=
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:15:56 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::63) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 07:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 07:15:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:15:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:15:53 -0500
Received: from dev-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 23 Aug 2023 02:15:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm: Remove the duplicate dpm status check
Date: Wed, 23 Aug 2023 15:15:36 +0800
Message-ID: <20230823071536.1107514-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CO6PR12MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: 43dc757d-01b1-41dd-0a0d-08dba3a8cb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zS6re+5+e3VuS4OeBk6/5uBiaZKHJx+3Y2uZZC5e+EaWAJIrablT9wcjP3Spvu25M9ctn3tx83j0U20kIv4BIVxSh07kCuD0kGGIYMOb3+qeRI2iQ2AJa9AUSU1i1mSmX1JDM5wuhuU4ZEz/26+Sx5/ePqRtV9y9T5/cTcNV1ySNYWhOp/ldrfH+ad4C1MZBeqIUVSsxOl0A1Of4hT1TLfjcOMG6fYd5sSgcrJIDpYvMq6ryzN1K+cy7CAu7VbMTHOXiJeQ1HDbZavCkneNwyVJs6tzPFi62FP1/+hQB0cXcEh3zbpT0eSZHO5Mnw7ZOxEc9b0l4sax6me2c4YepvWeGzqIVCiZGZfDPwsS3B5Bzjkd3gGwUTwd24m1/5/psM2HW7pLeje2OZgp6vxlitubgNIjvOvWujrNgWcFfvCgXS368rFes+LlOlA3QkMP4xhPHhhAb8cimob5IT+JjtJuKNFb8TIIAzx+hATlMFQNxFvmHicnR2QLoRub5FB2Tg2eQmBR2unYl2z0lOVMnk13NlMVVKKFK6EMHB9eZ1qs9kcErz3U1e/kNezFrC+7x++xrbxv/pyv4petyhMdhIcfWtY0GjNkZTszu1JCNO1FENXSDzaQMEX7qG5EvC4PNIoam6y3QmDuiwXDIFfv9YVNGLLiFoZU8L4um6m9n5DsELMjJzlcZmd4U+jkLu7bBZZXHpp1c/3LDZ1FPWNWPSpefHeFVlnMvdLwsCQk6vXzFpQP90JdeChVBBNohFszqg6bxahn4lqTLS9J4OKLvWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(478600001)(6666004)(1076003)(7696005)(26005)(426003)(336012)(36860700001)(2616005)(70206006)(4744005)(2906002)(70586007)(41300700001)(5660300002)(8936002)(316002)(8676002)(4326008)(6916009)(36756003)(54906003)(86362001)(47076005)(83380400001)(356005)(81166007)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:15:55.9595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dc757d-01b1-41dd-0a0d-08dba3a8cb26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since the smu firmware has fixed the issue that described in the commit "60d61f4ed6ead".
So we only need keep dpm status check in the funciton - smu_v13_0_5_set_soft_freq_limited_range.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index c6e7c2115a26..0dce672ac1b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -1060,7 +1060,7 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	if (sclk_min && sclk_max && smu_v13_0_5_clk_dpm_is_enabled(smu, SMU_SCLK)) {
+	if (sclk_min && sclk_max) {
 		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
 							    SMU_SCLK,
 							    sclk_min,
-- 
2.25.1

