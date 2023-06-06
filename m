Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D401C77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 02:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8658810E0EB;
	Tue,  6 Jun 2023 02:09:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A2F110E0EB
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 02:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLbzoC7AoQpwfOKZiOcq219IjQnjhVrAf9niAV1ci2AlzNoNWLG4vYNvO2+pBgnWxUQa3AeZEfAlsyOCrUj+3reL+Ohj2LFIsPxt2xjC1/pBm4+q/lNo+VyVP59HMH3xjD3s/MumGgXnHA2QzI5XN1WW5srNjFl9z49tFXbW8Gw+NW65o2cNVx139Y7f3SETE3yUDaPtxyswhcBAmtgGoUw2uwsGEJ9jqOUNdMMup4MHc1a9DMrAr8HZ/thKxhhJB+7W9JvjLEQQf7caidxtawZv7bJiccorr/KgLhCjjnxvC7bAs5tBdzPd4iAHFudNhZdNrhiRY6vBIuajPSCRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zAEAszTZddEI0tcJZKe/ZnarEcAcvpqyhIWAQSP3n8=;
 b=UBQqTokvQ8UorarRPhVaqyW6Zot3P0WYju0MLSsVmkChnKx5hqYhKaWedtSjWBxoXyhsFfsvYEFjrZU1ahsZ+SE7sB904AFTWpLtTGv+b9u0N7qXyrfZOV0NCY47FcAC7AMHoSPjBspnznde0ul3pde3jPEYly3y4y1RUf6ne3iN/yJcWD2OsSO2cj78JUYCytImaPYp7WNZLYcg1yTn7rYCQIyARCZMd3ZspoaJcirF9Mk56VEBE7ZkXZazezrtbj7gbX7oi9NYRhcJb78wvZaTQ1EeSj7xGyRHcWRrYET5hF0QOmajP5avK6qtt6oxsaqDZ+qJNnWk7NoDMh9WaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zAEAszTZddEI0tcJZKe/ZnarEcAcvpqyhIWAQSP3n8=;
 b=qsrm+Las4HYA8oezVuhVG8N6nBpKY/zipUtepLIASeY4qafA89DrDt/ZreHai1mXmqb4DAXCM61ibRpQ4uqJf7gupiD4pUbmrxR/FdN8dl5JNYzNdpJvwZjl10WsMrSQNxYL4zRcFHlTG+E+/lW+jKAKoSDWU7pr7/pNiIOPy9o=
Received: from MW4PR03CA0136.namprd03.prod.outlook.com (2603:10b6:303:8c::21)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 02:09:49 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::58) by MW4PR03CA0136.outlook.office365.com
 (2603:10b6:303:8c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 02:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 02:09:48 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 21:09:44 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable virtual display support on APP device
Date: Tue, 6 Jun 2023 10:08:59 +0800
Message-ID: <20230606020859.2094244-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d4965e-f336-4dfa-c4f3-08db66331afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsoZ6zdZMAwAFqpwGwNfv+WKMS1Z9IGa1aA4NCSqVeiLD/wxKJeXDscbUVD/nyRYXjlDquZ7x54Gs8PKiEv3A9DwJpV5ll29Fm54gmZwQHYNzLcebjCTQhDDMs35NejZstG4FS0JhMGxw3shJ4rUKKOEQFdtujVQ5JKBoMGKQTIyYkYlio50/BsuwBiTa4maj2ktnWARDhwa6LjLE4jp3wzjscIIJl/BC9prxUoA8096/f4owHiFgDLpE5PhIP8amFpXmLMKLKPcxX9vh/WjXt+1AFlXA0WtNTq5PlDTYNhGG3DrQCgc2v0NwI+9OZbB79W3PV2JToyXYa8l9BChJTI43PYJIotr6nYG1ujs17rQokJBhzk9qt779IQXK37DldoGVYbT5FFZmVg42BuH/ck0Zu3wgwX5b7oNKeoes16kbaZCjYvDR8ob2GlQHORj20GG1sLyBZHSngQrqLdtW6KId2iRhaiWCjm6mJOrkrMEKiMwjt57L0AraHH/9J+zSs+mqLsMFyYGHMZ588R9f82SDKZb/5bohsQyFHyQp/tXfoAsy6eyLJB3j0Kx3BH7QZRbOAy0z9H9oF7uVinnaPqLmD9Tb2jzoHLDXg8EoC2UkEFJX7T685JQI/MtE74lzvlEbrhYbnY72fT16votsKs9EVQLauxRr3y8r2HoChQc75usKWlbJisrYAd0z7cB6FhwrD5JhGuOR/3EaN49r6sXoN9uIuhiy8eK4oapg0g76/A315fLVZvSGIofDbdAPBLvziFG+fHECiWDEgbSlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(336012)(426003)(40480700001)(82740400003)(478600001)(8936002)(40460700003)(8676002)(41300700001)(316002)(81166007)(356005)(70586007)(70206006)(6916009)(5660300002)(4326008)(86362001)(54906003)(6666004)(36756003)(4744005)(2906002)(7696005)(36860700001)(82310400005)(26005)(16526019)(186003)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 02:09:48.3789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d4965e-f336-4dfa-c4f3-08db66331afc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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
Cc: Gavin Wan <gavin.wan@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

virtual display is not support on APP device.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Gavin Wan <gavin.wan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 2c1fbed24535..0f1ca0136f50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -56,7 +56,8 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 
 	/* enable virtual display */
 	if (adev->asic_type != CHIP_ALDEBARAN &&
-	    adev->asic_type != CHIP_ARCTURUS) {
+	    adev->asic_type != CHIP_ARCTURUS &&
+	    ((adev->pdev->class >> 8) != AMD_ACCELERATOR_PROCESSING)) {
 		if (adev->mode_info.num_crtc == 0)
 			adev->mode_info.num_crtc = 1;
 		adev->enable_virtual_display = true;
-- 
2.34.1

