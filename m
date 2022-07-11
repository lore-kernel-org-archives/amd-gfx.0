Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D52CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 13:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCA110F1C3;
	Mon, 11 Jul 2022 13:58:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB34F10F1C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 13:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cupelKCcxhxZ+QxwPWxA2xRSS/tN4JDFZQ3zTLPDjin/BceS717O0nW60YPrjTe9zrAOTpGZZbm/0L5BkjpiNIhrHFTqBOm4ZGkh/BkPmjritkoona5zEIj7AsRF1rIr1cID15VxKP5njJtGo1mmWEYxRpPmhOt8gBPy7qTLNHsi2moSzNu9cDWsQHLMd2Am/YOMeW685tG2mlgfb2s3LyffK14tZzDAaCEGQJBv5bbR9fwrx7TybYOiqxyPR1JVqS4K2Kna4ahT3IhVUE61OLT3D7yMgWMYgYH4iQ3mo+Dp9a44QqOBNE+ceK5TD/nM2qwUJpe8q+X/rvu23uO1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO8HCOufMhohMmcMT1O+JH2uckH/pTNXuZypPdiHHJc=;
 b=NRvlwIsgjyJRteFjnJt1+tzU5svUFoioPaLeNnpDBdZ0gA7NdqLaT3Iyke9HYIMrkxSZnYSZ1BxK57E8Xj1m+uRL/LrfgmEisWbBymkz68x/c7NkRrliE2OCItbXm0STk5f1JCUqbOoOVHJtXl5TJC2GFRStYOcXRgbpnnYiQyAh9N1scdihVMPd7w03qH4mhEzZTXE/tpN2cfpmQVjfJx7jaLLWgzS/cqZK5arSHNssSZ6joSPoXKhggGm0858htnoT1h5WHltqb8s2GhPw2IiLQXRjx2uJ2/Gq7ve/Gu9blLssz5MEz4hbfO4zWb0qStuIXskoh92OjmIAoWSmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO8HCOufMhohMmcMT1O+JH2uckH/pTNXuZypPdiHHJc=;
 b=pe0siXNda/xQdejYjfVqo6uoZs3Gooh25Q66L192aTNULLFTJ5WUWX/TtQtrJEjTqDm/OTHzXvjyBQ5u5BIfqw4u784qk7WteigRMtyARpDy+41ouNBy4+eQh8JWp7kmWBRw9lQihG9rZ6Uvlz/ww8kjR0IH4sq9o9/oC8CJNeE=
Received: from BN9P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::6)
 by DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 13:57:59 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::a3) by BN9P221CA0013.outlook.office365.com
 (2603:10b6:408:10a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Mon, 11 Jul 2022 13:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 13:57:59 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 11 Jul 2022 08:57:57 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
Date: Mon, 11 Jul 2022 21:57:42 +0800
Message-ID: <20220711135742.11739-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33ee29e5-297f-4c6d-7cf8-08da63455d56
X-MS-TrafficTypeDiagnostic: DM5PR12MB1131:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWXrvq4hJloJqaE1Y2tR8SR9dANOWm9gdkSTk83MR1hgVYKqpw+jFOstyW6QKKqGmSCAYVTMgziJIQlPkwjrQm41JPtCSldRVTu4++9lBuRZRFE6N56bRO2r/7yUJxMXzihA7VnznBVB6vGa+nW9FTWcQwrIrSPxxy80IEs5o8KxRRov+m2FIq8/ajI0baxaakhjbVH5oCigh8Am9T/se9QXJsPpSzUQbmbX7CY5+eOkhMxilgkwEfI4rx4rtaMtzQ/I9JW/rpJo2gOJ2BjK5xZZ1uBIgk/65uUfgCjFbOGIpBHV8XC2Y9kycUi33lG28dwzgorjWisIHe+T4fZkhcJALJentHDURqqAhhUe0wiD+b/ViPk5G33BSPdtkN9eyk1lfwtSCMmaM56jAXOjd+KZaa5CH2hB/N4OZ58nx5WGFybELQmZd5bwnvtrWpDUe5fPED6Y3QZKW8aQRaW2zL7k2fcaez3suepg9W+9yGQAHy/XkgJupon6PBcECWwhkuzU+rXYpErCVAU1ENlSZd97VbQ9538Z+eqT9lpFyeMyi04/bY6p0aLZjt3OgVjQjFU3w0j6VMgCwUzcMgdc6Qg/m5ikUm08hhRHrnI/CFtZsoYCR+daM/xT9E0rMASzlbZ38BXPDjx59qXRcmvhCZyHkR4KvwMMOXQ00GjjtCdV9XceLAKxiWkaTBFK3E0b84wwc76t/7/gImZOLUTFFthqFqfko0DqTf2A4NP6k5Z5OpPP3h450bp+K0vE2t1Le3Uf/sUk8Q6MP8GcNSAad87W/oDpPzLDQIkxV2IjrVu7jgNcu2U7iTJnbyuS4eg6ouW7YWdfUB0r9qZMHhTxCaA/cti8dQ8vggLGbPpbn4E1dogeHb4gUg+YK0DyvIha+aVNn24AoYp8kIjxl5FK8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(86362001)(4326008)(6666004)(70206006)(82740400003)(26005)(8676002)(110136005)(6636002)(34020700004)(426003)(47076005)(70586007)(41300700001)(7696005)(36860700001)(478600001)(81166007)(8936002)(5660300002)(316002)(2906002)(186003)(44832011)(36756003)(40460700003)(82310400005)(1076003)(356005)(16526019)(2616005)(40480700001)(336012)(4744005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 13:57:59.5407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ee29e5-297f-4c6d-7cf8-08da63455d56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
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

SMU is always alive, so it's fine to skip SMU FW reloading
when runpm resumed from BACO, this can avoid some race issues
when resuming SMU FW.

Suggested-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9411c28d88b..9f17235bab83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2348,6 +2348,12 @@ static int psp_load_smu_fw(struct psp_context *psp)
 			&adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 	struct amdgpu_ras *ras = psp->ras_context.ras;
 
+	/* Skip SMU FW reloading in case of using BACO for runpm,
+	 * as SMU is always alive.
+	 */
+	if (adev->in_runpm && amdgpu_asic_supports_baco(adev))
+		return 0;
+
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-- 
2.17.1

