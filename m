Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141E4C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 14:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDF410E17F;
	Tue,  2 Jan 2024 14:08:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BF510E17D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 14:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXZLHKdB1skYf6rijKRlfoKrMae/yc4RwoM1USHlNqGWkIVj7+8vDVj91zTuyVOPNzprF3zW0kpadcXdjyDaz7OwRRcHXtmYerkPJQ83kepcu1LIk5Fx+6XkbFHf8tW/xeeSRPaMOuUVdsHW9ldRKAt1Q09GoEqVZR4uYlbOL7kbtvV5QePNkcNWAQCfDkfiaTi2nls45LCCIKHFd9ELM7h7wqrKXFxDAhos8ANixiPPZZCih9dXAboR2XfMORI2AFBrEhTucqKeqotJrB1dEXBwrkLDdK/uNj79DpZ+CLcwhVGlRsTsizOmOFpsl9E+76WOAx20LZJTJA4/XTQMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB3hPOzi3Saw1PN7vDGteJwvsLr1yX7w/ypo8LwZhDU=;
 b=oCnghP/tB6yf6wHrhDT6SUTSmYIJQ5pZOBEquSDO4AqQJtWo1+BUybAIfEsqKq5MJzYcF4V71NMpu6OllO57ByvaHXEh92/MAk1WXagd5FlnVK4X6ro0ydK2J16TWB5lPbyLMhP0/TtmPu7qbbykina/vCDoQ1/fZvJkKXVrArzuYs42Sq5uBcRuPoca2mQnq+kr8ngNrqJp7lIGzCYNdXiC0HVQgH/noQnCTzMiZ3O8jjWrAiDYBcrTfXHtAKaQHpaTFUOEu4ymWnxnrqR/JQE2cn9B2LTCAWh8dEXgVHxHSKqS7nHO6EStV1KKhjJyZxL72mNGtmlqaGPpbuJOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB3hPOzi3Saw1PN7vDGteJwvsLr1yX7w/ypo8LwZhDU=;
 b=0suGynKM4ZPLy58SsoFUpHSxuvUNuW9BPgzP1HjytD3UlYMkJ9ukg1Aye1Q/uGYHA19fWo7VZho/ruKhW9RR0by4E5hnsdN6wlOF8fjyIGHsuWtAp2oF0jnGqfmwDxB9t29fjRBY64v2NhHx4yFIh1FNUpZgf3D6VeOBad2BJbs=
Received: from MN2PR05CA0040.namprd05.prod.outlook.com (2603:10b6:208:236::9)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:08:12 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::bd) by MN2PR05CA0040.outlook.office365.com
 (2603:10b6:208:236::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Tue, 2 Jan 2024 14:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 14:08:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:08:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:08:10 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Tue, 2 Jan 2024 08:08:08 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Date: Tue, 2 Jan 2024 22:07:36 +0800
Message-ID: <20240102140742.23917-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102140742.23917-1-Hawking.Zhang@amd.com>
References: <20240102140742.23917-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 2370a749-124b-43f2-f418-08dc0b9c41a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+mjQJueQlnaxHxX8zp2+mll4ZX3Al9TWF5Tu0sMKyf7UgyIgLWmp509kYhnOZWQvV23JhjpPsvVUT+tft9G7DHelZ58U2P4fsl7tXtTfl7eeEWKx16NmO6LuNvVo5gVZg8GMl7Sbc81HGsGmSFJO6HU7rLtJ57c2OzRY8UCZ0I4hl51LlcgubZNdNQU2mIFrfLkjN9nQpSHwdS+7nckemijvB+vc1QRp8fga4DLwumffa/4muxIgScrCaUMQ+/Zdh1DPFi/Zlzwabuif7heRQuNm2VXwosf4boLOG2i4V/alkjEu7pMuebPto4NS6AoDQX0Z1OViCA1ae65OR40olImaY4Q4w792eM7z6tcNirmyTEzdTaXAHtsqXhK/hpMgISaKOb6pPGr+4H1n3lO09utRel+ZyJnbpq9gz5VjLAdrSFkmlLvEkMGCok21tlCgClr9xNQm5mV/AO3mhkR17ERvfJkTF4M9ESrXKrd1mcS5qtxAZQOh4EhovkoOgotNwhSBbGQaQVsukyZ0rxdhD7icjL8tJXiclX86bTSwpMGFNyYmpLhhRk05noV9KC8yAP3P+2UEhg8DTrsW1RQxZnpc0k306ooERpwyfh7ttFjPwZTEe0Lw25iAxmbxmSzppLrBq0/STHUONLjViPdq+iaCeBdTzIve6vq4DUzrNX7kYYWXGMI09BJxBP5y3whCG2UHV8TRXTM8xkzvqW1o7apN2eVWGpXNWEAlfM9fe1FziWNarumSYN4AXNTRUnaTUUDZwOonh3JKVlngvcsYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(36756003)(40480700001)(40460700003)(478600001)(70206006)(7696005)(70586007)(86362001)(426003)(336012)(83380400001)(82740400003)(81166007)(356005)(2616005)(1076003)(26005)(47076005)(2906002)(4326008)(6666004)(6636002)(41300700001)(110136005)(36860700001)(54906003)(316002)(8676002)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:08:12.3301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2370a749-124b-43f2-f418-08dc0b9c41a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check and report boot status if discovery failed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b8fde08aec8e..302b71e9f1e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -27,6 +27,7 @@
 #include "amdgpu_discovery.h"
 #include "soc15_hw_ip.h"
 #include "discovery.h"
+#include "amdgpu_ras.h"
 
 #include "soc15.h"
 #include "gfx_v9_0.h"
@@ -98,6 +99,7 @@
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
 
+#define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmMP0_SMN_C2PMSG_33	0x16061
 #define mmMM_INDEX		0x0
@@ -518,7 +520,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 out:
 	kfree(adev->mman.discovery_bin);
 	adev->mman.discovery_bin = NULL;
-
+	if ((amdgpu_discovery != 2) &&
+	    (RREG32(mmIP_DISCOVERY_VERSION) == 4))
+		amdgpu_ras_query_boot_status(adev, 4);
 	return r;
 }
 
-- 
2.17.1

