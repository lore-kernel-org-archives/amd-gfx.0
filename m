Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83308C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 02:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D649F10E10C;
	Tue, 31 Oct 2023 02:50:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A910B10E10C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 02:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSnI8FF1mFRmKiFavnfbhNL84uFP9CrJkTFgb40x1FQt74NxHst6gYbVjXRkbAtKM6uge+KD01Zhw9D9oBQiF8ULBEgHB9uiWhEQHCutnrwKdJL2xr5ltku5gMGMhUCRkZYFubbqYE2brhCdCLj7kM5l0PaXrVfQMbHAfhHrfNpjnFKyhyt7C4LF0ggPdrWnJK16jNt1VdGx/kOqFUJlq6WzdFY/UPBTcb/n8tgyPW76ZO7AdIHKNQ9WSjwZDZjAjeFMyM1KHIFb1Hsz46+mXiQQTViLuRHXVpRPgZ0UpZSPEVZFAyVwPvAer35aNFovJ8BNfkHDUJ/TE1zZPZRCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iefrvL8nCaQV2dPBDy3AsPhDa96sLg0b22ZcOmYvn90=;
 b=k0RsF6RuKoJauTcWOmEoDev2WLwhC7PmNl5tfWADZcUbxCZCZWQiOOgmSQXZcPLcZsbP1uLsmjCETJFRd+6BTdBJW3WVb6hNw/r9gI5b8M1NjoI+Frf2UN/9cjM00ZHvqCdUXsyPHLwlvMRdPK0nfJdu+C4l7r3j0cX9PTR7FqyMn6nDgbHclJ5edfa/DXj+6fhFFlnd7pdwSz99CHFOloydno1fH1K1ppMWi8qlbyJnIHFrUb26tCfBx1pHl4EL45bad/pCXpOiNKeNpzWEIkVf4I6kNhtb31Smm1ODEDGNBVTCJZ1lObBxVn5jBdh6caXK9QmWYdNBbmMLMkMpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iefrvL8nCaQV2dPBDy3AsPhDa96sLg0b22ZcOmYvn90=;
 b=IGEBeCsCcgfhKJisH8rCsZpQt9kmtmlsGqdY68026MIh6BzBKFYYKNSDevfVWo34Kfi+qqTM8bLDO73pAviuVqIvBYMCyVA9p00dVsHs6NJT6F2l+dANJf2mQj8/7AjwE3oK/FoNt6GSq5JcHeGqHUwRWkQyK57eMDNWMIUJd4s=
Received: from CYZPR19CA0021.namprd19.prod.outlook.com (2603:10b6:930:8e::22)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 02:50:35 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::5d) by CYZPR19CA0021.outlook.office365.com
 (2603:10b6:930:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 02:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.22 via Frontend Transport; Tue, 31 Oct 2023 02:50:35 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 21:50:33 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct amdgpu ip block rev info
Date: Tue, 31 Oct 2023 10:50:21 +0800
Message-ID: <20231031025021.2697459-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH7PR12MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 9438e48e-0237-415d-ba97-08dbd9bc27fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2rTIJ+J01DqwBHXBaSb9l+HjvIwFfHN9zSC2+JfErxYJupl58L2RuQdgkEBYX+X/4nt/T9z+jKMZfGRjCzaiYmFVYVV2q2uShxK0CHdt0wVTD4+Eggx189KgclPyp4kToyOEuBHtS5/C9NvXki2KYYnQBrmBbHV7bzmKh25aTdeLmEnFrsxvE7o8j/+UIAC4NAavgRL2d55koKgG0v1/7EN1Aj7GAs8Ek9NKcyVvIZud7OPIoIheVa88TEra7w2ukpP34AlSJrzpLaaWpKMVIZ84w0NSSUDz/6SETsAqpZ9W2e3ZL30wPBMJXVgzYl36RhoMWy3gG3WkiUBBLSrfqOWqT6xoKQvJmAXe7Y+T0bAzcV08rPuAW/GGZbXhB6NJCjpOHnhBVCksmJ4TXP74t9u02+IRLCSuidQJa0fxo8xQyMo94AnxG2j7rOS8nMotWTAQ9/nUElZgankeQEuwH6VvnVHgkkOdx5tITWqZ0ySs4+UqOh7r5qJTJneyoLJKjpPNZ9fVbeZBFERQXgKtvvJ+AUOqSUPmm6V1AccofyM1EdeGjQLpzz3NfNJjarjlxvDN56FPxJN331KLfgdpeX4g2wZ8gnNBfnhLIPCcDn0HcP0yMhOxklL9RAVI8sq/R0zlF9iE5JS0rGD4q2RduPmzISaAvoED3Ii7SEN+9K90Nfyw6mMWA2+mtw65hsUgxO3PHBv3EvhIQCmI7o5bZRfU0d3HLcGQpwefBtsMCabTQGf0GJen5gAJrKPKgY3jtbXP+32ld8auo9S8mlOHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(86362001)(36756003)(82740400003)(40480700001)(2906002)(41300700001)(478600001)(8936002)(8676002)(4326008)(6666004)(7696005)(83380400001)(16526019)(336012)(1076003)(47076005)(26005)(2616005)(40460700003)(426003)(5660300002)(70586007)(316002)(70206006)(6916009)(356005)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 02:50:35.0047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9438e48e-0237-415d-ba97-08dbd9bc27fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178
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
Cc: Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

correct following amdgpu ip block version information:
- gfx_v9_4_3
- sdma_v4_4_2

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b3d4458e3889..1c46d205c0ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4295,7 +4295,7 @@ const struct amdgpu_ip_block_version gfx_v9_4_3_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GFX,
 	.major = 9,
 	.minor = 4,
-	.rev = 0,
+	.rev = 3,
 	.funcs = &gfx_v9_4_3_ip_funcs,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c46bc6aa4f48..c851413ba6b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2048,7 +2048,7 @@ const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_SDMA,
 	.major = 4,
 	.minor = 4,
-	.rev = 0,
+	.rev = 2,
 	.funcs = &sdma_v4_4_2_ip_funcs,
 };
 
-- 
2.34.1

