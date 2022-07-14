Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6343EC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 08:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F7CA3815;
	Thu, 14 Jul 2022 08:42:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD93A3814
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 08:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqgyMHG/NdxOBsawFZnJ6WaHUh5EbsyCDuDAxFlvq6EN99LKNPTwlKxf0YNRpkdjlZp6fDzVOwGMZ7ZAtdBI6spSunpQ87zoWCZ4y0fYL8IT+jC30BpNFVugTflDVg+x9mfug9S+S2C9HJRL59yK7dC8vg8yrpTk94aJOodKNkT8Yz6RuaU9qbhYdtRBcVX5CK0vIT/c2aMLf4re4AVk8V7Gq5qBrLFgZT+9AG0pRaGnKwncjbs+o1JzYtnmEijqHWL2yJmlPHxYk/EQY+yzjN1Ga02LCNjiZii0keq2SBd0HA9Gof89LITvruCI3MPMCK9bhEmZ1vabAjbwo1c6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuLz3B7XAvZIq+gWHY6sCBwAb7GAv2TmtkNeT0dkNtQ=;
 b=NY2L7q8pjvrFMWhUIMJSzuIyCDOOsx4wlpb9YBMP6NoOPsJfBP0O0fSQU6NEN57kmU8p5Nk5AldPxZMOoZ/gF+p4uLO5WZQIFVbbWRwrPO42azFUScMfkmLeQ9D4nfGpGjQVRizKJJgcP3t5p++5bAH1DzKEqVJCVcv8LY6kHUnLKbF69sPFK3c4QLLON026bUoRrcdSf+b8oKLj4N/agYy4FwGtnWcJsYTMOyk6p+5mj0MQM9VHYRLw3/TvTjkxNGlgG3A3tj32EjuJppKc550z9VM0yICI0rJuzy3GIe/XZCtyKQ+glm7eDbfRRuYyFE/nJY8GGenJWm51nmO/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuLz3B7XAvZIq+gWHY6sCBwAb7GAv2TmtkNeT0dkNtQ=;
 b=TwB2p2i3FbWT934EkIe5vaGNDftZhgJv9hBRVSgkmMhK/+aUEPIiqXYXZdlG80xA8xfpMefqhsysFNh/2FqdL/UJ09IOMuxo1sUGmYK0ORmA2ky8E9+m768z2Fwgt+kndnBZVS65ZYpn+2XiNYe9nuP2u3I59uLmt0m9GUL2mrc=
Received: from BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::34)
 by BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 08:42:32 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::9a) by BN9P220CA0029.outlook.office365.com
 (2603:10b6:408:13e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Thu, 14 Jul 2022 08:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 08:42:32 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 03:42:29 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: skip SMU FW reloading in runpm BACO case
Date: Thu, 14 Jul 2022 16:42:16 +0800
Message-ID: <20220714084216.2806-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb2539e8-2873-442a-6e72-08da6574caf7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6MB4OzbMziD+FNekFpxULfaqBbALLFSzvL3D37CxK/iLsqh0iS52XKT9fdjrsf19QnTyFVh2V0P86SAzV/SLhANFDVGP9bDgZAGk49UFPbZ7evBn7YylxK14MDQWKA91w7uY9MVlORJhJQUK5QPaGs200n7Q4uR48IUzaLEdRyCapucz2/4HWRzRuo7gU+U4HFMFp3haOlVO7dQ+IUoxiMBnllXaaXBWEhK77MEx5WrCSV3vPP7vklDzPrNLbEN0Z/c1ZxSE1W1lpYHXDh3pVvub80Hl1dGK5/fzevJvWii+T/cs8rBFeMa7byn23ehG5ste9JHhvBySpL8J+GZkLNxnjK2EAiui3zVtmRClgU/FfBI095dE+o53ofnWxES8OINLGB6IVJ91hCqYkbLPuLuomavVGBGuRXDXSnPucwanWTNy8euS7UVIjQRebukaWBMDRibQSdIrtNmPIfgUEcw3qfWbNiBCSbmHyIQCwjtmOc3enS/bI/hii2FGKnUV+Nc8eE1nHMbClLN866Smr4P9fZmGiWWnc5qUk6r56ovIyk6vvXXYUqVwM8vBd/yBINyXmRcQnDXwYdMrgXB/DXtjRZQLvjd8N0+FfJD2y+WBe5ySgMmIQN0n4W1jTjaSebZ5ij1kM9ePKtEAV58XQ7+BWiRoEh1FDZ/z3UTvaRTalxfHsEiMzwuv08oHdHTcVf1TT/uu3vzNz4VNexID9Uw3Ct9SHKnKe1qMPXqC1yVMrWdprxi04iXnmC0/U/hkSZ4MLMVM4guYp173NMiY8eB/dIK6yqTIbaTOKWOgaMhcG7j6b6uSU4aOEq5t3iTzHQQprdlXf4jRWoz7YxbRK4KIi+z9VYkMj6f4ZuaOoxhfYI8IA02nnddYK/Bqo1y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(40470700004)(36840700001)(46966006)(316002)(81166007)(6636002)(110136005)(2616005)(16526019)(356005)(1076003)(82310400005)(70586007)(70206006)(4326008)(8676002)(36756003)(86362001)(36860700001)(82740400003)(26005)(40480700001)(5660300002)(2906002)(478600001)(41300700001)(186003)(44832011)(8936002)(4744005)(426003)(40460700003)(6666004)(7696005)(336012)(47076005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 08:42:32.1390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2539e8-2873-442a-6e72-08da6574caf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1124
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
when resuming SMU.

Suggested-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9411c28d88b..6540582ecbf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2348,6 +2348,13 @@ static int psp_load_smu_fw(struct psp_context *psp)
 			&adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 	struct amdgpu_ras *ras = psp->ras_context.ras;
 
+	/*
+	 * Skip SMU FW reloading in case of using BACO for runpm only,
+	 * as SMU is always alive.
+	 */
+	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
+		return 0;
+
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-- 
2.17.1

