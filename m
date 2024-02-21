Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8F7C48BF6
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 14:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2F010E75F;
	Wed, 21 Feb 2024 14:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="04Cm90qd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D7A710E75F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 14:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I93IS0UaPXK12WXiAEb/4k7e394pWjN/PbSlhujP3VKcBkkNzimyDwZrleoyuZVUIXQErIvbop4JtoeVK9FBapSh71dUGmaEAXIw6CZ/s9fk8TCYeS2S8nekulq0LuADiXQ/I9WxD9rI83+hRUaAvSYePyKDqaCMYo5KyK/Whte3ncYlzoOWLDfwd5HXXGdiwVkoe1yFBg2fQBi0b8tGvg4Rf9+FZYsMLNAUJwaDViL8JsLsojl/q7JmBdbztz80F5325IkuVrMUyYMvOxfTTP/vP879I+o9ipOobpfI/c7vzicZi0ypxqzdY3JUr6xbOBMwwvlxOrd0bgeD1zZGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fZncHjqtrBO7bTsQFDXE4qHsgXDWMHicg+YaKDPL3s=;
 b=KQCeIRg+RZhrXVKTU2IB8O3XD3XKg9AXnn/yELG3chPRO5LCrJKpbbhMRFsgu/6jag72I8A/xf9lFSrLwV8uu7Xj63qzqxf08xOqGDIGhA159xeiEjT1/3jkko5MZJsmKMUGHwXP0K7ypFAlWRXbQnTpSM1xJPH/bEUIP56+8AJJAYkquo/jlrqda86tTWxfNXtG7mP4B7mgSnVO77QCwLN+MpAUpnzjpCeJcGHEEtVCaoUnXvAdLXPn60rZ8PgcRR8TPbVIFvDME4ANJnISmJsCLZ4bq5uHWsSoeWlYLabNdxI2Lc64HEgxTHC5tDaAdbcmEt+JutD4MQiaYfYJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fZncHjqtrBO7bTsQFDXE4qHsgXDWMHicg+YaKDPL3s=;
 b=04Cm90qd0Kl1Crwt2sBh5eusitb1JPX5jbLlXk+72FYsMV13ZCk3E+wMdXsQnQUbwA/RNs8IXfZSOQT2TDGngtd7LrwGWsERFgTIUGTdM4XhSEF/ybi5v8L4ME50f31N9phsAIMkTW43PzSMLQUOnPuUv1nS6eS9q0aWoWsbWDo=
Received: from PR0P264CA0175.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::19)
 by BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 14:27:25 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10a6:100:1c:cafe::5d) by PR0P264CA0175.outlook.office365.com
 (2603:10a6:100:1c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Wed, 21 Feb 2024 14:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 14:27:24 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 08:27:22 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix ineffective ras_mask settings
Date: Wed, 21 Feb 2024 22:27:07 +0800
Message-ID: <20240221142707.1989184-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|BN9PR12MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: 7930ebcc-fbc0-4f2a-d867-08dc32e938cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wnaz7nJ7/JS5+5wdj8QIzxkE7PzMW3BzfMDIR0nt9T37TIuOCQIY+WgtyOKaS9UwfsAZZZD+nGn3m9N+Jk8G71EyyqcoywhyAxVYrjA3wpJLiuyj6y++0/2y+Y2OYnmGwGRklCY2JWUkQV4rm4HdUsGueuM1DGLiy+K8VIfL00uvL+E8PVDgWQB680it7rofxOlV4/YeAQTaxXrK8V8n35zhHXBmcng2JzmNYoF2X2xVzubHlKC1aAglzX6QGaOrNsK67+KLWtkrC2skKRTECWwWrhdVGfl37qL60Th+6aeSqavHV/AVX8NABgC4xmQpuFPJfZsF7Of3qadyElvBGfYPWeKWLbo20kYEB5HXp1yb8osG/Q3Loj17w/QA9LQVuJVmgirwVfAYyvgob1pk03Kqdtq5+kSnJ3hTrcVj0Qd4oTv7UlXFdDo4P5acSRpTCSbmAEUvin7QGDNn9TDIupz20FXRPJHrM3cusQMirfMGg9MiKWKOWHwbFXiv2J+cxTuQG3P+qg4g80wd9L1TnrGblQZbwW4++C9qsYJtGydDH+nphI9vr0JByhGCZgcVFk/TTSakwDV8yVW5Aw6MX9RCFASFzstNSR0WDAprfxm5H67zPIXZkCvKNbbfeuh40XijeSiJlmdSdZQI8btjTxEheX/timK57yNXZRQmqcU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 14:27:24.0860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7930ebcc-fbc0-4f2a-d867-08dc32e938cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
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

Check amdgpu_ras_mask to fix ineffective ras_mask setting
due to special asic without sram ecc enable but with poison
supported.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d991b3467c47..b85014e7f96b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3629,6 +3629,7 @@ int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 	     block == AMDGPU_RAS_BLOCK__SDMA ||
 	     block == AMDGPU_RAS_BLOCK__VCN ||
 	     block == AMDGPU_RAS_BLOCK__JPEG) &&
+		(amdgpu_ras_mask & (1 << block)) &&
 	    amdgpu_ras_is_poison_mode_supported(adev) &&
 	    amdgpu_ras_get_ras_block(adev, block, 0))
 		ret = 1;
-- 
2.25.1

