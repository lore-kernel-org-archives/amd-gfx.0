Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD471C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 01:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC2D10E51E;
	Thu, 17 Nov 2022 01:24:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03AA910E513
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 01:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK2a+UR0VW1W2PfzqtaVyGggYuzhyhhlNkNwwXmfjq9Bl31jZR71THTqyvTrDQ3vcnYMDhlMeqWBg0RX9NBJHfuKXG9thDb0YZxf+lHi0LReslI/ZJBHJQUl1UeMKvp2o1+T/rGk7Pe1AFGgcG0y7izGkeV2BaLHB2AMXuZFPFiW2PuxdCWv2ijVi09D19QQQi1DNfaOW1RNfCLUBTKn4kryZznvKEgWP0CvKbZCf9Jk0LwnNj5F/9BXVptN+zFaZ7JxrTOKrC5JU8TghIwvj7Pxo2ZUDFUFnBnPN+NdzNuf3JGRGpXXeIQSWc1At1XOeG/8/FKp6WdmXXaGILKjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V14UnLrUVsNSwZcdDulM0M3PUijl/EAXOVmt+wgAJlA=;
 b=ITutcBl6i+6+N5220WiaJn5BwnQNVTpWhkXdpdoDng51Gl0aJ5Ra8m9NyK/Su03dSOgeCYkxsmrUMyyBbUD6wSbD84cbzznSGIhj1Cn9TA3q6lYOebb321j7wqJmBHyGa3UOaQo9hQ3NeHrTDyLKry5mAfr4uod2Qk0xgsyZs5et17pqyE7ufEfHmp7hQnyfBM9TNDXIkPh0ZVDyHwy9onDDb+xqVEbMefL2rakA+GZ9uqPKgJYAb3fAcoLkd9QsE+FLNPdzNsJvHNcmVT/HTkQZui8efaZoWp8cflm2fQG9kXYqsTQZoN2Kao2FZGsqlZsEkZCAgXcqXalznlNblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V14UnLrUVsNSwZcdDulM0M3PUijl/EAXOVmt+wgAJlA=;
 b=E8LrmusVu9SeoSE7IogEkHBR9Kn3t5qggURVFK7w5Z4Z0RWIfWK3J/A/Bdncl0/LQOn5nR0dVXJZ/pjcG/JzaOX7/qWIrQfvJwSP614vewoaW88XKV85tSWd4aAlaEjYMb1NlabqV7cNNI/VRa5aLUmGxnc3qhK0Et+xTBd/QaQ=
Received: from MW4PR03CA0191.namprd03.prod.outlook.com (2603:10b6:303:b8::16)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 01:24:52 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::4f) by MW4PR03CA0191.outlook.office365.com
 (2603:10b6:303:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Thu, 17 Nov 2022 01:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 01:24:52 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 19:24:49 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Add support for RAS table at 0x40000
Date: Wed, 16 Nov 2022 20:24:06 -0500
Message-ID: <20221117012406.33268-5-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117012406.33268-1-luben.tuikov@amd.com>
References: <20221117012406.33268-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 087a7558-577f-4d40-c307-08dac83a8717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HzTNqEl2YqnDRzar/XLRrdQjiqDvCnaxa6Rl2FuK33Ohy7nYETTNypFtRMxtOJ8NtQ7AhJwzcNvKVqN+fKTGAkic/7aeoHj+agtAzKg+dF+AtTC+eVkcKWWjiv1fdUt/HB6QkR2x67VT+rLVg1IkyaAQAnJTeVJrlNkIYtkjewMZcnGLxwT1zLWHbG3mIjF314jwWcb2FUsiMfNY2DoSdIZ2TJGq+tUOlaGigk3F13cuDuLtCOxxjzjnzYKmBFM9V07QF2xInnu2ABGu2kOMsnJiBFISw489ta3LJpgNgdNes2c9Dup/Zr2HlxLsc/5oLkq4sDs8jE/EaQQYRa+yQ3zMVXj8y/SPWOP9Dk/o8nlzGOfWrzOhUCZ7E5Ay03+hsrZNN2pUUqRl9kSeR/dwJTegVa0rPEBY5O8xhrUMZH4xAohwTtgw6F9hju8YPgRW0xwW7gcceP29dmRx6cNjwE1mQJLd0zaEn3eubfVNNVm0FDd0TB/YiLg0kK8cv5MXWSXH2/+nWVGs3kk8EfG4dtx8GjCS1p0ijMeCEWrizhBMr/XkMDHxVp4oCmRZYElFKSztVzqNhkrAp1fDQDGrXc/EuQE/UoQ6jEogX8RSff81ggXIxgEwPriYEJztYqX++claK8SDaFJPlleVAkSjVmBYMZXMKfJALZHZY/bv4xDVeOqPTisgVW916dIlH2smGpyPgsj78AoJFUgx75Xm2QxwgqLpSJ3X74zZ1Q8pN/GUvevepnZdI13t+Q1znF808HnCwT0MvcH+gzACauWwcsEfmBoYCxE7IwVenWu2NI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(4326008)(70586007)(86362001)(70206006)(8676002)(5660300002)(44832011)(41300700001)(8936002)(26005)(36860700001)(82740400003)(186003)(16526019)(36756003)(478600001)(1076003)(82310400005)(356005)(7696005)(81166007)(2616005)(54906003)(426003)(6666004)(47076005)(316002)(40480700001)(336012)(6916009)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:24:52.4767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087a7558-577f-4d40-c307-08dac83a8717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for RAS table at I2C EEPROM address of 0x40000, since on some
ASICs it is not at 0, but at 0x40000.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Tested-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f63bd31e199c8e..2d9f3f4cd79e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -157,6 +157,7 @@ static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
 static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 				  struct amdgpu_ras_eeprom_control *control)
 {
+	struct atom_context *atom_ctx = adev->mode_info.atom_context;
 	u8 i2c_addr;
 
 	if (!control)
@@ -190,7 +191,11 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		break;
 
 	case CHIP_ALDEBARAN:
-		control->i2c_address = EEPROM_I2C_MADDR_0;
+		if (strnstr(atom_ctx->vbios_version, "D673",
+			    sizeof(atom_ctx->vbios_version)))
+			control->i2c_address = EEPROM_I2C_MADDR_4;
+		else
+			control->i2c_address = EEPROM_I2C_MADDR_0;
 		break;
 
 	case CHIP_IP_DISCOVERY:
-- 
2.38.1

