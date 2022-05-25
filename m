Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BDAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 02:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2DF10E1E1;
	Wed, 25 May 2022 02:09:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB4C810E1A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 02:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDFHt6wVu4QFgGqvXUdDi/eIFpfyJmSK+A6IodhL/RNfjUk+KUxDKQXnAJYPh2O9Rgks3RCs+NwI7/jEalSqjMEIN4M1MaHYtXGQx8xR6RXOO/N8TSo2wC24sFUmzXYGFuG/A5x0rAcMJnnV+wLlnweK+7tobXeKtC73Z5ARXZybL3W++K4kfstHq16+bgd7yjnooXLoSVHeR4wiUq/yiLv0XJlZZFvs6dtGk215v4sz64OlfOfLu0pM8RrJUQrFsgBQ4jGrQ3trgTSXz5NoOiIQ9Qvb+QoxNS0u8TrbeSosN+7cSVrs8Js5S1IJOAXIgYqMndQmNBzN7aoeCMay2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsG8+VuZ/bLu9wGzZGrwKooh/OWlxAAru+KnYOrkN6g=;
 b=B95J5sptLNvPWUgctOQZrrp2p/kCnHHbWcTFtkasVJ1uzRNuBggRIbga6/YNq92D0ocLNkbs2QVdpC7YkaN2i/78z200C9tMpmTpDY4DxS8DMq3Q3HadjP5UQDJn6DOfZgTQCMSebNphmJSBYt+pcEekKC7P9F/ZatBxoMWkPJgN1zfZhdEXDZgRlot/uK9whAbMymuXzG+Ew/YcmZnACsAFcM0TKR0MSMeRyC/PB/Kjnq4B9xPk6suc9i3EYk6O9W8CDVtmUxDNm1Ca47TXiJHkBP2FXDwjwT0qn7MzvHo8k/OnrOYRnu7VQDldTfwXCx0v95bwVbuc6zLKdu002w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsG8+VuZ/bLu9wGzZGrwKooh/OWlxAAru+KnYOrkN6g=;
 b=KYyaTssmJDNMBrVlX9XyqYql9bHtju5ZqT3fG+WuuTRQRphHXifB1jwfEFgejUY6jGembQxM9Y8vrxIHbE2Yp2V9594yCD/zb8Ws/lOPbIpYExZUdQWRn/26YYiCrVKR916fF1/raN8DoFGa1b0we7RN0HyzDB3s39KIrFBnNsQ=
Received: from DM6PR17CA0019.namprd17.prod.outlook.com (2603:10b6:5:1b3::32)
 by SN6PR12MB2768.namprd12.prod.outlook.com (2603:10b6:805:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 02:09:43 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::4) by DM6PR17CA0019.outlook.office365.com
 (2603:10b6:5:1b3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22 via Frontend
 Transport; Wed, 25 May 2022 02:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 02:09:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 21:09:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix up comment in
 amdgpu_device_asic_has_dc_support()
Date: Tue, 24 May 2022 22:09:24 -0400
Message-ID: <20220525020926.1951685-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525020926.1951685-1-alexander.deucher@amd.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 059a72ee-4c02-473c-f57f-08da3df3a26a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2768:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2768AF85F2DC0E558DFB4239F7D69@SN6PR12MB2768.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPf8/qDG5N1RhSggMyg7UoWqZ8vX3ngQ23KPKXaNycKR8W9qxodqm6PgamcRiJcgXvoWtsua0IpfMKfZW4y+KdvJmuEuB7meqZW6M+Yp79h+wN+VULxz97YWh7GK/2tRBwKNjgRfIozRvH9C09pI/1Ko7Tu401Z4OdUZdgO/BRqaCF/Aau9Im+Wd6GHUZi1JZsmBTyqIppbAb6rsNkhreOLVnzAE2doJcysxl5j18JHFLC/pu0EUE6r/1b8c9XJM3uyrsXTZ76XMMWkdHDpbFzq7+DmvZ1grXewZGvhtbsqLIIT+aO6Ae9BKWPnOnkAa9poNE3FwN6XwFHVSY9op43RF2D+HHO8VroMlxREE2rf22kCTc0m2kHODoXgQYXP3vqpKwfE34WTPMUUmtnFtC0w3yl1U9O5imPQ+kcSqF8XJK5KsPARYbPmFz68GqvefJoRole77zvUghLczlfNbEoGq2KwkUSMTM78S5XwytSemnBfljajYA70PcYDGDFp32Hu+0GvjE9zcaPVQwrjW6vXTdiXFh+D1n0iGiVYbZWLYcNij4vXmGOaPrKcu9Ra35X2U++Bc6lCn1EfSDx9WUXAPyWnDWkfaJS5WC9qmQEEpAvPYSIVeVDy+FaUVjBXrRuHCYz6ASJ1h0z1WccB3hEazmSroAB9MSLx9HccWpxhdQubKvzDTMkKtZz77z5ij+MqKTug4ouDRoo3/P/ixZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(6916009)(70206006)(86362001)(70586007)(8936002)(316002)(2616005)(36756003)(4326008)(8676002)(6666004)(7696005)(26005)(81166007)(508600001)(356005)(426003)(336012)(83380400001)(82310400005)(5660300002)(4744005)(36860700001)(40460700003)(2906002)(186003)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 02:09:43.6518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059a72ee-4c02-473c-f57f-08da3df3a26a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LVDS support was implemented in DC a while ago.  Just DAC
support is left to do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dab0c59bfb1b..fa26e462e750 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3286,7 +3286,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	case CHIP_MULLINS:
 		/*
 		 * We have systems in the wild with these ASICs that require
-		 * LVDS and VGA support which is not supported with DC.
+		 * VGA support which is not supported with DC.
 		 *
 		 * Fallback to the non-DC driver here by default so as not to
 		 * cause regressions.
-- 
2.35.3

