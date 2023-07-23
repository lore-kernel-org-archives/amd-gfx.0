Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79D5C001DE
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jul 2023 06:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F87310E05B;
	Sun, 23 Jul 2023 06:38:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E666310E058
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jul 2023 06:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx9QGHhoj21d/0XoOBkQpm+sEJOP9LuaEoauGmUEeunc222vMvrS8xGAw6nCiFaQ23Q0btCJOLo2vDZLiGqpAx0yi2TomINvHp33hjqE/WjRVQlJmDQvsix4OgDJtS4FIeGPGVsO6fM9ZFe301L7IdJ0YcNP+0QFeJ8K5+30zGGXF/wRNOW77Qqf3FW9y2mIbADCJ/VBCjY9SVxK4x+pxjngVqvv0kSIAxizKBtrMqp8cb+8eZB6zMXJyjtZcf+7etVqTQKZ1mRYlLCjAHDhDmW0YAZLaDJe3zoh+yAGvXx9Rx8fFwVdzX+6EdqCE/jnNM6J3PSqQ7KFg+Kr+DIo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlCxjmOdIIQ2mdPfaNeZr/a6C1DblYIEPYjmjYAsYLk=;
 b=fYMU1ZWkCVpDTURpekxSwwADJjD6QF92m0PjDOznb4N9h5iFN4TYnaX9XDVmu4AHPR2x87eMLCyMfIbgXIxMy5Zw9HMHlkqD/EI8ilvU2FgNV/pCAKVkX/PsIbz75qLsPNL1P9CAemFWFFx/jvY9Y9NLLNsqiXA8g6ujDrqi9Fn/8Sq3QIrXwyPF5YPfBQZ/1STLU2eVRpAyzYYX1GrzBveJEU+9CN1ypc9Clj0nvVtY1B0xOOXoOYXUh11015eqDEIkypMD8m9xYPQVro1MQRy6+qCRp5sPgdnqOZssBRE8BIBXSKr//QFxPEIOuP0zHCXt4j0vR+DJyBKRGGSEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlCxjmOdIIQ2mdPfaNeZr/a6C1DblYIEPYjmjYAsYLk=;
 b=kzwwfGH+bv8lfvfRsju+aRrI08KafbRGckm2+Z+Y5a3j22wMCaJxDHOvfo5Aw+e77ujY22RASHBRVp+g93ygpLT6tb3KXB5ZXS3erMvuYLxb2WD1p1I6uFfzfH945zRYdbthqPrQop+7ygMc5UF1TCYkR3PIpasEnJbz5jN4IYs=
Received: from BN9PR03CA0180.namprd03.prod.outlook.com (2603:10b6:408:f4::35)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sun, 23 Jul
 2023 06:38:17 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::5) by BN9PR03CA0180.outlook.office365.com
 (2603:10b6:408:f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Sun, 23 Jul 2023 06:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sun, 23 Jul 2023 06:38:16 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 01:38:15 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Remove else after return in
 'is_fru_eeprom_supported'
Date: Sun, 23 Jul 2023 12:07:59 +0530
Message-ID: <20230723063759.2022306-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b0b9de-d563-4bf2-6280-08db8b4765a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nwtk14Sx0MpsZa/s7cHhIjdB+OAKpM3yoaXXsEmmU83b6+0VjpnesHJ2SrF2fz14N+u85pW0uXLEyzStRdqQI+4qaYFMRgnnB3pv571Kus2soF/gs3MUOSb4bVSBm/+6BU7o9a0WVWICYegvENfJkk9hkDoFOLC1TdRp8RddLTie3ul6Cq/s4xxA0Rgy1e1jIGH3sRNZlfKUFpMxz0FQ/6aj24+VTgDqU6nrVhakjgAl/D0Tge4KuUXmzjMR61Eh9/RgViZX7ma79jpPUUPwZ7hqfjCy5nXU+UnlvgmeLfC/T+Dhf3hMiwiYwDqICDPPdx9W2esLuYy7sbrhFiUeZqMHstYUT/HLv06bBhIDARuAZE/6e2i2IVfA3kYD4CFBiDXcy6f4oD7lbKZqOG3sFwyrO2S24Gq1NQs0FyT2v3fNqXETU3sZkAUEdNj7PcYO6X7/Xb3O/kZM+ofaceG5FMHq1MhgCgm3Sr2fSrdjs/L1O8pe8z+gyD4CYTceWCNL07vspQUi8HaAueOT9KoFH2EqogwxJuyRyrAWtRGe/J7FiDGjXRmbF+7A0EU8G64T0fMWz4u3E+AKr4q+M5VzyaIbPIz73J22yI4X6YHaCNBZ7jt+UXhGhq3eC6B/P8FJKrLq7x2byy7Td9w7XFymJO7ACVmYyhtH8kUWj+t7tSxlBMHGFa3D5L0YmmuL6Jv41ea/R6XrqYSRG7iSWJZQljl4bVsL2YLjnXlrjiRU1iWscIaW3jg+2aFRiMbGlIQ+/6g2g1cifR8a0NvvebO8pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40460700003)(81166007)(40480700001)(356005)(36860700001)(36756003)(426003)(2616005)(47076005)(66574015)(83380400001)(16526019)(8676002)(44832011)(5660300002)(8936002)(110136005)(478600001)(54906003)(6636002)(316002)(4326008)(70206006)(70586007)(41300700001)(26005)(186003)(336012)(1076003)(7696005)(6666004)(2906002)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 06:38:16.7283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b0b9de-d563-4bf2-6280-08db8b4765a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expressions under 'else' branch under case 'CHIP_SIENNA_CICHLID' in
function 'is_fru_eeprom_supported' are executed whenever the expression
in 'if' is False. Otherwise, return from case occurs. Therefore, there
is no need in 'else', and it has been removed.

Fixes the following:

WARNING: else is not generally useful after a break or return
+                               return false;
+                       } else {

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index c9f16eab0f3d..8c3ee042556a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -83,11 +83,12 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 			if (strnstr(atom_ctx->vbios_pn, "D603GLXE",
 				    sizeof(atom_ctx->vbios_pn))) {
 				return false;
-			} else {
-				if (fru_addr)
-					*fru_addr = FRU_EEPROM_MADDR_6;
-				return true;
 			}
+
+			if (fru_addr)
+				*fru_addr = FRU_EEPROM_MADDR_6;
+			return true;
+
 		} else {
 			return false;
 		}
-- 
2.25.1

