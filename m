Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A52C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 02:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2950810E1FF;
	Wed, 25 May 2022 02:09:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6E710E21A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 02:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtNO51abDFFFZH+16pAYbpD1czn4fyav3+H6r4Atro930Pp8h8k5ugC9nSc8OT/SzkyYgeI/mfnf8XFuecu3i8y3XhCnv08KyMFX6JRNkCT8VOShwQONsJZ6nBgWUlvvMenB0lgAQ8clx3jwl/bdEpiicxN2vaIIzlgLNk7SLiWzzCOoDzKDzRX3PjiuCm05D8xtIi5cVav43Ak8wJI481zQLHVq08gZGoTo8DzDr499lv7Abota02yGp4bruYD1wJl/jFOlcQLxgjRDr1hnPppY/qvMh6Du9xcusIq7zh+qlHByI4DoNEIvTZZdxjcstUiXC09RAFxpLA77kAKQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTETUW1cFwGtMMmx97gyC8yEOBYt9lANhTaLIGBox3I=;
 b=k8RK3zHnqxou86c4vx3DPvYFDUK9LBEG+CD5XIgngIMJUPwSTXtQM02j5rreyzsRClL8q1a2I0VtnY60Mo51kMsEBB2YV+XfUTsd1cYExOO6iKCueKYZO9gMwDINtlpSJTlIk/SUH+pLcLddhmDUX8GcnEYnzufTWcmoUt9JzfnUraVi23JCXNz5HFGjXCMv55yAOtu2rwFU+Ix22RjqMnFxwoT2rbQyrpu6g22FTtUibBqo7HHhX4c4oSUdLOjPvANcVBaAWo6RPG0x1duG32T/d/utKwbXBpO7Ztwhp8iaUWyjN5uflINHnT0oUbLtwYSi94bXB/fs/tFk947NWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTETUW1cFwGtMMmx97gyC8yEOBYt9lANhTaLIGBox3I=;
 b=Gn48rLHgHPzHXiGWrOIaTJE8S9Qr36Oo0qROLSvoyI1uyezlptIgnJzuj5p7jh/AHIL/inS2ZTKQXUF/mT2SPrLIKOp5i8izkXPI/ZT0lIz0L7rB4YwYzgqJNZvCU0utRWNT2YFGtw/zG47ucSKl3K7SWlJKX/VfyY+icvPvu0E=
Received: from DM6PR17CA0009.namprd17.prod.outlook.com (2603:10b6:5:1b3::22)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Wed, 25 May
 2022 02:09:43 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::ff) by DM6PR17CA0009.outlook.office365.com
 (2603:10b6:5:1b3::22) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 02:09:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 21:09:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: simplify amdgpu_device_asic_has_dc_support()
Date: Tue, 24 May 2022 22:09:23 -0400
Message-ID: <20220525020926.1951685-4-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 361cf47e-ba3c-4555-2482-08da3df3a1f6
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6097:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6097061A451D76D445323205F7D69@SJ1PR12MB6097.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlRIL0rQ+XpC9L28lK1+bn1VkhAi6gxJ0cJ52OC/u0kP2OlyqbCWH472eQodFH1HB4UhoawE79vsc2KSejdHr6EnLjkEHPWgYgrcTy1M7viSfVHS4lDI4PVrwoTbc2U2X4EQ8jpsth7KKsKMjWYIb65xlbQxqFPN98RzHT62yFbVa2CX47DOWIQzNBNujXsE+96FfMOSmV3WdtiHPVDijuhNWDCc9E6STRzhLDk1isi6dYA9KoYHVRAOfUCt/fme5Zg2D/FhNkIvsQeS0AXN4BzNgNqCywCd9JD8bmvR1htg+ub7ViyhZs63Od4DirAtenl9gJynsiB8dvO+LGSMrnjxW9RgION3SL8TJq6lOLRC3znFXyXzrfTUmzaAlNOWtMPGDxvcE/cm4LOBpveGE6hE12srlHZK6Z742Tjh3TDrWNpdjN5QFJuf2COlyseF/zCkNp78XAccvsTu1n7BVCR6b7quqr5Nz92Av0vBRHsRgWC+tROtha0ilr9vWhW/fFivCo4O7Up8khkCDsr17SZdlA4ZMExXaePNV2WI0PVNRDC1net4ce2Q3N6NxjKS8P1TdnH3sb2IDWCXPOTDeXWZ2LCH5clIUnB1jTbzhIBnNv5hS8ekvdLMfFpHak6+1/DSZkhfe5rmGavmmI8K1ybV5PDyYxOv0qjxsD4T+Bh8ozJdIaIdyz2l7XeFx9ktW6SQ586HEYRqueX6tl78Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(8676002)(86362001)(83380400001)(508600001)(70586007)(4326008)(6666004)(47076005)(336012)(40460700003)(426003)(186003)(5660300002)(8936002)(2616005)(26005)(36756003)(1076003)(6916009)(36860700001)(2906002)(81166007)(16526019)(356005)(82310400005)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 02:09:42.9019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361cf47e-ba3c-4555-2482-08da3df3a1f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097
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

Drop extra cases in the default case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ----------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f7d475c46b4..dab0c59bfb1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3292,32 +3292,6 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 		 * cause regressions.
 		 */
 		return amdgpu_dc > 0;
-	case CHIP_HAWAII:
-	case CHIP_CARRIZO:
-	case CHIP_STONEY:
-	case CHIP_POLARIS10:
-	case CHIP_POLARIS11:
-	case CHIP_POLARIS12:
-	case CHIP_VEGAM:
-	case CHIP_TONGA:
-	case CHIP_FIJI:
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	case CHIP_RAVEN:
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_RENOIR:
-	case CHIP_CYAN_SKILLFISH:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
-#endif
 	default:
 		return amdgpu_dc != 0;
 #else
-- 
2.35.3

