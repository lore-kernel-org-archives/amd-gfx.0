Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF78C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 23:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB50E11A865;
	Mon,  6 Jun 2022 23:05:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC0C11A821
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 23:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAOSNM4XiDN+baZaLj+lDeQaWnqUW4ksaagSPIbPxOTIe/GQWz55KHA6+PBZWgSLRPyBazvZQouN6R0Cv9inUh5TxpVly+izgXAfGU9Qyeywzr0KyuqDcmVT/PdzSmrI3txzjQr5w/7gVxVPtRR9vMo4z+ZENrY5ZH0Z2CAlImWPZzuAuMkWja8kwIpPM7SIZo+IQ65uhC1DXLC4hSmbQmGa0jmEgjMANL3Yg7S6sXhau0i/7p+GAJy1+CvApNirytnVWmtFJyotrxzlCcO8Ab6UZBvUcDEXcM1x2+ajaV+heGrP92+37knbpgRL7Xr30yOXiN3UUAPPSuVWVjwsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9Nz4KoXntF8NLphOwN4PHz6Wl0uf56ctt3RLeOknow=;
 b=c8CUHNIWnGe6/0ITDzQIAiLoTus3u7HyXWAYIDo4sP1Op2ZPOFVHMPxLv4ouWSWY88Mm+Fi9bP2X7ygt0SUUbDxy1kaWuU44bwKNBDNkGKXa+6cznvPuBb+rmn5Vk12fIHmqLeFEgWX9HV3nC+JFuHgvjpKUeQx0sF3n0+cHarjjlgU+UlWi73EUQ1jJwn3WHSb8aSPBnropRo/nyhoc0CwRtBhWp0LpZlI76HSZxtAvz5ezRfR/ViSaoWtLtR26Wm03ur62l1lcxnX3Z2wJPaoSVSQySvnnS1KFcnZijZNuw9Lkh5lfYKaCZkNsgI22DiWEXyqml8UqM2OwwVG1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9Nz4KoXntF8NLphOwN4PHz6Wl0uf56ctt3RLeOknow=;
 b=bGWA7X8SeJtkVVjSOrNoSvQ0LKZ0L+x3dQnJ+beLHgLTQE5eKgJPozh0GUXLL6CdsGaWYIDgJJfFaDUrOVxTgZXzXBBUY6aJEsB9/Y6RtQ21fTKsoPVIPr25qUo2s/gnvDsXxKPn+HzENhDdaVV1px0yBXPU8oO1NmCr2XwvW6w=
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Mon, 6 Jun 2022 23:05:10 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::f8) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.14 via Frontend
 Transport; Mon, 6 Jun 2022 23:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 23:05:10 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 18:05:04 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add MODE register to wave debug info in gfx11
Date: Mon, 6 Jun 2022 18:04:54 -0500
Message-ID: <20220606230454.697232-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5953b5a4-e006-4f5d-f22c-08da4811018a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1625:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1625B23BFDA6D7DD28C82280F9A29@DM5PR12MB1625.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIt5NOVDWj2uOQpPb+dJIbffXfhWRmk722LDIubE1GESyIVXu67ERgaOSCOnuT4cxTk6stA2meSq4yS3k2cBtVB4wDyB8HLXT99CFGju3xPfoyGDKP/uUMo3mi99gL7+mdzXLHHYPSKQ4tI7IBjgUjWXnC0YLRUSXkFjG6PsC5VOd30t8Q9pAZlMw0J/3fdibv7kKkCehTHEIwSAe8ln5cA/M34Z0b4w49pGIqA3NIa7M7nGyNtrIFK5uXE4uJsuvIFId4ea1h3AfHlm6kh9DTVm0boYa8qsL5Ij3F3yQ+Ffv0AyFU/NJGdAxFT1OgIc/sE5r71r3xrzYuCen620w9TySk99koEdtMg86gz5hc1RCZBs8P5CJdZVx5bm7PpToP4yuVbf66EbMKgHveEaNoe7cpuAhdGonu3qZjOAWR3Qz7hsg44FmQA7Brsh0h/HyICgc8BfJOnwmZfVFI+b0goGC/udNwAs8szZYrYnnrWGQCraO2f1vqHpyPbydXGLTFkq7XSXSj3cVPgB9gfG/VTHKgg5pLdJk9bSt3fgRKaDr6M1yOEBYqCejO5b9N4XlPEy87rcY4wZzXrJs3z7kAvAk8ucdi26fkpQ1qJaDaqi+rRegYseACu8dNxTL+sjK434RvTQeK50vJjBkdhzygDA68RRSDU7tiCns+ohWwRcvgnd2cTaMCuMO3+DN+rkqX2MefldDEOl7z8Fl2CFLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(36756003)(356005)(81166007)(336012)(6916009)(2616005)(70586007)(70206006)(26005)(86362001)(54906003)(5660300002)(4326008)(7696005)(8676002)(316002)(8936002)(186003)(1076003)(426003)(16526019)(82310400005)(36860700001)(47076005)(508600001)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 23:05:10.2779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5953b5a4-e006-4f5d-f22c-08da4811018a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
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
Cc: Tom.StDenis@amd.com, Joseph Greathouse <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All other chips, from gfx6-gfx10, now include the MODE register at the
end of the wave debug state. This appears to have been missed in gfx11,
so this patch adds in MODE to the debug state for gfx11.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ca37289c644f..05359df6c354 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1096,6 +1096,7 @@ static void gfx_v11_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd,
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
 }
 
 static void gfx_v11_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
-- 
2.20.1

