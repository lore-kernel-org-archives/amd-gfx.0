Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E01C47074
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jan 2024 15:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C360A10E0D3;
	Sun,  7 Jan 2024 15:41:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C5410E0D3
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Jan 2024 15:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xsr+SglZIggimoEXHGVksCFPquGzEUABkCTHtgT2aDTQlKOmqiMtWRKXyCVMjXODgXbUpgjKkBHeVPc28cFYA7a36MDW2IJ3FCVCCRenYqdheX6K5P7uctd8hWhS7wJbAciByQm0h8boxgEUgmh7CyBEWCeaupn8WpbNk/EpAUPQKNjnHWzEOqSvSiEAyleFm/3dy+LbXBKZiIUU70iEbNgfxWOTVWB68gfiEiDTuVQYtPUPBnp/gTq0UxezYTjpdXRIUEKdjOx9ML5C9UyjKfbLdd6aKT0JzSj0S+fh1yYCBQtDUwTYMOZ40rMJrCXNMxDhtxq5bKEa/8pwJccd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB3hPOzi3Saw1PN7vDGteJwvsLr1yX7w/ypo8LwZhDU=;
 b=VBIPQP5Cg7zv2pKqCAEMGIsJbDG+8y29sTHUHSyuQGwJTPjUHRM5LRQiDm7VuSweANkO1jDro78dpX4psuY44fKylDeI0sVBX6wm/zSW/GG9AovITWXhK52WEMg+IYqxZ0Ge58h7fvXkDY5C2Jpl+YLDH+90J+Z8/SpsrlnJB/IDc3BD1qVPHV6Tf9b6RMSFKFECOIAmqfaN/KldpwDpxZemmGtIzIrYHw4RDWqBn7qiYB5rrljXo1KwWS4RISl7EmNMq8VhrSRbzVWgp+cJ4kNAGGIzwUeVRZpJLgz9+eb+r1hilg5+3IxGwmAEFbnkc2sKpUcTt1WUcikqJ1qW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB3hPOzi3Saw1PN7vDGteJwvsLr1yX7w/ypo8LwZhDU=;
 b=x3/7n1k63NyF4U7ahedifGs3POzHPonzsIMDthmmrS5oGIr2E4C5afeFL2as2aeDrgPoBiGaQ7ZGxTDKRgfvOTwHFzqJLwNBnDUHUEqaus5krVAMSvOrYhABYRYtHyK2oV7gBimoZEsJ7A2vKV8y8EYWhQOhekZzJy3BR6JDJis=
Received: from CY5PR15CA0007.namprd15.prod.outlook.com (2603:10b6:930:14::13)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 15:41:06 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::26) by CY5PR15CA0007.outlook.office365.com
 (2603:10b6:930:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Sun, 7 Jan 2024 15:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sun, 7 Jan 2024 15:41:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 7 Jan
 2024 09:41:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 7 Jan
 2024 09:41:04 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Sun, 7 Jan 2024 09:41:02 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH v2 v2 4/5] drm/amdgpu: Query boot status if discovery failed
Date: Sun, 7 Jan 2024 23:40:10 +0800
Message-ID: <20240107154011.12927-9-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240107154011.12927-1-Hawking.Zhang@amd.com>
References: <20240107154011.12927-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 720f2b31-c716-4ab1-de2f-08dc0f971007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFV0jadkBR0Wi7vkJDqj/jTrcprGX18rTfPUKkPSlskdBNr+1RVnB/E0VkfH64XwxIkV2hVZsebPxw6p1ZzVANPztgfjPI6J96davrnEjcmBc5onYRFPZEj0UanTUs8eligH+0pwMj2lz7a17c+YhPfMLU8cRrmZR8WFK2gm3djpeu2C6HeGgumNCKvUnjzJvybwCPN1hlElJ/f1OVAPO67ZtWrKEcwyYcECwyjYZeDDLTX3c2lNhnwuOxcl2HGQcrFX3WVNVv/0b+JkXHR4DvHzlVTPFpHJ7WLRGI/4IU/4f/ZeLDLksFdMnXnVY/sYR4E5c5g8MgtYe4VUttFYSDGuzHvgsAGdanPpsabo9MtFqyTMTzBDdlOofL4h9w0lHuZ7ero42+XKyYFKR/WXiACsYDmA9cj9mP1xJku6u7+xa5+K6rAnPpKnMdgAYkt24L2gl5mrP9KF42jDoH4QGrmLb98foQ+ezTe0vBybH7jgcrPsLCj1Z2De2TAnJ1bxTFt1QikuxSYlohThtecSga8koCIByzWEE7M/LU7tweOVkdWKJ/ddcnkrBaVNkyyTN2qXbDqWQGhh4zMknqkjnPJuC/n7iuqFz0rV4aL6qB6aKU5JuhbrylDVuGkU0yXA6Pe8w/0VkwdrgIKO/hGtYSbAcDBfdH6hQOJKBus8tIe+RPeymu0EIUR3h6XlobS8eXBqcMMK9rZAV9hh/La0ejYwmf5KN3lB8I/AWmkDXrxDO6/qIt2Id5+PmYYJa4+rP4Cqu9GMwj/gdY8IhuMMKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(356005)(36756003)(8676002)(8936002)(110136005)(54906003)(316002)(426003)(336012)(5660300002)(4326008)(83380400001)(478600001)(6636002)(7696005)(6666004)(1076003)(26005)(70586007)(70206006)(2616005)(41300700001)(2906002)(47076005)(36860700001)(40460700003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 15:41:06.2103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 720f2b31-c716-4ab1-de2f-08dc0f971007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
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

