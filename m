Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40432C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 19:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99FAD10E1B1;
	Wed, 16 Nov 2022 19:49:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8941C10E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 19:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZLY8ocrI5zneAf4VJ24UGiZiaByXebYuHENlCR78KWJt6UjtRmNlzeCBNvGcl7WhBIqGe1b9xp0FwK27UtcS6vkoRYoUoowVZO9w+M0PYSWCBVAyjJvSBQasecyxe0cxP7FOBGx+qCTEozn3z/vpX2YLwP6kjuVc+lKTfFRvzq30WtbwR1EOsX3h7gLR7hj+U2q/01equMQkAzgbaV8AN2gcHcCC4V40haqqVkTApqKOUX3AXgn2JdKlQu9gsXnjc2W6LJDobojYMDaWLj3PfOUoVaFe7kmPnHmbv2goNVnhKftKH4XVpskXO8XG/rOnraoqW2PZ3IsDuVnZxKOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29GudM9yyUCPhUPhny3YKJPxxhLDgyrqCfE1jcwgFNc=;
 b=Yhm4L4POAMuvORewH8aocgso1aLkulqaJYSgz/xKcnYOiLxHpSzDFCVJm+4L3i3n1LX5Ek8ZZdYW91P1w0JLmZMv1hbY+KkzWr+s14KrEU9OAxYwTGDKBfiDaPKlgxLpTUUmz4rVODbZfT8QBI72EYqCA0n+VRBK5Tb0kflnNYiftCG+w86MV/jXPoAQ2C3cToRBP5EgpbF8YHmBV+DlSpjLRI/oBNQiGMLmuL3pOBGCG0+AJnFpU6S6vMzYYbf1uDTCwYznJKDygtyz54e1N13fk4/fmJ6W6HwepDylY6S0x9WVdOSMHix8lrlXQ+G1qglGj6MwLnwivGQMGl5uIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29GudM9yyUCPhUPhny3YKJPxxhLDgyrqCfE1jcwgFNc=;
 b=dEaPJDgdzaw2pMrydI/prHftC+8gJo6ScE0+vXYEtRBUkb5rRhiv9kf9xwi5PUkQEazUuVmygw8GcCZurJxZEeoaDV9j9zdp8AsQABoQ662ynfB/NUrdHuo4fLpD0OTmVXmbFoyS9YOc7bfKV6W16DW32FYdX/StDju51S4JGus=
Received: from BN1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:408:e2::7)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 19:49:07 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::1f) by BN1PR13CA0002.outlook.office365.com
 (2603:10b6:408:e2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.8 via Frontend
 Transport; Wed, 16 Nov 2022 19:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 19:49:07 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 13:49:06 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Allow non-standard EEPROM I2C address
Date: Wed, 16 Nov 2022 14:48:35 -0500
Message-ID: <20221116194838.15315-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116194838.15315-1-luben.tuikov@amd.com>
References: <20221116194838.15315-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de2620f-cad4-4322-f042-08dac80b9f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpVyFbkOVgFXn5Upy/BeAvDgL7hrc/iRpkxuBiOoXbbbTUDpv/Sn/rZ0pbH/1Rx98KY4CZANGxXV/2TFTrB5TQnJ5tFvUbK08X2gRQEMlvyyS17waHFPECMb2R3r8DYx6OjL5kEwRUJDXGDvXl2nZL/rh4NEJxct6vQUU5IYI3tyDkJf0MJ6Fs2ysCc2TYn22FIlyZVKbijyNj9cnmt91qfpXnsMClNaT6EY6N+O0/c9QnZsyoSYsGA4EoPppRQ/pz8vIKmS5iKv4n2NEZISBrSbLFKtTkgQikTfhQRcibBVwqFCVpDYwyfMcHrAzhLLkb4za9ijYT8eH7C8CrEpchHXd3dNmEuOu9DCWq4/m4cAEpAoNCL3tLEc8eMYEQpkXfI2UtgiL8dXbLtSSJFHhUNa9jc6Vnno9y/o+JEsOQrXKpcF98num60ZujbrLRvKf+THT8vokjFjmEO9/j6EyYw4a3yFi+b5QgvOhtuPC+Au+iNZr2yd4EWRWP6Dx2719r/vepVQ8WB+IXSCiTOWuD6HGm4X8HqRLaUMrSdoeWJb7tEsM67o64dXG0d4njshIsA4An2FlurI6/WE6elBrh6KsAtezwho7JgHl/41wRHnI7/DZlREDADu3two6VBj6dtPqsP5SubZmYprgfFmF2/cmOeJmvpaIzKsW1fFUEKQt87WijXdA6poW600CTxDFgZF5wxbArgMo7bfYlT3gsBBC3ZmmzFmOjTW6EPJ+rCUk72uoFm6t1W/D4y9tYNaAQztxGPrxuqI0s9mcN6Sq5AROOV02SZCw6N6102HwtiZ1pLtU7q2cxBihMBGHHG9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(40480700001)(478600001)(81166007)(83380400001)(40460700003)(82310400005)(86362001)(356005)(36860700001)(44832011)(5660300002)(47076005)(426003)(336012)(2906002)(36756003)(6666004)(8676002)(70586007)(4326008)(7696005)(70206006)(1076003)(16526019)(186003)(316002)(8936002)(26005)(2616005)(54906003)(41300700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:49:07.0462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de2620f-cad4-4322-f042-08dac80b9f67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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

Allow non-standard EEPROM I2C address of 0x58, where the Device Type
Identifier is 1011b, where we form 1011000b = 0x58 I2C address, as on some
ASICs the FRU lives there.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Tested-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index d6c4293829aab1..7d2a908438e924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -87,7 +87,7 @@
  * "eeprom_addr", and set A10 to 0 to write into it, and A10 and A1 to
  * 1 to lock it permanently.
  */
-#define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 7))
+#define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 0xF))
 
 static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 				u8 *eeprom_buf, u16 buf_size, bool read)
-- 
2.38.1

