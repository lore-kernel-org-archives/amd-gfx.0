Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B44AC46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 19:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7784010E125;
	Tue, 10 Jan 2023 19:16:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0762410E644
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 19:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGKnEmA+XLJnWgI+OZ7ZKTWogurYxXGyGbF6s0i/SQYCfmpw6pkoI/RVnJjoKJXzg5mSjX6RPY9JWOTcSMFoMhQMfssTSi2BbzfyvcBaqgm5Ok6gdAtEKEqQFVgLtVwtPlCu10qkZAZv7bCy6y9KGXPa28zdH353+VcUJ5pD799uLqIAu6KTXOEnfDzJp3JgJSo2q9RNcftzTTKLrhSZ15PMh/Jmm80u8WitwRo2SvICSqbNZ9AKrKga3xaY7KFCmizoYG2YViNRIFXM2GT6cl19EjhNhTnZlDdxu2/1TMq1Y9CUOdSUU3JozgQT6SvF1+/ux8wm3luu+4/Xcngv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OUcYSxyXv3b65ZhO4B4UekBHLGimZEVS2qHKlqu5MI=;
 b=ll4jbiCMEPmENRvT/YqQXcjcOLRx6LihU/Ehpm9MjGhRjJr1Bt4sU5kTt9qy4K5ANY72WYZechazTh+poIKGLmZIg3WFQwJkaK8FWJQQ2NN3x/+2S4IxmEZVfpCSib6diiPwI/45EN12jMNQ6UesPdCUH27AVhmSrWQsV6oBqnuQ9vt9Vr8Hl/EkNCNu1DgJq6Tzhk7PEA+tstzftJ+xh3TP37EOLC1j6xMR9VSuW/x+htDZzilM7ArMOhqZer4Kf683LnO7F/hSKY6Tj4EbOFqy09xQmBrrUsvdofHmgV79ueCVWhQ2v7Qkk62c60qcsBdJTeCJGwJiPJfupuSiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OUcYSxyXv3b65ZhO4B4UekBHLGimZEVS2qHKlqu5MI=;
 b=2K0aftG7ZI+nF3Ao6484WKkZpeiUwH+tApoYweaGZqDj+wAJRMELURk70F6zDUiIb0JCBUbCcVA5GFEowlsP2MBI1Wx7408LCXjc7R+BF9Rm4xMbLw2NMGK1r8w8iUL4cHzddIt6YeVhr4mgkFPAfXu3iIJqfXvl61dxtVXlD3g=
Received: from BN8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:ac::28)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 19:15:55 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::24) by BN8PR07CA0015.outlook.office365.com
 (2603:10b6:408:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 19:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 19:15:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 13:15:54 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Only load TA microcode for psp v12_0 once
Date: Tue, 10 Jan 2023 13:15:47 -0600
Message-ID: <20230110191547.5042-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b29c523-293a-4a45-903f-08daf33f189c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syxxwzQkcAuoOoR2QPQBGUgeh5JD1fBa1OnOhyDDjMxG4hfg9fkiy7BBaNXYiwjs4S4veunYVFqRhwGecA4VLuKWs2qS+NPWMBigltTzpmHV+pn90pFlrD0Y9lXJ5k1ZCEjLavV4jgzVxSssxSg/HJitW8k1zyONhXK19woyMOqq5RrBgScnMTPndteJouJzKvjA2qCaFJOX0sXs3VTcBAUrDOyKfIWNMYoNhT7XoR57+9Y0t+PYfCc3vgb+PTzIJ0BEKBBiUNoWrZVgxpwGRkBWsT9ZnL8toXVLIc+MvBOXDIcYJ/b1UMnJloGo4A2WphHPzE4NqcZ+HLWunOLlNwFs7aPGXVli+qxRDtr4iHA7VgR3ocfqibhAXTh+RWt0ABQ24MBo9xP8QOgAFCOHOOHvbkyJVIsVwTivbQEn9AamqzjXOf4XXYMCqZ8MtteXGrc5Bg8LCRwOh8y3wbRw+n4UrPOY21dq2W1GK45XLzANOAbJ85fBwuXuN1xxZqy0CdpE0Oy5VqXY0CrvJ/iJzJv8tfszWD4uiiWpzaa2/eAfupimqEEKJDLuIGE8CNQavpnCmYz6NHwEs1Yn2Tu52DezJJrusKc0Z1ZvmRjSQwcwa06Zm0p3hd6Ng+BLHTS9HTx8GfNBN67BIl0FV5BFNoPPfSfJWFiDgI5WYesgu4PRDBlYoq3tWBqghuLLADiATaO97Yi+cAP7DcS2RgXbW7tTKiAIVojmHzY9vHJlkJM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(6666004)(81166007)(2906002)(356005)(478600001)(2616005)(1076003)(4744005)(16526019)(26005)(7696005)(186003)(44832011)(5660300002)(316002)(40480700001)(83380400001)(8936002)(82310400005)(36756003)(86362001)(40460700003)(47076005)(426003)(41300700001)(8676002)(336012)(70586007)(4326008)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 19:15:54.6655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b29c523-293a-4a45-903f-08daf33f189c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During rebase from patch series accidentally ended up with two calls
to load TA microcode for psp v12_0. Only one is needed, so remove the
second.

Fixes: f1efed401badb ("drm/amd: Parse both v1 and v2 TA microcode headers using same function")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index e82a0c2bf1faa..fcd708eae75cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -55,9 +55,6 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 	amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
 	err = psp_init_asd_microcode(psp, ucode_prefix);
-	if (err)
-		return err;
-	err = psp_init_ta_microcode(psp, ucode_prefix);
 	if (err)
 		return err;
 
-- 
2.25.1

