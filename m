Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2633DFF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 10:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DF410EF43;
	Wed, 29 Apr 2026 10:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uSEc8r5v";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177E510EF43
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 10:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8+6sscd1OEgd0RgLD17Sb0LYjVB0e6fjwZ7DUKaJRQn1QBNPnqIAdUVSW0Ghh7wJeNeotgv6uDUSNTWgTcilGE/iV9jyYYmYYsywK5Y5e/HT+RvwBL06nmOy2aJ+JkvtxihkiBu8RYBGKITOwmb54RUi7B6j3sy+azLAzXEuEDQXS11XLM812yC4yyn5Rph1FPTcqzkfPkr6G5fSGPjjD8Tv3y5XR6BRgqdEb9sP8WS/jMaO4gFCYNG1hlCbMcXZSiivs3KOwisXV+SZevcdQzbnGkf4u15pMyiNyRyr8G6gUTEvkxqqtaldDAPOx9s0r0+m5OEQEzfuJ+NDWDycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNrqjgVfCSsmz81+52+TxjXD2FuKXgROIzE1RGQQz3A=;
 b=HbMKahWh6ACb+WOSCBjwtB5KuIMkB9a/6Ewe0cbUDOwVNQDSGXqC6PkNLNue+GPiye6XkHQGWrbc1KtXkPl58plKAoswc8NP1tUk1Kl0D8xamXlDB/xjYD+kuoj42qxazMgQQFGMeyJl4dhMlXv9lwrILsr8SZo9DSa7xlDJMYQ7lvnG5hKVgeuhBRI4qt95Krn7fmGf+kDgNK6iIsD7vbqDkdTbWrgMGXscqxECldFV0NQPmbQJglznak4+QuMPWnIk5eaHkF648ySEuNQtiL86OaC8SSSI4nb6c1QqlEbJkxlpT38Z+THQ/FJscjW7mASIhHJojuUZ9OjsU/HAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNrqjgVfCSsmz81+52+TxjXD2FuKXgROIzE1RGQQz3A=;
 b=uSEc8r5vnu7yDXqZUVSLfmjcYGxUrI9x/hLz9K1pR92JunFGkhnIzat9KD+EBzHQM4aV+jeFMUYZyhGo5WhXPMrB/ENeMehcVO1ZS1iO9Fx16WRzVlVRYQ1Mt2CZAViQ8BPL/RXq/rClme1ieB37xdWXqh2GpSVDqEqZYyxS3TI=
Received: from BLAPR05CA0032.namprd05.prod.outlook.com (2603:10b6:208:335::13)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 10:11:20 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::eb) by BLAPR05CA0032.outlook.office365.com
 (2603:10b6:208:335::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.20 via Frontend Transport; Wed,
 29 Apr 2026 10:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 10:11:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 05:11:18 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Prefer ROM BAR for default VGA device
Date: Wed, 29 Apr 2026 15:41:00 +0530
Message-ID: <20260429101100.3893004-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a7677f-7983-4551-814b-08dea5d7a8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: NDxkwWfH9jNO8+n5QKp4il/IoGkoRGDBrb0Z6V6VkkpEJXSrc8FPC7vvCYsxy0JbCSCw1y4QdeklhcXkTyVQxU2iwTbqctBoL8r6wTQYPWacugXkrkpPMOEndvq+pIpDbetNpSerMu4gufqTCutkXFM8Q5y0eUcvcofu3ouIOUt+wN7H1JLKlt6+pjyvao+AtAJiIDDZhtq1odT72OxFORNaijRBPs5P96fMHjDAwl60/YULpFF7PdYl9uDiQ3hXU0ghJm1O2fr9Of04ldxto97OCFZiHTGa5un7vD6/hKYfmg6KTnf/y0nxyUnUvkpY+UNBUPJlJDVgy/O621Pr47LeL4HFATbh+3ggExBBNJeff7A/oMmZh/O1TzsUuEhz89CBlILhdiE8Y5xmNQlrDSA+A7k79ZzD85LZWOvWL+SLKcveE8BxxZ+eJWtgQXAQWsYZsx99jQvPRgJujcc55ZAc0qwZ9agnaNF+bLxUR+EBzCKVHD8g1Ez+xbGTTr1oKaP/W5O1raj3jVPBMFK7FoMXQWbKItW8/iUH+SLGri7tpYLDDVwNypfCSVkMTvg6uvhwWUuNI5Pm1eq0SKpD0CQJo+hj9XIeZZb3OlMsRYOB16y+QcTdnO6YEnHG7emNEPi8Iu/Qc7mV/bpXjKu+4shN+N0eFZFUrATeAQZtmXoT0yubYlOuv2ltPDdlXwP7sfwgLKNpW5+i5g0tg+x0t4vPiFrX+v+DuLU9BeYlEdStVqueZVF3ygOJe8CHP65kewBkXdLJR4uIiWdy3mlcvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GYyM0HyfRMMehW3VAHydnB/x2B8Ry9uzMX5zb1TdLulXmX9Se3qTQtwZJ72teWFtieVoA42G7bAz++GBF2NOdz8tHm1AzsZV7WjHlUv0w58VhgzG4V0u/T43wM/uOflnDII/LWP6pzbCEOGgREAblSVC3tEaqwJZ+kJ4LbgsX/K7EttlrL/QBd7OPsbqh/dxOGr0tQAWVG9uYf12ReYhcx3lZGrIOtsgeI52EK4jKG1+fqOLm9fWXgEgFJBAvG/g1BACaI0qqelrvz8x2I0bh00wTl6tqJCHkpB6J60ykwC3+6GtMmBywBmylOoYtdR1n/d/UYtOWhR+iFtfHyAmhT5fNHEYUn+5ZnSsm0BPt2tbwqf3++axEh2Qh9tEacPYVFONrT2OZmVDa/ny+sf4Xy8Ne8eQWlRIGRpnIJ3Awr/wBN568jNvPTk+0LCl+u3P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 10:11:19.8802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a7677f-7983-4551-814b-08dea5d7a8a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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

Fetching from platform ROM doesn't work with hybrid ROM images. For
default VGA devices also prefer ROM BAR.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 35d04e69aec0..aa039e148a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/vgaarb.h>
 /*
  * BIOS.
  */
@@ -467,7 +468,8 @@ static bool amdgpu_prefer_rom_resource(struct amdgpu_device *adev)
 {
 	struct resource *res = &adev->pdev->resource[PCI_ROM_RESOURCE];
 
-	return (res->flags & IORESOURCE_ROM_SHADOW);
+	return (res->flags & IORESOURCE_ROM_SHADOW) ||
+	       adev->pdev == vga_default_device();
 }
 
 static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
-- 
2.49.0

