Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B17FD2D79
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 13:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9CC10E6C2;
	Tue, 10 Mar 2026 13:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2e73coCZ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C67710E6C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 13:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRqXF7fM9iMFc/ANSnzrQVf7VD97tViTgvfliQCT/FzpVNVwN3ujUYRSCZ5zyICHOYC8RZPdVPDodlZXa/SmSYIC2Hi9xeenSDWKLbaTh97RX06EkUqwKLntjYfN/2KXZxjRl0wwQI8rPm1LWNK0NgGoy6VuJS3MzgLblRD5vW+jAJqatjQAEvEXr4Cx9FkxI1i8tKRtjFe1Q7ZEfwOnm6v88Khww5ZSWu3mr52T7WM/nOuLSCfxCkbSFuqkHTaHxG62nL3EksWJZelJzYuqGCJA1uDDxszE9GFtgcNu1Mg/DC3jvuFuBt5QFItYjHl0M/Fy49oy10YlPpu7xWaAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ52Sg07+v8hgx2wYfePHLa1XPDuULnSET10H9c6EUs=;
 b=ERClez04IKkEJFkPnX+47rD9cEkeRV4sUGzUseGllb+cuxa1MXGz5fpQFZz5stM/vIAmELgzFuUz1jmnfp6LdDzu3GT9nGHVDNmQpK3fjce1yflbAa8xoArKGqfQqUebwn4rru6fzlAYv47oraMJppnUU4a7rHHtJjB8jtIhCwV5CsiTVnG7iZpmWsLhik+f4gCloqGJoC+/Ur202O5z3kmx+aSOvgU6v0g/gBPW28vmyQVUddzydh0cjH2/LWWon+bRhVFO7lTeAx3REnMO7rpNGhHWmNJnU8IKZ5hDLMhrQ8NAbxtX1guyyW5TH+str1IzFgxAkAKQSwOYUnyI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ52Sg07+v8hgx2wYfePHLa1XPDuULnSET10H9c6EUs=;
 b=2e73coCZd623VE0CT3Miaa43KJlnaSqBhUid1rptCYMnBTFr90KFOCuqeHu89bcklZAjBXxsA390Ixjz8y+kCya2C8/QcvpKHEyUPeRXXZQinHE9ZwwurGnklc9wOc48v/kMjgl9FgQvhlFYmhlfJNguYHdxbvr5QkHvkgIvL0Q=
Received: from CH2PR07CA0031.namprd07.prod.outlook.com (2603:10b6:610:20::44)
 by BN3PR12MB9594.namprd12.prod.outlook.com (2603:10b6:408:2cb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 13:23:44 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::ca) by CH2PR07CA0031.outlook.office365.com
 (2603:10b6:610:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend
 Transport; Tue, 10 Mar 2026 13:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 13:23:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 08:23:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 08:23:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 08:23:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Add fru eeprom info support
Date: Tue, 10 Mar 2026 09:23:29 -0400
Message-ID: <20260310132331.2867603-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|BN3PR12MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a84a68-513a-44fb-5693-08de7ea840d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026; 
X-Microsoft-Antispam-Message-Info: vJoYNO/aSoI015c747bEely0E6ZkA3uxJsI9BcBMM+koyZxMM3MrYEanG+8ZQQnerlmFoWms9ZIQBDOmMP52REOv/kzNZqMaKvfp6Im3fZngHoq3plSi/LiMzdlrURsNkYoaNVI5pkvWMpEVYKZ3clGkDt3lm3vLzoSu1zFySLYYdPmi+HGZuLWUbauPrujAF7hxg3uN8yHGMrn+123dQzATf+HUdV3y8AENt8Mich6ggdlQwVQT1NBU0DEAs2tXigUQUJVVL1OJw71oYeW1hIj6D7ow2had+ZGwyjE3kIT6Ihjl3vnP05W8xY2PuyZz5XO7aRCakDxhYwL4eg+niVcQ0Ex3dsrkuwN7SxAlbkviidoyzvGx7uQyqReTrjFa2WyRZ/yncbGN/3TXUHcmAyaM4cs629yWm+OXFufj2nzFnzJTJVIIb9J6m/euDhYTEnf5yZT5PV89WRTkUOAR6UbpNGAO3acMorhRob1f1SSC6TNgccnFZ7X7V6HT0kVmPu/AsBBd90LZtVkkjBhZGcbnQxMa80xvMIMPSRnXpdqoF6K40tAv2Kf6moI9FJG0fCNXDcAXIZv8qeDTcwdSoRzJFzG56nIaj+kiQCewFaxxNjthv/mXsJRUYV6MWnN91/xvWyc40tjggxgpYXtzW1ZjwkDZmLev7txBBA5bQLIt43Al9Fkth1C4sKXD1AdX1pPpVitcx1rtw6FCHPUv3MYuhjsVykgkLPaB+GkYcjTdm86AZV59Rm4C9O8UbVQltqE++NaAcz7h0+924skAHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fAt0PdApoiZE/CPNa+xhI1zapgK0g3MDfWETF/crKbnLOI9bxu4UCOGhf1ejHzBsRpHFZpQ3HPnXAQiNJaKKSKFb1F9yWVYwRWWeOlMSOOrliu/6y6NFT1X3MEhG+BHQyaCzPylUaCrTQ3KBeqIT64QMsozeZEOJUBP7LY+Q1LRXRM0H56ZRwX8P76HaLi2KzO8xyiC32IjDKSOo9K/wOuqni1X0Ma61BFp8MD/6RiEbNGYttn1JwyNf8RbHnu0urP/H6evGj+fRSUq1nhwercVCjF3Q6EkrGPUiEtgxyzRYtzsHpA988BdzcAg0CDjSKkfD1rd+60CjYQFUzU9NzfYS462VmIcHJ3TqNOk5A/1H9ywk5DF7uxsGw4DRklBjp+KzytR66/m7z62XpSCApQJJx5cWACRtPM1yFxwmJUyL//LUDEDz5hek/a3Am+sQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:23:43.9870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a84a68-513a-44fb-5693-08de7ea840d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9594
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Asad Kamal <asad.kamal@amd.com>

Add fru eeprom info support for smu_v15_0_8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index b0082aa7f3c61..c5178e2b794d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -106,6 +106,7 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 				*fru_addr = FRU_EEPROM_MADDR_8;
 			return true;
 	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(15, 0, 8):
 			if (fru_addr)
 				*fru_addr = FRU_EEPROM_MADDR_INV;
 			return true;
-- 
2.53.0

